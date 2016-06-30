/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 26.11.12
 */
package net.maygem.lib.scene.event
{
import flash.events.Event;

public class SceneEvent extends Event
{
	static public const TRANSITION_COMPLETED:String = "scene_transition_completed";

	public function SceneEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new SceneEvent(type);
	}
}
}
