# 面部表情识别（轻量 CNN）

## 流程

1. 数据准备
2. 环境配置
3. 复现训练（可选）
4. 复现推理验证

## 一、数据准备

这个项目中**删除了部分数据集文件以节省空间**，如果要进行复现，**请自行准备数据集**！    
数据集准备方法：
1. 将你的数据集压缩文件（images.zip）解压后放入 `cnn_python/data/images` 目录下。
2. 创建标签文件 `cnn_python/data/labels.txt`，格式为每行 `image_name label`，label 范围为 1..7。本项目中已包含该文件，但请**确认其内容与数据集目录对应**。
3. 确保数据集目录结构正确。

代码目录结构：
```
codes/
  cnn_python/
    model.py                        # 模型定义
    train.py                        # 训练脚本
    test_dataset.py                 # 数据集与预处理
    save_parameters.py              # 导出参数脚本
    valid_python_single.py          # Numpy单张图像验证
    valid_python_many.py            # Numpy批量图像验证
    valid_c.py                      # C实现验证脚本
    data/
      images/                       # 图像数据集目录（需自行准备）
        test_0001_aligned.bmp       # 测试图像文件
        ...
        train_00001_aligned.bmp     # 训练图像文件
      image.bmp                     # 示例图像文件
      labels.txt                    # 标签文件（本项目中已包含，但需确认与图像数据集目录对应）
    results/                        # 训练结果与检查点
    params/                         # 导出参数目录
  cnn_c/
    example.cpp                     # C推理示例
      output/                       # C运行输出目录
```

## 二、环境配置

> [!WARNING]
> 由于本文作者在撰写该 README 时距离项目代码编写时间较远，以下环境配置内容**可能存在不准确之处**，请谨慎参考！
> 准确环境配置请**以老师的文档为准**！

1. 推荐 Python 版本 与Conda 虚拟环境

- 建议使用 Python 3.9.12 (作者在该项目使用的 Python 版本)。首选 IDE 为 PyCharm，使用 Conda (Anaconda/Miniconda)创建虚拟环境以避免依赖冲突。

2. 安装依赖

- 已在 [cnn_python/requirements.txt](cnn_python/requirements.txt) 列出常用依赖，推荐先使用：

```bash
pip install -r cnn_python/requirements.txt
```

2. 可选：GPU / CUDA

- 有GPU的话建议使用GPU，可以极大的加快训练和推理速度。请确保安装了合适版本的 CUDA，并安装对应的 PyTorch 版本。如果不匹配会产生报错！

3. 运行目录与常见命令

- 绝大多数脚本假定当前工作目录为 `cnn_python`。示例：

```bash
cd cnn_python
python train.py --num_epochs 50 --batch_size 64
```

- 导出参数并在 Numpy/C 中验证：

```bash
python save_parameters.py --resume_net ./results/best.ckpt
python valid_python_single.py
```

## 三、复现训练
由于该项目已经包含了已训练好的参数，所以复现训练是可选的。如果你想从头开始训练模型，请按照以下步骤操作：

项目复现过程（训练）：  
- 1. 导入你自己的数据集到 `cnn_python/data/images` 目录下，标签文件为 `cnn_python/data/labels.txt`，格式为每行 `image_name label`，label 范围为 1..7。
```sh
# 必须在cnn_python下运行，否则请：
# cd cnn_python
python train.py
```

## 四、复现推理验证

项目复现过程（验证 Numpy/C实现推理）：

Numpy验证：  
```sh
# 必须在cnn_python下运行，否则请cd到该目录
python valid_python_single.py
python valid_python_many.py
```

C验证：  
```sh
# 必须在cnn_python下运行，否则请cd到该目录
python valid_c.py
```

运行完毕后，C程序会在 `cnn_c/output` 目录下生成中间输出文件，可将其与 Numpy 结果进行对比。

---

> [!WARNING]
> 以下内容来自**AI生成**，仅供参考。

---

**项目概述**
- 本项目实现了一个轻量卷积神经网络（LCNN）用于面部表情识别，主要基于 PyTorch 训练；并提供将训练权重导出为二进制参数、用 Numpy 重实现推理以验证、以及用 C 语言实现的推理示例。

**代码结构**
- 模型定义：[cnn_python/model.py](cnn_python/model.py)
- 训练脚本：[cnn_python/train.py](cnn_python/train.py)
- 数据集与预处理：[cnn_python/test_dataset.py](cnn_python/test_dataset.py)
- 导出参数：[cnn_python/save_parameters.py](cnn_python/save_parameters.py)
- Numpy 验证（单张/批量）：[cnn_python/valid_python_single.py](cnn_python/valid_python_single.py), [cnn_python/valid_python_many.py](cnn_python/valid_python_many.py)
- C 实现验证脚本：[cnn_python/valid_c.py](cnn_python/valid_c.py)
- C 推理示例：[cnn_c/example.cpp](cnn_c/example.cpp)
- 训练结果与检查点：[cnn_python/results](cnn_python/results)
- 导出参数目录：[cnn_python/params](cnn_python/params)

**依赖**
- Python 3.8+（建议）
- PyTorch, torchvision, numpy, Pillow, matplotlib, pandas

安装示例：
```bash
python -m pip install torch torchvision numpy pillow matplotlib pandas
```

**数据与标签格式**
- 数据目录：`cnn_python/data/images`
- 标签文件：`cnn_python/data/labels.txt`，每行格式：`image_name label`（label 为 1..7，对应 7 个表情）

**快速开始**
1. 切换到工程 Python 目录：
```bash
cd cnn_python
```
1. 训练模型（示例）：
```bash
python train.py --num_epochs 50 --batch_size 64 --learning_rate 0.001 --save_dir ./results
```
训练完成后，检查点会保存在 `./results`，最佳模型会另存为 `best.ckpt`。

1. 导出参数（二进制）用于 Numpy/C 验证：
```bash
python save_parameters.py --num_classes 7 --resume_net ./results/best.ckpt
```
导出文件位于 `./params`，文件名示例：`weight_conv1.bin`, `bias_conv1.bin`, `weight_fc1.bin` 等。

1. 使用 Numpy 单张图像推理对比（与 PyTorch 结果比对）：
```bash
python valid_python_single.py
```

1. 批量验证（Numpy）：
```bash
python valid_python_many.py
```

1. 在 C 中运行示例（编译并运行 `example.cpp`，它会读取 `./params` 和 `image.bmp`）：
```bash
cd ../cnn_c
cl /EHsc example.cpp   # 或使用 g++: g++ -O2 example.cpp -o example.exe
example.exe
```
运行后会在 `cnn_c/output` 生成中间输出文件。

**输出与结果**
- PyTorch 训练产生的模型检查点：`cnn_python/results/`（包含 epoch_x.pth, best.ckpt）
- 导出参数：`cnn_python/params/`（二进制 float32）
- C 运行输出：`cnn_c/output/`（文本格式的中间张量）

**注意事项 / 已知点**
- 路径为相对路径，Windows 下脚本中使用了反斜杠和正斜杠混合，运行前请确认当前工作目录为 `cnn_python`（或相应调整路径）。
- `save_parameters.py` 与验证脚本默认把 `best.ckpt` 加载到 CPU（map_location），确保 `./results/best.ckpt` 存在。
- Numpy/C 实现与 PyTorch 之间可能出现数值差异，`valid_python_single.py` 会输出平均绝对误差以评估差异。

**如何复现作者的结果（简短步骤）**
1. 准备 `data/images` 和 `data/labels.txt`。
2. 运行训练：`python train.py`。
3. 导出参数：`python save_parameters.py`。
4. 运行 `valid_python_single.py` 或编译并运行 `example.cpp`。
