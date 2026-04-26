# GitHub 仓库设置完善指南

## 1. 仓库基本信息设置

访问 `https://github.com/Senkeller/Trae-Forum/settings`

### 基本信息
- **Repository name**: `Trae-Forum` (已设置)
- **Description**: `用 AI 编程工具打造的 Trae 论坛第三方客户端 - 一个探索 AI 辅助开发边界的实验项目`
- **Website**: `https://forum.trae.cn`
- **Topics** (主题标签，点击右侧齿轮添加):
  ```
  flutter
  dart
  trae
  forum
  discourse
  ai-assisted-development
  mobile-app
  cross-platform
  riverpod
  open-source
  ```

### 仓库可见性
- ✅ 保持 **Public** (公开)

---

## 2. 功能启用设置

访问 `https://github.com/Senkeller/Trae-Forum/settings`

### Features (功能)
- ✅ **Issues** - 启用 (允许提交问题)
- ✅ **Discussions** - 启用 (社区讨论)
- ✅ **Projects** - 可选 (项目管理)
- ✅ **Wiki** - 可选 (文档)
- ⬜ **Sponsorships** - 可选 (赞助)

### Pull Requests
- ✅ **Allow merge commits** - 允许合并提交
- ✅ **Allow squash merging** - 允许压缩合并
- ✅ **Allow rebase merging** - 允许变基合并
- ✅ **Always suggest updating pull request branches** - 总是建议更新 PR 分支

---

## 3. 分支保护规则

访问 `https://github.com/Senkeller/Trae-Forum/settings/branches`

### 添加规则 (Add rule)
- **Branch name pattern**: `main`

### 保护规则
- ✅ **Require a pull request before merging** - 合并前需要 PR
  - ✅ **Require approvals** - 需要 1 个审批
  - ✅ **Dismiss stale PR approvals when new commits are pushed** - 新提交时取消旧审批
- ✅ **Require status checks to pass before merging** - 状态检查必须通过
  - 搜索并添加: `Analyze`, `Test`
- ✅ **Require conversation resolution before merging** - 需要解决所有对话
- ✅ **Do not allow bypassing the above settings** - 不允许绕过以上设置

---

## 4. GitHub Pages (可选)

如果想展示项目文档:

访问 `https://github.com/Senkeller/Trae-Forum/settings/pages`

- **Source**: Deploy from a branch
- **Branch**: `main` / `docs` (如果有 docs 文件夹)
- **Folder**: `/docs` 或 `/ (root)`

---

## 5. 社交预览图 (Social Preview)

访问 `https://github.com/Senkeller/Trae-Forum/settings`

上传一张 1280×640 的社交分享图片，建议包含:
- 项目 Logo
- 项目名称
- 简短描述
- 技术栈图标

可以使用 Canva 或 Figma 制作。

---

## 6. 添加项目截图

在 README 中添加应用截图，让访客更直观地了解项目。

### 截图建议
1. **首页/话题列表** - 展示主要功能
2. **话题详情页** - 展示富文本渲染
3. **搜索页面** - 展示搜索功能
4. **用户主页** - 展示用户信息
5. **深色模式** - 展示主题切换

### 截图存放
- 创建 `screenshots/` 文件夹
- 或者放在 `assets/screenshots/`
- 在 README 中引用:
  ```markdown
  ## 应用截图

  <p align="center">
    <img src="screenshots/home.png" width="200" alt="首页">
    <img src="screenshots/topic.png" width="200" alt="话题详情">
    <img src="screenshots/search.png" width="200" alt="搜索">
  </p>
  ```

---

## 7. 创建 Release (发布版本)

当项目准备好发布时:

访问 `https://github.com/Senkeller/Trae-Forum/releases`

### 创建新 Release
1. 点击 **Draft a new release**
2. **Choose a tag**: `v1.0.0` (输入后点击 "Create new tag")
3. **Release title**: `v1.0.0 - 初始发布`
4. **Describe this release**: 复制 CHANGELOG.md 中的内容
5. 上传 APK/IPA 文件 (可选)
6. 点击 **Publish release**

---

## 8. 启用 GitHub Discussions

访问 `https://github.com/Senkeller/Trae-Forum/discussions`

### 创建分类 (Categories)
建议创建以下讨论分类:

1. **💡 功能建议** (Ideas)
   - 新功能提议
   - 改进建议

2. **❓ 问答** (Q&A)
   - 使用问题
   - 技术问题

3. **💬 一般讨论** (General)
   - 随意交流
   - 经验分享

4. **🤖 AI 编程交流** (Show and tell)
   - AI 辅助开发经验
   - 工具使用心得

---

## 9. 添加协作者 (可选)

如果有朋友一起维护项目:

访问 `https://github.com/Senkeller/Trae-Forum/settings/access`

点击 **Add people**，输入 GitHub 用户名，选择权限级别:
- **Read**: 只读
- **Triage**: 可以管理 Issue 和 PR
- **Write**: 可以推送代码
- **Maintain**: 可以管理仓库设置
- **Admin**: 完全控制

---

## 10. 检查清单

设置完成后，检查以下项目:

- [ ] 仓库描述已填写
- [ ] 主题标签已添加 (5-10 个)
- [ ] Issues 功能已启用
- [ ] Discussions 功能已启用
- [ ] 分支保护规则已配置
- [ ] README 显示正常
- [ ] LICENSE 显示正常
- [ ] CI/CD 工作流运行正常
- [ ] 社交预览图已上传 (可选)
- [ ] 应用截图已添加 (可选)

---

## 快速链接

| 功能 | 链接 |
|------|------|
| 仓库设置 | https://github.com/Senkeller/Trae-Forum/settings |
| 分支保护 | https://github.com/Senkeller/Trae-Forum/settings/branches |
| 协作者管理 | https://github.com/Senkeller/Trae-Forum/settings/access |
| Webhooks | https://github.com/Senkeller/Trae-Forum/settings/hooks |
| 发布管理 | https://github.com/Senkeller/Trae-Forum/releases |
| 讨论区 | https://github.com/Senkeller/Trae-Forum/discussions |

---

完成以上设置后，你的开源项目就更加专业和完善了！
