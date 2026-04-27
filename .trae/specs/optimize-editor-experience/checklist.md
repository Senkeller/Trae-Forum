# Checklist - 编辑器体验优化

## Delta 空值错误修复
- [x] 空 Markdown 转换为包含换行符的 Delta
- [x] Delta 转换后为空时返回默认 Delta
- [x] 无 "document delta cannot be empty" 错误

## 编辑器点击输入修复
- [x] 使用 Container + BoxConstraints 布局
- [x] QuillEditor 配置正确（expands: false, scrollable: true）
- [x] 添加 GestureDetector 确保点击获取焦点
- [x] 编辑器可以正常点击
- [x] 编辑器可以正常输入文字

## 中文本地化
- [x] app.dart 添加 FlutterQuillLocalizations.delegate
- [x] pubspec.yaml 添加 flutter_localizations 依赖
- [x] 工具栏显示中文提示

## 图片上传集成
- [x] QuillComposerEditor 添加 onImageUpload 回调参数
- [x] 底部工具栏显示图片按钮
- [x] 图片选择和上传功能正常
- [x] 图片上传成功后插入 Markdown 格式

## 代码清理
- [x] 检查旧编辑器文件使用情况
- [x] composer_toolbar.dart 仍被使用，保留
- [x] composer_preview.dart 仍被使用，保留
- [x] composer_attachment_panel.dart 仍被使用，保留
- [x] flutter analyze 无未使用导入警告

## 统一配置
- [x] 所有页面使用一致的 minHeight: 200
- [x] 所有页面使用一致的 maxHeight: 400
- [x] 统一的 hintText 样式

## 验证测试
- [x] flutter analyze 无新增错误
- [x] flutter pub get 成功
- [x] 所有编辑器相关文件编译通过

## 增强工具栏功能
- [x] 添加标题按钮（H1, H2, H3）
- [x] 添加代码块按钮
- [x] 添加引用块按钮
- [x] 添加链接插入按钮
- [x] 添加下划线按钮
- [x] 添加删除线按钮
- [x] 所有工具栏按钮正常工作

## 修复底部工具栏
- [x] 底部工具栏图标不重复
- [x] 只显示一个图片上传按钮

## 优化编辑器高度
- [x] 默认 minHeight 增加到 150
- [x] 编辑器区域布局优化
- [x] 各页面编辑器高度合适

## 最终验证
- [x] flutter analyze 无新增错误
- [x] 工具栏所有功能正常
- [x] 编辑器高度合适
- [x] 底部工具栏正常
