> AI生成，没有核对，仅供参考，欢迎PR指正。

# 实验五

## 项目简介

`exp05` 是一个基于 Java Web (JSP/Servlet) 的练习/示例工程，包含与数据库交互的示例页面（增删改查）、表单提交与简单页面展示。该目录下包含多个 JSP 页面、示例 SQL 文件以及必要的 Web 配置（`WEB-INF`）。

## 目录结构（节选）

- `index.html` - 本模块入口页面（若存在）。
- `bookInsert.jsp` / `bookQuery.jsp` / `displayBooks.jsp` - 与图书信息相关的增查示例页面。
- `insertCustomer.jsp` / `showCustomer.jsp` / `editCustomer.jsp` - 与客户信息相关的示例页面。
- `test_db_connection.jsp` - 数据库连接测试页（用于快速验证 DB 配置）。
- `test.sql` - 示例数据库脚本（可以用于初始化测试数据）。
- `META-INF/`, `WEB-INF/` - Java Web 必要目录（部署描述、类/库、配置等）。
- `src/` - 源代码（如有）。

> 注：此 README 仅汇总 `exp05` 目录的使用与部署说明，具体业务逻辑请查看对应 JSP/Java 源文件。

## 运行环境与依赖

- Java 8+（与当前 Tomcat 版本兼容的 JDK）
- Apache Tomcat 9.x（或兼容的 Servlet 容器）
- MySQL 5.7 / 8.0 或兼容的关系型数据库
- JSP/Servlet 支持（由 Tomcat 提供）

## 数据库初始化

1. 查看 `test.sql` 以确认数据库名、表结构与示例数据。根据脚本内容，决定是否创建新数据库或将数据导入到已有数据库中。

2. 使用 MySQL 客户端导入示例数据（在 PowerShell 下执行）：

```powershell
# 假设 MySQL 客户端在 PATH 中，且需要输入密码
# 请根据 test.sql 中的数据库名与路径修改命令
mysql -u root -p < "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exp05\test.sql"
```

如果 `test.sql` 内包含 `CREATE DATABASE` 语句，上面的命令会创建并导入到该数据库；如果没有，请先创建数据库再导入：

```powershell
mysql -u root -p -e "CREATE DATABASE exp05db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -p exp05db < "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exp05\test.sql"
```

3. 检查数据库连接配置：
   - 打开 `test_db_connection.jsp`（或项目源码中负责获取 DB 连接的文件），确认 JDBC URL、用户名与密码是否与导入的数据库一致。
   - 如果工程使用连接池或 `context.xml`（在 `META-INF` 或 Tomcat 的 `conf` 中），请同步修改相应配置。

### 数据库脚本细节（来自 `test.sql`）

- `test.sql` 在本目录下，脚本创建并使用数据库 `test`（含 `CREATE DATABASE test;`）。
- 脚本创建了表 `books`，字段包括 `bookid`, `title`, `author`, `publisher`, `price`，并插入了若干示例图书记录；`contextListenerTest.jsp` 与其他页面可能基于该表进行查询。
- 脚本还创建了 `customer` 表，字段包括 `custName`, `email`, `phone`，并插入示例客户数据；`test_db_connection.jsp` 会检查 `customer` 表是否存在。

请在导入前阅读 `test.sql` 并在安全的测试环境中执行（脚本会创建数据库并插入数据）。

## 部署说明（Windows + Tomcat）

1. 将整个 `exp05` 文件夹放到 Tomcat 的 `webapps` 目录下（看起来你当前工作目录就是 Tomcat 的 `webapps`）。

2. 重启 Tomcat（两种常见方法）：

- 使用 Tomcat 服务（若安装为 Windows 服务）：

```powershell
Restart-Service -Name "Tomcat9" -Force
# 如果服务名不同，请替换为实际服务名
```

- 或使用 Tomcat 自带脚本（停止并启动）：

```powershell
& "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\shutdown.bat"
Start-Process -FilePath "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\startup.bat"
```

3. 访问示例页面（默认端口 8080）：

- 主页或入口： http://localhost:8080/exp05/
- 数据库测试页： http://localhost:8080/exp05/test_db_connection.jsp

> 如果部署后看不到页面，请检查 Tomcat 日志（`logs\catalina.out` 或 Windows 事件查看器）以获取错误信息。

## 文件说明（关键文件）

- `index.html`：模块入口，可能包含示例链接。
- `bookInsert.jsp`：图书插入页面（表单 + 后端插入逻辑）。
- `bookQuery.jsp`：以查询方式展示图书或执行检索的示例。
- `displayBooks.jsp`：用于展示查询结果的页面模板。
- `insertCustomer.jsp` / `editCustomer.jsp` / `showCustomer.jsp`：客户信息相关的增改查演示页面。
- `test_db_connection.jsp`：用于快速验证 JDBC 配置与数据库连通性的页面。
- `test.sql`：示例 SQL，包含建表与测试数据（请在导入前阅读并根据实际情况调整用户名/数据库名）。
- `WEB-INF/web.xml`（如存在）：Web 应用的部署描述，入口 Servlet 映射或错误页面配置可能在此处。

## 常见问题与故障排查

- 页面报错 500 或 JSP 编译错误：检查 Tomcat 日志 `logs\localhost.*.log` 与 `logs\catalina.*.log`，定位具体的异常堆栈。
- 数据库连接失败：
  - 检查 MySQL 是否启动并接受远程/本地连接。
  - 确认 JDBC URL、用户名、密码和驱动（通常 Tomcat 自带 MySQL 驱动，或放在 `WEB-INF/lib` 下）。
  - 在 `test_db_connection.jsp` 中打印异常信息以便定位（仅在开发环境）。
- 资源（CSS/JS/图片）加载失败：确认资源路径是否正确，相对路径与部署上下文 (`/exp05/`) 一致。

## 安全与注意事项

- README 示例中的数据库用户名/密码请不要用于生产环境。示例仅用于本地学习与测试。
- 在公开环境中不要把 `test_db_connection.jsp` 这样会泄露数据库错误/配置信息的调试页面保留在可访问位置。

## 可选改进（建议）

- 将数据库连接抽取到连接池（Tomcat Resource）并在 `context.xml` 中配置，提高性能与可维护性。
- 添加更完整的 `README`，包括每个 JSP 的输入/输出示例截图或参数说明。
- 为关键后端逻辑添加单元测试或集成测试（使用 Mock JDBC 或内存数据库）。