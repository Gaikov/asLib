package com.grom.cqrs.event.system
{
import com.grom.cqrs.event.BaseExceptionEvent;

public class RemoteObjectExceptionEvent extends BaseExceptionEvent
{
    public function RemoteObjectExceptionEvent(message:String)
    {
        super(message);
    }
}
}