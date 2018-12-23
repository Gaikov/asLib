package com.grom.cqrs.domain.eventbus
{
import com.grom.cqrs.domain.event.BaseEvent;

import flash.utils.Dictionary;

public class EventBus implements IEventBus
{
    protected static var _instance:EventBus = new EventBus();

    protected var listenersMap:Dictionary = new Dictionary();
    public var listenersCount:int = 0;

    public static function get instance():EventBus
    {
        return _instance;
    }

    public function EventBus()
    {
    }

    public function addEventListener(eventClass:Class, listener:Function):ListenerRegistration
    {
        var listeners:Array = listenersMap[eventClass];
        if (listeners == null)
        {
            listeners = [];
            listenersMap[eventClass] = listeners;
        }

        listeners.push(listener);
        listenersCount++;

        return new EventBusListenerRegistration(function():void
        {
            var index:Number = listeners.indexOf(listener);
            if (index >= 0)
            {
                listeners.splice(index, 1);
                listenersCount--;
            }
        });
    }

    public function dispatchEvent(event:BaseEvent):void
    {
        var eventClass:Class = Object(event).constructor;

        var listeners:Array = listenersMap[eventClass];
        if (listeners != null)
        {
            var handler:Function;
            for each (handler in listeners)
            {                                          
                handler(event);
            }
        }
    }
}
}