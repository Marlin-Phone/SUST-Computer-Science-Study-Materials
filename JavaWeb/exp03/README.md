> AI生成，没有核对，仅供参考，欢迎PR指正。

# 实验三：Web组件重用与JavaBeans

## 项目结构
```
exp03/
├── index.html                  # 主页，包含所有实验的链接
├── hello.jsp                   # 静态包含示例 - 方法一
├── response.jsp                # 静态包含的子页面 - 方法一
├── hello2.jsp                  # 静态包含示例 - 方法二
├── response2.jsp               # 静态包含的子页面 - 方法二
├── main.jsp                    # 动态包含示例 - 主页面
├── subpage.jsp                 # 动态包含的子页面
├── login.html                  # 用户登录页面
├── display.jsp                 # 显示用户信息页面
├── calculate.jsp               # 简单计算器页面
├── src/                       # Java源代码目录
│   └── com/
│       └── beans/
│           ├── UserBean.java          # 用户信息JavaBean
│           └── SimpleCalculator.java  # 简单计算器JavaBean
├── WEB-INF/
│   ├── web.xml                # Web应用配置文件
│   └── classes/               # 编译后的Java类文件
│       └── com/
│           └── beans/
│               ├── UserBean.class
│               └── SimpleCalculator.class
```

## 如何运行实验

1. 将exp03文件夹部署到Tomcat服务器的webapps目录下
2. 启动Tomcat服务器
3. 在浏览器中访问：http://localhost:8080/exp03/
4. 通过主页的链接访问各个实验内容

## 实验内容说明

### 1. 静态包含实验
- **方法一**：在hello.jsp中使用`<%@ include file="response.jsp" %>`直接包含response.jsp
- **方法二**：在hello2.jsp中通过pageContext共享数据，在response2.jsp中获取数据

### 2. 动态包含实验
- 在main.jsp中使用`<jsp:include>`动作包含subpage.jsp
- 通过参数传递数据给子页面

### 3. JavaBeans使用实验
- **用户信息管理**：通过UserBean管理用户信息
- **简单计算器**：通过SimpleCalculator实现四则运算

## 编译JavaBean类
如果需要重新编译JavaBean类，可以使用以下命令：
```bash
javac -d WEB-INF/classes -cp WEB-INF/classes src/com/beans/UserBean.java
javac -d WEB-INF/classes -cp WEB-INF/classes src/com/beans/SimpleCalculator.java