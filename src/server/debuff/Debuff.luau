--!strict
local RunService = game:GetService("RunService")
local Types = require(script.Parent.DebuffSchema);

--- @class Debuff
--- Applies debuff to an entity and runs related events until expiry.
--- @field EntityId string id of entity that debuff is applied to.
--- @field EndTime number os.clock() of time when it should expire.
--- @field NextTick number os.clock() of time when next tick should run.
--- @field Schema Types.DebuffSchema unique debuff related data.
local Debuff = {}
Debuff.__index = Debuff

--- Initialises new debuff.
--- @param entityId string id of an entity that schema is applied to.
--- @param schema Types.DebuffSchema configuration of the schema.
function Debuff.new(entityId: string, schema: Types.DebuffSchema)
    local now = os.clock()
    local self = setmetatable({}, Debuff)

    self.EntityId = entityId
    self.EndTime = now + schema.Duration
    self.NextTick = now + schema.TickInterval
    self.Schema = schema
    self.Data = schema.UniqueStatusData

    schema.OnApplied(entityId, self.Data)

    self.Connection = RunService.Heartbeat:Connect(function()
        self:_OnTick()
    end)

    return self
end

--- Destroys and cleans up the debuff.
function Debuff:Destroy() 
    self.Schema.OnRemoved(self.EntityId, self.Data)
    if self.Connection then 
        self.Connection:Disconnect()
    end
end

function Debuff:_OnTick()
    local now = os.clock()

    if (now >= self.NextTick) then 
        self.Schema.OnTick(self.EntityId, self.Data)
        self.NextTick = now + self.Schema.TickInterval
        return
    end

    if (now >= self.EndTime) then 
        self:Destroy()
        return
    end
end

return Debuff