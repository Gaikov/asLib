/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 18.04.13
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class PosInitSquareModifier implements IParticleModifier
{
	public static const NAME:String = "pos_square";

	private var _minX:Number;
	private var _maxX:Number;
	private var _minY:Number;
	private var _maxY:Number;

	public function PosInitSquareModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minX = node.@min_x;
		_maxX = node.@max_x;
		_minY = node.@min_y;
		_maxY = node.@max_y;
	}

	public function init(p:Particle):void
	{
		p.x = UMath.randomRange(_minX, _maxX);
		p.y = UMath.randomRange(_minY, _maxY);
	}

	public function move(p:Particle):void
	{
	}
}
}
