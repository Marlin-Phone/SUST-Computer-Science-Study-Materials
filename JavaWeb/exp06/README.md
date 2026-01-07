> 运行该项目前必须将 [exp06/WEB-INF/classes/db_config.properties](WEB-INF/classes/db_config.properties) 中数据库的端口、数据库名、账号及密码修改为你本地的配置，否则无法连接数据库。

---

> 以下内容由AI生成，没有核对，仅供参考，欢迎PR指正。

# exp06 - 实验六：Servlet 过滤器与事件处理（会话/请求/上下文监听器）

## 概述（基于仓库中实际文件）
本 README 严格基于 `exp06` 目录中的现有文件编写，不做杜撰。已核对的文件包括：

- `index.html` - 实验首页，包含三个实验项的入口链接。
- `contextListenerTest.jsp` - 测试 ServletContext 监听器并从 `ServletContext` 读取数据库连接（属性名：`dataSource`），执行查询 `SELECT bookId, title, author, price, publisher FROM books`。
- `onlineCount.jsp` - 展示自应用启动以来 `onlineCount.jsp` 的访问计数（使用 `application` 作用域属性 `count`）。
- `sessionDisplay.jsp` - 展示当前 `sessionList`（保存在 `application` 作用域）的在线会话列表，使用 JSTL 遍历显示会话 ID 与创建时间。
- `WEB-INF/web.xml` - 在 web.xml 中显式注册了 3 个监听器：
  - `com.listener.MyServletContextListener`（ServletContextListener）
  - `com.listener.MySessionListener`（HttpSessionListener）
  - `com.listener.MyRequestListener`（ServletRequestListener）
- `WEB-INF/classes/db_config.properties` - 数据库连接配置（`db.url`, `db.user`, `db.password`）。
- `src/com/listener/*.java` - 三个监听器的源码：`MyServletContextListener.java`, `MySessionListener.java`, `MyRequestListener.java`。
- `WEB-INF/lib/` - 包含多个库（包含 `mysql-connector-java` 的若干版本和 JSTL 实现等），因此 JDBC 驱动与 JSTL 已随项目一起提供（见 `WEB-INF/lib`）。

> 注：`实验6--Servlet过滤器与事件处理.doc` 存在于目录中（为 Office 文档），未在此 README 中提取其二进制内容；本 README 内容来自项目可读源码与 JSP 文件。

## 目的与功能要点（从源码推断）
- `MyServletContextListener` 在 web 应用启动时读取 `WEB-INF/classes/db_config.properties`，创建一个 `java.sql.Connection` 并把该连接对象放入 `ServletContext` 属性 `dataSource`，供 JSP（如 `contextListenerTest.jsp`）使用。应用销毁时关闭该连接并从上下文移除属性。
- `MyRequestListener` 在每次请求初始化时检测请求 URI，如果是 `onlineCount.jsp`，则从 `ServletContext` 读取/更新整数属性 `count`（访问次数），并记录访问日志（包含 IP）。
- `MySessionListener` 在会话创建时把 `HttpSession` 对象加入 `ServletContext` 下的 `sessionList`（List<HttpSession>），会话销毁时从该列表移除。该列表由 `sessionDisplay.jsp` 读取并显示会话 ID 与创建时间。

## 运行前检查（必做）
1. 确保 Tomcat（此目录下为 Tomcat 9.0）已正确安装并可启动。部署位置为：
   `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exp06`（你当前的路径）。
2. 确保 MySQL 正在运行，且 `WEB-INF/classes/db_config.properties` 中的 `db.url`, `db.user`, `db.password` 已根据你的环境正确配置：

   文件路径：
   `WEB-INF/classes/db_config.properties`

   示例（文件内已有，注意替换密码）：
   ```properties
   db.url=jdbc:mysql://localhost:3306/test?serverTimezone=Asia/Shanghai
   db.user=root
   db.password=your_password
   ```

   - 请把 `db.password` 替换为实际密码。
   - `db.url` 指向的数据库应可从应用服务器访问（端口、用户名/密码正确）。
3. 检查 JDBC 驱动：在 `WEB-INF/lib/` 中已包含若干 `mysql-connector-java`，通常无需额外安装；若你改变了驱动版本，请确保类路径中存在兼容的 MySQL 驱动。
4. 检查目标数据库中是否存在 `contextListenerTest.jsp` 查询所需的表与字段：
   - JSP 执行 SQL：`SELECT bookId, title, author, price, publisher FROM books`。
   - 请确保存在对应的 `books` 表并含有这些列（列名与大小写依赖于数据库设置）。本 README 不随意构造表结构；如果需要，我可以基于该查询为你生成一个示例建表 SQL（但需你确认接受）。

## 如何启动与访问（PowerShell 示例）

- 通过 Tomcat 服务重启（示例服务名为 `Tomcat9`，如不同请替换）：

```powershell
Restart-Service -Name "Tomcat9" -Force
```

- 或用脚本重启 Tomcat（在 Tomcat 安装目录下）：

```powershell
& "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\shutdown.bat"
Start-Process -FilePath "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\startup.bat"
```

- 打开浏览器访问实验首页：

  http://localhost:8080/exp06/

## 页面与测试步骤（逐项）

1. 测试 ServletContext 监听器（数据库连接）
   - 打开： http://localhost:8080/exp06/contextListenerTest.jsp
   - 预期行为：页面会尝试从 `application`（ServletContext）获取名为 `dataSource` 的属性并将其视为 `java.sql.Connection`，然后执行 `SELECT bookId, title, author, price, publisher FROM books` 并把结果以表格形式显示。
   - 故障排查：
     - 如果页面显示“错误：无法获取数据库连接，请检查监听器是否正常工作。”，说明 `MyServletContextListener` 未能创建连接或 `db_config.properties` 配置错误；检查 Tomcat 日志（`logs\catalina.*.log`）中 `context.log` 输出以获取具体异常信息。
     - 可能原因：`db_config.properties` 路径或格式错误、MySQL 未启动、JDBC 驱动兼容性问题、数据库无 `books` 表或列名不匹配。

2. 测试页面访问计数（ServletRequestListener）
   - 打开： http://localhost:8080/exp06/onlineCount.jsp
   - 预期行为：页面会显示客户端 IP 与 `application` 作用域中的 `count` 值（表示自应用启动后 `onlineCount.jsp` 被访问的次数）。
   - 实现要点：`MyRequestListener.requestInitialized` 检测 `request.getRequestURI().endsWith("onlineCount.jsp")` 并在 `ServletContext` 增量更新 `count`。
   - 故障排查：若计数不变或为 null，检查 `MyRequestListener` 是否被注册（`WEB-INF/web.xml` 已列出该监听器），以及 `logs` 中的 listener 日志。

3. 测试会话统计（HttpSessionListener）
   - 打开： http://localhost:8080/exp06/sessionDisplay.jsp
   - 预期行为：页面显示 `application` 作用域中 `sessionList` 的当前大小（在线用户数），并列出会话 ID 与创建时间。`MySessionListener` 在 `sessionCreated` 时将 `HttpSession` 添加到 `sessionList`，在 `sessionDestroyed` 时移除。
   - 测试建议：使用不同浏览器或隐私窗口来创建多个会话以观察变化；也可以在控制台手动调用 `session.invalidate()` 的页面（若有）来触发销毁。
   - 故障排查：若 `sessionList` 为 null 或为空，检查 `MySessionListener` 是否在 `web.xml` 中注册或 `sessionCreated` 是否执行成功（查看 Tomcat 日志中的 `创建一个新会话` / `删除一个会话` 日志）。

## 已核对的源码要点（引用自仓库源码）
- `MyServletContextListener`（`src/com/listener/MyServletContextListener.java`）
  - 读取 `WEB-INF/classes/db_config.properties`，通过 `DriverManager.getConnection(url, user, password)` 创建连接，并将 `Connection` 存入 `ServletContext` 属性名为 `dataSource`。
  - 在 `contextDestroyed` 中关闭该连接并移除属性。

- `MyRequestListener`（`src/com/listener/MyRequestListener.java`）
  - 在 `requestInitialized` 中判断请求是否为 `onlineCount.jsp`，若是则从 `ServletContext` 读取整数 `count`、递增、再保存回 `ServletContext` 并写日志（包含 IP 地址和访问次数）。

- `MySessionListener`（`src/com/listener/MySessionListener.java`）
  - 在 `sessionCreated` 时将 `HttpSession` 加入 `sessionList`，若 `sessionList` 不存在则新建并放入 `ServletContext`。
  - 在 `sessionDestroyed` 时从 `sessionList` 中删除对应会话并记录日志。

- `sessionDisplay.jsp` 使用 JSTL（项目已在 `WEB-INF/lib` 中包含 `taglibs`）读取 `applicationScope.sessionList` 并以 `${sess.id}` / `${sess.creationTime}` 显示会话信息。

## 已知限制与建议（非变更，仅建议）
- 当前实现将原始 `java.sql.Connection` 放入 `ServletContext` 并在应用结束时关闭；生产环境应使用连接池（DataSource），不要直接把裸 Connection 放至全局上下文以避免并发与泄露风险。项目中已包含 `commons-dbcp` / `c3p0` 等库，可以考虑改为在 `MyServletContextListener` 中使用连接池并把 DataSource 放入上下文。
- `sessionList` 直接存储 `HttpSession` 对象并在 JSP 中通过 EL 访问其属性，这在教学场景可用，但在复杂系统中应避免直接暴露会话对象，改为存储会话摘要 DTO（例如会话 ID、创建时间、最后访问时间等）更安全、更易序列化。
- `WEB-INF/classes/db_config.properties` 中包含敏感密码，建议不要把明文密码加入源码仓库；改用容器环境变量或 Tomcat 的 `context.xml` 与 JNDI DataSource 更安全。
