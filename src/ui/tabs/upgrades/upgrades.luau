local UpgradeService = require("../../../../backend/services/upgrades.luau")
local DataService = require("../../../../backend/services/data.luau")

--// Module State
local state = {
    data = DataService:getData(),
    autoUpgradeEnabled = false,
    autoUpgradeSort = "Expensive",
    autoUpgradeOrder = {}
}

return function(Section)
    local Tab = Section:Tab({
        Icon = "chevrons-up",
        Title = "Upgrades"
    })

    Tab:Toggle({
        Title = "Enable Auto Upgrade",
        Value = state.autoUpgradeEnabled,
        Callback = function(value)
            state.autoUpgradeEnabled = value
        end,
        Flag = "autoUpgradeToggle"
    })

    Tab:Dropdown({
        Title = "Auto Upgrade Sort",
        Desc = "Tells what upgrade script should buy first",
        Value = state.autoUpgradeSort,
        Values = {"Expensive", "Cheap", "Custom Order"},
        Callback = function(option)
            state.autoUpgradeSort = option
        end
    })

    Tab:Dropdown({

    })
end
