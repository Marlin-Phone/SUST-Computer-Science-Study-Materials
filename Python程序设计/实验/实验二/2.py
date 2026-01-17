# 尝试修改例6.2编写命令行参数解析示例程序,解析命令行参数所输入的边长的值,计算并输出正方形的周长和面积

# 例6.2
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--length', default = 10, type = int, help = '长度')
parser.add_argument('--width', default = 5, type = int, help = '宽度')

args = parser.parse_args()
area = args.length *  args.width
print('面积 = ', area)
print('周长 = ', 2 * (args.length + args.width))

# # 导入Python标准库中的argparse模块，用于解析命令行参数
# import argparse

# # 1. 创建参数解析器对象
# # ArgumentParser对象用于保存参数定义和生成帮助信息
# parser = argparse.ArgumentParser(
#     description='计算长方形面积',  # 程序的描述信息
#     epilog='示例: python script.py --length 10 --width 5'  # 帮助信息末尾的示例
# )

# # 2. 添加命令行参数定义
# # 添加'--length'参数（也可以用'-l'作为短参数名）
# parser.add_argument(
#     '--length',          # 参数名称（长格式）
#     default=10,         # 默认值为10（当用户未提供该参数时使用）
#     type=int,           # 将输入值转换为整数类型
#     help='长方形的长度',  # 参数的帮助说明
#     metavar='LEN',      # 在帮助信息中显示的参数值名称
#     dest='length'       # 解析后存储在args对象的属性名（默认与参数名相同）
# )

# # 添加'--width'参数（也可以用'-w'作为短参数名）
# parser.add_argument(
#     '--width',          # 参数名称（长格式）
#     default=5,          # 默认值为5
#     type=int,           # 将输入值转换为整数类型
#     help='长方形的宽度',  # 参数的帮助说明
#     metavar='WIDTH',    # 在帮助信息中显示的参数值名称
#     dest='width'        # 解析后存储在args对象的属性名
# )

# # 3. 解析命令行参数
# # 将自动解析sys.argv中的参数，并根据上面的定义进行验证和类型转换
# args = parser.parse_args()

# # 4. 计算面积
# # 通过args对象访问已解析的参数值（args.length和args.width）
# area = args.length * args.width

# # 5. 输出结果
# # 使用f-string格式化输出（Python 3.6+特性）
# print(f'长方形面积 = {area}')

# # 注：当用户输入无效参数时（如非数字），argparse会自动报错并显示帮助信息
# # 用户可以通过--help查看用法：python script.py --help
