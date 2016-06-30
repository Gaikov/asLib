/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1.2.12
 */
package com.grom.lib.scene.frameListener
{
import flash.display.DisplayObject;
import flash.events.Event;

public class FramePolicy
{
	private var _object:DisplayObject;
	private var _listener:IFrameListener;
	private var _enabled:Boolean = true;

	static private var _manager:EnterFrameManager;

	public function FramePolicy(listener:IFrameListener, object:DisplayObject)
	{
		if (!_manager)
			_manager = EnterFrameManager.instance;

		_object = object;
		_listener = listener;

		_object.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		updateListener(_object.stage != null);
	}

	public function destroy():void
	{
		_object.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		_manager.removeListener(_listener);
	}

	public function get enabled():Boolean
	{
		return _enabled;
	}

	public function set enabled(value:Boolean):void
	{
		_enabled = value;
		updateListener(_object.stage != null);
	}

	private function onAddedToStage(event:Event):void
	{
		updateListener(true);
	}

	private function onRemovedFromStage(event:Event):void
	{
		updateListener(false);
	}

	private function updateListener(onStage:Boolean):void
	{
		if (onStage && _enabled)
			_manager.addListener(_listener);
		else
			_manager.removeListener(_listener);
	}
}
}
