# 实验三：猫狗图片分类（PyTorch）

## 实验简介

本实验基于PyTorch框架，完成了猫狗图片的二分类任务。通过卷积神经网络（CNN）和深度可分离卷积结构，提升了模型的表达能力和计算效率。实验内容包括数据预处理、模型设计、训练与测试。

## 目录结构

- `AI_232_202307020122/`：主要代码与模型文件
	- `baseline.py`：模型结构与训练相关代码
	- `test.py`：模型测试脚本
	- `best_classifier.pth`：保存的最佳模型参数
- `data/`：数据集
	- `train/`：训练集（含cat、dog子文件夹）
	- `test/`：测试集（含cat、dog子文件夹）

## 主要内容

- 使用数据增强（如随机翻转、旋转、颜色扰动等）提升模型泛化能力
- 采用深度可分离卷积块，减少参数量并提升效率
- 训练并保存最佳模型，支持测试集准确率评估

## 运行方法

1. 准备好数据集，按`data/train/cat`、`data/train/dog`、`data/test/cat`、`data/test/dog`组织图片
2. 运行`baseline.py`进行模型训练
3. 运行`test.py`对测试集进行评估，输出准确率

## 依赖环境

- Python 3.x
- torch
- torchvision

可通过如下命令安装依赖：

```bash
pip install torch torchvision
```