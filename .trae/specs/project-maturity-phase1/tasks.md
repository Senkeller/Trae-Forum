# Tasks - TraeU 项目完善 Phase 1

## 任务概览

基于 `/Users/jason/Documents/codex/TraeU/traeu/docs/SPECS_PROJECT_MATURITY_ASSESSMENT_2026-04-27.md` 的评估，Phase 1 目标是修复所有 P0 缺陷，确保本地数据链路稳定可靠。

---

## Task 1: 修复 "我常去" 运行时异常 (P0-1)

- [x] 分析 `user_activity_repository.dart` 中 `recordVisit` 方法
  - [x] 读取 `lib/data/repositories/user_activity_repository.dart` 第 200-230 行
  - [x] 定位 `firstWhere(..., orElse: () => null as FrequentlyVisited)` 问题代码
  - [x] 理解空集合场景的类型转换错误
- [x] 设计修复方案
  - [x] 确定使用 `firstWhereOrNull` 扩展方法或手动安全查找
  - [x] 检查项目中是否已有 `firstWhereOrNull` 工具方法
- [x] 实现修复
  - [x] 修改 `recordVisit` 方法的安全查找逻辑
  - [x] 消除空值强转非空类型的写法
  - [x] 确保重复访问时 `visitCount` 正确累加
- [x] 添加单元测试
  - [x] 测试空数据首次调用 `recordVisit` 成功写入
  - [x] 测试重复调用正确累加 `visitCount`
  - [x] 测试边界情况（如 topicId 为空、topicName 为空）

---

## Task 2: 接入 Hive 自动注册并验证本地数据链路 (P0-2)

- [x] 分析 Hive 注册现状
  - [x] 读取 `lib/main.dart` 第 100-130 行，查看 `_registerHiveAdapters()` 实现
  - [x] 读取 `lib/hive_registrar.g.dart` 查看自动生成的注册代码
  - [x] 检查哪些适配器需要注册（FavoriteItem, BrowseHistory, FrequentlyVisited 等）
- [x] 实现 Hive 适配器注册
  - [x] 在 `main.dart` 中调用 `registerAdapters()` 或显式注册所需适配器
  - [x] 确保注册在 `Hive.initFlutter()` 之后，打开 Box 之前
- [x] 验证本地数据链路
  - [x] 测试本地收藏写入和读取
  - [x] 测试浏览历史写入和读取
  - [x] 测试"我常去"写入和读取
  - [x] 验证重启后数据可恢复
- [x] 添加回归测试
  - [x] 测试未注册适配器时的失败场景
  - [x] 测试注册后成功的场景

---

## Task 3: 修复 "我常去" 路由语义错误 (P1-1)

- [x] 分析当前路由实现
  - [x] 读取 `lib/presentation/pages/user/frequently_visited_page.dart` 第 130-160 行
  - [x] 查看当前跳转逻辑和路由参数
  - [x] 检查 `TopicDetailPage` 的路由定义和参数语义
- [x] 确定正确路由
  - [x] 确认话题详情页的正确路由（如 `/feed/:id` 或 `/topic/:id`）
  - [x] 统一 `topicId` 和 `topicTag` 字段语义
- [x] 实现修复
  - [x] 修改跳转逻辑，使用正确的路由和参数
  - [x] 更新相关数据模型的字段命名（如需要）
- [x] 添加测试
  - [x] 添加 widget 测试验证点击跳转
  - [x] 添加集成测试验证完整跳转路径

---

## Task 4: 统一通知页面实现 (P1-2)

- [x] 分析通知页面现状
  - [x] 读取 `lib/config/routes.dart` 第 300-330 行，查看 `/notifications` 路由实现
  - [x] 读取 `lib/presentation/pages/notification/notifications_page.dart`
  - [x] 读取 `lib/presentation/pages/message/message_page.dart`
  - [x] 对比两个页面的功能和实现
- [x] 确定保留的实现
  - [x] 评估哪个页面更适合作为通知入口
  - [x] 检查其他页面/组件对这两个页面的引用
- [x] 实现统一
  - [x] 保留选定的页面实现
  - [x] 删除或下线未使用的实现
  - [x] 更新路由配置（如需要）
- [x] 验证一致性
  - [x] 确保通知入口、消息入口、深链行为一致
  - [x] 检查无未引用死代码

---

## Task 5: 综合验证

- [x] 运行静态检查
  - [x] 执行 `flutter analyze`，确保无新增 error
  - [x] 修复任何新引入的 warning
- [x] 运行测试
  - [x] 执行 `flutter test`，确保所有测试通过
  - [x] 特别关注新增的单测
- [x] 功能验证
  - [x] 验证本地收藏功能完整可用
  - [x] 验证浏览历史功能完整可用
  - [x] 验证"我常去"功能完整可用
  - [x] 验证通知页面跳转正确

---

## 任务依赖

```
Task 1 (P0-1) ──┐
                ├──→ Task 5 (综合验证)
Task 2 (P0-2) ──┤
                │
Task 3 (P1-1) ──┤
                │
Task 4 (P1-2) ──┘
```

- Task 1 和 Task 2 可以并行执行
- Task 3 和 Task 4 可以并行执行
- Task 5 必须在所有其他任务完成后执行

---

## 验收检查点

### P0-1 验收
- [x] `recordVisit` 空数据首次调用成功
- [x] 重复调用 `visitCount` 正确累加
- [x] 单元测试覆盖通过

### P0-2 验收
- [x] Hive 适配器注册成功
- [x] 本地收藏可持久化和恢复
- [x] 浏览历史可持久化和恢复
- [x] "我常去"可持久化和恢复

### P1-1 验收
- [x] "我常去"条目跳转到正确页面
- [x] widget/integration 测试通过

### P1-2 验收
- [x] 通知页面实现统一
- [x] 无未引用死代码

### Phase 1 DoD
- [x] `flutter analyze` 无新增 error
- [x] `flutter test` 全部通过
- [x] 无 P0 已知缺陷
