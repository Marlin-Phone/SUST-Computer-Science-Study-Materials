
class Fuzzy_Inference:
    def __init__(self):
        self.R = None    
    
    # def multiply_matrix(self, A, B):
    #     C = []
    #     # todo：实现模糊关系合成（矩阵乘法） 
    #     return C    
    def multiply_matrix(self, A, B):
        # 实现模糊矩阵的 max-min 合成
        if not A or not B:
            return []
        
        rows = len(A)
        cols = len(B[0]) if B else 0
        C = [[0.0] * cols for _ in range(rows)]
        
        for i in range(rows):
            for j in range(cols):
                max_val = 0.0
                for k in range(len(B)):
                    min_val = min(A[i][k], B[k][j])
                    max_val = max(max_val, min_val)
                C[i][j] = max_val
        return C

    def inference(self, A):
        prob_A = [[float(v.split('/')[0])] for v in A]
        prob_A_transpose = self.transpose(prob_A)
        B = self.multiply_matrix(prob_A_transpose, self.R)
        
        # 计算加权平均决策
        if not B or not B[0]:
            return B, None
        
        weights = [i+1 for i in range(len(B[0]))]  # 位置权重 [1,2,3,4,5]
        total = sum(B[0][j] * weights[j] for j in range(len(B[0])))
        sum_b = sum(B[0])
        
        decision = round(total / sum_b) if sum_b != 0 else 0
        return B, decision

   
    def transpose(self, matrix):        
        rows = len(matrix)
        cols = len(matrix[0])
        transposed = [[0 for _ in range(rows)] for _ in range(cols)]        
        for i in range(rows):
            for j in range(cols):
                transposed[j][i] = matrix[i][j]        
        return transposed

    def init_R(self, A, B):
        prob_A = [[float(v.split('/')[0])] for v in A]
        prob_B = [[float(v.split('/')[0])] for v in B]
        prob_B_transpose = self.transpose(prob_B)
        self.R = self.multiply_matrix(prob_A, prob_B_transpose)    
    
    # def inference(self, A):
    #     prob_A = [[float(v.split('/')[0])] for v in A]
    #     prob_A_transpose = self.transpose(prob_A)
    #     B = self.multiply_matrix(prob_A_transpose, self.R)        
    #     decison = None
    #     # todo 实现基于加权平均判决的模糊决策
    #     return B, decison


if '__main__' == __name__:
    model = Fuzzy_Inference()

    # 测试模糊关系合成（矩阵乘法） 
    A = [[1,2,3], [4,5,6], [7,8,9]]
    B = [[11,12,1,2], [13,14,3,4], [15,16,5,6]]    
    AxB = model.multiply_matrix(A, B)    
    print(AxB)

    # 测试模糊推理和决策
    A1 = ['1.0/1', '0.6/2', '0.3/3', '0.0/4', '0.0/5']
    B1 = ['0.0/1', '0.0/2', '0.3/3', '0.6/4', '1.0/5']
    A2 = ['0.8/1', '1.0/2', '0.6/3', '0.3/4', '0.0/5']
    model.init_R(A1, B1)
    B2, result = model.inference(A2)
    print(B2)
    print(result)