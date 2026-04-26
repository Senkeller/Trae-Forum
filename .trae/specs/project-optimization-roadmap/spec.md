# TraeU 项目深度优化改进规格文档

## Why

基于 `/Users/jason/Documents/codex/TraeU/traeu/docs/项目深度分析与改进路线图_2026-04-26.md` 的深度分析，当前项目存在以下核心问题：

1. **P0 级稳定性问题**：关注/取关逻辑错误、编辑器编译错误、登录门禁不一致
2. **P1 级架构问题**：Dashboard 重复状态、搜索链路混乱、网络层语义遗留
3. **P2 级结构问题**：初始化职责重复、硬编码数据、文档不一致
4. **P3 级质量问题**：静态告警噪音过高（1267 issues）

目标：通过 4 周分阶段改进，将项目从"可读 + 部分可写"提升到"可维护生产闭环"。

## What Changes

### 第 1 周：稳定性止血（P0 修复）

#### P0-1: 关注/取关分支逻辑修复
- **问题**: `url.contains('follow')` 误判，`/v6/user/unfollow` 也会命中
- **方案**: 使用明确枚举/布尔参数表达动作，禁止字符串模糊匹配
- **验收**: 关注/取关动作方向正确，单元测试覆盖两分支

#### P0-2: 编辑器模块编译修复
- **问题**: 缺失依赖、`$before1` 未定义、`Icons.code_blocks` 不存在
- **方案**: 修复编译错误，使模块达到"可编译+最小可用"
- **验收**: `flutter analyze` errors 归零

#### P0-3: 登录门禁统一
- **问题**: 路由守卫仍是 TODO，同步/异步登录判定混用
- **方案**: 路由层统一门禁（白名单+受保护路由），业务层使用单一登录状态源
- **验收**: 登录门禁行为一致，无"页面显示已登录但操作提示未登录"

### 第 2 周：架构收敛（P1 清理）

#### P1-1: Dashboard 状态管理清理
- **问题**: 同一文件存在 `TraeDashboardNotifier` 和 `DashboardStateNotifier` 两套状态
- **方案**: 保留一套状态模型，删除或迁移另一套
- **验收**: Dashboard 只保留单一真源状态链

#### P1-2: 搜索链路收敛
- **问题**: `search_provider_new.dart` 存在但未引用，`SearchResultPage` 仍是占位逻辑
- **方案**: 确认主搜索实现，删除遗留或接回使用
- **验收**: `/search/result` 不再是空占位逻辑

#### P1-3: 网络层语义修复
- **问题**: 业务层传 `/v6/...` 语义参数但实现已映射到 Discourse，`AuthInterceptor` 将常量名当 Header 值
- **方案**: 参数命名与实际请求行为一致，设备 ID 从真实存储读取
- **验收**: API 语义清晰，Header 值正确

### 第 3 周：测试对齐（测试修复）

#### 测试修复任务
- 重写失效测试（登录页 13 个失败、FeedCard 10 个失败）
- 关键 Widget 测试在 `ProviderScope` 场景运行
- 补充关注/取关分支测试与登录态恢复测试
- **验收**: 现有失败用例清零，新增关键链路测试通过

### 第 4 周：质量治理（P2/P3 清理）

#### P2-1: 启动初始化职责合并
- **问题**: `main.dart` 和 `app.dart` 各有一套 `AppInitializer`
- **方案**: 合并初始化入口，保留单一真源

#### P2-2: Profile 页通知数接入真实数据
- **问题**: 未读数写死（3/1/12/2）
- **方案**: 接入通知 Provider 真实未读数

#### P2-3: 文档与产品语义统一
- **问题**: 包描述仍写 "based on CoolApk"，README 为 Flutter 模板
- **方案**: 统一产品术语为 Trae Forum/Discourse，补齐架构文档

#### P3-1: 静态告警治理
- **问题**: 1267 issues（errors=20, warnings=873, infos=374）
- **方案**: 分批治理（先 error，再 warning 再 info），建立增量门禁
- **验收**: `flutter analyze` 问题数显著下降

## Impact

### 受影响规格
- 现有 Feed 卡片增强规格（需确保 P0 修复不破坏）
- 核心内容能力规格（需确保状态管理清理后兼容）
- 论坛恢复 90% 规格（需确保登录门禁统一后兼容）

### 受影响代码
- `lib/core/network/api_service.dart` - P0-1 关注/取关逻辑
- `lib/presentation/widgets/editor/` - P0-2 编辑器编译修复
- `lib/config/routes.dart` - P0-3 路由守卫
- `lib/presentation/providers/trae_dashboard_provider.dart` - P1-1 状态清理
- `lib/presentation/providers/search_provider_new.dart` - P1-2 搜索链路
- `lib/core/network/interceptors/auth_interceptor.dart` - P1-3 Header 修复
- `lib/main.dart`, `lib/app.dart` - P2-1 初始化合并
- `lib/presentation/pages/user/profile_page_new.dart` - P2-2 通知数
- `pubspec.yaml`, `README.md` - P2-3 文档更新
- `test/` - 第 3 周测试修复

## ADDED Requirements

### Requirement: 关注/取关逻辑正确性
系统 SHALL 确保关注/取关操作调用正确的 API 分支。

#### Scenario: 用户点击关注
- **WHEN** 用户点击关注按钮
- **THEN** 系统 SHALL 调用关注 API
- **AND** 不得调用取关 API

#### Scenario: 用户点击取关
- **WHEN** 用户点击取关按钮
- **THEN** 系统 SHALL 调用取关 API
- **AND** 不得调用关注 API

### Requirement: 编辑器模块可编译
系统 SHALL 确保编辑器模块无编译错误。

#### Scenario: 运行 flutter analyze
- **WHEN** 执行 `flutter analyze`
- **THEN** 编辑器相关文件 SHALL 无 error

### Requirement: 登录门禁一致性
系统 SHALL 提供统一的登录状态判定机制。

#### Scenario: 未登录访问受保护页面
- **GIVEN** 用户未登录
- **WHEN** 访问受保护路由
- **THEN** 系统 SHALL 重定向到登录页

#### Scenario: 已登录状态判定
- **GIVEN** 用户已登录
- **WHEN** 执行需要登录的操作
- **THEN** 系统 SHALL 使用统一的登录状态源

## MODIFIED Requirements

### Requirement: Dashboard 状态管理
**原要求**: 存在两套状态体系
**新要求**: 只保留一套状态模型

### Requirement: 搜索链路
**原要求**: 新旧并行 + 占位页
**新要求**: 单一主链路，无占位逻辑

### Requirement: API 参数语义
**原要求**: 业务层传 `/v6/...` 语义参数
**新要求**: 参数命名与实际请求行为一致

## REMOVED Requirements

### Requirement: 旧版 /v6 语义参数
**Reason**: 与 Discourse 体系不一致
**Migration**: 替换为 Discourse 标准语义

### Requirement: 重复的状态管理实现
**Reason**: 维护成本高，容易在错误状态树上改动
**Migration**: 保留一套，删除另一套

### Requirement: 占位搜索页面
**Reason**: 用户路径与实际数据路径不一致
**Migration**: 接回真实数据源或下线该路由

## 验收标准

### 第 1 周验收
- [ ] `flutter analyze` errors = 0
- [ ] 关注/取关动作方向正确
- [ ] 登录门禁行为一致

### 第 2 周验收
- [ ] Dashboard/搜索只保留单一真源状态链
- [ ] `/search/result` 不再是空占位逻辑
- [ ] API 参数语义清晰

### 第 3 周验收
- [ ] 现有失败用例清零（25 个失败修复）
- [ ] 新增关键链路测试通过

### 第 4 周验收
- [ ] `flutter analyze` 问题数显著下降（目标 < 500）
- [ ] 文档可支持新成员独立完成本地运行与调试
- [ ] README 包含架构、登录链路、构建命令、常见故障

## 风险与应对

1. **风险**: 清理重复状态时引入行为回归
   **应对**: 先补回归测试再删旧实现

2. **风险**: 登录链路修正后暴露更多历史脏数据
   **应对**: 保留日志分层与错误码透传

3. **风险**: 测试大量失效导致短期交付压力
   **应对**: 先修关键链路用例，分批恢复非关键 UI 断言

## 技术约束

- 不新增重依赖，优先复用现有架构
- 每个修复限制单模块，保持可回滚
- 每个修复必带对应测试
- 保持向后兼容，不破坏现有功能
