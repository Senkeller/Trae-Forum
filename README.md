# Trae Forum

[![Flutter Version](https://img.shields.io/badge/Flutter-3.10+-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Trae Forum 是一款基于 Flutter 开发的 Trae 官方社区客户端，对接 Discourse 论坛系统 (forum.trae.cn)，提供完整的话题浏览、搜索、用户互动等功能。

## 功能特性

- **话题浏览**: 最新话题、热门话题、分类话题列表
- **话题详情**: 支持富文本渲染、图片预览、目录导航
- **搜索功能**: 全文搜索，支持分类筛选和高级搜索
- **用户系统**: 用户主页、活动历史、关注/粉丝列表
- **消息通知**: 通知列表、标记已读
- **WebView 登录**: 对接 Trae 主站 SSO 登录体系
- **本地存储**: 浏览历史、本地收藏、草稿箱

## 技术架构

### 整体架构

```
┌─────────────────────────────────────────────────────────────┐
│                      表现层 (Presentation)                   │
├─────────────────────────────────────────────────────────────┤
│  Pages (页面)        │  home, feed, topic, user, search...  │
│  Widgets (组件)      │  feed_card, comment, user_avatar...  │
│  Providers (状态)    │  Riverpod 状态管理                   │
├─────────────────────────────────────────────────────────────┤
│                      业务层 (Domain)                         │
├─────────────────────────────────────────────────────────────┤
│  Repositories        │  数据仓库，封装业务逻辑               │
│  Models              │  数据模型 (Freezed + JSON)           │
├─────────────────────────────────────────────────────────────┤
│                      数据层 (Data)                           │
├─────────────────────────────────────────────────────────────┤
│  Network             │  Dio + CookieManager                 │
│  Local Storage       │ Hive CE + SharedPreferences          │
│  API Services        │ DiscourseApiService, TraeDashboardApi│
├─────────────────────────────────────────────────────────────┤
│                      核心层 (Core)                           │
├─────────────────────────────────────────────────────────────┤
│  Network             │ DioClient, Interceptors              │
│  Utils               │ 工具类、常量配置、主题管理            │
└─────────────────────────────────────────────────────────────┘
```

### 核心技术栈

| 类别 | 技术选型 | 说明 |
|------|----------|------|
| 状态管理 | `flutter_riverpod` | 响应式状态管理，支持代码生成 |
| 网络请求 | `dio` + `dio_cookie_manager` | 强大的 HTTP 客户端，支持 Cookie 持久化 |
| 本地存储 | `hive_ce` + `shared_preferences` | 高性能 NoSQL 数据库 + KV 存储 |
| 路由管理 | `go_router` | 声明式路由，支持深度链接 |
| 数据模型 | `freezed` + `json_serializable` | 不可变数据类，自动生成序列化代码 |
| 图片加载 | `cached_network_image` | 带缓存的网络图片加载 |
| 富文本渲染 | `flutter_html` | HTML 内容渲染 |
| WebView | `webview_flutter` | 原生 WebView 嵌入 |

### 项目结构

```
lib/
├── main.dart                    # 应用入口
├── app.dart                     # 应用配置
├── config/
│   ├── constants.dart           # 应用常量、API 配置
│   ├── routes.dart              # 路由配置
│   └── theme.dart               # 主题配置
├── core/
│   ├── network/                 # 网络层
│   │   ├── dio_client.dart      # Dio 客户端配置
│   │   ├── discourse_api_service.dart  # Discourse API 封装
│   │   ├── trae_dashboard_api.dart     # Trae 仪表盘 API
│   │   └── interceptors/        # 拦截器
│   ├── services/                # 核心服务
│   └── utils/                   # 工具类
├── data/
│   ├── models/                  # 数据模型
│   ├── repositories/            # 数据仓库
│   └── adapters/                # 数据适配器
└── presentation/
    ├── pages/                   # 页面
    ├── widgets/                 # 组件
    └── providers/               # 状态提供者
```

## 登录链路说明

Trae Forum 采用 **SSO (单点登录)** 架构，登录流程如下：

```
┌─────────────────────────────────────────────────────────────────────┐
│                           登录流程                                   │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      │
│  │  Trae Forum  │      │ www.trae.cn  │      │ forum.trae.cn│      │
│  │   (App)      │      │  (SSO 登录)   │      │  (论坛 API)  │      │
│  └──────┬───────┘      └──────┬───────┘      └──────┬───────┘      │
│         │                     │                     │              │
│         │  1. 打开 WebView     │                     │              │
│         │────────────────────▶│                     │              │
│         │   加载登录页          │                     │              │
│         │                     │                     │              │
│         │  2. 用户输入手机号   │                     │              │
│         │     验证码登录       │                     │              │
│         │────────────────────▶│                     │              │
│         │                     │                     │              │
│         │  3. 登录成功回调     │                     │              │
│         │◀────────────────────│                     │              │
│         │   获取 Cookie        │                     │              │
│         │                     │                     │              │
│         │  4. 同步 Cookie      │                     │              │
│         │──────────────────────────────────────────▶│              │
│         │   到论坛域名         │                     │              │
│         │                     │                     │              │
│         │  5. 验证登录状态     │                     │              │
│         │──────────────────────────────────────────▶│              │
│         │                     │                     │              │
│         │  6. 登录成功，进入首页                      │              │
│         │◀──────────────────────────────────────────│              │
│         │                     │                     │              │
└─────────┴─────────────────────┴─────────────────────┴──────────────┘
```

### 关键登录文件

| 文件路径 | 说明 |
|----------|------|
| `lib/presentation/pages/user/webview_login_page.dart` | WebView 登录页面实现 |
| `lib/core/network/dio_client.dart` | Cookie 持久化与同步 |
| `lib/core/network/cookie_manager.dart` | Cookie 管理工具 |
| `lib/data/repositories/auth_repository.dart` | 认证仓库 |

### 登录实现细节

1. **WebView 登录**: 使用 `webview_flutter` 加载 `https://www.trae.cn/login`
2. **Cookie 同步**: 登录成功后，将 WebView Cookie 同步到 Dio 的 CookieJar
3. **持久化存储**: Cookie 使用 `PersistCookieJar` 持久化到本地
4. **登录状态检查**: 通过访问 `https://forum.trae.cn/session/current.json` 验证

## 环境要求

- **Flutter**: >= 3.10.0
- **Dart**: >= 3.0.0
- **Android**: minSdkVersion 21
- **iOS**: iOS 11.0+

## 构建命令

### 开发环境

```bash
# 获取依赖
flutter pub get

# 生成代码（Freezed、Riverpod、JSON 序列化）
flutter pub run build_runner build --delete-conflicting-outputs

# 运行应用（调试模式）
flutter run

# 指定设备运行
flutter run -d <device_id>
```

### 代码生成

项目使用代码生成工具，修改以下文件后需要重新生成：

```bash
# 一次性生成
flutter pub run build_runner build --delete-conflicting-outputs

# 监听模式（开发时自动重新生成）
flutter pub run build_runner watch --delete-conflicting-outputs
```

需要生成的文件类型：
- `*.freezed.dart` - Freezed 数据类
- `*.g.dart` - JSON 序列化和 Riverpod Provider

### 构建发布版本

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

### 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/pages/login_page_test.dart

# 运行集成测试
flutter test integration_test/app_test.dart
```

### 代码分析

```bash
# 静态分析
flutter analyze

# 格式化代码
flutter format lib/
```

## 常见故障排查

### 1. 构建失败

#### 问题: `flutter pub get` 失败

**解决方案**:
```bash
# 清理并重新获取依赖
flutter clean
flutter pub get
```

#### 问题: 代码生成失败

**解决方案**:
```bash
# 清理生成文件并重新生成
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. 登录问题

#### 问题: WebView 登录后无法同步 Cookie

**排查步骤**:
1. 检查 `DioClient.initPersistentCookieManager()` 是否在应用启动时调用
2. 检查 `WebViewLoginPage` 中的 Cookie 同步逻辑
3. 查看日志中的 Cookie 同步信息

**关键日志**:
```
🔧 [DioClient] 初始化持久化 CookieManager...
📁 [DioClient] Cookie 存储路径: ...
✅ [DioClient] 持久化 CookieManager 初始化成功
```

#### 问题: 登录状态无法保持

**解决方案**:
- 检查 `PersistCookieJar` 是否正确初始化
- 确认 `ignoreExpires: true` 已设置
- 检查应用重启后 Cookie 是否正确加载

### 3. 网络请求问题

#### 问题: API 请求返回 403/401

**可能原因**:
- Cookie 过期或无效
- CSRF Token 验证失败

**解决方案**:
```bash
# 清除应用数据后重新登录
# Android: 设置 -> 应用 -> Trae Forum -> 存储 -> 清除数据
# iOS: 卸载并重新安装应用
```

#### 问题: 图片加载失败

**排查步骤**:
1. 检查网络连接
2. 检查图片 URL 是否可访问
3. 查看 `cached_network_image` 缓存是否损坏

### 4. 平台特定问题

#### Android

**问题**: `minSdkVersion` 冲突

**解决方案**:
在 `android/app/build.gradle` 中确保:
```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

#### iOS

**问题**: CocoaPods 安装失败

**解决方案**:
```bash
cd ios
pod deintegrate
pod install
cd ..
```

**问题**: 编译时找不到头文件

**解决方案**:
```bash
# 清理 Xcode 构建缓存
rm -rf ios/Pods ios/Podfile.lock
flutter clean
flutter pub get
cd ios && pod install
```

### 5. 开发环境问题

#### 问题: Flutter 命令无法识别

**解决方案**:
```bash
# 检查 Flutter 安装
flutter doctor

# 更新 Flutter
flutter upgrade
```

#### 问题: IDE 代码提示不工作

**解决方案**:
1. 重启 IDE
2. 执行 `flutter pub get`
3. 执行代码生成命令
4. 在 IDE 中重新索引项目

## 贡献指南

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 相关资源

- [Flutter 官方文档](https://docs.flutter.dev/)
- [Riverpod 文档](https://riverpod.dev/)
- [Discourse API 文档](https://docs.discourse.org/)
- [Trae 官方社区](https://forum.trae.cn)

## 许可证

本项目基于 MIT 许可证开源 - 详见 [LICENSE](LICENSE) 文件

---

**注意**: 本项目为社区开源项目，与 Trae 官方无直接关联。
