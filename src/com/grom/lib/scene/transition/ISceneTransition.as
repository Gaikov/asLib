/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 16.11.12
 * Time: 12:56
 * To change this template use File | Settings | File Templates.
 */
package com.grom.lib.scene.transition
{
import flash.display.Sprite;

public interface ISceneTransition
{
	function startTransition(overlay:Sprite, placer:IScenePlacer):void
	function isActive():Boolean;
	function stop():void //should force scene transition and stop animation (always called when startScene call)
}
}
