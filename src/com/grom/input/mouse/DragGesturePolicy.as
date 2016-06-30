/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 21.05.13
 */
package com.grom.input.mouse
{
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Point;

import com.grom.lib.debug.Log;

public class DragGesturePolicy
{
	private var _obj:DisplayObject;
	private var _listener:IDragListener;
	private var _prevPos:Point;

	public function DragGesturePolicy(obj:DisplayObject, listener:IDragListener)
	{
		_obj = obj;
		_listener = listener;

		_obj.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_obj.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		_obj.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}

	private function onMouseMove(event:MouseEvent):void
	{
		if (_prevPos)
		{
			var pos:Point = new Point(_obj.mouseX, _obj.mouseY);
			var offs:Point = pos.subtract(_prevPos);
			_listener.onDragged(offs.x, offs.y);
			_prevPos = pos;
		}
	}

	private function onMouseUp(event:MouseEvent):void
	{
		_prevPos = null;
	}

	private function onMouseDown(event:MouseEvent):void
	{
		_prevPos = new Point(_obj.mouseX, _obj.mouseY);
	}
}
}
