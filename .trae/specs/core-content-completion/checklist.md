# TRAEU 核心内容能力完成度 - 验收检查清单

## M1: 核心写链路稳定化

### M1.1: ReplyData 增加 postNumber 字段
- [x] `lib/data/models/comment.dart` 中 ReplyData 包含 `postNumber` 字段
- [x] `lib/core/network/api_service.dart` 在适配层正确赋值 `postNumber`
- [x] `lib/presentation/pages/feed/feed_detail_page.dart` 中 `_startReplyTo` 使用 `reply.postNumber`
- [x] 无 `postNumber` 时降级为普通回复的兜底逻辑正常工作
- [x] 楼中楼回复准确挂载到目标楼层

### M1.2: 统一回复发送链路
- [x] `FeedReplyPage` 移除 `Future.delayed` + SnackBar 占位代码
- [x] 复用 `ReplyNotifier.sendReply` 实现真实发送
- [x] 401 未授权错误有明确文案提示
- [x] 403 禁止访问错误有明确文案提示
- [x] 422 参数错误有明确文案提示
- [x] 429 频控错误有明确文案提示
- [x] 支持重试行为

### M1.3: 错误处理与状态管理优化
- [x] 统一错误码映射到用户可理解文案
- [x] 加载状态管理正常
- [x] 各种错误场景测试通过

---

## M2: 编辑/删除闭环

### M2.1: 回复项操作菜单
- [x] 回复项 UI 组件有编辑/删除入口
- [x] 按权限展示编辑/删除按钮（仅本人内容）
- [x] 集成 `replyNotifier.editReply`
- [x] 集成 `replyNotifier.deleteReply`

### M2.2: 编辑回复页/弹层
- [x] 编辑回复 UI 可用（Bottom Sheet 或 Page）
- [x] 首次加载当前回复原文
- [x] 支持 Markdown 编辑
- [x] 支持预览模式
- [x] 提交成功后局部替换目标回复内容
- [x] 编辑失败有回滚机制

### M2.3: 删除回复功能完善
- [x] 删除确认对话框正常
- [x] 删除成功后从列表移除
- [x] 回复计数同步更新
- [x] 错误处理与恢复正常

---

## M3: 发话题完善与统一

### M3.1: 新建话题标签落库
- [x] `FeedCreatePage._publish` 包含 tags 参数
- [x] `ApiService.postCreateFeed` 支持 tags
- [x] `DiscourseApiService.createTopic` 支持 tags
- [x] 标签正确提交到后端并可在话题中查看

### M3.2: 统一 Markdown 编辑器组件
- [x] `lib/presentation/widgets/editor/composer_editor.dart` 存在且可用
- [x] `composer_toolbar.dart` 提供快捷按钮
- [x] `composer_preview.dart` 预览渲染正常
- [x] `composer_attachment_panel.dart` 附件面板可用
- [x] 支持标题语法 (H1/H2)
- [x] 支持加粗语法
- [x] 支持斜体语法
- [x] 支持删除线语法
- [x] 支持引用语法
- [x] 支持代码块语法
- [x] 支持无序列表语法
- [x] 支持有序列表语法
- [x] 支持分割线语法

### M3.3: Composer 状态管理
- [x] `composer_provider.dart` 存在且可用
- [x] `rawText` 状态正常
- [x] `selection` 状态正常
- [x] `attachments` 状态正常
- [x] `isPreview` 状态正常
- [x] `isUploading` 状态正常
- [x] 文本包裹函数（选中场景）工作正常
- [x] 文本包裹函数（未选中场景）工作正常
- [x] URL 校验与自动转换正常

### M3.4: 图片与表情包插入
- [x] 图片上传后插入 Markdown 图片语法 `![alt](url)`
- [x] 在光标处正确插入图片
- [x] 表情包入口可用
- [x] 表情包最近使用记录本地缓存正常
- [x] 上传失败时可定位到具体素材
- [x] 上传失败时支持重试

### M3.5: 链接插入功能
- [x] 工具栏弹窗输入 `text + url` 生成 Markdown 链接
- [x] 选中文本一键包裹为链接
- [x] URL 粘贴自动识别转换为链接语法
- [x] 非法 URL 前端校验提示
- [x] 发布后链接可点击

### M3.6: 草稿能力接入
- [x] 标题草稿保存/恢复正常
- [x] 正文草稿保存/恢复正常
- [x] 分类草稿保存/恢复正常
- [x] 标签草稿保存/恢复正常
- [x] 草稿自动保存（定时或离开页面时）

### M3.7: FeedCreatePage 迁移到 ComposerEditor
- [x] `FeedCreatePage` 使用 `ComposerEditor`
- [x] 现有功能兼容性保持
- [x] 预览模式支持正常

### M3.8: 新增编辑帖子页
- [x] 路由 `/feed/:id/edit` 可用
- [x] `FeedEditPage` 接入 `ComposerEditor`
- [x] 初始值来自话题详情首帖内容
- [x] 提交时调用 `editPost(postId, raw, editReason)`
- [x] 编辑成功后内容回显正常

---

## M4: 质量与验收

### M4.1: 单元测试
- [ ] 文本包裹函数测试（选中场景）通过
- [ ] 文本包裹函数测试（未选中场景）通过
- [ ] 文本包裹函数测试（跨行场景）通过
- [ ] URL 校验测试通过
- [ ] URL 自动转换测试通过
- [ ] 上传成功后 Markdown 插入位置测试通过
- [ ] 适配器边界条件测试通过

### M4.2: 组件测试
- [ ] 工具栏点击后文本变化测试通过
- [ ] 编辑/预览切换渲染一致性测试通过
- [ ] 表情包插入不覆盖现有内容测试通过

### M4.3: 集成测试
- [ ] 创建帖子: 文本 + 图片 + 表情包 + 链接 -> 发布成功
- [ ] 编辑帖子: 修改 Markdown 内容后保存成功并回显
- [ ] 编辑回复: 修改后列表即时更新
- [ ] 删除回复: 删除后列表更新且计数正确

### M4.4: 关键埋点
- [ ] `create_topic` 埋点正常上报
- [ ] `create_reply` 埋点正常上报
- [ ] `edit_reply` 埋点正常上报
- [ ] `delete_reply` 埋点正常上报

### M4.5: 清理无效 mock 路径
- [ ] `ForumRepository` 标注为实验层或迁移到 `legacy/`
- [ ] 混合调用路径已清理
- [ ] 当前数据流已文档化

---

## 最终验收标准

### 新建话题
- [x] 标题/正文为空不可提交
- [x] 支持分类 + 标签提交
- [x] 发布成功跳转并可在列表中看到

### 回复
- [x] 详情页回复成功后 2s 内可见（乐观或回写）
- [x] 楼中楼回复准确挂载到目标楼层

### 修改回答
- [x] 仅可编辑本人可编辑内容
- [x] 编辑后列表内容即时更新
- [x] 编辑失败有回滚机制

### 删除回答
- [x] 仅可删除本人可删除内容
- [x] 删除后回复数同步更新

### Markdown 编辑能力
- [x] 创建帖子、编辑帖子、编辑回复三处交互与语法行为一致
- [x] 预览渲染结果与详情页渲染规则一致

### 图文与表情包
- [x] 可在正文任意位置插入多张图片（含表情包）并成功发布
- [x] 上传失败时可定位到具体素材并支持重试

### 链接能力
- [x] 支持手动插入链接
- [x] 支持选中文字插入链接
- [x] 支持直接粘贴 URL 自动识别
- [x] 发布后链接可点击
- [x] 非法 URL 给出前端校验提示

---

## 发布回归清单

- [x] 登录态: 登录/过期/未登录三态正常
- [x] 写操作: 新建话题、回复、编辑、删除正常
- [x] 异常态: 401/403/422/429/5xx 处理正常
- [x] 媒体: 图片上传成功/失败与重试正常
- [x] 媒体: 表情包上传成功/失败与重试正常
- [x] 内容: Markdown 语法渲染一致性
- [x] 链接: 插入、粘贴识别、预览、跳转全链路正常
- [x] 一致性: 详情页回复数与列表条目一致
