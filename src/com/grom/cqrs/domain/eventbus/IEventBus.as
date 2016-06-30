package com.grom.cqrs.domain.eventbus {
import com.grom.cqrs.domain.event.BaseEvent;

public interface IEventBus
{
    function addEventListener(eventClass:Class, listener:Function):ListenerRegistration;

    function dispatchEvent(event:BaseEvent):void;
}
}