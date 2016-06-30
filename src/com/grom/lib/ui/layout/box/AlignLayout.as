package com.grom.lib.ui.layout.box
{
import flash.display.DisplayObject;

import com.grom.lib.ui.layout.BaseLayout;
import com.grom.lib.ui.layout.alignment.Alignments;
import com.grom.lib.ui.layout.alignment.IAlignment;
import com.grom.lib.ui.layout.builder.ILayoutBuilder;
import com.grom.lib.utils.UDisplay;

public class AlignLayout extends BaseLayout
{
	private var _width : int = 10;
	private var _height : int = 10;
	private var _vertical : String;
	private var _horizontal : String;
	private var _border:Boolean;

	public function AlignLayout(meta : XML)
	{
		super();
		updateFromXML(meta)
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);
		_width = meta.@width;
		_height = meta.@height;
		_vertical = meta.@vertical;
		_horizontal = meta.@horizontal;
		_border = meta.@border == "true";
	}

	override public function updateLayout() : void
	{
		super.updateLayout();

		var vert : IAlignment = Alignments.policy(_vertical);
		var horz : IAlignment = Alignments.policy(_horizontal);

		for (var i : int = 0; i < numChildren; i++)
		{
			var child : DisplayObject = getChildAt(i) as DisplayObject;

			UDisplay.placeAtOrigin(child,
					horz.align(child.width, _width),
					vert.align(child.height, _height));
		}

		if (_border)
		{
			graphics.clear();
			graphics.lineStyle(1, 0);
			graphics.drawRect(0, 0, width, height);
		}
	}

	static public function builder() : ILayoutBuilder
	{
		return new AlignBuilder();
	}
}
}

import com.grom.lib.ui.layout.BaseLayout;
import com.grom.lib.ui.layout.box.AlignLayout;
import com.grom.lib.ui.layout.builder.ILayoutBuilder;

class AlignBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		return new AlignLayout(node);
	}
}