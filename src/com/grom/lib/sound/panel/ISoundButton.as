/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 26.11.12
 */
package com.grom.lib.sound.panel
{
public interface ISoundButton
{
	function set enabled(value:Boolean):void
	function get enabled():Boolean
	function setClickHandler(handler:Function):void

}
}
