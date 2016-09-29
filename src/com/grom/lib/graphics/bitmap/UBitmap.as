package com.grom.lib.graphics.bitmap
{
import com.grom.lib.utils.Color;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;

public class UBitmap
	{
		static public function createSquare(src:BitmapData):BitmapData
		{
			var size:int = src.width > src.height ? src.height : src.width;
			var res:BitmapData = new BitmapData(size, size);
			var rect:Rectangle = new Rectangle(
					(src.width - size) / 2,
					(src.height - size) / 2,
					size, size);

			res.copyPixels(src, rect, new Point(0, 0));
			return res;
		}

		static public function isZeroPixel(src:BitmapData, x:int, y:int):Boolean
		{
			return (src.getPixel32(x, y) & 0xff000000) == 0;
		}

		static public function trim(src:BitmapData):CachedFrame
		{
			var top:int = findTop(src);
			var left:int = findLeft(src, top);
			var right:int = findRight(src, top);
			var bottom:int = findBottom(src, left, right);

			var w:int = right - left;
			var h:int = bottom - top;

			var rect:Rectangle = new Rectangle(left, top, w, h);

			var bd:BitmapData = new BitmapData(w, h);

			bd.copyPixels(src, rect, new Point(0, 0));

			return new CachedFrame(bd, new Point(left, top));
		}

		private static function findBottom(src:BitmapData, left:int, right:int):int
		{
			for (var y:int = src.height - 1; y >= 0; y--)
			{
				for (var x:int = left; x <= right; x++)
				{
					if (!isZeroPixel(src, x, y))
					{
						return y;
					}
				}
			}
			return src.height;
		}

		private static function findRight(src:BitmapData, top:int):int
		{
			for (var x:int = src.width - 1; x >= 0; x--)
			{
				for (var y:int = top; y < src.height; y++)
				{
					if (!isZeroPixel(src, x, y))
					{
						return x;
					}
				}
			}
			return src.width;
		}

		private static function findLeft(src:BitmapData, top:int):int
		{
			for (var x:int = 0; x < src.width; x++)
			{
				for (var y:int = top; y < src.height; y++)
				{
					if (!isZeroPixel(src, x, y))
					{
						return x;
					}
				}
			}
			return 0;
		}

		static private function findTop(src:BitmapData):int
		{
			for (var y:int = 0; y < src.height; y++)
			{
				for (var x:int = 0; x < src.width; x++)
				{
					if (!isZeroPixel(src, x, y))
					{
						return y;
					}
				}
			}
			return 0;
		}

		static public function tint(src:BitmapData, color:uint):BitmapData
		{
			var res:BitmapData = new BitmapData(src.width, src.height, true, 0);
			var c:Color = new Color();
			c.setFromUINT(color);
			res.draw(src, null, new ColorTransform(c.r, c.g, c.b));
			return res;
		}
	}
}