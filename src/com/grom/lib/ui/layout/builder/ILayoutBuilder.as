package com.grom.lib.ui.layout.builder
{
import com.grom.lib.ui.layout.BaseLayout;

public interface ILayoutBuilder
{
	function createLayout(node:XML):BaseLayout;
}
}