# Checklist - 统一编辑器为 flutter_quill 方案

## 依赖安装检查
- [x] pubspec.yaml 中已添加 flutter_quill: ^11.0.0-dev.15
- [x] pubspec.yaml 中已添加 markdown_quill: ^4.3.0
- [x] flutter pub get 运行成功，无版本冲突

## QuillComposerEditor 组件检查
- [x] lib/presentation/widgets/editor/quill_composer_editor.dart 文件已创建
- [x] 组件包含 QuillEditor 和 QuillToolbar
- [x] 支持 initialText 参数（Markdown 格式）
- [x] 支持 onTextChanged 回调
- [x] 支持 onSubmit 回调
- [x] 支持图片上传功能
- [x] Delta 与 Markdown 双向转换功能正常

## ComposerEditor 包装器检查
- [x] lib/presentation/widgets/editor/composer_editor.dart 已重写
- [x] 保留原有接口不变
- [x] 内部使用 QuillComposerEditor
- [x] 向后兼容，现有调用代码无需修改

## FeedCreatePage 替换检查
- [x] lib/presentation/pages/feed/feed_create_page.dart 已更新
- [x] 删除了内嵌编辑器实现（约 500 行工具栏逻辑）
- [x] 使用 QuillComposerEditor 替换原编辑器
- [x] 图片上传功能正常工作
- [x] 草稿保存/恢复功能正常工作

## FeedReplyPage 替换检查
- [x] lib/presentation/pages/feed/feed_reply_page.dart 已更新
- [x] 删除了简单编辑器实现
- [x] 使用 QuillComposerEditor 替换原编辑器
- [x] 工具栏按钮功能正常实现

## FeedEditPage 更新检查
- [x] lib/presentation/pages/feed/feed_edit_page.dart 已更新
- [x] 使用 QuillComposerEditor 替换 ComposerEditor
- [x] 编辑内容正确加载和显示

## FeedDetailPage 更新检查
- [x] lib/presentation/pages/feed/feed_detail_page.dart 已更新
- [x] 评论编辑器使用 QuillComposerEditor
- [x] 评论功能正常工作

## 图片上传集成检查
- [x] 复用现有 ImageUploadService
- [x] 支持从相册选择图片
- [x] 支持粘贴图片
- [x] 上传成功后图片正确插入编辑器

## 代码清理检查
- [x] 删除不再使用的旧编辑器文件（如需要）
- [x] FeedCreatePage 中无冗余代码
- [x] flutter analyze 无未使用导入警告

## 测试检查
- [x] QuillComposerEditor 单元测试已添加
- [x] 编辑器相关集成测试已更新
- [x] 所有测试通过

## 质量和兼容性检查
- [x] flutter analyze 无新增错误
- [x] flutter test 所有测试通过
- [x] 历史 Markdown 内容能正确加载和显示
- [x] 新内容可以保存为 Markdown 格式
- [x] 与现有主题/样式一致
- [x] 移动端和桌面端均正常工作

## 功能验收检查
- [x] 创建话题页面编辑器功能正常
- [x] 回复话题页面编辑器功能正常
- [x] 编辑话题页面编辑器功能正常
- [x] 评论编辑器功能正常
- [x] 所有编辑器体验一致
