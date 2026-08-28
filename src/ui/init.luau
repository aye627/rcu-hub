local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Rebirth Champions Ultimate",
    Icon = "trophy",
    Theme = "MonokaiPro"
})
Window._threads = {} -- safety to prevent memory leaks
Window._connections = {} -- same purpose

task.spawn(function() require("./tabs/transparent.luau")(Window) end)
require("./tabs/clicker.luau")(Window)
require("./tabs/rebirths.luau")(Window)
require("./tabs/upgrades.luau")(Window)
require("./tabs/debug_stats.luau")(Window)

Window:OnDestroy(function()
    for i, thread_obj in ipairs(Window._threads) do
        task.cancel(thread_obj)
    end

    for i, connection_obj in ipairs(Window._connections) do
        connection_obj:Disconnect()
    end

    table.clear(Window._threads)
    table.clear(Window._connections)
    Window = nil
    WindUI = nil

    --if collectgarbage then collectgarbage("collect") end
end)
