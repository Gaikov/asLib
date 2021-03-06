package com.grom.lib.scene.manipulator
{
import flash.display.DisplayObject;
import flash.events.Event;

import com.grom.lib.debug.Log;

public class ManipulableObjectPolicy
{
	private var _object:DisplayObject;
	private var _manipulator:DisplayObjectManipulator;
	private var _parentManipulator:DisplayObjectManipulator;

	public function ManipulableObjectPolicy(manipulatorName:String, object:DisplayObject, parentManipulator:DisplayObjectManipulator = null)
	{
		_object = object;
		_manipulator = new DisplayObjectManipulator(manipulatorName, object);
		_parentManipulator = parentManipulator;
		_object.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	public function destroy():void
	{
		_manipulator.removeFromParent();
		_manipulator.clearPropertySetters();
		_object.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	public function get manipulator():DisplayObjectManipulator
	{
		return _manipulator;
	}

	private function onAddedToStage(event:Event = null):void
	{
		if (_parentManipulator)
		{
			_parentManipulator.addChild(_manipulator);
		}
		else
		{
			var manipulableParent:IManipulableObject = findParentManipulator(_object.parent);
			if (manipulableParent)
			{
				if (!manipulableParent.manipulator)
				{
					Log.warning("Can't get manipulator at: ", manipulableParent, " for: ", _manipulator.fullName);
				}
				else
				{
					manipulableParent.manipulator.addChild(_manipulator);
				}
			}
		}
	}

	private function findParentManipulator(obj:DisplayObject):IManipulableObject
	{
		if (!obj)
		{
			return null;
		}
		else if (obj is IManipulableObject)
		{
			return obj as IManipulableObject;
		}
		return findParentManipulator(obj.parent);
	}

	private function onRemovedFromStage(event:Event):void
	{
		_manipulator.removeFromParent();
	}

	public function set parentManipulator(value:DisplayObjectManipulator):void
	{
		_parentManipulator = value;
		if (_object.stage)
		{
			_parentManipulator.addChild(_manipulator);
		}
	}
}
}