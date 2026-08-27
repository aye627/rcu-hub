local ClickerService = require("../../backend/services/click")

-- See `Tab` at "https://footagesus.github.io/WindUI-Docs/docs/tab"
return function(Window)
    local fastAutoClicker = false
    local delay = 1/60

    local Tab = Window:Tab({
        Title = "Clicker",
        Icon = "mouse-pointer-click"
    })

    local ClickDelay = Tab:Slider({
        Title = "Click Delay",
        Value = {
            Min = 0,
            Max = 1,
            Default = delay
        },
        Step = 1/100,
        Callback = function(value)
            delay = value
        end
    })

    Tab:Toggle({
        Title = "Auto Clicker",
        Desc = "Enable Auto Clicker",
        Icon = "mouse-pointer-click",
        Flag = "fastAutoClicker",
        Callback = function(value)
            fastAutoClicker = value
        end
    })
    
    local loop = task.spawn(function()
        while true do
            if fastAutoClicker then
                ClickerService.click()
            end
            task.wait(delay)
        end
    end)
    table.insert(Window._threads, loop)

    return Tab
end
