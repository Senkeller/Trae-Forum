import 'package:flutter/material.dart';
import '../../../core/services/emoji_cache_service.dart';

/// 表情包选择器面板
///
/// 支持以下功能：
/// - Unicode 表情选择
/// - 自定义表情包选择
/// - 最近使用记录（本地缓存）
/// - 分类浏览
///
/// 使用示例：
/// ```dart
/// EmojiPickerPanel(
///   onEmojiSelected: (emoji) => print('选中: $emoji'),
///   onStickerSelected: (url) => print('选中表情包: $url'),
///   stickerUrls: ['https://example.com/sticker1.png', ...],
/// )
/// ```
class EmojiPickerPanel extends StatefulWidget {
  /// Unicode 表情选择回调
  final Function(String emoji)? onEmojiSelected;

  /// 表情包（图片）选择回调
  final Function(String imageUrl)? onStickerSelected;

  /// 自定义表情包 URL 列表
  final List<String> stickerUrls;

  /// 面板高度
  final double height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 构造函数
  ///
  /// [onEmojiSelected] Unicode 表情选择回调
  /// [onStickerSelected] 表情包选择回调
  /// [stickerUrls] 自定义表情包 URL 列表
  /// [height] 面板高度，默认 300
  /// [backgroundColor] 背景颜色
  const EmojiPickerPanel({
    super.key,
    this.onEmojiSelected,
    this.onStickerSelected,
    this.stickerUrls = const [],
    this.height = 300,
    this.backgroundColor,
  });

  @override
  State<EmojiPickerPanel> createState() => _EmojiPickerPanelState();
}

class _EmojiPickerPanelState extends State<EmojiPickerPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final EmojiCacheService _cacheService = EmojiCacheService();
  List<String> _recentEmojis = [];
  List<String> _recentStickers = [];

  // 默认表情分类
  static final Map<String, List<String>> _emojiCategories = {
    '常用': [
      '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
      '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
      '👍', '👎', '👏', '🙌', '🤝', '❤️', '💔', '🔥',
    ],
    '表情': [
      '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
      '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
      '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
      '🤪', '🤨', '🧐', '🤓', '😎', '🥸', '🤩', '🥳',
      '😏', '😒', '😞', '😔', '😟', '😕', '🙁', '☹️',
      '😣', '😖', '😫', '😩', '🥺', '😢', '😭', '😤',
      '😠', '😡', '🤬', '🤯', '😳', '🥵', '🥶', '😱',
      '😨', '😰', '😥', '😓', '🤗', '🤔', '🤭', '🤫',
    ],
    '手势': [
      '👍', '👎', '👏', '🙌', '🤝', '🤞', '✌️', '🤟',
      '🤘', '👌', '🤌', '🤏', '👈', '👉', '👆', '👇',
      '☝️', '✋', '🤚', '🖐️', '🖖', '👋', '🤙', '💪',
      '🦾', '🖕', '✍️', '🙏', '🦶', '🦵', '🦿', '👂',
    ],
    '爱心': [
      '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
      '🤎', '💔', '❣️', '💕', '💞', '💓', '💗', '💖',
      '💘', '💝', '💟', '☮️', '✝️', '☪️', '🕉️', '☸️',
    ],
    '其他': [
      '🔥', '⭐', '✨', '💯', '💢', '💥', '💫', '💦',
      '💨', '🕳️', '💣', '💬', '👁️‍🗨️', '🗨️', '🗯️', '💭',
      '💤', '👋', '🤚', '🖐️', '✋', '🖖', '👌', '🤌',
    ],
  };

  @override
  void initState() {
    super.initState();
    final tabCount = 2 + (widget.stickerUrls.isNotEmpty ? 1 : 0);
    _tabController = TabController(length: tabCount, vsync: this);
    _loadRecentEmojis();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 加载最近使用的表情
  void _loadRecentEmojis() {
    setState(() {
      _recentEmojis = _cacheService.getRecentEmojis();
      _recentStickers = _cacheService.getRecentStickerEmojis();
    });
  }

  /// 处理 Unicode 表情选择
  void _onEmojiSelected(String emoji) {
    _cacheService.recordEmojiUsage(emoji);
    setState(() {
      if (!_recentEmojis.contains(emoji)) {
        _recentEmojis.insert(0, emoji);
        if (_recentEmojis.length > 30) {
          _recentEmojis.removeLast();
        }
      } else {
        // 移动到最前面
        _recentEmojis.remove(emoji);
        _recentEmojis.insert(0, emoji);
      }
    });
    widget.onEmojiSelected?.call(emoji);
  }

  /// 处理表情包选择
  void _onStickerSelected(String imageUrl) {
    _cacheService.recordStickerUsage(imageUrl);
    setState(() {
      if (!_recentStickers.contains(imageUrl)) {
        _recentStickers.insert(0, imageUrl);
        if (_recentStickers.length > 30) {
          _recentStickers.removeLast();
        }
      } else {
        _recentStickers.remove(imageUrl);
        _recentStickers.insert(0, imageUrl);
      }
    });
    widget.onStickerSelected?.call(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          // Tab 栏
          TabBar(
            controller: _tabController,
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            indicatorColor: colorScheme.primary,
            tabs: [
              const Tab(text: '最近'),
              const Tab(text: '表情'),
              if (widget.stickerUrls.isNotEmpty) const Tab(text: '表情包'),
            ],
          ),

          // Tab 内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 最近使用
                _buildRecentTab(),
                // 表情分类
                _buildEmojiTab(),
                // 表情包
                if (widget.stickerUrls.isNotEmpty) _buildStickerTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建最近使用标签页
  Widget _buildRecentTab() {
    final hasRecentEmojis = _recentEmojis.isNotEmpty;
    final hasRecentStickers = _recentStickers.isNotEmpty;

    if (!hasRecentEmojis && !hasRecentStickers) {
      return const Center(
        child: Text(
          '暂无最近使用记录',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 最近使用的 Unicode 表情
          if (hasRecentEmojis) ...[
            const Text(
              '最近使用表情',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildEmojiGrid(_recentEmojis),
            if (hasRecentStickers) const SizedBox(height: 24),
          ],

          // 最近使用的表情包
          if (hasRecentStickers) ...[
            const Text(
              '最近使用表情包',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildStickerGrid(_recentStickers),
          ],
        ],
      ),
    );
  }

  /// 构建表情标签页
  Widget _buildEmojiTab() {
    return DefaultTabController(
      length: _emojiCategories.length,
      child: Column(
        children: [
          // 子分类 Tab 栏
          TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: _emojiCategories.keys.map((name) => Tab(text: name)).toList(),
          ),

          // 子分类内容
          Expanded(
            child: TabBarView(
              children: _emojiCategories.values.map((emojis) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildEmojiGrid(emojis),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建表情包标签页
  Widget _buildStickerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildStickerGrid(widget.stickerUrls),
    );
  }

  /// 构建表情网格
  Widget _buildEmojiGrid(List<String> emojis) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        childAspectRatio: 1,
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        final emoji = emojis[index];
        return GestureDetector(
          onTap: () => _onEmojiSelected(emoji),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      },
    );
  }

  /// 构建表情包网格
  Widget _buildStickerGrid(List<String> urls) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: urls.length,
      itemBuilder: (context, index) {
        final url = urls[index];
        return GestureDetector(
          onTap: () => _onStickerSelected(url),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
