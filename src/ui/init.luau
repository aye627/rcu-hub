local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Rebirth Champions Ultimate",
    Icon = "trophy",
    Theme = "MonokaiPro"
})
Window._threads = {} -- safety to prevent memory leaks
Window._connections = {} -- same purpose

local Clicker = require("./tabs/clicker.luau")(Window)
local Rebirths = require("./tabs/rebirths.luau")(Window)

Window:OnDestroy(function()
    for i, thread_obj in ipairs(Window._threads) do
        task.cancel(thread_obj)
    end

    for i, connection_obj in ipairs(Window._connections) do
        connection_obj:Disconnect()
    end

    table.clear(Window._threads)
    table.clear(Window._connections)
    Clicker = nil
    Rebirths = nil
    Window = nil
    WindUI = nil

    if collectgarbage then collectgarbage("collect") end
end)
