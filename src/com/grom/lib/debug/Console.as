package com.grom.lib.debug
{
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

internal class Console
{
	private var _tf:TextField = new TextField;
	private var _tfInput:TextField = new TextField;
	private var _visible:Boolean;
	private var _stage:Stage;
	private var _allowed:Boolean = true;

	public function Console()
	{
		_tf.background = true;
		_tf.backgroundColor = 0x444444;

		_tfInput.type = TextFieldType.INPUT;
		_tfInput.background = true;
		_tfInput.backgroundColor = 0x333333;
		_tfInput.addEventListener(KeyboardEvent.KEY_DOWN, onInputKeyDown);
		_tfInput.tabEnabled = false;

		var f:TextFormat = _tf.defaultTextFormat;
		f.color = 0xffffff;
		f.font = "Verdana";

		_tf.defaultTextFormat = f;
		_tfInput.defaultTextFormat = f;
	}

	public function set allowed(value:Boolean):void
	{
		if (_allowed != value)
		{
			_allowed = value;

			if (_stage)
			{
				if (_allowed)
					_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				else
					_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
	}

	public function get visible():Boolean
	{
		return _visible;
	}

	public function trace(text:String, color:uint = 0xffffff):void
	{
		var f:TextFormat = _tf.defaultTextFormat;
		var start:int = _tf.length;
		f.color = color;

		_tf.appendText(text + "\n");
		_tf.setTextFormat(f, start, start + text.length + 1);
		_tf.scrollV = _tf.numLines;
	}

	public function attachToStage(stage:Stage):void
	{
		_stage = stage;
		_stage.addEventListener(Event.RESIZE, onStageResize);

		if (_allowed)
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onStageResize(e:Event):void
	{
		updateSize();
	}

	private function onInputKeyDown(e:KeyboardEvent):void
	{
		if (e.keyCode == Keyboard.ENTER)
		{
			var cmd:String = _tfInput.text;
			_tfInput.text = "";
			CmdManager.instance().exec(cmd);
		}
		else if (e.keyCode == Keyboard.END && _tfInput.text)
		{
			var name:String = CmdManager.instance().autoComplete(_tfInput.text);
			if (name)
				_tfInput.text = name;
			_stage.focus = _tfInput;
		}
	}

	private function onKeyDown(e:KeyboardEvent):void
	{
		if (!_stage) return;

		if ( e.keyCode == 192 )
			toggle(!_visible);
		if (e.keyCode == 67 && e.ctrlKey && e.shiftKey)
			toggle(!_visible);
		else if (e.keyCode == 27)
			toggle(false);
	}

	private function toggle(on:Boolean):void
	{
		if (_visible == on) return;

		_visible = on;
		if (_visible)
		{
			_stage.addChild(_tf);
			_stage.addChild(_tfInput);
			_tfInput.addEventListener(Event.ENTER_FRAME, onInputFrame);
			updateSize();
		}
		else
		{
			_stage.removeChild(_tf);
			_stage.removeChild(_tfInput);
			_stage.focus = _stage;
		}
	}

	private function onInputFrame(e:Event):void
	{
		_stage.focus = _tfInput;
		_tfInput.removeEventListener(Event.ENTER_FRAME, onInputFrame);
	}

	private function updateSize():void
	{
		_tf.width = _stage.stageWidth;
		_tf.height = _stage.stageHeight / 2;

		_tfInput.y = _tf.height;
		_tfInput.width = _stage.stageWidth;
		_tfInput.height = 20;
	}
}
}