# 移动端长列表滚动性能优化规格说明

## Why

当前 Flutter 应用移动端长列表（首页流、回复流、消息流、搜索结果）滑动时偶发卡顿、掉帧，影响用户体验。需要通过懒构建、减少重绘与主线程负载、图片链路优化、滚动触底触发治理等手段提升滚动性能。

## What Changes

### P0 高优先级任务

1. **新增滚动触底治理通用组件**
   - 新建 `lib/core/utils/scroll_load_guard.dart`
   - 实现"触底阈值 + 最小触发间隔 + 请求中门闩"三件套
   - API 可被页面复用，形态为 `tryTrigger(ScrollController, Future<void> Function())`
   - 默认阈值 200~240px，默认最小间隔 180ms
   - 并发请求禁止重复触发

2. **将滚动触底页面全部接入统一治理**
   - 改造文件：
     - `feed_detail_page.dart`
     - `post_reply_list.dart`
     - `user_profile_page.dart`
     - `message_page.dart`
     - `message_detail_page.dart`
     - `search_page.dart`

3. **首页高频列表图片链路优化**
   - 改造文件：
     - `home_page.dart`
     - `user_avatar.dart`
     - `cached_image.dart`
   - 将首页卡片中的 `Image.network` 与 `NetworkImage` 改为统一缓存组件链路
   - 为列表图片指定 `memCacheWidth/memCacheHeight`（按渲染尺寸估算，避免原图进内存）
   - 首图仍保持可点击预览行为不变

4. **首页卡片减负（低风险）**
   - 改造文件：`home_page.dart`
   - 降低 `boxShadow` 复杂度（减小 blur/alpha 或改轻量边框方案），保留视觉层级
   - 不允许删除核心信息区块（用户、标题、摘要、操作栏）

### P1 中优先级任务

5. **修复 LazyLoadImage 为真实"滚动期延迟加载"**
   - 改造文件：`cached_image.dart`
   - 移除当前"拿到 renderObject 就直接加载"的逻辑
   - 使用 Flutter 原生 `Scrollable.recommendDeferredLoadingForContext(context)` 进行滚动期延迟
   - 滚动中展示轻占位，停止滚动后自动进入图片加载
   - 禁止引入 `visibility_detector`

6. **长列表 delegate 参数统一**
   - 改造文件：
     - `home_page.dart`
     - `ai_news_list_view_v2.dart`
     - `post_reply_list.dart`
   - 统一 `cacheExtent` 策略（基于视口高度倍率，而非固定魔法值）
   - 按场景配置 `addAutomaticKeepAlives/addRepaintBoundaries/addSemanticIndexes`
   - 避免无意义 keepAlive 导致内存增长

7. **高频列表页 Image.network/NetworkImage 二轮替换**
   - 范围优先：用户关注/粉丝/浏览历史/搜索结果/主题列表
   - 只处理长列表内高频头像与缩略图，不触碰详情页大图逻辑

## Impact

### 受影响规格
- 现有列表渲染逻辑
- 图片加载与缓存策略
- 滚动加载更多触发机制

### 受影响代码
- `lib/core/utils/scroll_load_guard.dart` - 新增
- `lib/presentation/pages/home/home_page.dart` - 卡片减负、图片优化
- `lib/presentation/pages/feed/feed_detail_page.dart` - 滚动触底治理
- `lib/presentation/widgets/post_reply_list.dart` - 滚动触底治理
- `lib/presentation/pages/user/user_profile_page.dart` - 滚动触底治理
- `lib/presentation/pages/message/message_page.dart` - 滚动触底治理
- `lib/presentation/pages/message/message_detail_page.dart` - 滚动触底治理
- `lib/presentation/pages/search/search_page.dart` - 滚动触底治理
- `lib/presentation/widgets/user_avatar.dart` - 图片链路优化
- `lib/presentation/widgets/cached_image.dart` - 懒加载修复
- `lib/presentation/widgets/ai_news_list_view_v2.dart` - delegate 参数统一

## ADDED Requirements

### Requirement: 滚动触底治理组件
系统 SHALL 提供一个通用的滚动触底触发控制组件，防止重复触发加载请求。

#### Scenario: 正常触底加载
- **WHEN** 用户滚动列表接近底部（阈值内）
- **AND** 距离上次触发超过最小间隔时间
- **AND** 当前没有正在进行的加载请求
- **THEN** 系统 SHALL 触发加载更多回调

#### Scenario: 快速重复触底
- **WHEN** 用户在短时间内多次触发触底
- **THEN** 系统 SHALL 仅执行第一次有效的加载请求
- **AND** 后续触发在门闩释放前被忽略

### Requirement: 图片内存优化
系统 SHALL 为列表中的图片指定内存缓存尺寸，避免原图直接进入内存。

#### Scenario: 列表图片显示
- **WHEN** 列表项包含网络图片
- **THEN** 系统 SHALL 根据渲染尺寸计算合适的 memCacheWidth/memCacheHeight
- **AND** 图片加载后按指定尺寸缓存，不保留原图

### Requirement: 滚动期图片延迟加载
系统 SHALL 在滚动过程中延迟加载图片，停止滚动后再加载可见区域图片。

#### Scenario: 快速滚动
- **WHEN** 用户快速滑动列表
- **THEN** 系统 SHALL 使用轻量级占位图
- **AND** 滚动停止后自动加载可见区域图片

## MODIFIED Requirements

### Requirement: 首页卡片样式
**原要求**: 首页卡片使用较重的阴影效果
**新要求**: 降低 boxShadow 复杂度，保留视觉层级的同时减少重绘开销

### Requirement: 列表 delegate 配置
**原要求**: 各列表使用独立的 cacheExtent 和 keepAlive 配置
**新要求**: 统一 cacheExtent 策略，基于视口高度倍率；按需配置 keepAlive

## REMOVED Requirements

无

## 硬性约束

1. 不新增依赖（禁止引入新包）
2. 不改变业务行为与视觉主结构
3. 每个改造点必须有回归验证
4. 改造后必须通过 `flutter analyze`、`flutter test`

## 验收标准（DoD）

### 功能验收
- 下拉刷新、上拉加载、图片显示、图片预览、进入详情、评论/回复操作行为与改造前一致

### 性能验收
- 首页连续快速滑动 15 秒，主观无明显卡顿
- Profile 模式下长列表场景平均 FPS 目标 >= 55
- 长列表场景中 >16ms 帧占比明显下降（相对基线至少改善 20%）
- 图片缓存峰值稳定，无明显 OOM 风险增长

### 代码验收
- `flutter analyze` 通过
- `flutter test` 通过
- 新增/改动代码有必要注释，且无重复实现
