import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';

/// 用户资料页
///
/// 展示用户的个人信息、动态列表、关注/粉丝数等
/// 支持查看自己的资料或其他用户的资料
class UserProfilePage extends ConsumerStatefulWidget {
  /// 用户 ID，为空时表示当前登录用户
  final String? uid;

  /// 构造函数
  const UserProfilePage({
    super.key,
    this.uid,
  });

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

/// 用户资料页状态
class _UserProfilePageState extends ConsumerState<UserProfilePage>
    with SingleTickerProviderStateMixin {
  /// Tab 控制器
  late TabController _tabController;

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 判断是否为自己的资料页
  bool get _isOwnProfile => widget.uid == null || widget.uid == 'current_user';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // 顶部导航栏
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              title: const Text('个人主页'),
              actions: [
                if (_isOwnProfile) ...[
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      context.push(RoutePaths.settings);
                    },
                  ),
                ] else ...[
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showMoreOptions(context),
                  ),
                ],
              ],
            ),
            // 用户信息头部
            SliverToBoxAdapter(
              child: _ProfileHeader(
                isOwnProfile: _isOwnProfile,
              ),
            ),
            // Tab 栏
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '动态'),
                    Tab(text: '收藏'),
                    Tab(text: '赞过'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _FeedList(),
            _FeedList(),
            _FeedList(),
          ],
        ),
      ),
    );
  }

  /// 显示更多选项菜单
  ///
  /// [context] 构建上下文
  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('举报用户'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('加入黑名单'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 个人资料头部
///
/// 展示用户头像、昵称、简介、统计数据等
class _ProfileHeader extends StatelessWidget {
  /// 是否为自己的资料
  final bool isOwnProfile;

  /// 构造函数
  const _ProfileHeader({required this.isOwnProfile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像和基本信息行
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头像
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primaryContainer,
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 统计信息
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      count: '128',
                      label: '动态',
                      onTap: () {},
                    ),
                    _StatItem(
                      count: '256',
                      label: '关注',
                      onTap: () {
                        context.push('/user/123/follows');
                      },
                    ),
                    _StatItem(
                      count: '1.2k',
                      label: '粉丝',
                      onTap: () {
                        context.push('/user/123/fans');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 用户名和认证标识
          Row(
            children: [
              Text(
                isOwnProfile ? '我的昵称' : '用户昵称',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.verified,
                size: 18,
                color: colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // 用户 ID
          Text(
            '@userid123',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          // 个人简介
          Text(
            '这里是个人简介，可以写一些关于自己的介绍。热爱技术，喜欢分享。',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          // 其他信息
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '北京',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.link,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                'github.com/username',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 操作按钮
          if (isOwnProfile)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.push(RoutePaths.userEdit);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('编辑资料'),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('关注'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('私信'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// 统计项组件
///
/// 展示用户的统计数据（动态数、关注数、粉丝数）
class _StatItem extends StatelessWidget {
  /// 数量
  final String count;

  /// 标签
  final String label;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _StatItem({
    required this.count,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Text(
              count,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Sliver TabBar 委托
///
/// 用于在 Sliver 中固定 TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  /// TabBar
  final TabBar tabBar;

  /// 构造函数
  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

/// Feed 列表
///
/// 展示用户的动态列表
class _FeedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _FeedCard(index: index);
      },
    );
  }
}

/// Feed 卡片
///
/// 单个动态项的展示卡片
class _FeedCard extends StatelessWidget {
  /// 索引
  final int index;

  /// 构造函数
  const _FeedCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          context.push('/feed/$index');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '这是第 $index 条动态的内容，展示在用户主页的动态列表中。',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              if (index % 2 == 0)
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '${index + 1}天前',
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  _ActionButton(
                    icon: Icons.thumb_up_outlined,
                    label: '${index * 5 + 3}',
                    onTap: () {},
                  ),
                  _ActionButton(
                    icon: Icons.comment_outlined,
                    label: '${index * 2 + 1}',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 操作按钮
///
/// 用于点赞、评论等操作
class _ActionButton extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标签
  final String label;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
