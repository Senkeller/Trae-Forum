# SPECS: 项目完善程度评估与高优先级改进清单

- 日期: 2026-04-27
- 项目路径: `/Users/jason/Documents/codex/TraeU/traeu`
- 评估方式: 只读分析（代码 + 配置 + 测试 + 静态检查）
- 目标: 输出可直接交给其他 AI 执行的开发完善规格

---

## 1. 执行摘要

当前项目已经达到“可用 Beta”水平：核心阅读链路、通知与基础登录恢复可用，且测试可全量通过；但在**本地数据链路**与**部分账号/资料功能闭环**上仍存在阻断级问题与明显未完成功能。

综合完善度（估算）：**68 / 100**

1. 优势:
   1. `flutter test` 全通过（本次执行 276+ 用例）。
   2. 主体路由和主要页面骨架完整，读路径覆盖高。
   3. 网络分层、Provider 状态管理、组件拆分结构清晰。
2. 主要短板:
   1. 本地 Hive 适配器未注册，导致本地收藏/历史/常去存在高风险失效。
   2. “我常去”存在确定性运行时异常。
   3. 注册/找回密码/资料编辑等关键账号能力仍是占位实现。
   4. 静态检查 `flutter analyze` 仍有 76 条问题（含 warning）。

---

## 2. 证据快照（Evidence）

1. 构建与测试:
   1. 命令: `flutter analyze`
   2. 结果: `76 issues found`（无 error，但有 warning/info）
   3. 命令: `flutter test`
   4. 结果: `All tests passed!`（执行结束为全绿）
2. 代码规模与测试规模:
   1. `lib` 文件数: 256
   2. `test + integration_test` 文件数: 29
3. 功能占位/未完成证据:
   1. 注册页仅 Snackbar 提示跳转，未实际打开页面: `lib/presentation/pages/auth/register_page.dart:55`
   2. 找回密码页同样占位: `lib/presentation/pages/auth/forgot_password_page.dart:55`
   3. 用户资料保存仍为“开发中”提示: `lib/presentation/pages/user/user_edit_page.dart:67`
4. 本地存储高风险证据:
   1. Hive 适配器注册代码未启用: `lib/main.dart:117`
   2. 仓库直接使用 `Hive.openBox<T>` 写入模型对象: `lib/data/repositories/user_activity_repository.dart:28`

---

## 3. 严重 Bug 清单（按优先级）

## Bug P0-1: 我常去首次写入会触发运行时异常

1. 严重级别: `P0`（功能阻断 / 高概率崩溃）
2. 位置:
   1. `lib/data/repositories/user_activity_repository.dart:215`
3. 现象:
   1. `firstWhere(..., orElse: () => null as FrequentlyVisited)` 在空集合场景会产生错误类型转换。
4. 影响:
   1. “我常去”首次记录访问可能直接失败，影响页面可用性与数据完整性。
5. 复现步骤:
   1. 清空本地 `frequently_visited` 数据。
   2. 调用 `recordVisit(topicId: ..., topicName: ...)`。
   3. 观察异常抛出或流程中断。
6. 修复要求:
   1. 改为安全查找逻辑（如 `firstWhereOrNull` 或手动循环）。
   2. 消除“空值强转非空类型”写法。
7. 验收标准:
   1. 空数据首次调用 `recordVisit` 成功写入 1 条记录。
   2. 重复调用可正确累加 `visitCount`。
   3. 增加仓库单测覆盖以上两路径。

## Bug P0-2: 本地收藏/浏览历史/常去链路可能因 Hive 适配器未注册而失效

1. 严重级别: `P0`（核心本地功能不可用风险）
2. 位置:
   1. `lib/main.dart:117`
   2. `lib/hive_registrar.g.dart:8`
3. 现象:
   1. 初始化中调用了 `_registerHiveAdapters()`，但实际注册语句被注释。
   2. 工程内存在自动生成的 `registerAdapters()`，但未被调用。
4. 影响:
   1. 本地收藏、浏览历史、我常去等依赖 Hive typed box 的功能可能在真机上写入失败。
5. 修复要求:
   1. 在启动初始化中调用生成的 `Hive.registerAdapters()`（或显式逐个注册）。
   2. 增加“未注册时失败 / 注册后成功”的回归测试。
6. 验收标准:
   1. 本地收藏、新增历史、常去写入可成功持久化。
   2. 重启 App 后数据可恢复。

## Bug P1-1: “我常去”跳转路由参数语义错误

1. 严重级别: `P1`（高影响功能错误）
2. 位置:
   1. `lib/presentation/pages/user/frequently_visited_page.dart:144`
3. 现象:
   1. 当前将 `topicId` 填充到 `/topic/:tag`，而 `TopicDetailPage` 语义是“标签详情页”。
4. 影响:
   1. 点击“我常去”条目可能进入错误页面数据源，或请求错误标签。
5. 修复要求:
   1. 改为跳转真正的话题详情路由（如 `/feed/:id`）或在记录时保存 tag 并按 tag 跳转。
   2. 统一 `topicId / topicTag` 字段语义。
6. 验收标准:
   1. 从“我常去”点击任意条目均可打开正确目标内容。
   2. 增加 widget/integration 用例验证跳转路径。

## Bug P1-2: 通知页路由实现不一致，存在死代码与行为漂移风险

1. 严重级别: `P1`（维护风险 + 行为不一致）
2. 位置:
   1. `/notifications` 路由实际返回 `MessagePage`: `lib/config/routes.dart:315`
   2. 但独立 `NotificationsPage` 已实现: `lib/presentation/pages/notification/notifications_page.dart:15`
3. 现象:
   1. 同域功能存在两套页面实现，但路由只走其一。
4. 影响:
   1. 后续维护易出现修一处漏一处，测试和真实行为偏差增大。
5. 修复要求:
   1. 明确保留单一通知页面实现。
   2. 删除或下线路由未使用实现，避免双轨并行。
6. 验收标准:
   1. 通知入口、消息入口、深链行为一致。
   2. 相关页面无未引用死代码。

---

## 4. 最需继续改进的方向（Top 改进区）

## A. 可靠性与数据层稳定性（最高优先）

1. 消除 P0 缺陷（Hive 注册 + 常去崩溃）。
2. 为本地存储仓库补齐单测：
   1. `add/remove/clear`
   2. 重启恢复
   3. 异常路径（空值、重复写入）

## B. 账号与写操作闭环

1. 完成注册/找回密码真实跳转（外链或 WebView）。
2. `UserEditPage` 从占位提示升级为真实可保存流程（即便受权限限制，也应返回明确失败原因与引导）。
3. 统一登录态检查逻辑与错误提示，减少“看起来可点、实际不可用”的交互。

## C. 测试可信度提升

1. 当前测试通过，但 mock 比例高，真实 API/存储路径覆盖仍不足。
2. 优先补充：
   1. 本地 Hive 集成测试
   2. 写操作真实仓库层测试（非纯 mock）
   3. 关键路由深链用例（`/feed/:id`、`/notifications`、`/user/*`）

## D. 静态质量治理

1. `flutter analyze` 76 项问题建议分两批治理：
   1. 第一批: warning（潜在逻辑风险）
   2. 第二批: info（可读性与规范）
2. 强制 CI 门禁: 新增代码不引入 warning。

---

## 5. 交付给其他 AI 的执行计划（可直接拆任务）

## Phase 1（P0，1-2 天）

1. 修复 `recordVisit` 空值强转异常。
2. 接入 Hive 自动注册并验证本地数据链路。
3. 新增对应单测并在 CI 跑通。

### Phase 1 DoD
1. 无 P0 已知缺陷。
2. 本地收藏/历史/常去均可新增、读取、删除、重启恢复。
3. 新增测试全部通过。

## Phase 2（P1，2-4 天）

1. 修复“我常去”路由语义错误。
2. 统一通知页面实现，移除死代码分叉。
3. 完成注册/找回密码页面真实跳转逻辑。

### Phase 2 DoD
1. 常去条目跳转 100% 正确。
2. `/notifications` 仅一套实现，行为与文档一致。
3. 注册/找回密码不再是“开发中”占位。

## Phase 3（P2，持续）

1. 清理 analyze warning。
2. 补写操作链路的端到端回归用例。
3. 逐步补齐设置页中的 TODO 能力（协议、隐私、更新、缓存清理）。

---

## 6. 验证命令规范（交付 AI 必跑）

```bash
flutter pub get
flutter analyze
flutter test
```

如果修改了代码生成模型或适配器：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 7. 结论

项目并非“半成品”，已经具备较好的可运行基础；但要进入“稳定可持续迭代”的状态，必须优先处理本 specs 中的 P0/P1 问题。先修数据层可靠性，再补账号闭环和测试可信度，是当前性价比最高的改进路径。
