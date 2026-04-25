#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
生成 Flutter 应用图标脚本
为 Android 和 iOS 生成所有需要的图标尺寸
"""

from PIL import Image, ImageDraw
import os


def create_gradient_background(width: int, height: int, colors: list) -> Image.Image:
    """创建对角线渐变背景"""
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


def create_app_icon(input_path: str, size: int, gradient_colors: list, padding: int = 0) -> Image.Image:
    """
    创建应用图标

    Args:
        input_path: 输入图标路径
        size: 输出尺寸
        gradient_colors: 渐变背景色
        padding: 内边距
    """
    # 打开原始图标
    img = Image.open(input_path)
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    # 去除黑色背景
    img = remove_black_background(img)

    # 创建渐变背景
    bg = create_gradient_background(size, size, gradient_colors)

    # 计算图标尺寸（留出内边距）
    icon_size = size - (padding * 2)

    # 缩放图标
    img_resized = img.resize((icon_size, icon_size), Image.LANCZOS)

    # 像素化处理
    pixel_size = max(1, icon_size // 32)  # 根据尺寸调整像素块大小
    small_size = icon_size // pixel_size
    img_pixelated = img_resized.resize((small_size, small_size), Image.NEAREST)
    img_final = img_pixelated.resize((icon_size, icon_size), Image.NEAREST)

    # 将图标粘贴到背景中心
    paste_x = (size - icon_size) // 2
    paste_y = (size - icon_size) // 2

    result = bg.copy()
    result.paste(img_final, (paste_x, paste_y), img_final)

    return result


def generate_android_icons(input_path: str, output_dir: str, gradient_colors: list):
    """生成 Android 图标"""
    # Android 图标尺寸配置
    android_configs = [
        ('mipmap-mdpi', 48),
        ('mipmap-hdpi', 72),
        ('mipmap-xhdpi', 96),
        ('mipmap-xxhdpi', 144),
        ('mipmap-xxxhdpi', 192),
    ]

    for folder, size in android_configs:
        folder_path = os.path.join(output_dir, folder)
        os.makedirs(folder_path, exist_ok=True)

        # 生成方形图标
        icon = create_app_icon(input_path, size, gradient_colors, padding=size//8)
        icon.save(os.path.join(folder_path, 'ic_launcher.png'), 'PNG')

        # 生成圆形图标（Android 自适应图标）
        icon_round = create_round_icon(input_path, size, gradient_colors)
        icon_round.save(os.path.join(folder_path, 'ic_launcher_round.png'), 'PNG')

        print(f"✓ Android {folder}: {size}x{size}")


def create_round_icon(input_path: str, size: int, gradient_colors: list) -> Image.Image:
    """创建圆形图标"""
    # 创建方形图标
    icon = create_app_icon(input_path, size, gradient_colors, padding=size//6)

    # 创建圆形遮罩
    mask = Image.new('L', (size, size), 0)
    draw = ImageDraw.Draw(mask)
    draw.ellipse((0, 0, size, size), fill=255)

    # 应用圆形遮罩
    icon.putalpha(mask)

    return icon


def generate_ios_icons(input_path: str, output_dir: str, gradient_colors: list):
    """生成 iOS 图标"""
    # iOS 图标尺寸配置
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

    os.makedirs(output_dir, exist_ok=True)

    for name, size in ios_configs:
        # iOS 图标需要圆角
        icon = create_app_icon(input_path, size, gradient_colors, padding=size//8)

        # 应用 iOS 圆角（1024 的 App Store 图标不需要圆角）
        if size < 1024:
            icon = apply_ios_rounded_corners(icon, size)

        icon.save(os.path.join(output_dir, f'{name}.png'), 'PNG')
        print(f"✓ iOS {name}: {size}x{size}")


def apply_ios_rounded_corners(img: Image.Image, size: int) -> Image.Image:
    """应用 iOS 圆角效果"""
    # iOS 圆角半径约为尺寸的 20%
    radius = int(size * 0.2)

    # 创建圆角遮罩
    mask = Image.new('L', (size, size), 0)
    draw = ImageDraw.Draw(mask)

    # 绘制圆角矩形
    draw.rounded_rectangle((0, 0, size, size), radius=radius, fill=255)

    # 应用遮罩
    result = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    result.paste(img, (0, 0), mask)

    return result


def update_ios_contents_json(output_dir: str):
    """更新 iOS Contents.json 文件"""
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

    import json
    with open(os.path.join(output_dir, 'Contents.json'), 'w') as f:
        json.dump(contents, f, indent=2)

    print("✓ iOS Contents.json 已更新")


def main():
    # 输入图标路径
    input_icon = "/Users/jason/Documents/codex/TraeU/traeu/ic_maskable.png"

    # 渐变配色方案（紫粉渐变 - 推荐）
    gradient_colors = [
        (15, 23, 42, 255),    # 深蓝
        (88, 28, 135, 255),   # 紫色
        (190, 24, 93, 255),   # 粉色
    ]

    # 项目路径
    project_dir = "/Users/jason/Documents/codex/TraeU/traeu"

    print("=" * 50)
    print("开始生成 Flutter 应用图标")
    print("=" * 50)

    # 生成 Android 图标
    print("\n📱 生成 Android 图标...")
    android_output = os.path.join(project_dir, "android/app/src/main/res")
    generate_android_icons(input_icon, android_output, gradient_colors)

    # 生成 iOS 图标
    print("\n🍎 生成 iOS 图标...")
    ios_output = os.path.join(project_dir, "ios/Runner/Assets.xcassets/AppIcon.appiconset")
    generate_ios_icons(input_icon, ios_output, gradient_colors)
    update_ios_contents_json(ios_output)

    # 同时生成一个高清版本到 assets
    print("\n🎨 生成高清版本到 assets...")
    assets_output = os.path.join(project_dir, "assets/icons")
    os.makedirs(assets_output, exist_ok=True)
    hd_icon = create_app_icon(input_icon, 1024, gradient_colors, padding=100)
    hd_icon.save(os.path.join(assets_output, "app_icon_hd.png"), 'PNG')

    print("\n" + "=" * 50)
    print("✅ 所有图标生成完成！")
    print("=" * 50)
    print("\n请运行以下命令验证：")
    print("  flutter clean")
    print("  flutter pub get")
    print("  flutter build apk --debug (Android)")
    print("  flutter build ios --debug (iOS)")


if __name__ == "__main__":
    main()
