/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 04.02.12
 */
package com.ns.menu.displayPolicy
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Point;

import net.maygem.lib.ui.layout.alignment.Alignments;
import net.maygem.lib.ui.layout.alignment.IAlignment;
import net.maygem.lib.utils.UArray;
import net.maygem.lib.utils.UDisplay;

public class DisplayHorizontalPopupPolicy implements IDisplayPopupPolicy, IClosePopupPolicy
{
	private var _movingPopups:Array = [];
	private var _frameListener:Sprite = new Sprite();
	private var _screenWidth:int;
	private var _screenHeight:int;

	public function DisplayHorizontalPopupPolicy(screenWidth:int, screenHeight:int)
	{
		_screenWidth = screenWidth;
		_screenHeight = screenHeight;
		_frameListener.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public function onPopupCloseQuery(popup:Sprite, remover:IPopupRemover, back:DisplayObject):void
	{
		var endPos:Point = new Point(popup.x + _screenWidth, popup.y);
		_movingPopups.push(new FadeOutPopup(popup, endPos, remover));
		playCloseSound();
	}

	private function onEnterFrame(event:Event):void
	{
		for each(var fade:FadeInPopup in _movingPopups)
		{
			if (!fade.move())
				UArray.removeItem(_movingPopups, fade);
		}
	}

	public function onPopupDisplayed(popup:Sprite):void
	{
		var policy:IAlignment = Alignments.policy(Alignments.CENTER);
		var stage:Stage = popup.stage;

		var endPos:Point = UDisplay.convertToOriginPos(popup,
			policy.align(popup.width, _screenWidth),
			policy.align(popup.height, _screenHeight));

		popup.x = endPos.x - _screenWidth;
		popup.y = endPos.y;

		_movingPopups.push(new FadeInPopup(popup, endPos));
		playOpenSound();
	}

	protected function playOpenSound():void
	{

	}

	protected function playCloseSound():void
	{

	}
}
}

import com.ns.menu.displayPolicy.IPopupRemover;
import com.ns.menu.events.PopupEvent;

import flash.display.Sprite;
import flash.geom.Point;

import net.maygem.lib.utils.UPoint;

class FadeInPopup
{
	private var _popup:Sprite;
	private var _endPos:Point;

	public function FadeInPopup(popup:Sprite, endPos:Point)
	{
		_popup = popup;
		_endPos = endPos;
		_popup.mouseChildren = false;
	}

	protected function get speed():Number
	{
		var prevPos:Point = new Point(_popup.x, _popup.y);
		var speed:Number = UPoint.distance(prevPos, _endPos);
		if (speed <= 1)
			speed = 1;
		else
			speed *= 0.3;
		return speed;
	}

	public function move():Boolean
	{
		var prevPos:Point = new Point(_popup.x, _popup.y);

		var pos:Point = UPoint.move(prevPos, _endPos, speed);
		if (!pos)
		{
			_popup.x = _endPos.x;
			_popup.y = _endPos.y;
			_popup.mouseChildren = true;
			onEndAction();
			return false;
		}

		_popup.x = pos.x;
		_popup.y = pos.y;
		return true;
	}

	protected function onEndAction():void
	{
		_popup.dispatchEvent(new PopupEvent(PopupEvent.DISPLAYED));
	}
}

class FadeOutPopup extends FadeInPopup
{
	static private const SPEED:Number = 100;

	private var _remover:IPopupRemover;

	public function FadeOutPopup(popup:Sprite, endPos:Point, remover:IPopupRemover)
	{
		super(popup, endPos);
		_remover = remover;
	}

	override protected function get speed():Number
	{
		return SPEED;
	}

	override public function move():Boolean
	{
		if (!super.move())
		{
			_remover.removeFromStage();
			return false;
		}

		return true;
	}

	override protected function onEndAction():void
	{
	}
}


