package com.grom.lib.input
{
import flash.display.Stage;
import flash.events.KeyboardEvent;

import com.grom.lib.input.keyboard.IKeyListener;

import com.grom.lib.utils.UArray;

public class InputManager
{
	static private var _inst:InputManager;

	private var _stage:Stage;
	private var _keyListeners:Array = [];

	public function InputManager()
	{
	}

	static public function instance():InputManager
	{
		if (!_inst)
			_inst = new InputManager();
		return _inst;
	}

	public function captureFocus():void
	{
		if (_stage) _stage.focus = _stage;
	}

	public function attachToStage(stage:Stage):void
	{
		if (!stage) return;
		_stage = stage;
		_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	public function addListener(listener:IKeyListener, capture:Boolean = false):void
	{
		_keyListeners.push(listener);
		if (capture) captureFocus();
	}

	public function removeListener(listener:IKeyListener):void
	{
		UArray.removeItem(_keyListeners, listener);
	}

	private function onKeyDown(event:KeyboardEvent):void
	{
		for each (var listener:IKeyListener in _keyListeners)
			listener.onKeyDown(event.keyCode);
	}

	private function onKeyUp(event:KeyboardEvent):void
	{
		for each (var listener:IKeyListener in _keyListeners)
			listener.onKeyUp(event.keyCode);
	}
}
}