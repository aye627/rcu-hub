local Service = {}

--// Services & Packages
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local Upgrades = require(ReplicatedStorage.Shared.List.Upgrades)
local FishingUpgrades = require(ReplicatedStorage.Shared.List.Fishing.FishingUpgrades)
local DungeonUpgrades = require(ReplicatedStorage.Shared.List.Dungeon.Upgrades)
local HiveUpgrades = require(ReplicatedStorage.Shared.List.Hive.HiveUpgrades)

local UpgradeService = Knit.GetService("UpgradeService")
local HiveService = Knit.GetService("HiveService")
local DungeonService = Knit.GetService("DungeonService")

--// Functions
function Service.buyUpgrade(id: string)
    return UpgradeService:upgrade(id)
end

function Service.buyFishingUpgrade(id: string)
    return UpgradeService:upgradeFishing(id)
end

function Service.buyDungeonUpgrade(id: string)
    return DungeonService:upgrade(id)
end

function Service.buyHiveUpgrade(id: string)
    return HiveService:buyHiveUpgrade(id)
end

return Service
