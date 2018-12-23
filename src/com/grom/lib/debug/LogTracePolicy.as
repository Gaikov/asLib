package com.grom.lib.debug
{
public class LogTracePolicy implements ILogAdapter
{
	public function LogTracePolicy()
	{
	}

	public function print(msg:String, color:uint):void
	{
		trace(msg);
	}
}
}
