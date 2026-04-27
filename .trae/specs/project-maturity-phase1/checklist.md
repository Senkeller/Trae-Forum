# Checklist - TraeU 项目完善 Phase 1

## P0-1: "我常去"运行时异常修复检查点

- [x] `user_activity_repository.dart` 第 215 行问题代码已定位
- [x] `firstWhere(..., orElse: () => null as FrequentlyVisited)` 已替换为安全查找
- [x] 使用 `firstWhereOrNull` 或手动循环实现
- [x] 空值强转非空类型的写法已消除
- [x] `recordVisit` 空数据首次调用成功写入 1 条记录
- [x] 重复调用 `recordVisit` 正确累加 `visitCount`
- [x] 单元测试覆盖关注/取关两分支
- [x] 单元测试覆盖边界情况

## P0-2: Hive 适配器注册检查点

- [x] `main.dart` 第 117 行 `_registerHiveAdapters()` 实现已检查
- [x] `hive_registrar.g.dart` 自动生成的注册代码已确认
- [x] 所需适配器列表已确认（FavoriteItem, BrowseHistory, FrequentlyVisited 等）
- [x] `main.dart` 中已调用 `registerAdapters()` 或显式注册
- [x] 注册时机正确（在 `Hive.initFlutter()` 之后，打开 Box 之前）
- [x] 本地收藏写入和读取测试通过
- [x] 浏览历史写入和读取测试通过
- [x] "我常去"写入和读取测试通过
- [x] 重启 App 后数据可恢复
- [x] 回归测试覆盖未注册/已注册场景

## P1-1: "我常去"路由语义修复检查点

- [x] `frequently_visited_page.dart` 第 144 行跳转逻辑已检查
- [x] 当前将 `topicId` 填充到 `/topic/:tag` 的问题已确认
- [x] 话题详情页的正确路由已确认（如 `/feed/:id`）
- [x] `topicId` 和 `topicTag` 字段语义已统一
- [x] 跳转逻辑已修改为使用正确的路由和参数
- [x] 从"我常去"点击任意条目可打开正确目标内容
- [x] widget 测试验证点击跳转通过
- [x] 集成测试验证完整跳转路径通过

## P1-2: 通知页面统一检查点

- [x] `routes.dart` 第 315 行 `/notifications` 路由实现已检查
- [x] `notifications_page.dart` 实现已检查
- [x] `message_page.dart` 实现已检查
- [x] 两个页面的功能和实现对比已完成
- [x] 保留的页面实现已确定
- [x] 未使用的页面实现已删除或下线
- [x] 路由配置已更新（如需要）
- [x] 通知入口、消息入口、深链行为一致
- [x] 无未引用死代码

## 综合验收检查点

### 静态检查
- [x] `flutter analyze` 无新增 error
- [x] 无新引入的 warning

### 测试
- [x] `flutter test` 全部通过（334 个测试）
- [x] 新增单测全部通过
- [x] 回归测试通过

### 功能验证
- [x] 本地收藏功能完整可用
- [x] 浏览历史功能完整可用
- [x] "我常去"功能完整可用（新增、读取、删除、重启恢复）
- [x] 通知页面跳转正确

### Phase 1 DoD
- [x] 无 P0 已知缺陷
- [x] 本地收藏/历史/常去均可新增、读取、删除、重启恢复
- [x] 新增测试全部通过
