package com.grom.cqrs.presenter
{
import flash.display.DisplayObject;
import flash.events.Event;

import com.grom.cqrs.domain.command.Command;
import com.grom.cqrs.domain.eventbus.EventBus;
import com.grom.cqrs.domain.eventbus.ListenerRegistration;
import com.grom.lib.debug.Log;

public class BasePresenter
{
	protected var _view:DisplayObject;
	private var registrations:Array = new Array();

	public function BasePresenter(view:DisplayObject)
	{
		_view = view;

		view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageEvent);
		view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageEvent);

		if (view.stage != null)
		{
			registerEventListeners();
			afterInitialization();
		}
	}

	public function get view():DisplayObject
	{
		return _view;
	}

	public function dispatchCommand(command:Command):void
	{
		//CommandDispatchService.instance().dispatch(command);
	}

	public function destroy():void
	{
		removeEventListeners();

		_view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageEvent);
		_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageEvent);
	}

	protected function registerEventListeners():void
	{
	}

	protected function afterInitialization():void
	{
	}

	protected function listenersRemoved():void
	{
	}

	protected function registerEventListener(eventType:Class, listener:Function):void
	{
		var registration:ListenerRegistration = EventBus.instance.addEventListener(eventType, listener);

		registrations.push(registration);
	}

	private function removeEventListeners():void
	{
		var registration:ListenerRegistration;
		for each (registration in registrations)
		{
			registration.removeListener();
		}
		registrations = new Array();
		listenersRemoved();
	}

	private function onAddedToStageEvent(event:Event):void
	{
		if (registrations.length)
		{
			Log.warning("Listeners already registered! Class name: ", Object(this).constructor);
			//TODO: need better decision
		}
		else
		{
			registerEventListeners();
			afterInitialization();
		}
	}

	private function onRemovedFromStageEvent(event:Event):void
	{
		removeEventListeners();
	}
}
}