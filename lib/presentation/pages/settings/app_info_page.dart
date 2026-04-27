import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/constants.dart';

/// 应用信息页面
///
/// 展示应用的详细信息，包括：
/// - 项目特性与功能
/// - 使用的技术栈
/// - 开源项目信息
/// - 项目地址
/// - 感谢贡献者
class AppInfoPage extends StatelessWidget {
  /// 构造函数
  const AppInfoPage({super.key});

  /// GitHub 项目地址
  static const String _githubUrl = 'https://github.com/Senkeller/Trae-Forum';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('应用信息'),
      ),
      body: ListView(
        children: [
          // 应用图标和基本信息
          _buildAppHeader(context, colorScheme),

          // 项目特性
          _buildSection(
            context,
            title: '项目特性',
            icon: Icons.featured_play_list_outlined,
            children: [
              _buildFeatureItem(context, '话题浏览', '最新、热门、分类话题列表'),
              _buildFeatureItem(context, '话题详情', '富文本渲染、图片预览、目录导航'),
              _buildFeatureItem(context, '搜索功能', '全文搜索，支持分类筛选'),
              _buildFeatureItem(context, '用户系统', '个人主页、活动历史'),
              _buildFeatureItem(context, '消息通知', '通知列表、标记已读'),
              _buildFeatureItem(context, '本地存储', '浏览历史、本地收藏'),
            ],
          ),

          // 技术栈
          _buildSection(
            context,
            title: '技术栈',
            icon: Icons.code_outlined,
            children: [
              _buildTechItem(context, 'Flutter', '跨平台 UI 框架'),
              _buildTechItem(context, 'Dart', '编程语言'),
              _buildTechItem(context, 'Riverpod', '状态管理'),
              _buildTechItem(context, 'Dio', '网络请求'),
              _buildTechItem(context, 'Hive', '本地存储'),
              _buildTechItem(context, 'Go Router', '路由管理'),
            ],
          ),

          // 开源项目
          _buildSection(
            context,
            title: '开源项目',
            icon: Icons.source_outlined,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '本项目是一个开源的 Trae 论坛第三方客户端，旨在为用户提供更好的移动端浏览体验。',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildLinkButton(
                      context,
                      icon: Icons.link,
                      label: 'GitHub 项目地址',
                      url: _githubUrl,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 感谢贡献者
          _buildSection(
            context,
            title: '感谢贡献者',
            icon: Icons.favorite_outline,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '感谢以下贡献者对本项目的支持：',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildContributorChip(context, '待定 xxx'),
                    const SizedBox(height: 16),
                    Text(
                      '欢迎提交 Issue 和 Pull Request，一起完善这个项目！',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 构建应用头部信息
  ///
  /// [context] 构建上下文
  /// [colorScheme] 颜色方案
  Widget _buildAppHeader(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.forum,
              size: 48,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '版本 ${AppConstants.appVersion}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建章节组件
  ///
  /// [context] 构建上下文
  /// [title] 章节标题
  /// [icon] 章节图标
  /// [children] 章节内容
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  /// 构建特性项
  ///
  /// [context] 构建上下文
  /// [title] 特性标题
  /// [description] 特性描述
  Widget _buildFeatureItem(BuildContext context, String title, String description) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(
        Icons.check_circle_outline,
        color: colorScheme.primary,
        size: 20,
      ),
      title: Text(title),
      subtitle: Text(
        description,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// 构建技术项
  ///
  /// [context] 构建上下文
  /// [name] 技术名称
  /// [description] 技术描述
  Widget _buildTechItem(BuildContext context, String name, String description) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            name.substring(0, 1),
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      title: Text(name),
      subtitle: Text(
        description,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// 构建链接按钮
  ///
  /// [context] 构建上下文
  /// [icon] 按钮图标
  /// [label] 按钮标签
  /// [url] 链接地址
  Widget _buildLinkButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String url,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: () => _launchUrl(context, url),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        minimumSize: const Size(double.infinity, 44),
      ),
    );
  }

  /// 构建贡献者标签
  ///
  /// [context] 构建上下文
  /// [name] 贡献者名称
  Widget _buildContributorChip(BuildContext context, String name) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Wrap(
      spacing: 8,
      children: [
        Chip(
          avatar: Icon(
            Icons.person_outline,
            size: 18,
            color: colorScheme.onSecondaryContainer,
          ),
          label: Text(name),
          backgroundColor: colorScheme.secondaryContainer,
          labelStyle: TextStyle(
            color: colorScheme.onSecondaryContainer,
          ),
        ),
      ],
    );
  }

  /// 打开外部链接
  ///
  /// [context] 构建上下文
  /// [url] 链接地址
  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法打开链接')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('打开链接失败: $e')),
        );
      }
    }
  }
}
