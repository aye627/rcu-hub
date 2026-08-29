--// Services & Packages
local PlayerGuiUtil = require("../utils/player_gui.luau")
local DataService = require("../../backend/services/data.luau")
local UpgradeService = require("../../backend/services/upgrades.luau")

--// Variables
local UpgradesSort = {
    {Title = "Expensive First", Icon = "gem"},
    {Title = "Cheap First", Icon = "badge-percent"},
    {Title = "Custom Order", Icon = "settings-2"}
}
local CategoriesData = {
    Spawn = {
        Thumbnail = "rbxassetid://108379018063166",
        List = UpgradeService.upgrades
    },
    Dungeon = {
        Thumbnail = "rbxassetid://134529890290858",
        List = UpgradeService.dungeonUpgrades
    },
    Fishing = {
        Thumbnail = "rbxassetid://123935569797121",
        List = UpgradeService.fishingUpgrades
    },
    Hive = {
        Thumbnail = "rbxassetid://80411257431791",
        List = UpgradeService.hiveUpgrades
    }
}
local CategoryToThumbnail = {}
local CategoryToList = {}
local CategoryList = {}
local UpgradesList = {}
local state = {
    autoUpgradeSettings = {}
}

local counter = 1
for name, data in CategoriesData do
    CategoryToThumbnail[name] = data.Thumbnail
    CategoryToList[name] = data.List
    CategoryList[counter] = name
    UpgradesList[name] = {}

    for upgrade_name, _ in data.List do
        table.insert(UpgradesList[name], upgrade_name)
    end
    counter = counter + 1
end
counter = nil
CategoriesData = nil

--// Functions

return function(Window)
    local Tab = Window:Tab({
        Title = "Upgrades",
        Icon = "chevrons-up",
    })

    local UpgradesSortDropdown, UpgradesOrderDropdown
    Tab:Paragraph({
        Title = CategoryList[1],
        Thumbnail = CategoryToThumbnail[CategoryList[1]],
        ThumbnailSize = 80
    })

    Tab:Dropdown({
        Title = "Upgrades Category",
        Values = CategoryList,
        AllowNone = false,
        Callback = function(option)
            local settings = state.autoUpgradeSettings
            UpgradesSortDropdown:Select(settings.upgradeSort)
            UpgradesOrderDropdown:Refresh(UpgradesList[option])
            UpgradesOrderDropdown:Select(settings.upgradeOrder)
        end
    })

    UpgradesSortDropdown = Tab:Dropdown({
        Title = "Upgrades Sort",
        Values = UpgradesSort
    })

    UpgradesOrderDropdown = Tab:Dropdown({
        Title = "Upgrades Buy Order",
        Values = UpgradesList[CategoryList[1]],
        AllowNone = false,
        Multi = true,
        Callback = function(options)
            
        end
    })
end
