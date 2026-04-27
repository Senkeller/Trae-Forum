# 移动端长列表滚动性能优化任务清单

## P0 高优先级任务

### Task P0-1: 新增滚动触底治理通用组件
**目标**: 实现通用的滚动触底触发控制组件
- [ ] 创建 `lib/core/utils/scroll_load_guard.dart`
- [ ] 实现 ScrollLoadGuard 类，包含：
  - [ ] 触底阈值配置（默认 200~240px）
  - [ ] 最小触发间隔（默认 180ms）
  - [ ] 请求中门闩（防止并发重复触发）
  - [ ] tryTrigger(ScrollController, Future<void> Function()) API
- [ ] 添加必要的注释说明
- [ ] 单元测试：验证门闩逻辑、间隔控制

### Task P0-2: 将滚动触底页面全部接入统一治理
**目标**: 所有使用滚动触底加载的页面接入 ScrollLoadGuard
- [ ] 改造 `feed_detail_page.dart` (line 71)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常
- [ ] 改造 `post_reply_list.dart` (line 62)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常
- [ ] 改造 `user_profile_page.dart` (line 40)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常
- [ ] 改造 `message_page.dart` (line 248)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常
- [ ] 改造 `message_detail_page.dart` (line 88)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常
- [ ] 改造 `search_page.dart` (line 42)
  - [ ] 引入 ScrollLoadGuard
  - [ ] 替换原有滚动监听逻辑
  - [ ] 验证加载行为正常

### Task P0-3: 首页高频列表图片链路优化
**目标**: 优化首页列表图片加载，减少内存占用
- [ ] 改造 `home_page.dart`
  - [ ] 定位 line 795 和 line 942 的 Image.network/NetworkImage 使用
  - [ ] 替换为 CachedImage 或 UserAvatar 组件
  - [ ] 为列表图片指定 memCacheWidth/memCacheHeight
  - [ ] 确保首图点击预览行为不变
- [ ] 检查 `user_avatar.dart`
  - [ ] 确认已支持 memCacheWidth/memCacheHeight 参数
  - [ ] 必要时添加参数支持
- [ ] 检查 `cached_image.dart`
  - [ ] 确认已支持 memCacheWidth/memCacheHeight 参数
  - [ ] 确保缓存策略正确

### Task P0-4: 首页卡片减负
**目标**: 降低首页卡片渲染开销
- [ ] 改造 `home_page.dart`
  - [ ] 定位卡片 boxShadow 配置
  - [ ] 降低 blur/alpha 值，或改为轻量边框方案
  - [ ] 保留视觉层级（用户、标题、摘要、操作栏可见性）
  - [ ] 视觉回归验证

## P1 中优先级任务

### Task P1-1: 修复 LazyLoadImage 为真实"滚动期延迟加载"
**目标**: 实现真正的滚动期图片延迟加载
- [ ] 改造 `cached_image.dart` (line 369)
  - [ ] 移除"拿到 renderObject 就直接加载"的逻辑
  - [ ] 使用 `Scrollable.recommendDeferredLoadingForContext(context)` 判断滚动状态
  - [ ] 滚动中展示轻占位（如灰色背景或缩略图）
  - [ ] 停止滚动后自动进入图片加载
  - [ ] 禁止引入 visibility_detector

### Task P1-2: 长列表 delegate 参数统一
**目标**: 统一长列表的 cacheExtent 和 keepAlive 配置
- [ ] 改造 `home_page.dart`
  - [ ] 统一 cacheExtent 策略（基于视口高度倍率）
  - [ ] 配置 addAutomaticKeepAlives/addRepaintBoundaries/addSemanticIndexes
  - [ ] 避免无意义 keepAlive
- [ ] 改造 `ai_news_list_view_v2.dart`
  - [ ] 统一 cacheExtent 策略
  - [ ] 配置 delegate 参数
- [ ] 改造 `post_reply_list.dart`
  - [ ] 统一 cacheExtent 策略
  - [ ] 配置 delegate 参数

### Task P1-3: 高频列表页 Image.network/NetworkImage 二轮替换
**目标**: 替换其他高频列表页的图片组件
- [ ] 用户关注/粉丝列表页
  - [ ] 替换头像为 UserAvatar
  - [ ] 指定 memCacheWidth/memCacheHeight
- [ ] 浏览历史页
  - [ ] 替换缩略图为 CachedImage
  - [ ] 指定 memCacheWidth/memCacheHeight
- [ ] 搜索结果页
  - [ ] 替换头像/缩略图为统一组件
  - [ ] 指定 memCacheWidth/memCacheHeight
- [ ] 主题列表页
  - [ ] 替换相关图片为统一组件
  - [ ] 指定 memCacheWidth/memCacheHeight

## 验收任务

### Task V1: 功能回归验证
- [ ] 下拉刷新功能正常
- [ ] 上拉加载更多功能正常
- [ ] 图片显示正常
- [ ] 图片预览功能正常
- [ ] 进入详情页正常
- [ ] 评论/回复操作正常

### Task V2: 性能验证
- [ ] 首页连续快速滑动 15 秒，主观无明显卡顿
- [ ] Profile 模式下长列表场景平均 FPS >= 55
- [ ] >16ms 帧占比相对基线改善 20%
- [ ] 图片缓存峰值稳定

### Task V3: 代码质量验证
- [ ] `flutter analyze` 通过
- [ ] `flutter test` 通过
- [ ] 新增/改动代码有必要注释

## 任务依赖关系

```
P0-1 (ScrollLoadGuard) → P0-2 (页面接入)
                     ↓
P0-3 (图片链路) → P0-4 (卡片减负) → P1-1 (LazyLoadImage)
                     ↓
                  P1-2 (delegate) → P1-3 (二轮替换)
                     ↓
                  V1/V2/V3 (验收)
```
