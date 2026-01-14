
class Animal_Recognition:
    def __init__(self):  
        self.animals = ['金钱豹', '虎', '长颈鹿', '斑马', '鸵鸟', '企鹅', '信天翁']
        self.knowledges = {
            '有毛发': '哺乳动物',
            '有奶': '哺乳动物',
            '有羽毛': '鸟',
            '会飞,下蛋': '鸟',
            '吃肉': '食肉动物',
            '有犬齿,有爪,眼盯前方': '食肉动物',
            '哺乳动物,有蹄': '有蹄类动物',
            '哺乳动物,反刍动物': '有蹄类动物',
            '哺乳动物,食肉动物,黄褐色,身上有暗斑点': '金钱豹',
            '哺乳动物,食肉动物,黄褐色,黑色条纹': '虎',
            '有蹄类动物,长脖子,长腿,身上有暗斑点': '长颈鹿',
            '有蹄类动物,黑色条纹': '斑马',
            '鸟,长脖子,长腿,不会飞,黑白两色': '鸵鸟',
            '鸟,会游泳,不会飞,黑白两色': '企鹅',
            '鸟,擅飞': '信天翁'    
        }

    def get_features(self):
        features = []
        for key in self.knowledges.keys():
            features += key.split(',')    
        return features

    def print_knowledges(self):
        print('知识库:')
        for knowledge in self.knowledges.items():
            print('如果该动物{}，则该动物是{}'.format(knowledge[0], knowledge[1]))

    def print_features(self):
        print('所有特征:')
        for feature in self.get_features():
            print('{}'.format(feature))

    def check_database(self, database):
        for each_data in database:
            assert each_data in self.get_features(), '特征“{}”不存在...'.format(each_data)    
    
    # def inference(self, database):   
    #     # todo 实现基于产生式系统的动物识别
    #     features = set(database)
    #     new_added = True
    #     while()
    #     return '不知道'
    def inference(self, database):
    # 将输入特征转为集合
        features = set(database)
        new_added = True
    
    # 循环推理直到没有新特征加入
        while new_added:
            new_added = False
            for condition, conclusion in self.knowledges.items():
                cond_set = set(condition.split(','))
                # 检查是否满足当前条件且结论未加入
                if cond_set.issubset(features) and conclusion not in features:
                    features.add(conclusion)
                    new_added = True
        
        # 寻找最具体的动物匹配
            max_match = 0
            result = '不知道'
            for condition, animal in self.knowledges.items():
                cond_set = set(condition.split(','))
                # 只检查最终动物分类
                if animal in self.animals:
                    # 计算匹配的条件数量
                    match_count = len(cond_set & features)
                    if match_count > max_match and cond_set.issubset(features):
                        max_match = match_count
                        result = animal
                        
        return result




if '__main__' == __name__:   
    model = Animal_Recognition()
    model.print_knowledges()
    model.print_features()    

    # 测试给定database下的识别结果
    database = ['身上有暗斑点', '长脖子', '长腿', '有奶', '有蹄']
    model.check_database(database)
    animal = model.inference(database)
    print('该动物是:{}'.format(animal))

    
