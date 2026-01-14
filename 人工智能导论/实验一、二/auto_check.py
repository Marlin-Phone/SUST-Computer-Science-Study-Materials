
from AI_232_202307020122.experiment1 import *
from AI_232_202307020122.experiment2 import *

check_lists = [
    ['身上有暗斑点', '长脖子', '长腿', '有奶', '有蹄'],
    ['身上有暗斑点'],
    ['会飞', '下蛋', '会游泳', '不会飞', '黑白两色']
]

model1 = Animal_Recognition()
for check_list in check_lists:
    animal = model1.inference(check_list)
    print('该动物是:{}'.format(animal))

# result:
# 该动物是:长颈鹿
# 该动物是:不知道
# 该动物是:企鹅

A1 = ['1.0/1', '0.6/2', '0.3/3', '0.0/4', '0.0/5']
B1 = ['0.0/1', '0.0/2', '0.3/3', '0.6/4', '1.0/5']
A2 = ['0.8/1', '1.0/2', '0.6/3', '0.3/4', '0.0/5']

model2 = Fuzzy_Inference()
model2.init_R(A1, B1)
B2, result = model2.inference(A2)
print(B2)
print(result)

# result：
# [[0.0, 0.0, 0.3, 0.6, 0.8]]
# 4（由4.294117647058823四舍五入得到最终结果）