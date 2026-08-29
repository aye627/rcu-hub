local Util = {}

--// Services & Packages
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Functions = require(ReplicatedStorage.Shared.Functions)

--// References
 -- i'd say waitforchild is kinda bad practice
local PlayerGui = Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
local MainUI = PlayerGui:WaitForChild("MainUI")
local Frames = MainUI:WaitForChild("Menus")

--// Functions
local UpgradesList = Frames:WaitForChild("UpgradesFrame"):WaitForChild("Main"):WaitForChild("List").Holder.Upgrades

function Util.upgradeIdToName(id: string): string
    local element_name = Functions.toPascal(id)
    local ui_element = UpgradesList:FindFirstChild(element_name)
    if not ui_element then error(`Couldn't find {element_name} in Upgrades`) end
            
    return ui_element.Main.UpgradeName.Text
end

return Util
