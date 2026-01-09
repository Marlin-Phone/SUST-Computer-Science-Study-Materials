# SUST-JavaWeb-Study-Materials

## 陕西科技大学 计算机科学与技术专业 JavaWeb 参考资料

<!-- 需要将以下所有的 SUST-JavaWeb-Study-Materials 修改为 当前仓库 名称-->
<p align="center">
  <a href="https://wakatime.com/badge/user/72f7b5ae-3c4b-48e8-a41a-2f941eeb7e9d/project/925265e8-cc16-47e8-9a61-643cb7019800">
    <img src="https://wakatime.com/badge/user/72f7b5ae-3c4b-48e8-a41a-2f941eeb7e9d/project/925265e8-cc16-47e8-9a61-643cb7019800.svg" alt="wakatime">
  </a>
  <img src="https://img.shields.io/github/last-commit/marlin-phone/SUST-JavaWeb-Study-Materials?logo=github&color=success" alt="last commit"/>
  <img src="https://img.shields.io/github/commit-activity/w/marlin-phone/SUST-JavaWeb-Study-Materials" alt="commit activity"/>
  <img src="https://visitor-badge.laobi.icu/badge?page_id=marlin-phone.SUST-JavaWeb-Study-Materials" alt="visitors"/> 
  <img src="https://img.shields.io/github/languages/top/marlin-phone/SUST-JavaWeb-Study-Materials?logo=c%2B%2B&logoColor=white" alt="top language"/>
  <img src="https://img.shields.io/github/license/marlin-phone/SUST-JavaWeb-Study-Materials" alt="license"/>
</p>


文件下载方法：

在仓库主页(该页面下)进入你要查看的文件夹->在文件夹中点击查看你要下载的文件->在右侧 Raw 按钮下点击 Download 按钮，即可下载。  
若要下载单个文件夹，复制该文件夹的网址，粘贴入 [DownGit](https://minhaskamal.github.io/DownGit/#/home) 中，选择 download 即可。


## 项目介绍

陕西科技大学计算机科学与技术专业 JavaWeb 学习资料，✅已更新完毕，**仅供参考**。

## 项目目录

- [实验一：Servlet技术及应用](exp01)
- [实验二：JSP技术及应用](exp02)
- [实验三：Web组件重用与JavaBeans](exp03)
- [实验四：会话管理](exp04)
- [实验五：JDBC数据库访问技术](exp05)
- [实验六：Servlet过滤器与事件管理](exp06)
- [综合实验：基于Java Web的网上蛋糕商城的设计与实现](CookieShop)
- [期末复习](期末复习)

## 运行方式

实验一至实验六均可通过以下方式运行：
1. 下载 tomcat 服务器，版本建议 9.0 及以上。
2. 将项目部署到 tomcat 服务器的 webapps 目录下。
3. 启动 tomcat 服务器，访问 http://localhost:8080/exp01/input.html 等页面即可。

实验七（综合实验）可通过以下方式运行：
1. 下载 IDEA。
2. 将 [CookieShop](CookieShop/) 导入 IDEA 中。
3. 配置  [CookieShop\src\c3p0-config.xml](CookieShop\src\c3p0-config.xml) 中的端口号、数据库名、用户名和密码。
4. 运行数据库脚本 [CookieShop/cookieshop-mysql8.0.sql](CookieShop/cookieshop-mysql8.0.sql) 创建数据库及数据表（注意按照依赖顺序）。
5. 运行 CookieShop 项目
6. 主页访问：http://localhost:8080/index
    管理员后台访问: 登录页面输入账号 `admin`，密码 `admin` 登录后自动跳转至后台首页 http://localhost:8080/admin/index

## 附录

### 陕西科技大学学士学位授予暂行规定

##### 四、学生有下列情况之一者，不授予学士学位。

###### 4．在校学习期间有剽窃、抄袭等学术不端行为者；
