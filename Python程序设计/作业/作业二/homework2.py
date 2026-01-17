# 导入所需库
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from IPython.display import display, Markdown
import matplotlib as mpl
# %matplotlib inline

# 设置全局样式 - 解决中文字符显示问题
plt.rcParams['font.sans-serif'] = ['SimHei']  # 用来正常显示中文标签
plt.rcParams['axes.unicode_minus'] = False    # 用来正常显示负号

try:
    # 尝试使用 seaborn 样式
    import seaborn as sns
    sns.set_style("whitegrid")
    print("使用 seaborn 的 whitegrid 样式")
except ImportError:
    # 如果 seaborn 不可用，使用 matplotlib 的默认样式
    plt.style.use('default')
    print("使用 matplotlib 的默认样式")

pd.set_option('display.float_format', '{:.4f}'.format)
pd.set_option('display.max_columns', None)

# (1) 导入数据包、读取数据csv文件、查看前10行数据
# 定义列名（根据数据集描述）
column_names = [
    'CRIM', 'ZN', 'INDUS', 'CHAS', 'NOX', 'RM', 'AGE', 'DIS', 
    'RAD', 'TAX', 'PTRATIO', 'B', 'LSTAT', 'MEDV'
]

display(Markdown("### (1) 导入数据并查看前10行数据"))

# 读取CSV文件 - 使用推荐的 sep='\s+' 替代 delim_whitespace
try:
    df = pd.read_csv('housing.csv', header=None, names=column_names, sep='\s+')
    print("成功读取 housing.csv 文件")
except FileNotFoundError:
    display(Markdown("<div style='color:red;'>错误：找不到 housing.csv 文件。请确保文件在当前工作目录。</div>"))
    # 创建示例数据以便继续运行
    np.random.seed(42)
    data = {
        'CRIM': np.random.rand(10),
        'ZN': np.random.randint(0, 100, 10),
        'INDUS': np.random.rand(10),
        'CHAS': np.random.randint(0, 2, 10),
        'NOX': np.random.rand(10),
        'RM': np.random.uniform(3, 8, 10),
        'AGE': np.random.randint(20, 100, 10),
        'DIS': np.random.rand(10),
        'RAD': np.random.randint(1, 10, 10),
        'TAX': np.random.randint(100, 800, 10),
        'PTRATIO': np.random.uniform(10, 25, 10),
        'B': np.random.rand(10),
        'LSTAT': np.random.uniform(1, 40, 10),
        'MEDV': np.random.randint(50, 500, 10)
    }
    
    df = pd.DataFrame(data)
    display(Markdown("已创建示例数据集用于演示目的。"))

# 查看前10行数据
display(Markdown("**前10行数据：**"))
display(df.head(10).style.set_caption("数据集前10行"))

# (2) 数据的描述统计
display(Markdown("### (2) 数据的描述统计"))

# 美化描述统计输出
desc = df.describe().transpose()
desc['count'] = desc['count'].astype(int)  # 将计数转为整数

display(Markdown("**描述性统计：**"))
display(desc.style.set_caption("数据集描述性统计"))

# (3) 绘制数据的箱形图
display(Markdown("### (3) 绘制数据的箱形图"))

plt.figure(figsize=(14, 8))
# 创建箱形图
box = plt.boxplot(df.values, patch_artist=True, vert=True, labels=df.columns)

# 设置颜色
colors = ['lightblue', 'lightgreen', 'lightpink', 'lightyellow', 'lightcyan',
          'lightgrey', 'lightcoral', 'lightsalmon', 'lightseagreen', 'lightskyblue',
          'lightslategrey', 'lightsteelblue', 'lightcoral', 'lightgreen']

for patch, color in zip(box['boxes'], colors):
    patch.set_facecolor(color)
    patch.set_edgecolor('darkblue')
    
for whisker in box['whiskers']:
    whisker.set(color='darkblue', linewidth=1.5)
    
for cap in box['caps']:
    cap.set(color='darkblue', linewidth=1.5)
    
for median in box['medians']:
    median.set(color='red', linewidth=2)

plt.title('Boston Housing Dataset 箱形图', fontsize=14, fontweight='bold')
plt.xticks(rotation=45)
plt.ylabel('数值范围', fontsize=12)
plt.tight_layout()
plt.show()

# (4) 查看数据的10%和90%分位数，查看目标值
display(Markdown("### (4) 数据的10%和90%分位数"))

# 计算所有数值列的分位数
quantiles = df.quantile([0.1, 0.9]).transpose()
quantiles.columns = ['10%分位数', '90%分位数']

display(Markdown("**所有特征的10%和90%分位数：**"))
display(quantiles.style.set_caption("特征分位数"))

# 单独查看目标值(MEDV)的分位数
medv_quantiles = df['MEDV'].quantile([0.1, 0.9])
medv_df = pd.DataFrame({
    '分位数': ['10%', '90%'],
    'MEDV值': [f"{medv_quantiles[0.1]:.4f}", f"{medv_quantiles[0.9]:.4f}"]
})

display(Markdown("**目标值(MEDV)的10%和90%分位数：**"))
# 使用更兼容的方式隐藏索引
styled_medv = medv_df.style.set_caption("目标变量分位数")
styled_medv = styled_medv.hide(axis='index')  # 兼容的隐藏索引方法
display(styled_medv)

# 添加额外分析 - 目标变量分布
display(Markdown("**目标变量(MEDV)分布直方图：**"))

plt.figure(figsize=(10, 6))
plt.hist(df['MEDV'], bins=30, color='steelblue', edgecolor='white', alpha=0.8)
plt.title('房屋价格(MEDV)分布', fontsize=14)
plt.xlabel('房屋价格(千美元)', fontsize=12)
plt.ylabel('频数', fontsize=12)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.show()