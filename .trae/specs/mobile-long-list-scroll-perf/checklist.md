# 移动端长列表滚动性能优化验收清单

## P0-1 滚动触底治理通用组件

- [ ] `lib/core/utils/scroll_load_guard.dart` 文件已创建
- [ ] ScrollLoadGuard 类实现了触底阈值配置（默认 200~240px）
- [ ] 实现了最小触发间隔控制（默认 180ms）
- [ ] 实现了请求中门闩（防止并发重复触发）
- [ ] 提供了 tryTrigger(ScrollController, Future<void> Function()) API
- [ ] 代码包含必要的函数级注释
- [ ] 单元测试覆盖门闩逻辑和间隔控制

## P0-2 滚动触底页面接入

- [ ] `feed_detail_page.dart` 已接入 ScrollLoadGuard
- [ ] `post_reply_list.dart` 已接入 ScrollLoadGuard
- [ ] `user_profile_page.dart` 已接入 ScrollLoadGuard
- [ ] `message_page.dart` 已接入 ScrollLoadGuard
- [ ] `message_detail_page.dart` 已接入 ScrollLoadGuard
- [ ] `search_page.dart` 已接入 ScrollLoadGuard
- [ ] 所有页面加载行为正常，无重复请求

## P0-3 首页高频列表图片链路优化

- [ ] `home_page.dart` line 795 的 Image.network/NetworkImage 已替换
- [ ] `home_page.dart` line 942 的 Image.network/NetworkImage 已替换
- [ ] 列表图片已指定 memCacheWidth/memCacheHeight
- [ ] 首图点击预览行为保持不变
- [ ] `user_avatar.dart` 支持 memCacheWidth/memCacheHeight 参数
- [ ] `cached_image.dart` 缓存策略正确

## P0-4 首页卡片减负

- [ ] 首页卡片 boxShadow 复杂度已降低
- [ ] 视觉层级保留（用户、标题、摘要、操作栏可见）
- [ ] 无视觉回归问题

## P1-1 LazyLoadImage 滚动期延迟加载

- [ ] 移除了"拿到 renderObject 就直接加载"的逻辑
- [ ] 使用 `Scrollable.recommendDeferredLoadingForContext(context)` 判断滚动状态
- [ ] 滚动中展示轻占位
- [ ] 停止滚动后自动加载图片
- [ ] 未引入 visibility_detector

## P1-2 长列表 delegate 参数统一

- [ ] `home_page.dart` cacheExtent 策略统一（基于视口高度倍率）
- [ ] `home_page.dart` 配置了 addAutomaticKeepAlives/addRepaintBoundaries/addSemanticIndexes
- [ ] `ai_news_list_view_v2.dart` cacheExtent 策略统一
- [ ] `ai_news_list_view_v2.dart` 配置了 delegate 参数
- [ ] `post_reply_list.dart` cacheExtent 策略统一
- [ ] `post_reply_list.dart` 配置了 delegate 参数
- [ ] 无无意义 keepAlive 导致内存增长

## P1-3 高频列表页图片二轮替换

- [ ] 用户关注/粉丝列表页头像使用 UserAvatar
- [ ] 浏览历史页缩略图使用 CachedImage
- [ ] 搜索结果页头像/缩略图使用统一组件
- [ ] 主题列表页相关图片使用统一组件
- [ ] 所有替换的图片都指定了 memCacheWidth/memCacheHeight

## 功能验收

- [ ] 下拉刷新功能正常
- [ ] 上拉加载更多功能正常
- [ ] 图片显示正常
- [ ] 图片预览功能正常
- [ ] 进入详情页正常
- [ ] 评论/回复操作正常

## 性能验收

- [ ] 首页连续快速滑动 15 秒，主观无明显卡顿
- [ ] Profile 模式下长列表场景平均 FPS >= 55
- [ ] >16ms 帧占比相对基线改善 20%
- [ ] 图片缓存峰值稳定，无 OOM 风险

## 代码质量验收

- [ ] `flutter analyze` 无 error
- [ ] `flutter test` 通过
- [ ] 新增/改动代码有必要注释
- [ ] 无重复实现
