import os
import argparse
import numpy as np
from PIL import Image
import torch
import torchvision.transforms as transforms
from model import LCNN
import torch.serialization

# 添加安全全局变量以解决加载问题
with torch.serialization.safe_globals([argparse.Namespace]):
    parser = argparse.ArgumentParser(description='Rafdb')
    parser.add_argument('--num_classes', type=int, default=7)
    parser.add_argument('--resume_net', type=str, default='./results/best.ckpt')
    opts = parser.parse_args()

    net = LCNN(opts)
    
    # 使用 map_location 参数指定加载到 CPU
    ckpt = torch.load(
        opts.resume_net, 
        map_location=torch.device('cpu'),
        weights_only=False  # 禁用安全加载
    )
    
    # 加载模型状态
    net.load_state_dict(ckpt['model_state_dict'])

# 预处理保持不变
normalize = transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])    
transform = transforms.Compose([
    transforms.ToTensor(),
    normalize           
])
img = Image.open('./image.bmp')
img = transform(img).unsqueeze(0)   

# 确保目录存在
if not os.path.exists('./params'):
    os.makedirs('./params')

# 卷积层和BN层参数导出
for i in range(1, 7):
    conv = getattr(net, f'conv{i}')
    weight = conv.weight.detach().cpu().numpy().astype(np.float32)
    bias = conv.bias.detach().cpu().numpy().astype(np.float32)
    weight.reshape(-1).tofile(f'./params/weight_conv{i}.bin')
    bias.tofile(f'./params/bias_conv{i}.bin')
    if hasattr(net, f'bn{i}'):
        bn = getattr(net, f'bn{i}')
        bn_weight = bn.weight.detach().cpu().numpy().astype(np.float32)
        bn_bias = bn.bias.detach().cpu().numpy().astype(np.float32)
        bn_running_mean = bn.running_mean.detach().cpu().numpy().astype(np.float32)
        bn_running_var = bn.running_var.detach().cpu().numpy().astype(np.float32)
        bn_weight.tofile(f'./params/weight_bn{i}.bin')
        bn_bias.tofile(f'./params/bias_bn{i}.bin')
        bn_running_mean.tofile(f'./params/running_mean_bn{i}.bin')
        bn_running_var.tofile(f'./params/running_var_bn{i}.bin')

# 全连接层参数导出
for i in range(1, 4):
    fc = getattr(net, f'fc{i}')
    weight = fc.weight.detach().cpu().numpy().astype(np.float32)
    bias = fc.bias.detach().cpu().numpy().astype(np.float32)
    weight.reshape(-1).tofile(f'./params/weight_fc{i}.bin')
    bias.tofile(f'./params/bias_fc{i}.bin')

print('所有参数已导出到 ./params/ 目录')