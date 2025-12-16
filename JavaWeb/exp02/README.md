> AI生成，没有核对，仅供参考，欢迎PR指正。

# 实验二 JSP技术及应用实验

## 实验目的
1. 熟练掌握JSP的声明、表达式、小脚本和注释的使用；
2. 理解JSP页面指令和动作的语法格式；
3. 理解JSP页面的生命周期；
4. 熟练掌握page指令的常用属性：import、session、errorPage、isErrorPage、contentType、pageEncoding；
5. 熟练掌握JSP的内置对象及用法；
6. 熟练掌握JSP作用域对象及用法。

## 文件说明

### 任务1：计数器页面
- `counter.jsp` - 使用JSP声明的全局计数器
- `counter_local.jsp` - 使用局部变量的计数器（用于对比）

### 任务2：错误处理机制
- `hello.jsp` - 处理请求参数，抛出异常
- `errorHandler.jsp` - 错误处理页面

### 任务3：用户登录系统
- `login.jsp` - 用户登录表单
- `deal.jsp` - 处理登录逻辑
- `main.jsp` - 主页面，显示欢迎信息
- `exit.jsp` - 退出登录

### 任务4：应用级访问计数器
- `app_counter.jsp` - 使用application对象实现全局访问计数

### 任务5：页面停留时间统计
- `staytime.jsp` - 统计用户在页面的停留时间

## 运行说明
1. 确保Tomcat服务器已启动
2. 将所有文件放置在Tomcat的webapps/exp02目录下
3. 通过浏览器访问相应的JSP页面，例如：
   - http://localhost:8080/exp02/counter.jsp
   - http://localhost:8080/exp02/login.jsp

## 实验要点分析

### JSP语法元素区别
- `<%! %>` - JSP声明，用于声明全局变量和方法
- `<% %>` - JSP脚本，用于编写Java代码
- `<%= %>` - JSP表达式，用于输出表达式的值

### JSP页面生命周期
1. 翻译阶段：JSP页面被翻译成Servlet源代码
2. 编译阶段：Servlet源代码被编译成字节码
3. 初始化阶段：容器加载Servlet类并调用init()方法
4. 执行阶段：对于每个请求，容器创建一个新的线程并调用_jspService()方法
5. 销毁阶段：容器调用destroy()方法并卸载Servlet类

### JSP指令和动作区别
- 指令（Directive）：`<%@ %>`，用于设置整个JSP页面的属性
- 动作（Action）：`<jsp:action>`，用于控制JSP页面的行为

### page指令常用属性
- `language` - 指定使用的脚本语言
- `import` - 导入Java包
- `session` - 是否自动创建session对象
- `errorPage` - 指定错误处理页面
- `isErrorPage` - 指定当前页面是否为错误处理页面
- `contentType` - 指定响应内容类型
- `pageEncoding` - 指定页面编码

### JSP内置对象
1. `request` - HttpServletRequest对象
2. `response` - HttpServletResponse对象
3. `session` - HttpSession对象
4. `application` - ServletContext对象
5. `out` - JspWriter对象
6. `pageContext` - PageContext对象
7. `config` - ServletConfig对象
8. `page` - 当前Servlet实例
9. `exception` - Throwable对象（仅在错误页面中可用）

### JSP四大作用域对象
1. `pageContext` - 页面范围，作用域最小
2. `request` - 请求范围
3. `session` - 会话范围
4. `application` - 应用范围，作用域最大