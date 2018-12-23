/**
 * Created by Roman.Gaikov
 */
package com.grom.input.mouse
{
	import flash.events.MouseEvent;

	public interface IMouseListener
	{
		function onTargetMouseDown(e:MouseEvent):void;
		function onStageMouseMove(e:MouseEvent):void;
		function onStageMouseRelease():void;
	}
}
