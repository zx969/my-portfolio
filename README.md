# 个人作品集（my-portfolio）

极简静态个人作品集网站：纯 HTML / CSS / JS，无框架、无构建步骤、手机端适配。
部署目标：Cloudflare Pages。

```
.
├── index.html          # 单页：关于我 / 项目经历 / 实习经历 / 人生支点 / 联系方式
├── assets/
│   ├── styles.css      # 全部样式（含深色模式、响应式断点 720px / 1000px）
│   ├── main.js         # 移动端菜单、滚动高亮、出现动画、年份
│   └── favicon.svg     # 站点图标
└── README.md
```

## 一、先把占位符换成你的真实内容

页面里所有需要你填的地方都写成 `【...】` 形式。用编辑器全局搜索 `【` 就能逐条替换。

| 位置 | 占位符 | 说明 |
| --- | --- | --- |
| `<title>` / og 标签 / 顶栏 / 首屏 / 页脚 | `【姓名】` | 你的名字或昵称 |
| 首屏 | `【身份标签…】` | 例如"计算机科学与技术 · 2024 级" |
| 首屏 / og 标签 | `【一句话自我介绍…】` | 1~2 句 |
| 首屏副文案 | `【用 2~3 句话介绍自己…】` | 2~3 句 |
| 首屏数据 | `【N】` | 项目数、实习数、支点数 |
| 关于我 | `【第一段…】` `【第二段…】` `【第三段…】` | 三段自我介绍 |
| 关于我 | `【技能 1】`~`【技能 6】` | 技术栈标签 |
| 关于我 | `【城市】` `【学校或公司】` `【状态…】` | 基本信息 |
| 项目经历 | `【项目一名称】` 等 | 3 个项目（可增删 `.card`） |
| 实习经历 | `【公司 / 团队名称】` 等 | 2 段（可增删 `.timeline-item`） |
| 人生支点 | `【支点一】`~`【支点六】` | 5~8 条，按需增删 `.pillar` |
| 联系方式 | `【你的邮箱】` `【你的 GitHub 用户名】` `【微信号…】` | 只放愿意公开的渠道 |

### 隐私红线（重要）

这个站点是**公开可访问**的，以下内容不要写进页面：

- 学号、身份证号、手机号、家庭住址、家庭收入/欠债等财务信息
- 家人姓名与联系方式
- 任何证件照片、聊天记录截图

需要私发给人看的信息，写在简历 PDF 里单独发送。

## 二、本地预览

任选一种（都只是起个静态服务器，不会上传任何东西）：

```powershell
# 方式 A：Python
python -m http.server 4321

# 方式 B：Node
npx --yes serve .
```

然后浏览器打开 <http://localhost:4321>。改完文件刷新即可，无需构建。
按 F12 → 切换设备工具栏，可以检查 375px（iPhone）宽度下的排版。

## 三、部署到 Cloudflare Pages（首次）

```powershell
# 1. 登录 Cloudflare（会弹出浏览器，需要你本人授权）
npx wrangler login

# 2. 首次部署（会创建名为 my-portfolio 的 Pages 项目）
npx wrangler pages deploy . --project-name=my-portfolio --branch=main
```

部署成功后命令行会打印形如 `https://my-portfolio.pages.dev` 的地址。

## 四、以后更新内容（常用命令）

```powershell
# 1) 本地改文件（index.html / assets/*）
# 2) 提交到 GitHub
git add -A
git commit -m "update: 修改说明"
git push

# 3) 重新部署到 Cloudflare Pages
npx wrangler pages deploy . --project-name=my-portfolio --branch=main
```

> 如果给 Pages 项目绑定了 Git 仓库，第 3 步可以省掉：`git push` 之后 Cloudflare 会自动重新部署。

## 五、技术说明

- 无框架、无外链字体/CDN，离线也能打开；首屏只有 HTML + 一份 CSS + 一份 JS。
- 响应式断点：`720px`（两列 / 三列网格）、`1000px`（横向导航，隐藏汉堡按钮）。
- 支持 `prefers-color-scheme: dark`（跟随系统深色模式）与 `prefers-reduced-motion`。
- 无障碍：跳转链接、`aria-expanded` 菜单状态、可见焦点框。
