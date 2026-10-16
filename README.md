# 个人作品集（my-portfolio）

极简静态个人作品集网站：纯 HTML / CSS / JS，无框架、无构建步骤、手机端适配。

| 项目 | 地址 | 状态 |
| --- | --- | --- |
| **线上地址** | **<https://zx969.github.io/my-portfolio/>** | ✅ 已上线（GitHub Pages，`git push` 后自动更新） |
| GitHub 仓库 | <https://github.com/zx969/my-portfolio> | ✅ public，main 分支 |

```
.
├── index.html          # 单页：关于我 / 项目经历 / 实习经历 / 人生支点 / 联系方式
├── assets/
│   ├── styles.css      # 全部样式（深色模式、响应式断点 720px / 1000px）
│   ├── main.js         # 移动端菜单、滚动高亮、出现动画、页脚年份
│   └── favicon.svg     # 站点图标
├── .nojekyll           # 告诉 GitHub Pages 不要用 Jekyll 处理
├── README.md
└── （可选）Cloudflare 备用部署：wrangler.jsonc / deploy.cmd / deploy-pages.cmd / package.json
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
cd "C:\Users\FIREBAT\Desktop\新建文件夹 (4)"
python -m http.server 4321     # 或： npx --yes serve .
```

浏览器打开 <http://localhost:4321>，改完刷新即可（无构建）。
按 F12 → 设备工具栏可检查 375px（iPhone）宽度下的排版。

---

## 三、更新并上线（日常就三条命令）

```powershell
cd "C:\Users\FIREBAT\Desktop\新建文件夹 (4)"

git add -A
git commit -m "update: 填写了项目经历"
git push
```

推送后 GitHub Pages 会在 1~2 分钟内自动重新发布，直接刷新 <https://zx969.github.io/my-portfolio/> 即可。
（想确认发布状态：仓库页 → **Actions** 或 **Settings → Pages**。）

---

## 四、可选：改用 Cloudflare 部署（当前被账号状态卡住）

如果你想换成 Cloudflare（自定义域名、全球 CDN 等），仓库里已经准备好两条一键命令：

```powershell
npm install          # 安装 wrangler（只需一次）
npx wrangler login --device   # 浏览器输入设备码授权（只需一次）
.\deploy.cmd         # → Cloudflare Workers：https://my-portfolio.zx969.workers.dev
.\deploy-pages.cmd   # → Cloudflare Pages：https://my-portfolio.pages.dev
```

**但现在跑不通**，Cloudflare 服务端拒绝，原文：

- Pages：`HTTP 403` · `code: 8000077` · `Your user email must been verified`
- Workers：`code: 10034` · `You need to verify your email address to use Workers`

已排除 wrangler 版本、网络、项目名、令牌过期（换新令牌仍报错）——用 REST API 直连、完全绕开 wrangler 也是这两个错误码。根因是账号 `3286505484@qq.com`（2026-10-16 17:06 注册）的"邮箱已验证"标记在服务端为否，而 My Profile 里只有 `Update email`、没有 `Send verification email`，属于社区已有案例的账号状态不一致（[10034 无验证入口](https://community.cloudflare.com/t/error-10034-workers-deployment-blocked-but-no-email-verification-option/945945/2)、[8000077 与 10034 同时出现](https://community.cloudflare.com/t/email-verification-mismatch-blocks-workers-pages-10034-8000077/940511/2)）。

想用 Cloudflare 时按顺序做：① 翻 QQ 邮箱（含垃圾箱/订阅邮件）找 Cloudflare 验证邮件并点链接；② <https://dash.cloudflare.com/profile> → **Email** → **Update email** 重填或换一个能收信的邮箱；③ 控制台右上角 **Support** 提工单并附上两个错误码。之后 `.\deploy.cmd` 就能用。

---

## 五、技术说明

- 无框架、无外链字体/CDN，离线也能打开；首屏只有 HTML + 一份 CSS + 一份 JS。
- 响应式：`720px`（卡片两列）、`1000px`（横向导航，隐藏汉堡按钮）。
- 支持 `prefers-color-scheme: dark`（跟随系统深色模式）与 `prefers-reduced-motion`。
- 无障碍：跳转主要内容链接、`aria-expanded` 菜单状态、可见焦点框。
- 自检：静态结构 19 项 + jsdom 交互行为 23 项，全部通过。
- `.cf-config/`、`node_modules/`、`_deploy/`、`_tools/`、`_probe/`、`_npm-cache/`、`my-portfolio-site.zip` 均不会提交到仓库。
