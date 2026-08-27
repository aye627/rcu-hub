local Service = {}

--// Roblox Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Packages
local Knit = require(ReplicatedStorage.Packages.Knit) 

--// Knit
local ClickService = Knit.GetService("ClickService")
local DataController = Knit.GetController("DataController")

--// Types
type ListenerFunction = (old_value: number, new_value: number) -> any

--// Functions
function Service.onClicksChange(listener: ListenerFunction)
    return DataController.replica:OnSet({ "clicks" }, listener)
end

function Service.click()
    ClickService.click:Fire()
end

return Service

