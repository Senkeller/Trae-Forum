# Tasks - 编辑器体验优化

## Task 1: 修复 Delta 空值错误
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 确保空 Markdown 转换为包含换行符的 Delta
  - [x] 添加 Delta 为空检查
- [x] 验证修复后无 "document delta cannot be empty" 错误

## Task 2: 修复编辑器点击输入问题
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 修复布局约束（使用 Container + BoxConstraints 替代 Expanded）
  - [x] 确保 QuillEditor 配置正确（expands: false, scrollable: true）
  - [x] 添加 enableInteractiveSelection 和 enableSelectionToolbar
  - [x] 添加 GestureDetector 确保点击获取焦点
- [x] 验证编辑器可以正常点击和输入

## Task 3: 添加中文本地化支持
- [x] 修改 lib/app.dart
  - [x] 添加 FlutterQuillLocalizations.delegate
  - [x] 添加 flutter_localizations 依赖
- [x] 验证工具栏显示中文

## Task 4: 集成图片上传到 QuillComposerEditor
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 添加图片上传回调参数 onImageUpload
  - [x] 在底部工具栏添加图片按钮
  - [x] 实现图片选择和上传逻辑
  - [x] 实现图片 Markdown 插入

## Task 5: 清理旧编辑器文件
- [x] 检查旧编辑器文件使用情况
  - [x] composer_toolbar.dart - 仍被使用，保留
  - [x] composer_preview.dart - 仍被使用，保留
  - [x] composer_attachment_panel.dart - 仍被使用，保留
- [x] 运行 flutter analyze 确保无未使用导入

## Task 6: 统一编辑器配置
- [x] 确保所有页面使用一致的编辑器配置
  - [x] 统一的 minHeight: 200
  - [x] 统一的 maxHeight: 400
  - [x] 统一的 hintText 样式

## Task 7: 验证和测试
- [x] 运行 flutter analyze 检查无新增错误
- [x] flutter pub get 成功
- [x] 所有编辑器相关文件编译通过

## Task 8: 增强工具栏功能
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 添加标题按钮（H1, H2, H3）
  - [x] 添加代码块按钮
  - [x] 添加引用块按钮
  - [x] 添加链接插入按钮
  - [x] 添加下划线按钮
  - [x] 添加删除线按钮
- [x] 验证所有工具栏按钮正常工作

## Task 9: 修复底部工具栏
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 修复底部工具栏图标重复问题
  - [x] 只保留一个图片上传按钮
- [x] 验证底部工具栏显示正常

## Task 10: 优化编辑器高度
- [x] 修改 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [x] 增加默认 minHeight 到 150
  - [x] 优化编辑器区域布局
- [x] 修改各页面使用编辑器时的配置
  - [x] feed_detail_page.dart - 评论编辑器高度
  - [x] feed_reply_page.dart - 回复编辑器高度

## Task 11: 最终验证
- [x] 运行 flutter analyze 检查无新增错误
- [x] 验证工具栏所有功能正常
- [x] 验证编辑器高度合适
- [x] 验证底部工具栏正常

# Task Dependencies

- Task 1-7 (已完成) - 基础优化
- Task 8 (增强工具栏) 依赖：无
- Task 9 (修复底部工具栏) 依赖：无
- Task 10 (优化高度) 依赖：无
- Task 11 (最终验证) 依赖：Task 8, 9, 10 完成
