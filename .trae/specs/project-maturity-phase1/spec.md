# TraeU 项目完善 Phase 1 规格文档

## Why

基于 `/Users/jason/Documents/codex/TraeU/traeu/docs/SPECS_PROJECT_MATURITY_ASSESSMENT_2026-04-27.md` 的评估，当前项目存在以下 P0 级严重问题：

1. **Bug P0-1**: "我常去"首次写入会触发运行时异常（`firstWhere` 空值强转错误）
2. **Bug P0-2**: 本地收藏/浏览历史/常去链路因 Hive 适配器未注册而失效
3. **Bug P1-1**: "我常去"跳转路由参数语义错误（将 topicId 填充到 `/topic/:tag`）
4. **Bug P1-2**: 通知页路由实现不一致，存在死代码与行为漂移风险

目标：在 1-2 天内修复所有 P0 缺陷，确保本地数据链路稳定可靠。

## What Changes

### Phase 1-1: 修复 "我常去" 运行时异常 (P0-1)

#### 问题
- 位置: `lib/data/repositories/user_activity_repository.dart:215`
- 现象: `firstWhere(..., orElse: () => null as FrequentlyVisited)` 在空集合场景产生错误类型转换
- 影响: "我常去"首次记录访问可能直接失败

#### 方案
- 改为安全查找逻辑（使用 `firstWhereOrNull` 或手动循环）
- 消除"空值强转非空类型"写法

#### 验收
- 空数据首次调用 `recordVisit` 成功写入 1 条记录
- 重复调用可正确累加 `visitCount`
- 增加仓库单测覆盖以上两路径

### Phase 1-2: 接入 Hive 自动注册并验证本地数据链路 (P0-2)

#### 问题
- 位置: `lib/main.dart:117`
- 现象: 初始化中调用了 `_registerHiveAdapters()`，但实际注册语句被注释
- 影响: 本地收藏、浏览历史、我常去等依赖 Hive typed box 的功能可能写入失败

#### 方案
- 在启动初始化中调用生成的 `registerAdapters()`（或显式逐个注册）
- 增加"未注册时失败 / 注册后成功"的回归测试

#### 验收
- 本地收藏、新增历史、常去写入可成功持久化
- 重启 App 后数据可恢复

### Phase 1-3: 修复 "我常去" 路由语义错误 (P1-1)

#### 问题
- 位置: `lib/presentation/pages/user/frequently_visited_page.dart:144`
- 现象: 将 `topicId` 填充到 `/topic/:tag`，而 `TopicDetailPage` 语义是"标签详情页"
- 影响: 点击"我常去"条目可能进入错误页面

#### 方案
- 改为跳转真正的话题详情路由（如 `/feed/:id`）
- 统一 `topicId / topicTag` 字段语义

#### 验收
- 从"我常去"点击任意条目均可打开正确目标内容
- 增加 widget/integration 用例验证跳转路径

### Phase 1-4: 统一通知页面实现 (P1-2)

#### 问题
- 位置: `lib/config/routes.dart:315`
- 现象: `/notifications` 路由实际返回 `MessagePage`，但独立 `NotificationsPage` 已实现
- 影响: 同域功能存在两套页面实现，维护易出现修一处漏一处

#### 方案
- 明确保留单一通知页面实现
- 删除或下线路由未使用实现，避免双轨并行

#### 验收
- 通知入口、消息入口、深链行为一致
- 相关页面无未引用死代码

## Impact

### 受影响代码
- `lib/data/repositories/user_activity_repository.dart` - P0-1 修复
- `lib/main.dart` - P0-2 Hive 注册
- `lib/hive_registrar.g.dart` - P0-2 适配器注册
- `lib/presentation/pages/user/frequently_visited_page.dart` - P1-1 路由修复
- `lib/config/routes.dart` - P1-2 通知页统一
- `lib/presentation/pages/notification/notifications_page.dart` - P1-2 可能删除

## ADDED Requirements

### Requirement: 本地数据持久化可靠性
系统 SHALL 确保本地收藏、浏览历史、我常去数据可正确持久化和恢复。

#### Scenario: 首次写入我常去
- **GIVEN** 用户首次访问话题
- **WHEN** 调用 `recordVisit`
- **THEN** 系统 SHALL 成功写入记录，不抛出异常

#### Scenario: 重启后数据恢复
- **GIVEN** 用户已收藏/浏览/访问过内容
- **WHEN** 重启 App
- **THEN** 系统 SHALL 恢复之前的数据

### Requirement: 路由跳转正确性
系统 SHALL 确保"我常去"条目跳转到正确的话题详情页。

#### Scenario: 点击我常去条目
- **GIVEN** 用户在我的页面查看"我常去"
- **WHEN** 点击任意条目
- **THEN** 系统 SHALL 打开对应的话题详情页

## MODIFIED Requirements

### Requirement: Hive 适配器注册
**原要求**: 手动注册适配器（已注释）
**新要求**: 调用自动生成的 `registerAdapters()`

### Requirement: 通知页面实现
**原要求**: 路由返回 MessagePage，独立 NotificationsPage 未使用
**新要求**: 统一使用单一实现，移除死代码

## REMOVED Requirements

### Requirement: 重复的通知页面实现
**Reason**: 维护成本高，行为不一致
**Migration**: 统一使用 MessagePage 或 NotificationsPage 之一

## 验收标准

### Phase 1 DoD
- [ ] 无 P0 已知缺陷
- [ ] 本地收藏/历史/常去均可新增、读取、删除、重启恢复
- [ ] 新增测试全部通过

## 验证命令

```bash
flutter pub get
flutter analyze
flutter test
```

如果修改了代码生成模型或适配器：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
