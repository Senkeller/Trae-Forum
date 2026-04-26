# Tasks - TraeU 项目深度优化改进

## 第 1 周：稳定性止血（P0 修复）

### Task 1: 修复关注/取关分支逻辑错误 (P0-1)
- [x] 分析 `api_service.dart` 中关注/取关逻辑
  - [x] 读取 `lib/core/network/api_service.dart` 第 830 行附近代码
  - [x] 读取 `lib/presentation/providers/user_provider.dart` 第 535 行附近代码
  - [x] 理解当前 `url.contains('follow')` 的误判问题
- [x] 设计修复方案
  - [x] 定义明确的枚举/布尔参数表达动作类型
  - [x] 替换字符串模糊匹配为精确判断
- [x] 实现修复
  - [x] 修改 `api_service.dart` 关注/取关分支判断逻辑
  - [x] 修改 `user_provider.dart` 调用处传值
- [x] 添加单元测试
  - [x] 测试关注操作调用正确分支
  - [x] 测试取关操作调用正确分支
  - [x] 测试边界情况

### Task 2: 修复编辑器模块编译错误 (P0-2)
- [x] 分析编辑器模块编译错误
  - [x] 读取 `lib/presentation/widgets/editor/composer_editor.dart`
  - [x] 读取 `lib/presentation/widgets/editor/composer_toolbar.dart`
  - [x] 识别所有编译错误点
- [x] 修复缺失依赖文件引用
- [x] 修复 `$before1` 未定义错误
- [x] 修复 `Icons.code_blocks` 不存在错误
- [x] 运行 `flutter analyze` 验证 errors 归零

### Task 3: 统一登录门禁 (P0-3)
- [x] 分析当前登录判定实现
  - [x] 读取 `lib/config/routes.dart` 第 323 行路由守卫 TODO
  - [x] 读取 `lib/presentation/providers/feed_provider.dart` 第 346 行同步判定
  - [x] 读取 `lib/presentation/providers/message_provider.dart` 第 263 行异步判定
  - [x] 读取 `lib/presentation/providers/notification_provider.dart` 第 119 行异步判定
- [x] 设计统一登录状态源
  - [x] 确定使用异步可恢复态作为单一源
  - [x] 设计路由层统一门禁（白名单+受保护路由）
- [x] 实现路由守卫
  - [x] 在 `routes.dart` 实现路由守卫逻辑
  - [x] 定义白名单路由列表
  - [x] 定义受保护路由列表
- [x] 统一业务层登录判定
  - [x] 修改 `feed_provider.dart` 使用统一登录状态源
  - [x] 修改 `message_provider.dart` 使用统一登录状态源
  - [x] 修改 `notification_provider.dart` 使用统一登录状态源
- [x] 添加登录门禁测试

## 第 2 周：架构收敛（P1 清理）

### Task 4: 清理 Dashboard 重复状态 (P1-1)
- [x] 分析 Dashboard 状态实现
  - [x] 读取 `lib/presentation/providers/trae_dashboard_provider.dart`
  - [x] 识别 `TraeDashboardNotifier` 和 `DashboardStateNotifier` 两套状态
  - [x] 检查 `traeDashboardNotifierProvider` 调用路径
- [x] 确定保留的状态模型
- [x] 删除或迁移废弃状态模型
- [x] 更新所有引用处
- [x] 添加回归测试

### Task 5: 收敛搜索链路 (P1-2)
- [x] 分析搜索链路现状
  - [x] 读取 `lib/presentation/providers/search_provider_new.dart`
  - [x] 读取 `lib/presentation/pages/search/search_result_page.dart`
  - [x] 检查 `search_provider_new.dart` 是否被引用
- [x] 确定主搜索实现
- [x] 删除遗留 provider 或接回使用
- [x] 修复 `SearchResultPage` 占位逻辑
- [x] 添加搜索链路测试

### Task 6: 修复网络层语义遗留 (P1-3)
- [x] 分析网络层语义问题
  - [x] 读取 `lib/presentation/providers/feed_provider.dart` 第 356 行
  - [x] 读取 `lib/core/network/interceptors/auth_interceptor.dart` 第 35 行
- [x] 修复 API 参数语义
  - [x] 更新参数命名与实际请求行为一致
  - [x] 去除 `/v6/...` 语义参数
- [x] 修复 Header 值问题
  - [x] 设备 ID 从真实存储读取
  - [x] 避免发送键名字面量
- [x] 添加网络层测试

## 第 3 周：测试对齐

### Task 7: 修复登录页测试 (13 个失败)
- [x] 分析登录页测试失败原因
  - [x] 读取 `test/pages/login_page_test.dart`
  - [x] 读取 `lib/presentation/pages/user/login_page.dart`
  - [x] 对比测试期望与实际页面实现
- [x] 修复测试用例
  - [x] 更新测试以匹配实际页面结构
  - [x] 确保测试在 `ProviderScope` 中运行
- [x] 验证所有登录页测试通过

### Task 8: 修复 FeedCard 测试 (10 个失败)
- [x] 分析 FeedCard 测试失败原因
  - [x] 读取 `test/widgets/feed_card_test.dart`
  - [x] 读取 `lib/presentation/widgets/feed/feed_card.dart`
- [x] 修复测试用例
  - [x] 更新测试以匹配实际组件结构
  - [x] 确保测试在 `ProviderScope` 中运行
- [x] 验证所有 FeedCard 测试通过

### Task 9: 修复其他失败测试 (2 个)
- [x] 修复 `test/providers/notification_provider_test.dart` (1 个失败)
- [x] 修复 `test/widget_test.dart` (1 个失败)
- [x] 验证所有测试通过

### Task 10: 补充关键链路测试
- [x] 添加关注/取关分支测试
- [x] 添加登录态恢复测试
- [x] 添加路由守卫测试
- [x] 验证新增测试通过

## 第 4 周：质量治理（P2/P3 清理）

### Task 11: 合并启动初始化职责 (P2-1)
- [x] 分析初始化实现
  - [x] 读取 `lib/main.dart` 第 67 行 `AppInitializer`
  - [x] 读取 `lib/app.dart` 第 129 行 `AppInitializer`
- [x] 合并初始化入口
  - [x] 保留单一真源
  - [x] 删除过时 TODO 初始化器
- [x] 验证应用正常启动

### Task 12: 修复 Profile 页通知数硬编码 (P2-2)
- [x] 读取 `lib/presentation/pages/user/profile_page_new.dart` 第 552 行
- [x] 接入通知 Provider 真实未读数
- [x] 未接入前显示占位态而非具体数字
- [x] 验证通知数显示正确

### Task 13: 更新文档与产品语义 (P2-3)
- [x] 更新 `pubspec.yaml` 包描述
  - [x] 移除 "based on CoolApk"
  - [x] 统一为 Trae Forum/Discourse 术语
- [x] 重写 `README.md`
  - [x] 补齐架构说明
  - [x] 补齐登录链路说明
  - [x] 补齐构建命令
  - [x] 补齐常见故障排查

### Task 14: 静态告警治理 (P3-1)
- [x] 运行 `flutter analyze` 获取完整问题列表
- [x] 分批治理 errors（已在前几周完成）
- [x] 治理高频 warnings
  - [x] 修复 `invalid_annotation_target`
  - [x] 修复 `deprecated_member_use`
  - [x] 修复 `avoid_print`
- [x] 治理 infos
- [x] 建立增量门禁
  - [x] 配置 CI 禁止新增 error/warning
- [x] 验证 `flutter analyze` 问题数 < 500

## 跨周依赖

- Task 1 (P0-1) 依赖：无
- Task 2 (P0-2) 依赖：无
- Task 3 (P0-3) 依赖：无
- Task 4 (P1-1) 依赖：Task 3 完成（确保登录状态源统一）
- Task 5 (P1-2) 依赖：无
- Task 6 (P1-3) 依赖：无
- Task 7-10 (测试) 依赖：Task 1-3 完成（确保核心功能修复后再修复测试）
- Task 11-14 (P2/P3) 依赖：Task 1-10 完成

## 验收检查点

- [x] 第 1 周末：`flutter analyze` errors = 0
- [x] 第 2 周末：Dashboard/搜索状态单一真源
- [x] 第 3 周末：所有测试通过（+174 -0）
- [x] 第 4 周末：`flutter analyze` 问题数 < 500，文档更新完成
