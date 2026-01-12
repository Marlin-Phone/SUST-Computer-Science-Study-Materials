import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader
import argparse
import os
from test_dataset import CustomImageDataset
from model import LCNN
from multiprocessing import freeze_support

def train():
    # 参数配置解析
    parser = argparse.ArgumentParser(description='Train Facial Expression Recognition Model')

    # 设备检测（自动选择CUDA如果可用）
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    print(f"使用设备: {device}")

    # 必要参数
    parser.add_argument('--num_classes', type=int, default=7,
                      help='Number of emotion classes (default:7)')
    parser.add_argument('--batch_size', type=int, default=64,
                      help='Input batch size (default:64)')
    parser.add_argument('--num_epochs', type=int, default=50,
                      help='Number of training epochs (default:50)')
    parser.add_argument('--learning_rate', type=float, default=0.001,
                      help='Learning rate (default:0.001)')
    parser.add_argument('--save_dir', type=str, default='./results',
                      help='Directory to save checkpoints (default:./results)')

    # 可选参数
    parser.add_argument('--num_workers', type=int, default=4,
                      help='Number of data loading workers (default:4)')
    
    opts = parser.parse_args()

    # 创建保存目录
    os.makedirs(opts.save_dir, exist_ok=True)

    # 初始化数据集
    train_dataset = CustomImageDataset(
        img_dir=r'.\data\images',
        label_path=r'.\data\labels.txt',
        is_train=True
    )

    val_dataset = CustomImageDataset(
        img_dir=r'.\data\images',
        label_path=r'.\data\labels.txt',
        is_train=False
    )

    # 创建数据加载器（启用pin_memory加速数据传输）
    train_loader = DataLoader(
        train_dataset,
        batch_size=opts.batch_size,
        shuffle=True,
        num_workers=opts.num_workers,
        pin_memory=True  # 启用内存锁页，加速CPU到GPU的数据传输
    )

    val_loader = DataLoader(
        val_dataset,
        batch_size=opts.batch_size,
        shuffle=False,
        num_workers=opts.num_workers,
        pin_memory=True
    )

    # 初始化模型并转移到CUDA
    model = LCNN(opts).to(device)
    
    # 打印模型参数数量
    total_params = sum(p.numel() for p in model.parameters())
    print(f"模型总参数数: {total_params:,}")
    
    # 如果使用多GPU，启用DataParallel
    if torch.cuda.device_count() > 1:
        print(f"使用 {torch.cuda.device_count()} 个GPU!")
        model = nn.DataParallel(model)
    
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=opts.learning_rate)

    # 训练循环
    best_acc = 0.0
    for epoch in range(opts.num_epochs):
        model.train()
        running_loss = 0.0
        
        for i, (images, labels) in enumerate(train_loader):
            # 将数据转移到CUDA设备（非阻塞传输）
            images = images.to(device, non_blocking=True)
            labels = labels.to(device, non_blocking=True)
            
            # 前向传播
            outputs = model(images)
            loss = criterion(outputs, labels)
            
            # 反向传播和优化
            optimizer.zero_grad(set_to_none=True)  # 更高效的内存清理
            loss.backward()
            optimizer.step()
            
            running_loss += loss.item()
            
            # 每100个batch打印一次
            if i % 100 == 99:
                print(f'Epoch [{epoch+1}/{opts.num_epochs}], '
                    f'Step [{i+1}/{len(train_loader)}], '
                    f'Loss: {running_loss/100:.4f}')
                running_loss = 0.0
        
        # 每个epoch保存模型
        checkpoint = {
            'epoch': epoch,
            'model_state_dict': model.state_dict(),
            'optimizer_state_dict': optimizer.state_dict(),
            'loss': loss,
            'config': opts,
            'best_acc': best_acc
        }
        torch.save(
            checkpoint,
            os.path.join(opts.save_dir, f'epoch_{epoch+1}.pth')
        )

        # 验证模型
        model.eval()
        with torch.no_grad():
            correct = 0
            total = 0
            for val_images, val_labels in val_loader:
                val_images = val_images.to(device, non_blocking=True)
                val_labels = val_labels.to(device, non_blocking=True)
                
                val_outputs = model(val_images)
                _, predicted = torch.max(val_outputs, 1)
                
                total += val_labels.size(0)
                correct += (predicted == val_labels).sum().item()
            
            acc = 100 * correct / total
            print(f'Epoch [{epoch+1}/{opts.num_epochs}] 验证准确率: {acc:.2f}%')
            
            # 保存最佳模型
            if acc > best_acc:
                best_acc = acc
                torch.save(
                    checkpoint,
                    os.path.join(opts.save_dir, 'best.ckpt')
                )
                print(f'保存新的最佳模型，准确率: {best_acc:.2f}%')

    print('训练完成! 最佳验证准确率: {:.2f}%'.format(best_acc))

if __name__ == '__main__':
    freeze_support()  
    train()
