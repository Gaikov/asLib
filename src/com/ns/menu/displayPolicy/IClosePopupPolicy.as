/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 04.02.12
 */
package com.ns.menu.displayPolicy
{
import flash.display.DisplayObject;
import flash.display.Sprite;

public interface IClosePopupPolicy
{
	function onPopupCloseQuery(popup:Sprite, remover:IPopupRemover, back:DisplayObject):void;
}
}
