package com.grom.lib.ui.layout.builder
{
import com.grom.lib.debug.Log;
import com.grom.lib.resources.ResourceLoader;
import com.grom.lib.ui.layout.BaseLayout;

public class LayoutManager
{
	static private var _instance:LayoutManager;

	private var _metaList:Array = [];

	public function LayoutManager()
	{
	}

	static public function instance():LayoutManager
	{
		if (!_instance)
			_instance = new LayoutManager();
		return _instance;
	}

	public function load(fileName:String):void
	{
		ResourceLoader.instance().loadXML(fileName, onMetaLoaded);
	}

	public function createLayout(id:String):BaseLayout
	{
		for each (var meta:XML in _metaList)
		{
			for each (var layout:XML in meta.children())
			{
				if (layout.@id == id)
					return createLayoutFromXML(layout);
			}
		}

		Log.warning("layout meta not found with id: ", id);
		return null;
	}

	private function createLayoutFromXML(meta : XML) : BaseLayout
	{
		var builder:ILayoutBuilder = LayoutRegistry.instance().getBuilder(String(meta.name()));
		if (!builder) return null;

		var layout:BaseLayout = builder.createLayout(meta);
		if (!layout) return null;

		for each (var childMeta:XML in meta.children())
		{
			var child:BaseLayout = createLayoutFromXML(childMeta);
			if (child) layout.addChild(child);
		}

		layout.updateLayout();
		return layout;
	}

	private function onMetaLoaded(data:*):void
	{
		if (data)
			_metaList.push(new XML(data));
	}
}
}