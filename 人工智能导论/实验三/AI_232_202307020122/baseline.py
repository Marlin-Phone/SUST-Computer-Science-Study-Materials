import os
import torch
from torch import nn
from torch.utils.data import DataLoader, random_split
from torchvision import datasets, models, transforms
import torch.nn.functional as F


device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Using {device} device")


def count_parameters(model):
    return sum(p.numel() for p in model.parameters() if p.requires_grad)


# 强化数据变换（保持原样）
train_transforms = transforms.Compose([
    transforms.Resize((144, 144)),  # 平衡尺寸和计算量
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(15),
    transforms.ColorJitter(brightness=0.1, contrast=0.1, saturation=0.1),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])


# 注意：不要修改名字"val_transforms"
val_transforms = transforms.Compose([
    transforms.Resize((144, 144)),  # 保持一致
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])


# 深度可分离卷积块
class DepthwiseSeparableConv(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, padding=0):
        super().__init__()
        self.depthwise = nn.Conv2d(in_channels, in_channels, kernel_size=kernel_size,
                                   stride=stride, padding=padding, groups=in_channels)
        self.pointwise = nn.Conv2d(in_channels, out_channels, kernel_size=1)
        self.bn = nn.BatchNorm2d(out_channels)
        self.relu = nn.ReLU(inplace=True)

    def forward(self, x):
        x = self.depthwise(x)
        x = self.pointwise(x)
        x = self.bn(x)
        return self.relu(x)


# 注意：不要修改名字"Model"
class Model(nn.Module):
    def __init__(self):
        super(Model, self).__init__()

        # 翻倍通道数 - 增加模型容量
        self.conv_layers = nn.Sequential(
            # 初始标准卷积（通道数翻倍）
            nn.Conv2d(3, 64, kernel_size=3, stride=2, padding=1),  # 32 -> 64
            nn.BatchNorm2d(64),
            nn.ReLU(inplace=True),

            # 深度可分离卷积块1（通道数翻倍）
            DepthwiseSeparableConv(
                64, 128, kernel_size=3, padding=1),  # 64 -> 128
            nn.MaxPool2d(kernel_size=2, stride=2),

            # 深度可分离卷积块2（通道数翻倍）
            DepthwiseSeparableConv(
                128, 256, kernel_size=3, padding=1),  # 128 -> 256
            DepthwiseSeparableConv(
                256, 256, kernel_size=3, padding=1),  # 保持256但额外添加一层
            nn.MaxPool2d(kernel_size=2, stride=2),

            # 深度可分离卷积块3（通道数翻倍）
            DepthwiseSeparableConv(
                256, 512, kernel_size=3, padding=1),  # 256 -> 512
            DepthwiseSeparableConv(
                512, 512, kernel_size=3, padding=1),  # 保持512
            DepthwiseSeparableConv(
                512, 512, kernel_size=3, padding=1),  # 额外添加一层
            nn.MaxPool2d(kernel_size=2, stride=2),

            # 深度可分离卷积块4（通道数翻倍）
            DepthwiseSeparableConv(
                512, 1024, kernel_size=3, padding=1),  # 512 -> 1024
            DepthwiseSeparableConv(
                1024, 1024, kernel_size=3, padding=1),  # 保持1024
            nn.MaxPool2d(kernel_size=2, stride=2),

            # 自适应平均池化
            nn.AdaptiveAvgPool2d((1, 1))
        )

        # 分类头部（宽度翻倍）
        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(1024, 256),  # 512 -> 1024, 128 -> 256
            nn.BatchNorm1d(256),
            nn.ReLU(inplace=True),
            nn.Dropout(0.5),
            nn.Linear(256, 128),  # 128 -> 256, 64 -> 128
            nn.BatchNorm1d(128),
            nn.ReLU(inplace=True),
            nn.Dropout(0.3),
            nn.Linear(128, 2)
        )

    def forward(self, x):
        x = self.conv_layers(x)
        x = self.classifier(x)
        return x


def train(dataloader, model, criterion, optimizer):
    model.train()

    for _, (X, y) in enumerate(dataloader):
        X, y = X.to(device), y.to(device)
        pred = model(X)
        loss = criterion(pred, y)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

    # 保留原始输出格式
    print(f"loss: {loss.item():>7f}")


def val(dataloader, model, criterion):
    size = len(dataloader.dataset)
    num_batches = len(dataloader)
    model.eval()
    test_loss, correct = 0, 0

    with torch.no_grad():
        for X, y in dataloader:
            X, y = X.to(device), y.to(device)
            pred = model(X)
            test_loss += criterion(pred, y).item()
            correct += (pred.argmax(1) == y).type(torch.float).sum().item()

    test_loss /= num_batches
    correct /= size
    # 保留原始输出格式
    print(
        f"Val Error: \n Accuracy: {(100*correct):>0.1f}%, Avg loss: {test_loss:>8f} \n")
    return correct


def test(dataloader, model, criterion):
    model.load_state_dict(torch.load(
        './best_classifier.pth', map_location=torch.device('cpu')))
    size = len(dataloader.dataset)
    num_batches = len(dataloader)
    model.eval()
    test_loss, correct = 0, 0

    with torch.no_grad():
        for X, y in dataloader:
            X, y = X.to(device), y.to(device)
            pred = model(X)
            test_loss += criterion(pred, y).item()
            correct += (pred.argmax(1) == y).type(torch.float).sum().item()

    test_loss /= num_batches
    correct /= size
    # 保留原始输出格式
    print(
        f"Test Error: \n Accuracy: {(100*correct):>0.1f}%, Avg loss: {test_loss:>8f} \n")
    return correct


if __name__ == '__main__':
    # 数据集加载 - 保持原结构
    dataset = datasets.ImageFolder(
        root="../data/train", transform=train_transforms)
    test_data = datasets.ImageFolder(
        root="../data/test", transform=val_transforms)
    train_size = int(0.8 * len(dataset))  # 增加训练数据比例
    val_size = len(dataset) - train_size
    torch.manual_seed(42)  # 设置随机种子
    train_data, val_data = random_split(dataset, [train_size, val_size])

    batch_size = 32
    train_dataloader = DataLoader(
        train_data, batch_size=batch_size, shuffle=True, num_workers=2)
    val_dataloader = DataLoader(
        val_data, batch_size=batch_size, shuffle=False, num_workers=2)
    test_dataloader = DataLoader(
        test_data, batch_size=batch_size, shuffle=False, num_workers=2)

    model = Model().to(device)
    criterion = nn.CrossEntropyLoss()

    # 优化器设置 - 保持原样
    optimizer = torch.optim.AdamW(
        model.parameters(),
        lr=0.0005,
        weight_decay=1e-4  # L2正则化
    )

    best_acc = -1.0
    epochs = 30  # 训练轮次不变
    for t in range(epochs):
        print(f"Epoch {t+1}\n-------------------------------")  # 保持原格式
        train(train_dataloader, model, criterion, optimizer)
        acc = val(val_dataloader, model, criterion)

        # 手动调整学习率 - 每5个epoch降低一次
        if t % 5 == 4:  # 每5个epoch降低学习率
            for param_group in optimizer.param_groups:
                param_group['lr'] *= 0.75

        if acc > best_acc:
            best_acc = acc
            # 注意：模型保存不要修改 - 保留原注释
            torch.save(model.state_dict(), "./best_classifier.pth")
            num_params = count_parameters(model)
            # 保持输出格式完全不变
            print(
                f"Best model parameters count: {num_params * 4 / (1024 * 1024):.2f} MB")

    test_acc = test(test_dataloader, model, criterion)
    # 保持结束语句不变
    print("finish...")
