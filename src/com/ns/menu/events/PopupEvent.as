/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.07.12
 */
package com.ns.menu.events
{
import flash.events.Event;

public class PopupEvent extends Event
{
	public static const DISPLAYED:String = "popup_displayed";
	public static const DISAPPEARED:String = "popup_disappeared";

	public function PopupEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new PopupEvent(type);
	}
}
}
