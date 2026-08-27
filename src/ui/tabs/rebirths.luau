local RebirthService = require("../../backend/services/rebirths")
local ClickerService = require("../../backend/services/click")
local DataService = require("../../backend/services/data")

local Functions = require(game:GetService("ReplicatedStorage").Shared.Functions)

local function get_normalized_rebirths()
    local vkMap = {}
    local stringButtons = {} 
    local unlockedButtons = RebirthService.unlockedRebirthButtons(DataService.getData())
    
    for i, v in ipairs(unlockedButtons) do
        vkMap[Functions.suffixes(v)] = i
        stringButtons[i] = Functions.suffixes(v) 
    end

    return stringButtons, vkMap
end

return function(Window)
    local data = DataService.getData()
    local selectedAutoRebirth = 1
    local autoRebirthing = false
    local clickCount = 0
    local rebirthPrice = RebirthService.calculateRebirthPrice(data, selectedAutoRebirth)

    local buttons, map = get_normalized_rebirths()

    local Tab = Window:Tab({
        Title = "Rebirth",
        Icon = "refresh-ccw"
    })
    
    local RebirthsDropdown = Tab:Dropdown({
        Title = "Auto-Rebirth",
        Desc = "Select Auto-Rebirth Value",
        Values = buttons,
        Callback = function(option)
            selectedAutoRebirth = map[option]
            rebirthPrice = RebirthService.calculateRebirthPrice(data, selectedAutoRebirth)
            
            print(rebirthPrice) 
            
        end,
        Flag = "selectedAutoRebirth"
    })

    Tab:Button({
        Title = "Refresh Buttons",
        Callback = function()
            buttons, map = get_normalized_rebirths() 
            RebirthsDropdown:Refresh(buttons)
        end
    })

    Tab:Toggle({
        Title = "Toggle Auto-Rebirth",
        Callback = function()
            autoRebirthing = true
        end,
        Flag = "toggleAutoRebirth"
    })
    
    ClickerService.onClicksChange(function(old, new) 
        clickCount = new
    end)

    task.spawn(function()
        while true do
            if autoRebirthing then
               if clickCount >= rebirthPrice then 
                    RebirthService.rebirth(selectedAutoRebirth)
                end
            end
            task.wait() -- little delay just in case
        end
    end)

    return Tab
end
