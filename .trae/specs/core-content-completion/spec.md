# TRAEU 核心内容能力完成度 - 规格文档

## 项目背景

基于 `/Users/jason/Documents/codex/TraeU/traeu/docs/SPECS_CORE_CONTENT_PLAN_2026-04-26.md` 的评估结果，当前项目在"可读 + 部分可写"层面已具备基础闭环，但在"可维护生产闭环"层面仍缺关键拼图。

## 当前状态评估

### 核心能力完成度评分

| 能力 | 完成度 | 当前状态 |
|---|---|---|
| 新建话题 | 72% | 主入口可用，支持标题/正文/分类/图片上传后发布；但标签未落库、草稿缺失、部分功能为占位 |
| 话题内评论/回复 | 78% | 详情页可直接发送回复并刷新列表；支持图片上传与基本错误提示 |
| 独立回复页（/feed/:id/reply） | 20% | 页面存在但仍是"功能开发中"占位实现 |
| 回复编辑（修改回答） | 35% | API/Repository/Provider 具备，但主详情页未接入编辑入口 |
| 回复删除 | 30% | API/Provider 有部分能力，但主流程未接入、调用路径割裂 |
| 楼中楼回复准确性 | 45% | 有回复目标选择，但参数映射疑似错误，存在回复楼层错位风险 |

### 关键发现（按优先级）

#### P0
1. **楼中楼参数语义风险**: 回复目标参数使用 `reply.id`，但 Discourse `reply_to_post_number` 语义通常是楼层号 `post_number`
2. **编辑/删除能力未接入主链路**: API 与 Provider 有实现，但详情页当前回复项未暴露编辑/删除入口

#### P1
3. **新建话题标签未提交**: UI 维护 `_selectedTags`，发布请求未包含 `tags`
4. **双写体系并存导致维护复杂**: `ApiService`、`FeedDetailPage`、`CommentRepository` 形成混合路径

#### P2
5. **自动化测试偏"Mock 验证"**: 缺真实仓库级回归

## 阶段目标

### M1（1 周）: 核心写链路稳定化
- 修复楼中楼参数语义
- 打通统一回复发送链路
- 下线占位回复页

### M2（1 周）: 编辑/删除闭环
- 将"修改回答/删除回答"从能力层接入到主流程 UI
- 编辑回复页支持 Markdown 语法输入与预览
- 编辑成功后局部回写，不强制全量刷新

### M3（1 周）: 发话题完善与统一
- 新建话题能力从"可发"提升到"可运营"
- 支持图文混排、表情包插入、链接插入与链接预览
- 支持草稿保存/恢复

### M4（0.5-1 周）: 质量与验收
- 新增仓库级测试覆盖核心写链路
- 增加关键埋点
- 发布前回归清单通过

## 需求规格

### Requirement: 楼中楼回复参数修复

**问题**: `_startReplyTo` 使用 `reply.id` 作为 `reply_to_post_number`，但 Discourse API 期望的是楼层号 `post_number`

**解决方案**:
- ReplyData 增加 `postNumber` 字段并在适配层赋值
- `_startReplyTo` 使用 `reply.postNumber` 而非 `reply.id`
- 兜底策略: 无 `postNumber` 时降级为普通回复

### Requirement: 统一回复发送链路

**问题**: `/feed/:id/reply` 页面仍是"功能开发中"占位实现

**解决方案**:
- 复用 `ReplyNotifier.sendReply`
- 移除 `Future.delayed` + SnackBar 占位逻辑
- 失败场景（401/403/422/429）都有明确文案与可重试行为

### Requirement: 回复编辑/删除 UI 接入

**问题**: API/Provider 有实现，但主流程 UI 未接入

**解决方案**:
- 在当前详情页回复项中添加更多操作菜单（按权限展示）
- 直接调用 `replyNotifier.editReply/deleteReply`
- 编辑回复页支持 Markdown 语法输入与预览
- 编辑成功后局部替换目标回复内容，保留失败回滚
- 删除成功后从列表移除并修正回复计数

### Requirement: 新建话题标签落库

**问题**: UI 维护 `_selectedTags`，发布请求未包含 `tags`

**解决方案**:
- `FeedCreatePage._publish` 增加 tags 参数
- `ApiService.postCreateFeed`、`DiscourseApiService.createTopic` 扩展 tags 支持

### Requirement: 统一 Markdown 编辑器

**范围**:
- 新建话题页 `FeedCreatePage`
- 编辑帖子页（新增）
- 编辑回复页/弹层（新增）

**能力**:
- Markdown 基础语法: 标题、加粗、斜体、删除线、引用、代码块、列表、分割线
- 链接: 手动插入 `[text](url)`、选中文本一键包裹、URL 粘贴自动识别
- 图片: 上传后插入 Markdown 图片语法，支持图文混排
- 表情包: 作为图片上传并插入 Markdown（与普通图片同链路，UI 入口分离）

### Requirement: 草稿能力

**问题**: 新建话题页缺少草稿保存/恢复

**解决方案**:
- 参考 `reply_provider` 的草稿机制
- 至少支持标题+正文+分类+标签的草稿保存/恢复

## 技术实现建议

### 组件层
- 新增: `lib/presentation/widgets/editor/composer_editor.dart`
- 子组件:
  - `composer_toolbar.dart`
  - `composer_preview.dart`
  - `composer_attachment_panel.dart`

### 状态层
- 新增: `composer_provider.dart`
- 状态字段建议:
  - `rawText`
  - `selection`
  - `attachments`
  - `isPreview`
  - `isUploading`

### 页面接入
- `FeedCreatePage` 迁移到 `ComposerEditor`
- 新增 `FeedEditPage` 接入 `ComposerEditor`
- 回复编辑入口接入 `ComposerEditor`（sheet 或 page 二选一，优先 sheet）

## 验收标准

1. **新建话题**
   - 标题/正文为空不可提交
   - 支持分类 + 标签提交
   - 发布成功跳转并可在列表中看到

2. **回复**
   - 详情页回复成功后 2s 内可见（乐观或回写）
   - 楼中楼回复准确挂载到目标楼层

3. **修改回答**
   - 仅可编辑本人可编辑内容
   - 编辑后列表内容即时更新，保留编辑失败回滚

4. **删除回答**
   - 仅可删除本人可删除内容
   - 删除后回复数同步更新

5. **Markdown 编辑能力**
   - 创建帖子、编辑帖子、编辑回复三处交互与语法行为一致
   - 预览渲染结果与详情页渲染规则一致

6. **图文与表情包**
   - 可在正文任意位置插入多张图片（含表情包）并成功发布
   - 上传失败时可定位到具体素材并支持重试

7. **链接能力**
   - 支持手动插入链接、选中文字插入链接、直接粘贴 URL 自动识别
   - 发布后链接可点击，非法 URL 给出前端校验提示

## 发布回归清单

- 登录态: 登录/过期/未登录三态
- 写操作: 新建话题、回复、编辑、删除
- 异常态: 401/403/422/429/5xx
- 媒体: 图片上传成功/失败与重试
- 媒体: 表情包上传成功/失败与重试
- 内容: Markdown 语法渲染一致性
- 链接: 插入、粘贴识别、预览、跳转全链路
- 一致性: 详情页回复数与列表条目一致
