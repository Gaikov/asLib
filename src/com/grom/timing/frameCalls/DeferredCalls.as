/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class DeferredCalls extends FrameCalls
{
	public function DeferredCalls()
	{
	}

	override public function addFrameCall(numFrames:int, callback:Function):void
	{
		_frameCallers.push(new DeferredCallback(numFrames, callback));
	}
}
}
