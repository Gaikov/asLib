/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.2.12
 */
package com.grom.lib.sound
{
public interface ISoundStateListener
{
	function onEffectsState(enabled:Boolean):void
	function onMusicState(enabled:Boolean):void
}
}
