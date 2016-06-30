/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 12.04.13
 */
package com.grom.test.levelBalance
{
import com.adobe.serialization.json.JSON;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.net.sendToURL;

import net.maygem.lib.debug.Log;

public class LevelBalanceStore
{
	private var _url:String = "http://free-casual-game.com/";
	private var _gameID:String;

	public function LevelBalanceStore(gameID:String)
	{
		_gameID = gameID;
	}

	public function write(levelID:String, data:Object):void
	{
		var loader:URLLoader = new URLLoader();
		var q:URLRequest = new URLRequest(_url + "balance_add.php");
		var params:URLVariables = new URLVariables();
		params.game_id = _gameID;
		params.level_id = levelID;
		params.data = JSON.encode(data);
		params.hash = Math.random();
		q.data = params;

		loader.addEventListener(Event.COMPLETE, function():void
		{
			var xml:XML = new XML(loader.data);
			if (xml.name() == "success")
			{
				Log.info(xml.toString());
			}
			else
			{
				Log.info("can't store level balance: ", levelID);
				Log.error(xml.toString());
			}
		});

		loader.addEventListener(IOErrorEvent.IO_ERROR, function():void
		{
			Log.error("IO Error in store level balance: ", levelID);
		});

		loader.load(q);
	}

	public function read(levelID:String, onCompleted:Function):void
	{
		var loader:URLLoader = new URLLoader();
		var q:URLRequest = new URLRequest(_url + "balance_list.php");
		var params:URLVariables = new URLVariables();
		params.game_id = _gameID;
		params.level_id = levelID;
		params.hash = Math.random();
		q.data = params;

		loader.addEventListener(Event.COMPLETE, function():void
		{
			var xml:XML = new XML(loader.data);
			if (xml.name() == "error")
			{
				Log.error(xml.toString());
			}
			else
			{
				onCompleted(JSON.decode(String(loader.data)));
			}
		});

		loader.addEventListener(IOErrorEvent.IO_ERROR, function():void
		{
			Log.error("IO Error in read level balance list: ", levelID);
		});

		loader.load(q);
	}

	public function clear():void
	{
		var q:URLRequest = new URLRequest(_url + "balance_clear.php");
		var params:URLVariables = new URLVariables();
		params.game_id = _gameID;
		params.hash = Math.random();
		q.data = params;
		sendToURL(q);
		Log.info("clear levels balance: ", _gameID);
	}
}
}
