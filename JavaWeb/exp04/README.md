> AI生成，没有核对，仅供参考，欢迎PR指正。

# 实验四

## 简介

`exp04` 是面向 Java Web（JSP/Servlet）的第4次实验，主题为“会话管理（Session Management）”。该目录包含示例页面、源码以及实验说明文档 `实验4--会话管理.doc`，用于展示和练习基于 HTTP Session 的状态维护（例如在线人数统计、会话信息保存、会话失效与共享等）。

## 目录结构（当前）

- `index.html` — 入口页面（请通过浏览器访问以查看示例或跳转到演示页面）。
- `src/` — 源代码目录（Servlet / Java 源文件，若存在请查看以了解实现细节）。
- `WEB-INF/` — Web 应用私有目录（web.xml、classes、lib 等）。
- `实验4--会话管理.doc` — 实验说明文档（包含实验目的、步骤与要求）。

## 运行与部署（Windows + Tomcat）

1. 确保 Java（JDK）与 Tomcat 已正确安装并能启动。
2. `exp04` 文件夹应位于 Tomcat 的 `webapps` 目录下（例如：
   `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exp04`）。
3. 启动或重启 Tomcat：

```powershell
# 如果 Tomcat 安装为 Windows 服务，替换服务名为你的实际服务名
Restart-Service -Name "Tomcat9" -Force

# 或使用 Tomcat 自带脚本（在安装目录下）
& "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\shutdown.bat"
Start-Process -FilePath "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\startup.bat"
```

4. 在浏览器中访问：

- 入口页面： http://localhost:8080/exp04/

如果 `index.html` 中包含示例链接（如在线人数、会话显示等），按页面提示操作即可。

## 如何测试会话行为（常用示例）

- 在线人数统计：打开多个不同浏览器或使用无痕/隐私窗口分别访问页面，观察在线人数是否随新会话增加而变化；关闭或手动失效会话后，人数应减少。
- 会话属性读写：提交表单将数据写入 Session（通常通过 JSP/Servlet），然后在其他页面读取并展示。
- 会话失效测试：通过调用 `session.invalidate()` 或等待超时（默认 30 分钟）来测试会话失效处理逻辑。

## 如果你想查看实现细节

- 打开 `src/` 下的 Servlet/Java 源文件，查找 `HttpSession`、`session.setAttribute`、`session.getAttribute`、`session.invalidate()` 等关键用法。
- `WEB-INF/web.xml`（如存在）可能含有会话相关参数或 Servlet 映射。
- 实验说明和任务要求见 `实验4--会话管理.doc`，建议先阅读该文档再按步骤操作。

## 常见问题与排查

- 页面访问 404：确认 `exp04` 是否已正确放在 Tomcat 的 `webapps` 下，且 Tomcat 已重启完成。
- 无法统计在线人数或人数不准确：
  - 检查是否在每个请求/登录逻辑中正确创建并登记会话（例如在 HttpSessionListener 中维护计数）。
  - 浏览器可能复用会话（相同浏览器窗口通常共享 session），使用无痕或不同浏览器进行测试以模拟不同用户。
- 页面报错 500 或 JSP 编译错误：查看 Tomcat 日志（`logs\catalina.*.log`、`logs\localhost.*.log`）并根据异常堆栈定位问题。

## 安全与注意事项

- 在生产环境中不要把调试用的 JSP 页面或会暴露敏感信息的测试页面公开。
- 会话信息不要存放敏感数据（如明文密码）。如需存储敏感数据，应使用服务器端更安全的存储和传输加密。

## 建议改进

- 将会话管理的统计逻辑放到 `HttpSessionListener` 中集中处理，减少重复代码。
- 在 `WEB-INF` 下添加 README 或注释，说明每个 Servlet/JSP 的作用，便于维护。
- 增加单元/集成测试（例如使用 MockHttpSession）来验证关键逻辑。