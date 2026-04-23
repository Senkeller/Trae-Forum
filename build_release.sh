#!/bin/bash

# TRAE Forum Release 构建脚本
# 用法: ./build_release.sh [android|ios|all]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印信息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Flutter 环境
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter 未安装或未添加到 PATH"
        exit 1
    fi
    
    print_info "Flutter 版本:"
    flutter --version
}

# 获取版本号
get_version() {
    VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: //')
    print_info "当前版本: $VERSION"
}

# 运行测试
run_tests() {
    print_info "运行测试..."
    
    # 代码分析
    print_info "运行代码分析..."
    flutter analyze
    
    # 单元测试
    print_info "运行单元测试..."
    flutter test
    
    print_info "测试通过!"
}

# 生成图标和启动页
generate_assets() {
    print_info "生成应用图标..."
    flutter pub run flutter_launcher_icons:main
    
    print_info "生成启动页..."
    flutter pub run flutter_native_splash:create
}

# 构建 Android Release
build_android() {
    print_info "构建 Android Release..."
    
    # 检查签名配置
    if [ ! -f "android/key.properties" ]; then
        print_warning "未找到 android/key.properties，使用 Debug 签名"
        print_warning "如需发布，请创建签名配置"
    fi
    
    # 清理旧构建
    flutter clean
    flutter pub get
    
    # 构建 APK
    print_info "构建 APK..."
    flutter build apk --release
    
    # 构建 AppBundle
    print_info "构建 AppBundle..."
    flutter build appbundle --release
    
    print_info "Android 构建完成!"
    print_info "APK 路径: build/app/outputs/flutter-apk/app-release.apk"
    print_info "AAB 路径: build/app/outputs/bundle/release/app-release.aab"
}

# 构建 iOS Release
build_ios() {
    print_info "构建 iOS Release..."
    
    # 检查是否在 macOS 上
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "iOS 构建只能在 macOS 上进行"
        return 1
    fi
    
    # 清理旧构建
    flutter clean
    flutter pub get
    
    # 构建 iOS
    print_info "构建 iOS..."
    flutter build ios --release
    
    print_info "iOS 构建完成!"
    print_info "请在 Xcode 中打开 ios/Runner.xcworkspace 进行归档和分发"
}

# 显示帮助
show_help() {
    echo "TRAE Forum Release 构建脚本"
    echo ""
    echo "用法: ./build_release.sh [选项]"
    echo ""
    echo "选项:"
    echo "  android     构建 Android Release (APK + AAB)"
    echo "  ios         构建 iOS Release"
    echo "  all         构建所有平台"
    echo "  test        仅运行测试"
    echo "  assets      仅生成图标和启动页"
    echo "  help        显示帮助信息"
    echo ""
    echo "示例:"
    echo "  ./build_release.sh android    # 仅构建 Android"
    echo "  ./build_release.sh all        # 构建所有平台"
}

# 主函数
main() {
    print_info "TRAE Forum Release 构建脚本"
    print_info "=============================="
    
    # 检查 Flutter 环境
    check_flutter
    
    # 获取版本号
    get_version
    
    # 解析参数
    case "${1:-help}" in
        android)
            run_tests
            generate_assets
            build_android
            ;;
        ios)
            run_tests
            generate_assets
            build_ios
            ;;
        all)
            run_tests
            generate_assets
            build_android
            build_ios
            ;;
        test)
            run_tests
            ;;
        assets)
            generate_assets
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
    
    print_info "构建脚本执行完成!"
}

# 执行主函数
main "$@"
