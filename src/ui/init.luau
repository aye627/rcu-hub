local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Rebirth Champions Ultimate",
    Icon = "trophy",
    Theme = "MonokaiPro"
})

local Clicker = require("./tabs/clicker.luau")(Window)
local Rebirths = require("./tabs/rebirths.luau")(Window)
