import 'package:flutter/material.dart';
import 'composer_editor.dart';

/// 链接插入回调函数类型
///
/// [text] 链接显示文本
/// [url] 链接 URL
/// [isValid] URL 是否有效
/// [errorMessage] 错误信息（如果 URL 无效）
typedef LinkInsertCallback = void Function({
  required String text,
  required String url,
  required bool isValid,
  String? errorMessage,
});

/// Markdown 编辑器工具栏组件
///
/// 提供 Markdown 语法快捷操作按钮，支持：
/// - 标题（H1, H2, H3）
/// - 文本样式（加粗、斜体、删除线）
/// - 引用
/// - 代码（行内代码、代码块）
/// - 列表（无序列表、有序列表）
/// - 分割线
/// - 链接和图片
///
/// 使用示例：
/// ```dart
/// ComposerToolbar(
///   onAction: (syntax, selectedText) {
///     // 处理工具栏操作
///   },
/// )
/// ```
class ComposerToolbar extends StatelessWidget {
  /// 工具栏操作回调
  ///
  /// [syntax] Markdown 语法类型
  /// [selectedText] 当前选中的文本（如果有）
  final Function(MarkdownSyntax syntax, String? selectedText) onAction;

  /// 当前选中的文本
  final String? selectedText;

  /// 是否显示分组标签
  final bool showGroupLabels;

  /// 自定义高度
  final double? height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 表情按钮点击回调
  final VoidCallback? onEmojiTap;

  /// 图片按钮点击回调（覆盖默认行为）
  final VoidCallback? onImageTap;

  /// 链接按钮点击回调（覆盖默认行为）
  final VoidCallback? onLinkTap;

  /// 构造函数
  ///
  /// [onAction] 工具栏操作回调（必填）
  /// [selectedText] 当前选中的文本
  /// [showGroupLabels] 是否显示分组标签，默认 false
  /// [height] 自定义高度
  /// [backgroundColor] 背景颜色
  /// [onEmojiTap] 表情按钮点击回调
  /// [onImageTap] 图片按钮点击回调
  /// [onLinkTap] 链接按钮点击回调
  const ComposerToolbar({
    super.key,
    required this.onAction,
    this.selectedText,
    this.showGroupLabels = false,
    this.height,
    this.backgroundColor,
    this.onEmojiTap,
    this.onImageTap,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // 标题组
            _buildToolbarGroup(
              context,
              label: '标题',
              children: [
                _ToolbarButton(
                  icon: Icons.title,
                  tooltip: '一级标题',
                  onTap: () => onAction(MarkdownSyntax.heading, selectedText),
                  label: 'H1',
                ),
                _ToolbarButton(
                  icon: Icons.title,
                  tooltip: '二级标题',
                  onTap: () => onAction(MarkdownSyntax.heading2, selectedText),
                  label: 'H2',
                  iconSize: 18,
                ),
                _ToolbarButton(
                  icon: Icons.title,
                  tooltip: '三级标题',
                  onTap: () => onAction(MarkdownSyntax.heading3, selectedText),
                  label: 'H3',
                  iconSize: 16,
                ),
              ],
            ),

            _buildDivider(context),

            // 文本样式组
            _buildToolbarGroup(
              context,
              label: '样式',
              children: [
                _ToolbarButton(
                  icon: Icons.format_bold,
                  tooltip: '加粗',
                  onTap: () => onAction(MarkdownSyntax.bold, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.format_italic,
                  tooltip: '斜体',
                  onTap: () => onAction(MarkdownSyntax.italic, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.format_strikethrough,
                  tooltip: '删除线',
                  onTap: () => onAction(MarkdownSyntax.strikethrough, selectedText),
                ),
              ],
            ),

            _buildDivider(context),

            // 引用和代码组
            _buildToolbarGroup(
              context,
              label: '引用',
              children: [
                _ToolbarButton(
                  icon: Icons.format_quote,
                  tooltip: '引用',
                  onTap: () => onAction(MarkdownSyntax.quote, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.code,
                  tooltip: '行内代码',
                  onTap: () => onAction(MarkdownSyntax.code, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.code_off,
                  tooltip: '代码块',
                  onTap: () => onAction(MarkdownSyntax.codeBlock, selectedText),
                ),
              ],
            ),

            _buildDivider(context),

            // 列表组
            _buildToolbarGroup(
              context,
              label: '列表',
              children: [
                _ToolbarButton(
                  icon: Icons.format_list_bulleted,
                  tooltip: '无序列表',
                  onTap: () => onAction(MarkdownSyntax.unorderedList, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.format_list_numbered,
                  tooltip: '有序列表',
                  onTap: () => onAction(MarkdownSyntax.orderedList, selectedText),
                ),
              ],
            ),

            _buildDivider(context),

            // 其他组
            _buildToolbarGroup(
              context,
              label: '其他',
              children: [
                _ToolbarButton(
                  icon: Icons.horizontal_rule,
                  tooltip: '分割线',
                  onTap: () => onAction(MarkdownSyntax.divider, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.link,
                  tooltip: '链接',
                  onTap: onLinkTap ?? () => onAction(MarkdownSyntax.link, selectedText),
                ),
                if (onEmojiTap != null)
                  _ToolbarButton(
                    icon: Icons.emoji_emotions_outlined,
                    tooltip: '表情',
                    onTap: onEmojiTap!,
                  ),
                _ToolbarButton(
                  icon: Icons.image,
                  tooltip: '图片',
                  onTap: onImageTap ?? () => onAction(MarkdownSyntax.image, selectedText),
                ),
                _ToolbarButton(
                  icon: Icons.image,
                  tooltip: '图片',
                  onTap: () => onAction(MarkdownSyntax.image, selectedText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建工具栏分组
  Widget _buildToolbarGroup(
    BuildContext context, {
    required String label,
    required List<Widget> children,
  }) {
    if (showGroupLabels) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  /// 构建分隔线
  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
    );
  }
}

/// 工具栏按钮
class _ToolbarButton extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 提示文字
  final String tooltip;

  /// 点击回调
  final VoidCallback onTap;

  /// 标签（显示在图标下方）
  final String? label;

  /// 图标大小
  final double iconSize;

  /// 构造函数
  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.label,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: colorScheme.onSurfaceVariant,
                ),
                if (label != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 8,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 扩展工具栏组件
///
/// 提供更多高级功能的工具栏
class ComposerToolbarExtended extends StatelessWidget {
  /// 工具栏操作回调
  final Function(MarkdownSyntax syntax, String? selectedText) onAction;

  /// 当前选中的文本
  final String? selectedText;

  /// 撤销回调
  final VoidCallback? onUndo;

  /// 重做回调
  final VoidCallback? onRedo;

  /// 是否可以撤销
  final bool canUndo;

  /// 是否可以重做
  final bool canRedo;

  /// 表情按钮点击回调
  final VoidCallback? onEmojiTap;

  /// 附件按钮点击回调
  final VoidCallback? onAttachmentTap;

  /// 全屏按钮点击回调
  final VoidCallback? onFullscreenTap;

  /// 链接插入回调
  final LinkInsertCallback? onLinkInsert;

  /// 构造函数
  const ComposerToolbarExtended({
    super.key,
    required this.onAction,
    this.selectedText,
    this.onUndo,
    this.onRedo,
    this.canUndo = false,
    this.canRedo = false,
    this.onEmojiTap,
    this.onAttachmentTap,
    this.onFullscreenTap,
    this.onLinkInsert,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 第一行：撤销/重做 + 扩展功能
          Row(
            children: [
              // 撤销按钮
              _IconButton(
                icon: Icons.undo,
                tooltip: '撤销',
                onTap: canUndo ? onUndo : null,
                isEnabled: canUndo,
              ),

              // 重做按钮
              _IconButton(
                icon: Icons.redo,
                tooltip: '重做',
                onTap: canRedo ? onRedo : null,
                isEnabled: canRedo,
              ),

              const Spacer(),

              // 表情按钮
              if (onEmojiTap != null)
                _IconButton(
                  icon: Icons.emoji_emotions_outlined,
                  tooltip: '表情',
                  onTap: onEmojiTap,
                ),

              // 附件按钮
              if (onAttachmentTap != null)
                _IconButton(
                  icon: Icons.attach_file,
                  tooltip: '附件',
                  onTap: onAttachmentTap,
                ),

              // 全屏按钮
              if (onFullscreenTap != null)
                _IconButton(
                  icon: Icons.fullscreen,
                  tooltip: '全屏',
                  onTap: onFullscreenTap,
                ),
            ],
          ),

          const SizedBox(height: 8),

          // 第二行：Markdown 语法按钮
          const Divider(height: 1),
          const SizedBox(height: 8),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // 标题
                _DropdownButton(
                  icon: Icons.title,
                  tooltip: '标题',
                  items: [
                    _DropdownItem(
                      label: '一级标题',
                      value: MarkdownSyntax.heading,
                    ),
                    _DropdownItem(
                      label: '二级标题',
                      value: MarkdownSyntax.heading2,
                    ),
                    _DropdownItem(
                      label: '三级标题',
                      value: MarkdownSyntax.heading3,
                    ),
                  ],
                  onSelected: (syntax) => onAction(syntax, selectedText),
                ),

                _buildDivider(context),

                // 文本样式
                _IconButton(
                  icon: Icons.format_bold,
                  tooltip: '加粗',
                  onTap: () => onAction(MarkdownSyntax.bold, selectedText),
                ),
                _IconButton(
                  icon: Icons.format_italic,
                  tooltip: '斜体',
                  onTap: () => onAction(MarkdownSyntax.italic, selectedText),
                ),
                _IconButton(
                  icon: Icons.format_strikethrough,
                  tooltip: '删除线',
                  onTap: () => onAction(MarkdownSyntax.strikethrough, selectedText),
                ),

                _buildDivider(context),

                // 引用和代码
                _IconButton(
                  icon: Icons.format_quote,
                  tooltip: '引用',
                  onTap: () => onAction(MarkdownSyntax.quote, selectedText),
                ),
                _IconButton(
                  icon: Icons.code,
                  tooltip: '行内代码',
                  onTap: () => onAction(MarkdownSyntax.code, selectedText),
                ),
                _IconButton(
                  icon: Icons.code_off,
                  tooltip: '代码块',
                  onTap: () => onAction(MarkdownSyntax.codeBlock, selectedText),
                ),

                _buildDivider(context),

                // 列表
                _IconButton(
                  icon: Icons.format_list_bulleted,
                  tooltip: '无序列表',
                  onTap: () => onAction(MarkdownSyntax.unorderedList, selectedText),
                ),
                _IconButton(
                  icon: Icons.format_list_numbered,
                  tooltip: '有序列表',
                  onTap: () => onAction(MarkdownSyntax.orderedList, selectedText),
                ),

                _buildDivider(context),

                // 其他
                _IconButton(
                  icon: Icons.horizontal_rule,
                  tooltip: '分割线',
                  onTap: () => onAction(MarkdownSyntax.divider, selectedText),
                ),
                _IconButton(
                  icon: Icons.link,
                  tooltip: '链接',
                  onTap: () => _showLinkDialog(context),
                ),
                _IconButton(
                  icon: Icons.image,
                  tooltip: '图片',
                  onTap: () => onAction(MarkdownSyntax.image, selectedText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
    );
  }

  /// 显示链接插入对话框
  void _showLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LinkInsertDialog(
        initialText: selectedText,
        onConfirm: onLinkInsert,
      ),
    );
  }
}

/// 图标按钮
class _IconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool isEnabled;

  const _IconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isEnabled ? Colors.transparent : Colors.transparent,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isEnabled
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

/// 下拉按钮数据项
class _DropdownItem {
  final String label;
  final MarkdownSyntax value;

  const _DropdownItem({
    required this.label,
    required this.value,
  });
}

/// 下拉按钮
class _DropdownButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final List<_DropdownItem> items;
  final Function(MarkdownSyntax) onSelected;

  const _DropdownButton({
    required this.icon,
    required this.tooltip,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<MarkdownSyntax>(
      tooltip: tooltip,
      offset: const Offset(0, 36),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem(
            value: item.value,
            child: Text(item.label),
          );
        }).toList();
      },
      onSelected: onSelected,
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// 链接插入对话框
///
/// 提供输入链接文本和 URL 的弹窗界面，支持 URL 校验
class LinkInsertDialog extends StatefulWidget {
  /// 初始文本（选中的文本）
  final String? initialText;

  /// 确认回调
  final LinkInsertCallback? onConfirm;

  /// 构造函数
  const LinkInsertDialog({
    super.key,
    this.initialText,
    this.onConfirm,
  });

  @override
  State<LinkInsertDialog> createState() => _LinkInsertDialogState();
}

class _LinkInsertDialogState extends State<LinkInsertDialog> {
  late final TextEditingController _textController;
  late final TextEditingController _urlController;
  String? _errorMessage;

  /// URL 正则表达式模式
  static final RegExp _urlPattern = RegExp(
    r'^(https?:\/\/)?' // 协议（可选）
    r'(([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,})' // 域名
    r'(:\d+)?' // 端口（可选）
    r'(\/[^\s]*)?' // 路径（可选）
    r'$',
    caseSensitive: false,
  );

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText ?? '');
    _urlController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  /// 验证 URL 是否有效
  bool _validateUrl(String url) {
    if (url.isEmpty) {
      setState(() {
        _errorMessage = '请输入 URL';
      });
      return false;
    }

    // 自动补全协议
    String normalizedUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      normalizedUrl = 'https://$url';
    }

    if (!_urlPattern.hasMatch(normalizedUrl)) {
      setState(() {
        _errorMessage = '请输入有效的 URL 地址';
      });
      return false;
    }

    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  /// 处理确认操作
  void _handleConfirm() {
    final text = _textController.text.trim();
    final url = _urlController.text.trim();

    final isValid = _validateUrl(url);

    widget.onConfirm?.call(
      text: text.isEmpty ? '链接' : text,
      url: url,
      isValid: isValid,
      errorMessage: _errorMessage,
    );

    if (isValid) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text('插入链接'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 链接文本输入框
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: '链接文本',
              hintText: widget.initialText?.isNotEmpty == true
                  ? widget.initialText
                  : '请输入链接显示文本',
              prefixIcon: const Icon(Icons.text_fields),
              border: const OutlineInputBorder(),
            ),
            autofocus: widget.initialText?.isNotEmpty != true,
          ),
          const SizedBox(height: 16),
          // URL 输入框
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'URL 地址',
              hintText: 'https://example.com',
              prefixIcon: const Icon(Icons.link),
              border: const OutlineInputBorder(),
              errorText: _errorMessage,
            ),
            keyboardType: TextInputType.url,
            autofocus: widget.initialText?.isNotEmpty == true,
            onSubmitted: (_) => _handleConfirm(),
          ),
          const SizedBox(height: 8),
          // 提示文字
          Text(
            '支持自动识别 http:// 和 https:// 协议',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _handleConfirm,
          child: const Text('插入'),
        ),
      ],
    );
  }
}
