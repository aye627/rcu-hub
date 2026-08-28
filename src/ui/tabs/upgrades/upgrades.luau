local UpgradeService = require("../../../../backend/services/upgrades.luau")
local DataService = require("../../../../backend/services/data.luau")

--// Module State
local state = {
    data = DataService:getData()
}

return function(Section)
    local Tab = Section:Tab({
        Icon = "chevrons-up",
        Title = "Upgrades"
    })

    
end
