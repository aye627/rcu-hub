local Service = {}

--// Roblox Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// References
local LocalPlayer = Players.LocalPlayer
local Values = require(ReplicatedStorage.Shared.Values)
local Functions = require(ReplicatedStorage.Shared.Functions)

--// Functions
function Service.clickMultiplier(data)
    return Functions.suffixes(
        Functions.floatingPoint(Values.clicks(LocalPlayer, data))
    )
end

function Service.rebirthsMultiplier(data)
    return Functions.suffixes(
        Functions.floatingPoint(Values.rebirths(LocalPlayer, data))
    )
end

function Service.hatchingSpeed(data)
    return Functions.suffixes(
        4.11 / Functions.floatingPoint(Values.hatchSpeed(LocalPlayer, data))
    )
end

function Service.epicClickChance(data)
    return Functions.floatingPoint(Values.epicClickChance(LocalPlayer, data))
end

return Service
