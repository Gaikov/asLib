package com.grom.lib.ui.layout.builder
{
import com.grom.lib.debug.Log;
import com.grom.lib.ui.layout.ReferenceLayoutBuilder;
import com.grom.lib.ui.layout.box.AlignLayout;
import com.grom.lib.ui.layout.controls.ButtonLayout;
import com.grom.lib.ui.layout.controls.ButtonLayoutManipulable;
import com.grom.lib.ui.layout.controls.CanvasLayout;
import com.grom.lib.ui.layout.controls.ImageLayout;
import com.grom.lib.ui.layout.controls.LabelLayout;
import com.grom.lib.ui.layout.box.HorizontalLayout;
import com.grom.lib.ui.layout.box.VerticalLayout;

public class LayoutRegistry
{
	static private var _instance : LayoutRegistry;

	private var _builders : Object = {};

	public function LayoutRegistry()
	{
		registerBuilder("vertical", VerticalLayout.builder());
		registerBuilder("horizontal", HorizontalLayout.builder());
		registerBuilder("image", ImageLayout.builder());
		registerBuilder("label", LabelLayout.builder());
		registerBuilder("button", ButtonLayout.builder());
		registerBuilder("button_manipulable", ButtonLayoutManipulable.builder());
		registerBuilder("canvas", CanvasLayout.builder());
		registerBuilder("align", AlignLayout.builder());
		registerBuilder("reference", new ReferenceLayoutBuilder());
	}

	static public function instance() : LayoutRegistry
	{
		if (!_instance)
			_instance = new LayoutRegistry();
		return _instance;
	}

	public function registerBuilder(tagName : String, builder : ILayoutBuilder) : void
	{
		if (_builders[tagName])
			Log.warning("layout builder for tag name '", tagName, "' - already exists!");
		else
			_builders[tagName] = builder;
	}

	internal function getBuilder(tagName : String) : ILayoutBuilder
	{
		if (!_builders[tagName])
		{
			Log.warning("layout builder not found by tag name:", tagName);
			return null;
		}
		return _builders[tagName];
	}
}
}