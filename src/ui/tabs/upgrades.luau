local UpgradeService = require("../../backend/services/upgrades.luau")
local DataService = require("../../backend/services/data.luau")

--// Functions
local function upgradesToArray(upgrades)
    local result = {}
    local counter = 1
    for name, _ in ipairs(upgrades) do
        result[counter] = name
    end
    return result
end

--// Variables
local backgroundMap = {
    Spawn = "rbxassetid://108379018063166",
    Dungeon = "rbxassetid://134529890290858",
    Hive = "rbxassetid://80411257431791",
    Fishing = "rbxassetid://86301195991861"
}
local state = {
    autoUpgradeEnabled = false,
    autoUpgradeSort = "Expensive",
    autoUpgradeOrder = {},
    autoUpgradeCategory = "Spawn"
}

return function(Window)
    local Tab = Window:Tab({
        Icon = "chevrons-up",
        Title = "Upgrades"
    })

    local paragraphButtons = {}
    local counter = 1
    local paragraph
    for name, asset in backgroundMap do
        paragraphButtons[counter] = {
            Title = name,
            Callback = function()
                paragraph:SetThumbnail(asset)
            end
        }
        counter = counter + 1
    end
    -- free some space just in case
    backgroundMap = nil
    counter = nil

    paragraph = Tab:Paragraph({
        Title = "Upgrades Category",
        Color = "Grey",
        Image = "map-pin",
        ImageSize = 30,
        Thumbnail = "rbxassetid://77341192020088",
        ThumbnailSize = 80,
        Locked = false,
        Buttons = paragraphButtons
    })
    paragraphButtons = nil -- already rendered

    Tab:Toggle({
        Title = "Enable Auto Upgrade",
        Value = state.autoUpgradeEnabled,
        Callback = function(value)
            state.autoUpgradeEnabled[autoUpgradeCategory] = value
        end,
        Flag = "autoUpgradeToggle"
    })

    Tab:Dropdown({
        Title = "Auto Upgrade Sort",
        Desc = "Tells what upgrade script should buy first",
        Value = state.autoUpgradeSort,
        Values = {"Expensive", "Cheap", "Custom Order"},
        Callback = function(option)
            state.autoUpgradeSort[state.autoUpgradeCategory] = option
        end
    })

    Tab:Dropdown({
        Title = "Auto Upgrade Order",
        Desc = "(Upgrades are represented with their ID)",
        Values = upgradesToArray(UpgradeService.upgrades),
        Multi = true,
        AllowNone = true,
        Callback = function(options)
            state.autoUpgradeOrder[state.autoUpgradeCategory] = options
        end
    })

    return Tab
end
