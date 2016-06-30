package com.ns.menu
{
import com.ns.menu.displayPolicy.IClosePopupPolicy;
import com.ns.menu.displayPolicy.IDisplayPopupPolicy;

import flash.display.Sprite;

public class PopupManager
{
	static private var _instance:PopupManager = new PopupManager;

	private var _layer:Sprite = new Sprite();

	static public function instance():PopupManager
	{
		return _instance;
	}

	public function PopupManager()
	{
		_layer.mouseEnabled = false;
	}

	public function get layer():Sprite
	{
		return _layer;
	}
	
	static public function setScreenSize(width:int, height:int):void
	{
		MenuPopup._screenWidth = width;
		MenuPopup._screenHeight = height;
	}
	
	static public function set backClass(cls:Class):void
	{
		MenuPopup._backClass = cls;
	}

	static public function set displayPolicy(policy:IDisplayPopupPolicy):void
	{
		MenuPopup._displayPolicy = policy;
	}

	static public function set closePolicy(policy:IClosePopupPolicy):void
	{
		MenuPopup._closePolicy = policy;
	}

	public function openPopup(popup:Sprite):void
	{
		_layer.addChild(new MenuPopup(popup));
	}

	public function closePopup(popup:Sprite):void
	{
		for (var i:int = 0; i < _layer.numChildren; i++)
		{
			var menu:MenuPopup = _layer.getChildAt(i) as MenuPopup;
			if (menu && menu._popup == popup)
			{
				if (MenuPopup._closePolicy)
				{
					MenuPopup._closePolicy.onPopupCloseQuery(menu._popup, menu, menu._back);
				}
				else
				{
					menu.removeFromStage();
				}
				focusStage();
			}
		}

	}

	private function focusStage():void
	{
		//TODO: need new decision
		if (!_layer.numChildren || _layer.numChildren == 1)
		{
			_layer.stage.focus = _layer.stage;
		}
	}

	public function isActive():Boolean
	{
		return _layer.numChildren != 0;
	}
}
}

import com.ns.menu.displayPolicy.IClosePopupPolicy;
import com.ns.menu.displayPolicy.IDisplayPopupPolicy;
import com.ns.menu.displayPolicy.IPopupRemover;

import flash.display.Sprite;
import flash.events.Event;

import net.maygem.lib.graphics.bitmap.MoviesCache;

class MenuPopup extends Sprite implements IPopupRemover
{
	static public var _backClass:Class;
	static public var _displayPolicy:IDisplayPopupPolicy;
	static public var _closePolicy:IClosePopupPolicy;
	static public var _screenWidth:int = 0;
	static public var _screenHeight:int = 0;

	public var _popup:Sprite;
	public var _back:Sprite = new Sprite;

	function MenuPopup(popup:Sprite)
	{
		this._popup = popup;

		if (_backClass)
		{
			_back = MoviesCache.instance.getSprite(_backClass);
			addChild(_back);
		}

		addChild(_popup);
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(e:Event):void
	{
		if (_back)
		{
			this._back.width = _screenWidth;
			this._back.height = _screenHeight;
		}

		if (_displayPolicy)
		{
			_displayPolicy.onPopupDisplayed(_popup);
		}
	}

	public function removeFromStage():void
	{
		parent.removeChild(this);
	}
}