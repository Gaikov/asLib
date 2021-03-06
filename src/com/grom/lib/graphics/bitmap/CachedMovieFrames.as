/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.2.12
 */
package com.grom.lib.graphics.bitmap
{
import com.grom.display.particles.ParticlesDesc;
import com.grom.display.particles.ParticlesNode;

import flash.display.Bitmap;
import flash.display.MovieClip;

import com.grom.lib.utils.UContainer;

public class CachedMovieFrames
{
	private var _frames:Array = [];

	public function CachedMovieFrames()
	{
	}

	public function addFrame(frame:CachedFrame):void
	{
		_frames.push(frame);
	}

	public function get count():int
	{
		return _frames.length;
	}

	public function getFrame(index:int):CachedFrame
	{
		return _frames[index];
	}

	public function createFrame(index:int):Bitmap
	{
		var frame:CachedFrame = _frames[index];
		return frame.createFrame();
	}

	static public function renderMovie(movie:MovieClip, trim:Boolean = false):CachedMovieFrames
	{
		UContainer.removeChildrenWithPrefix(movie, "anchor");

		var frames:CachedMovieFrames = new CachedMovieFrames();

		for (var i:int = 1; i <= movie.totalFrames; i++)
		{
			movie.gotoAndStop(i);

			var frame:CachedFrame = CachedFrame.renderObject(movie);
			if (trim)
			{
				frame.trim();
			}
			frames.addFrame(frame);
		}
		return frames;
	}

	static public function renderParticles(desc:ParticlesDesc):CachedMovieFrames
	{
		var frames:CachedMovieFrames = new CachedMovieFrames();

		var part:ParticlesNode = new ParticlesNode(desc);
		part.emmit();
		while (part.isAlive)
		{
			frames.addFrame(CachedFrame.renderObject(part, 5));
			part.emulateStep();
		}

		return frames;
	}
}
}
