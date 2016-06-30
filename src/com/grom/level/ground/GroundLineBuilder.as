/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 21.05.13
 */
package com.grom.level.ground
{

public class GroundLineBuilder
{
	private var _modifiers:Vector.<IGroundModifier> = new Vector.<IGroundModifier>();

	public function GroundLineBuilder()
	{
	}

	public function addModifier(m:IGroundModifier):void
	{
		_modifiers.push(m);
	}

	public function compute(pixelDistance:Number):Number
	{
		var value:Number = 0;
		for each (var m:IGroundModifier in _modifiers)
		{
			value += m.compute(pixelDistance);
		}
		return value;
	}
}
}
