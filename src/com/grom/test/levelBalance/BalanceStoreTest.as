/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 12.04.13
 */
package com.grom.test.levelBalance
{
import flash.display.Sprite;

import net.maygem.lib.debug.Log;

public class BalanceStoreTest extends Sprite
{
	private var _store:LevelBalanceStore = new LevelBalanceStore("test_game");

	public function BalanceStoreTest()
	{
/*		for (var i:int = 0; i < 10; i++)
		_store.write("test_level",
			{
				killed:int(Math.random() * 500),
				dies:  int(Math.random() * 10)
			});*/

			_store.read("test_level", function(data:Array):void
		 {
		 Log.info(data);
		 });
		//_store.clear();
	}
}
}
