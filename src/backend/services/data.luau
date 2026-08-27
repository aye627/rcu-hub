local Service = {}

--// Roblox Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Packages
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Knit
local DataController = Knit.GetController("DataController")

--// Functions
function Service.getData()
    return DataController:getData()
end

return Service
