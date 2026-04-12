import re

class Token:
    """词法单元类，存储类型和值"""
    def __init__(self, type_, value):
        self.type = type_
        self.value = value

    def __repr__(self):
        return f"Token({self.type!r}, {self.value!r})"

class Lexer:
    """词法分析器"""
    def __init__(self, code):
        self.code = code
        self.pos = 0
        self.length = len(code)
        # 定义 Token 规则
        self.token_specs = [
            ('KEYWORD',    r'plot|range|func'),     # 关键字
            ('FLOAT',      r'\d+\.\d*|\.\d+'),      # 浮点数
            ('INTEGER',    r'\d+'),                 # 整数
            ('OPERATOR',   r'[+\-*/^=]'),           # 运算符
            ('PARENS',     r'[()]'),                # 括号
            ('BRACKETS',   r'[\[\]]'),              # 方括号
            ('COMMA',      r','),                   # 逗号
            ('SEMICOLON',  r';'),                   # 分号
            ('IDENTIFIER', r'[a-zA-Z][a-zA-Z0-9]*'), # 标识符
            ('SKIP',       r'\s+'),                 # 空白字符
            ('MISMATCH',   r'.'),                   # 错误字符
        ]
        self.pattern = '|'.join(f'(?P<{name}>{pattern})' for name, pattern in self.token_specs)

    def get_tokens(self):
        tokens = []
        while self.pos < self.length:
            match = re.match(self.pattern, self.code[self.pos:])
            if not match: break
            type_ = match.lastgroup
            value = match.group()
            self.pos += len(value)
            if type_ == 'SKIP': continue
            if type_ == 'MISMATCH':
                raise SyntaxError(f"词法错误: 非法字符 '{value}' at index {self.pos-1}")
            tokens.append(Token(type_, value))
        return tokens

def run_test(case_id, code):
    print(f"--- Test Case {case_id} ---")
    print(f"Code: {code}")
    lexer = Lexer(code)
    try:
        tokens = lexer.get_tokens()
        for t in tokens:
            print(t)
    except SyntaxError as e:
        print(e)
    print("\n")

if __name__ == "__main__":
    # Case 1: Complex math
    run_test(1, "f(x) = exp(x) * tan(3.14 / 2);")
    # Case 2: Plot command
    run_test(2, "plot g1(x) range [0, 100.];")
    # Case 3: Error handling
    run_test(3, "y = x @ 1;")
