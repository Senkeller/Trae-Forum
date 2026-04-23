import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 应用主题配置
class AppTheme {
  // 主色调
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryDarkColor = Color(0xFF1976D2);
  static const Color primaryLightColor = Color(0xFFBBDEFB);

  // 功能色
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color errorColor = Color(0xFFF44336);
  static const Color infoColor = Color(0xFF2196F3);

  // 点赞/收藏色
  static const Color likeColor = Color(0xFFE91E63);
  static const Color favoriteColor = Color(0xFFFF9800);

  // 热门搜索排名颜色
  static const Color hotSearchFirstColor = Color(0xFFFF4D4D);
  static const Color hotSearchSecondColor = Color(0xFFFF8C00);
  static const Color hotSearchThirdColor = Color(0xFFFFD700);
  
  // 浅色主题颜色
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightTextPrimary = Color(0xFF212121);
  static const Color _lightTextSecondary = Color(0xFF757575);
  static const Color _lightTextHint = Color(0xFF9E9E9E);
  static const Color _lightDivider = Color(0xFFE0E0E0);

  // 深色主题颜色
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkTextPrimary = Color(0xFFFFFFFF);
  static const Color _darkTextSecondary = Color(0xFFB0B0B0);
  static const Color _darkTextHint = Color(0xFF808080);
  static const Color _darkDivider = Color(0xFF424242);

  // 公开的颜色常量（供扩展使用）
  /// 浅色主题背景色
  static Color get lightBackgroundColor => _lightBackground;

  /// 浅色主题表面色
  static Color get lightSurfaceColor => _lightSurface;

  /// 浅色主题主要文字色
  static Color get lightTextPrimaryColor => _lightTextPrimary;

  /// 浅色主题次要文字色
  static Color get lightTextSecondaryColor => _lightTextSecondary;

  /// 浅色主题提示文字色
  static Color get lightTextHintColor => _lightTextHint;

  /// 浅色主题分割线颜色
  static Color get lightDividerColor => _lightDivider;

  /// 深色主题背景色
  static Color get darkBackgroundColor => _darkBackground;

  /// 深色主题表面色
  static Color get darkSurfaceColor => _darkSurface;

  /// 深色主题主要文字色
  static Color get darkTextPrimaryColor => _darkTextPrimary;

  /// 深色主题次要文字色
  static Color get darkTextSecondaryColor => _darkTextSecondary;

  /// 深色主题提示文字色
  static Color get darkTextHintColor => _darkTextHint;

  /// 深色主题分割线颜色
  static Color get darkDividerColor => _darkDivider;

  /// 获取浅色主题
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryLightColor,
        onPrimaryContainer: primaryDarkColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        error: errorColor,
        onError: Colors.white,
        background: _lightBackground,
        onBackground: _lightTextPrimary,
        surface: _lightSurface,
        onSurface: _lightTextPrimary,
        surfaceVariant: Color(0xFFEEEEEE),
        onSurfaceVariant: _lightTextSecondary,
        outline: _lightDivider,
      ),
      scaffoldBackgroundColor: _lightBackground,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _lightSurface,
        foregroundColor: _lightTextPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: _lightSurface,
      ),
      dividerTheme: const DividerThemeData(
        color: _lightDivider,
        thickness: 0.5,
        space: 1,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      iconButtonTheme: _buildIconButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.light),
      chipTheme: _buildChipTheme(Brightness.light),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _lightSurface,
        selectedItemColor: primaryColor,
        unselectedItemColor: _lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: primaryColor,
        unselectedLabelColor: _lightTextSecondary,
        indicatorColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: _lightSurface,
      ),
    );
  }

  /// 获取深色主题
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryDarkColor,
        onPrimaryContainer: primaryLightColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        error: errorColor,
        onError: Colors.white,
        background: _darkBackground,
        onBackground: _darkTextPrimary,
        surface: _darkSurface,
        onSurface: _darkTextPrimary,
        surfaceVariant: Color(0xFF2C2C2C),
        onSurfaceVariant: _darkTextSecondary,
        outline: _darkDivider,
      ),
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _darkSurface,
        foregroundColor: _darkTextPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: _darkSurface,
      ),
      dividerTheme: const DividerThemeData(
        color: _darkDivider,
        thickness: 0.5,
        space: 1,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      iconButtonTheme: _buildIconButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.dark),
      chipTheme: _buildChipTheme(Brightness.dark),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _darkSurface,
        selectedItemColor: primaryColor,
        unselectedItemColor: _darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: primaryColor,
        unselectedLabelColor: _darkTextSecondary,
        indicatorColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: _darkSurface,
      ),
    );
  }

  /// 构建文本主题
  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textPrimary = brightness == Brightness.light 
        ? _lightTextPrimary 
        : _darkTextPrimary;
    final Color textSecondary = brightness == Brightness.light 
        ? _lightTextSecondary 
        : _darkTextSecondary;
    
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
    );
  }

  /// 构建 ElevatedButton 主题
  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// 构建 TextButton 主题
  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// 构建 OutlinedButton 主题
  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: _lightDivider),
      ),
    );
  }

  /// 构建 IconButton 主题
  static IconButtonThemeData _buildIconButtonTheme() {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  /// 构建 InputDecoration 主题
  static InputDecorationTheme _buildInputDecorationTheme(Brightness brightness) {
    final Color fillColor = brightness == Brightness.light 
        ? const Color(0xFFF5F5F5) 
        : const Color(0xFF2C2C2C);
    
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
    );
  }

  /// 构建 Chip 主题
  static ChipThemeData _buildChipTheme(Brightness brightness) {
    final Color backgroundColor = brightness == Brightness.light 
        ? const Color(0xFFF5F5F5) 
        : const Color(0xFF2C2C2C);
    
    return ChipThemeData(
      backgroundColor: backgroundColor,
      selectedColor: primaryColor.withOpacity(0.2),
      labelStyle: TextStyle(
        fontSize: 12,
        color: brightness == Brightness.light ? _lightTextPrimary : _darkTextPrimary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

/// 主题扩展
extension ThemeExtension on BuildContext {
  /// 获取当前主题
  ThemeData get theme => Theme.of(this);

  /// 获取颜色方案
  ColorScheme get colorScheme => theme.colorScheme;

  /// 获取文本主题
  TextTheme get textTheme => theme.textTheme;

  /// 判断是否为深色模式
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// 获取主色调
  Color get primaryColor => colorScheme.primary;

  /// 获取背景色
  Color get backgroundColor => colorScheme.background;

  /// 获取表面色
  Color get surfaceColor => colorScheme.surface;

  /// 获取表面变体色
  Color get surfaceVariantColor => colorScheme.surfaceVariant;

  /// 获取轮廓色
  Color get outlineColor => colorScheme.outline;

  /// 获取错误色
  Color get errorColor => colorScheme.error;

  /// 获取主背景上的文字颜色
  Color get onBackgroundColor => colorScheme.onBackground;

  /// 获取表面上文字颜色
  Color get onSurfaceColor => colorScheme.onSurface;

  /// 获取表面变体上文字颜色
  Color get onSurfaceVariantColor => colorScheme.onSurfaceVariant;
}

/// 颜色扩展
extension ColorExtension on BuildContext {
  /// 获取自适应背景色
  ///
  /// 根据当前主题返回适合的背景色
  Color get adaptiveBackground => isDarkMode
      ? AppTheme.darkBackgroundColor
      : AppTheme.lightBackgroundColor;

  /// 获取自适应表面色
  ///
  /// 根据当前主题返回适合的表面色
  Color get adaptiveSurface => isDarkMode
      ? AppTheme.darkSurfaceColor
      : AppTheme.lightSurfaceColor;

  /// 获取自适应分割线颜色
  ///
  /// 根据当前主题返回适合的分割线颜色
  Color get adaptiveDivider => isDarkMode
      ? AppTheme.darkDividerColor
      : AppTheme.lightDividerColor;

  /// 获取自适应文字颜色（主要）
  ///
  /// 根据当前主题返回适合的主要文字颜色
  Color get adaptiveTextPrimary => isDarkMode
      ? AppTheme.darkTextPrimaryColor
      : AppTheme.lightTextPrimaryColor;

  /// 获取自适应文字颜色（次要）
  ///
  /// 根据当前主题返回适合的次要文字颜色
  Color get adaptiveTextSecondary => isDarkMode
      ? AppTheme.darkTextSecondaryColor
      : AppTheme.lightTextSecondaryColor;

  /// 获取自适应提示文字颜色
  ///
  /// 根据当前主题返回适合的提示文字颜色
  Color get adaptiveTextHint => isDarkMode
      ? AppTheme.darkTextHintColor
      : AppTheme.lightTextHintColor;

  /// 获取自适应输入框背景色
  ///
  /// 根据当前主题返回适合的输入框背景色
  Color get adaptiveInputBackground => isDarkMode
      ? const Color(0xFF2C2C2C)
      : const Color(0xFFF5F5F5);

  /// 获取自适应卡片背景色
  ///
  /// 根据当前主题返回适合的卡片背景色
  Color get adaptiveCardBackground => surfaceColor;

  /// 获取自适应阴影颜色
  ///
  /// 根据当前主题返回适合的阴影颜色
  Color get adaptiveShadowColor => isDarkMode
      ? Colors.black.withOpacity(0.3)
      : Colors.black.withOpacity(0.1);
}
