--// Services & Packages
local DebugService = require("../../backend/services/debug")

--// Module internals
local Paragraphs = {
    device_category = {
        Icon = "monitor-smartphone",
        Title = "Device Category"
    },
    platform = {
        Icon = "gamepad",
        Title = "Platform",
        _handler = function(v: Enum.Platform) return v.Name end
    },
    --[[fullscreen = {
        Icon = "expand",
        Title = "In Fullscreen?",
        _handler = function(v: boolean) return tostring(v) end
    },
    mouse_sensitivity = {
        Icon = "mouse",
        Title = "Mouse Sensitivity",
        _handler = function(v: number) return round_decimal(v, 2) end
    },
    quality_level = {
        Icon = "file-image",
        Title = "Graphic Quality Level",
        _handler = function(v: Enum.SavedQualitySetting) return v.Name end
    },]]
    memory_usage = {
        Icon = "database",
        Title = "Memory Usage (RAM)",
        _handler = function(v: number) return math.round(v) end
    }
}
local Config = {
    debugStats = DebugService.getDebugStats(),
    updateDelay = 3
}
local handlers = {}

local function round_decimal(num, decimalPlaces)
    local mult = 10 ^ (decimalPlaces or 0)
    if num >= 0 then
        return math.floor(num * mult + 0.5) / mult
    else
        return math.ceil(num * mult - 0.5) / mult
    end
end
    
local function update()
    Config.debugStats = DebugService.getDebugStats()
        
    local link = Config.debugStats
    for name, object in Paragraphs do
        local value = link[name]
        local handler = handlers[name]
        local result = if handler then handler(value) else value

        object:SetDesc(result)
    end
end
    
return function(Window)
    local Tab = Window:Tab({
        Title = "Debug",
        Icon = "chart-column"
    })

    Tab:Slider({
        Title = "Update Frequency",
        Desc = "In seconds",
        Value = {
            Min = 1,
            Max = 60,
            Default = Config.updateDelay
        },
        Step = 1,
        Callback = function(value)
            Config.updateDelay = value
        end,
        Flag = "debugUpdateDelay"
    })

    for name, config in Paragraphs do
        local handler = ref._handler
        local value = Config.debugStats[name]
        local ref = Paragraphs[name]

        ref.Desc = if handler then handler(value) else value
        handlers[name] = handler
        Paragraphs[name] = Tab:Paragraph(config)
    end
    
    local loop = task.spawn(function()
        while true do
            update()
            task.wait(updateDelay)
        end
    end)
        
    table.insert(Window._threads, loop)
    return Tab
end
