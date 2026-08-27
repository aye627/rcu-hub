local ClickerService = require("../../backend/services/click")

-- See `Tab` at "https://footagesus.github.io/WindUI-Docs/docs/tab"
return function(Window)
    local fastAutoClicker = false

    local Tab = Window:Tab({
        Title = "Clicker",
        Icon = "mouse-pointer-click"
    })

    Tab:Toggle({
        Title = "Fast Auto Clicker",
        Desc = "Enable Auto Clicker",
        Icon = "mouse-pointer-click",
        Flag = "fastAutoClicker",
        Callback = function(value)
            fastAutoClicker = value
        end
    })
    
    task.spawn(function()
        while true do
            if fastAutoClicker then
                ClickerService.click()
            end
            task.wait(1/60)
        end
    end)

    return Tab
end
