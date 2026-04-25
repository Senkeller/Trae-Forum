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
    draw.ellipse((