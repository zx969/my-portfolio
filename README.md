# 个人作品集（my-portfolio）

极简静态个人作品集网站：纯 HTML / CSS / JS，无框架、无构建步骤、手机端适配。
部署于 **Cloudflare Pages**，源码托管在 **GitHub**。

- 线上地址：`https://my-portfolio.pages.dev`（首次部署后生效）
- GitHub：<https://github.com/zx969/my-portfolio>

```
.
├── index.html          # 单页：关于我 / 项目经历 / 实习经历 / 人生支点 / 联系方式
├── assets/
│   ├── styles.css      # 全部样式（含深色模式、响应式断点 720px / 1000px）
│   ├── main.js         # 移动端菜单、滚动高亮、出现动画、年份
│   └── favicon.svg     # 站点图标
├── deploy.cmd          # 一键部署到 Cloudflare Pages
├── package.json        # 只用于安装 wrangler（部署工具），页面本身不需要构建
└── README.md
```

---

## 一、先把占位符换成你的真实内容

页面里所有待填内容都写成 `【...】` 形式，全局搜索 `【` 即可逐条替换（当前还有 53 种、74 处）。

| 位置 | 占位符 | 说明 |
| --- | --- | --- |
| 首屏 / 关于我 / 页脚 | 已填：郑翔、湖北师范大学 · 人工智能与计算机学院、2404 班 | 不需要再改 |
| `<meta name="description">`、og 标签 | `【一句话自我介绍】` | 1~2 句，影响分享卡片 |
| 首屏副文案 | `【用 2~3 句话介绍自己…】` | 2~3 句 |
| 首屏数据 | `【N】` | 项目数、实习数、支点数 |
| 关于我 | `【第一段…】` `【第二段…】` `【第三段…】` | 三段自我介绍 |
| 关于我 | `【技能 1】`~`【技能 6】` | 技术栈标签 |
| 关于我 | `【城市】` `【例如：在读，寻找 2026 暑期实习】` | 基本信息 |
| 项目经历 | `【项目一名称】` 等 | 3 个项目，卡片可复制/删除 |
| 实习经历 | `【公司 / 团队名称】` 等 | 2 段，没有可整块删掉 |
| 人生支点 | `【支点一】`~`【支点六】` | 6 条（要求 5~8 条），可增删 `.pillar` |
| 联系方式 | `【你的邮箱】` `【你的 GitHub 用户名】` `【微信号…】` `【简历链接】` | 只放愿意公开的渠道 |

### 隐私红线（重要）

站点是**公开可访问**的，以下内容不要写进页面：

- 学号、身份证号、手机号、家庭住址、家庭收入/欠债等财务信息
- 家人姓名与联系方式
- 证件照片、聊天记录截图

需要给人看但不能公开的信息，放进简历 PDF 单独发送。

---

## 二、本地预览

```powershell
python -m http.server 4321     # 或： npx --yes serve .
```

浏览器打开 <http://localhost:4321>，改完刷新即可（无构建）。
按 F12 → 设备工具栏可检查 375px（iPhone）宽度下的排版。

---

## 三、更新并上线（日常只需要这两步）

```powershell
# 1) 提交到 GitHub
git add -A
git commit -m "update: 填写了项目经历"
git push

# 2) 部署到 Cloudflare Pages（双击 deploy.cmd 也可以）
.\deploy.cmd
```

`deploy.cmd` 做的事：把 `index.html` + `assets/` 复制到临时目录 `_deploy/`（避免把 `.git`、`node_modules` 传上去）→ 用 wrangler 上传 → 打印新的线上地址。
每部署一次会生成一个新地址（形如 `https://<hash>.my-portfolio.pages.dev`），生产地址始终是 `https://my-portfolio.pages.dev`。

---

## 四、首次部署记录（已经做过的事，换电脑时才需要重做）

1. `npm install` —— 安装 wrangler（部署工具）。
2. 登录 Cloudflare：`npx wrangler login --device`，浏览器里打开提示的链接、输入设备码授权。
   登录凭据保存在项目内的 `.cf-config/`（已在 `.gitignore` 中，**不要把整个文件夹打包发给别人**）。
3. 创建 Pages 项目：`npx wrangler pages project create my-portfolio --production-branch=main`
4. 部署：`.\deploy.cmd`

> 若第 3 步报 `Your user email must been verified`，说明 Cloudflare 账号邮箱还没验证：
> 去注册邮箱（`3286505484@qq.com`）点 Cloudflare 的验证链接，或在 Cloudflare 控制台右上角重新发送验证邮件，之后重试即可。

---

## 五、技术说明

- 无框架、无外链字体/CDN，离线也能打开；首屏只有 HTML + 一份 CSS + 一份 JS。
- 响应式：`720px`（卡片两列）、`1000px`（横向导航，隐藏汉堡按钮）。
- 支持 `prefers-color-scheme: dark`（跟随系统深色模式）与 `prefers-reduced-motion`。
- 无障碍：跳转主要内容链接、`aria-expanded` 菜单状态、可见焦点框。
- `.cf-config/`、`node_modules/`、`_deploy/`、`_tools/` 均不会提交到仓库。
