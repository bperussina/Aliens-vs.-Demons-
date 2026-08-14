"""Knock out studio backgrounds and crop character sprites."""

from pathlib import Path

import numpy as np
from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SPRITES = ROOT / "assets" / "sprites"


def is_backdrop(rgb: np.ndarray) -> np.ndarray:
	r = rgb[..., 0].astype(np.int16)
	g = rgb[..., 1].astype(np.int16)
	b = rgb[..., 2].astype(np.int16)
	luma = 0.2126 * r + 0.7152 * g + 0.0722 * b
	spread = np.maximum(np.maximum(r, g), b) - np.minimum(np.minimum(r, g), b)
	return (luma >= 214) & (spread < 32)


def flood_alpha(rgb: np.ndarray) -> np.ndarray:
	h, w, _ = rgb.shape
	bg = is_backdrop(rgb)
	alpha = np.full((h, w), 255, dtype=np.uint8)
	seen = np.zeros((h, w), dtype=bool)
	stack = []
	for x in range(w):
		stack.append((0, x))
		stack.append((h - 1, x))
	for y in range(h):
		stack.append((y, 0))
		stack.append((y, w - 1))
	while stack:
		y, x = stack.pop()
		if seen[y, x] or not bg[y, x]:
			continue
		seen[y, x] = True
		alpha[y, x] = 0
		if y > 0:
			stack.append((y - 1, x))
		if y + 1 < h:
			stack.append((y + 1, x))
		if x > 0:
			stack.append((y, x - 1))
		if x + 1 < w:
			stack.append((y, x + 1))
	# Soft fringe so the cut isn't crunchy.
	fringe = seen.copy()
	for _ in range(2):
		up = np.roll(fringe, 1, 0)
		down = np.roll(fringe, -1, 0)
		left = np.roll(fringe, 1, 1)
		right = np.roll(fringe, -1, 1)
		fringe = fringe | up | down | left | right
	edge = fringe & ~seen
	alpha[edge] = np.minimum(alpha[edge], 90)
	return alpha


def crop_rgba(im: Image.Image, pad: int = 18) -> Image.Image:
	arr = np.array(im)
	ys, xs = np.where(arr[..., 3] > 12)
	if len(xs) == 0:
		return im
	x0 = max(int(xs.min()) - pad, 0)
	y0 = max(int(ys.min()) - pad, 0)
	x1 = min(int(xs.max()) + pad + 1, im.width)
	y1 = min(int(ys.max()) + pad + 1, im.height)
	return im.crop((x0, y0, x1, y1))


def process(name: str) -> None:
	path = SPRITES / name
	rgb = np.array(Image.open(path).convert("RGB"))
	alpha = flood_alpha(rgb)
	out = Image.fromarray(rgb, "RGB")
	out.putalpha(Image.fromarray(alpha, "L"))
	out = crop_rgba(out)
	out.save(path, "PNG", optimize=True)
	print(f"{name}: {out.size} mode={out.mode}")


def write_bullet() -> None:
	size = 96
	yy, xx = np.mgrid[0:size, 0:size]
	cx = cy = (size - 1) / 2.0
	d = np.sqrt((xx - cx) ** 2 + (yy - cy) ** 2)
	core = np.clip(1.0 - d / 14.0, 0, 1)
	glow = np.clip(1.0 - d / 38.0, 0, 1) ** 1.6
	rgb = np.zeros((size, size, 3), dtype=np.uint8)
	rgb[..., 0] = np.clip(255 * (0.55 * glow + 0.45 * core) + 255 * core, 0, 255).astype(np.uint8)
	rgb[..., 1] = np.clip(210 * glow + 255 * core, 0, 255).astype(np.uint8)
	rgb[..., 2] = np.clip(80 * glow + 180 * core, 0, 255).astype(np.uint8)
	alpha = np.clip(255 * glow, 0, 255).astype(np.uint8)
	im = Image.fromarray(rgb, "RGB")
	im.putalpha(Image.fromarray(alpha, "L"))
	im.save(SPRITES / "bullet.png", "PNG", optimize=True)
	print(f"bullet.png: {im.size}")


if __name__ == "__main__":
	for name in ("robot.png", "king.png", "demon.png", "king_demon.png", "turret.png"):
		process(name)
	write_bullet()
