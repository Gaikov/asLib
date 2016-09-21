/**
 * Created by roman.gaikov on 9/20/2016.
 */
package com.grom.sys
{
import com.grom.lib.debug.Log;

import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.NativeProcessExitEvent;
import flash.events.ProgressEvent;
import flash.filesystem.File;

public class ProcessRunner extends EventDispatcher
{
	private var _exec:File;
	private var _workDir:File;

	private var _process:NativeProcess;

	public function ProcessRunner(exec:File, workDir:File)
	{
		_exec = exec;
		_workDir = workDir;
	}

	public function run(args:Vector.<String>):void
	{
		if (_process != null)
		{
			throw new Error("Process already started!");
		}

		var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();

		startupInfo.executable = _exec;
		startupInfo.workingDirectory = _workDir;
		startupInfo.arguments = args;

		_process = new NativeProcess();

		_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
		_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
		_process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
		_process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
		_process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);

		_process.start(startupInfo);
	}


	private function destroy():void
	{
		_process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
		_process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
		_process.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
		_process.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
		_process.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
		_process = null;
	}

	public function onOutputData(event:ProgressEvent):void
	{
		Log.info("process: ", _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable));
	}

	public function onErrorData(event:ProgressEvent):void
	{
		Log.warning(_process.standardError.readUTFBytes(_process.standardError.bytesAvailable));
	}

	public function onExit(event:NativeProcessExitEvent):void
	{
		Log.info("EXIT: ", event.exitCode);
		destroy();
		dispatchEvent(new Event(Event.COMPLETE));
	}

	public function onIOError(event:IOErrorEvent):void
	{
		Log.error(event.toString());
		destroy();
		dispatchEvent(new Event(Event.COMPLETE));
	}
}
}
