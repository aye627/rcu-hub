type ListenerFunction__DARKLUA_TYPE_a = (old_value:number, new_value:number) -> any

local a = {
    cache = {}::any,
}

do
    do
        local function __modImpl()
            local b = {}
            local c = game:GetService'ReplicatedStorage'
            local d = require(c.Packages.Knit)
            local e = d.GetService'ClickService'
            local f = d.GetController'DataController'

            function b.onClicksChange(g: ListenerFunction__DARKLUA_TYPE_a)
                return f.replica:OnSet({
                    'clicks',
                }, g)
            end
            function b.click()
                e.click:Fire()
            end

            return b
        end

        function a.a(): typeof(__modImpl())
            local b = a.cache.a

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.a = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = a.a()

            return function(c)
                local d = false
                local e = c:Tab{
                    Title = 'Clicker',
                    Icon = 'mouse-pointer-click',
                }

                e:Toggle{
                    Title = 'Fast Auto Clicker',
                    Desc = 'Enable Auto Clicker',
                    Icon = 'mouse-pointer-click',
                    Flag = 'fastAutoClicker',
                    Callback = function(f)
                        d = f
                    end,
                }
                task.spawn(function()
                    while true do
                        if d then
                            b.click()
                        end

                        task.wait(1.6666666666666665E-2)
                    end
                end)

                return e
            end
        end

        function a.b(): typeof(__modImpl())
            local b = a.cache.b

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.b = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = {}
            local c = game:GetService'ReplicatedStorage'
            local d = require(c.Shared.List.Upgrades)
            local e = require(c.Shared.List.Rebirths)
            local f = require(c.Shared.Variables)
            local g = require(c.Packages.Knit)
            local h = g.GetService'RebirthService'

            function b.unlockedRebirthButtons(i): {number}
                local j = {}
                local k = d.rebirthButtons.upgrades[i.upgrades.rebirthButtons or 0]

                for l, m in ipairs(e)do
                    if k.value >= l then
                        j[l] = m
                    end
                end

                return j
            end
            function b.rebirth(i: number)
                h:rebirth(i)
            end
            function b.calculateRebirthPrice(i, j: number): number
                local k = e[j]

                return (f.rebirthPrice + i.rebirths * f.rebirthPriceMultiplier) * k + f.rebirthPriceMultiplier * (k * (k - 1) / 2)
            end

            return b
        end

        function a.c(): typeof(__modImpl())
            local b = a.cache.c

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.c = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = {}
            local c = game:GetService'ReplicatedStorage'
            local d = require(c.Packages.Knit)
            local e = d.GetController'DataController'

            function b.getData()
                return e:getData()
            end

            return b
        end

        function a.d(): typeof(__modImpl())
            local b = a.cache.d

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.d = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = a.c()
            local c = a.a()
            local d = a.d()
            local e = require(game:GetService'ReplicatedStorage'.Shared.Functions)

            local function get_normalized_rebirths()
                local f = {}
                local g = {}
                local h = b.unlockedRebirthButtons(d.getData())

                for i, j in ipairs(h)do
                    f[e.suffixes(j)] = i
                    g[i] = e.suffixes(j)
                end

                return g, f
            end

            return function(f)
                local g = d.getData()
                local h = 1
                local i = false
                local j = 0
                local k = b.calculateRebirthPrice(g, h)
                local l, m = get_normalized_rebirths()
                local n = f:Tab{
                    Title = 'Rebirth',
                    Icon = 'refresh-ccw',
                }
                local o = n:Dropdown{
                    Title = 'Auto-Rebirth',
                    Desc = 'Select Auto-Rebirth Value',
                    Values = l,
                    Callback = function(o)
                        h = m[o]
                        k = b.calculateRebirthPrice(g, h)

                        print(k)
                    end,
                    Flag = 'selectedAutoRebirth',
                }

                n:Button{
                    Title = 'Refresh Buttons',
                    Callback = function()
                        l, m = get_normalized_rebirths()

                        o:Refresh(l)
                    end,
                }
                n:Toggle{
                    Title = 'Toggle Auto-Rebirth',
                    Callback = function()
                        i = true
                    end,
                    Flag = 'toggleAutoRebirth',
                }
                c.onClicksChange(function(p, q)
                    j = q
                end)
                task.spawn(function()
                    while true do
                        if i then
                            if j >= k then
                                b.rebirth(h)
                            end
                        end

                        task.wait()
                    end
                end)

                return n
            end
        end

        function a.e(): typeof(__modImpl())
            local b = a.cache.e

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.e = b
            end

            return b.c
        end
    end
end

local b = loadstring(game:HttpGet
[[https://github.com/Footagesus/WindUI/releases/latest/download/main.lua]])()
local c = b:CreateWindow{
    Title = 'Rebirth Champions Ultimate',
    Icon = 'trophy',
    Theme = 'MonokaiPro',
}

a.b()(c)
a.e()(c)
