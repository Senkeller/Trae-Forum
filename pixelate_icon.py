#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
图标像素化处理脚本
将图标转换为像素艺术风格，并添加渐变背景
"""

from PIL import Image, ImageDraw
import os


def create_gradient_background(width: int, height: int, colors: list, direction: str = "diagonal") -> Image.Image:
    """
    创建渐变背景

    Args:
        width: 图片宽度
        height: 图片高度
        colors: 渐变色列表 [(r,g,b,a), ...]
        direction: 渐变方向 - "horizontal"(水平), "vertical"(垂直), "diagonal"(对角线)

    Returns:
        渐变背景图片
    """
    bg = Image.new('RGBA', (width, height), (0, 0, 0, 255))
    draw = ImageDraw.Draw(bg)

    if direction == "horizontal":
        for x in range(width):
            ratio = x / width
            color = interpolate_color(colors, ratio)
            draw.line([(x, 0), (x, height)], fill=color)
    elif direction == "vertical":
        for y in range(height):
            ratio = y / height
            color = interpolate_color(colors, ratio)
            draw.line([(0, y), (width, y)], fill=color)
    else:  # diagonal
        for y in range(height):
            for x in range(width):
                ratio = (x + y) / (width + height)
                color = interpolate_color(colors, ratio)
                bg.putpixel((x, y), color)

    return bg


def interpolate_color(colors: list, ratio: float) -> tuple:
    """
    在颜色列表中进行插值

    Args:
        colors: 颜色列表 [(r,g,b,a), ...]
        ratio: 0.0 到 1.0 之间的值

    Returns:
        插值后的颜色 (r,g,b,a)
    """
    if len(colors) == 1:
        return colors[0]

    # 计算当前比例对应的颜色段
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
    """
    将图片中的黑色背景变为透明

    Args:
        img: 输入图片
        threshold: 黑色阈值，低于此值视为黑色

    Returns:
        去除黑色背景后的图片
    """
    # 转换为 RGBA
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    # 获取像素数据
    datas = img.getdata()

    # 创建新的像素数据
    new_data = []
    for item in datas:
        r, g, b, a = item
        # 如果像素接近黑色，设为透明
        if r < threshold and g < threshold and b < threshold:
            new_data.append((0, 0, 0, 0))
        else:
            new_data.append(item)

    # 更新图片数据
    img.putdata(new_data)
    return img


def pixelate_image_with_gradient(
    input_path: str,
    output_path: str,
    pixel_size: int = 8,
    gradient_colors: list = None,
    direction: str = "diagonal",
    remove_bg: bool = True
) -> None:
    """
    将图片像素化处理并添加渐变背景

    Args:
        input_path: 输入图片路径
        output_path: 输出图片路径
        pixel_size: 像素块大小
        gradient_colors: 渐变色列表，默认使用蓝紫渐变
        direction: 渐变方向
        remove_bg: 是否去除黑色背景
    """
    # 默认渐变色：深蓝 -> 紫色 -> 粉色
    if gradient_colors is None:
        gradient_colors = [
            (15, 23, 42, 255),    # 深蓝 slate-900
            (88, 28, 135, 255),   # 紫色 purple-900
            (190, 24, 93, 255),   # 粉色 pink-700
        ]

    # 打开图片
    img = Image.open(input_path)

    # 确保图片是 RGBA 模式
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    # 去除黑色背景
    if remove_bg:
        img = remove_black_background(img)

    # 获取原始尺寸
    original_width, original_height = img.size

    # 创建渐变背景
    gradient_bg = create_gradient_background(
        original_width, original_height, gradient_colors, direction
    )

    # 计算缩小后的尺寸
    small_width = original_width // pixel_size
    small_height = original_height // pixel_size

    # 缩小图片（使用 NEAREST 保持硬边缘）
    small_img = img.resize((small_width, small_height), Image.NEAREST)

    # 放大回原始尺寸
    pixelated_img = small_img.resize((original_width, original_height), Image.NEAREST)

    # 将像素化图标合成到渐变背景上
    result = Image.alpha_composite(gradient_bg, pixelated_img)

    # 保存结果
    result.save(output_path, 'PNG')
    print(f"像素化图片已保存: {output_path}")
    print(f"原始尺寸: {original_width}x{original_height}")
    print(f"像素块大小: {pixel_size}px")
    print(f"等效像素分辨率: {small_width}x{small_height}")


def create_pixel_art_icon_with_gradient(input_path: str, output_dir: str) -> None:
    """
    创建多个像素化版本的图标（带渐变背景）

    Args:
        input_path: 输入图片路径
        output_dir: 输出目录
    """
    # 确保输出目录存在
    os.makedirs(output_dir, exist_ok=True)

    # 定义不同的渐变配色方案
    gradients = {
        "purple": [
            (15, 23, 42, 255),    # 深蓝
            (88, 28, 135, 255),   # 紫色
            (190, 24, 93, 255),   # 粉色
        ],
        "blue": [
            (15, 23, 42, 255),    # 深蓝
            (30, 58, 138, 255),   # 蓝色
            (59, 130, 246, 255),  # 亮蓝
        ],
        "green": [
            (6, 78, 59, 255),     # 深绿
            (16, 185, 129, 255),  # 翠绿
            (52, 211, 153, 255),  # 浅绿
        ],
        "dark": [
            (0, 0, 0, 255),       # 纯黑
            (31, 41, 55, 255),    # 深灰
            (55, 65, 81, 255),    # 中灰
        ],
        "sunset": [
            (88, 28, 135, 255),   # 紫色
            (219, 39, 119, 255),  # 玫红
            (251, 146, 60, 255),  # 橙色
        ],
        "ocean": [
            (15, 23, 42, 255),    # 深蓝
            (30, 64, 175, 255),   # 蓝色
            (6, 182, 212, 255),   # 青色
        ],
    }

    # 定义不同的像素化程度
    pixel_sizes = [4, 8, 12, 16]

    # 生成不同配色和像素化程度的组合
    for gradient_name, colors in gradients.items():
        for pixel_size in pixel_sizes:
            output_path = os.path.join(
                output_dir,
                f"ic_maskable_pixel_{gradient_name}_{pixel_size}.png"
            )
            pixelate_image_with_gradient(
                input_path, output_path, pixel_size, colors, "diagonal", remove_bg=True
            )

    # 创建推荐版本（紫色渐变 + 8px 像素块）
    recommended_output = os.path.join(output_dir, "ic_maskable_pixel_gradient.png")
    pixelate_image_with_gradient(
        input_path, recommended_output, pixel_size=8,
        gradient_colors=gradients["purple"], direction="diagonal", remove_bg=True
    )

    # 创建 TRAE 品牌色版本（深蓝到青色渐变）
    trae_gradient = [
        (15, 23, 42, 255),    # 深蓝
        (20, 184, 166, 255),  # 青色
        (52, 211, 153, 255),  # 翠绿
    ]
    trae_output = os.path.join(output_dir, "ic_maskable_pixel_trae.png")
    pixelate_image_with_gradient(
        input_path, trae_output, pixel_size=8,
        gradient_colors=trae_gradient, direction="diagonal", remove_bg=True
    )

    # 创建海洋渐变版本
    ocean_output = os.path.join(output_dir, "ic_maskable_pixel_ocean.png")
    pixelate_image_with_gradient(
        input_path, ocean_output, pixel_size=8,
        gradient_colors=gradients["ocean"], direction="diagonal", remove_bg=True
    )

    # 创建日落渐变版本
    sunset_output = os.path.join(output_dir, "ic_maskable_pixel_sunset.png")
    pixelate_image_with_gradient(
        input_path, sunset_output, pixel_size=8,
        gradient_colors=gradients["sunset"], direction="diagonal", remove_bg=True
    )


if __name__ == "__main__":
    # 输入文件路径
    input_file = "/Users/jason/Documents/codex/TraeU/traeu/ic_maskable.png"

    # 输出目录
    output_directory = "/Users/jason/Documents/codex/TraeU/traeu/assets/icons"

    # 创建像素化图标（带渐变背景）
    create_pixel_art_icon_with_gradient(input_file, output_directory)

    print("\n✅ 像素化处理完成！")
    print(f"推荐使用的图标: {output_directory}/ic_maskable_pixel_gradient.png")
    print(f"TRAE 品牌色版本: {output_directory}/ic_maskable_pixel_trae.png")
    print(f"海洋渐变版本: {output_directory}/ic_maskable_pixel_ocean.png")
    print(f"日落渐变版本: {output_directory}/ic_maskable_pixel_sunset.png")
