package com.grom.cqrs.event.system
{
import com.grom.cqrs.event.BaseExceptionEvent;

public class ConnectionFailureEvent extends BaseExceptionEvent
{
    public function ConnectionFailureEvent(message:String)
    {
        super(message);
    }
}
}
