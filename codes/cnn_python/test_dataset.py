

import torch
from torch.utils.data import Dataset
from torchvision import datasets
from torchvision.transforms import ToTensor
import matplotlib.pyplot as plt
from PIL import Image
import torchvision.transforms as transforms
import os
import pandas as pd
from torchvision.io import decode_image
from torch.utils.data import DataLoader
from torchvision.utils import make_grid, save_image


class CustomImageDataset(Dataset):
    def __init__(self, img_dir, label_path, is_train=True):
        self.img_dir = img_dir
        self.label_path = label_path
        

        self.normalize = transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])
        
        with open(self.label_path, 'r') as f:
            self.img_labels = [line.strip().split() for line in f.readlines()]
        

        if is_train:
            self.transforms = transforms.Compose([       
                transforms.RandomHorizontalFlip(),
                transforms.ToTensor(),
                self.normalize
            ])
        else:        
            self.transforms = transforms.Compose([   
                transforms.ToTensor(),
                self.normalize
            ])

    def __len__(self):
        return len(self.img_labels)
        # return 100

    def __getitem__(self, idx):
        img_name, label = self.img_labels[idx]
        label = int(label)
        label -= 1
        img_path = os.path.join(self.img_dir, img_name)
        image = Image.open(img_path)
        if self.transforms:
            image = self.transforms(image)        
        return image, int(label)


        # img_path = os.path.join(self.img_dir, 'train_00050_aligned.bmp')
        # image = Image.open(img_path)
        # label = 1
        # if self.transforms:
        #     image = self.transforms(image)        
        # return image, label
    

training_data = CustomImageDataset(img_dir=r'.\data\images', label_path=r'.\data\labels.txt')

train_dataloader = DataLoader(training_data, batch_size=64, shuffle=True)

for i, (X, y) in enumerate(train_dataloader):
    print(f"Shape of X [N, C, H, W]: {X.shape}")
    print(f"Shape of y: {y.shape} {y.dtype}")
    grid_image = make_grid(X, nrow=8, padding=2, normalize=True)
    save_image(grid_image, 'train_batch_{:0>6d}.png'.format(i))
    if i==2: break
    
