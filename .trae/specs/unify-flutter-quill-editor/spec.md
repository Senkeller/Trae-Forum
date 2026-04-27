# 统一编辑器为 flutter_quill 方案规格文档

## Why

当前项目中存在三套编辑器实现，导致代码重复、维护困难、用户体验不一致：

1. **ComposerEditor**（组件库）- 相对完整但使用范围有限
2. **FeedCreatePage 内嵌编辑器** - 独立实现，功能重复
3. **FeedReplyPage 简单编辑器** - 功能简陋，工具栏按钮未实现

目标：统一使用 flutter_quill 富文本编辑器，提供一致的编辑体验，减少代码重复，提升可维护性。

## What Changes

### 新增依赖
- **flutter_quill**: ^11.1.0 - 核心富文本编辑器
- **flutter_quill_extensions**: ^11.0.0 - 图片/视频扩展
- **markdown_quill**: ^4.3.0 - Markdown 与 Delta 格式互转

### 删除重复代码
- 删除 `FeedCreatePage` 内嵌的编辑器实现（约 500 行工具栏逻辑）
- 删除 `FeedReplyPage` 的简单编辑器实现
- 保留 `ComposerEditor` 作为包装组件，但内部改为 flutter_quill

### 统一编辑器组件
- 创建新的 `QuillComposerEditor` 组件
- 所有页面统一使用新组件
- 支持 Delta 格式存储，向后兼容 Markdown

## Impact

### 受影响规格
- project-optimization-roadmap（编辑器相关任务需要更新）

### 受影响代码
- `lib/presentation/widgets/editor/composer_editor.dart` - 重写为 flutter_quill 包装器
- `lib/presentation/pages/feed/feed_create_page.dart` - 替换编辑器
- `lib/presentation/pages/feed/feed_reply_page.dart` - 替换编辑器
- `lib/presentation/pages/feed/feed_edit_page.dart` - 替换编辑器
- `lib/presentation/pages/feed/feed_detail_page.dart` - 替换编辑器
- `pubspec.yaml` - 添加依赖

## ADDED Requirements

### Requirement: flutter_quill 编辑器组件
系统 SHALL 提供基于 flutter_quill 的统一编辑器组件。

#### Scenario: 创建话题
- **GIVEN** 用户进入创建话题页面
- **WHEN** 用户编辑内容
- **THEN** 系统 SHALL 显示 flutter_quill 编辑器
- **AND** 支持富文本格式（加粗、斜体、标题、列表等）

#### Scenario: 回复话题
- **GIVEN** 用户进入回复页面
- **WHEN** 用户编辑回复内容
- **THEN** 系统 SHALL 显示 flutter_quill 编辑器
- **AND** 与创建话题编辑器体验一致

#### Scenario: 编辑话题
- **GIVEN** 用户编辑已有话题
- **WHEN** 加载原有内容
- **THEN** 系统 SHALL 正确解析并显示原有格式

### Requirement: Markdown 兼容性
系统 SHALL 支持 Markdown 格式与 Delta 格式的双向转换。

#### Scenario: 读取历史 Markdown 内容
- **GIVEN** 存在历史 Markdown 格式的内容
- **WHEN** 编辑器加载该内容
- **THEN** 系统 SHALL 正确转换为 Delta 格式并显示

#### Scenario: 保存内容
- **GIVEN** 用户使用编辑器编辑内容
- **WHEN** 保存内容
- **THEN** 系统 SHALL 同时支持保存为 Delta JSON 或 Markdown

### Requirement: 图片上传
系统 SHALL 支持在编辑器中上传并插入图片。

#### Scenario: 插入图片
- **GIVEN** 用户正在编辑内容
- **WHEN** 用户选择插入图片
- **THEN** 系统 SHALL 上传图片到服务器
- **AND** 在光标位置插入图片

## MODIFIED Requirements

### Requirement: 编辑器组件接口
**原要求**: ComposerEditor 使用自定义 Markdown 编辑器
**新要求**: ComposerEditor 内部使用 flutter_quill，保持接口兼容

## REMOVED Requirements

### Requirement: FeedCreatePage 内嵌编辑器
**Reason**: 代码重复，与 flutter_quill 方案冲突
**Migration**: 替换为 QuillComposerEditor

### Requirement: FeedReplyPage 简单编辑器
**Reason**: 功能简陋，用户体验不一致
**Migration**: 替换为 QuillComposerEditor

## 验收标准

- [ ] flutter_quill 依赖正确添加，无版本冲突
- [ ] 所有编辑器页面使用统一的 QuillComposerEditor 组件
- [ ] 历史 Markdown 内容能正确加载和显示
- [ ] 新内容可以保存为 Delta 或 Markdown 格式
- [ ] 图片上传功能正常工作
- [ ] `flutter analyze` 无新增错误
- [ ] 所有编辑器相关测试通过

## 技术约束

- 保持向后兼容，支持历史 Markdown 数据
- 不破坏现有 API 接口
- 保持与现有主题/样式一致
- 支持移动端和桌面端
