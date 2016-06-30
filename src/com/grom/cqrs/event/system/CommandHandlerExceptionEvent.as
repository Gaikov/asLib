package com.grom.cqrs.event.system
{
import com.grom.cqrs.event.BaseExceptionEvent;

[RemoteClass(alias="net.subjectivity.cqrs.event.system.CommandHandlerExceptionEvent")]
public class CommandHandlerExceptionEvent extends BaseExceptionEvent
{
    public function CommandHandlerExceptionEvent(message:String = null)
    {
        super(message);
    }
}
}
