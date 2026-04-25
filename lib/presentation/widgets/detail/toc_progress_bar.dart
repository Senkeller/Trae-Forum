import 'package:flutter/material.dart';
import 'table_of_contents.dart';

/// 目录进度条组件
///
/// 显示在回复输入栏上方，展示阅读进度和当前章节
class TocProgressBar extends StatefulWidget {
  /// 目录项列表
  final List<TocItem> items;

  /// 滚动控制器
  final ScrollController scrollController;

  /// 是否可见
  final bool visible;

  /// 点击目录项回调
  final Function(int index, double offset)? onItemTap;

  const TocProgressBar({
    super.key,
    required this.items,
    required this.scrollController,
    this.visible = true,
    this.onItemTap,
  });

  @override
  State<TocProgressBar> createState() => _TocProgressBarState();
}

class _TocProgressBarState extends State<TocProgressBar> {
  int _currentIndex = -1;
  double _progress = 0.0;
  bool _showFullToc = false;

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

  /// 滚动监听
  void _onScroll() {
    if (widget.items.isEmpty) return;

    final offset = widget.scrollController.offset;
    final maxScroll = widget.scrollController.position.maxScrollExtent;

    // 计算阅读进度
    final newProgress = maxScroll > 0
        ? (offset / maxScroll).clamp(0.0, 1.0)
        : 0.0;

    // 找到当前章节
    final newIndex = _findCurrentIndex(offset);

    if (newIndex != _currentIndex || newProgress != _progress) {
      setState(() {
        _currentIndex = newIndex;
        _progress = newProgress;
      });
    }
  }

  /// 根据滚动位置找到当前章节索引
  int _findCurrentIndex(double offset) {
    if (widget.items.isEmpty) return -1;

    const threshold = 150.0;
    final adjustedOffset = offset + threshold;

    for (int i = widget.items.length - 1; i >= 0; i--) {
      if (widget.items[i].offset <= adjustedOffset) {
        return i;
      }
    }
    return 0;
  }

  /// 跳转到指定章节
  void _scrollToItem(int index) {
    if (index < 0 || index >= widget.items.length) return;

    final item = widget.items[index];
    final targetOffset = item.offset - 100;

    widget.scrollController.animateTo(
      targetOffset.clamp(0.0, widget.scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    if (widget.onItemTap != null) {
      widget.onItemTap!(index, targetOffset);
    }

    setState(() {
      _currentIndex = index;
      _showFullToc = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible || widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.15)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 进度条
          _buildProgressIndicator(colorScheme),

          // 当前章节和展开按钮
          _buildCurrentSectionBar(colorScheme),

          // 完整目录列表（展开时显示）
          if (_showFullToc) _buildFullTocList(colorScheme),
        ],
      ),
    );
  }

  /// 构建进度指示器
  Widget _buildProgressIndicator(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      height: 3,
      color: colorScheme.surfaceContainerHighest,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: _progress,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(1.5),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建当前章节栏
  Widget _buildCurrentSectionBar(ColorScheme colorScheme) {
    final currentItem = _currentIndex >= 0 && _currentIndex < widget.items.length
        ? widget.items[_currentIndex]
        : null;

    return InkWell(
      onTap: () => setState(() => _showFullToc = !_showFullToc),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // 阅读进度百分比
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(_progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(width: 12),

            // 当前章节标题
            Expanded(
              child: currentItem != null
                  ? Row(
                      children: [
                        Icon(
                          Icons.format_list_bulleted,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            currentItem.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '阅读中...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
            ),

            // 章节计数
            Text(
              '${_currentIndex + 1}/${widget.items.length}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(width: 8),

            // 展开/收起图标
            AnimatedRotation(
              turns: _showFullToc ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建完整目录列表
  Widget _buildFullTocList(ColorScheme colorScheme) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final isActive = index == _currentIndex;
          final isPast = index < _currentIndex;

          return _TocProgressItem(
            text: item.text,
            level: item.level,
            index: index + 1,
            isActive: isActive,
            isPast: isPast,
            onTap: () => _scrollToItem(index),
          );
        },
      ),
    );
  }
}

/// 目录进度项
class _TocProgressItem extends StatelessWidget {
  final String text;
  final int level;
  final int index;
  final bool isActive;
  final bool isPast;
  final VoidCallback onTap;

  const _TocProgressItem({
    required this.text,
    required this.level,
    required this.index,
    required this.isActive,
    required this.isPast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indent = (level - 1) * 20.0;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16 + indent, 10, 16, 10),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primaryContainer.withValues(alpha: 0.4)
              : null,
        ),
        child: Row(
          children: [
            // 序号或完成标记
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.primary
                    : isPast
                        ? colorScheme.primary.withValues(alpha: 0.2)
                        : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isPast && !isActive
                    ? Icon(
                        Icons.check,
                        size: 12,
                        color: colorScheme.primary,
                      )
                    : Text(
                        '$index',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isActive
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: isActive ? FontWeight.w600 : null,
                              fontSize: 11,
                            ),
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // 标题
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      color: isActive
                          ? colorScheme.primary
                          : isPast
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface,
                    ),
              ),
            ),

            // 当前指示器
            if (isActive)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
