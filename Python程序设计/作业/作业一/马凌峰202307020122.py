import tkinter as tk
import math

class Calculator:
    def __init__(self, root):
        self.root = root
        self.root.title("图形化计算器")
        self.root.geometry("400x500")
        self.root.resizable(False, False)
        
        # 创建显示区域
        self.display_var = tk.StringVar()
        self.display_var.set("0")
        display = tk.Entry(root, textvariable=self.display_var, font=("Arial", 24), 
                          bd=20, insertwidth=1, bg="#f0f0f0", justify="right")
        display.pack(fill=tk.BOTH, ipadx=8, padx=10, pady=10)
        
        # 按钮框架
        button_frame = tk.Frame(root)
        button_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        # 按钮布局
        buttons = [
            '7', '8', '9', '/', 'sin',
            '4', '5', '6', '*', 'cos',
            '1', '2', '3', '-', 'tan',
            '0', '.', '=', '+', 'C'
        ]
        
        # 创建按钮
        self.buttons = {}
        row, col = 0, 0
        for btn_text in buttons:
            # 设置按钮颜色
            if btn_text in ['+', '-', '*', '/']:
                bg_color = "#ff9900"
            elif btn_text in ['sin', 'cos', 'tan']:
                bg_color = "#66cc66"
            elif btn_text == '=':
                bg_color = "#3399ff"
            elif btn_text == 'C':
                bg_color = "#ff6666"
            else:
                bg_color = "#e0e0e0"
            
            # 创建按钮
            button = tk.Button(button_frame, text=btn_text, font=("Arial", 18),
                              bg=bg_color, fg="black", bd=1, 
                              command=lambda t=btn_text: self.on_button_click(t))
            button.grid(row=row, column=col, sticky="nsew", padx=2, pady=2)
            self.buttons[btn_text] = button
            
            # 更新行列位置
            col += 1
            if col > 4:
                col = 0
                row += 1
        
        # 配置网格行列权重
        for i in range(5):
            button_frame.grid_columnconfigure(i, weight=1)
        for i in range(4):
            button_frame.grid_rowconfigure(i, weight=1)
        
        # 初始化计算器状态
        self.current_input = "0"
        self.stored_value = None
        self.operation = None
        self.reset_next = False
    
    def on_button_click(self, button_text):
        current_display = self.display_var.get()
        
        # 处理清除按钮
        if button_text == 'C':
            self.current_input = "0"
            self.stored_value = None
            self.operation = None
            self.reset_next = False
            self.display_var.set("0")
            return
        
        # 处理三角函数
        if button_text in ['sin', 'cos', 'tan']:
            try:
                value = float(current_display)
                # 将角度转换为弧度
                radians = math.radians(value)
                
                if button_text == 'sin':
                    result = math.sin(radians)
                elif button_text == 'cos':
                    result = math.cos(radians)
                elif button_text == 'tan':
                    result = math.tan(radians)
                
                # 格式化结果，保留5位小数
                self.display_var.set(f"{result:.5f}")
                self.current_input = str(result)
                self.reset_next = True
            except:
                self.display_var.set("错误")
            return
        
        # 处理数字和点
        if button_text in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.']:
            if self.reset_next:
                self.current_input = "0"
                self.reset_next = False
            
            if button_text == '.' and '.' in self.current_input:
                return  # 避免多个小数点
            
            if self.current_input == "0" and button_text != '.':
                self.current_input = button_text
            else:
                self.current_input += button_text
            
            self.display_var.set(self.current_input)
            return
        
        # 处理运算符
        if button_text in ['+', '-', '*', '/']:
            if self.stored_value is not None and self.operation is not None and not self.reset_next:
                self.calculate()  # 连续计算
            
            self.stored_value = float(self.current_input)
            self.operation = button_text
            self.reset_next = True
            return
        
        # 处理等号
        if button_text == '=':
            self.calculate()
    
    def calculate(self):
        try:
            current_value = float(self.current_input)
            
            if self.operation == '+':
                result = self.stored_value + current_value
            elif self.operation == '-':
                result = self.stored_value - current_value
            elif self.operation == '*':
                result = self.stored_value * current_value
            elif self.operation == '/':
                if current_value == 0:
                    raise ZeroDivisionError
                result = self.stored_value / current_value
            
            # 格式化结果，如果是整数显示整数，否则显示浮点数
            if result.is_integer():
                result_str = str(int(result))
            else:
                result_str = f"{result:.6f}".rstrip('0').rstrip('.')
                if '.' not in result_str:
                    result_str = str(result)
            
            self.display_var.set(result_str)
            self.current_input = result_str
            self.stored_value = None
            self.operation = None
            self.reset_next = True
        except ZeroDivisionError:
            self.display_var.set("错误：除零")
            self.current_input = "0"
            self.stored_value = None
            self.operation = None
        except:
            self.display_var.set("错误")

if __name__ == "__main__":
    root = tk.Tk()
    app = Calculator(root)
    root.mainloop()