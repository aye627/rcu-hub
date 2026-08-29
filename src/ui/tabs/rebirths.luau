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
    buttons = {}
}

--// Functions
local function doubleToSuffixed(n: number): string
    return Functions.suffixes(Functions.floatingPoint(n))
end

local function refreshRebirths()
    table.clear(state.buttons)
    table.clear(state.nameToIndexMap)
    
    local unlocked = RebirthService.unlockedRebirthButtons(DataService.getData())
    for index, value in ipairs(unlocked) do
        local formatted = doubleToSuffixed(value)
        state.buttons[index] = tostring(formatted)
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
    refreshRebirths()

    local Tab = Window:Tab({
        Title = "Rebirth",
        Icon = "refresh-ccw"
    })

    local RebirthParagraph = Tab:Paragraph({
        Title = "Selected Option",
        Desc = state.buttons[state.selectedRebirthIndex],
        Image = "icon-restart",
        ImageSize = 20
    })

    local RebirthSlider = Tab:Slider({
        Title = "Auto-Rebirth",
        Desc = "Select Auto-Rebirth Value",
        Value = {
            Min = 0,
            Max = #state.buttons - 1,
            Default = 0
        },
        Callback = function(value)
            state.selectedRebirthIndex = value
            RebirthParagraph:SetDesc(state.buttons[value])
        end,
        Flag = "selectedAutoRebirth"
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

    local upgradesConnection = DataService.replica:OnSet({ "upgrades" }, function()
        refreshRebirths()
        RebirthSlider:SetMax(#state.buttons)
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
