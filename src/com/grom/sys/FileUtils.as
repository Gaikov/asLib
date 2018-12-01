package com.grom.sys
{
import flash.filesystem.File;

public class FileUtils
{
	public static function isExists(filePath:String):Boolean
	{
		try
		{
			var file:File = new File(filePath);
			return file.exists;
		}
		catch (e:Error)
		{

		}
		return false;
	}
}
}
