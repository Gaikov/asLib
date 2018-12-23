/**
 * Created by roman.gaikov
 */
package com.grom.input.mouse
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class CaptureMousePolicy
	{
		private var _target:DisplayObject;
		private var _stage:Stage;
		private var _listener:IMouseListener;
		private var _stopPropagation:Boolean;

		public function CaptureMousePolicy(target:DisplayObject, listener:IMouseListener, stopPropagation:Boolean = true)
		{
			_target = target;
			_listener = listener;
			_stopPropagation = stopPropagation;

			_target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addListeners();
		}

		public function destroy():void
		{
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			onMouseRelease();
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			_target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event:Event):void
		{
			addListeners();
		}

		protected function addListeners():void
		{
			if (_target.stage)
			{
				_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
		}

		protected function get stage():Stage
		{
			return _stage;
		}

		private function onRemoveFromStage(event:Event):void
		{
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			onMouseRelease();
		}

		private function onMouseDown(event:MouseEvent):void
		{
			processEvent(event);
			_stage = _target.stage;
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseLeave);
			_stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_listener.onTargetMouseDown(event);
		}

		private function onMouseMove(event:MouseEvent):void
		{
			processEvent(event);
			_listener.onStageMouseMove(event);
		}

		private function onMouseLeave(event:Event):void
		{
			processEvent(event);
			onMouseRelease();
		}

		protected function onMouseRelease():void
		{
			if (_stage)
			{
				_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseLeave);
				_stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				_stage = null;
				_listener.onStageMouseRelease();
			}
		}

		private function processEvent(e:Event):void
		{
			if (_stopPropagation)
			{
				e.stopImmediatePropagation();
			}
		}
	}
}
