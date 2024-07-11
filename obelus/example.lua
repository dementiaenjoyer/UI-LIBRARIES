--// init the library

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/main/obelus/src.lua"))()

local window = library:Window({name = "<font color=\"#AA55EB\">elixer.sol</font> | Jul 7 2021"})

local aimbot = window:Page({Name = "aimbot"})
local antiaim = window:Page({Name = "antiaim"})
local visuals = window:Page({Name = "visuals"})
local misc = window:Page({Name = "misc"})
local config = window:Page({Name = "config"})
local skins = window:Page({Name = "skins"})

local aimbot_section = aimbot:Section({Name = "players", size = 300})
local aimbot_section2 = aimbot:Section({Name = "colored models", Side = "Right"})

local label = aimbot_section:Label({Name = "label hello random"})
local label2 = aimbot_section:Label({Name = "with none", Offset = 16})
local toggle = aimbot_section:Toggle({Name = "random toggle", Default = true, Callback = function(val) warn(val) end})
local slider = aimbot_section:Slider({Default = 10, Minimum = -10, Maximum = 30, Decimals = 10, Suffix = "%", Callback = function(val) warn(val) end})
local button = aimbot_section:Button({Name = "random button", Callback = function() warn("clicked") end})
local slider = aimbot_section:Slider({Name = "random slider", Callback = function(val) warn(val) end})
local slider = aimbot_section:Slider({Name = "random slider", Default = 10, Minimum = -10, Maximum = 30, Decimals = 10, Suffix = "%", Callback = function(val) warn(val) end})
local label = aimbot_section:Label({Name = "label hello random"})
local label2 = aimbot_section:Label({Name = "with none", Offset = 16})
local toggle = aimbot_section:Toggle({Name = "random toggle", Default = true, Callback = function(val) warn(val) end})
local slider = aimbot_section:Slider({Default = 10, Minimum = -10, Maximum = 30, Decimals = 10, Suffix = "%", Callback = function(val) warn(val) end})
local button = aimbot_section:Button({Name = "random button", Callback = function() warn("clicked") end})
local slider = aimbot_section:Slider({Name = "random slider", Callback = function(val) warn(val) end})
local slider = aimbot_section:Slider({Name = "random slider", Default = 10, Minimum = -10, Maximum = 30, Decimals = 10, Suffix = "%", Callback = function(val) warn(val) end})
--
aimbot:Turn(true)
