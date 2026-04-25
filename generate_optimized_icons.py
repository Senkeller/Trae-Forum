#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
优化版 Flutter 应用图标生成脚本
- 提升分辨率（使用 2048x2048 作为源图）
- 优化圆角效果（更平滑的圆角）
- 生成开屏图标
"""

from PIL import Image, ImageDraw, ImageFilter
import os


def create_gradient_background(width: int, height: int, colors: list) -> Image.Image:
    """创建高质量对角线渐变背景"""
    bg = Image.new('RGBA', (width, height), (0, 0, 0, 255))

    for y in range(height):
        for x in range(width):
            ratio = (x + y) / (width + height)
            color = interpolate_color(colors, ratio)
            bg.putpixel((x, y), color)

    return bg


def interpolate_color(colors: list, ratio: float) -> tuple:
    """在颜色列表中进行插值"""
    if len(colors) == 1:
        return colors[0]

    segment = ratio * (len(colors) - 1)
    index = int(segment)
    local_ratio = segment - index

    if index >= len(colors) - 1:
        return colors[-1]

    c1 = colors[index]
    c2 = colors[index + 1]

    r = int(c1[0] + (c2[0] - c1[0]) * local_ratio)
    g = int(c1[1] + (c2[1] - c1[1]) * local_ratio)
    b = int(c1[2] + (c2[2] - c1[2]) * local_ratio)
    a = int(c1[3] + (c2[3] - c1[3]) * local_ratio)

    return (r, g, b, a)


def remove_black_background(img: Image.Image, threshold: int = 30) -> Image.Image:
    """将图片中的黑色背景变为透明"""
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    datas = img.getdata()
    new_data = []

    for item in datas:
        r, g, b, a = item
        if r < threshold and g < threshold and b < threshold:
            new_data.append((0, 0, 0, 0))
        else:
            new_data.append(item)

    img.putdata(new_data)
    return img


def create_rounded_mask(size: int, radius_ratio: float = 0.225) -> Image.Image:
    """
    创建圆角遮罩（使用抗锯齿）

    Args:
        size: 图片尺寸
        radius_ratio: 圆角半径比例（iOS 标准约为 22.5%）
    """
    # 使用 4 倍大小进行超采样，然后缩小以获得平滑圆角
    scale = 4
    large_size = size * scale
    radius = int(large_size * radius_ratio)

    # 创建大尺寸的遮罩
    mask = Image.new('L', (large_size, large_size), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle((0, 0, large_size, large_size), radius=radius, fill=255)

    # 缩小到目标尺寸（使用 LANCZOS 获得平滑边缘）
    mask = mask.resize((size, size), Image.LANCZOS)

    return mask


def create_app_icon_high_res(
    input_path: str,
    output_size: int,
    gradient_colors: list,
    padding_ratio: float = 0.12,
    pixelate: bool = True
) -> Image.Image:
    """
    创建高分辨率应用图标

    Args:
        input_path: 输入图标路径
        output_size: 输出尺寸
        gradient_colors: 渐变背景色
        padding_ratio: 内边距比例
        pixelate: 是否应用像素化效果
    """
    # 打开原始图标
    img = Image.open(input_path)
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    # 去除黑色背景
    img = remove_black_background(img)

    # 创建渐变背景
    bg = create_gradient_background(output_size, output_size, gradient_colors)

    # 计算图标尺寸
    padding = int(output_size * padding_ratio)
    icon_size = output_size - (padding * 2)

    # 缩放图标（使用高质量缩放）
    img_resized = img.resize((icon_size, icon_size), Image.LANCZOS)

    # 可选：应用像素化效果
    if pixelate and icon_size >= 64:
        pixel_size = max(2, icon_size // 32)
        small_size = icon_size // pixel_size
        img_pixelated = img_resized.resize((small_size, small_size), Image.NEAREST)
        img_final = img_pixelated.resize((icon_size, icon_size), Image.NEAREST)
    else:
        img_final = img_resized

    # 将图标粘贴到背景中心
    paste_x = (output_size - icon_size) // 2
    paste_y = (output_size - icon_size) // 2

    result = bg.copy()
    result.paste(img_final, (paste_x, paste_y), img_final)

    return result


def create_ios_icon(input_path: str, size: int, gradient_colors: list) -> Image.Image:
    """创建 iOS 图标（带圆角）"""
    # 创建基础图标
    icon = create_app_icon_high_res(input_path, size, gradient_colors, padding_ratio=0.10)

    # 应用圆角（1024 的 App Store 图标不需要圆角）
    if size < 1024:
        mask = create_rounded_mask(size, radius_ratio=0.225)
        icon.putalpha(mask)

    return icon


def create_android_icon(input_path: str, size: int, gradient_colors: list, round: bool = False) -> Image.Image:
    """创建 Android 图标"""
    icon = create_app_icon_high_res(input_path, size, gradient_colors, padding_ratio=0.12)

    if round:
        # 创建圆形遮罩
        mask = Image.new('L', (size, size), 0)
        draw = ImageDraw.Draw(mask)
        draw.ellipse((0, 0, size, size), fill=255)
        icon.putalpha(mask)

    return icon


def create_splash_icon(input_path: str, size: int, gradient_colors: list) -> Image.Image:
    """创建开屏图标（更大、更清晰）"""
    # 开屏图标使用更小的内边距，让图标更大
    icon = create_app_icon_high_res(input_path, size, gradient_colors, padding_ratio=0.05)
    return icon


def generate_all_icons(input_path: str, project_dir: str, gradient_colors: list):
    """生成所有图标"""

    print("=" * 60)
    print("开始生成优化版 Flutter 应用图标")
    print("=" * 60)

    # 1. 生成超高清源图（2048x2048）
    print("\n🎨 生成超高清源图...")
    assets_dir = os.path.join(project_dir, "assets/icons")
    os.makedirs(assets_dir, exist_ok=True)

    source_2k = create_app_icon_high_res(input_path, 2048, gradient_colors, padding_ratio=0.10)
    source_2k.save(os.path.join(assets_dir, "app_icon_2k.png"), 'PNG')
    print("✓ 2048x2048 源图已生成")

    # 2. 生成 Android 图标
    print("\n📱 生成 Android 图标...")
    android_res_dir = os.path.join(project_dir, "android/app/src/main/res")

    android_configs = [
        ('mipmap-mdpi', 48),
        ('mipmap-hdpi', 72),
        ('mipmap-xhdpi', 96),
        ('mipmap-xxhdpi', 144),
        ('mipmap-xxxhdpi', 192),
    ]

    for folder, size in android_configs:
        folder_path = os.path.join(android_res_dir, folder)
        os.makedirs(folder_path, exist_ok=True)

        # 方形图标
        icon_square = create_android_icon(input_path, size, gradient_colors, round=False)
        icon_square.save(os.path.join(folder_path, 'ic_launcher.png'), 'PNG')

        # 圆形图标
        icon_round = create_android_icon(input_path, size, gradient_colors, round=True)
        icon_round.save(os.path.join(folder_path, 'ic_launcher_round.png'), 'PNG')

        print(f"✓ Android {folder}: {size}x{size}")

    # 3. 生成 iOS 图标
    print("\n🍎 生成 iOS 图标...")
    ios_icon_dir = os.path.join(project_dir, "ios/Runner/Assets.xcassets/AppIcon.appiconset")
    os.makedirs(ios_icon_dir, exist_ok=True)

    ios_configs = [
        ('Icon-App-20x20@1x', 20),
        ('Icon-App-20x20@2x', 40),
        ('Icon-App-20x20@3x', 60),
        ('Icon-App-29x29@1x', 29),
        ('Icon-App-29x29@2x', 58),
        ('Icon-App-29x29@3x', 87),
        ('Icon-App-40x40@1x', 40),
        ('Icon-App-40x40@2x', 80),
        ('Icon-App-40x40@3x', 120),
        ('Icon-App-60x60@2x', 120),
        ('Icon-App-60x60@3x', 180),
        ('Icon-App-76x76@1x', 76),
        ('Icon-App-76x76@2x', 152),
        ('Icon-App-83.5x83.5@2x', 167),
        ('Icon-App-1024x1024@1x', 1024),
    ]

    for name, size in ios_configs:
        icon = create_ios_icon(input_path, size, gradient_colors)
        icon.save(os.path.join(ios_icon_dir, f'{name}.png'), 'PNG')
        print(f"✓ iOS {name}: {size}x{size}")

    # 更新 Contents.json
    update_ios_contents_json(ios_icon_dir)

    # 4. 生成开屏图标（多种尺寸）
    print("\n🚀 生成开屏图标...")
    splash_sizes = [
        ("splash_icon_xxxhdpi", 288),   # xxxhdpi
        ("splash_icon_xxhdpi", 216),    # xxhdpi
        ("splash_icon_xhdpi", 144),     # xhdpi
        ("splash_icon_hdpi", 108),      # hdpi
        ("splash_icon_mdpi", 72),       # mdpi
    ]

    for name, size in splash_sizes:
        splash_icon = create_splash_icon(input_path, size, gradient_colors)
        splash_icon.save(os.path.join(assets_dir, f"{name}.png"), 'PNG')
        print(f"✓ 开屏图标 {name}: {size}x{size}")

    # 5. 生成高清版本用于 pubspec.yaml
    hd_icon = create_app_icon_high_res(input_path, 1024, gradient_colors, padding_ratio=0.10)
    hd_icon.save(os.path.join(assets_dir, "app_icon_hd.png"), 'PNG')
    print("✓ 高清图标 (1024x1024)")

    # 6. 生成开屏背景图
    print("\n🌅 生成开屏背景...")
    splash_bg = create_gradient_background(1080, 1920, gradient_colors)
    splash_bg.save(os.path.join(assets_dir, "splash_background.png"), 'PNG')
    print("✓ 开屏背景 (1080x1920)")

    print("\n" + "=" * 60)
    print("✅ 所有优化图标生成完成！")
    print("=" * 60)


def update_ios_contents_json(output_dir: str):
    """更新 iOS Contents.json 文件"""
    import json

    contents = {
        "images": [
            {"size": "20x20", "idiom": "iphone", "filename": "Icon-App-20x20@2x.png", "scale": "2x"},
            {"size": "20x20", "idiom": "iphone", "filename": "Icon-App-20x20@3x.png", "scale": "3x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@1x.png", "scale": "1x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@2x.png", "scale": "2x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@3x.png", "scale": "3x"},
            {"size": "40x40", "idiom": "iphone", "filename": "Icon-App-40x40@2x.png", "scale": "2x"},
            {"size": "40x40", "idiom": "iphone", "filename": "Icon-App-40x40@3x.png", "scale": "3x"},
            {"size": "60x60", "idiom": "iphone", "filename": "Icon-App-60x60@2x.png", "scale": "2x"},
            {"size": "60x60", "idiom": "iphone", "filename": "Icon-App-60x60@3x.png", "scale": "3x"},
            {"size": "20x20", "idiom": "ipad", "filename": "Icon-App-20x20@1x.png", "scale": "1x"},
            {"size": "20x20", "idiom": "ipad", "filename": "Icon-App-20x20@2x.png", "scale": "2x"},
            {"size": "29x29", "idiom": "ipad", "filename": "Icon-App-29x29@1x.png", "scale": "1x"},
            {"size": "29x29", "idiom": "ipad", "filename": "Icon-App-29x29@2x.png", "scale": "2x"},
            {"size": "40x40", "idiom": "ipad", "filename": "Icon-App-40x40@1x.png", "scale": "1x"},
            {"size": "40x40", "idiom": "ipad", "filename": "Icon-App-40x40@2x.png", "scale": "2x"},
            {"size": "76x76", "idiom": "ipad", "filename": "Icon-App-76x76@1x.png", "scale": "1x"},
            {"size": "76x76", "idiom": "ipad", "filename": "Icon-App-76x76@2x.png", "scale": "2x"},
            {"size": "83.5x83.5", "idiom": "ipad", "filename": "Icon-App-83.5x83.5@2x.png", "scale": "2x"},
            {"size": "1024x1024", "idiom": "ios-marketing", "filename": "Icon-App-1024x1024@1x.png", "scale": "1x"},
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }

    with open(os.path.join(output_dir, 'Contents.json'), 'w') as f:
        json.dump(contents, f, indent=2)

    print("✓ iOS Contents.json 已更新")


def main():
    # 输入图标路径
    input_icon = "/Users/jason/Documents/codex/TraeU/traeu/ic_maskable.png"

    # 渐变配色方案（紫粉渐变）
    gradient_colors = [
        (15, 23, 42, 255),    # 深蓝
        (88, 28, 135, 255),   # 紫色
        (190, 24, 93, 255),   # 粉色
    ]

    # 项目路径
    project_dir = "/Users/jason/Documents/codex/TraeU/traeu"

    # 生成所有图标
    generate_all_icons(input_icon, project_dir, gradient_colors)

    print("\n📋 后续步骤：")
    print("1. 更新 flutter_native_splash.yaml 配置")
    print("2. 运行: flutter pub run flutter_native_splash:create")
    print("3. 运行: flutter clean && flutter pub get")
    print("4. 构建应用验证效果")


if __name__ == "__main__":
    main()
