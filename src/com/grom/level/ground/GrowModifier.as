/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 21.05.13
 */
package com.grom.level.ground
{

public class GrowModifier implements IGroundModifier
{
	private var _step:Number;
	private var _distance:Number;

	public function GrowModifier(step:Number, distance:Number)
	{
		_step = step;
		_distance = distance;
	}

	public function compute(pixelDistance:Number):Number
	{
		return pixelDistance * _step / _distance;
	}
}
}
