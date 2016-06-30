package com.grom.cqrs.domain.event
{
import com.grom.cqrs.domain.common.VersionedId;

public class DomainEvent implements BaseEvent
{
    public var aggregateRootId:VersionedId;

    function DomainEvent()
    {
    }
}
}