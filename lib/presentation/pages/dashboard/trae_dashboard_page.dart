import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/trae_dashboard.dart';
import '../../providers/trae_dashboard_provider.dart';
import '../../widgets/dashboard/activity_heatmap.dart';
import '../../widgets/dashboard/language_bar_chart.dart';
import '../../widgets/dashboard/model_preference_list.dart';
import '../../widgets/dashboard/hourly_activity_curve.dart';
import '../../../core/network/cookie_manager.dart';

/// Trae Dashboard 页面
///
/// 展示用户的 Trae IDE 使用统计数据
/// 包括活跃天数热力图、代码采纳、模型偏好、编程时段等
class TraeDashboardPage extends ConsumerWidget {
  const TraeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardStateNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'TRAE 仪表盘',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              ref.read(dashboardStateNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: dashboardAsync.when(
        data: (data) => _DashboardContent(data: data),
        loading: () => const _LoadingView(),
        error: (error, stackTrace) => _ErrorView(
          error: error.toString(),
          onRetry: () {
            ref.invalidate(dashboardStateNotifierProvider);
          },
        ),
      ),
    );
  }
}

/// Dashboard 内容主体
class _DashboardContent extends StatelessWidget {
  final DashboardData data;

  const _DashboardContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final stats = data.stats;
    final userInfo = data.userInfo;

    return RefreshIndicator(
      onRefresh: () async {
        // 刷新逻辑由外部处理
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息卡片
            _UserInfoCard(
              screenName: userInfo.screenName,
              registerDays: stats.registerDays,
              avatarUrl: userInfo.avatarUrl,
            ),
            const SizedBox(height: 24),

            // 活跃天数热力图
            _SectionTitle(title: '活跃天数', subtitle: '过去一年的编程活跃度'),
            const SizedBox(height: 12),
            ActivityHeatmap(data: stats.sortedDailyActivity),
            const SizedBox(height: 24),

            // 代码采纳统计
            _CodeAcceptCard(stats: stats),
            const SizedBox(height: 24),

            // 对话次数统计
            _ConversationCard(stats: stats),
            const SizedBox(height: 24),

            // 编程语言分布
            _SectionTitle(title: '编程语言分布', subtitle: '近7天代码采纳按语言统计'),
            const SizedBox(height: 12),
            LanguageBarChart(data: stats.sortedLanguageStats),
            const SizedBox(height: 24),

            // AI 模型偏好
            _SectionTitle(title: 'AI 模型偏好', subtitle: '近7天模型调用统计'),
            const SizedBox(height: 12),
            ModelPreferenceList(data: stats.sortedModelStats),
            const SizedBox(height: 24),

            // 编程时段分布
            _SectionTitle(title: '编程时段', subtitle: '24小时活跃分布'),
            const SizedBox(height: 12),
            HourlyActivityCurve(data: stats.hourlyActivityList),
            const SizedBox(height: 32),
          ],
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
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.info_outline,
              color: Colors.white.withOpacity(0.4),
              size: 16,
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
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
      padding: const EdgeInsets.all(20),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF32F08C),
                  borderRadius: BorderRadius.circular(24),
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
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
              ),
              const SizedBox(width: 16),
              // 用户名
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! $screenName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '这是你使用 TRAE IDE 的第 $registerDays 天',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 标签
          Wrap(
            spacing: 8,
            runSpacing: 8,
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF32F08C).withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '# $text',
        style: const TextStyle(
          color: Color(0xFF32F08C),
          fontSize: 12,
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
      padding: const EdgeInsets.all(20),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.4),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${stats.codeAcceptCount7d}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // 语言分布条形图
          if (stats.sortedLanguageStats.isNotEmpty) ...[
            LanguageBarChart(data: stats.sortedLanguageStats.take(4).toList()),
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
      padding: const EdgeInsets.all(20),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.4),
                size: 16,
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
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              if (topAgent != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32F08C).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.smart_toy_outlined,
                        color: Color(0xFF32F08C),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        topAgent.agentName,
                        style: const TextStyle(
                          color: Color(0xFF32F08C),
                          fontSize: 12,
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
                color: const Color(0xFF32F08C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${topAgent.count}',
                style: const TextStyle(
                  color: Color(0xFF32F08C),
                  fontSize: 16,
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF32F08C),
          ),
          SizedBox(height: 16),
          Text(
            '加载中...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

/// 错误视图
class _ErrorView extends StatefulWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  State<_ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<_ErrorView> {
  String? _cookieInfo;

  Future<void> _checkCookies() async {
    final cookies = await TraeCookieManager.getAllCookies();
    setState(() {
      _cookieInfo = 'Cookie 数量: ${cookies.length}\n'
          'Keys: ${cookies.keys.toList()}\n'
          'Has sessionid: ${cookies.containsKey('sessionid')}\n'
          'Has ttwid: ${cookies.containsKey('ttwid')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAuthError = widget.error.contains('未登录') || widget.error.contains('过期');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAuthError ? Icons.lock_outline : Icons.error_outline,
              color: isAuthError ? Colors.orange : Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              isAuthError ? '需要登录' : '加载失败',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isAuthError
                  ? '请先登录 Trae 账号以查看仪表盘数据'
                  : widget.error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            if (isAuthError)
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/login');
                },
                icon: const Icon(Icons.login),
                label: const Text('去登录'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF32F08C),
                  foregroundColor: Colors.black,
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: widget.onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF32F08C),
                  foregroundColor: Colors.black,
                ),
              ),
            const SizedBox(height: 16),
            // 调试按钮
            TextButton.icon(
              onPressed: _checkCookies,
              icon: const Icon(Icons.cookie_outlined, color: Colors.grey),
              label: const Text('查看 Cookie', style: TextStyle(color: Colors.grey)),
            ),
            if (_cookieInfo != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _cookieInfo!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
