package net.maygem.lib
{

import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.Capabilities;
import flash.text.Font;
import flash.text.TextFormat;
import flash.utils.getDefinitionByName;

import net.maygem.lib.debug.CmdManager;
import net.maygem.lib.debug.FPSView;
import net.maygem.lib.debug.Log;
import net.maygem.lib.debug.ui.DebugUIManager;
import net.maygem.lib.input.InputManager;
import net.maygem.lib.input.mouse.MouseWheel;
import net.maygem.lib.lang.LangLoader;
import net.maygem.lib.scene.manipulator.ManipulableSprite;
import net.maygem.lib.scene.manipulator.SceneManipulator;
import net.maygem.lib.sound.SoundManager;
import net.maygem.lib.sound.USound;
import net.maygem.lib.ui.CursorManager;
import net.maygem.lib.utils.UDisplay;

public class GameApplication extends ManipulableSprite
{
	private var _fpsView:FPSView = new FPSView();

	private var _gameLayer:Sprite = new Sprite();
	private var _systemLayer:Sprite = new Sprite();
	private var _isAir:Boolean;

	public function GameApplication(isAir:Boolean = false)
	{
		super("app", SceneManipulator.instance());
		_isAir = isAir;

		_gameLayer.mouseEnabled = false;
		_systemLayer.mouseEnabled = false;

		Log.info("=== embedded fonts");
		var fonts:Array = Font.enumerateFonts(false);
		for (var i:int = 0; i < fonts.length; ++i)
		{
			var font:Font = fonts[i];
			Log.info("name: " + font.fontName + ", style: " + font.fontStyle);
		}
		Log.info("=== embedded fonts");

		mouseEnabled = false;
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		CmdManager.instance().register("fps", cmdFPS);
		CmdManager.instance().register("lang", cmdLang);
		CmdManager.instance().register("fullscreen", cmdFullscreen);
		CmdManager.instance().register("sound", cmdSound);

		_fpsView.defaultTextFormat = new TextFormat("Tahoma", 16, 0xffffff, true);
		_fpsView.filters = [UDisplay.createBorderFilter(0, 3)];
		Log.allowConsole(Capabilities.isDebugger);

		addEventListener(Event.ACTIVATE, function():void
		{
			SoundManager.instance.resumeMusic();
		});

		addEventListener(Event.DEACTIVATE, function():void
		{
			SoundManager.instance.pauseMusic();
		});
	}

	protected function get gameLayer() : Sprite
	{
		return _gameLayer;
	}

	private function onAddedToStage(e:Event):void
	{
		stage.tabChildren = false;

		InputManager.instance().attachToStage(stage);
		Log.attachToStage(stage);

		addChild(_gameLayer);
		addChild(_systemLayer);

		_systemLayer.addChild(DebugUIManager.instance().root);
		_systemLayer.addChild(CursorManager.instance());

		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		onApplicationLoaded();
	}

	protected function onApplicationLoaded():void
	{
		Log.print("=== swf params ===", 0xffff00);
		for (var i:String in loaderInfo.parameters)
		{
			Log.print(i + ": " + loaderInfo.parameters[i], 0xffff00);
		}
		Log.print("=== swf params ===", 0xffff00);

		if (!_isAir)
		{
			MouseWheel.capture();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function():void
			{
				MouseWheel.release();
				MouseWheel.capture();
			});
		}
	}

	private function onKeyDown(event:KeyboardEvent):void
	{
		if (!Log.isConsoleActive())
			CmdManager.instance().execCommandsForKey(event.keyCode);
	}

	private function cmdFPS(args:Array):void
	{
		if (!_fpsView.parent)
			stage.addChild(_fpsView);
		else
			_fpsView.parent.removeChild(_fpsView);
	}

	private function cmdLang(args:Array):void
	{
		if (!args.length)
		{
			Log.info("usage: lang [language id]");
			return;
		}

		LangLoader.instance().applyLang(args[0]);
	}

	private function cmdFullscreen(args:Array):void
	{
		if (stage)
			stage.displayState = StageDisplayState.FULL_SCREEN;
	}

	private function cmdSound(args:Array):void
	{
		if (!args.length)
			Log.info("usage: sound [soundClassName]");
		else
		{
			var cls:Class = getDefinitionByName(args[0]) as Class;
			if (cls)
				USound.play(cls);
			else
				Log.warning("sound class not found!");
		}
	}
}
}