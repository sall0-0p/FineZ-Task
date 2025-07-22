export type DebuffSchema = {
    Duration: number,
    TickInterval: number,
    UniqueStatusData: table,

    OnApplied: (entityId: string, uniqueStatusData: table) -> nil,
    OnTick: (entityId: string, uniqueStatusData: table) -> nil,
    OnRemoved: (entityId: string, uniqueStatusData: table) -> nil,
}

return nil