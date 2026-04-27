# Tasks - 统一编辑器为 flutter_quill 方案

## Task 1: 添加 flutter_quill 依赖
- [ ] 在 pubspec.yaml 添加依赖
  - [ ] 添加 flutter_quill: ^11.1.0
  - [ ] 添加 flutter_quill_extensions: ^11.0.0
  - [ ] 添加 markdown_quill: ^4.3.0
- [ ] 运行 flutter pub get 验证依赖安装
- [ ] 检查依赖版本兼容性

## Task 2: 创建 QuillComposerEditor 组件
- [ ] 创建新的编辑器组件文件
  - [ ] 创建 lib/presentation/widgets/editor/quill_composer_editor.dart
  - [ ] 实现基础编辑器界面（QuillEditor + QuillToolbar）
  - [ ] 添加 Delta 与 Markdown 转换逻辑
- [ ] 实现组件接口
  - [ ] initialText 支持（接收 Markdown 或 Delta）
  - [ ] onTextChanged 回调（返回 Markdown 或 Delta）
  - [ ] onSubmit 回调
  - [ ] 图片上传集成
- [ ] 添加本地化配置
  - [ ] 配置 FlutterQuillLocalizations

## Task 3: 重写 ComposerEditor 为包装器
- [ ] 修改 lib/presentation/widgets/editor/composer_editor.dart
  - [ ] 保留现有接口不变
  - [ ] 内部使用 QuillComposerEditor
  - [ ] 确保向后兼容

## Task 4: 替换 FeedCreatePage 编辑器
- [ ] 修改 lib/presentation/pages/feed/feed_create_page.dart
  - [ ] 删除内嵌编辑器实现（约 500 行工具栏逻辑）
  - [ ] 使用 QuillComposerEditor 替换
  - [ ] 保留图片上传功能
  - [ ] 保留草稿保存/恢复功能
- [ ] 验证创建话题功能正常

## Task 5: 替换 FeedReplyPage 编辑器
- [ ] 修改 lib/presentation/pages/feed/feed_reply_page.dart
  - [ ] 删除简单编辑器实现
  - [ ] 使用 QuillComposerEditor 替换
  - [ ] 实现工具栏按钮功能（之前是空的 onPressed）
- [ ] 验证回复功能正常

## Task 6: 更新 FeedEditPage 编辑器
- [ ] 修改 lib/presentation/pages/feed/feed_edit_page.dart
  - [ ] 替换 ComposerEditor 为 QuillComposerEditor
  - [ ] 确保编辑内容正确加载
- [ ] 验证编辑功能正常

## Task 7: 更新 FeedDetailPage 编辑器
- [ ] 修改 lib/presentation/pages/feed/feed_detail_page.dart
  - [ ] 替换评论编辑器为 QuillComposerEditor
- [ ] 验证评论功能正常

## Task 8: 实现图片上传集成
- [ ] 在 QuillComposerEditor 中集成图片上传
  - [ ] 复用现有 ImageUploadService
  - [ ] 支持从相册选择图片
  - [ ] 支持粘贴图片
  - [ ] 上传成功后插入图片到编辑器
- [ ] 验证图片上传功能

## Task 9: 清理旧代码
- [ ] 删除不再使用的文件
  - [ ] 检查 composer_toolbar.dart 是否还需要
  - [ ] 检查 composer_preview.dart 是否还需要
  - [ ] 检查 emoji_picker_panel.dart 是否还需要
- [ ] 删除 FeedCreatePage 中的冗余代码
- [ ] 运行 flutter analyze 确保无未使用导入

## Task 10: 添加/更新测试
- [ ] 添加 QuillComposerEditor 单元测试
- [ ] 更新编辑器相关集成测试
- [ ] 验证所有测试通过

## Task 11: 验证和验收
- [ ] 运行 flutter analyze 检查无新增错误
- [ ] 运行 flutter test 确保所有测试通过
- [ ] 手动测试所有编辑器页面
  - [ ] 创建话题
  - [ ] 回复话题
  - [ ] 编辑话题
  - [ ] 评论
- [ ] 验证 Markdown 兼容性
  - [ ] 加载历史 Markdown 内容
  - [ ] 保存新内容

# Task Dependencies

- Task 1 (添加依赖) 依赖：无
- Task 2 (创建组件) 依赖：Task 1 完成
- Task 3 (重写包装器) 依赖：Task 2 完成
- Task 4 (替换 FeedCreatePage) 依赖：Task 3 完成
- Task 5 (替换 FeedReplyPage) 依赖：Task 3 完成
- Task 6 (更新 FeedEditPage) 依赖：Task 3 完成
- Task 7 (更新 FeedDetailPage) 依赖：Task 3 完成
- Task 8 (图片上传) 依赖：Task 2 完成
- Task 9 (清理代码) 依赖：Task 4, 5, 6, 7 完成
- Task 10 (测试) 依赖：Task 4, 5, 6, 7 完成
- Task 11 (验收) 依赖：Task 8, 9, 10 完成
