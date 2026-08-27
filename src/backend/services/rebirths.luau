local Service = {}

--// Roblox Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Upgrades = require(ReplicatedStorage.Shared.List.Upgrades)
local Rebirths = require(ReplicatedStorage.Shared.List.Rebirths)
local Variables = require(ReplicatedStorage.Shared.Variables)

--// Packages
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Knit
local RebirthService = Knit.GetService("RebirthService")

--// Functions
function Service.unlockedRebirthButtons(data): { number }
    local unlocked = {}
    local max_rebirth = Upgrades.rebirthButtons.upgrades[data.upgrades.rebirthButtons or 0]

    for index, value in ipairs(Rebirths) do
        if max_rebirth.value >= index then unlocked[index] = value end
    end
    
    return unlocked
end

function Service.rebirth(index: number)
   RebirthService:rebirth(index)
end

function Service.calculateRebirthPrice(data, index: number): number
    local selectedRebirth = Rebirths[index]

    return (Variables.rebirthPrice + data.rebirths * Variables.rebirthPriceMultiplier) * selectedRebirth + Variables.rebirthPriceMultiplier * (selectedRebirth * (selectedRebirth - 1) / 2)
end

return Service
