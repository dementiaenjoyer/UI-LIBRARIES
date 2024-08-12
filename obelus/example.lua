--// init the library

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/main/obelus/src.lua"))()

local window = library:Window({name = `<font color=\"#AA55EB\">obelus</font> | {os.date("%b %d %Y", os.time())}`, color = Color3.fromRGB(255, 255, 255)})

local tabs = {
    aimbot = window:Page({Name = "aimbot"}),
    antiaim = window:Page({Name = "antiaim"}),
    visuals = window:Page({Name = "visuals"}),
    misc = window:Page({Name = "misc"}),
    config = window:Page({Name = "config"}),
    skins = window:Page({Name = "skins"})
}
local sections = {
    aimbot_section = tabs.aimbot:Section({Name = "players", size = 330}),
    aimbot_section2 = tabs.aimbot:Section({Name = "colored models", Side = "Right"})
}

local label = sections.aimbot_section:Label({
    Name = "label hello random"
})

local label2 = sections.aimbot_section:Label({
    Name = "with none", Offset = 16
})

local toggle = sections.aimbot_section:Toggle({
    Name = "random toggle", 
    Default = true, 
    Callback = function(val) 
        warn(val) 
    end
})

local slider = sections.aimbot_section:Slider({
    Default = 10, 
    Minimum = -10, 
    Maximum = 30, 
    Decimals = 10, 
    Suffix = "%", 
    Callback = function(val) 
        warn(val) 
    end
})

local button = sections.aimbot_section:Button({
    Name = "random button", 
    Callback = function() 
        warn("clicked") 
    end
})

local slider = sections.aimbot_section:Slider({
    Name = "random slider", 
    Callback = function(val) 
        warn(val) 
    end
})

local slider = sections.aimbot_section:Slider({
    Name = "random slider", 
    Default = 10, 
    Minimum = -10, 
    Maximum = 30, 
    Decimals = 10, 
    Suffix = "%", 
    Callback = function(val) 
        warn(val) 
    end
})

local label = sections.aimbot_section:Label({
    Name = "label hello random"
})

local label2 = sections.aimbot_section:Label({
    Name = "with none", 
    Offset = 16
})

local toggle = sections.aimbot_section:Toggle({
    Name = "random toggle", 
    Default = true, 
    Callback = function(val) 
        warn(val) 
    end
})

local slider = sections.aimbot_section:Slider({
    Default = 10, 
    Minimum = -10, 
    Maximum = 30, 
    Decimals = 10, 
    Suffix = "%", 
    Callback = function(val) 
        warn(val) 
    end
})

local button = sections.aimbot_section:Button({
    Name = "random button", 
    Callback = function() 
        warn("clicked") 
    end
})

local slider = sections.aimbot_section:Slider({
    Name = "random slider", 
    Callback = function(val) 
        warn(val) 
    end
})

local slider = sections.aimbot_section:Slider({
    Name = "random slider", 
    Default = 10, 
    Minimum = -10, 
    Maximum = 30, 
    Decimals = 10, 
    Suffix = "%", Callback = function(val) 
        warn(val) 
    end
})
--
sections.aimbot_section:Turn(true)
