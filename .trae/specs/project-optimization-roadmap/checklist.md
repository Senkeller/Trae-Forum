# Checklist - TraeU 项目深度优化改进

## P0 修复验收检查点

### P0-1: 关注/取关分支逻辑修复
- [x] `api_service.dart` 中不再使用 `url.contains('follow')` 模糊匹配
- [x] 使用明确枚举/布尔参数表达动作类型（follow/unfollow）
- [x] 关注操作正确调用关注 API 分支
- [x] 取关操作正确调用取关 API 分支
- [x] 单元测试覆盖关注/取关两分支
- [x] 单元测试覆盖边界情况（如重复关注、取关未关注用户）

### P0-2: 编辑器模块编译修复
- [x] `composer_editor.dart` 无缺失依赖文件引用
- [x] `composer_editor.dart` 第 222 行 `$before1` 未定义错误已修复
- [x] `composer_toolbar.dart` 第 148 行 `Icons.code_blocks` 错误已修复
- [x] 运行 `flutter analyze` 编辑器相关文件无 error
- [x] 编辑器模块达到"可编译+最小可用"状态

### P0-3: 登录门禁统一
- [x] `routes.dart` 路由守卫 TODO 已实现
- [x] 路由层实现统一门禁（白名单路由+受保护路由）
- [x] 白名单路由列表定义清晰
- [x] 受保护路由列表定义清晰
- [x] `feed_provider.dart` 使用统一登录状态源
- [x] `message_provider.dart` 使用统一登录状态源
- [x] `notification_provider.dart` 使用统一登录状态源
- [x] 不存在同步/异步登录判定混用
- [x] 未登录访问受保护页面正确重定向到登录页
- [x] 登录门禁行为一致性测试通过

## P1 清理验收检查点

### P1-1: Dashboard 状态管理清理
- [x] 识别 `trae_dashboard_provider.dart` 中两套状态体系
- [x] 确定保留的状态模型（`TraeDashboardNotifier` 或 `DashboardStateNotifier`）
- [x] 废弃状态模型已删除或迁移
- [x] 所有引用处已更新
- [x] Dashboard 只保留单一真源状态链
- [x] 回归测试通过

### P1-2: 搜索链路收敛
- [x] 确认主搜索实现
- [x] `search_provider_new.dart` 已删除或接回使用
- [x] `SearchResultPage` 占位逻辑已替换为真实数据
- [x] `/search/result` 不再是空占位逻辑
- [x] 搜索链路测试通过

### P1-3: 网络层语义修复
- [x] 业务层不再传递 `/v6/...` 语义参数
- [x] API 参数命名与实际请求行为一致
- [x] `AuthInterceptor` 设备 ID 从真实存储读取
- [x] `AuthInterceptor` 不再将常量名直接当 Header 值发送
- [x] API 语义清晰，Header 值正确
- [x] 网络层测试通过

## 测试修复验收检查点

### 登录页测试修复 (13 个失败)
- [x] 分析登录页测试失败原因
- [x] 测试期望与实际页面结构对齐
- [x] 所有登录页测试在 `ProviderScope` 场景运行
- [x] 13 个失败测试全部修复
- [x] 验证 `test/pages/login_page_test.dart` 全绿

### FeedCard 测试修复 (10 个失败)
- [x] 分析 FeedCard 测试失败原因
- [x] 测试期望与实际组件结构对齐
- [x] 所有 FeedCard 测试在 `ProviderScope` 场景运行
- [x] 10 个失败测试全部修复
- [x] 验证 `test/widgets/feed_card_test.dart` 全绿

### 其他测试修复 (2 个失败)
- [x] `test/providers/notification_provider_test.dart` 失败修复
- [x] `test/widget_test.dart` 失败修复
- [x] 验证所有测试通过

### 新增关键链路测试
- [x] 关注/取关分支测试已添加
- [x] 登录态恢复测试已添加
- [x] 路由守卫测试已添加
- [x] 新增测试全部通过

## P2/P3 清理验收检查点

### P2-1: 启动初始化职责合并
- [x] 分析 `main.dart` 和 `app.dart` 的 `AppInitializer`
- [x] 初始化入口已合并
- [x] 保留单一真源
- [x] 过时 TODO 初始化器已删除
- [x] 应用正常启动

### P2-2: Profile 页通知数硬编码修复
- [x] `profile_page_new.dart` 硬编码通知数已移除
- [x] 接入通知 Provider 真实未读数
- [x] 未接入前显示占位态而非具体数字
- [x] 通知数显示正确

### P2-3: 文档与产品语义统一
- [x] `pubspec.yaml` 包描述更新
- [x] 移除 "based on CoolApk"
- [x] 统一产品术语为 Trae Forum/Discourse
- [x] `README.md` 重写
- [x] README 包含架构说明
- [x] README 包含登录链路说明
-