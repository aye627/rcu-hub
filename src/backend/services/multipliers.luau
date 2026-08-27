local Service = {}

--// Roblox Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// References
local LocalPlayer = Players.LocalPlayer
local Variables = ReplicatedStorage.Shared.Variables
local Functions = ReplicatedStorage.Shared.Functions

--// Functions
function Service.clickMultiplier(data)
    return Functions.suffixes(
        Functions.floatingPoint(Variables.clicks(LocalPlayer, data))
    )
end

function Service.rebirthsMultiplier(data)
    return Functions.suffixes(
        Functions.floatingPoint(Variables.rebirths(LocalPlayer, data))
    )
end

function Service.hatchingSpeed(data)
    return Functions.suffixes(
        4.11 / Functions.floatingPoint(Variables.hatchSpeed(LocalPlayer, data))
    )
end

return Service
