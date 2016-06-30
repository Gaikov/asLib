package com.grom.cqrs.event
{
import com.grom.cqrs.domain.event.BaseEvent;

public class BaseExceptionEvent implements BaseEvent
{
    public var message:String;

    function BaseExceptionEvent(message:String)
    {
        this.message = message;
    }
}
}