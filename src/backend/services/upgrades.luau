local Service = {}

--// Services & Packages
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local Upgrades = require(ReplicatedStorage.Shared.List.Upgrades)
local UpgradeService = Knit.GetService("UpgradeService")

--// Functions

return Service
