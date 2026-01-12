#include <direct.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct {
    unsigned short bfType;
    unsigned int bfSize;
    unsigned short bfReserved1;
    unsigned short bfReserved2;
    unsigned int bfOffBits;
} BITMAPFILEHEADER;

typedef struct {
    unsigned int biSize;
    int biWidth;
    int biHeight;
    unsigned short biPlanes;
    unsigned short biBitCount;
    unsigned int biCompression;
    unsigned int biSizeImage;
    int biXPelsPerMeter;
    int biYPelsPerMeter;
    unsigned int biClrUsed;
    unsigned int biClrImportant;
} BITMAPINFOHEADER;

typedef struct {
    int width;
    int height;
    int channel;
    float *data;
} Image;

typedef struct {
    int channel;
    float *data;
} Vector;

typedef struct {
    int in_channel;
    int out_channel;
    int kernel_size;
    int stride;
    int padding;
    float *weight;
    float *bias;
} ConvolutionLayer;

typedef struct {
    int in_channel;
    int out_channel;
    float *weight;
    float *bias;
} FullyConnectedLayer;

typedef struct {
    int kernel_size;
    int stride;
} MaxPooling;

#pragma pack(pop)

void readBMP(const char *filename, float **p_data, int *p_channel, int *p_width,
             int *p_height) {
    FILE *file = fopen(filename, "rb");
    if (!file) {
        printf("Failed to open BMP file.\n");
        return;
    }

    BITMAPFILEHEADER fileHeader;
    BITMAPINFOHEADER infoHeader;

    fread(&fileHeader, sizeof(BITMAPFILEHEADER), 1, file);
    fread(&infoHeader, sizeof(BITMAPINFOHEADER), 1, file);

    if (fileHeader.bfType != 0x4D42) {
        printf("Not a valid BMP file.\n");
        fclose(file);
        return;
    }

    int width = infoHeader.biWidth;
    int height = infoHeader.biHeight;
    int channels = 3;

    *p_width = width;
    *p_height = height;
    *p_channel = channels;

    fseek(file, fileHeader.bfOffBits, SEEK_SET);

    int rowSize = (width * 3 + 3) & ~3;
    unsigned char *imageData = (unsigned char *)malloc(rowSize * height);
    if (!imageData) {
        printf("Memory allocation failed.\n");
        fclose(file);
        return;
    }

    fread(imageData, 1, rowSize * height, file);
    fclose(file);

    *p_data = (float *)malloc(width * height * channels * sizeof(float));
    if (!*p_data) {
        printf("Memory allocation failed for RGB channels.\n");
        free(imageData);
        return;
    }

    int pixelIndex = 0;
    float *pR = *p_data;
    float *pG = *p_data + width * height;
    float *pB = *p_data + width * height * 2;

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            float b = float(imageData[pixelIndex++]) / 255.0f;
            float g = float(imageData[pixelIndex++]) / 255.0f;
            float r = float(imageData[pixelIndex++]) / 255.0f;

            int flipped_y = height - 1 - y;
            pR[flipped_y * width + x] = (r - 0.5f) / 0.5f;
            pG[flipped_y * width + x] = (g - 0.5f) / 0.5f;
            pB[flipped_y * width + x] = (b - 0.5f) / 0.5f;
        }
        // Skip padding bytes
        pixelIndex += rowSize - width * 3;
    }

    free(imageData);
}

void savetxt(float *p_data, int width, int height, int channel,
             const char *filename) {
    FILE *outFile = fopen(filename, "w");
    if (!outFile) {
        printf("Failed to create output file.\n");
        return;
    }

    for (int c = 0; c < channel; c++) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                fprintf(outFile, "%.7f ",
                        p_data[c * height * width + i * width + j]);
            }
            fprintf(outFile, "\n");
        }
        fprintf(outFile, "\n");
    }

    fclose(outFile);
    printf("Saved to %s ...\n", filename);
}

void readFloatBinary(const char *filename, float **data) {
    FILE *file = fopen(filename, "rb");
    if (!file) {
        printf("Failed to open file: %s\n", filename);
        return;
    }

    fseek(file, 0, SEEK_END);
    long fileSize = ftell(file);
    rewind(file);

    if (fileSize % sizeof(float) != 0) {
        printf("File size is not a multiple of float size. Corrupted file?\n");
        fclose(file);
        return;
    }

    size_t numFloats = fileSize / sizeof(float);
    *data = (float *)malloc(fileSize);
    if (!*data) {
        printf("Memory allocation failed.\n");
        fclose(file);
        return;
    }

    size_t readCount = fread(*data, sizeof(float), numFloats, file);
    if (readCount != numFloats) {
        printf("Failed to read the expected number of floats.\n");
        free(*data);
        fclose(file);
        return;
    }

    fclose(file);
}

void initConv(ConvolutionLayer *conv, int in_channel, int out_channel,
              int kernel_size, int stride, int padding) {
    conv->in_channel = in_channel;
    conv->out_channel = out_channel;
    conv->kernel_size = kernel_size;
    conv->stride = stride;
    conv->padding = padding;
    
    readFloatBinary("./params/weight_conv1.bin", &(conv->weight));
    readFloatBinary("./params/bias_conv1.bin", &(conv->bias));
}

void initFc(FullyConnectedLayer *fc, int in_channel, int out_channel) {
    fc->in_channel = in_channel;
    fc->out_channel = out_channel;
    
    readFloatBinary("./params/weight_fc3.bin", &(fc->weight));
    readFloatBinary("./params/bias_fc3.bin", &(fc->bias));
}

void initPool(MaxPooling *pool, int kernel_size, int stride) {
    pool->kernel_size = kernel_size;
    pool->stride = stride;
}

void pad(Image *input, Image *output, int padding) {
    if (padding == 0) {
        output->width = input->width;
        output->height = input->height;
        output->channel = input->channel;
        output->data = input->data;
        return;
    }

    output->width = input->width + 2 * padding;
    output->height = input->height + 2 * padding;
    output->channel = input->channel;
    output->data = (float *)malloc(output->width * output->height *
                                   input->channel * sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for padding.\n");
        return;
    }

    memset(output->data, 0,
           output->width * output->height * input->channel * sizeof(float));

    for (int c = 0; c < input->channel; c++) {
        for (int i = 0; i < input->height; i++) {
            for (int j = 0; j < input->width; j++) {
                int input_idx =
                    c * input->width * input->height + i * input->width + j;
                int output_idx = c * output->width * output->height +
                                 (i + padding) * output->width + (j + padding);
                output->data[output_idx] = input->data[input_idx];
            }
        }
    }
}

void convolve(Image *input, Image *output, const ConvolutionLayer conv) {
    int out_width =
        (input->width + 2 * conv.padding - conv.kernel_size) / conv.stride + 1;
    int out_height =
        (input->height + 2 * conv.padding - conv.kernel_size) / conv.stride + 1;

    output->width = out_width;
    output->height = out_height;
    output->channel = conv.out_channel;
    output->data = (float *)malloc(out_width * out_height * conv.out_channel *
                                   sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for convolution output.\n");
        return;
    }

    Image padded;
    pad(input, &padded, conv.padding);

    for (int oc = 0; oc < conv.out_channel; oc++) {
        for (int oh = 0; oh < out_height; oh++) {
            for (int ow = 0; ow < out_width; ow++) {
                float sum = 0.0f;
                for (int ic = 0; ic < conv.in_channel; ic++) {
                    for (int kh = 0; kh < conv.kernel_size; kh++) {
                        for (int kw = 0; kw < conv.kernel_size; kw++) {
                            int input_h = oh * conv.stride + kh;
                            int input_w = ow * conv.stride + kw;
                            int input_idx = ic * padded.width * padded.height +
                                            input_h * padded.width + input_w;
                            int weight_idx =
                                oc * conv.in_channel * conv.kernel_size *
                                    conv.kernel_size +
                                ic * conv.kernel_size * conv.kernel_size +
                                kh * conv.kernel_size + kw;
                            sum += padded.data[input_idx] *
                                   conv.weight[weight_idx];
                        }
                    }
                }
                sum += conv.bias[oc];
                int output_idx =
                    oc * out_width * out_height + oh * out_width + ow;
                output->data[output_idx] = sum;
            }
        }
    }

    if (conv.padding > 0)
        free(padded.data);
}

void max_pooling(Image *input, Image *output, const MaxPooling pool) {
    int out_width = (input->width - pool.kernel_size) / pool.stride + 1;
    int out_height = (input->height - pool.kernel_size) / pool.stride + 1;

    output->width = out_width;
    output->height = out_height;
    output->channel = input->channel;
    output->data = (float *)malloc(out_width * out_height * input->channel *
                                   sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for pooling output.\n");
        return;
    }

    for (int c = 0; c < input->channel; c++) {
        for (int oh = 0; oh < out_height; oh++) {
            for (int ow = 0; ow < out_width; ow++) {
                float max_val = -FLT_MAX;
                int start_h = oh * pool.stride;
                int start_w = ow * pool.stride;

                for (int ph = 0; ph < pool.kernel_size; ph++) {
                    for (int pw = 0; pw < pool.kernel_size; pw++) {
                        int h = start_h + ph;
                        int w = start_w + pw;
                        if (h < input->height && w < input->width) {
                            int idx = c * input->width * input->height +
                                      h * input->width + w;
                            if (input->data[idx] > max_val) {
                                max_val = input->data[idx];
                            }
                        }
                    }
                }

                int idx = c * out_width * out_height + oh * out_width + ow;
                output->data[idx] = max_val;
            }
        }
    }
}

void reluImage(Image *input, Image *output) {
    output->width = input->width;
    output->height = input->height;
    output->channel = input->channel;
    output->data = (float *)malloc(input->width * input->height *
                                   input->channel * sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for ReLU output.\n");
        return;
    }

    int size = input->width * input->height * input->channel;
    for (int i = 0; i < size; i++) {
        output->data[i] = input->data[i] > 0 ? input->data[i] : 0.0f;
    }
}

void image2vector(Image *input, Vector *output) {
    int total_size = input->width * input->height * input->channel;
    output->channel = total_size;
    output->data = (float *)malloc(total_size * sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for vector.\n");
        return;
    }
    memcpy(output->data, input->data, total_size * sizeof(float));
}

void fullyconnect(Vector *input, Vector *output, const FullyConnectedLayer fc) {
    output->channel = fc.out_channel;
    output->data = (float *)malloc(fc.out_channel * sizeof(float));
    if (!output->data) {
        printf("Memory allocation failed for FC output.\n");
        return;
    }

    for (int i = 0; i < fc.out_channel; i++) {
        output->data[i] = fc.bias[i];
        for (int j = 0; j < fc.in_channel; j++) {
            output->data[i] +=
                input->data[j] * fc.weight[i * fc.in_channel + j];
        }
    }
}

void freeImage(Image *img) {
    if (img) {
        if (img->data) {
            free(img->data);
            img->data = NULL;
        }
        free(img);
    }
}

void freeVector(Vector *vec) {
    if (vec) {
        if (vec->data) {
            free(vec->data);
            vec->data = NULL;
        }
        free(vec);
    }
}

void freeResources(Image *bmp_image, Image *conv_output, Image *pooling_output,
                   Image *relu_output, Vector *fc_input, Vector *fc_output) {
    freeImage(bmp_image);
    freeImage(conv_output);
    freeImage(pooling_output);
    freeImage(relu_output);
    freeVector(fc_input);
    freeVector(fc_output);
}

int main() {
    if (_mkdir("output") == 0) {
        printf("Created folder 'output'\n");
    }

    Image *bmp_image = (Image *)malloc(sizeof(Image));
    readBMP("image.bmp",
            &(bmp_image->data), &(bmp_image->channel), &(bmp_image->width),
            &(bmp_image->height));
    savetxt(bmp_image->data, bmp_image->width, bmp_image->height,
            bmp_image->channel, "./output/image.txt");

    ConvolutionLayer conv;
    FullyConnectedLayer fc;
    MaxPooling pool;
    initConv(&conv, 3, 8, 3, 1, 1);
    initFc(&fc, 200, 7);
    initPool(&pool, 8, 8);

    Image *conv_output = (Image *)malloc(sizeof(Image));
    Image *pooling_output = (Image *)malloc(sizeof(Image));
    Image *relu_output = (Image *)malloc(sizeof(Image));

    printf("Performing convolution...\n");
    convolve(bmp_image, conv_output, conv);
    savetxt(conv_output->data, conv_output->width, conv_output->height,
            conv_output->channel, "./output/conv_output.txt");

    printf("Applying ReLU...\n");
    reluImage(conv_output, relu_output);
    savetxt(relu_output->data, relu_output->width, relu_output->height,
            relu_output->channel, "./output/relu_output.txt");

    printf("Performing max pooling...\n");
    max_pooling(relu_output, pooling_output, pool);
    savetxt(pooling_output->data, pooling_output->width, pooling_output->height,
            pooling_output->channel, "./output/pooling_output.txt");

    Vector *fc_input = (Vector *)malloc(sizeof(Vector));
    Vector *fc_output = (Vector *)malloc(sizeof(Vector));

    printf("Converting image to vector...\n");
    image2vector(pooling_output, fc_input);

    printf("Performing fully connected layer...\n");
    fullyconnect(fc_input, fc_output, fc);
    savetxt(fc_output->data, fc_output->channel, 1, 1,
            "./output/fc_output.txt");

    const char *emotions[] = {"surprise", "fear",  "disgust", "happiness",
                              "sadness",  "anger", "neutral"};
    float max_val = -FLT_MAX;
    int max_idx = -1;

    printf("\nClassification Results:\n");
    for (int i = 0; i < fc_output->channel; i++) {
        printf("%s: %.4f\n", emotions[i], fc_output->data[i]);
        if (fc_output->data[i] > max_val) {
            max_val = fc_output->data[i];
            max_idx = i;
        }
    }

    printf("\nPredicted Emotion: %s (%.4f)\n", emotions[max_idx], max_val);

    freeResources(bmp_image, conv_output, pooling_output, relu_output, fc_input,
                  fc_output);

    return 0;
}