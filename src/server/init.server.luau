local Types = require(script.debuff.DebuffSchema)
local Debuff = require(script.debuff.Debuff)

local BurningDebuff: Types.DebuffSchema = {
    Duration = 5,
    TickInterval = 1,
    UniqueStatusData = {
        Damage = 5,
    },

    OnApplied = function(id, data) 
        print(`Applying ${data.Damage} damage debuff against entity with id ${id}`)
    end,

    OnTick = function(id, data) 
        print(`Imagine that we are applying ${data.Damage} damage to entity with id ${id}`)
    end,

    OnRemoved = function(id, data) 
        print(`Removing ${data.Damage} damage debuff against entity with id ${id}`)
    end,
}

local debuff1 = Debuff.new(1, BurningDebuff);
task.wait(5)
debuff1:Destroy()
Debuff.new(2, BurningDebuff);