/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class DeferredCallback extends FrameCallback
{
	private var _isActive:Boolean = true;

	public function DeferredCallback(periodFrames:int, callback:Function)
	{
		super(periodFrames, callback);
	}

	override public function get isActive():Boolean
	{
		return _isActive;
	}

	override protected function callFunc():void
	{
		super.callFunc();
		_isActive = false;
	}
}
}
