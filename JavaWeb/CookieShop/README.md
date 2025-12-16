> 运行该项目前必须将 [CookieShop/src/c3p0-config.xml](src/c3p0-config.xml) 中数据库的端口、数据库名、账号及密码修改为你本地的配置，否则无法连接数据库。
> 进入的方法是在登录界面输入账号 `admin`，密码 `admin`后跳转至后台首页 http://localhost:8080/admin/index

---

> AI生成，没有核对，仅供参考，欢迎PR指正。

# CookieShop - 项目概览（基于仓库中实际文件）

本 README 严格基于 `CookieShop` 目录下存在的文件编写，不做未核对的实现推断。主要依据的文件包括：

- `cookieshop-mysql8.0.sql`（仓库根） — MySQL 导入脚本，包含数据库 `cookieshop` 的建表与大量示例数据（goods、order、orderitem、recommend、type、user 等表）。
- `test.sql`（仓库根） — 另一个 SQL 文件（存在于仓库根，供参考）。
- `web/` — 前端页面目录，包含 `index.jsp`, `goods_list.jsp`, `goods_detail.jsp`, `goods_cart.jsp`, `order_submit.jsp` 等多个 JSP 页面；还含 `header.jsp`/`footer.jsp`、静态资源子目录（`css/`、`js/`、`images/`、`picture/`）。
- `src/` — Java 源代码目录，含多个子包：`dao/`, `service/`, `servlet/`, `model/`, `utils/`, `filter/`, `listener/` 等；`src/servlet` 下包含许多 Servlet 源文件（例如 `IndexServlet.java`, `GoodsListServlet.java`, `GoodsDetailServlet.java`, `OrderSubmitServlet.java`, `UserLoginServlet.java` 等）。
- `sql/` 与 `docs/` 目录 — 含额外文档与 SQL，供进一步阅读。

## 主要用途与范围

该项目是一个较完整的示例电商/商品演示应用（CookieShop），仓库已包含：

- 数据库建表与大量示例数据（见 `cookieshop-mysql8.0.sql`）；
- 前端 JSP 页面（商品列表、详情、购物车、下单、用户登录/注册、管理后台页面等）；
- 后端 Servlet、DAO、Service 等实现源码存放在 `src/` 下（项目已包含诸多服务端处理类）。

## 快速部署（在本地 Tomcat 上）

1. 准备数据库：

   - 使用 MySQL 导入脚本 `cookieshop-mysql8.0.sql`（根据你的 MySQL 版本在本地导入）：

```powershell
# 以 Windows PowerShell 为例（请根据本地 MySQL 客户端路径与凭据调整）
mysql -u root -p < "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\CookieShop\cookieshop-mysql8.0.sql"
```

   - 脚本会创建 `cookieshop` 数据库并建立所需表（`goods`, `order`, `orderitem`, `recommend`, `type`, `user` 等），并插入大量示例数据。

2. 部署到 Tomcat：

   - 将整个 `CookieShop` 文件夹复制到 Tomcat 的 `webapps` 目录下（或将 `web/` 中的内容作为 Web 应用的根），确保 `WEB-INF`、`src`、`lib`（如果有）位于正确位置。
   - 启动或重启 Tomcat。访问： `http://localhost:8080/CookieShop/` 或若使用 `web/` 下的 `index.jsp`，访问 `http://localhost:8080/CookieShop/web/`（请以实际部署路径为准）。

3. 检查并修改数据库连接配置：

   - 项目中可能在 `src/` 的配置文件或 `WEB-INF` 下定义了数据库连接（请搜索 `jdbc`, `DataSource`, `c3p0` 等关键词以确认连接位置）。
   - 根据你的 MySQL 实例（host、port、用户名、密码）修改相应配置后重启 Tomcat。

## 重要文件与目录（简要）

- `cookieshop-mysql8.0.sql` — 建库与建表脚本（推荐先阅读并在测试库中导入）；
- `web/` — JSP 前端页面集合（`index.jsp`, `goods_list.jsp`, `goods_detail.jsp`, `goods_cart.jsp`, `user_login.jsp`, `user_register.jsp`, `order_submit.jsp`, `order_success.jsp` 等）；
- `src/servlet` — 主要请求处理 Servlet（见仓库文件列表，包含 `UserLoginServlet`, `UserRegisterServlet`, `GoodsListServlet`, `GoodsDetailServlet`, `OrderSubmitServlet`, 管理相关的 `Admin*Servlet` 等）；
- `src/dao`, `src/service`, `src/model` — 数据访问、业务逻辑与模型类（源码已包含，便于学习与扩展）；
- `sql/` — 可能包含额外 SQL 脚本或迁移脚本；
- `docs/` — 额外文档（请查看以获取更详细的项目说明）。

## 测试与校验建议（基于现有文件）

- 导入 SQL 后，先在数据库中确认 `goods` 与 `user` 表存在并含有示例数据；`
- 启动 Tomcat 并打开主页，逐步测试商品列表、商品详情、加入购物车、下单流程与用户登录/注册；
- 若出现数据库连接错误，请检查后端配置并查看 Tomcat 日志（`logs\catalina.*.log`）以获取详细异常。

## 安全与注意事项

- `cookieshop-mysql8.0.sql` 中包含示例用户与密码（明文），仅用于本地测试；不要直接在生产环境使用示例凭据或把该脚本用于公开数据库。
- 若将项目部署到公共环境，务必更改默认密码、使用连接池与安全的凭据管理策略。