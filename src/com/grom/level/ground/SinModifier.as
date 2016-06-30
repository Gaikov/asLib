/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 21.05.13
 */
package com.grom.level.ground
{
public class SinModifier implements IGroundModifier
{
	private var _amp:Number;
	private var _freq:Number;
	private var _ampMultiplier:IGroundModifier;
	private var _freqMultiplier:IGroundModifier;
	//PI per pixels

	public function SinModifier(amp:Number, freq:Number, ampMultiplier:IGroundModifier = null, freqMultiplier:IGroundModifier = null)
	{
		_amp = amp;
		_freq = freq;
		_ampMultiplier = ampMultiplier;
		_freqMultiplier = freqMultiplier;
	}

	public function compute(pixelDistance:Number):Number
	{
		var amp:Number = _ampMultiplier ? _ampMultiplier.compute(pixelDistance) * _amp : _amp;
		var freq:Number = _freqMultiplier ? _freqMultiplier.compute(pixelDistance) * _freq : _freq;
		return amp * Math.sin(pixelDistance * Math.PI / freq);
	}
}
}
