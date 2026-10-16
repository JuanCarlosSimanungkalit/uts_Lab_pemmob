"""Membuat gambar aset aplikasi (logo, piala, buku) secara programatik.

Semua gambar digambar dari bentuk dasar (tanpa sumber luar), sehingga bebas
hak cipta. Jalankan dari folder proyek:

    pip install pillow
    python tools/generate_assets.py
"""

import math
import os

from PIL import Image, ImageDraw, ImageFont

CANVAS = 1024  # digambar besar, lalu diperkecil agar tepi halus
OUTPUT = 512
OUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets", "images")

PRIMARY = (91, 91, 214)
PRIMARY_LIGHT = (142, 124, 240)
GOLD = (255, 193, 7)
GOLD_DARK = (224, 150, 0)
GOLD_LIGHT = (255, 226, 128)


def load_font(size):
    candidates = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/Library/Fonts/Arial Bold.ttf",
        "C:/Windows/Fonts/arialbd.ttf",
    ]
    for path in candidates:
        if os.path.exists(path):
            return ImageFont.truetype(path, size)
    return ImageFont.load_default(size)


def save(img, name):
    os.makedirs(OUT_DIR, exist_ok=True)
    img.resize((OUTPUT, OUTPUT), Image.LANCZOS).save(os.path.join(OUT_DIR, name))


def vertical_gradient(size, top, bottom):
    strip = Image.new("RGB", (1, size[1]))
    for y in range(size[1]):
        t = y / (size[1] - 1)
        strip.putpixel((0, y), tuple(int(top[i] + (bottom[i] - top[i]) * t) for i in range(3)))
    return strip.resize(size)


def make_logo():
    img = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    mask = Image.new("L", (CANVAS, CANVAS), 0)
    ImageDraw.Draw(mask).rounded_rectangle((40, 40, CANVAS - 40, CANVAS - 40), radius=230, fill=255)
    img.paste(vertical_gradient((CANVAS, CANVAS), PRIMARY, PRIMARY_LIGHT), (0, 0), mask)

    d = ImageDraw.Draw(img)
    d.rounded_rectangle((220, 210, 804, 684), radius=120, fill="white")
    d.polygon([(330, 660), (330, 830), (510, 672)], fill="white")
    d.text((CANVAS / 2, 450), "?", font=load_font(420), fill=PRIMARY, anchor="mm")
    for x, y, r in [(800, 230, 26), (852, 330, 16), (190, 790, 22)]:
        d.ellipse((x - r, y - r, x + r, y + r), fill=(255, 255, 255, 210))
    save(img, "logo.png")


def star_points(cx, cy, outer, inner, points=5):
    result = []
    for i in range(points * 2):
        radius = outer if i % 2 == 0 else inner
        angle = -math.pi / 2 + i * math.pi / points
        result.append((cx + radius * math.cos(angle), cy + radius * math.sin(angle)))
    return result


def make_trophy():
    img = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.arc((130, 230, 380, 520), 90, 270, fill=GOLD, width=46)
    d.arc((644, 230, 894, 520), 270, 90, fill=GOLD, width=46)
    d.rectangle((260, 150, 764, 400), fill=GOLD)
    d.pieslice((260, 150, 764, 650), 0, 180, fill=GOLD)
    d.rounded_rectangle((310, 190, 346, 430), radius=18, fill=GOLD_LIGHT)
    d.rectangle((462, 640, 562, 770), fill=GOLD_DARK)
    d.rounded_rectangle((330, 770, 694, 860), radius=34, fill=GOLD_DARK)
    d.polygon(star_points(512, 330, 100, 42), fill="white")
    save(img, "trophy.png")


def make_book():
    img = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((110, 250, 914, 810), radius=56, fill=PRIMARY)
    d.rounded_rectangle((165, 295, 495, 765), radius=26, fill=(250, 250, 255))
    d.rounded_rectangle((529, 295, 859, 765), radius=26, fill=(250, 250, 255))
    for i in range(6):
        y = 370 + i * 56
        d.rounded_rectangle((215, y, 445, y + 18), radius=9, fill=(200, 202, 230))
        d.rounded_rectangle((579, y, 809, y + 18), radius=9, fill=(200, 202, 230))
    d.polygon([(700, 250), (780, 250), (780, 440), (740, 400), (700, 440)], fill=(239, 83, 80))
    save(img, "book.png")


if __name__ == "__main__":
    make_logo()
    make_trophy()
    make_book()
    print("Aset dibuat di", os.path.normpath(OUT_DIR))
