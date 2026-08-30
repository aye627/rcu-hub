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
    local current_category = CategoryList[1]

    local Tab = Window:Tab({
        Title = "Upgrades",
        Icon = "chevrons-up",
    })

    local UpgradesSortDropdown, UpgradesOrderDropdown
    local Paragraph = Tab:Paragraph({
        Title = current_category,
        Thumbnail = CategoryToThumbnail[current_category],
        ThumbnailSize = 80
    })

    Tab:Dropdown({
        Title = "Upgrades Category",
        Values = CategoryList,
        AllowNone = false,
        Callback = function(option)
            current_category = option
            local settings = state.autoUpgradeSettings[current_category]
            UpgradesSortDropdown:Select(settings.upgradeSort or UpgradesSort[1].Title)
            UpgradesOrderDropdown:Refresh(UpgradesList[option])
            if settings.upgradeOrder then
                UpgradesOrderDropdown:Select(settings.upgradeOrder)
            end
            Paragraph:SetTitle(option)
            Paragraph:SetThumbnail(CategoryToThumbnail[option])
        end
    })

    UpgradesSortDropdown = Tab:Dropdown({
        Title = "Upgrades Sort",
        Values = UpgradesSort,
        Callback = function(option)
            state.autoUpgradeSettings[current_category].upgradeSort = option 
        end
    })

    UpgradesOrderDropdown = Tab:Dropdown({
        Title = "Upgrades Buy Order",
        Values = UpgradesList[current_category],
        AllowNone = false,
        Multi = true,
        Callback = function(options)
            state.autoUpgradeSettings[current_category].upgradeOrder = options
        end
    })

    return Tab
end
