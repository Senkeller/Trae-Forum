import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/trae_dashboard.dart';
import '../../providers/trae_dashboard_provider.dart';
import 'activity_heatmap.dart';
import 'hourly_activity_curve.dart';

/// 嵌入式 TRAE 仪表盘（Banner 滑动版）
///
/// 在“我的”页面使用可左右滑动的单区域展示 6 个模块，
/// 避免 6 个模块直接纵向堆叠。
class EmbeddedTraeDashboard extends ConsumerWidget {
  const EmbeddedTraeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardStateNotifierProvider);

    return dashboardAsync.when(
      data: (data) => _DashboardBannerContent(
        data: data,
        onRefresh: () =>
            ref.read(dashboardStateNotifierProvider.notifier).refresh(),
      ),
      loading: () => const _LoadingView(),
      error: (error, stackTrace) => _ErrorView(
        error: error.toString(),
        onRetry: () => ref.invalidate(dashboardStateNotifierProvider),
      ),
    );
  }
}

class _DashboardBannerContent extends StatefulWidget {
  final DashboardData data;
  final Future<void> Function() onRefresh;

  const _DashboardBannerContent({required this.data, required this.onRefresh});

  @override
  State<_DashboardBannerContent> createState() =>
      _DashboardBannerContentState();
}

class _DashboardBannerContentState extends State<_DashboardBannerContent> {
  static const double _bannerHeight = 220;
  static const int _maxLanguageItems = 3;
  static const int _maxModelItems = 3;

  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.97);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = widget.data.stats;
    final modules = _buildModules(stats);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: const Color(0xFF121317),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                const Text(
                  'TRAE 仪表盘',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_currentPage + 1}/${modules.length}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: widget.onRefresh,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white70,
                    size: 16,
                  ),
                  tooltip: '刷新',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: _bannerHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: modules.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final module = modules[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _BannerModulePage(
                    title: module.title,
                    subtitle: module.subtitle,
                    child: module.child,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(modules.length, (index) {
              final active = _currentPage == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: active ? 14 : 5,
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF32F08C) : Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: () => context.push(RoutePaths.traeDashboard),
              icon: const Icon(Icons.open_in_full, size: 16),
              label: const Text('查看完整数据'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF262A30),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_BannerModule> _buildModules(TraeUserStats stats) {
    final languageTop = stats.sortedLanguageStats
        .take(_maxLanguageItems)
        .toList();
    final modelTop = stats.sortedModelStats.take(_maxModelItems).toList();

    return [
      _BannerModule(
        title: '活跃天数',
        subtitle: '过去一年的编程活跃度',
        child: ActivityHeatmap(data: stats.sortedDailyActivity),
      ),
      _BannerModule(
        title: '近期生成代码采纳次数',
        subtitle: null,
        child: _CodeAcceptContent(
          stats: stats,
          languageData: languageTop,
          omittedLanguageCount:
              stats.sortedLanguageStats.length - languageTop.length,
        ),
      ),
      _BannerModule(
        title: '近期对话次数',
        subtitle: null,
        child: _ConversationContent(stats: stats),
      ),
      _BannerModule(
        title: '语言/模型概览',
        subtitle: '排行信息已精简展示',
        child: _CompactRankingContent(
          languageTop: languageTop,
          modelTop: modelTop,
          omittedLanguageCount:
              stats.sortedLanguageStats.length - languageTop.length,
          omittedModelCount: stats.sortedModelStats.length - modelTop.length,
        ),
      ),
      _BannerModule(
        title: '编程时段',
        subtitle: '24小时活跃分布',
        child: HourlyActivityCurve(data: stats.hourlyActivityList),
      ),
    ];
  }
}

class _BannerModule {
  final String title;
  final String? subtitle;
  final Widget child;

  const _BannerModule({
    required this.title,
    this.subtitle,
    required this.child,
  });
}

class _BannerModulePage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const _BannerModulePage({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.info_outline,
                size: 14,
                color: Colors.white.withValues(alpha: 0.42),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              subtitle!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.48),
                fontSize: 12,
              ),
            ),
          ),
        ],
        const SizedBox(height: 6),
        Expanded(child: child),
      ],
    );
  }
}

class _DarkCard extends StatelessWidget {
  final Widget child;

  const _DarkCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _CodeAcceptContent extends StatelessWidget {
  final TraeUserStats stats;
  final List<LanguageStat> languageData;
  final int omittedLanguageCount;

  const _CodeAcceptContent({
    required this.stats,
    required this.languageData,
    required this.omittedLanguageCount,
  });

  @override
  Widget build(BuildContext context) {
    return _DarkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${stats.codeAcceptCount7d}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '近7天采纳总量',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...languageData
                    .take(2)
                    .map(
                      (language) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _CompactStatRow(
                          label: language.language,
                          value: '${language.count}',
                        ),
                      ),
                    ),
                if (omittedLanguageCount > 0)
                  Text(
                    '已省略 $omittedLanguageCount 项',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.52),
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConversationContent extends StatelessWidget {
  final TraeUserStats stats;

  const _ConversationContent({required this.stats});

  @override
  Widget build(BuildContext context) {
    final topAgent = stats.sortedAgentStats.isNotEmpty
        ? stats.sortedAgentStats.first
        : null;

    return _DarkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.conversationCount7d}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  height: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              if (topAgent != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32F08C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (topAgent != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F4D3F), Color(0xFF1C453A)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    '${topAgent.count}',
                    style: const TextStyle(
                      color: Color(0xFF32F08C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Top 模型对话次数',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompactRankingContent extends StatelessWidget {
  final List<LanguageStat> languageTop;
  final List<ModelStat> modelTop;
  final int omittedLanguageCount;
  final int omittedModelCount;

  const _CompactRankingContent({
    required this.languageTop,
    required this.modelTop,
    required this.omittedLanguageCount,
    required this.omittedModelCount,
  });

  @override
  Widget build(BuildContext context) {
    return _DarkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '语言 TOP',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.62),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          ...languageTop
              .take(2)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _CompactStatRow(
                    label: item.language,
                    value: '${item.count}',
                  ),
                ),
              ),
          const SizedBox(height: 2),
          Text(
            '模型 TOP',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.62),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          ...modelTop
              .take(2)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _CompactStatRow(
                    label: item.modelName,
                    value: '${item.count}',
                  ),
                ),
              ),
          if (omittedLanguageCount > 0 || omittedModelCount > 0)
            Text(
              '更多排行已省略，进入完整仪表盘查看',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}

class _CompactStatRow extends StatelessWidget {
  final String label;
  final String value;

  const _CompactStatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF32F08C),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF121317),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF32F08C),
            ),
          ),
          SizedBox(width: 10),
          Text('加载仪表盘中...', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isAuthError =
        error.contains('未登录') ||
        error.contains('过期') ||
        error.contains('NO_COOKIES') ||
        error.contains('UNAUTHORIZED');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121317),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAuthError ? '仪表盘登录凭证失效' : '仪表盘加载失败',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isAuthError ? '请重新登录 Trae 后再重试。' : '网络或服务异常，请稍后重试。',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('重试'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF262A30),
              foregroundColor: Colors.white,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
