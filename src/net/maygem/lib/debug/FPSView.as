package
net.maygem.lib.debug
{
import flash.events.Event;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

public class FPSView extends TextField
{
	static private const MAX_FRAMES:int = 30;

	private var _prevTime:int = getTimer();
	private var _numFrames:int = 0;

	public function FPSView()
	{
		super();
		mouseEnabled = false;
		selectable = false;
		autoSize = TextFieldAutoSize.LEFT;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void
	{
		_numFrames ++;
		if (_numFrames > MAX_FRAMES)
		{
			var currTime:int = getTimer();
			var time:int = currTime - _prevTime;
			_prevTime = currTime;
			text = String(int(_numFrames * 1000 / time)) + " FPS, mem: " + System.totalMemory / 1024 + " Kb";
			_numFrames = 0;
		}
	}
}
}