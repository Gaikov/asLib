package com.grom.cqrs.event.system
{
import com.grom.cqrs.domain.event.BaseEvent;

[RemoteClass(alias="net.maygem.common.event.system.EventsTokenEvent")]
public class EventsTokenEvent implements BaseEvent
{
    public var token:Number;

    public function EventsTokenEvent()
    {
    }
}
}