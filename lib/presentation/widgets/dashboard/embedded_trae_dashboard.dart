import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/trae_dashboard.dart';
import '../../providers/trae_dashboard_provider.dart';
import 'activity_heatmap.dart';
import 'language_bar_chart.dart';
import 'model_preference_list.dart';
import 'hourly_activity_curve.dart';

/// 嵌入式 TRAE 仪表盘组件
///
/// 将完整的仪表盘功能直接嵌入到页面中展示
/// 包含：用户信息、活跃热力图、代码采纳、对话次数、语言分布、模型偏好、编程时段
class EmbeddedTraeDashboard extends ConsumerWidget {
  const EmbeddedTraeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardStateNotifierProvider);

    return dashboardAsync.when(
      data: (data) => _DashboardContent(
        data: data,
        onRefresh: () =>
            ref.read(dashboardStateNotifierProvider.notifier).refresh(),
      ),
      loading: () => const _LoadingView(),
      error: (error, stackTrace) => _ErrorView(
        error: error.toString(),
        onRetry: () {
          ref.invalidate(dashboardStateNotifierProvider);
        },
      ),
    );
  }
}

/// 仪表盘内容主体
class _DashboardContent extends StatelessWidget {
  final DashboardData data;
  final Future<void> Function() onRefresh;

  const _DashboardContent({required this.data, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final stats = data.stats;
    final userInfo = data.userInfo;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          color: const Color(0xFF32F08C),
          backgroundColor: const Color(0xFF252525),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头部标题
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dashboard_outlined,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TRAE 仪表盘',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => onRefresh(),
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white54,
                        size: 18,
                      ),
                      tooltip: '刷新数据',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 用户信息卡片
                _UserInfoCard(
                  screenName: userInfo.screenName,
                  registerDays: stats.registerDays,
                  avatarUrl: userInfo.avatarUrl,
                ),
                const SizedBox(height: 20),

                // 活跃天数热力图
                _SectionTitle(title: '活跃天数', subtitle: '过去一年的编程活跃度'),
                const SizedBox(height: 12),
                ActivityHeatmap(data: stats.sortedDailyActivity),
                const SizedBox(height: 20),

                // 代码采纳统计
                _CodeAcceptCard(stats: stats),
                const SizedBox(height: 20),

                // 对话次数统计
                _ConversationCard(stats: stats),
                const SizedBox(height: 20),

                // 编程语言分布
                _SectionTitle(title: '编程语言分布', subtitle: '近7天代码采纳按语言统计'),
                const SizedBox(height: 12),
                LanguageBarChart(data: stats.sortedLanguageStats),
                const SizedBox(height: 20),

                // AI 模型偏好
                _SectionTitle(title: 'AI 模型偏好', subtitle: '近7天模型调用统计'),
                const SizedBox(height: 12),
                ModelPreferenceList(data: stats.sortedModelStats),
                const SizedBox(height: 20),

                // 编程时段分布
                _SectionTitle(title: '编程时段', subtitle: '24小时活跃分布'),
                const SizedBox(height: 12),
                HourlyActivityCurve(data: stats.hourlyActivityList),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 区块标题
class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionTitle({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.info_outline,
              color: Colors.white.withValues(alpha: 0.4),
              size: 14,
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }
}

/// 用户信息卡片
class _UserInfoCard extends StatelessWidget {
  final String screenName;
  final int registerDays;
  final String? avatarUrl;

  const _UserInfoCard({
    required this.screenName,
    required this.registerDays,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 头像
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF32F08C),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.person, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              // 用户名
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! $screenName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '这是你使用 TRAE IDE 的第 $registerDays 天',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 标签
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildTag('满勤码神'),
              _buildTag('智能体饲养员'),
              _buildTag('单模型挚友'),
              _buildTag('编程夜行侠'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF32F08C).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '# $text',
        style: const TextStyle(
          color: Color(0xFF32F08C),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// 代码采纳统计卡片
class _CodeAcceptCard extends StatelessWidget {
  final TraeUserStats stats;

  const _CodeAcceptCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '近期生成代码采纳次数',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Colors.white.withValues(alpha: 0.4),
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${stats.codeAcceptCount7d}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 语言分布条形图
          if (stats.sortedLanguageStats.isNotEmpty) ...[
            LanguageBarChart(
              data: stats.sortedLanguageStats.take(4).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

/// 对话次数统计卡片
class _ConversationCard extends StatelessWidget {
  final TraeUserStats stats;

  const _ConversationCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final topAgent = stats.sortedAgentStats.isNotEmpty
        ? stats.sortedAgentStats.first
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '近期对话次数',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Colors.white.withValues(alpha: 0.4),
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.conversationCount7d}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              if (topAgent != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32F08C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.smart_toy_outlined,
                        color: Color(0xFF32F08C),
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        topAgent.agentName,
                        style: const TextStyle(
                          color: Color(0xFF32F08C),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (topAgent != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF32F08C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${topAgent.count}',
                style: const TextStyle(
                  color: Color(0xFF32F08C),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 加载视图
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF32F08C),
              strokeWidth: 2,
            ),
            SizedBox(height: 16),
            Text(
              '加载仪表盘数据...',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// 错误视图
class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isAuthError =
        error.contains('未登录') || error.contains('过期') || error.contains('NO_COOKIES');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAuthError ? Icons.lock_outline : Icons.error_outline,
            color: isAuthError ? Colors.orange : Colors.red,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            isAuthError ? '需要登录' : '加载失败',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isAuthError ? '请先登录 Trae 账号以查看仪表盘数据' : error,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('重试'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF32F08C),
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
