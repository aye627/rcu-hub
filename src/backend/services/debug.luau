local Service = {}

--// Services & Packages
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
--local UserGameSettings = game:GetService("UserGameSettings") unknown issue with actor
local GuiService = game:GetService("GuiService")

--// References
local LocalPlayer = Players.LocalPlayer

--// Types
type DebugStats = {
    device_category: string,
    platform: Enum.Platform,
    fullscreen: boolean,
    mouse_sensitivity: number,
    quality_level: Enum.SavedQualitySetting,
    memory_usage: number
}

--// Functions
local function getDeviceCategory()
    if GuiService:IsTenFootInterface() then
        return "Console"
	  elseif UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		    return "Mobile"
	  else
		    return "Desktop"
	  end
end

function Service.getDebugStats(): DebugStats
    local success, platform = pcall(function() return UserInputService:GetPlatform() end)
    
    return {
        device_category = getDeviceCategory(),
        platform = if success then platform else "Unknown",
        --fullscreen = UserGameSettings:InFullscreen(),
        --mouse_sensitivity = UserGameSettings.MouseSensitivity,
        --quality_level = UserGameSettings.SavedQualityLevel,
        memory_usage = Stats:GetTotalMemoryUsageMb()
    }
end

return Service
