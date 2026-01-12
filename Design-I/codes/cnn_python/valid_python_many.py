import os
import argparse
import numpy as np
from PIL import Image
import torch
import torchvision.transforms as transforms
import struct


def read_bin_as_floats(filename):
    """读取二进制文件为float数组"""
    floats = []
    with open(filename, 'rb') as file:
        data = file.read()
        float_size = struct.calcsize('f')
        
        if len(data) % float_size != 0:
            print(f"File {filename} size is not a multiple of float size. Data might be corrupted.")
            return []
            
        for i in range(0, len(data), float_size):
            float_value = struct.unpack('f', data[i:i + float_size])[0]
            floats.append(float_value)
    return np.array(floats, dtype=np.float32)


def np_pad(array, pad_num):
    """边缘填充"""
    return np.pad(array, ((0, 0), (pad_num, pad_num), (pad_num, pad_num)), mode='constant')


def func_conv2d(input, kernel, bias, stride=1, padding=0):
    """卷积操作"""
    # 1. 对输入进行填充
    if padding > 0:
        input_padded = np_pad(input, padding)
    else:
        input_padded = input

    C, H, W = input_padded.shape
    OC, _, KH, KW = kernel.shape

    # 2. 计算输出尺寸
    OH = (H - KH) // stride + 1
    OW = (W - KW) // stride + 1

    # 3. 初始化输出
    output = np.zeros((OC, OH, OW))

    # 4. 执行卷积运算
    for oc in range(OC):
        for y in range(0, OH):
            for x in range(0, OW):
                # 计算当前窗口位置
                h_start = y * stride
                w_start = x * stride
                h_end = h_start + KH
                w_end = w_start + KW

                # 提取输入窗口
                window = input_padded[:, h_start:h_end, w_start:w_end]

                # 卷积计算：对应元素相乘后求和
                conv_val = np.sum(window * kernel[oc])
                # 加上偏置
                output[oc, y, x] = conv_val + bias[oc]

    return output


def func_batch_norm(input, weight, bias, running_mean, running_var, eps=1e-5):
    """批归一化操作"""
    # 标准化
    normalized = (input - running_mean.reshape(-1, 1, 1)) / np.sqrt(running_var.reshape(-1, 1, 1) + eps)
    # 缩放和偏移
    return weight.reshape(-1, 1, 1) * normalized + bias.reshape(-1, 1, 1)


def func_max_pooling(input, win_size, stride, padding=0):
    """最大池化操作"""
    # 1. 对输入进行填充
    if padding > 0:
        input_padded = np_pad(input, padding)
    else:
        input_padded = input

    C, H, W = input_padded.shape
    # 2. 计算输出尺寸
    OH = (H - win_size) // stride + 1
    OW = (W - win_size) // stride + 1

    # 3. 初始化输出
    output = np.zeros((C, OH, OW))

    # 4. 执行最大池化
    for c in range(C):
        for y in range(0, OH):
            for x in range(0, OW):
                # 计算当前窗口位置
                h_start = y * stride
                w_start = x * stride
                h_end = h_start + win_size
                w_end = w_start + win_size

                # 提取输入窗口
                window = input_padded[c, h_start:h_end, w_start:w_end]
                # 取窗口内最大值
                output[c, y, x] = np.max(window)

    return output


def func_relu(input):
    """ReLU激活函数"""
    return np.maximum(0, input)


def func_fc(input, weight, bias):
    """全连接层"""
    # 如果输入是1维，转为二维（1, D）
    if input.ndim == 1:
        input = input.reshape(1, -1)

    # 全连接计算：y = x * W^T + b
    output = np.dot(input, weight.T) + bias
    return output


def load_all_parameters():
    """加载所有参数"""
    params = {}
    
    # 加载卷积层参数
    for i in range(1, 7):
        weight = read_bin_as_floats(f'./params/weight_conv{i}.bin')
        bias = read_bin_as_floats(f'./params/bias_conv{i}.bin')
        
        # 重塑权重
        if i == 1:
            weight = weight.reshape(16, 3, 3, 3)
        elif i == 2:
            weight = weight.reshape(16, 16, 3, 3)
        elif i == 3:
            weight = weight.reshape(32, 16, 3, 3)
        elif i == 4:
            weight = weight.reshape(32, 32, 3, 3)
        elif i == 5:
            weight = weight.reshape(64, 32, 3, 3)
        elif i == 6:
            weight = weight.reshape(64, 64, 3, 3)
            
        params[f'conv{i}_weight'] = weight
        params[f'conv{i}_bias'] = bias
        
        # 加载BN层参数
        if os.path.exists(f'./params/weight_bn{i}.bin'):
            bn_weight = read_bin_as_floats(f'./params/weight_bn{i}.bin')
            bn_bias = read_bin_as_floats(f'./params/bias_bn{i}.bin')
            bn_running_mean = read_bin_as_floats(f'./params/running_mean_bn{i}.bin')
            bn_running_var = read_bin_as_floats(f'./params/running_var_bn{i}.bin')
            
            params[f'bn{i}_weight'] = bn_weight
            params[f'bn{i}_bias'] = bn_bias
            params[f'bn{i}_running_mean'] = bn_running_mean
            params[f'bn{i}_running_var'] = bn_running_var
    
    # 加载全连接层参数
    for i in range(1, 4):
        weight = read_bin_as_floats(f'./params/weight_fc{i}.bin')
        bias = read_bin_as_floats(f'./params/bias_fc{i}.bin')
        
        # 重塑权重
        if i == 1:
            weight = weight.reshape(128, 1600)  # 64*5*5 = 1600
        elif i == 2:
            weight = weight.reshape(64, 128)
        elif i == 3:
            weight = weight.reshape(7, 64)
            
        params[f'fc{i}_weight'] = weight
        params[f'fc{i}_bias'] = bias
    
    return params


def complex_model_inference(input_tensor, params):
    """复杂模型推理"""
    x = input_tensor.squeeze().numpy().astype(np.float32)
    
    # 第一个卷积块
    x = func_conv2d(x, params['conv1_weight'], params['conv1_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn1_weight'], params['bn1_bias'], 
                       params['bn1_running_mean'], params['bn1_running_var'])
    x = func_relu(x)
    
    x = func_conv2d(x, params['conv2_weight'], params['conv2_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn2_weight'], params['bn2_bias'], 
                       params['bn2_running_mean'], params['bn2_running_var'])
    x = func_relu(x)
    x = func_max_pooling(x, 2, 2)  # pool1
    
    # 第二个卷积块
    x = func_conv2d(x, params['conv3_weight'], params['conv3_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn3_weight'], params['bn3_bias'], 
                       params['bn3_running_mean'], params['bn3_running_var'])
    x = func_relu(x)
    
    x = func_conv2d(x, params['conv4_weight'], params['conv4_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn4_weight'], params['bn4_bias'], 
                       params['bn4_running_mean'], params['bn4_running_var'])
    x = func_relu(x)
    x = func_max_pooling(x, 2, 2)  # pool2
    
    # 第三个卷积块
    x = func_conv2d(x, params['conv5_weight'], params['conv5_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn5_weight'], params['bn5_bias'], 
                       params['bn5_running_mean'], params['bn5_running_var'])
    x = func_relu(x)
    
    x = func_conv2d(x, params['conv6_weight'], params['conv6_bias'], stride=1, padding=1)
    x = func_batch_norm(x, params['bn6_weight'], params['bn6_bias'], 
                       params['bn6_running_mean'], params['bn6_running_var'])
    x = func_relu(x)
    x = func_max_pooling(x, 2, 2)  # pool3
    
    # 展平
    x = x.reshape(1, -1)
    
    # 全连接层
    x = func_fc(x, params['fc1_weight'], params['fc1_bias'])
    x = func_relu(x)
    
    x = func_fc(x, params['fc2_weight'], params['fc2_bias'])
    x = func_relu(x)
    
    x = func_fc(x, params['fc3_weight'], params['fc3_bias'])
    
    return x


if __name__ == '__main__':
    # 图像预处理
    normalize = transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])
    transform = transforms.Compose([
        transforms.ToTensor(),
        normalize
    ])

    # 加载所有参数
    print("正在加载参数...")
    params = load_all_parameters()
    print("参数加载完成")

    # batch inference
    img_dir = 'data\\images'
    label_path = 'data\\labels.txt'

    N = 200
    preds = []
    targets = []
    
    with open(label_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        for i, line in enumerate(lines[:N]):
            img_name, label = line.split(' ')
            img = Image.open(os.path.join(img_dir, img_name))
            img_tensor = transform(img).unsqueeze(0)
            
            # 使用复杂模型推理
            output = complex_model_inference(img_tensor, params)
            
            preds.append(np.argmax(output, 1).item())
            targets.append(int(label)-1)
            
            if (i + 1) % 10 == 0:
                print(f"已处理 {i + 1}/{N} 张图片")

    # 计算准确率
    acc = 0
    for v1, v2 in zip(preds, targets):
        acc += 1 if v1 == v2 else 0
    print(f"准确率(Accuracy): {acc/N*100:.2f}%")

    # 显示详细结果
    label2emotion = ['surprise', 'fear', 'disgust', 'happiness', 'sadness', 'anger', 'neutral']
    for i in range(min(20, N)):  # 只显示前20个结果
        pred_emotion = label2emotion[preds[i]]
        target_emotion = label2emotion[targets[i]]
        print(f"图片{i+1}: 预测={pred_emotion}({preds[i]}), 实际={target_emotion}({targets[i]})")
    
    print(f"finish... 总共处理了 {N} 张图片")
    