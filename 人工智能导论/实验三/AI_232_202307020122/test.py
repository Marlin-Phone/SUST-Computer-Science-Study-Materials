

import torch
from torchvision import datasets
from torch.utils.data import DataLoader

from baseline import val_transforms
from baseline import Model


device = "cpu"


def test(dataloader, model):
    model.load_state_dict(torch.load('./best_classifier.pth', map_location=torch.device('cpu')))
    size = len(dataloader.dataset)
    model.eval()
    correct = 0

    with torch.no_grad():
        for X, y in dataloader:
            X, y = X.to(device), y.to(device)
            pred = model(X)            
            correct += (pred.argmax(1) == y).type(torch.float).sum().item()

    correct /= size
    print(f"Test Error: \n Accuracy: {(100*correct):>0.1f}% \n") 
    return correct

model = Model()
test_data = datasets.ImageFolder(root="../data/test", transform=val_transforms)

batch_size = 32
test_dataloader = DataLoader(test_data, batch_size=batch_size, shuffle=False, num_workers=0)
test_acc = test(test_dataloader, model)
