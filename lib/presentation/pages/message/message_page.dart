import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';

/// 消息列表页
///
/// 展示各类消息通知，包括：
/// - @我的
/// - 回复
/// - 赞
/// - 关注
/// - 系统消息
class MessagePage extends ConsumerStatefulWidget {
  /// 构造函数
  const MessagePage({super.key});

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

/// 消息页面状态
class _MessagePageState extends ConsumerState<MessagePage>
    with SingleTickerProviderStateMixin {
  /// Tab 控制器
  late TabController _tabController;

  /// 当前选中的消息类型
  MessageType _currentType = MessageType.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: MessageType.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: '全部已读',
            onPressed: () {
              // TODO: 标记全部已读
              _showMarkAllReadDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: '消息设置',
            onPressed: () {
              // TODO: 消息设置
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: MessageType.values.map((type) {
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(type.label),
                  if (type != MessageType.all)
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_getUnreadCount(type)}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          onTap: (index) {
            setState(() {
              _currentType = MessageType.values[index];
            });
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: MessageType.values.map((type) {
          return _MessageList(type: type);
        }).toList(),
      ),
    );
  }

  /// 获取未读消息数量
  ///
  /// [type] 消息类型
  /// 返回该类型的未读消息数量
  int _getUnreadCount(MessageType type) {
    // TODO: 从 Provider 获取实际的未读数量
    final mockCounts = {
      MessageType.mention: 3,
      MessageType.reply: 5,
      MessageType.like: 12,
      MessageType.follow: 2,
      MessageType.system: 1,
    };
    return mockCounts[type] ?? 0;
  }

  /// 显示全部已读确认对话框
  ///
  /// [context] 构建上下文
  void _showMarkAllReadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('标记全部已读'),
        content: const Text('确定要将所有消息标记为已读吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 执行标记已读操作
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

/// 消息列表
///
/// 展示指定类型的消息列表
class _MessageList extends StatelessWidget {
  /// 消息类型
  final MessageType type;

  /// 构造函数
  const _MessageList({required this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: 根据类型加载不同的消息数据
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _MessageItem(
          index: index,
          type: type,
        );
      },
    );
  }
}

/// 消息项
///
/// 单个消息的展示组件
class _MessageItem extends StatelessWidget {
  /// 索引
  final int index;

  /// 消息类型
  final MessageType type;

  /// 构造函数
  const _MessageItem({
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = index < 3;

    return InkWell(
      onTap: () {
        // TODO: 跳转到消息详情或相关页面
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread
              ? colorScheme.primaryContainer.withOpacity(0.3)
              : null,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 发送者头像
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    _getIcon(),
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                if (isUnread)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // 消息内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getTitle(),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight:
                                isUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        '${index + 1}小时前',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getContent(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // 相关内容预览
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '相关内容预览：这是被回复/点赞/提及的动态内容...',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取消息图标
  ///
  /// 根据消息类型返回对应的图标
  IconData _getIcon() {
    switch (type) {
      case MessageType.mention:
        return Icons.alternate_email;
      case MessageType.reply:
        return Icons.comment;
      case MessageType.like:
        return Icons.favorite;
      case MessageType.follow:
        return Icons.person_add;
      case MessageType.system:
        return Icons.notifications;
      case MessageType.all:
        return Icons.forum;
    }
  }

  /// 获取消息标题
  ///
  /// 根据消息类型返回对应的标题
  String _getTitle() {
    switch (type) {
      case MessageType.mention:
        return '用户 $index 提到了你';
      case MessageType.reply:
        return '用户 $index 回复了你';
      case MessageType.like:
        return '用户 $index 赞了你';
      case MessageType.follow:
        return '用户 $index 关注了你';
      case MessageType.system:
        return '系统通知';
      case MessageType.all:
        return '用户 $index';
    }
  }

  /// 获取消息内容
  ///
  /// 根据消息类型返回对应的内容描述
  String _getContent() {
    switch (type) {
      case MessageType.mention:
        return '@了你：这条动态真不错！';
      case MessageType.reply:
        return '回复：同意你的观点，我也这么觉得。';
      case MessageType.like:
        return '赞了你的动态';
      case MessageType.follow:
        return '开始关注你';
      case MessageType.system:
        return '欢迎使用 TRAE Forum！';
      case MessageType.all:
        return '与你互动了';
    }
  }
}

/// 消息分类卡片
///
/// 用于展示消息分类入口（如 @我的、评论、赞等）
class _MessageCategoryCard extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 未读数量
  final int unreadCount;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _MessageCategoryCard({
    required this.icon,
    required this.title,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
            ),
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
