# 个人作品集（my-portfolio）

极简静态个人作品集网站：纯 HTML / CSS / JS，无框架、无构建步骤、手机端适配。

| 项目 | 地址 | 状态 |
| --- | --- | --- |
| 线上地址（现在可用） | <https://zx969.github.io/my-portfolio/> | ✅ GitHub Pages 已上线 |
| GitHub 仓库 | <https://github.com/zx969/my-portfolio> | ✅ public，main 分支 |
| Cloudflare Workers | `https://my-portfolio.zx969.workers.dev` | ⏳ 已配置完成，等账号邮箱验证后 `deploy.cmd` 一键上线 |
| Cloudflare Pages | `https://my-portfolio.pages.dev` | ⏳ 同上，见文末「Cloudflare 部署状态」 |

```
.
├── index.html          # 单页：关于我 / 项目经历 / 实习经历 / 人生支点 / 联系方式
├── assets/
│   ├── styles.css      # 全部样式（深色模式、响应式断点 720px / 1000px）
│   ├── main.js         # 移动端菜单、滚动高亮、出现动画、页脚年份
│   └── favicon.svg     # 站点图标
├── wrangler.jsonc      # Cloudflare Workers 静态资源配置
├── deploy.cmd          # 一键部署到 Cloudflare Workers
├── deploy-pages.cmd    # 一键部署到 Cloudflare Pages（等邮箱验证后可用）
├── package.json        # 只为安装 wrangler（部署工具），页面本身不需要构建
└── README.md
```

---

## 一、先把占位符换成你的真实内容

页面里所有待填内容都写成 `【...】` 形式，全局搜索 `【` 即可逐条替换（当前 **53 种、74 处**）。

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

## 三、更新并上线（日常两条命令）

```powershell
cd "C:\Users\FIREBAT\Desktop\新建文件夹 (4)"

# 1) 提交：GitHub 上的代码更新，同时 GitHub Pages 会自动重新发布
git add -A
git commit -m "update: 填写了项目经历"
git push

# 2) 同步到 Cloudflare（账号邮箱验证通过后可用；双击 deploy.cmd 也一样）
.\deploy.cmd          # → Cloudflare Workers
.\deploy-pages.cmd    # → Cloudflare Pages（可选，二者内容相同）
```

`deploy.cmd` 做的事：把 `index.html` + `assets/` 复制到 `_deploy/`（避免把 `.git`、`node_modules` 传上去）→ 用 wrangler 发布 → 打印线上地址。

---

## 四、Cloudflare 部署状态（当前唯一卡点）

**现象**：Cloudflare 拒绝创建任何 Pages 项目 / 发布任何 Worker，服务端原文：

- Pages：`HTTP 403` · `code: 8000077` · `Your user email must been verified`
- Workers：`code: 10034` · `You need to verify your email address to use Workers`

**已排除的原因**（都实测过）：wranger 版本、网络、项目名、令牌过期（重新登录换新令牌后仍报错）、以及 PowerShell/沙箱环境——用 REST API 直连（完全绕开 wrangler）同样是这两个错误码。

**根因**：账号 `3286505484@qq.com`（2026-10-16 17:06 注册）在 Cloudflare 服务端的"邮箱已验证"标记为否。而 My Profile 页面里只有 `Update email`、没有 `Send verification email`，属于社区里已有多例的账号状态不一致问题（参见 [Error 10034: Workers deployment blocked, but no email verification option](https://community.cloudflare.com/t/error-10034-workers-deployment-blocked-but-no-email-verification-option/945945/2) 与 [Email verification mismatch blocks Workers/Pages (10034, 8000077)](https://community.cloudflare.com/t/email-verification-mismatch-blocks-workers-pages-10034-8000077/940511/2)）。

**解决办法（按推荐顺序）**：

1. **先确认邮箱真的收到过验证邮件**：登录 QQ 邮箱，查收件箱 / 垃圾箱 / 广告邮件 / 订阅邮件，找发件人含 `cloudflare` 的邮件，点里面的验证链接（保持 Cloudflare 已登录状态点）。这一步做完 5 分钟后重试 `deploy.cmd` 即可。
2. **重新触发验证邮件**：<https://dash.cloudflare.com/profile> → **Email** 卡片 → **Update email** → 重新填入同一个邮箱（或换成一个确定能收到 Cloudflare 邮件、且已启用的邮箱，例如 Gmail / 163）→ 提交后 Cloudflare 会往新地址发验证链接 → 点链接完成验证。
3. **联系 Cloudflare 支持**：控制台右上角 **Support** → 提交工单，正文贴上面两行错误码（`8000077` / `10034`）与账号邮箱，说明"My Profile 中没有 Send verification email 入口"。
4. 极端情况可换一个已验证邮箱的账号（例如用 GitHub / Google 登录 Cloudflare，服务商侧邮箱通常视为已验证），然后重新执行 `npx wrangler login --device` 与本 README 第五节的初始化步骤。

验证生效后，`.\deploy.cmd` 会直接产出 `https://my-portfolio.zx969.workers.dev`（workers.dev 子域名 `zx969` 已经注册好了）。

---

## 五、首次部署记录（换电脑时才需要重做）

1. `npm install` —— 安装 wrangler。
2. 登录 Cloudflare：`npx wrangler login --device`，浏览器里打开提示链接输入设备码授权。
   凭据保存在项目内的 `.cf-config/`（已加入 `.gitignore`，**不要把整个文件夹打包发给别人**）。
3. `.\deploy.cmd` 部署 Worker；或 `.\deploy-pages.cmd` 部署 Pages（Pages 需要先能创建项目）。

---

## 六、技术说明

- 无框架、无外链字体/CDN，离线也能打开；首屏只有 HTML + 一份 CSS + 一份 JS。
- 响应式：`720px`（卡片两列）、`1000px`（横向导航，隐藏汉堡按钮）。
- 支持 `prefers-color-scheme: dark`（跟随系统深色模式）与 `prefers-reduced-motion`。
- 无障碍：跳转主要内容链接、`aria-expanded` 菜单状态、可见焦点框。
- `.cf-config/`、`node_modules/`、`_deploy/`、`_tools/`、`_probe/`、`_npm-cache/` 均不会提交到仓库。
