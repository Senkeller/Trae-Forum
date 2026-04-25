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
    b = int(c1[2] + (c2[2] - c1[2]) *