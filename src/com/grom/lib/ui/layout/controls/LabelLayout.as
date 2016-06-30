package com.grom.lib.ui.layout.controls
{
import flash.text.TextFormat;

import com.grom.lib.ui.layout.*;

import flash.text.TextField;

import com.grom.lib.lang.Lang;
import com.grom.lib.ui.layout.builder.ILayoutBuilder;
import com.grom.lib.utils.UContainer;
import com.grom.lib.utils.UDisplay;
import com.grom.lib.utils.UString;

public class LabelLayout extends BaseLayout
{
	private var _textField : TextField = new TextField();
	private var _text : String = "";
	private var _params : Object = {};
	private var _limit : int = 0;

	public function LabelLayout(meta : XML = null)
	{
		super();
		if (meta) updateFromXML(meta);
	}

	override public function set width(value : Number) : void
	{
		_textField.width = value;
	}

	public function set text(value : String) : void
	{
		_text = value ? value : "";
	}

	public function set params(value : Object) : void
	{
		_params = value ? value : {};
	}

	public function set color(value:uint):void
	{
		var f:TextFormat = _textField.defaultTextFormat;
		f.color = value;
		_textField.defaultTextFormat = f;
		_textField.setTextFormat(f);
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);

		UContainer.removeAllChildren(this);
		_textField = UDisplay.createTextField(meta.@font, meta.@size, meta.@color);
		_text = String(meta.@text);
		if (meta.@wrap == "true")
		{
			_textField.wordWrap = true;
			_textField.width = meta.@width;
		}

		if (meta.@multiline == "true")
			_textField.multiline = true;

		_textField.border = meta.@border == "true";
		_limit = meta.@limit;

		addChild(_textField);
	}

	override public function updateLayout() : void
	{
		super.updateLayout();
		var text:String = Lang.replaceParams(_text, _params);
		if (_limit)
			_textField.text = UString.clamp(text, _limit);
		else
			_textField.htmlText = text;
	}

	static public function builder() : ILayoutBuilder
	{
		return new LabelBuilder();
	}

	public function set limit(value:int):void
	{
		_limit = value;
	}
}
}

import com.grom.lib.ui.layout.BaseLayout;
import com.grom.lib.ui.layout.controls.LabelLayout;
import com.grom.lib.ui.layout.builder.ILayoutBuilder;

class LabelBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		return new LabelLayout(node);
	}
}