import 'package:flutter/material.dart';
import 'topic_magazine_renderer.dart';

/// 目录项数据模型
///
/// 存储标题文本、层级和对应的滚动位置
class TocItem {
  /// 标题文本
  final String text;

  /// 标题层级 (1-6)
  final int level;

  /// 对应的 block 索引
  final int blockIndex;

  /// 滚动位置（由外部计算设置）
  double offset;

  /// 全局键，用于定位
  final GlobalKey key;

  TocItem({
    required this.text,
    required this.level,
    required this.blockIndex,
    this.offset = 0,
    GlobalKey? key,
  }) : key = key ?? GlobalKey();
}

/// 目录导航组件
///
/// 悬浮按钮形式，点击展开目录列表，支持点击跳转和当前位置高亮
class TableOfContents extends StatefulWidget {
  /// 目录项列表
  final List<TocItem> items;

  /// 滚动控制器
  final ScrollController scrollController;

  /// 是否显示目录按钮
  final bool visible;

  const TableOfContents({
    super.key,
    required this.items,
    required this.scrollController,
    this.visible = true,
  });

  @override
  State<TableOfContents> createState() => _TableOfContentsState();
}

class _TableOfContentsState extends State<TableOfContents> {
  bool _isExpanded = false;
  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  /// 滚动监听，更新当前高亮的目录项
  void _onScroll() {
    if (widget.items.isEmpty) return;

    final offset = widget.scrollController.offset;
    final newIndex = _findCurrentIndex(offset);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  /// 根据滚动位置找到当前应该高亮的目录项索引
  int _findCurrentIndex(double offset) {
    if (widget.items.isEmpty) return -1;

    // 考虑 AppBar 高度和额外边距
    const threshold = 120.0;
    final adjustedOffset = offset + threshold;

    for (int i = widget.items.length - 1; i >= 0; i--) {
      if (widget.items[i].offset <= adjustedOffset) {
        return i;
      }
    }
    return 0;
  }

  /// 点击目录项跳转到对应位置
  void _scrollToItem(int index) {
    if (index < 0 || index >= widget.items.length) return;

    final item = widget.items[index];
    final targetOffset = item.offset - 80; // 留出顶部边距

    widget.scrollController.animateTo(
      targetOffset.clamp(0.0, widget.scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _isExpanded = false;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible || widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // 遮罩层
        if (_isExpanded)
          GestureDetector(
            onTap: () => setState(() => _isExpanded = false),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),

        // 目录面板
        if (_isExpanded)
          Positioned(
            right: 16,
            bottom: 80,
            child: _buildTocPanel(colorScheme),
          ),

        // 悬浮按钮
        Positioned(
          right: 16,
          bottom: 16,
          child: _buildFab(colorScheme),
        ),
      ],
    );
  }

  /// 构建目录面板
  Widget _buildTocPanel(ColorScheme colorScheme) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      color: colorScheme.surface,
      child: Container(
        width: 280,
        constraints: const BoxConstraints(maxHeight: 400),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.format_list_bulleted,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '目录',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.items.length} 项',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            // 目录列表
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isActive = index == _currentIndex;

                  return _TocListItem(
                    text: item.text,
                    level: item.level,
                    isActive: isActive,
                    onTap: () => _scrollToItem(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建悬浮按钮
  Widget _buildFab(ColorScheme colorScheme) {
    return FloatingActionButton.small(
      onPressed: () => setState(() => _isExpanded = !_isExpanded),
      backgroundColor: _isExpanded ? colorScheme.primary : colorScheme.surface,
      foregroundColor: _isExpanded
          ? colorScheme.onPrimary
          : colorScheme.onSurfaceVariant,
      elevation: 4,
      child: AnimatedRotation(
        turns: _isExpanded ? 0.125 : 0,
        duration: const Duration(milliseconds: 200),
        child: Icon(_isExpanded ? Icons.close : Icons.toc),
      ),
    );
  }
}

/// 目录列表项
class _TocListItem extends StatelessWidget {
  final String text;
  final int level;
  final bool isActive;
  final VoidCallback onTap;

  const _TocListItem({
    required this.text,
    required this.level,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indent = (level - 1) * 16.0;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16 + indent, 8, 16, 8),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primaryContainer.withValues(alpha: 0.5)
              : null,
          border: isActive
              ? Border(
                  left: BorderSide(
                    color: colorScheme.primary,
                    width: 3,
                  ),
                )
              : Border(
                  left: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                    width: 3,
                  ),
                ),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? colorScheme.primary : colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}

/// 目录工具类
///
/// 提供从内容块中提取目录项的方法
class TocUtils {
  /// 从 TopicContentBlock 列表中提取目录项
  ///
  /// [blocks] 内容块列表
  /// 返回提取的目录项列表
  static List<TocItem> extractFromBlocks(List<TopicContentBlock> blocks) {
    final items = <TocItem>[];

    for (int i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      if (block.type == TopicContentBlockType.heading) {
        items.add(TocItem(
          text: block.text,
          level: block.headingLevel.clamp(1, 6),
          blockIndex: i,
        ));
      }
    }

    return items;
  }

  /// 计算每个目录项的滚动位置
  ///
  /// [items] 目录项列表
  /// [context] BuildContext，用于获取 RenderBox
  static void calculateOffsets(
    List<TocItem> items,
    BuildContext context,
  ) {
    for (final item in items) {
      final key = item.key;
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final scrollController = Scrollable.of(context);
          item.offset = position.dy + scrollController.position.pixels;
        }
      }
    }
  }
}
