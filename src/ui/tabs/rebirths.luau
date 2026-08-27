--// Services & Dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local RebirthService = require("../../backend/services/rebirths")
local ClickerService = require("../../backend/services/click")
local DataService = require("../../backend/services/data")
local Functions = require(ReplicatedStorage.Shared.Functions)

--// Module State
local state = {
    selectedRebirthIndex = 1,
    isAutoRebirthing = false,
    currentClicks = 0,
    buttons = {},
    nameToIndexMap = {}
}

--// Functions
local function refreshRebirthOptions()
    table.clear(state.buttons)
    table.clear(state.nameToIndexMap)
    
    local unlocked = RebirthService.unlockedRebirthButtons(DataService.getData())
    for index, value in ipairs(unlocked) do
        local formatted = Functions.suffixes(value)
        state.buttons[index] = tostring(formatted)
        state.nameToIndexMap[tostring(formatted)] = index
    end
end

local function getSelectedPrice()
    local data = DataService.getData()
    return RebirthService.calculateRebirthPrice(data, state.selectedRebirthIndex)
end

local function attemptRebirth()
    if not state.isAutoRebirthing then return end
    
    local price = getSelectedPrice()
    if state.currentClicks >= price then
        RebirthService.rebirth(state.selectedRebirthIndex)
    end
end

return function(Window)
    refreshRebirthOptions()

    local Tab = Window:Tab({
        Title = "Rebirth",
        Icon = "refresh-ccw"
    })
    
    local RebirthsDropdown = Tab:Dropdown({
        Title = "Auto-Rebirth",
        Desc = "Select Auto-Rebirth Value",
        Values = state.buttons,
        Callback = function(selectedOption)
            state.selectedRebirthIndex = state.nameToIndexMap[selectedOption] or 1
        end,
        Flag = "selectedAutoRebirth"
    })

    Tab:Button({
        Title = "Refresh Buttons",
        Callback = function()
            refreshRebirthOptions()
            RebirthsDropdown:Refresh(state.buttons)
        end
    })

    Tab:Toggle({
        Title = "Toggle Auto-Rebirth",
        Callback = function(enabled)
            state.isAutoRebirthing = enabled
        end,
        Flag = "toggleAutoRebirth"
    })

    local connection = ClickerService.onClicksChange(function(_, newClicksValue) 
        state.currentClicks = newClicksValue
        attemptRebirth()
    end)

    local loop = task.spawn(function()
        while true do
            RunService.RenderStepped:Wait()
            attemptRebirth()
        end
    end)

    table.insert(Window._threads, loop)
    table.insert(Window._connections, connection)

    return Tab
end
