package com.grom.lib.sound.panel
{

import flash.display.DisplayObject;

import com.grom.lib.sound.ISoundStateListener;
import com.grom.lib.sound.SoundManager;
import com.grom.lib.sound.USound;

public class BaseSoundPanel implements ISoundStateListener
{
	private var _musicButton:ISoundButton;
	private var _soundButton:ISoundButton;

	public function BaseSoundPanel(soundButton:ISoundButton, musicButton:ISoundButton, stageObject:DisplayObject)
	{
		_soundButton = soundButton;
		_musicButton = musicButton;

		_musicButton.setClickHandler(function():void
		{
			SoundManager.instance.setMusicState(!_musicButton.enabled);
		});

		_soundButton.setClickHandler(function():void
		{
			SoundManager.instance.setEffectsState(!_soundButton.enabled)
		});

		USound.attachStateListener(stageObject, this);
	}

	public function onEffectsState(enabled:Boolean):void
	{
		_soundButton.enabled = enabled;
	}

	public function onMusicState(enabled:Boolean):void
	{
		_musicButton.enabled = enabled;
	}
}
}