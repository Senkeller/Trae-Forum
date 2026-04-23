# TRAE Forum 发布指南

## 发布前准备

### 1. 更新版本号

在 `pubspec.yaml` 中更新版本号：

```yaml
version: 1.0.0+1  # 格式: 版本号+构建号
```

版本号规则：
- 版本号格式：`主版本.次版本.修订版本` (如 1.0.0)
- 构建号：每次发布递增的整数 (如 1, 2, 3...)

### 2. 配置应用图标

1. 准备应用图标文件 `assets/icons/app_icon.png` (1024x1024)
2. 运行图标生成命令：

```bash
flutter pub run flutter_launcher_icons:main
```

### 3. 配置启动页

1. 确保 `flutter_native_splash.yaml` 配置正确
2. 运行启动页生成命令：

```bash
flutter pub run flutter_native_splash:create
```

### 4. Android 发布配置

#### 4.1 创建签名密钥库

```bash
cd android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

#### 4.2 配置签名信息

1. 复制配置文件模板：

```bash
cp key.properties.example key.properties
```

2. 编辑 `key.properties` 填写实际的签名信息：

```properties
storeFile=../upload-keystore.jks
storePassword=your_keystore_password
keyAlias=upload
keyPassword=your_key_password
```

**注意**：`key.properties` 和 `upload-keystore.jks` 不应提交到版本控制！

#### 4.3 构建 Android Release

**构建 APK：**

```bash
flutter build apk --release
```

输出路径：`build/app/outputs/flutter-apk/app-release.apk`

**构建 AppBundle (推荐用于 Google Play)：**

```bash
flutter build appbundle --release
```

输出路径：`build/app/outputs/bundle/release/app-release.aab`

### 5. iOS 发布配置

#### 5.1 配置 Xcode

1. 打开 Xcode：`open ios/Runner.xcworkspace`
2. 选择 Runner 项目
3. 配置 Signing & Capabilities：
   - 选择你的开发团队
   - 更新 Bundle Identifier (如 `com.trae.forum`)

#### 5.2 构建 iOS Release

**构建 IPA：**

```bash
flutter build ios --release
```

然后在 Xcode 中：
1. Product > Archive
2. 在 Organizer 中分发应用

### 6. 运行测试

在发布前运行所有测试：

```bash
# 运行单元测试
flutter test

# 运行集成测试
flutter test integration_test/app_test.dart

# 检查代码分析
flutter analyze

# 检查代码格式化
dart format --set-exit-if-changed .
```

## 发布检查清单

- [ ] 版本号已更新
- [ ] 应用图标已生成
- [ ] 启动页已配置
- [ ] 所有测试通过
- [ ] 代码分析无错误
- [ ] Android 签名配置正确
- [ ] iOS 签名配置正确
- [ ] 发布说明已准备
- [ ] 隐私政策已更新 (如需要)

## 构建命令速查

### Android

```bash
# 构建 Release APK
flutter build apk --release

# 构建 AppBundle
flutter build appbundle --release

# 构建特定 ABI 的 APK
flutter build apk --release --split-per-abi
```

### iOS

```bash
# 构建 Release
flutter build ios --release

# 构建 IPA (无签名)
flutter build ipa --release --export-method=ad-hoc
```

### Web

```bash
flutter build web --release
```

## 故障排除

### Android 构建问题

**问题**：签名配置错误
**解决**：检查 `key.properties` 文件路径和内容是否正确

**问题**：ProGuard 混淆错误
**解决**：检查 `proguard-rules.pro` 规则配置

### iOS 构建问题

**问题**：签名错误
**解决**：在 Xcode 中检查 Signing & Capabilities 配置

**问题**：Pod 安装失败
**解决**：
```bash
cd ios
pod deintegrate
pod install
```

## 相关文档

- [Flutter 发布文档](https://docs.flutter.dev/deployment/android)
- [Android 应用签名](https://developer.android.com/studio/publish/app-signing)
- [iOS 应用发布](https://developer.apple.com/documentation/xcode/distributing-your-app)
