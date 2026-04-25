# TRAEU 核心内容能力完成度分析与最终 Specs 计划

- 评估日期: 2026-04-26
- 评估范围: 新建话题、评论/回复、回复编辑、回复删除、楼中楼回复链路
- 评估方式: 代码走查 + 关键测试运行（`flutter test test/write_operations_test.dart test/integration/core_flows_test.dart`）

## 1. 结论摘要

当前项目在“可读 + 部分可写”层面已具备基础闭环，但在“可维护生产闭环”层面仍缺关键拼图。

- 读链路（列表/详情/回复展示）: 基本可用
- 写链路（发话题/发回复）: 可用但不完整
- 修改/删除（编辑回复、删除回复）: API 层有能力，主流程 UI 未接入
- 楼中楼回复: 存在参数语义风险（可能传 post_id 而非 post_number）

## 2. 核心能力完成度评分

> 评分口径: 0-100%，按“UI入口 + 业务编排 + API落地 + 错误处理 + 测试覆盖”综合评估。

| 能力 | 完成度 | 当前状态 | 关键证据 |
|---|---:|---|---|
| 新建话题 | 72% | 主入口可用，支持标题/正文/分类/图片上传后发布；但标签未落库、草稿缺失、部分功能为占位 | `FeedCreatePage._publish` 已走 `feedRepository.createFeed`；`DiscourseApiService.createTopic` 已实现 |
| 话题内评论/回复 | 78% | 详情页可直接发送回复并刷新列表；支持图片上传与基本错误提示 | `FeedDetailPage._sendComment` -> `CommentRepository.createComment` -> `DiscourseApiService.createPost` |
| 独立回复页（/feed/:id/reply） | 20% | 页面存在但仍是“功能开发中”占位实现 | `FeedReplyPage._sendReply` 中 `Future.delayed` + SnackBar |
| 回复编辑（修改回答） | 35% | API/Repository/Provider 具备，但主详情页未接入编辑入口 | `comment_repository.editComment`/`reply_provider.editReply`；UI处 `TODO` |
| 回复删除 | 30% | API/Provider 有部分能力，但主流程未接入、调用路径割裂 | `comment_repository.deletePost` 存在；列表 UI 删除为 `TODO` |
| 楼中楼回复准确性 | 45% | 有回复目标选择，但参数映射疑似错误，存在回复楼层错位风险 | `FeedDetailPage._startReplyTo` 用 `reply.id` 作为 `reply_to_post_number` |

## 3. 关键发现（按优先级）

### P0

1. 楼中楼参数语义风险
- 现状: 回复目标参数使用 `reply.id`。
- 风险: Discourse `reply_to_post_number` 语义通常是楼层号 `post_number`，不是 `post_id`。
- 证据: `lib/presentation/pages/feed/feed_detail_page.dart` 中 `_replyToPostNumber = int.tryParse(reply.id)`。

2. 编辑/删除能力未接入主链路
- 现状: API 与 Provider 有实现，但详情页当前回复项未暴露编辑/删除入口。
- 证据: `lib/presentation/widgets/post/post_reply_list.dart` 的编辑/删除为 `TODO`，而主详情页未使用该组件。

### P1

3. 新建话题标签未提交
- 现状: UI 维护 `_selectedTags`，发布请求未包含 `tags`。
- 风险: 话题组织能力弱，影响检索与运营分发。

4. 双写体系并存导致维护复杂
- 现状: `ApiService`、`FeedDetailPage`、`CommentRepository` 形成混合路径；`ForumRepository` 仍保留大量 mock 逻辑。
- 风险: 后续改动时行为不一致、缺陷定位困难。

### P2

5. 自动化测试偏“Mock 验证”，缺真实仓库级回归
- 现状: `write_operations_test` 与 `core_flows_test` 主要验证 mock 调用与返回。
- 风险: 线上真实响应结构变化时无法及时发现回归。

## 4. 最终 Specs 开发计划（建议版）

## 4.1 阶段目标

### M1（1 周）: 核心写链路稳定化
- 目标: 修复楼中楼参数语义；打通统一回复发送链路；下线占位回复页。
- 完成标准:
  - 回复目标使用 `post_number`（非 `post_id`）。
  - `/feed/:id/reply` 与详情页发送逻辑统一到 `ReplyNotifier`。
  - 失败场景（401/403/422/429）都有明确文案与可重试行为。

### M2（1 周）: 编辑/删除闭环
- 目标: 将“修改回答/删除回答”从能力层接入到主流程 UI。
- 完成标准:
  - 回复项菜单提供编辑/删除（按权限展示）。
  - 编辑回复页支持 Markdown 语法输入与预览（和发帖编辑器保持一致）。
  - 编辑成功后局部回写，不强制全量刷新。
  - 删除成功后从列表移除并修正回复计数。

### M3（1 周）: 发话题完善与统一
- 目标: 新建话题能力从“可发”提升到“可运营”。
- 完成标准:
  - 发布请求支持 `tags`。
  - 创建帖子页与编辑帖子页共享统一 Markdown 编辑器能力。
  - 支持图文混排、表情包插入、链接插入与链接预览。
  - 支持草稿保存/恢复（至少标题+正文+分类+标签）。
  - 清理/隔离 Forum mock 路径，避免与真实接口混用。

### M4（0.5-1 周）: 质量与验收
- 目标: 建立可回归、可观测、可发布的稳定基线。
- 完成标准:
  - 新增仓库级测试（非纯 mock）覆盖核心写链路。
  - 增加关键埋点: create_topic / create_reply / edit_reply / delete_reply。
  - 发布前回归清单通过（见 4.4）。

## 4.2 任务分解（Backlog）

### P0（先做）

1. ReplyData 增加 `postNumber` 字段并在适配层赋值
- 目标文件:
  - `lib/data/models/comment.dart`
  - `lib/core/network/api_service.dart`
  - `lib/presentation/pages/feed/feed_detail_page.dart`

2. 修复楼中楼回复参数映射
- `_startReplyTo` 使用 `reply.postNumber`。
- 兜底策略: 无 `postNumber` 时降级普通回复。

3. `/feed/:id/reply` 接入真实发送
- 复用 `ReplyNotifier.sendReply`，移除“功能开发中”占位。

### P1（并行推进）

4. 接入编辑/删除 UI
- 在当前详情页回复项中添加更多操作菜单。
- 直接调用 `replyNotifier.editReply/deleteReply`。

5. 新建话题 tags 落库
- `FeedCreatePage._publish` 增加 tags 参数。
- `ApiService.postCreateFeed`、`DiscourseApiService.createTopic` 扩展 tags 支持。

6. 草稿能力接入发帖页
- 参考 `reply_provider` 的草稿机制。

7. 建立统一 Markdown 编辑器（发帖/编辑帖子/编辑回复共用）
- 新增 `ComposerEditor` 能力层（组件 + 状态 + 序列化）。
- 统一支持:
  - Markdown 基础语法: 标题、加粗、斜体、删除线、引用、代码块、列表、分割线。
  - 链接: 手动插入 `[text](url)`、选中文本一键包裹、URL 粘贴自动识别。
  - 图片: 上传后插入 Markdown 图片语法，支持图文混排。
  - 表情包: 作为图片上传并插入 Markdown（与普通图片同链路，UI 入口分离）。

8. 新增“编辑帖子页”并复用创建页能力
- 新路由建议: `/feed/:id/edit`。
- 复用 `createTopic` 同类表单结构，初始值来自话题详情首帖内容。
- 提交时走 `editPost(postId, raw, editReason)`。

9. 新增“编辑回复页/弹层”并复用统一编辑器
- 回复项菜单“编辑”进入编辑页或 bottom sheet。
- 首次加载当前回复原文，支持继续编辑并预览。
- 提交成功后局部替换目标回复内容，保留失败回滚。

### P2（收敛）

7. 清理无效 mock 路径
- 标注 `ForumRepository` 为实验层或迁移到 `legacy/`。

8. 测试升级
- 新增仓库级用例（Dio 拦截器 + Fake 响应）验证请求参数与错误分支。

## 4.3 验收标准（必须满足）

1. 新建话题
- 标题/正文为空不可提交。
- 支持分类 + 标签提交。
- 发布成功跳转并可在列表中看到。

2. 回复
- 详情页回复成功后 2s 内可见（乐观或回写）。
- 楼中楼回复准确挂载到目标楼层。

3. 修改回答
- 仅可编辑本人可编辑内容。
- 编辑后列表内容即时更新，保留编辑失败回滚。

4. 删除回答
- 仅可删除本人可删除内容。
- 删除后回复数同步更新。

5. Markdown 编辑能力
- 创建帖子、编辑帖子、编辑回复三处交互与语法行为一致。
- 预览渲染结果与详情页渲染规则一致（同一渲染器或同等规则）。

6. 图文与表情包
- 可在正文任意位置插入多张图片（含表情包）并成功发布。
- 上传失败时可定位到具体素材并支持重试，不影响已成功素材。

7. 链接能力
- 支持手动插入链接、选中文字插入链接、直接粘贴 URL 自动识别。
- 发布后链接可点击，非法 URL 给出前端校验提示。

## 4.4 发布回归清单

- 登录态: 登录/过期/未登录三态
- 写操作: 新建话题、回复、编辑、删除
- 异常态: 401/403/422/429/5xx
- 媒体: 图片上传成功/失败与重试
- 媒体: 表情包上传成功/失败与重试（含大图、格式错误、频控）
- 内容: Markdown 语法渲染一致性（编辑态 vs 详情态）
- 链接: 插入、粘贴识别、预览、跳转全链路
- 一致性: 详情页回复数与列表条目一致

## 7. 富文本编辑器专项 Specs（新增）

## 7.1 范围

- 页面:
  - 新建话题页 `FeedCreatePage`
  - 编辑帖子页（新增）
  - 编辑回复页/弹层（新增）
- 能力:
  - Markdown
  - 图文混排
  - 表情包
  - 链接

## 7.2 交互与能力要求

1. Markdown 工具栏
- 提供快捷按钮: `H1/H2`、`B`、`I`、`S`、引用、代码块、无序列表、有序列表、链接、图片、表情包。
- 支持“选中文本包裹”与“无选中时插入模板”两种模式。

2. 预览模式
- 支持“编辑 / 预览”切换。
- 预览内容必须复用详情页渲染规则，避免渲染偏差。

3. 图片与表情包
- 图片与表情包统一走 `uploadImage` 接口。
- 表情包入口支持最近使用记录（本地缓存）。
- 上传后在光标处插入 `![alt](url)`，并保留原始文件名作为 alt 默认值。

4. 链接
- 工具栏可弹窗输入 `text + url` 生成 Markdown 链接。
- 粘贴 URL 时可自动转换为链接语法（可配置开关）。
- 非法 URL 阻止提交并提示具体字段。

## 7.3 技术实现建议

1. 组件层
- 新增: `lib/presentation/widgets/editor/composer_editor.dart`
- 子组件:
  - `composer_toolbar.dart`
  - `composer_preview.dart`
  - `composer_attachment_panel.dart`

2. 状态层
- 新增: `composer_provider.dart`
- 状态字段建议:
  - `rawText`
  - `selection`
  - `attachments`
  - `isPreview`
  - `isUploading`

3. 页面接入
- `FeedCreatePage` 迁移到 `ComposerEditor`
- 新增 `FeedEditPage` 接入 `ComposerEditor`
- 回复编辑入口接入 `ComposerEditor`（sheet 或 page 二选一，优先 sheet）

## 7.4 测试用例（新增）

1. 单元测试
- 文本包裹函数: 选中/未选中/跨行场景
- URL 校验与自动转换
- 上传成功后 Markdown 插入位置正确

2. 组件测试
- 工具栏点击后文本变化正确
- 编辑/预览切换渲染一致
- 表情包插入不覆盖现有内容

3. 集成测试
- 创建帖子: 文本 + 图片 + 表情包 + 链接 -> 发布成功
- 编辑帖子: 修改 Markdown 内容后保存成功并回显
- 编辑回复: 修改后列表即时更新

## 5. 风险与依赖

- 依赖 Discourse 实际权限策略（`can_edit`/`can_delete`/分类权限）。
- 依赖 CSRF 令牌稳定可用（当前已有 ensureValid，但需压测验证并发场景）。
- 若社区后端对 tags 参数格式有定制，需先做一次联调抓包确认。

## 6. 本次验证记录

- 已运行测试:
  - `flutter test test/write_operations_test.dart test/integration/core_flows_test.dart`
- 结果: 通过
- 说明: 当前测试偏 mock 验证，不代表端到端写链路已完全验收。
