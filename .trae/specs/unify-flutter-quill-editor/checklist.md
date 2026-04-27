# Checklist - 统一编辑器为 flutter_quill 方案

## 依赖安装检查
- [ ] pubspec.yaml 中已添加 flutter_quill: ^11.1.0
- [ ] pubspec.yaml 中已添加 flutter_quill_extensions: ^11.0.0
- [ ] pubspec.yaml 中已添加 markdown_quill: ^4.3.0
- [ ] flutter pub get 运行成功，无版本冲突

## QuillComposerEditor 组件检查
- [ ] lib/presentation/widgets/editor/quill_composer_editor.dart 文件已创建
- [ ] 组件包含 QuillEditor 和 QuillToolbar
- [ ] 支持 initialText 参数（Markdown 格式）
- [ ] 支持 onTextChanged 回调
- [ ] 支持 onSubmit 回调
- [ ] 支持图片上传功能
- [ ] Delta 与 Markdown 双向转换功能正常

## ComposerEditor 包装器检查
- [ ] lib/presentation/widgets/editor/composer_editor.dart 已重写
- [ ] 保留原有接口不变
- [ ] 内部使用 QuillComposerEditor
- [ ] 向后兼容，现有调用代码无需修改

## FeedCreatePage 替换检查
- [ ] lib/presentation/pages/feed/feed_create_page.dart 已更新
- [ ] 删除了内嵌编辑器实现（约 500 行工具栏逻辑）
- [ ] 使用 QuillComposerEditor 替换原编辑器
- [ ] 图片上传功能正常工作
- [ ] 草稿保存/恢复功能正常工作

## FeedReplyPage 替换检查
- [ ] lib/presentation/pages/feed/feed_reply_page.dart 已更新
- [ ] 删除了简单编辑器实现
- [ ] 使用 QuillComposerEditor 替换原编辑器
- [ ] 工具栏按钮功能正常实现

## FeedEditPage 更新检查
- [ ] lib/presentation/pages/feed/feed_edit_page.dart 已更新
- [ ] 使用 QuillComposerEditor 替换 ComposerEditor
- [ ] 编辑内容正确加载和显示

## FeedDetailPage 更新检查
- [ ] lib/presentation/pages/feed/feed_detail_page.dart 已更新
- [ ] 评论编辑器使用 QuillComposerEditor
- [ ] 评论功能正常工作

## 图片上传集成检查
- [ ] 复用现有 ImageUploadService
- [ ] 支持从相册选择图片
- [ ] 支持粘贴图片
- [ ] 上传成功后图片正确插入编辑器

## 代码清理检查
- [ ] 删除不再使用的旧编辑器文件（如需要）
- [ ] FeedCreatePage 中无冗余代码
- [ ] flutter analyze 无未使用导入警告

## 测试检查
- [ ] QuillComposerEditor 单元测试已添加
- [ ] 编辑器相关集成测试已更新
- [ ] 所有测试通过

## 质量和兼容性检查
- [ ] flutter analyze 无新增错误
- [ ] flutter test 所有测试通过
- [ ] 历史 Markdown 内容能正确加载和显示
- [ ] 新内容可以保存为 Markdown 格式
- [ ] 与现有主题/样式一致
- [ ] 移动端和桌面端均正常工作

## 功能验收检查
- [ ] 创建话题页面编辑器功能正常
- [ ] 回复话题页面编辑器功能正常
- [ ] 编辑话题页面编辑器功能正常
- [ ] 评论编辑器功能正常
- [ ] 所有编辑器体验一致
