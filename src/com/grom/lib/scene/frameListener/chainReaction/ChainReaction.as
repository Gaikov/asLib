/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.06.12
 */
package com.grom.lib.scene.frameListener.chainReaction
{
import com.grom.lib.scene.frameListener.*;

public class ChainReaction extends ActionsList implements IFrameListener
{
	private var _frameInterval:int;
	private var _framesLeft:int;
	private var _completeCallback:Function;
	
	public function ChainReaction(frameInterval:int, completeCallback:Function = null)
	{
		_frameInterval = frameInterval;
		_completeCallback = completeCallback;
		EnterFrameManager.instance.addListener(this);
	}

	public function set completeCallback(value:Function):void
	{
		_completeCallback = value;
	}

	override public function clear():void
	{
		super.clear();
		EnterFrameManager.instance.removeListener(this);
	}

	public function onEnterFrame():void
	{
		if (!isActive()) return;

		_framesLeft --;
		if (_framesLeft <= 0)
		{
			_framesLeft = _frameInterval;
			if (!doNext())
			{
				EnterFrameManager.instance.removeListener(this);
				if (_completeCallback != null)
				{
					_completeCallback();
				}
			}
		}
	}


}
}
