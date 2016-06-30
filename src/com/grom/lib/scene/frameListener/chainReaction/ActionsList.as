/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 26.03.13
 */
package com.grom.lib.scene.frameListener.chainReaction
{
public class ActionsList
{
	private var _actions:Array = [];

	public function ActionsList()
	{
	}

	public function isActive():Boolean
	{
		return _actions.length != 0;
	}

	public function addAction(action:Function):void
	{
		_actions.push(action);
	}

	public function addActionPolicy(action:IChainAction):void
	{
		_actions.push(action);
	}

	public function doNext():Boolean
	{
		var action:Object = _actions.shift();
		if (action)
		{
			doAction(action);
		}
		return _actions.length > 0;
	}

	public function clear():void
	{
		_actions.length = 0;
	}

	private static function doAction(action:Object):void
	{
		if (action is Function)
		{
			(action as Function)();
		}
		else if (action is IChainAction)
		{
			(action as IChainAction).doAction();
		}
	}
}
}
