/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class FrameCallback implements IFrameCallback
{
	private var _periodFrames:int;
	private var _framesLeft:int;
	private var _callback:Function;

	public function FrameCallback(periodFrames:int, callback:Function)
	{
		_periodFrames = periodFrames;
		_framesLeft = periodFrames;
		_callback = callback;
	}

	public function get isActive():Boolean
	{
		return true;
	}

	final public function loop():void
	{
		_framesLeft--;
		if (_framesLeft <= 0)
		{
			_framesLeft = _periodFrames;
			callFunc();
		}
	}

	protected function callFunc():void
	{
		_callback();
	}
}
}
