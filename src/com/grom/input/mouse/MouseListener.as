/**
 * Created by Roman.Gaikov
 */
package com.grom.input.mouse
{
import flash.events.MouseEvent;

public class MouseListener implements IMouseListener
	{
		private var _mouseDown:Function;
		private var _mouseMove:Function;
		private var _mouseRelease:Function;

		public function MouseListener(mouseDown:Function, mouseMove:Function = null, mouseRelease:Function = null)
		{
			_mouseDown = mouseDown;
			_mouseMove = mouseMove;
			_mouseRelease = mouseRelease;
		}

		public function onTargetMouseDown(e:MouseEvent):void
		{
			if (_mouseDown != null)
			{
				_mouseDown(e);
			}
		}

		public function onStageMouseMove(e:MouseEvent):void
		{
			if (_mouseMove != null)
			{
				_mouseMove(e);
			}
		}

		public function onStageMouseRelease():void
		{
			if (_mouseRelease != null)
			{
				_mouseRelease();
			}
		}
	}
}
