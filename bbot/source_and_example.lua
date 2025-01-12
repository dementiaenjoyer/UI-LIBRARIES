local COLOR = 1
local COLOR1 = 2
local COLOR2 = 3
local COMBOBOX = 4
local TOGGLE = 5
local KEYBIND = 6
local DROPBOX = 7
local COLORPICKER = 8
local DOUBLE_COLORPICKERS = 9
local SLIDER = 10
local BUTTON = 11
local LIST = 12
local IMAGE = 13
local TEXTBOX = 14 -- menu type enums and shit

if not BBOT then
    BBOT = { username = "dev" }
end

local menu
assert(getgenv().v2 == nil)
getgenv().v2 = true
makefolder("bitchbot")
local MenuName = isfile("bitchbot/menuname.txt") and readfile("bitchbot/menuname.txt") or nil
local loadstart = tick()
local Nate = isfile("cole.mak")

local customChatSpam = {}
local customKillSay = {}
local e = 2.718281828459045
local placeholderImage = "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"
-- please keep this here
local PingStat = game:service("Stats").PerformanceStats.Ping
local function GetLatency()
    return PingStat:GetValue() / 1000
end
placeholderImage = crypt.base64.decode(placeholderImage)
if not isfile("bitchbot/chatspam.txt") then --idk help the user out lol, prevent stupid errors --well it would kinda ig
    writefile(
        "bitchbot/chatspam.txt",
        [[
WSUP FOOL
GET OWNED KID
BBOAT ON TOP
I LOVE BBOT YEAH
PLACEHOLDER TEXT
dear bbot user, edit your chat spam
    ]]
    )
end

if not isfile("bitchbot/killsay.txt") then
    writefile(
        "bitchbot/killsay.txt",
        [[
WSUP FOOL [name]
GET OWNED [name]
[name] just died to my [weapon] everybody laugh
[name] got owned roflsauce
PLACEHOLDER TEXT
dear bbot user, edit your kill say
    ]]
    )
end

do
    local customtxt = readfile("bitchbot/chatspam.txt")
    for s in customtxt:gmatch("[^\n]+") do -- I'm Love String:Match
        table.insert(customChatSpam, s) -- I'm care
    end
    customtxt = readfile("bitchbot/killsay.txt")
    for s in customtxt:gmatch("[^\n]+") do -- I'm Love String:Match
        table.insert(customKillSay, s)
    end
end

local function map(N, OldMin, OldMax, Min, Max)
    return (N - OldMin) / (OldMax - OldMin) * (Max - Min) + Min
end

local function reverse_table(tbl) -- THANKS FINI <33333
    local new_tbl = {}
    for i = 1, #tbl do
        new_tbl[#tbl + 1 - i] = tbl[i]
    end
    return new_tbl
end

local NotifLogs = {}
local CreateNotification
do
    local notes = {}
    local function DrawingObject(t, col)
        local d = Drawing.new(t)

        d.Visible = true
        d.Transparency = 1
        d.Color = col

        return d
    end

    local function Rectangle(sizex, sizey, fill, col)
        local s = DrawingObject("Square", col)

        s.Filled = fill
        s.Thickness = 1
        s.Position = Vector2.new()
        s.Size = Vector2.new(sizex, sizey)

        return s
    end

    local function Text(text)
        local s = DrawingObject("Text", Color3.new(1, 1, 1))

        s.Text = text
        s.Size = 13
        s.Center = false
        s.Outline = true
        s.Position = Vector2.new()
        s.Font = 2

        return s
    end

    CreateNotification = function(t, customcolor) -- TODO i want some kind of prioritized message to the notification list, like a warning or something. warnings have icons too maybe? idk??
        table.insert(NotifLogs, string.format("[%s]: %s", os.date("%X"), t))
        local gap = 25
        local width = 18

        local alpha = 255
        local time = 0
        local estep = 0
        local eestep = 0.02

        local insety = 0

        local Note = {

            enabled = true,

            targetPos = Vector2.new(50, 33),

            size = Vector2.new(200, width),

            drawings = {
                outline = Rectangle(202, width + 2, false, Color3.new(0, 0, 0)),
                fade = Rectangle(202, width + 2, false, Color3.new(0, 0, 0)),
            },

            Remove = function(self, d)
                if d.Position.x < d.Size.x then
                    for k, drawing in pairs(self.drawings) do
                        drawing:Remove()
                        drawing = false
                    end
                    self.enabled = false
                end
            end,

            Update = function(self, num, listLength, dt)
                local pos = self.targetPos

                local indexOffset = (listLength - num) * gap
                if insety < indexOffset then
                    insety -= (insety - indexOffset) * 0.2
                else
                    insety = indexOffset
                end
                local size = self.size

                local tpos = Vector2.new(pos.x - size.x / time - map(alpha, 0, 255, size.x, 0), pos.y + insety)
                self.pos = tpos

                local locRect = {
                    x = math.ceil(tpos.x),
                    y = math.ceil(tpos.y),
                    w = math.floor(size.x - map(255 - alpha, 0, 255, 0, 70)),
                    h = size.y,
                }
                --pos.set(-size.x / fc - map(alpha, 0, 255, size.x, 0), pos.y)

                local fade = math.min(time * 12, alpha)
                fade = fade > 255 and 255 or fade < 0 and 0 or fade

                if self.enabled then
                    local linenum = 1
                    for i, drawing in pairs(self.drawings) do
                        drawing.Transparency = fade / 255

                        if type(i) == "number" then
                            drawing.Position = Vector2.new(locRect.x + 1, locRect.y + i)
                            drawing.Size = Vector2.new(locRect.w - 2, 1)
                        elseif i == "text" then
                            drawing.Position = tpos + Vector2.new(6, 2)
                        elseif i == "outline" then
                            drawing.Position = Vector2.new(locRect.x, locRect.y)
                            drawing.Size = Vector2.new(locRect.w, locRect.h)
                        elseif i == "fade" then
                            drawing.Position = Vector2.new(locRect.x - 1, locRect.y - 1)
                            drawing.Size = Vector2.new(locRect.w + 2, locRect.h + 2)
                            local t = (200 - fade) / 255 / 3
                            drawing.Transparency = t < 0.4 and 0.4 or t
                        elseif i:find("line") then
                            drawing.Position = Vector2.new(locRect.x + linenum, locRect.y + 1)
                            if menu then
                                local mencol = customcolor or (
                                        menu:GetVal("Settings", "Cheat Settings", "Menu Accent") and Color3.fromRGB(unpack(menu:GetVal("Settings", "Cheat Settings", "Menu Accent", COLOR))) or Color3.fromRGB(127, 72, 163)
                                    )
                                local color = linenum == 1 and mencol or Color3.fromRGB(mencol.R * 255 - 40, mencol.G * 255 - 40, mencol.B * 255 - 40) -- super shit
                                if drawing.Color ~= color then
                                    drawing.Color = color
                                end
                            end
                            linenum += 1
                        end
                    end

                    time += estep * dt * 128 -- TODO need to do the duration
                    estep += eestep * dt * 64
                end
            end,

            Fade = function(self, num, len, dt)
                if self.pos.x > self.targetPos.x - 0.2 * len or self.fading then
                    if not self.fading then
                        estep = 0
                    end
                    self.fading = true
                    alpha -= estep / 4 * len * dt * 50
                    eestep += 0.01 * dt * 100
                end
                if alpha <= 0 then
                    self:Remove(self.drawings[1])
                end
            end,
        }

        for i = 1, Note.size.y - 2 do
            local c = 0.28 - i / 80
            Note.drawings[i] = Rectangle(200, 1, true, Color3.new(c, c, c))
        end
        local color = (menu and menu.GetVal) and customcolor or menu:GetVal("Settings", "Cheat Settings", "Menu Accent") and Color3.fromRGB(unpack(menu:GetVal("Settings", "Cheat Settings", "Menu Accent", COLOR))) or Color3.fromRGB(127, 72, 163)

        Note.drawings.text = Text(t)
        if Note.drawings.text.TextBounds.x + 7 > Note.size.x then -- expand the note size to fit if it's less than the default size
            Note.size = Vector2.new(Note.drawings.text.TextBounds.x + 7, Note.size.y)
        end
        Note.drawings.line = Rectangle(1, Note.size.y - 2, true, color)
        Note.drawings.line1 = Rectangle(1, Note.size.y - 2, true, color)

        notes[#notes + 1] = Note
    end

    renderStepped = game:GetService("RunService").RenderStepped:Connect(function(dt)
        Camera = workspace.CurrentCamera
        local smallest = math.huge
        for k = 1, #notes do
            local v = notes[k]
            if v and v.enabled then
                smallest = k < smallest and k or smallest
            else
                table.remove(notes, k)
            end
        end
        local length = #notes
        for k = 1, #notes do
            local note = notes[k]
            note:Update(k, length, dt)
            if k <= math.ceil(length / 10) or note.fading then
                note:Fade(k, length, dt)
            end
        end
    end)
    --ANCHOR how to create notification
    --CreateNotification("Loading...")
end

--validity check
--SECTION commented these out for development

-- make_synreadonly(syn)
-- make_synreadonly(Drawing)
-- protectfunction(getgenv)
-- protectfunction(getgc)

-- local init
-- if syn then
--     init = getfenv(saveinstance).script
-- end

-- script.Name = "\1"
-- local function search_hookfunc(tbl)
--     for i,v in pairs(tbl) do
--         local s = getfenv(v).script
--         if is_synapse_function(v) and islclosure(v) and s and s ~= script and s.Name ~= "\1" and s ~= init then
--             if tostring(unpack(debug.getconstants(v))):match("hookfunc") or tostring(unpack(debug.getconstants(v))):match("hookfunction") then
--                 writefile("poop.text", "did the funny")
--                 SX_CRASH()
--                 break
--             end
--         end
--     end
-- end
-- search_hookfunc(getgc())
-- search_hookfunc = nil

--if syn.crypt.derive(BBOT.username, 32) ~= BBOT.check then SX_CRASH() end

--!SECTION
local menuWidth, menuHeight = 500, 600
menu = { -- this is for menu stuffs n shi
    w = menuWidth,
    h = menuHeight,
    x = 0,
    y = 0,
    columns = {
        width = math.floor((menuWidth - 40) / 2),
        left = 17,
        right = math.floor((menuWidth - 20) / 2) + 13,
    },
    activetab = 1,
    open = true,
    fadestart = 0,
    fading = false,
    mousedown = false,
    postable = {},
    options = {},
    clrs = {
        norm = {},
        dark = {},
        togz = {},
    },
    mc = { 127, 72, 163 },
    watermark = {},
    connections = {},
    list = {},
    unloaded = false,
    copied_clr = nil,
    game = "uni",
    tabnames = {}, -- its used to change the tab num to the string (did it like this so its dynamic if u add or remove tabs or whatever :D)
    friends = {},
    priority = {},
    muted = {},
    spectating = false,
    stat_menu = false,
    load_time = 0,
    log_multi = nil,
    mgrouptabz = {},
    backspaceheld = false,
    backspacetime = -1,
    backspaceflags = 0,
    selectall = false,
    modkeys = {
        alt = {
            direction = nil,
        },
        shift = {
            direction = nil,
        },
    },
    modkeydown = function(self, key, direction)
        local keydata = self.modkeys[key]
        return keydata.direction and keydata.direction == direction or false
    end,
    keybinds = {},
    values = {}
}

local function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function average(t)
    local sum = 0
    for _, v in pairs(t) do -- Get the sum of all numbers in t
        sum = sum + v
    end
    return sum / #t
end

local function clamp(a, lowerNum, higher) -- DONT REMOVE this clamp is better then roblox's because it doesnt error when its not lower or heigher
    if a > higher then
        return higher
    elseif a < lowerNum then
        return lowerNum
    else
        return a
    end
end

local function CreateThread(func, ...) -- improved... yay.
    local thread = coroutine.create(func)
    coroutine.resume(thread, ...)
    return thread
end

local function MultiThreadList(obj, ...)
    local n = #obj
    if n > 0 then
        for i = 1, n do
            local t = obj[i]
            if type(t) == "table" then
                local d = #t
                assert(d ~= 0, "table inserted was not an array or was empty")
                assert(d < 3, ("invalid number of arguments (%d)"):format(d))
                local thetype = type(t[1])
                assert(
                    thetype == "function",
                    ("invalid argument #1: expected 'function', got '%s'"):format(tostring(thetype))
                )

                CreateThread(t[1], unpack(t[2]))
            else
                CreateThread(t, ...)
            end
        end
    else
        for i, v in pairs(obj) do
            CreateThread(v, ...)
        end
    end
end

local DeepRestoreTableFunctions, DeepCleanupTable

DeepRestoreTableFunctions = function(tbl)
    for k, v in next, tbl do
        if type(v) == "function" and is_synapse_function(v) then
            for k1, v1 in next, getupvalues(v) do
                if type(v1) == "function" and islclosure(v1) and not is_synapse_function(v1) then
                    tbl[k] = v1
                end
            end
        end

        if type(v) == "table" then
            DeepRestoreTableFunctions(v)
        end
    end
end

DeepCleanupTable = function(tbl)
    local numTable = #tbl
    local isTableArray = numTable > 0
    if isTableArray then
        for i = 1, numTable do
            local entry = tbl[i]
            local entryType = type(entry)

            if entryType == "table" then
                DeepCleanupTable(tbl)
            end

            tbl[i] = nil
            entry = nil
            entryType = nil
        end
    else
        for k, v in next, tbl do
            if type(v) == "table" then
                DeepCleanupTable(tbl)
            end
        end

        tbl[k] = nil
    end

    numTable = nil
    isTableArray = nil
end

local event = {}

local allevent = {}

function event.new(eventname, eventtable, requirename) -- fyi you can put in a table of choice to make the table you want an "event" pretty cool its like doing & in c lol!
    if eventname then
        assert(
            allevent[eventname] == nil,
            ("the event '%s' already exists in the event table"):format(eventname)
        )
    end
    local newevent = eventtable or {}
    local funcs = {}
    local disconnectlist = {}
    function newevent:fire(...)
        allevent[eventname].fire(...)
    end
    function newevent:connect(func)
        funcs[#funcs + 1] = func
        local disconnected = false
        local function disconnect()
            if not disconnected then
                disconnected = true
                disconnectlist[func] = true
            end
        end
        return disconnect
    end

    local function fire(...)
        local n = #funcs
        local j = 0
        for i = 1, n do
            local func = funcs[i]
            if disconnectlist[func] then
                disconnectlist[func] = nil
            else
                j = j + 1
                funcs[j] = func
            end
        end
        for i = j + 1, n do
            funcs[i] = nil
        end
        for i = 1, j do
            CreateThread(function(...)
                pcall(funcs[i], ...)
            end, ...)
        end
    end

    if eventname then
        allevent[eventname] = {
            event = newevent,
            fire = fire,
        }
    end

    return newevent, fire
end

local function FireEvent(eventname, ...)
    if allevent[eventname] then
        return allevent[eventname].fire(...)
    else
        --warn(("Event %s does not exist!"):format(eventname))
    end
end

local function GetEvent(eventname)
    return allevent[eventname]
end

local BBOT_IMAGES = {}
MultiThreadList({
    function()
        BBOT_IMAGES[1] = game:HttpGet("https://i.imgur.com/9NMuFcQ.png")
    end,
    function()
        BBOT_IMAGES[2] = game:HttpGet("https://i.imgur.com/jG3NjxN.png")
    end,
    function()
        BBOT_IMAGES[3] = game:HttpGet("https://i.imgur.com/2Ty4u2O.png")
    end,
    function()
        BBOT_IMAGES[4] = game:HttpGet("https://i.imgur.com/kNGuTlj.png")
    end,
    function()
        BBOT_IMAGES[5] = game:HttpGet("https://i.imgur.com/OZUR3EY.png")
    end,
    function()
        BBOT_IMAGES[6] = game:HttpGet("https://i.imgur.com/3HGuyVa.png")
    end,
})

-- MULTITHREAD DAT LOADING SO FAST!!!!
local loaded = {}
do
    local function Loopy_Image_Checky()
        for i = 1, 6 do
            local v = BBOT_IMAGES[i]
            if v == nil then
                return true
            elseif not loaded[i] then
                loaded[i] = true
            end
        end
        return false
    end
    while Loopy_Image_Checky() do
        wait(0)
    end
end


loadstart = tick()

-- nate i miss u D:
-- im back
local NETWORK = game:service("NetworkClient")
local NETWORK_SETTINGS = settings().Network
NETWORK:SetOutgoingKBPSLimit(0)

setfpscap(getgenv().maxfps or 144)

if not isfolder("bitchbot") then
    makefolder("bitchbot")
    if not isfile("bitchbot/relations.bb") then
        writefile("bitchbot/relations.bb", "bb:{{friends:}{priority:}")
    end
else
    if not isfile("bitchbot/relations.bb") then
        writefile("bitchbot/relations.bb", "bb:{{friends:}{priority:}")
    end
    writefile("bitchbot/debuglog.bb", "")
end

if not isfolder("bitchbot/" .. menu.game) then
    makefolder("bitchbot/" .. menu.game)
end

local configs = {}

local function GetConfigs()
    local result = {}
    local directory = "bitchbot\\" .. menu.game
    for k, v in pairs(listfiles(directory)) do
        local clipped = v:sub(#directory + 2)
        if clipped:sub(#clipped - 2) == ".bb" then
            clipped = clipped:sub(0, #clipped - 3)
            result[k] = clipped
            configs[k] = v
        end
    end
    if #result <= 0 then
        writefile("bitchbot/" .. menu.game .. "/Default.bb", "")
    end
    return result
end

local Players = game:GetService("Players")
local LIGHTING = game:GetService("Lighting")
local stats = game:GetService("Stats")

local function UnpackRelations()
    local str = isfile("bitchbot/relations.bb") and readfile("bitchbot/relations.bb") or nil
    local final = {
        friends = {},
        priority = {},
    }
    if str then
        if str:find("bb:{{") then
            writefile("bitchbot/relations.bb", "friends:\npriority:")
            return
        end

        local friends, frend = str:find("friends:")
        local priority, priend = str:find("\npriority:")
        local friendslist = str:sub(frend + 1, priority - 1)
        local prioritylist = str:sub(priend + 1)
        for i in friendslist:gmatch("[^,]+") do
            if not table.find(final.friends, i) then
                table.insert(final.friends, i)
            end
        end
        for i in prioritylist:gmatch("[^,]+") do
            if not table.find(final.priority, i) then
                table.insert(final.priority, i)
            end
        end
    end
    if not menu then
        repeat
            game:GetService("RunService").Heartbeat:Wait()
        until menu
    end
    menu.friends = final.friends
    if not table.find(menu.friends, Players.LocalPlayer.Name) then
        table.insert(menu.friends, Players.LocalPlayer.Name)
    end
    menu.priority = final.priority
end

local function WriteRelations()
    local str = "friends:"

    for k, v in next, menu.friends do
        local playerobj
        local userid
        local pass, ret = pcall(function()
            playerobj = Players[v]
        end)

        if not pass then
            local newpass, newret = pcall(function()
                userid = v
            end)
        end

        if userid then
            str ..= tostring(userid) .. ","
        else
            str ..= tostring(playerobj.Name) .. ","
        end
    end

    str ..= "\npriority:"

    for k, v in next, menu.priority do
        local playerobj
        local userid
        local pass, ret = pcall(function()
            playerobj = Players[v]
        end)

        if not pass then
            local newpass, newret = pcall(function()
                userid = v
            end)
        end

        if userid then
            str ..= tostring(userid) .. ","
        else
            str ..= tostring(playerobj.Name) .. ","
        end
    end

    writefile("bitchbot/relations.bb", str)
end
CreateThread(function()
    if (not menu or not menu.GetVal) then
        repeat
            game:GetService("RunService").Heartbeat:Wait()
        until (menu and menu.GetVal)
    end
    wait(2)
    UnpackRelations()
    WriteRelations()
end)

local LOCAL_PLAYER = Players.LocalPlayer
local LOCAL_MOUSE = LOCAL_PLAYER:GetMouse()
local TEAMS = game:GetService("Teams")
local INPUT_SERVICE = game:GetService("UserInputService")
local TELEPORT_SERVICE = game:GetService("TeleportService")
local GAME_SETTINGS = UserSettings():GetService("UserGameSettings")
local CACHED_VEC3 = Vector3.new()
local Camera = workspace.CurrentCamera
local SCREEN_SIZE = Camera.ViewportSize
--[[ local ButtonPressed = Instance.new("BindableEvent")
local TogglePressed = Instance.new("BindableEvent") ]]

local ButtonPressed = event.new("bb_buttonpressed")
local TogglePressed = event.new("bb_togglepressed")
local MouseMoved = event.new("bb_mousemoved")

--local PATHFINDING = game:GetService("PathfindingService")
local GRAVITY = Vector3.new(0, -192.6, 0)

menu.x = math.floor((SCREEN_SIZE.x / 2) - (menu.w / 2))
menu.y = math.floor((SCREEN_SIZE.y / 2) - (menu.h / 2))

local Lerp = function(delta, from, to) -- wtf why were these globals thats so exploitable!
    if (delta > 1) then
        return to
    end
    if (delta < 0) then
        return from
    end
    return from + (to - from) * delta
end

local ColorRange = function(value, ranges) -- ty tony for dis function u a homie
    if value <= ranges[1].start then
        return ranges[1].color
    end
    if value >= ranges[#ranges].start then
        return ranges[#ranges].color
    end

    local selected = #ranges
    for i = 1, #ranges - 1 do
        if value < ranges[i + 1].start then
            selected = i
            break
        end
    end
    local minColor = ranges[selected]
    local maxColor = ranges[selected + 1]
    local lerpValue = (value - minColor.start) / (maxColor.start - minColor.start)
    return Color3.new(
        Lerp(lerpValue, minColor.color.r, maxColor.color.r),
        Lerp(lerpValue, minColor.color.g, maxColor.color.g),
        Lerp(lerpValue, minColor.color.b, maxColor.color.b)
    )
end

local bVector2 = {}
do -- vector functions
    function bVector2:getRotate(Vec, Rads)
        local vec = Vec.Unit
        --x2 = cos β x1 − sin β y1
        --y2 = sin β x1 + cos β y1
        local sin = math.sin(Rads)
        local cos = math.cos(Rads)
        local x = (cos * vec.x) - (sin * vec.y)
        local y = (sin * vec.x) + (cos * vec.y)

        return Vector2.new(x, y).Unit * Vec.Magnitude
    end
end
local bColor = {}
do -- color functions
    function bColor:Mult(col, mult)
        return Color3.new(col.R * mult, col.G * mult, col.B * mult)
    end
    function bColor:Add(col, num)
        return Color3.new(col.R + num, col.G + num, col.B + num)
    end
end
local function string_cut(s1, num)
    return num == 0 and s1 or string.sub(s1, 1, num)
end

local textBoxLetters = {
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
}

local keyNames = {
    One = "1",
    Two = "2",
    Three = "3",
    Four = "4",
    Five = "5",
    Six = "6",
    Seven = "7",
    Eight = "8",
    Nine = "9",
    Zero = "0",
    LeftBracket = "[",
    RightBracket = "]",
    Semicolon = ";",
    BackSlash = "\\",
    Slash = "/",
    Minus = "-",
    Equals = "=",
    Return = "Enter",
    Backquote = "`",
    CapsLock = "Caps",
    LeftShift = "LShift",
    RightShift = "RShift",
    LeftControl = "LCtrl",
    RightControl = "RCtrl",
    LeftAlt = "LAlt",
    RightAlt = "RAlt",
    Backspace = "Back",
    Plus = "+",
    Multiplaye = "x",
    PageUp = "PgUp",
    PageDown = "PgDown",
    Delete = "Del",
    Insert = "Ins",
    NumLock = "NumL",
    Comma = ",",
    Period = ".",
}
local colemak = {
    E = "F",
    R = "P",
    T = "G",
    Y = "J",
    U = "L",
    I = "U",
    O = "Y",
    P = ";",
    S = "R",
    D = "S",
    F = "T",
    G = "D",
    J = "N",
    K = "E",
    L = "I",
    [";"] = "O",
    N = "K",
}

local keymodifiernames = {
    ["`"] = "~",
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    ["["] = "{",
    ["]"] = "}",
    ["\\"] = "|",
    [";"] = ":",
    ["'"] = '"',
    [","] = "<",
    ["."] = ".",
    ["/"] = "?",
}

local function KeyEnumToName(key) -- did this all in a function cuz why not
    if key == nil then
        return "None"
    end
    local _key = tostring(key) .. "."
    local _key = _key:gsub("%.", ",")
    local keyname = nil
    local looptime = 0
    for w in _key:gmatch("(.-),") do
        looptime = looptime + 1
        if looptime == 3 then
            keyname = w
        end
    end
    if string.match(keyname, "Keypad") then
        keyname = string.gsub(keyname, "Keypad", "")
    end

    if keyname == "Unknown" or key.Value == 27 then
        return "None"
    end

    if keyNames[keyname] then
        keyname = keyNames[keyname]
    end
    if Nate then
        return colemak[keyname] or keyname
    else
        return keyname
    end
end

local invalidfilekeys = {
    ["\\"] = true,
    ["/"] = true,
    [":"] = true,
    ["*"] = true,
    ["?"] = true,
    ['"'] = true,
    ["<"] = true,
    [">"] = true,
    ["|"] = true,
}

local function KeyModifierToName(key, filename)
    if keymodifiernames[key] ~= nil then
        if filename then
            if invalidfilekeys[keymodifiernames[key]] then
                return ""
            else
                return keymodifiernames[key]
            end
        else
            return keymodifiernames[key]
        end
    else
        return ""
    end
end

local allrender = {}

local RGB = Color3.fromRGB
local Draw = {}
do
    function Draw:UnRender()
        for k, v in pairs(allrender) do
            for k1, v1 in pairs(v) do
                --warn(k1, v1)
                -- ANCHOR WHAT THE FUCK IS GOING ON WITH THIS WHY IS THIS ERRORING BECAUSE OF NUMBER
                if v1 and type(v1) ~= "number" and v1.__OBJECT_EXISTS then
                    v1:Remove()
                else
                    --rconsolewarn(tostring(k),tostring(v),tostring(k1),tostring(v1)) -- idfk why but this shit doesn't print anything out. might as well have it commented out though -nata april 1 21
                end
            end
        end
    end

    function Draw:OutlinedRect(visible, pos_x, pos_y, width, height, clr, tablename)
        local temptable = Drawing.new("Square")
        temptable.Visible = visible
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Size = Vector2.new(width, height)
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Filled = false
        temptable.Thickness = 0
        temptable.Transparency = clr[4] / 255
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:FilledRect(visible, pos_x, pos_y, width, height, clr, tablename)
        local temptable = Drawing.new("Square")
        temptable.Visible = visible
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Size = Vector2.new(width, height)
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Filled = true
        temptable.Thickness = 0
        temptable.Transparency = clr[4] / 255
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:Line(visible, thickness, start_x, start_y, end_x, end_y, clr, tablename)
        temptable = Drawing.new("Line")
        temptable.Visible = visible
        temptable.Thickness = thickness
        temptable.From = Vector2.new(start_x, start_y)
        temptable.To = Vector2.new(end_x, end_y)
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Transparency = clr[4] / 255
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:Image(visible, imagedata, pos_x, pos_y, width, height, transparency, tablename)
        local temptable = Drawing.new("Image")
        temptable.Visible = visible
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Size = Vector2.new(width, height)
        temptable.Transparency = transparency
        temptable.Data = imagedata or placeholderImage
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:Text(text, font, visible, pos_x, pos_y, size, centered, clr, tablename)
        local temptable = Drawing.new("Text")
        temptable.Text = text
        temptable.Visible = visible
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Size = size
        temptable.Center = centered
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Transparency = clr[4] / 255
        temptable.Outline = false
        temptable.Font = font
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:OutlinedText(text, font, visible, pos_x, pos_y, size, centered, clr, clr2, tablename)
        local temptable = Drawing.new("Text")
        temptable.Text = text
        temptable.Visible = visible
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Size = size
        temptable.Center = centered
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Transparency = clr[4] / 255
        temptable.Outline = true
        temptable.OutlineColor = RGB(clr2[1], clr2[2], clr2[3])
        temptable.Font = font
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
        if tablename then
            table.insert(tablename, temptable)
        end
        return temptable
    end

    function Draw:Triangle(visible, filled, pa, pb, pc, clr, tablename)
        clr = clr or { 255, 255, 255, 1 }
        local temptable = Drawing.new("Triangle")
        temptable.Visible = visible
        temptable.Transparency = clr[4] or 1
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        temptable.Thickness = 4.1
        if pa and pb and pc then
            temptable.PointA = Vector2.new(pa[1], pa[2])
            temptable.PointB = Vector2.new(pb[1], pb[2])
            temptable.PointC = Vector2.new(pc[1], pc[2])
        end
        temptable.Filled = filled
        table.insert(tablename, temptable)
        if tablename and not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:Circle(visible, pos_x, pos_y, size, thickness, sides, clr, tablename)
        local temptable = Drawing.new("Circle")
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Visible = visible
        temptable.Radius = size
        temptable.Thickness = thickness
        temptable.NumSides = sides
        temptable.Transparency = clr[4]
        temptable.Filled = false
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    function Draw:FilledCircle(visible, pos_x, pos_y, size, thickness, sides, clr, tablename)
        local temptable = Drawing.new("Circle")
        temptable.Position = Vector2.new(pos_x, pos_y)
        temptable.Visible = visible
        temptable.Radius = size
        temptable.Thickness = thickness
        temptable.NumSides = sides
        temptable.Transparency = clr[4]
        temptable.Filled = true
        temptable.Color = RGB(clr[1], clr[2], clr[3])
        table.insert(tablename, temptable)
        if not table.find(allrender, tablename) then
            table.insert(allrender, tablename)
        end
    end

    --ANCHOR MENU ELEMENTS

    function Draw:MenuOutlinedRect(visible, pos_x, pos_y, width, height, clr, tablename)
        Draw:OutlinedRect(visible, pos_x + menu.x, pos_y + menu.y, width, height, clr, tablename)
        table.insert(menu.postable, { tablename[#tablename], pos_x, pos_y })

        if menu.log_multi ~= nil then
            table.insert(menu.mgrouptabz[menu.log_multi[1]][menu.log_multi[2]], tablename[#tablename])
        end
    end

    function Draw:MenuFilledRect(visible, pos_x, pos_y, width, height, clr, tablename)
        Draw:FilledRect(visible, pos_x + menu.x, pos_y + menu.y, width, height, clr, tablename)
        table.insert(menu.postable, { tablename[#tablename], pos_x, pos_y })

        if menu.log_multi ~= nil then
            table.insert(menu.mgrouptabz[menu.log_multi[1]][menu.log_multi[2]], tablename[#tablename])
        end
    end

    function Draw:MenuImage(visible, imagedata, pos_x, pos_y, width, height, transparency, tablename)
        Draw:Image(visible, imagedata, pos_x + menu.x, pos_y + menu.y, width, height, transparency, tablename)
        table.insert(menu.postable, { tablename[#tablename], pos_x, pos_y })

        if menu.log_multi ~= nil then
            table.insert(menu.mgrouptabz[menu.log_multi[1]][menu.log_multi[2]], tablename[#tablename])
        end
    end

    function Draw:MenuBigText(text, visible, centered, pos_x, pos_y, tablename)
        local text = Draw:OutlinedText(
            text,
            2,
            visible,
            pos_x + menu.x,
            pos_y + menu.y,
            13,
            centered,
            { 255, 255, 255, 255 },
            { 0, 0, 0 },
            tablename
        )
        table.insert(menu.postable, { tablename[#tablename], pos_x, pos_y })

        if menu.log_multi ~= nil then
            table.insert(menu.mgrouptabz[menu.log_multi[1]][menu.log_multi[2]], tablename[#tablename])
        end

        return text
    end

    function Draw:CoolBox(name, x, y, width, height, tab)
        Draw:MenuOutlinedRect(true, x, y, width, height, { 0, 0, 0, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, width - 2, height - 2, { 20, 20, 20, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 2, y + 2, width - 3, 1, { 127, 72, 163, 255 }, tab)
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 2, y + 3, width - 3, 1, { 87, 32, 123, 255 }, tab)
        table.insert(menu.clrs.dark, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 2, y + 4, width - 3, 1, { 20, 20, 20, 255 }, tab)

        for i = 0, 7 do
            Draw:MenuFilledRect(true, x + 2, y + 5 + (i * 2), width - 4, 2, { 45, 45, 45, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(45, 45, 45) }, [2] = { start = 7, color = RGB(35, 35, 35) } }
            )
        end

        Draw:MenuBigText(name, true, false, x + 6, y + 5, tab)
    end

    function Draw:CoolMultiBox(names, x, y, width, height, tab)
        Draw:MenuOutlinedRect(true, x, y, width, height, { 0, 0, 0, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, width - 2, height - 2, { 20, 20, 20, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 2, y + 2, width - 3, 1, { 127, 72, 163, 255 }, tab)
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 2, y + 3, width - 3, 1, { 87, 32, 123, 255 }, tab)
        table.insert(menu.clrs.dark, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 2, y + 4, width - 3, 1, { 20, 20, 20, 255 }, tab)

        --{35, 35, 35, 255}

        Draw:MenuFilledRect(true, x + 2, y + 5, width - 4, 18, { 30, 30, 30, 255 }, tab)
        Draw:MenuFilledRect(true, x + 2, y + 21, width - 4, 2, { 20, 20, 20, 255 }, tab)

        local selected = {}
        for i = 0, 8 do
            Draw:MenuFilledRect(true, x + 2, y + 5 + (i * 2), width - 159, 2, { 45, 45, 45, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 8, color = RGB(35, 35, 35) } }
            )
            table.insert(selected, { postable = #menu.postable, drawn = tab[#tab] })
        end

        local length = 2
        local selected_pos = {}
        local click_pos = {}
        local nametext = {}
        for i, v in ipairs(names) do
            Draw:MenuBigText(v, true, false, x + 4 + length, y + 5, tab)
            if i == 1 then
                tab[#tab].Color = RGB(255, 255, 255)
            else
                tab[#tab].Color = RGB(170, 170, 170)
            end
            table.insert(nametext, tab[#tab])

            Draw:MenuFilledRect(true, x + length + tab[#tab].TextBounds.X + 8, y + 5, 2, 16, { 20, 20, 20, 255 }, tab)
            table.insert(selected_pos, { pos = x + length, length = tab[#tab - 1].TextBounds.X + 8 })
            table.insert(click_pos, {
                x = x + length,
                y = y + 5,
                width = tab[#tab - 1].TextBounds.X + 8,
                height = 18,
                name = v,
                num = i,
            })
            length += tab[#tab - 1].TextBounds.X + 10
        end

        local settab = 1
        for k, v in pairs(selected) do
            menu.postable[v.postable][2] = selected_pos[settab].pos
            v.drawn.Size = Vector2.new(selected_pos[settab].length, 2)
        end

        return { bar = selected, barpos = selected_pos, click_pos = click_pos, nametext = nametext }

        --Draw:MenuBigText(str, true, false, x + 6, y + 5, tab)
    end

    function Draw:Toggle(name, value, unsafe, x, y, tab)
        Draw:MenuOutlinedRect(true, x, y, 12, 12, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, 10, 10, { 0, 0, 0, 255 }, tab)

        local temptable = {}
        for i = 0, 3 do
            Draw:MenuFilledRect(true, x + 2, y + 2 + (i * 2), 8, 2, { 0, 0, 0, 255 }, tab)
            table.insert(temptable, tab[#tab])
            if value then
                tab[#tab].Color = ColorRange(i, {
                    [1] = { start = 0, color = RGB(menu.mc[1], menu.mc[2], menu.mc[3]) },
                    [2] = { start = 3, color = RGB(menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40) },
                })
            else
                tab[#tab].Color = ColorRange(i, {
                    [1] = { start = 0, color = RGB(50, 50, 50) },
                    [2] = { start = 3, color = RGB(30, 30, 30) },
                })
            end
        end

        Draw:MenuBigText(name, true, false, x + 16, y - 1, tab)
        if unsafe == true then
            tab[#tab].Color = RGB(245, 239, 120)
        end
        table.insert(temptable, tab[#tab])
        return temptable
    end

    function Draw:Keybind(key, x, y, tab)
        local temptable = {}
        Draw:MenuFilledRect(true, x, y, 44, 16, { 25, 25, 25, 255 }, tab)
        Draw:MenuBigText(KeyEnumToName(key), true, true, x + 22, y + 1, tab)
        table.insert(temptable, tab[#tab])
        Draw:MenuOutlinedRect(true, x, y, 44, 16, { 30, 30, 30, 255 }, tab)
        table.insert(temptable, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 1, y + 1, 42, 14, { 0, 0, 0, 255 }, tab)

        return temptable
    end

    function Draw:ColorPicker(color, x, y, tab)
        local temptable = {}

        Draw:MenuOutlinedRect(true, x, y, 28, 14, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, 26, 12, { 0, 0, 0, 255 }, tab)

        Draw:MenuFilledRect(true, x + 2, y + 2, 24, 10, { color[1], color[2], color[3], 255 }, tab)
        table.insert(temptable, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 2, y + 2, 24, 10, { color[1] - 40, color[2] - 40, color[3] - 40, 255 }, tab)
        table.insert(temptable, tab[#tab])
        Draw:MenuOutlinedRect(true, x + 3, y + 3, 22, 8, { color[1] - 40, color[2] - 40, color[3] - 40, 255 }, tab)
        table.insert(temptable, tab[#tab])

        return temptable
    end

    function Draw:Slider(name, stradd, value, minvalue, maxvalue, customvals, rounded, x, y, length, tab)
        Draw:MenuBigText(name, true, false, x, y - 3, tab)

        for i = 0, 3 do
            Draw:MenuFilledRect(true, x + 2, y + 14 + (i * 2), length - 4, 2, { 0, 0, 0, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 3, color = RGB(30, 30, 30) } }
            )
        end

        local temptable = {}
        for i = 0, 3 do
            Draw:MenuFilledRect(
                true,
                x + 2,
                y + 14 + (i * 2),
                (length - 4) * ((value - minvalue) / (maxvalue - minvalue)),
                2,
                { 0, 0, 0, 255 },
                tab
            )
            table.insert(temptable, tab[#tab])
            tab[#tab].Color = ColorRange(i, {
                [1] = { start = 0, color = RGB(menu.mc[1], menu.mc[2], menu.mc[3]) },
                [2] = { start = 3, color = RGB(menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40) },
            })
        end
        Draw:MenuOutlinedRect(true, x, y + 12, length, 12, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 13, length - 2, 10, { 0, 0, 0, 255 }, tab)

        local textstr = ""

        if stradd == nil then
            stradd = ""
        end

        local decplaces = rounded and string.rep("0", math.log(1 / rounded) / math.log(10)) or 1
        if rounded and value == math.floor(value * decplaces) then
            textstr = tostring(value) .. "." .. decplaces .. stradd
        else
            textstr = tostring(value) .. stradd
        end

        Draw:MenuBigText(customvals[value] or textstr, true, true, x + (length * 0.5), y + 11, tab)
        table.insert(temptable, tab[#tab])
        table.insert(temptable, stradd)
        return temptable
    end

    function Draw:Dropbox(name, value, values, x, y, length, tab)
        local temptable = {}
        Draw:MenuBigText(name, true, false, x, y - 3, tab)

        for i = 0, 7 do
            Draw:MenuFilledRect(true, x + 2, y + 14 + (i * 2), length - 4, 2, { 0, 0, 0, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 7, color = RGB(35, 35, 35) } }
            )
        end

        Draw:MenuOutlinedRect(true, x, y + 12, length, 22, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 13, length - 2, 20, { 0, 0, 0, 255 }, tab)

        Draw:MenuBigText(tostring(values[value]), true, false, x + 6, y + 16, tab)
        table.insert(temptable, tab[#tab])

        Draw:MenuBigText("-", true, false, x - 17 + length, y + 16, tab)
        table.insert(temptable, tab[#tab])

        return temptable
    end

    function Draw:Combobox(name, values, x, y, length, tab)
        local temptable = {}
        Draw:MenuBigText(name, true, false, x, y - 3, tab)

        for i = 0, 7 do
            Draw:MenuFilledRect(true, x + 2, y + 14 + (i * 2), length - 4, 2, { 0, 0, 0, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 7, color = RGB(35, 35, 35) } }
            )
        end

        Draw:MenuOutlinedRect(true, x, y + 12, length, 22, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 13, length - 2, 20, { 0, 0, 0, 255 }, tab)
        local textthing = ""
        for k, v in pairs(values) do
            if v[2] then
                if textthing == "" then
                    textthing = v[1]
                else
                    textthing ..= ", " .. v[1]
                end
            end
        end
        textthing = string_cut(textthing, 25)
        textthing = textthing ~= "" and textthing or "None"
        Draw:MenuBigText(textthing, true, false, x + 6, y + 16, tab)
        table.insert(temptable, tab[#tab])

        Draw:MenuBigText("...", true, false, x - 27 + length, y + 16, tab)
        table.insert(temptable, tab[#tab])

        return temptable
    end

    function Draw:Button(name, x, y, length, tab)
        local temptable = {}

        for i = 0, 8 do
            Draw:MenuFilledRect(true, x + 2, y + 2 + (i * 2), length - 4, 2, { 0, 0, 0, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 8, color = RGB(35, 35, 35) } }
            )
            table.insert(temptable, tab[#tab])
        end

        Draw:MenuOutlinedRect(true, x, y, length, 22, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, length - 2, 20, { 0, 0, 0, 255 }, tab)
        temptable.text = Draw:MenuBigText(name, true, true, x + math.floor(length * 0.5), y + 4, tab)

        return temptable
    end

    function Draw:List(name, x, y, length, maxamount, columns, tab)
        local temptable = { uparrow = {}, downarrow = {}, liststuff = { rows = {}, words = {} } }

        for i, v in ipairs(name) do
            Draw:MenuBigText(
                v,
                true,
                false,
                (math.floor(length / columns) * i) - math.floor(length / columns) + 30,
                y - 3,
                tab
            )
        end

        Draw:MenuOutlinedRect(true, x, y + 12, length, 22 * maxamount + 4, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 13, length - 2, 22 * maxamount + 2, { 0, 0, 0, 255 }, tab)

        Draw:MenuFilledRect(true, x + length - 7, y + 16, 1, 1, { menu.mc[1], menu.mc[2], menu.mc[3], 255 }, tab)
        table.insert(temptable.uparrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuFilledRect(true, x + length - 8, y + 17, 3, 1, { menu.mc[1], menu.mc[2], menu.mc[3], 255 }, tab)
        table.insert(temptable.uparrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuFilledRect(true, x + length - 9, y + 18, 5, 1, { menu.mc[1], menu.mc[2], menu.mc[3], 255 }, tab)
        table.insert(temptable.uparrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])

        Draw:MenuFilledRect(
            true,
            x + length - 7,
            y + 16 + (22 * maxamount + 4) - 9,
            1,
            1,
            { menu.mc[1], menu.mc[2], menu.mc[3], 255 },
            tab
        )
        table.insert(temptable.downarrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuFilledRect(
            true,
            x + length - 8,
            y + 16 + (22 * maxamount + 4) - 10,
            3,
            1,
            { menu.mc[1], menu.mc[2], menu.mc[3], 255 },
            tab
        )
        table.insert(temptable.downarrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])
        Draw:MenuFilledRect(
            true,
            x + length - 9,
            y + 16 + (22 * maxamount + 4) - 11,
            5,
            1,
            { menu.mc[1], menu.mc[2], menu.mc[3], 255 },
            tab
        )
        table.insert(temptable.downarrow, tab[#tab])
        table.insert(menu.clrs.norm, tab[#tab])

        for i = 1, maxamount do
            temptable.liststuff.rows[i] = {}
            if i ~= maxamount then
                Draw:MenuOutlinedRect(true, x + 4, (y + 13) + (22 * i), length - 8, 2, { 20, 20, 20, 255 }, tab)
                table.insert(temptable.liststuff.rows[i], tab[#tab])
            end

            if columns ~= nil then
                for i1 = 1, columns - 1 do
                    Draw:MenuOutlinedRect(
                        true,
                        x + math.floor(length / columns) * i1,
                        (y + 13) + (22 * i) - 18,
                        2,
                        16,
                        { 20, 20, 20, 255 },
                        tab
                    )
                    table.insert(temptable.liststuff.rows[i], tab[#tab])
                end
            end

            temptable.liststuff.words[i] = {}
            if columns ~= nil then
                for i1 = 1, columns do
                    Draw:MenuBigText(
                        "",
                        true,
                        false,
                        (x + math.floor(length / columns) * i1) - math.floor(length / columns) + 5,
                        (y + 13) + (22 * i) - 16,
                        tab
                    )
                    table.insert(temptable.liststuff.words[i], tab[#tab])
                end
            else
                Draw:MenuBigText("", true, false, x + 5, (y + 13) + (22 * i) - 16, tab)
                table.insert(temptable.liststuff.words[i], tab[#tab])
            end
        end

        return temptable
    end

    function Draw:ImageWithText(size, image, text, x, y, tab)
        local temptable = {}
        Draw:MenuOutlinedRect(true, x, y, size + 4, size + 4, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, size + 2, size + 2, { 0, 0, 0, 255 }, tab)
        Draw:MenuFilledRect(true, x + 2, y + 2, size, size, { 40, 40, 40, 255 }, tab)

        Draw:MenuBigText(text, true, false, x + size + 8, y, tab)
        table.insert(temptable, tab[#tab])

        Draw:MenuImage(true, BBOT_IMAGES[5], x + 2, y + 2, size, size, 1, tab)
        table.insert(temptable, tab[#tab])

        return temptable
    end

    function Draw:TextBox(name, text, x, y, length, tab)
        for i = 0, 8 do
            Draw:MenuFilledRect(true, x + 2, y + 2 + (i * 2), length - 4, 2, { 0, 0, 0, 255 }, tab)
            tab[#tab].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 8, color = RGB(35, 35, 35) } }
            )
        end

        Draw:MenuOutlinedRect(true, x, y, length, 22, { 30, 30, 30, 255 }, tab)
        Draw:MenuOutlinedRect(true, x + 1, y + 1, length - 2, 20, { 0, 0, 0, 255 }, tab)
        Draw:MenuBigText(text, true, false, x + 6, y + 4, tab)

        return tab[#tab]
    end
end

--funny graf
local networkin = {
    incoming = {},
    outgoing = {},
}

for i = 1, 21 do
    networkin.incoming[i] = 20
    networkin.outgoing[i] = 2
end
local lasttick = tick()

local infopos = 400

local graphs = {
    incoming = {
        pos = {
            x = 35,
            y = infopos,
        },
        sides = {},
        graph = {},
    },
    outgoing = {
        pos = {
            x = 35,
            y = infopos + 97,
        },
        sides = {},
        graph = {},
    },
    other = {},
}
--- incoming
Draw:OutlinedText(
    "incoming kbps: 20",
    2,
    false,
    graphs.incoming.pos.x - 1,
    graphs.incoming.pos.y - 15,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.incoming.sides
)
Draw:OutlinedText(
    "80",
    2,
    false,
    graphs.incoming.pos.x - 21,
    graphs.incoming.pos.y - 7,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.incoming.sides
)

Draw:FilledRect(
    false,
    graphs.incoming.pos.x - 1,
    graphs.incoming.pos.y - 1,
    222,
    82,
    { 10, 10, 10, 50 },
    graphs.incoming.sides
)

Draw:Line(
    false,
    3,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y - 1,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y + 82,
    { 20, 20, 20, 225 },
    graphs.incoming.sides
)
Draw:Line(
    false,
    3,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y + 80,
    graphs.incoming.pos.x + 221,
    graphs.incoming.pos.y + 80,
    { 20, 20, 20, 225 },
    graphs.incoming.sides
)
Draw:Line(
    false,
    3,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y,
    graphs.incoming.pos.x - 6,
    graphs.incoming.pos.y,
    { 20, 20, 20, 225 },
    graphs.incoming.sides
)

Draw:Line(
    false,
    1,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y + 80,
    { 255, 255, 255, 225 },
    graphs.incoming.sides
)
Draw:Line(
    false,
    1,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y + 80,
    graphs.incoming.pos.x + 220,
    graphs.incoming.pos.y + 80,
    { 255, 255, 255, 225 },
    graphs.incoming.sides
)
Draw:Line(
    false,
    1,
    graphs.incoming.pos.x,
    graphs.incoming.pos.y,
    graphs.incoming.pos.x - 5,
    graphs.incoming.pos.y,
    { 255, 255, 255, 225 },
    graphs.incoming.sides
)

for i = 1, 20 do
    Draw:Line(false, 1, 10, 10, 10, 10, { 255, 255, 255, 225 }, graphs.incoming.graph)
end

Draw:Line(false, 1, 10, 10, 10, 10, { 68, 255, 0, 255 }, graphs.incoming.graph)
Draw:OutlinedText("avg: 20", 2, false, 20, 20, 13, false, { 68, 255, 0, 255 }, { 10, 10, 10 }, graphs.incoming.graph)

--- outgoing
Draw:OutlinedText(
    "outgoing kbps: 5",
    2,
    false,
    graphs.outgoing.pos.x - 1,
    graphs.outgoing.pos.y - 15,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.outgoing.sides
)
Draw:OutlinedText(
    "10",
    2,
    false,
    graphs.outgoing.pos.x - 21,
    graphs.outgoing.pos.y - 7,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.outgoing.sides
)

Draw:FilledRect(
    false,
    graphs.outgoing.pos.x - 1,
    graphs.outgoing.pos.y - 1,
    222,
    82,
    { 10, 10, 10, 50 },
    graphs.outgoing.sides
)

Draw:Line(
    false,
    3,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y - 1,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y + 82,
    { 20, 20, 20, 225 },
    graphs.outgoing.sides
)
Draw:Line(
    false,
    3,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y + 80,
    graphs.outgoing.pos.x + 221,
    graphs.outgoing.pos.y + 80,
    { 20, 20, 20, 225 },
    graphs.outgoing.sides
)
Draw:Line(
    false,
    3,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y,
    graphs.outgoing.pos.x - 6,
    graphs.outgoing.pos.y,
    { 20, 20, 20, 225 },
    graphs.outgoing.sides
)

Draw:Line(
    false,
    1,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y + 80,
    { 255, 255, 255, 225 },
    graphs.outgoing.sides
)
Draw:Line(
    false,
    1,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y + 80,
    graphs.outgoing.pos.x + 220,
    graphs.outgoing.pos.y + 80,
    { 255, 255, 255, 225 },
    graphs.outgoing.sides
)
Draw:Line(
    false,
    1,
    graphs.outgoing.pos.x,
    graphs.outgoing.pos.y,
    graphs.outgoing.pos.x - 5,
    graphs.outgoing.pos.y,
    { 255, 255, 255, 225 },
    graphs.outgoing.sides
)

for i = 1, 20 do
    Draw:Line(false, 1, 10, 10, 10, 10, { 255, 255, 255, 225 }, graphs.outgoing.graph)
end

Draw:Line(false, 1, 10, 10, 10, 10, { 68, 255, 0, 255 }, graphs.outgoing.graph)
Draw:OutlinedText("avg: 20", 2, false, 20, 20, 13, false, { 68, 255, 0, 255 }, { 10, 10, 10 }, graphs.outgoing.graph)
-- the fuckin fps and stuff i think xDDDDDd

Draw:OutlinedText(
    "loading...",
    2,
    false,
    35,
    infopos + 180,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.other
)

Draw:OutlinedText(
    "[DEBUG LOGS]",
    2,
    false,
    35,
    infopos - 200,
    13,
    false,
    { 255, 255, 255, 255 },
    { 10, 10, 10 },
    graphs.other
)

-- finish

local loadingthing = Draw:OutlinedText(
    "Loading...",
    2,
    true,
    math.floor(SCREEN_SIZE.x / 16),
    math.floor(SCREEN_SIZE.y / 16),
    13,
    true,
    { 255, 50, 200, 255 },
    { 0, 0, 0 }
)

local tabz = {}
local tabs = {} -- i like tabby catz 🐱🐱🐱

function menu.Initialize(menutable)
    local bbmenu = {} -- this one is for the rendering n shi
    do
        Draw:MenuOutlinedRect(true, 0, 0, menu.w, menu.h, { 0, 0, 0, 255 }, bbmenu) -- first gradent or whatever
        Draw:MenuOutlinedRect(true, 1, 1, menu.w - 2, menu.h - 2, { 20, 20, 20, 255 }, bbmenu)
        Draw:MenuOutlinedRect(true, 2, 2, menu.w - 3, 1, { 127, 72, 163, 255 }, bbmenu)
        table.insert(menu.clrs.norm, bbmenu[#bbmenu])
        Draw:MenuOutlinedRect(true, 2, 3, menu.w - 3, 1, { 87, 32, 123, 255 }, bbmenu)
        table.insert(menu.clrs.dark, bbmenu[#bbmenu])
        Draw:MenuOutlinedRect(true, 2, 4, menu.w - 3, 1, { 20, 20, 20, 255 }, bbmenu)

        for i = 0, 19 do
            Draw:MenuFilledRect(true, 2, 5 + i, menu.w - 4, 1, { 20, 20, 20, 255 }, bbmenu)
            bbmenu[6 + i].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 20, color = RGB(35, 35, 35) } }
            )
        end
        Draw:MenuFilledRect(true, 2, 25, menu.w - 4, menu.h - 27, { 35, 35, 35, 255 }, bbmenu)

        Draw:MenuBigText(MenuName or "Bitch Bot", true, false, 6, 6, bbmenu)

        Draw:MenuOutlinedRect(true, 8, 22, menu.w - 16, menu.h - 30, { 0, 0, 0, 255 }, bbmenu) -- all this shit does the 2nd gradent
        Draw:MenuOutlinedRect(true, 9, 23, menu.w - 18, menu.h - 32, { 20, 20, 20, 255 }, bbmenu)
        Draw:MenuOutlinedRect(true, 10, 24, menu.w - 19, 1, { 127, 72, 163, 255 }, bbmenu)
        table.insert(menu.clrs.norm, bbmenu[#bbmenu])
        Draw:MenuOutlinedRect(true, 10, 25, menu.w - 19, 1, { 87, 32, 123, 255 }, bbmenu)
        table.insert(menu.clrs.dark, bbmenu[#bbmenu])
        Draw:MenuOutlinedRect(true, 10, 26, menu.w - 19, 1, { 20, 20, 20, 255 }, bbmenu)

        for i = 0, 14 do
            Draw:MenuFilledRect(true, 10, 27 + (i * 2), menu.w - 20, 2, { 45, 45, 45, 255 }, bbmenu)
            bbmenu[#bbmenu].Color = ColorRange(
                i,
                { [1] = { start = 0, color = RGB(50, 50, 50) }, [2] = { start = 15, color = RGB(35, 35, 35) } }
            )
        end
        Draw:MenuFilledRect(true, 10, 57, menu.w - 20, menu.h - 67, { 35, 35, 35, 255 }, bbmenu)
    end
    -- ok now the cool part :D
    --ANCHOR menu stuffz

    for i = 1, #menutable do
        tabz[i] = {}
    end

    menu.multigroups = {}

    for k, v in pairs(menutable) do
        Draw:MenuFilledRect(
            true,
            10 + ((k - 1) * ((menu.w - 20) / #menutable)),
            27,
            ((menu.w - 20) / #menutable),
            32,
            { 30, 30, 30, 255 },
            bbmenu
        )
        Draw:MenuOutlinedRect(
            true,
            10 + ((k - 1) * ((menu.w - 20) / #menutable)),
            27,
            ((menu.w - 20) / #menutable),
            32,
            { 20, 20, 20, 255 },
            bbmenu
        )
        Draw:MenuBigText(
            v.name,
            true,
            true,
            math.floor(10 + ((k - 1) * ((menu.w - 20) / #menutable)) + (((menu.w - 20) / #menutable) * 0.5)),
            35,
            bbmenu
        )
        table.insert(tabs, { bbmenu[#bbmenu - 2], bbmenu[#bbmenu - 1], bbmenu[#bbmenu] })
        table.insert(menu.tabnames, v.name)

        menu.options[v.name] = {}
        menu.multigroups[v.name] = {}
        menu.mgrouptabz[v.name] = {}

        local y_offies = { left = 66, right = 66 }
        if v.content ~= nil then
            for k1, v1 in pairs(v.content) do
                if v1.autopos ~= nil then
                    v1.width = menu.columns.width
                    if v1.autopos == "left" then
                        v1.x = menu.columns.left
                        v1.y = y_offies.left
                    elseif v1.autopos == "right" then
                        v1.x = menu.columns.right
                        v1.y = y_offies.right
                    end
                end

                local groups = {}

                if type(v1.name) == "table" then
                    groups = v1.name
                else
                    table.insert(groups, v1.name)
                end

                local y_pos = 24

                for g_ind, g_name in ipairs(groups) do
                    menu.options[v.name][g_name] = {}
                    if type(v1.name) == "table" then
                        menu.mgrouptabz[v.name][g_name] = {}
                        menu.log_multi = { v.name, g_name }
                    end

                    local content = nil
                    if type(v1.name) == "table" then
                        y_pos = 28
                        content = v1[g_ind].content
                    else
                        y_pos = 24
                        content = v1.content
                    end


                    if content ~= nil then
                        for k2, v2 in pairs(content) do
                            if v2.type == TOGGLE then
                                menu.options[v.name][g_name][v2.name] = {}
                                local unsafe = false
                                if v2.unsafe then
                                    unsafe = true
                                end
                                menu.options[v.name][g_name][v2.name][4] = Draw:Toggle(v2.name, v2.value, unsafe, v1.x + 8, v1.y + y_pos, tabz[k])
                                menu.options[v.name][g_name][v2.name][1] = v2.value
                                menu.options[v.name][g_name][v2.name][7] = v2.value
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1 }
                                menu.options[v.name][g_name][v2.name][6] = unsafe
                                menu.options[v.name][g_name][v2.name].tooltip = v2.tooltip or nil
                                if v2.extra ~= nil then
                                    if v2.extra.type == KEYBIND then
                                        menu.options[v.name][g_name][v2.name][5] = {}
                                        menu.options[v.name][g_name][v2.name][5][4] = Draw:Keybind(
                                            v2.extra.key,
                                            v1.x + v1.width - 52,
                                            y_pos + v1.y - 2,
                                            tabz[k]
                                        )
                                        menu.options[v.name][g_name][v2.name][5][1] = v2.extra.key
                                        menu.options[v.name][g_name][v2.name][5][2] = v2.extra.type
                                        menu.options[v.name][g_name][v2.name][5][3] = { v1.x + v1.width - 52, y_pos + v1.y - 2 }
                                        menu.options[v.name][g_name][v2.name][5][5] = false
                                        menu.options[v.name][g_name][v2.name][5].toggletype = v2.extra.toggletype == nil and 1 or v2.extra.toggletype
                                        menu.options[v.name][g_name][v2.name][5].relvalue = false
                                        local event = event.new(("%s %s %s"):format(v.name, g_name, v2.name))
                                        event:connect(function(newval)
                                            if menu:GetVal("Visuals", "Keybinds" ,"Log Keybinds") then
                                                CreateNotification(("%s %s %s has been set to %s"):format(v.name, g_name, v2.name, newval and "true" or "false"))
                                            end
                                        end)
                                        menu.options[v.name][g_name][v2.name][5].event = event
                                        menu.options[v.name][g_name][v2.name][5].bind = table.insert(menu.keybinds, {
                                                menu.options[v.name][g_name][v2.name],
                                                tostring(v2.name),
                                                tostring(g_name),
                                                tostring(v.name),
                                            })
                                    elseif v2.extra.type == COLORPICKER then
                                        menu.options[v.name][g_name][v2.name][5] = {}
                                        menu.options[v.name][g_name][v2.name][5][4] = Draw:ColorPicker(
                                            v2.extra.color,
                                            v1.x + v1.width - 38,
                                            y_pos + v1.y - 1,
                                            tabz[k]
                                        )
                                        menu.options[v.name][g_name][v2.name][5][1] = v2.extra.color
                                        menu.options[v.name][g_name][v2.name][5][2] = v2.extra.type
                                        menu.options[v.name][g_name][v2.name][5][3] = { v1.x + v1.width - 38, y_pos + v1.y - 1 }
                                        menu.options[v.name][g_name][v2.name][5][5] = false
                                        menu.options[v.name][g_name][v2.name][5][6] = v2.extra.name
                                    elseif v2.extra.type == DOUBLE_COLORPICKER then
                                        menu.options[v.name][g_name][v2.name][5] = {}
                                        menu.options[v.name][g_name][v2.name][5][1] = {}
                                        menu.options[v.name][g_name][v2.name][5][1][1] = {}
                                        menu.options[v.name][g_name][v2.name][5][1][2] = {}
                                        menu.options[v.name][g_name][v2.name][5][2] = v2.extra.type
                                        for i = 1, 2 do
                                            menu.options[v.name][g_name][v2.name][5][1][i][4] = Draw:ColorPicker(
                                                v2.extra.color[i],
                                                v1.x + v1.width - 38 - ((i - 1) * 34),
                                                y_pos + v1.y - 1,
                                                tabz[k]
                                            )
                                            menu.options[v.name][g_name][v2.name][5][1][i][1] = v2.extra.color[i]
                                            menu.options[v.name][g_name][v2.name][5][1][i][3] = { v1.x + v1.width - 38 - ((i - 1) * 34), y_pos + v1.y - 1 }
                                            menu.options[v.name][g_name][v2.name][5][1][i][5] = false
                                            menu.options[v.name][g_name][v2.name][5][1][i][6] = v2.extra.name[i]
                                        end
                                    end
                                end
                                y_pos += 18
                            elseif v2.type == SLIDER then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][4] = Draw:Slider(
                                    v2.name,
                                    v2.stradd,
                                    v2.value,
                                    v2.minvalue,
                                    v2.maxvalue,
                                    v2.custom or {},
                                    v2.decimal,
                                    v1.x + 8,
                                    v1.y + y_pos,
                                    v1.width - 16,
                                    tabz[k]
                                )
                                menu.options[v.name][g_name][v2.name][1] = v2.value
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1, v1.width - 16 }
                                menu.options[v.name][g_name][v2.name][5] = false
                                menu.options[v.name][g_name][v2.name][6] = { v2.minvalue, v2.maxvalue }
                                menu.options[v.name][g_name][v2.name][7] = { v1.x + 7 + v1.width - 38, v1.y + y_pos - 1 }
                                menu.options[v.name][g_name][v2.name].decimal = v2.decimal == nil and nil or v2.decimal
                                menu.options[v.name][g_name][v2.name].stepsize = v2.stepsize
                                menu.options[v.name][g_name][v2.name].shift_stepsize = v2.shift_stepsize
                                menu.options[v.name][g_name][v2.name].custom = v2.custom or {}

                                y_pos += 30
                            elseif v2.type == DROPBOX then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][1] = v2.value
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][5] = false
                                menu.options[v.name][g_name][v2.name][6] = v2.values

                                if v2.x == nil then
                                    menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1, v1.width - 16 }
                                    menu.options[v.name][g_name][v2.name][4] = Draw:Dropbox(
                                        v2.name,
                                        v2.value,
                                        v2.values,
                                        v1.x + 8,
                                        v1.y + y_pos,
                                        v1.width - 16,
                                        tabz[k]
                                    )
                                    y_pos += 40
                                else
                                    menu.options[v.name][g_name][v2.name][3] = { v2.x + 7, v2.y - 1, v2.w }
                                    menu.options[v.name][g_name][v2.name][4] = Draw:Dropbox(v2.name, v2.value, v2.values, v2.x + 8, v2.y, v2.w, tabz[k])
                                end
                            elseif v2.type == COMBOBOX then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][4] = Draw:Combobox(
                                        v2.name,
                                        v2.values,
                                        v1.x + 8,
                                        v1.y + y_pos,
                                        v1.width - 16,
                                        tabz[k]
                                    )
                                menu.options[v.name][g_name][v2.name][1] = v2.values
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1, v1.width - 16 }
                                menu.options[v.name][g_name][v2.name][5] = false
                                y_pos += 40
                            elseif v2.type == BUTTON then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][1] = false
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name].name = v2.name
                                menu.options[v.name][g_name][v2.name].groupbox = g_name
                                menu.options[v.name][g_name][v2.name].tab = v.name -- why is it all v, v1, v2 so ugly
                                menu.options[v.name][g_name][v2.name].doubleclick = v2.doubleclick

                                if v2.x == nil then
                                    menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1, v1.width - 16 }
                                    menu.options[v.name][g_name][v2.name][4] = Draw:Button(v2.name, v1.x + 8, v1.y + y_pos, v1.width - 16, tabz[k])
                                    y_pos += 28
                                else
                                    menu.options[v.name][g_name][v2.name][3] = { v2.x + 7, v2.y - 1, v2.w }
                                    menu.options[v.name][g_name][v2.name][4] = Draw:Button(v2.name, v2.x + 8, v2.y, v2.w, tabz[k])
                                end
                            elseif v2.type == TEXTBOX then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][4] = Draw:TextBox(v2.name, v2.text, v1.x + 8, v1.y + y_pos, v1.width - 16, tabz[k])
                                menu.options[v.name][g_name][v2.name][1] = v2.text
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][3] = { v1.x + 7, v1.y + y_pos - 1, v1.width - 16 }
                                menu.options[v.name][g_name][v2.name][5] = false
                                menu.options[v.name][g_name][v2.name][6] = v2.file and true or false
                                y_pos += 28
                            elseif v2.type == "list" then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][4] = Draw:List(
                                    v2.multiname,
                                    v1.x + 8,
                                    v1.y + y_pos,
                                    v1.width - 16,
                                    v2.size,
                                    v2.columns,
                                    tabz[k]
                                )
                                menu.options[v.name][g_name][v2.name][1] = nil
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                                menu.options[v.name][g_name][v2.name][3] = 1
                                menu.options[v.name][g_name][v2.name][5] = {}
                                menu.options[v.name][g_name][v2.name][6] = v2.size
                                menu.options[v.name][g_name][v2.name][7] = v2.columns
                                menu.options[v.name][g_name][v2.name][8] = { v1.x + 8, v1.y + y_pos, v1.width - 16 }
                                y_pos += 22 + (22 * v2.size)
                            elseif v2.type == IMAGE then
                                menu.options[v.name][g_name][v2.name] = {}
                                menu.options[v.name][g_name][v2.name][1] = Draw:ImageWithText(v2.size, nil, v2.text, v1.x + 8, v1.y + y_pos, tabz[k])
                                menu.options[v.name][g_name][v2.name][2] = v2.type
                            end
                        end
                    end

                    menu.log_multi = nil
                end

                y_pos += 2

                if type(v1.name) ~= "table" then
                    if v1.autopos == nil then
                        Draw:CoolBox(v1.name, v1.x, v1.y, v1.width, v1.height, tabz[k])
                    else
                        if v1.autofill then
                            y_pos = (menu.h - 17) - v1.y
                        elseif v1.size ~= nil then
                            y_pos = v1.size
                        end
                        Draw:CoolBox(v1.name, v1.x, v1.y, v1.width, y_pos, tabz[k])
                        y_offies[v1.autopos] += y_pos + 6
                    end
                else
                    if v1.autofill then
                        y_pos = (menu.h - 17) - v1.y
                        y_offies[v1.autopos] += y_pos + 6
                    elseif v1.size ~= nil then
                        y_pos = v1.size
                        y_offies[v1.autopos] += y_pos + 6
                    end

                    local drawn

                    if v1.autopos == nil then
                        drawn = Draw:CoolMultiBox(v1.name, v1.x, v1.y, v1.width, v1.height, tabz[k])
                    else
                        drawn = Draw:CoolMultiBox(v1.name, v1.x, v1.y, v1.width, y_pos, tabz[k])
                    end

                    local group_vals = {}

                    for _i, _v in ipairs(v1.name) do
                        if _i == 1 then
                            group_vals[_v] = true
                        else
                            group_vals[_v] = false
                        end
                    end
                    table.insert(menu.multigroups[v.name], { vals = group_vals, drawn = drawn })
                end
            end
        end
    end

    menu.list.addval = function(list, option)
        table.insert(list[5], option)
    end

    menu.list.removeval = function(list, optionnum)
        if list[1] == optionnum then
            list[1] = nil
        end
        table.remove(list[5], optionnum)
    end

    menu.list.removeall = function(list)
        list[5] = {}
        for k, v in pairs(list[4].liststuff) do
            for i, v1 in ipairs(v) do
                for i1, v2 in ipairs(v1) do
                    v2.Visible = false
                end
            end
        end
    end

    menu.list.setval = function(list, value)
        list[1] = value
    end

    Draw:MenuOutlinedRect(true, 10, 59, menu.w - 20, menu.h - 69, { 20, 20, 20, 255 }, bbmenu)

    Draw:MenuOutlinedRect(true, 11, 58, ((menu.w - 20) / #menutable) - 2, 2, { 35, 35, 35, 255 }, bbmenu)
    local barguy = { bbmenu[#bbmenu], menu.postable[#menu.postable] }

    local function setActiveTab(slot)
        barguy[1].Position = Vector2.new(
            (menu.x + 11 + ((((menu.w - 20) / #menutable) - 2) * (slot - 1))) + ((slot - 1) * 2),
            menu.y + 58
        )
        barguy[2][2] = (11 + ((((menu.w - 20) / #menutable) - 2) * (slot - 1))) + ((slot - 1) * 2)
        barguy[2][3] = 58

        for k, v in pairs(tabs) do
            if k == slot then
                v[1].Visible = false
                v[3].Color = RGB(255, 255, 255)
            else
                v[3].Color = RGB(170, 170, 170)
                v[1].Visible = true
            end
        end

        for k, v in pairs(tabz) do
            if k == slot then
                for k1, v1 in pairs(v) do
                    v1.Visible = true
                end
            else
                for k1, v1 in pairs(v) do
                    v1.Visible = false
                end
            end
        end

        for k, v in pairs(menu.multigroups) do
            if menu.tabnames[menu.activetab] == k then
                for k1, v1 in pairs(v) do
                    for k2, v2 in pairs(v1.vals) do
                        for k3, v3 in pairs(menu.mgrouptabz[k][k2]) do
                            v3.Visible = v2
                        end
                    end
                end
            end
        end
    end

    setActiveTab(menu.activetab)

    local plusminus = {}

    Draw:OutlinedText("_", 1, false, 10, 10, 14, false, { 225, 225, 225, 255 }, { 20, 20, 20 }, plusminus)
    Draw:OutlinedText("+", 1, false, 10, 10, 14, false, { 225, 225, 225, 255 }, { 20, 20, 20 }, plusminus)

    function menu:SetPlusMinus(value, x, y)
        for i, v in ipairs(plusminus) do
            if value == 0 then
                v.Visible = false
            else
                v.Visible = true
            end
        end

        if value ~= 0 then
            plusminus[1].Position = Vector2.new(x + 3 + menu.x, y - 5 + menu.y)
            plusminus[2].Position = Vector2.new(x + 13 + menu.x, y - 1 + menu.y)

            if value == 1 then
                for i, v in ipairs(plusminus) do
                    v.Color = RGB(225, 225, 225)
                    v.OutlineColor = RGB(20, 20, 20)
                end
            else
                for i, v in ipairs(plusminus) do
                    if i + 1 == value then
                        v.Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                    else
                        v.Color = RGB(255, 255, 255)
                    end
                    v.OutlineColor = RGB(0, 0, 0)
                end
            end
        end
    end

    menu:SetPlusMinus(0, 20, 20)

    --DROP BOX THINGY
    local dropboxthingy = {}
    local dropboxtexty = {}

    Draw:OutlinedRect(false, 20, 20, 100, 22, { 20, 20, 20, 255 }, dropboxthingy)
    Draw:OutlinedRect(false, 21, 21, 98, 20, { 0, 0, 0, 255 }, dropboxthingy)
    Draw:FilledRect(false, 22, 22, 96, 18, { 45, 45, 45, 255 }, dropboxthingy)

    for i = 1, 30 do
        Draw:OutlinedText("", 2, false, 20, 20, 13, false, { 255, 255, 255, 255 }, { 0, 0, 0 }, dropboxtexty)
    end

    function menu:SetDropBox(visible, x, y, length, value, values)
        for k, v in pairs(dropboxthingy) do
            v.Visible = visible
        end

        local size = Vector2.new(length, 21 * (#values + 1) + 3)
        -- if y + size.y > SCREEN_SIZE.y then
        --     y = SCREEN_SIZE.y - size.y
        -- end
        -- if x + size.x > SCREEN_SIZE.x then
        --     x = SCREEN_SIZE.x - size.x
        -- end
        -- if y < 0 then
        --     y = 0
        -- end
        -- if x < 0 then
        --     x = 0
        -- end

        local pos = Vector2.new(x, y)
        dropboxthingy[1].Position = pos
        dropboxthingy[2].Position = Vector2.new(x + 1, y + 1)
        dropboxthingy[3].Position = Vector2.new(x + 2, y + 22)

        dropboxthingy[1].Size = size
        dropboxthingy[2].Size = Vector2.new(length - 2, (21 * (#values + 1)) + 1)
        dropboxthingy[3].Size = Vector2.new(length - 4, (21 * #values) + 1 - 1)


       
        if visible then
            for i = 1, #values do
                dropboxtexty[i].Position = Vector2.new(x + 6, y + 26 + ((i - 1) * 21))
                dropboxtexty[i].Visible = true
                dropboxtexty[i].Text = values[i]
                if i == value then
                    dropboxtexty[i].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                else
                    dropboxtexty[i].Color = RGB(255, 255, 255)
                end
            end
        else
            for k, v in pairs(dropboxtexty) do
                v.Visible = false
            end
        end
        return pos
    end

    local function set_comboboxthingy(visible, x, y, length, values)
        for k, v in pairs(dropboxthingy) do
            v.Visible = visible
        end
        local size = Vector2.new(length, 22 * (#values + 1) + 2)

        if y + size.y > SCREEN_SIZE.y then
            y = SCREEN_SIZE.y - size.y
        end
        if x + size.x > SCREEN_SIZE.x then
            x = SCREEN_SIZE.x - size.x
        end
        if y < 0 then
            y = 0
        end
        if x < 0 then
            x = 0
        end
        local pos = Vector2.new(x,y)
        dropboxthingy[1].Position = pos
        dropboxthingy[2].Position = Vector2.new(x + 1, y + 1)
        dropboxthingy[3].Position = Vector2.new(x + 2, y + 22)

        dropboxthingy[1].Size = size
        dropboxthingy[2].Size = Vector2.new(length - 2, (22 * (#values + 1)))
        dropboxthingy[3].Size = Vector2.new(length - 4, (22 * #values))

        if visible then
            for i = 1, #values do
                dropboxtexty[i].Position = Vector2.new(x + 6, y + 26 + ((i - 1) * 22))
                dropboxtexty[i].Visible = true
                dropboxtexty[i].Text = values[i][1]
                if values[i][2] then
                    dropboxtexty[i].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                else
                    dropboxtexty[i].Color = RGB(255, 255, 255)
                end
            end
        else
            for k, v in pairs(dropboxtexty) do
                v.Visible = false
            end
        end
        return pos
    end

    menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })

    --MODE SELECT THING
    local modeselect = {}

    Draw:OutlinedRect(false, 20, 20, 100, 22, { 20, 20, 20, 255 }, modeselect)
    Draw:OutlinedRect(false, 21, 21, 98, 20, { 0, 0, 0, 255 }, modeselect)
    Draw:FilledRect(false, 22, 22, 96, 18, { 45, 45, 45, 255 }, modeselect)

    local modeselecttext = { "Hold", "Toggle", "Hold Off", "Always" }
    for i = 1, 4 do
        Draw:OutlinedText(
            modeselecttext[i],
            2,
            false,
            20,
            20,
            13,
            false,
            { 255, 255, 255, 255 },
            { 0, 0, 0 },
            modeselect
        )
    end

    function menu:SetKeybindSelect(visible, x, y, value)
        for k, v in pairs(modeselect) do
            v.Visible = visible
        end

        if visible then
            modeselect[1].Position = Vector2.new(x, y)
            modeselect[2].Position = Vector2.new(x + 1, y + 1)
            modeselect[3].Position = Vector2.new(x + 2, y + 2)

            modeselect[1].Size = Vector2.new(70, 22 * 4 - 1)
            modeselect[2].Size = Vector2.new(70 - 2, 22 * 4 - 3)
            modeselect[3].Size = Vector2.new(70 - 4, 22 * 4 - 5)

            for i = 1, 4 do
                modeselect[i + 3].Position = Vector2.new(x + 6, y + 4 + ((i - 1) * 21))
                if value == i then
                    modeselect[i + 3].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                else
                    modeselect[i + 3].Color = RGB(255, 255, 255)
                end
            end
        end
    end

    menu:SetKeybindSelect(false, 200, 400, 1)

    --COLOR PICKER
    local cp = {
        x = 400,
        y = 40,
        w = 280,
        h = 211,
        alpha = false,
        dragging_m = false,
        dragging_r = false,
        dragging_b = false,
        hsv = {
            h = 0,
            s = 0,
            v = 0,
            a = 0,
        },
        postable = {},
        drawings = {},
    }

    local function ColorpickerOutline(visible, pos_x, pos_y, width, height, clr, tablename) -- doing all this shit to make it easier for me to make this beat look nice and shit ya fell dog :dog_head:
        Draw:OutlinedRect(visible, pos_x + cp.x, pos_y + cp.y, width, height, clr, tablename)
        table.insert(cp.postable, { tablename[#tablename], pos_x, pos_y })
    end

    local function ColorpickerRect(visible, pos_x, pos_y, width, height, clr, tablename)
        Draw:FilledRect(visible, pos_x + cp.x, pos_y + cp.y, width, height, clr, tablename)
        table.insert(cp.postable, { tablename[#tablename], pos_x, pos_y })
    end

    local function ColorpickerImage(visible, imagedata, pos_x, pos_y, width, height, transparency, tablename)
        Draw:Image(visible, imagedata, pos_x, pos_y, width, height, transparency, tablename)
        table.insert(cp.postable, { tablename[#tablename], pos_x, pos_y })
    end

    local function ColorpickerText(text, visible, centered, pos_x, pos_y, tablename)
        Draw:OutlinedText(
            text,
            2,
            visible,
            pos_x + cp.x,
            pos_y + cp.y,
            13,
            centered,
            { 255, 255, 255, 255 },
            { 0, 0, 0 },
            tablename
        )
        table.insert(cp.postable, { tablename[#tablename], pos_x, pos_y })
    end

    ColorpickerRect(false, 1, 1, cp.w, cp.h, { 35, 35, 35, 255 }, cp.drawings)
    ColorpickerOutline(false, 1, 1, cp.w, cp.h, { 0, 0, 0, 255 }, cp.drawings)
    ColorpickerOutline(false, 2, 2, cp.w - 2, cp.h - 2, { 20, 20, 20, 255 }, cp.drawings)
    ColorpickerOutline(false, 3, 3, cp.w - 3, 1, { 127, 72, 163, 255 }, cp.drawings)
    table.insert(menu.clrs.norm, cp.drawings[#cp.drawings])
    ColorpickerOutline(false, 3, 4, cp.w - 3, 1, { 87, 32, 123, 255 }, cp.drawings)
    table.insert(menu.clrs.dark, cp.drawings[#cp.drawings])
    ColorpickerOutline(false, 3, 5, cp.w - 3, 1, { 20, 20, 20, 255 }, cp.drawings)
    ColorpickerText("color picker :D", false, false, 7, 6, cp.drawings)

    ColorpickerText("x", false, false, 268, 4, cp.drawings)

    ColorpickerOutline(false, 10, 23, 160, 160, { 30, 30, 30, 255 }, cp.drawings)
    ColorpickerOutline(false, 11, 24, 158, 158, { 0, 0, 0, 255 }, cp.drawings)
    ColorpickerRect(false, 12, 25, 156, 156, { 0, 0, 0, 255 }, cp.drawings)
    local maincolor = cp.drawings[#cp.drawings]
    ColorpickerImage(false, BBOT_IMAGES[1], 12, 25, 156, 156, 1, cp.drawings)

    --https://i.imgur.com/jG3NjxN.png
    local alphabar = {}
    ColorpickerOutline(false, 10, 189, 160, 14, { 30, 30, 30, 255 }, cp.drawings)
    table.insert(alphabar, cp.drawings[#cp.drawings])
    ColorpickerOutline(false, 11, 190, 158, 12, { 0, 0, 0, 255 }, cp.drawings)
    table.insert(alphabar, cp.drawings[#cp.drawings])
    ColorpickerImage(false, BBOT_IMAGES[2], 12, 191, 159, 10, 1, cp.drawings)
    table.insert(alphabar, cp.drawings[#cp.drawings])

    ColorpickerOutline(false, 176, 23, 14, 160, { 30, 30, 30, 255 }, cp.drawings)
    ColorpickerOutline(false, 177, 24, 12, 158, { 0, 0, 0, 255 }, cp.drawings)
    --https://i.imgur.com/2Ty4u2O.png
    ColorpickerImage(false, BBOT_IMAGES[3], 178, 25, 10, 156, 1, cp.drawings)

    ColorpickerText("New Color", false, false, 198, 23, cp.drawings)
    ColorpickerOutline(false, 197, 37, 75, 40, { 30, 30, 30, 255 }, cp.drawings)
    ColorpickerOutline(false, 198, 38, 73, 38, { 0, 0, 0, 255 }, cp.drawings)
    ColorpickerImage(false, BBOT_IMAGES[4], 199, 39, 71, 36, 1, cp.drawings)

    ColorpickerRect(false, 199, 39, 71, 36, { 255, 0, 0, 255 }, cp.drawings)
    local newcolor = cp.drawings[#cp.drawings]

    ColorpickerText("copy", false, true, 198 + 36, 41, cp.drawings)
    ColorpickerText("paste", false, true, 198 + 37, 56, cp.drawings)
    local newcopy = { cp.drawings[#cp.drawings - 1], cp.drawings[#cp.drawings] }

    ColorpickerText("Old Color", false, false, 198, 77, cp.drawings)
    ColorpickerOutline(false, 197, 91, 75, 40, { 30, 30, 30, 255 }, cp.drawings)
    ColorpickerOutline(false, 198, 92, 73, 38, { 0, 0, 0, 255 }, cp.drawings)
    ColorpickerImage(false, BBOT_IMAGES[4], 199, 93, 71, 36, 1, cp.drawings)

    ColorpickerRect(false, 199, 93, 71, 36, { 255, 0, 0, 255 }, cp.drawings)
    local oldcolor = cp.drawings[#cp.drawings]

    ColorpickerText("copy", false, true, 198 + 36, 103, cp.drawings)
    local oldcopy = { cp.drawings[#cp.drawings] }

    --ColorpickerRect(false, 197, cp.h - 25, 75, 20, {30, 30, 30, 255}, cp.drawings)
    ColorpickerText("[ Apply ]", false, true, 235, cp.h - 23, cp.drawings)
    local applytext = cp.drawings[#cp.drawings]

    local function set_newcolor(r, g, b, a)
        newcolor.Color = RGB(r, g, b)
        if a ~= nil then
            newcolor.Transparency = a / 255
        else
            newcolor.Transparency = 1
        end
    end

    local function set_oldcolor(r, g, b, a)
        oldcolor.Color = RGB(r, g, b)
        cp.oldcolor = oldcolor.Color
        cp.oldcoloralpha = a
        if a ~= nil then
            oldcolor.Transparency = a / 255
        else
            oldcolor.Transparency = 1
        end
    end
    -- all this color picker shit is disgusting, why can't it be in it's own fucking scope. these are all global
    local dragbar_r = {}
    Draw:OutlinedRect(true, 30, 30, 16, 5, { 0, 0, 0, 255 }, cp.drawings)
    table.insert(dragbar_r, cp.drawings[#cp.drawings])
    Draw:OutlinedRect(true, 31, 31, 14, 3, { 255, 255, 255, 255 }, cp.drawings)
    table.insert(dragbar_r, cp.drawings[#cp.drawings])

    local dragbar_b = {}
    Draw:OutlinedRect(true, 30, 30, 5, 16, { 0, 0, 0, 255 }, cp.drawings)
    table.insert(dragbar_b, cp.drawings[#cp.drawings])
    table.insert(alphabar, cp.drawings[#cp.drawings])
    Draw:OutlinedRect(true, 31, 31, 3, 14, { 255, 255, 255, 255 }, cp.drawings)
    table.insert(dragbar_b, cp.drawings[#cp.drawings])
    table.insert(alphabar, cp.drawings[#cp.drawings])

    local dragbar_m = {}
    Draw:OutlinedRect(true, 30, 30, 5, 5, { 0, 0, 0, 255 }, cp.drawings)
    table.insert(dragbar_m, cp.drawings[#cp.drawings])
    Draw:OutlinedRect(true, 31, 31, 3, 3, { 255, 255, 255, 255 }, cp.drawings)
    table.insert(dragbar_m, cp.drawings[#cp.drawings])

    function menu:SetDragBarR(x, y)
        dragbar_r[1].Position = Vector2.new(x, y)
        dragbar_r[2].Position = Vector2.new(x + 1, y + 1)
    end

    function menu:SetDragBarB(x, y)
        dragbar_b[1].Position = Vector2.new(x, y)
        dragbar_b[2].Position = Vector2.new(x + 1, y + 1)
    end

    function menu:SetDragBarM(x, y)
        dragbar_m[1].Position = Vector2.new(x, y)
        dragbar_m[2].Position = Vector2.new(x + 1, y + 1)
    end

    function menu:SetColorPicker(visible, color, value, alpha, text, x, y)
        for k, v in pairs(cp.drawings) do
            v.Visible = visible
        end
        cp.oldalpha = alpha
        if visible then
            cp.x = clamp(x, 0, SCREEN_SIZE.x - cp.w)
            cp.y = clamp(y, 0, SCREEN_SIZE.y - cp.h)
            for k, v in pairs(cp.postable) do
                v[1].Position = Vector2.new(cp.x + v[2], cp.y + v[3])
            end

            local tempclr = RGB(color[1], color[2], color[3])
            local h, s, v = tempclr:ToHSV()
            cp.hsv.h = h
            cp.hsv.s = s
            cp.hsv.v = v

            menu:SetDragBarR(cp.x + 175, cp.y + 23 + math.floor((1 - h) * 156))
            menu:SetDragBarM(cp.x + 9 + math.floor(s * 156), cp.y + 23 + math.floor((1 - v) * 156))
            if not alpha then
                set_newcolor(color[1], color[2], color[3])
                set_oldcolor(color[1], color[2], color[3])
                cp.alpha = false
                for k, v in pairs(alphabar) do
                    v.Visible = false
                end
                cp.h = 191
                for i = 1, 2 do
                    cp.drawings[i].Size = Vector2.new(cp.w, cp.h)
                end
                cp.drawings[3].Size = Vector2.new(cp.w - 2, cp.h - 2)
            else
                cp.hsv.a = color[4]
                cp.alpha = true
                set_newcolor(color[1], color[2], color[3], color[4])
                set_oldcolor(color[1], color[2], color[3], color[4])
                cp.h = 211
                for i = 1, 2 do
                    cp.drawings[i].Size = Vector2.new(cp.w, cp.h)
                end
                cp.drawings[3].Size = Vector2.new(cp.w - 2, cp.h - 2)
                menu:SetDragBarB(cp.x + 12 + math.floor(156 * (color[4] / 255)), cp.y + 188)
            end

            applytext.Position = Vector2.new(235 + cp.x, cp.y + cp.h - 23)
            maincolor.Color = Color3.fromHSV(h, 1, 1)
            cp.drawings[7].Text = text
        end
    end

    menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "", 0, 0)

    --TOOL TIP
    local tooltip = {
        x = 0,
        y = 0,
        time = 0,
        active = false,
        text = "This does this and that i guess\npooping 24/7",
        drawings = {},
        postable = {},
    }

    local function ttOutline(visible, pos_x, pos_y, width, height, clr, tablename)
        Draw:OutlinedRect(visible, pos_x + tooltip.x, pos_y + tooltip.y, width, height, clr, tablename)
        table.insert(tooltip.postable, { tablename[#tablename], pos_x, pos_y })
    end

    local function ttRect(visible, pos_x, pos_y, width, height, clr, tablename)
        Draw:FilledRect(visible, pos_x + tooltip.x, pos_y + tooltip.y, width, height, clr, tablename)
        table.insert(tooltip.postable, { tablename[#tablename], pos_x, pos_y })
    end

    local function ttText(text, visible, centered, pos_x, pos_y, tablename)
        Draw:OutlinedText(
            text,
            2,
            visible,
            pos_x + tooltip.x,
            pos_y + tooltip.y,
            13,
            centered,
            { 255, 255, 255, 255 },
            { 0, 0, 0 },
            tablename
        )
        table.insert(tooltip.postable, { tablename[#tablename], pos_x, pos_y })
    end

    ttRect(
        false,
        tooltip.x + 1,
        tooltip.y + 1,
        1,
        28,
        { menu.mc[1], menu.mc[2], menu.mc[3], 255 },
        tooltip.drawings
    )
    ttRect(
        false,
        tooltip.x + 2,
        tooltip.y + 1,
        1,
        28,
        { menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40, 255 },
        tooltip.drawings
    )
    ttOutline(false, tooltip.x, tooltip.y, 4, 30, { 20, 20, 20, 255 }, tooltip.drawings)
    ttRect(false, tooltip.x + 4, tooltip.y, 100, 30, { 40, 40, 40, 255 }, tooltip.drawings)
    ttOutline(false, tooltip.x - 1, tooltip.y - 1, 102, 32, { 0, 0, 0, 255 }, tooltip.drawings)
    ttOutline(false, tooltip.x + 3, tooltip.y, 102, 30, { 20, 20, 20, 255 }, tooltip.drawings)
    ttText(tooltip.text, false, false, tooltip.x + 7, tooltip.y + 1, tooltip.drawings)

    local bbmouse = {}
    function menu:SetToolTip(x, y, text, visible, dt)
        dt = dt or 0
        x = x or tooltip.x
        y = y or tooltip.y
        tooltip.x = x
        tooltip.y = y
        if tooltip.time < 1 and visible then
            if tooltip.time < -1 then
                tooltip.time = -1
            end
            tooltip.time += dt
        else
            tooltip.time -= dt
            if tooltip.time < -1 then
                tooltip.time = -1
            end
        end
        if not visible and tooltip.time < 0 then
            tooltip.time = -1
        end
        if tooltip.time > 1 then
            tooltip.time = 1
        end
        for k, v in ipairs(tooltip.drawings) do
            v.Visible = tooltip.time > 0
        end

        tooltip.active = visible
        if text then
            tooltip.drawings[7].Text = text
        end
        for k, v in pairs(tooltip.postable) do
            v[1].Position = Vector2.new(x + v[2], y + v[3])
            v[1].Transparency = math.min((0.3 + tooltip.time) ^ 3 - 1, menu.fade_amount or 1)
        end
        tooltip.drawings[1].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
        tooltip.drawings[2].Color = RGB(menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40)

        local tb = tooltip.drawings[7].TextBounds

        tooltip.drawings[1].Size = Vector2.new(1, tb.Y + 3)
        tooltip.drawings[2].Size = Vector2.new(1, tb.Y + 3)
        tooltip.drawings[3].Size = Vector2.new(4, tb.Y + 5)
        tooltip.drawings[4].Size = Vector2.new(tb.X + 6, tb.Y + 5)
        tooltip.drawings[5].Size = Vector2.new(tb.X + 12, tb.Y + 7)
        tooltip.drawings[6].Size = Vector2.new(tb.X + 7, tb.Y + 5)
        if bbmouse[#bbmouse] then
            bbmouse[#bbmouse].Visible = visible
            bbmouse[#bbmouse].Transparency = 1 - tooltip.time
        end
    end

    menu:SetToolTip(500, 500, "", false)

    -- mouse shiz
    local mousie = {
        x = 100,
        y = 240,
    }
    Draw:Triangle(
        true,
        true,
        { mousie.x, mousie.y },
        { mousie.x, mousie.y + 15 },
        { mousie.x + 10, mousie.y + 10 },
        { 127, 72, 163, 255 },
        bbmouse
    )
    table.insert(menu.clrs.norm, bbmouse[#bbmouse])
    Draw:Triangle(
        true,
        false,
        { mousie.x, mousie.y },
        { mousie.x, mousie.y + 15 },
        { mousie.x + 10, mousie.y + 10 },
        { 0, 0, 0, 255 },
        bbmouse
    )
    Draw:OutlinedText("", 2, false, 0, 0, 13, false, { 255, 255, 255, 255 }, { 15, 15, 15 }, bbmouse)
    Draw:OutlinedText("?", 2, false, 0, 0, 13, false, { 255, 255, 255, 255 }, { 15, 15, 15 }, bbmouse)

    local lastMousePos = Vector2.new()
    function menu:SetMousePosition(x, y)
        FireEvent("bb_mousemoved", lastMousePos ~= Vector2.new(x, y))
        for k = 1, #bbmouse do
            local v = bbmouse[k]
            if k ~= #bbmouse and k ~= #bbmouse - 1 then
                v.PointA = Vector2.new(x, y + 36)
                v.PointB = Vector2.new(x, y + 36 + 15)
                v.PointC = Vector2.new(x + 10, y + 46)
            else
                v.Position = Vector2.new(x + 10, y + 46)
            end
        end
        lastMousePos = Vector2.new(x, y)
    end

    function menu:SetColor(r, g, b)
        menu.watermark.rect[1].Color = RGB(r - 40, g - 40, b - 40)
        menu.watermark.rect[2].Color = RGB(r, g, b)

        for k, v in pairs(menu.clrs.norm) do
            v.Color = RGB(r, g, b)
        end
        for k, v in pairs(menu.clrs.dark) do
            v.Color = RGB(r - 40, g - 40, b - 40)
        end
        local menucolor = { r, g, b }
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == TOGGLE then
                        if not v2[1] then
                            for i = 0, 3 do
                                v2[4][i + 1].Color = ColorRange(i, {
                                    [1] = { start = 0, color = RGB(50, 50, 50) },
                                    [2] = { start = 3, color = RGB(30, 30, 30) },
                                })
                            end
                        else
                            for i = 0, 3 do
                                v2[4][i + 1].Color = ColorRange(i, {
                                    [1] = { start = 0, color = RGB(menucolor[1], menucolor[2], menucolor[3]) },
                                    [2] = {
                                        start = 3,
                                        color = RGB(menucolor[1] - 40, menucolor[2] - 40, menucolor[3] - 40),
                                    },
                                })
                            end
                        end
                    elseif v2[2] == SLIDER then
                        for i = 0, 3 do
                            v2[4][i + 1].Color = ColorRange(i, {
                                [1] = { start = 0, color = RGB(menucolor[1], menucolor[2], menucolor[3]) },
                                [2] = {
                                    start = 3,
                                    color = RGB(menucolor[1] - 40, menucolor[2] - 40, menucolor[3] - 40),
                                },
                            })
                        end
                    end
                end
            end
        end
    end

    local function UpdateConfigs()
        local configthing = menu.options["Settings"]["Configuration"]["Configs"]

        configthing[6] = GetConfigs()
        if configthing[1] > #configthing[6] then
            configthing[1] = #configthing[6]
        end
        configthing[4][1].Text = configthing[6][configthing[1]]
    end

    menu.keybind_open = nil

    menu.dropbox_open = nil

    menu.colorPickerOpen = false

    menu.textboxopen = nil

    local shooties = {}
    local isPlayerScoped = false

    function menu:InputBeganMenu(key) --ANCHOR menu input
        if key.KeyCode == Enum.KeyCode.Delete and not loadingthing.Visible then
            cp.dragging_m = false
            cp.dragging_r = false
            cp.dragging_b = false

            customChatSpam = {}
            customKillSay = {}
            local customtxt = readfile("bitchbot/chatspam.txt")
            for s in customtxt:gmatch("[^\n]+") do -- I'm Love String:Match
                table.insert(customChatSpam, s)
            end
            customtxt = readfile("bitchbot/killsay.txt")
            for s in customtxt:gmatch("[^\n]+") do -- I'm Love String:Match
                table.insert(customKillSay, s)
            end
            UpdateConfigs()
            if menu.open and not menu.fading then
                for k = 1, #menu.options do
                    local v = menu.options[k]
                    for k1, v1 in pairs(v) do
                        for k2, v2 in pairs(v1) do
                            if v2[2] == SLIDER and v2[5] then
                                v2[5] = false
                            elseif v2[2] == DROPBOX and v2[5] then
                                v2[5] = false
                            elseif v2[2] == COMBOBOX and v2[5] then
                                v2[5] = false
                            elseif v2[2] == TOGGLE then
                                if v2[5] ~= nil then
                                    if v2[5][2] == KEYBIND and v2[5][5] then
                                        v2[5][4][2].Color = RGB(30, 30, 30)
                                        v2[5][5] = false
                                    elseif v2[5][2] == COLORPICKER and v2[5][5] then
                                        v2[5][5] = false
                                    end
                                end
                            elseif v2[2] == BUTTON then
                                if v2[1] then
                                    for i = 0, 8 do
                                        v2[4][i + 1].Color = ColorRange(i, {
                                            [1] = { start = 0, color = RGB(50, 50, 50) },
                                            [2] = { start = 8, color = RGB(35, 35, 35) },
                                        })
                                    end
                                    v2[1] = false
                                end
                            end
                        end
                    end
                end
                menu.keybind_open = nil
                menu:SetKeybindSelect(false, 20, 20, 1)
                menu.dropbox_open = nil
                menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                menu.colorPickerOpen = nil
                menu:SetToolTip(nil, nil, nil, false)
                menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "hahaha", 400, 200)
            end
            if not menu.fading then
                menu.fading = true
                menu.fadestart = tick()
            end
        end

        if menu == nil then
            return
        end

        if menu.textboxopen then
            if key.KeyCode == Enum.KeyCode.Delete or key.KeyCode == Enum.KeyCode.Return then
                for k, v in pairs(menu.options) do
                    for k1, v1 in pairs(v) do
                        for k2, v2 in pairs(v1) do
                            if v2[2] == TEXTBOX then
                                if v2[5] then
                                    v2[5] = false
                                    v2[4].Color = RGB(255, 255, 255)
                                    menu.textboxopen = false
                                    v2[4].Text = v2[1]
                                end
                            end
                        end
                    end
                end
            end
        end

        if menu.open and not menu.fading then
            for k, v in pairs(menu.options) do
                for k1, v1 in pairs(v) do
                    for k2, v2 in pairs(v1) do
                        if v2[2] == TOGGLE then
                            if v2[5] ~= nil then
                                if v2[5][2] == KEYBIND and v2[5][5] and key.KeyCode.Value ~= 0 then
                                    v2[5][4][2].Color = RGB(30, 30, 30)
                                    v2[5][4][1].Text = KeyEnumToName(key.KeyCode)
                                    if KeyEnumToName(key.KeyCode) == "None" then
                                        v2[5][1] = nil
                                    else
                                        v2[5][1] = key.KeyCode
                                    end
                                    v2[5][5] = false
                                end
                            end
                        elseif v2[2] == TEXTBOX then --ANCHOR TEXTBOXES
                            if v2[5] then
                                if not INPUT_SERVICE:IsKeyDown(Enum.KeyCode.LeftControl) then
                                    if string.len(v2[1]) <= 28 then
                                        if table.find(textBoxLetters, KeyEnumToName(key.KeyCode)) then
                                            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.LeftShift) then
                                                v2[1] ..= string.upper(KeyEnumToName(key.KeyCode))
                                            else
                                                v2[1] ..= string.lower(KeyEnumToName(key.KeyCode))
                                            end
                                        elseif KeyEnumToName(key.KeyCode) == "Space" then
                                            v2[1] ..= " "
                                        elseif keymodifiernames[KeyEnumToName(key.KeyCode)] ~= nil then
                                            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.LeftShift) then
                                                v2[1] ..= KeyModifierToName(KeyEnumToName(key.KeyCode), v2[6])
                                            else
                                                v2[1] ..= KeyEnumToName(key.KeyCode)
                                            end
                                        elseif KeyEnumToName(key.KeyCode) == "Back" and v2[1] ~= "" then
                                            v2[1] = string.sub(v2[1], 0, #v2[1] - 1)
                                        end
                                    end
                                    v2[4].Text = v2[1] .. "|"
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    function menu:InputBeganKeybinds(key) -- this is super shit because once we add mouse we need to change all this shit to be the contextaction stuff
        if INPUT_SERVICE:GetFocusedTextBox() or menu.textboxopen then
            return
        end
        for i = 1, #self.keybinds do
            local value = self.keybinds[i][1]
            if key.KeyCode == value[5][1] then
                value[5].lastvalue = value[5].relvalue
                if value[5].toggletype == 2 then
                    value[5].relvalue = not value[5].relvalue
                elseif value[5].toggletype == 1 then
                    value[5].relvalue = true
                elseif value[5].toggletype == 3 then
                    value[5].relvalue = false
                end
            elseif value[5].toggletype == 4 then
                value[5].relvalue = true
            end
            if value[5].lastvalue ~= value[5].relvalue then
                value[5].event:fire(value[5].relvalue)
            end
        end
    end

    function menu:InputEndedKeybinds(key)
        for i = 1, #self.keybinds do
            local value = self.keybinds[i][1]
            value[5].lastvalue = value[5].relvalue
            if key.KeyCode == value[5][1] then
                if value[5].toggletype == 1 then
                    value[5].relvalue = false
                elseif value[5].toggletype == 3 then
                    value[5].relvalue = true
                end
            end
            if value[5].lastvalue ~= value[5].relvalue then
                value[5].event:fire(value[5].relvalue)
            end
        end
    end

    function menu:SetMenuPos(x, y)
        for k, v in pairs(menu.postable) do
            if v[1].Visible then
                v[1].Position = Vector2.new(x + v[2], y + v[3])
            end
        end
    end

    function menu:MouseInArea(x, y, width, height)
        return LOCAL_MOUSE.x > x and LOCAL_MOUSE.x < x + width and LOCAL_MOUSE.y > 36 + y and LOCAL_MOUSE.y < 36 + y + height
    end

    function menu:MouseInMenu(x, y, width, height)
        return LOCAL_MOUSE.x > menu.x + x and LOCAL_MOUSE.x < menu.x + x + width and LOCAL_MOUSE.y > menu.y - 36 + y and LOCAL_MOUSE.y < menu.y - 36 + y + height
    end

    function menu:MouseInColorPicker(x, y, width, height)
        return LOCAL_MOUSE.x > cp.x + x and LOCAL_MOUSE.x < cp.x + x + width and LOCAL_MOUSE.y > cp.y - 36 + y and LOCAL_MOUSE.y < cp.y - 36 + y + height
    end

    local keyz = {}
    for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
        keyz[v.Value] = v
    end


    function menu:GetVal(tab, groupbox, name, ...)
        local args = { ... }

        local option = menu.options[tab][groupbox][name]
        if not option then print(tab, groupbox, name) end
        if args[1] == nil then
            if option[2] == TOGGLE then
                local lastval = option[7]
                option[7] = option[1]
                return option[1], lastval
            elseif option[2] ~= COMBOBOX then
                return option[1]
            else
                local temptable = {}
                for k = 1, #option[1] do
                    local v = option[1][k]
                    table.insert(temptable, v[2])
                end
                return temptable
            end
        else
            if args[1] == KEYBIND or args[1] == COLOR then
                if args[2] then
                    return RGB(option[5][1][1], option[5][1][2], option[5][1][3])
                else
                    return option[5][1]
                end
            elseif args[1] == COLOR1 then
                if args[2] then
                    return RGB(option[5][1][1][1][1], option[5][1][1][1][2], option[5][1][1][1][3])
                else
                    return option[5][1][1][1]
                end
            elseif args[1] == COLOR2 then
                if args[2] then
                    return RGB(option[5][1][2][1][1], option[5][1][2][1][2], option[5][1][2][1][3])
                else
                    return option[5][1][2][1]
                end
            end
        end
    end

    function menu:GetKey(tab, groupbox, name)
        local option = self.options[tab][groupbox][name][5]
        local return1, return2, return3
        if self:GetVal(tab, groupbox, name) then
            if option.toggletype ~= 0 then
                if option.lastvalue == nil then
                    option.lastvalue = option.relvalue
                end
                return1, return2, return3 = option.relvalue, option.lastvalue, option.event
                option.lastvalue = option.relvalue
            end
        end
        return return1, return2, return3
    end

    function menu:SetKey(tab, groupbox, name, val)
        val = val or false
        local option = menu.options[tab][groupbox][name][5]
        if option.toggletype ~= 0 then
            option.lastvalue = option.relvalue
            option.relvalue = val
            if option.lastvalue ~= option.relvalue then
                option.event:fire(option.relvalue)
            end
        end
    end

    local menuElementTypes = { [TOGGLE] = "toggle", [SLIDER] = "slider", [DROPBOX] = "dropbox", [TEXTBOX] = "textbox" }
    local doubleclickDelay = 1
    local buttonsInQue = {}

    local function SaveCurSettings() --ANCHOR figgies
        local figgy = "BitchBot v2\nmade with <3 by nata and bitch\n\n" -- screw zarzel XD (and json and classy)

        for k, v in next, menuElementTypes do
            figgy ..= v .. "s {\n"
            for k1, v1 in pairs(menu.options) do
                for k2, v2 in pairs(v1) do
                    for k3, v3 in pairs(v2) do
                        if v3[2] == k and k3 ~= "Configs" and k3 ~= "Player Status" and k3 ~= "ConfigName"
                        then
                            figgy ..= k1 .. "|" .. k2 .. "|" .. k3 .. "|" .. tostring(v3[1]) .. "\n"
                        end
                    end
                end
            end
            figgy = figgy .. "}\n"
        end
        figgy = figgy .. "comboboxes {\n"
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == COMBOBOX then
                        local boolz = ""
                        for k3, v3 in pairs(v2[1]) do
                            boolz = boolz .. tostring(v3[2]) .. ", "
                        end
                        figgy = figgy .. k .. "|" .. k1 .. "|" .. k2 .. "|" .. boolz .. "\n"
                    end
                end
            end
        end
        figgy = figgy .. "}\n"
        figgy = figgy .. "keybinds {\n"
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == TOGGLE then
                        if v2[5] ~= nil then
                            if v2[5][2] == KEYBIND then
                                local toggletype = "|" .. tostring(v2[5].toggletype)

                                if v2[5][1] == nil then
                                    figgy = figgy
                                        .. k
                                        .. "|"
                                        .. k1
                                        .. "|"
                                        .. k2
                                        .. "|nil"
                                        .. "|"
                                        .. tostring(v2[5].toggletype)
                                        .. "\n"
                                else
                                    figgy = figgy
                                        .. k
                                        .. "|"
                                        .. k1
                                        .. "|"
                                        .. k2
                                        .. "|"
                                        .. tostring(v2[5][1].Value)
                                        .. "|"
                                        .. tostring(v2[5].toggletype)
                                        .. "\n"
                                end
                            end
                        end
                    end
                end
            end
        end
        figgy = figgy .. "}\n"
        figgy = figgy .. "colorpickers {\n"
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == TOGGLE then
                        if v2[5] ~= nil then
                            if v2[5][2] == COLORPICKER then
                                local clrz = ""
                                for k3, v3 in pairs(v2[5][1]) do
                                    clrz = clrz .. tostring(v3) .. ", "
                                end
                                figgy = figgy .. k .. "|" .. k1 .. "|" .. k2 .. "|" .. clrz .. "\n"
                            end
                        end
                    end
                end
            end
        end
        figgy = figgy .. "}\n"
        figgy = figgy .. "double colorpickers {\n"
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == TOGGLE then
                        if v2[5] ~= nil then
                            if v2[5][2] == DOUBLE_COLORPICKER then
                                local clrz1 = ""
                                for k3, v3 in pairs(v2[5][1][1][1]) do
                                    clrz1 = clrz1 .. tostring(v3) .. ", "
                                end
                                local clrz2 = ""
                                for k3, v3 in pairs(v2[5][1][2][1]) do
                                    clrz2 = clrz2 .. tostring(v3) .. ", "
                                end
                                figgy = figgy .. k .. "|" .. k1 .. "|" .. k2 .. "|" .. clrz1 .. "|" .. clrz2 .. "\n"
                            end
                        end
                    end
                end
            end
        end
        figgy = figgy .. "}\n"

        return figgy
    end

    local function LoadConfig(loadedcfg)
        local lines = {}

        for s in loadedcfg:gmatch("[^\r\n]+") do
            table.insert(lines, s)
        end

        if lines[1] == "BitchBot v2" then
            local start = nil
            for i, v in next, lines do
                if v == "toggles {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")

                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    if tt[4] == "true" then
                        menu.options[tt[1]][tt[2]][tt[3]][1] = true
                    else
                        menu.options[tt[1]][tt[2]][tt[3]][1] = false
                    end
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "sliders {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")
                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    menu.options[tt[1]][tt[2]][tt[3]][1] = tonumber(tt[4])
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "dropboxs {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")

                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    local num = tonumber(tt[4])
                    if num > #menu.options[tt[1]][tt[2]][tt[3]][6] then
                        num = #menu.options[tt[1]][tt[2]][tt[3]][6]
                    elseif num < 0 then
                        num = 1
                    end
                    menu.options[tt[1]][tt[2]][tt[3]][1] = num
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "textboxs {" then
                    start = i
                    break
                end
            end
            if start ~= nil then
                local end_ = nil
                for i, v in next, lines do
                    if i > start and v == "}" then
                        end_ = i
                        break
                    end
                end
                for i = 1, end_ - start - 1 do
                    local tt = string.split(lines[i + start], "|")
                    if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                    then
                        menu.options[tt[1]][tt[2]][tt[3]][1] = tostring(tt[4])
                    end
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "comboboxes {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")
                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    local subs = string.split(tt[4], ",")

                    for i, v in ipairs(subs) do
                        local opt = string.gsub(v, " ", "")
                        if opt == "true" then
                            menu.options[tt[1]][tt[2]][tt[3]][1][i][2] = true
                        else
                            menu.options[tt[1]][tt[2]][tt[3]][1][i][2] = false
                        end
                        if i == #subs - 1 then
                            break
                        end
                    end
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "keybinds {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")
                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]][5] ~= nil
                then
                    if tt[5] ~= nil then
                        local toggletype = clamp(tonumber(tt[5]), 1, 4)
                        if menu.options[tt[1]][tt[2]][tt[3]][5].toggletype ~= 0 then
                            menu.options[tt[1]][tt[2]][tt[3]][5].toggletype = toggletype
                        end
                    end

                    if tt[4] == "nil" then
                        menu.options[tt[1]][tt[2]][tt[3]][5][1] = nil
                    else
                        menu.options[tt[1]][tt[2]][tt[3]][5][1] = keyz[tonumber(tt[4])]
                    end
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "colorpickers {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")
                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    local subs = string.split(tt[4], ",")

                    if type(menu.options[tt[1]][tt[2]][tt[3]][5][1][1]) == "table" then
                        continue
                    end
                    for i, v in ipairs(subs) do
                        if menu.options[tt[1]][tt[2]][tt[3]][5][1][i] == nil then
                            break
                        end
                        local opt = string.gsub(v, " ", "")
                        menu.options[tt[1]][tt[2]][tt[3]][5][1][i] = tonumber(opt)
                        if i == #subs - 1 then
                            break
                        end
                    end
               
                end
            end

            local start = nil
            for i, v in next, lines do
                if v == "double colorpickers {" then
                    start = i
                    break
                end
            end
            local end_ = nil
            for i, v in next, lines do
                if i > start and v == "}" then
                    end_ = i
                    break
                end
            end
            for i = 1, end_ - start - 1 do
                local tt = string.split(lines[i + start], "|")
                if menu.options[tt[1]] ~= nil and menu.options[tt[1]][tt[2]] ~= nil and menu.options[tt[1]][tt[2]][tt[3]] ~= nil
                then
                    local subs = { string.split(tt[4], ","), string.split(tt[5], ",") }

                    for i, v in ipairs(subs) do
                        if type(menu.options[tt[1]][tt[2]][tt[3]][5][1][i]) == "number" then
                            break
                        end
                        for i1, v1 in ipairs(v) do
                           
                               
                            if menu.options[tt[1]][tt[2]][tt[3]][5][1][i][1][i1] == nil then
                                break
                            end
                            local opt = string.gsub(v1, " ", "")
                            menu.options[tt[1]][tt[2]][tt[3]][5][1][i][1][i1] = tonumber(opt)
                            if i1 == #v - 1 then
                                break
                            end
                        end
                    end
                end
            end

            for k, v in pairs(menu.options) do
                for k1, v1 in pairs(v) do
                    for k2, v2 in pairs(v1) do
                        if v2[2] == TOGGLE then
                            if not v2[1] then
                                for i = 0, 3 do
                                    v2[4][i + 1].Color = ColorRange(i, {
                                        [1] = { start = 0, color = RGB(50, 50, 50) },
                                        [2] = { start = 3, color = RGB(30, 30, 30) },
                                    })
                                end
                            else
                                for i = 0, 3 do
                                    v2[4][i + 1].Color = ColorRange(i, {
                                        [1] = { start = 0, color = RGB(menu.mc[1], menu.mc[2], menu.mc[3]) },
                                        [2] = {
                                            start = 3,
                                            color = RGB(menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40),
                                        },
                                    })
                                end
                            end
                            if v2[5] ~= nil then
                                if v2[5][2] == KEYBIND then
                                    v2[5][4][2].Color = RGB(30, 30, 30)
                                    v2[5][4][1].Text = KeyEnumToName(v2[5][1])
                                elseif v2[5][2] == COLORPICKER then
                                    v2[5][4][1].Color = RGB(v2[5][1][1], v2[5][1][2], v2[5][1][3])
                                    for i = 2, 3 do
                                        v2[5][4][i].Color = RGB(v2[5][1][1] - 40, v2[5][1][2] - 40, v2[5][1][3] - 40)
                                    end
                                elseif v2[5][2] == DOUBLE_COLORPICKER then
                                    if type(v2[5][1][1]) == "table" then
                                        for i, v3 in ipairs(v2[5][1]) do
                                            v3[4][1].Color = RGB(v3[1][1], v3[1][2], v3[1][3])
                                            for i1 = 2, 3 do
                                                v3[4][i1].Color = RGB(v3[1][1] - 40, v3[1][2] - 40, v3[1][3] - 40)
                                            end
                                        end
                                    end
                                end
                            end
                        elseif v2[2] == SLIDER then
                            if v2[1] < v2[6][1] then
                                v2[1] = v2[6][1]
                            elseif v2[1] > v2[6][2] then
                                v2[1] = v2[6][2]
                            end

                            local decplaces = v2.decimal and string.rep("0", math.log(1 / v2.decimal) / math.log(10))
                            if decplaces and math.abs(v2[1]) < v2.decimal then
                                v2[1] = 0
                            end
                            v2[4][5].Text = v2.custom[v2[1]] or (v2[1] == math.floor(v2[1]) and v2.decimal) and tostring(v2[1]) .. "." .. decplaces .. v2[4][6] or tostring(v2[1]) .. v2[4][6]
                            -- v2[4][5].Text = tostring(v2[1]).. v2[4][6]

                            for i = 1, 4 do
                                v2[4][i].Size = Vector2.new((v2[3][3] - 4) * ((v2[1] - v2[6][1]) / (v2[6][2] - v2[6][1])), 2)
                            end
                        elseif v2[2] == DROPBOX then
                            if v2[6][v2[1]] == nil then
                                v2[1] = 1
                            end
                            v2[4][1].Text = v2[6][v2[1]]
                        elseif v2[2] == COMBOBOX then
                            local textthing = ""
                            for k3, v3 in pairs(v2[1]) do
                                if v3[2] then
                                    if textthing == "" then
                                        textthing = v3[1]
                                    else
                                        textthing = textthing .. ", " .. v3[1]
                                    end
                                end
                            end
                            textthing = textthing ~= "" and textthing or "None"
                            textthing = string_cut(textthing, 25)
                            v2[4][1].Text = textthing
                        elseif v2[2] == TEXTBOX then
                            v2[4].Text = v2[1]
                        end
                    end
                end
            end
        end
    end
    function menu.saveconfig()
        local figgy = SaveCurSettings()
        writefile(
            "bitchbot/"
                .. menu.game
                .. "/"
                .. menu.options["Settings"]["Configuration"]["ConfigName"][1]
                .. ".bb",
            figgy
        )
        CreateNotification('Saved "' .. menu.options["Settings"]["Configuration"]["ConfigName"][1] .. '.bb"!')
        UpdateConfigs()
    end
   
    function menu.loadconfig()
        local configname = "bitchbot/"
            .. menu.game
            .. "/"
            .. menu.options["Settings"]["Configuration"]["ConfigName"][1]
            .. ".bb"
        if not isfile(configname) then
            CreateNotification(
                '"'
                    .. menu.options["Settings"]["Configuration"]["ConfigName"][1]
                    .. '.bb" is not a valid config.'
            )
            return
        end
   
        local curcfg = SaveCurSettings()
        local loadedcfg = readfile(configname)
   
        if pcall(LoadConfig, loadedcfg) then
            CreateNotification('Loaded "' .. menu.options["Settings"]["Configuration"]["ConfigName"][1] .. '.bb"!')
        else
            LoadConfig(curcfg)
            CreateNotification(
                'There was an issue loading "'
                    .. menu.options["Settings"]["Configuration"]["ConfigName"][1]
                    .. '.bb"'
            )
        end
    end

    local function buttonpressed(bp)
        if bp.doubleclick then
            if buttonsInQue[bp] and tick() - buttonsInQue[bp] < doubleclickDelay then
                buttonsInQue[bp] = 0
            else
                for button, time in next, buttonsInQue do
                    buttonsInQue[button] = 0
                end
                buttonsInQue[bp] = tick()
                return
            end
        end
        FireEvent("bb_buttonpressed", bp.tab, bp.groupbox, bp.name)
        --ButtonPressed:Fire(bp.tab, bp.groupbox, bp.name)
        if bp == menu.options["Settings"]["Cheat Settings"]["Unload Cheat"] then
            menu.fading = true
            wait()
            menu:unload()
        elseif bp == menu.options["Settings"]["Cheat Settings"]["Set Clipboard Game ID"] then
            setclipboard(game.JobId)
            CreateNotification("Set Clipboard Game ID! (".. tostring(game.JobId)..")")
        elseif bp == menu.options["Settings"]["Configuration"]["Save Config"] then
            menu.saveconfig()
        elseif bp == menu.options["Settings"]["Configuration"]["Delete Config"] then
            delfile(
                "bitchbot/"
                    .. menu.game
                    .. "/"
                    .. menu.options["Settings"]["Configuration"]["ConfigName"][1]
                    .. ".bb"
            )
            CreateNotification('Deleted "' .. menu.options["Settings"]["Configuration"]["ConfigName"][1] .. '.bb"!')
            UpdateConfigs()
        elseif bp == menu.options["Settings"]["Configuration"]["Load Config"] then
            menu.loadconfig()
        end
    end

    local function MouseButton2Event()
        if menu.colorPickerOpen or menu.dropbox_open then
            return
        end

        for k, v in pairs(menu.options) do
            if menu.tabnames[menu.activetab] == k then
                for k1, v1 in pairs(v) do
                    local pass = true
                    for k3, v3 in pairs(menu.multigroups) do
                        if k == k3 then
                            for k4, v4 in pairs(v3) do
                                for k5, v5 in pairs(v4.vals) do
                                    if k1 == k5 then
                                        pass = v5
                                    end
                                end
                            end
                        end
                    end

                    if pass then
                        for k2, v2 in pairs(v1) do --ANCHOR more menu bs
                            if v2[2] == TOGGLE then
                                if v2[5] ~= nil then
                                    if v2[5][2] == KEYBIND then
                                        if menu:MouseInMenu(v2[5][3][1], v2[5][3][2], 44, 16) then
                                            if menu.keybind_open ~= v2 and v2[5].toggletype ~= 0 then
                                                menu.keybind_open = v2
                                                menu:SetKeybindSelect(
                                                    true,
                                                    v2[5][3][1] + menu.x,
                                                    v2[5][3][2] + 16 + menu.y,
                                                    v2[5].toggletype
                                                )
                                            else
                                                menu.keybind_open = nil
                                                menu:SetKeybindSelect(false, 20, 20, 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local function menucolor()
        if menu.open then
            if menu:GetVal("Settings", "Cheat Settings", "Menu Accent") then
                local clr = menu:GetVal("Settings", "Cheat Settings", "Menu Accent", COLOR, true)
                menu.mc = { clr.R * 255, clr.G * 255, clr.B * 255 }
            else
                menu.mc = { 127, 72, 163 }
            end
            menu:SetColor(menu.mc[1], menu.mc[2], menu.mc[3])

            local wme = menu:GetVal("Settings", "Cheat Settings", "Watermark")
            for k, v in pairs(menu.watermark.rect) do
                v.Visible = wme
            end
            menu.watermark.text[1].Visible = wme
        end
    end
    local function MouseButton1Event() --ANCHOR menu mouse down func
        menu.dropbox_open = nil
        menu.textboxopen = false

        menu:SetKeybindSelect(false, 20, 20, 1)
        if menu.keybind_open then
            local key = menu.keybind_open
            local foundkey = false
            for i = 1, 4 do
                if menu:MouseInMenu(key[5][3][1], key[5][3][2] + 16 + ((i - 1) * 21), 70, 21) then
                    foundkey = true
                    menu.keybind_open[5].toggletype = i
                    menu.keybind_open[5].relvalue = false
                end
            end
            menu.keybind_open = nil
            if foundkey then
                return
            end
        end

        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == DROPBOX and v2[5] then
                        if not menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 24 * (#v2[6] + 1) + 3) then
                            menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                            v2[5] = false
                        else
                            menu.dropbox_open = v2
                        end
                    end
                    if v2[2] == COMBOBOX and v2[5] then
                        if not menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 24 * (#v2[1] + 1) + 3) then
                            menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                            v2[5] = false
                        else
                            menu.dropbox_open = v2
                        end
                    end
                    if v2[2] == TOGGLE then
                        if v2[5] ~= nil then
                            if v2[5][2] == KEYBIND then
                                if v2[5][5] == true then
                                    v2[5][4][2].Color = RGB(30, 30, 30)
                                    v2[5][5] = false
                                end
                            elseif v2[5][2] == COLORPICKER then
                                if v2[5][5] == true then
                                    if not menu:MouseInColorPicker(0, 0, cp.w, cp.h) then
                                        if menu.colorPickerOpen then
                                           
                                            local tempclr = cp.oldcolor
                                            menu.colorPickerOpen[4][1].Color = tempclr
                                            for i = 2, 3 do
                                                menu.colorPickerOpen[4][i].Color = RGB(
                                                    math.floor(tempclr.R * 255) - 40,
                                                    math.floor(tempclr.G * 255) - 40,
                                                    math.floor(tempclr.B * 255) - 40
                                                )
                                            end
                                            if cp.alpha then
                                                menu.colorPickerOpen[1] = {
                                                    math.floor(tempclr.R * 255),
                                                    math.floor(tempclr.G * 255),
                                                    math.floor(tempclr.B * 255),
                                                    cp.oldcoloralpha,
                                                }
                                            else
                                                menu.colorPickerOpen[1] = {
                                                    math.floor(tempclr.R * 255),
                                                    math.floor(tempclr.G * 255),
                                                    math.floor(tempclr.B * 255),
                                                }
                                            end
                                        end
                                        menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "hahaha", 400, 200)
                                        v2[5][5] = false
                                        menu.colorPickerOpen = nil -- close colorpicker
                                    end
                                end
                            elseif v2[5][2] == DOUBLE_COLORPICKER then
                                for k3, v3 in pairs(v2[5][1]) do
                                    if v3[5] == true then
                                        if not menu:MouseInColorPicker(0, 0, cp.w, cp.h) then
                                            if menu.colorPickerOpen then
                                                local tempclr = cp.oldcolor
                                                menu.colorPickerOpen[4][1].Color = tempclr
                                                for i = 2, 3 do
                                                    menu.colorPickerOpen[4][i].Color = RGB(
                                                        math.floor(tempclr.R * 255) - 40,
                                                        math.floor(tempclr.G * 255) - 40,
                                                        math.floor(tempclr.B * 255) - 40
                                                    )
                                                end
                                                if cp.alpha then
                                                    menu.colorPickerOpen[1] = {
                                                        math.floor(tempclr.R * 255),
                                                        math.floor(tempclr.G * 255),
                                                        math.floor(tempclr.B * 255),
                                                        cp.oldcoloralpha,
                                                    }
                                                else
                                                    menu.colorPickerOpen[1] = {
                                                        math.floor(tempclr.R * 255),
                                                        math.floor(tempclr.G * 255),
                                                        math.floor(tempclr.B * 255),
                                                    }
                                                end
                                            end
                                            menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "hahaha", 400, 200)
                                            v3[5] = false
                                            menu.colorPickerOpen = nil -- close colorpicker
                                           
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if v2[2] == TEXTBOX and v2[5] then
                        v2[4].Color = RGB(255, 255, 255)
                        v2[5] = false
                        v2[4].Text = v2[1]
                    end
                end
            end
        end
        for i = 1, #menutable do
            if menu:MouseInMenu(
                    10 + ((i - 1) * math.floor((menu.w - 20) / #menutable)),
                    27,
                    math.floor((menu.w - 20) / #menutable),
                    32
                )
            then
                menu.activetab = i
                setActiveTab(menu.activetab)
                menu:SetMenuPos(menu.x, menu.y)
                menu:SetToolTip(nil, nil, nil, false)
            end
        end
        if menu.colorPickerOpen then
            if menu:MouseInColorPicker(197, cp.h - 25, 75, 20) then
                --apply newcolor to oldcolor
                local tempclr = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                menu.colorPickerOpen[4][1].Color = tempclr
                for i = 2, 3 do
                    menu.colorPickerOpen[4][i].Color = RGB(
                        math.floor(tempclr.R * 255) - 40,
                        math.floor(tempclr.G * 255) - 40,
                        math.floor(tempclr.B * 255) - 40
                    )
                end
                if cp.alpha then
                    menu.colorPickerOpen[1] = {
                        math.floor(tempclr.R * 255),
                        math.floor(tempclr.G * 255),
                        math.floor(tempclr.B * 255),
                        cp.hsv.a,
                    }
                else
                    menu.colorPickerOpen[1] = {
                        math.floor(tempclr.R * 255),
                        math.floor(tempclr.G * 255),
                        math.floor(tempclr.B * 255),
                    }
                end
                menu.colorPickerOpen = nil
                menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "hahaha", 400, 200)
            end
            if menu:MouseInColorPicker(264, 2, 14, 14) then
                -- x out
                local tempclr = cp.oldcolor
                menu.colorPickerOpen[4][1].Color = tempclr
                for i = 2, 3 do
                    menu.colorPickerOpen[4][i].Color = RGB(
                        math.floor(tempclr.R * 255) - 40,
                        math.floor(tempclr.G * 255) - 40,
                        math.floor(tempclr.B * 255) - 40
                    )
                end
                if cp.alpha then
                    menu.colorPickerOpen[1] = {
                        math.floor(tempclr.R * 255),
                        math.floor(tempclr.G * 255),
                        math.floor(tempclr.B * 255),
                        cp.oldcoloralpha,
                    }
                else
                    menu.colorPickerOpen[1] = {
                        math.floor(tempclr.R * 255),
                        math.floor(tempclr.G * 255),
                        math.floor(tempclr.B * 255),
                    }
                end
                menu.colorPickerOpen = nil
                menu:SetColorPicker(false, { 255, 0, 0 }, nil, false, "hahaha", 400, 200)
            end
            if menu:MouseInColorPicker(10, 23, 160, 160) then
                cp.dragging_m = true
                --set value and saturation
            elseif menu:MouseInColorPicker(176, 23, 14, 160) then
                cp.dragging_r = true
                --set hue
            elseif menu:MouseInColorPicker(10, 189, 160, 14) and cp.alpha then
                cp.dragging_b = true
                --set transparency
            end

            if menu:MouseInColorPicker(197, 37, 75, 20) then
                menu.copied_clr = newcolor.Color
                --copy newcolor
            elseif menu:MouseInColorPicker(197, 57, 75, 20) then
                --paste newcolor
                if menu.copied_clr ~= nil then
                    local cpa = false
                    local clrtable = { menu.copied_clr.R * 255, menu.copied_clr.G * 255, menu.copied_clr.B * 255 }
                    if menu.colorPickerOpen[1][4] ~= nil then
                        cpa = true
                        table.insert(clrtable, menu.colorPickerOpen[1][4])
                    end

                    menu:SetColorPicker(true, clrtable, menu.colorPickerOpen, cpa, menu.colorPickerOpen[6], cp.x, cp.y)
                    cp.oldclr = menu.colorPickerOpen[4][1].Color
                    local oldclr = cp.oldclr
                    if menu.colorPickerOpen[1][4] ~= nil then
                        set_oldcolor(oldclr.R * 255, oldclr.G * 255, oldclr.B * 255, menu.colorPickerOpen[1][4])
                    else
                        set_oldcolor(oldclr.R * 255, oldclr.G * 255, oldclr.B * 255)
                    end
                end
            end

            if menu:MouseInColorPicker(197, 91, 75, 40) then
                menu.copied_clr = oldcolor.Color --copy oldcolor
            end
        else
            for k, v in pairs(menu.multigroups) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        local c_pos = v1.drawn.click_pos
                        --local selected = v1.drawn.bar
                        local selected_pos = v1.drawn.barpos

                        for k2, v2 in pairs(v1.drawn.click_pos) do
                            if menu:MouseInMenu(v2.x, v2.y, v2.width, v2.height) then
                                for _k, _v in pairs(v1.vals) do
                                    if _k == v2.name then
                                        v1.vals[_k] = true
                                    else
                                        v1.vals[_k] = false
                                    end
                                end

                                local settab = v2.num
                                for _k, _v in pairs(v1.drawn.bar) do
                                    menu.postable[_v.postable][2] = selected_pos[settab].pos
                                    _v.drawn.Size = Vector2.new(selected_pos[settab].length, 2)
                                end

                                for i, v in pairs(v1.drawn.nametext) do
                                    if i == v2.num then
                                        v.Color = RGB(255, 255, 255)
                                    else
                                        v.Color = RGB(170, 170, 170)
                                    end
                                end

                                menu:setMenuVisible(true)
                                setActiveTab(menu.activetab)
                                menu:SetMenuPos(menu.x, menu.y)
                            end
                        end
                    end
                end
            end
            local newdropbox_open
            for k, v in pairs(menu.options) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        local pass = true
                        for k3, v3 in pairs(menu.multigroups) do
                            if k == k3 then
                                for k4, v4 in pairs(v3) do
                                    for k5, v5 in pairs(v4.vals) do
                                        if k1 == k5 then
                                            pass = v5
                                        end
                                    end
                                end
                            end
                        end

                        if pass then
                            for k2, v2 in pairs(v1) do
                                if v2[2] == TOGGLE and not menu.dropbox_open then
                                    if menu:MouseInMenu(v2[3][1], v2[3][2], 30 + v2[4][5].TextBounds.x, 16) then
                                        if v2[6] then
                                            if menu:GetVal(
                                                    "Settings",
                                                    "Cheat Settings",
                                                    "Allow Unsafe Features"
                                                ) and v2[1] == false
                                            then
                                                v2[1] = true
                                            else
                                                v2[1] = false
                                            end
                                        else
                                            v2[1] = not v2[1]
                                        end
                                        if not v2[1] then
                                            for i = 0, 3 do
                                                v2[4][i + 1].Color = ColorRange(i, {
                                                    [1] = { start = 0, color = RGB(50, 50, 50) },
                                                    [2] = { start = 3, color = RGB(30, 30, 30) },
                                                })
                                            end
                                        else
                                            for i = 0, 3 do
                                                v2[4][i + 1].Color = ColorRange(i, {
                                                    [1] = {
                                                        start = 0,
                                                        color = RGB(menu.mc[1], menu.mc[2], menu.mc[3]),
                                                    },
                                                    [2] = {
                                                        start = 3,
                                                        color = RGB(
                                                            menu.mc[1] - 40,
                                                            menu.mc[2] - 40,
                                                            menu.mc[3] - 40
                                                        ),
                                                    },
                                                })
                                            end
                                        end
                                        --TogglePressed:Fire(k1, k2, v2)
                                        FireEvent("bb_togglepressed", k1, k2, v2)
                                    end
                                    if v2[5] ~= nil then
                                        if v2[5][2] == KEYBIND then
                                            if menu:MouseInMenu(v2[5][3][1], v2[5][3][2], 44, 16) then
                                                v2[5][4][2].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                                                v2[5][5] = true
                                            end
                                        elseif v2[5][2] == COLORPICKER then
                                            if menu:MouseInMenu(v2[5][3][1], v2[5][3][2], 28, 14) then
                                                v2[5][5] = true
                                                menu.colorPickerOpen = v2[5]
                                                menu.colorPickerOpen = v2[5]
                                                if v2[5][1][4] ~= nil then
                                                    menu:SetColorPicker(
                                                        true,
                                                        v2[5][1],
                                                        v2[5],
                                                        true,
                                                        v2[5][6],
                                                        LOCAL_MOUSE.x,
                                                        LOCAL_MOUSE.y + 36
                                                    )
                                                else
                                                    menu:SetColorPicker(
                                                        true,
                                                        v2[5][1],
                                                        v2[5],
                                                        false,
                                                        v2[5][6],
                                                        LOCAL_MOUSE.x,
                                                        LOCAL_MOUSE.y + 36
                                                    )
                                                end
                                            end
                                        elseif v2[5][2] == DOUBLE_COLORPICKER then
                                            for k3, v3 in pairs(v2[5][1]) do
                                                if menu:MouseInMenu(v3[3][1], v3[3][2], 28, 14) then
                                                    v3[5] = true
                                                    menu.colorPickerOpen = v3
                                                    menu.colorPickerOpen = v3
                                                    if v3[1][4] ~= nil then
                                                        menu:SetColorPicker(
                                                            true,
                                                            v3[1],
                                                            v3,
                                                            true,
                                                            v3[6],
                                                            LOCAL_MOUSE.x,
                                                            LOCAL_MOUSE.y + 36
                                                        )
                                                    else
                                                        menu:SetColorPicker(
                                                            true,
                                                            v3[1],
                                                            v3,
                                                            false,
                                                            v3[6],
                                                            LOCAL_MOUSE.x,
                                                            LOCAL_MOUSE.y + 36
                                                        )
                                                    end
                                                end
                                            end
                                        end
                                    end
                                elseif v2[2] == SLIDER and not menu.dropbox_open then
                                    if menu:MouseInMenu(v2[7][1], v2[7][2], 22, 13) then
                                        local stepval = 1
                                        if v2.stepsize then
                                            stepval = v2.stepsize
                                        end
                                        if menu:modkeydown("shift", "left") then
                                            stepval = v2.shift_stepsize or 0.1
                                        end
                                        if menu:MouseInMenu(v2[7][1], v2[7][2], 11, 13) then
                                            v2[1] -= stepval
                                        elseif menu:MouseInMenu(v2[7][1] + 11, v2[7][2], 11, 13) then
                                            v2[1] += stepval
                                        end

                                        if v2[1] < v2[6][1] then
                                            v2[1] = v2[6][1]
                                        elseif v2[1] > v2[6][2] then
                                            v2[1] = v2[6][2]
                                        end
                                        local decplaces = v2.decimal and string.rep("0", math.log(1 / v2.decimal) / math.log(10))
                                        if decplaces and math.abs(v2[1]) < v2.decimal then
                                            v2[1] = 0
                                        end
                                        v2[4][5].Text = v2.custom[v2[1]] or (v2[1] == math.floor(v2[1]) and v2.decimal) and tostring(v2[1]) .. "." .. decplaces .. v2[4][6] or tostring(v2[1]) .. v2[4][6]

                                        for i = 1, 4 do
                                            v2[4][i].Size = Vector2.new(
                                                (v2[3][3] - 4) * ((v2[1] - v2[6][1]) / (v2[6][2] - v2[6][1])),
                                                2
                                            )
                                        end
                                    elseif menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 28) then
                                        v2[5] = true
                                    end
                                elseif v2[2] == DROPBOX then
                                    if menu.dropbox_open then
                                        if v2 ~= menu.dropbox_open then
                                            continue
                                        end
                                    end
                                    if menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 36) then
                                        if not v2[5] then
                                            v2[5] = menu:SetDropBox(
                                                true,
                                                v2[3][1] + menu.x + 1,
                                                v2[3][2] + menu.y + 13,
                                                v2[3][3],
                                                v2[1],
                                                v2[6]
                                            )
                                            newdropbox_open = v2
                                        else
                                            menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                                            v2[5] = false
                                            newdropbox_open = nil
                                        end
                                    elseif menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 24 * (#v2[6] + 1) + 3) and v2[5]
                                    then
                                        for i = 1, #v2[6] do
                                            if menu:MouseInMenu(
                                                    v2[3][1],
                                                    v2[3][2] + 36 + ((i - 1) * 21),
                                                    v2[3][3],
                                                    21
                                                )
                                            then
                                                v2[4][1].Text = v2[6][i]
                                                v2[1] = i
                                                menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                                                v2[5] = false
                                                newdropbox_open = nil
                                            end
                                        end

                                        if v2 == menu.options["Settings"]["Configuration"]["Configs"] then
                                            local textbox = menu.options["Settings"]["Configuration"]["ConfigName"]
                                            local relconfigs = GetConfigs()
                                            textbox[1] = relconfigs[menu.options["Settings"]["Configuration"]["Configs"][1]]
                                            textbox[4].Text = textbox[1]
                                        end
                                    end
                                elseif v2[2] == COMBOBOX then
                                    if menu.dropbox_open then
                                        if v2 ~= menu.dropbox_open then
                                            continue
                                        end
                                    end
                                    if menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 36) then
                                        if not v2[5] then
                                           
                                            v2[5] = set_comboboxthingy(
                                                true,
                                                v2[3][1] + menu.x + 1,
                                                v2[3][2] + menu.y + 13,
                                                v2[3][3],
                                                v2[1],
                                                v2[6]
                                            )
                                            newdropbox_open = v2
                                        else
                                            menu:SetDropBox(false, 400, 200, 160, 1, { "HI q", "HI q", "HI q" })
                                            v2[5] = false
                                            newdropbox_open = nil
                                        end
                                    elseif menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 24 * (#v2[1] + 1) + 3) and v2[5]
                                    then
                                        for i = 1, #v2[1] do
                                            if menu:MouseInMenu(
                                                    v2[3][1],
                                                    v2[3][2] + 36 + ((i - 1) * 22),
                                                    v2[3][3],
                                                    23
                                                )
                                            then
                                                v2[1][i][2] = not v2[1][i][2]
                                                local textthing = ""
                                                for k, v in pairs(v2[1]) do
                                                    if v[2] then
                                                        if textthing == "" then
                                                            textthing = v[1]
                                                        else
                                                            textthing = textthing .. ", " .. v[1]
                                                        end
                                                    end
                                                end
                                                textthing = textthing ~= "" and textthing or "None"
                                                textthing = string_cut(textthing, 25)
                                                v2[4][1].Text = textthing
                                                set_comboboxthingy(
                                                    true,
                                                    v2[3][1] + menu.x + 1,
                                                    v2[3][2] + menu.y + 13,
                                                    v2[3][3],
                                                    v2[1],
                                                    v2[6]
                                                )
                                            end
                                        end
                                    end
                                elseif v2[2] == BUTTON and not menu.dropbox_open then
                                    if menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 22) then
                                        if not v2[1] then
                                            buttonpressed(v2)
                                            if k2 == "Unload Cheat" then
                                                return
                                            end
                                            for i = 0, 8 do
                                                v2[4][i + 1].Color = ColorRange(i, {
                                                    [1] = { start = 0, color = RGB(35, 35, 35) },
                                                    [2] = { start = 8, color = RGB(50, 50, 50) },
                                                })
                                            end
                                            v2[1] = true
                                        end
                                    end
                                elseif v2[2] == TEXTBOX and not menu.dropbox_open then
                                    if menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 22) then
                                        if not v2[5] then
                                            menu.textboxopen = v2

                                            v2[4].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                                            v2[5] = true
                                        end
                                    end
                                elseif v2[2] == "list" then
                                    --[[
                                    menu.options[v.name][v1.name][v2.name] = {}
                                    menu.options[v.name][v1.name][v2.name][4] = Draw:List(v2.name, v1.x + 8, v1.y + y_pos, v1.width - 16, v2.size, v2.columns, tabz[k])
                                    menu.options[v.name][v1.name][v2.name][1] = nil
                                    menu.options[v.name][v1.name][v2.name][2] = v2.type
                                    menu.options[v.name][v1.name][v2.name][3] = 1
                                    menu.options[v.name][v1.name][v2.name][5] = {}
                                    menu.options[v.name][v1.name][v2.name][6] = v2.size
                                    menu.options[v.name][v1.name][v2.name][7] = v2.columns
                                    menu.options[v.name][v1.name][v2.name][8] = {v1.x + 8, v1.y + y_pos, v1.width - 16}
                                    ]]
                                    --
                                    if #v2[5] > v2[6] then
                                        for i = 1, v2[6] do
                                            if menu:MouseInMenu(v2[8][1], v2[8][2] + (i * 22) - 5, v2[8][3], 22)
                                            then
                                                if v2[1] == tostring(v2[5][i + v2[3] - 1][1][1]) then
                                                    v2[1] = nil
                                                else
                                                    v2[1] = tostring(v2[5][i + v2[3] - 1][1][1])
                                                end
                                            end
                                        end
                                    else
                                        for i = 1, #v2[5] do
                                            if menu:MouseInMenu(v2[8][1], v2[8][2] + (i * 22) - 5, v2[8][3], 22)
                                            then
                                                if v2[1] == tostring(v2[5][i + v2[3] - 1][1][1]) then
                                                    v2[1] = nil
                                                else
                                                    v2[1] = tostring(v2[5][i + v2[3] - 1][1][1])
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            menu.dropbox_open = newdropbox_open
        end
        for k, v in pairs(menu.options) do
            for k1, v1 in pairs(v) do
                for k2, v2 in pairs(v1) do
                    if v2[2] == TOGGLE then
                        if v2[6] then
                            if not menu:GetVal("Settings", "Cheat Settings", "Allow Unsafe Features") then
                                v2[1] = false
                                for i = 0, 3 do
                                    v2[4][i + 1].Color = ColorRange(i, {
                                        [1] = { start = 0, color = RGB(50, 50, 50) },
                                        [2] = { start = 3, color = RGB(30, 30, 30) },
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
        menucolor()
    end

   

    local function mousebutton1upfunc()
        cp.dragging_m = false
        cp.dragging_r = false
        cp.dragging_b = false
        for k, v in pairs(menu.options) do
            if menu.tabnames[menu.activetab] == k then
                for k1, v1 in pairs(v) do
                    for k2, v2 in pairs(v1) do
                        if v2[2] == SLIDER and v2[5] then
                            v2[5] = false
                        end
                        if v2[2] == BUTTON and v2[1] then
                            for i = 0, 8 do
                                v2[4][i + 1].Color = ColorRange(i, {
                                    [1] = { start = 0, color = RGB(50, 50, 50) },
                                    [2] = { start = 8, color = RGB(35, 35, 35) },
                                })
                            end
                            v2[1] = false
                        end
                    end
                end
            end
        end
    end

    local clickspot_x, clickspot_y, original_menu_x, original_menu_y = 0, 0, 0, 0

    menu.connections.mwf = LOCAL_MOUSE.WheelForward:Connect(function()
        if menu.open then
            for k, v in pairs(menu.options) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        for k2, v2 in pairs(v1) do
                            if v2[2] == "list" then
                                if v2[3] > 1 then
                                    v2[3] -= 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    menu.connections.mwb = LOCAL_MOUSE.WheelBackward:Connect(function()
        if menu.open then
            for k, v in pairs(menu.options) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        for k2, v2 in pairs(v1) do
                            if v2[2] == "list" then
                                if v2[5][v2[3] + v2[6]] ~= nil then
                                    v2[3] += 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    function menu:setMenuAlpha(transparency)
        for k, v in pairs(bbmouse) do
            v.Transparency = transparency
        end
        for k, v in pairs(bbmenu) do
            v.Transparency = transparency
        end
        for k, v in pairs(tabz[menu.activetab]) do
            v.Transparency = transparency
        end
    end

    function menu:setMenuVisible(visible)
        for k, v in pairs(bbmouse) do
            v.Visible = visible
        end
        for k, v in pairs(bbmenu) do
            v.Visible = visible
        end
        for k, v in pairs(tabz[menu.activetab]) do
            v.Visible = visible
        end

        if visible then
            for k, v in pairs(menu.multigroups) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        for k2, v2 in pairs(v1.vals) do
                            for k3, v3 in pairs(menu.mgrouptabz[k][k2]) do
                                v3.Visible = v2
                            end
                        end
                    end
                end
            end
        end
    end

    menu:setMenuAlpha(0)
    menu:setMenuVisible(false)
    menu.lastActive = true
    menu.open = false
    menu.windowactive = true
    menu.connections.mousemoved = MouseMoved:connect(function(b)
        menu.windowactive = iswindowactive() or b
    end)

    local function renderSteppedMenu(fdt)
        if cp.dragging_m or cp.dragging_r or cp.dragging_b then
            menucolor()
        end
        menu.dt = fdt
        if menu.unloaded then
            return
        end
        SCREEN_SIZE = Camera.ViewportSize
        if bbmouse[#bbmouse-1] then
            if menu.inmenu and not menu.inmiddlemenu and not menu.intabs then
                bbmouse[#bbmouse-1].Visible = true
                bbmouse[#bbmouse-1].Transparency = 1
            else
                bbmouse[#bbmouse-1].Visible = false
            end
        end
        -- i pasted the old menu working ingame shit from the old source nate pls fix ty
        -- this is the really shitty alive check that we've been using since day one
        -- removed it :DDD
        -- im keepin all of our comments they're fun to look at
        -- i wish it showed comment dates that would be cool
        -- nah that would suck fk u (comment made on 3/4/2021 3:35 pm est by bitch)

       
        menu.lastActive = menu.windowactive
        for button, time in next, buttonsInQue do
            if time and tick() - time < doubleclickDelay then
                button[4].text.Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                button[4].text.Text = "Confirm?"
            else
                button[4].text.Color = Color3.new(1, 1, 1)
                button[4].text.Text = button.name
            end
        end
        if menu.open then
            if menu.backspaceheld then
                local dt = tick() - menu.backspacetime
                if dt > 0.4 then
                    menu.backspaceflags += 1
                    if menu.backspaceflags % 5 == 0 then
                        local textbox = menu.textboxopen
                        textbox[1] = string.sub(textbox[1], 0, #textbox[1] - 1)
                        textbox[4].Text = textbox[1] .. "|"
                    end
                end
            end
        end
        if menu.fading then
            if menu.open then
                menu.timesincefade = tick() - menu.fadestart
                menu.fade_amount = 1 - (menu.timesincefade * 10)
                menu:SetPlusMinus(0, 20, 20)
                menu:setMenuAlpha(menu.fade_amount)
                if menu.fade_amount <= 0 then
                    menu.open = false
                    menu.fading = false
                    menu:setMenuAlpha(0)
                    menu:setMenuVisible(false)
                else
                    menu:setMenuAlpha(menu.fade_amount)
                end
            else
                menu:setMenuVisible(true)
                setActiveTab(menu.activetab)
                menu.timesincefade = tick() - menu.fadestart
                menu.fade_amount = (menu.timesincefade * 10)
                menu.fadeamount = menu.fade_amount
                menu:setMenuAlpha(menu.fade_amount)
                if menu.fade_amount >= 1 then
                    menu.open = true
                    menu.fading = false
                    menu:setMenuAlpha(1)
                else
                    menu:setMenuAlpha(menu.fade_amount)
                end
            end
        end
        if menu.game == "uni" then
            if menu.open then
                INPUT_SERVICE.MouseBehavior = Enum.MouseBehavior.Default
            else
                if INPUT_SERVICE.MouseBehavior ~= menu.mousebehavior then
                    INPUT_SERVICE.MouseBehavior = menu.mousebehavior
                end
            end
        end
        menu:SetMousePosition(LOCAL_MOUSE.x, LOCAL_MOUSE.y)
        local settooltip = true
        if menu.open or menu.fading then
            menu:SetPlusMinus(0, 20, 20)
            for k, v in pairs(menu.options) do
                if menu.tabnames[menu.activetab] == k then
                    for k1, v1 in pairs(v) do
                        local pass = true
                        for k3, v3 in pairs(menu.multigroups) do
                            if k == k3 then
                                for k4, v4 in pairs(v3) do
                                    for k5, v5 in pairs(v4.vals) do
                                        if k1 == k5 then
                                            pass = v5
                                        end
                                    end
                                end
                            end
                        end

                        if pass then
                            for k2, v2 in pairs(v1) do
                                if v2[2] == TOGGLE then
                                    if not menu.dropbox_open and not menu.colorPickerOpen then
                                        if menu.open and menu:MouseInMenu(v2[3][1], v2[3][2], 30 + v2[4][5].TextBounds.x, 16)
                                        then
                                            if v2.tooltip and settooltip then
                                                menu:SetToolTip(
                                                    menu.x + v2[3][1],
                                                    menu.y + v2[3][2] + 18,
                                                    v2.tooltip,
                                                    true,
                                                    fdt--[[this is really fucking stupid]] -- this is no longer really fucking stupid
                                                )
                                                settooltip = false
                                            end
                                        end
                                    end
                                elseif v2[2] == SLIDER then
                                    if v2[5] then
                                        local new_val = (v2[6][2] - v2[6][1])  * (
                                                (
                                                    LOCAL_MOUSE.x
                                                    - menu.x
                                                    - v2[3][1]
                                                ) / v2[3][3]
                                            )
                                        v2[1] = (
                                                not v2.decimal and math.floor(new_val) or math.floor(new_val / v2.decimal) * v2.decimal
                                            ) + v2[6][1]
                                        if v2[1] < v2[6][1] then
                                            v2[1] = v2[6][1]
                                        elseif v2[1] > v2[6][2] then
                                            v2[1] = v2[6][2]
                                        end
                                        local decplaces = v2.decimal and string.rep("0", math.log(1 / v2.decimal) / math.log(10))
                                        if decplaces and math.abs(v2[1]) < v2.decimal then
                                            v2[1] = 0
                                        end

                                        v2[4][5].Text = v2.custom[v2[1]] or (v2[1] == math.floor(v2[1]) and v2.decimal) and tostring(v2[1]) .. "." .. decplaces .. v2[4][6] or tostring(v2[1]) .. v2[4][6]
                                        for i = 1, 4 do
                                            v2[4][i].Size = Vector2.new(
                                                (v2[3][3] - 4) * ((v2[1] - v2[6][1]) / (v2[6][2] - v2[6][1])),
                                                2
                                            )
                                        end
                                        menu:SetPlusMinus(1, v2[7][1], v2[7][2])
                                    else
                                        if not menu.dropbox_open then
                                            if menu:MouseInMenu(v2[3][1], v2[3][2], v2[3][3], 28) then
                                                if menu:MouseInMenu(v2[7][1], v2[7][2], 22, 13) then
                                                    if menu:MouseInMenu(v2[7][1], v2[7][2], 11, 13) then
                                                        menu:SetPlusMinus(2, v2[7][1], v2[7][2])
                                                    elseif menu:MouseInMenu(v2[7][1] + 11, v2[7][2], 11, 13) then
                                                        menu:SetPlusMinus(3, v2[7][1], v2[7][2])
                                                    end
                                                else
                                                    menu:SetPlusMinus(1, v2[7][1], v2[7][2])
                                                end
                                            end
                                        end
                                    end
                                elseif v2[2] == "list" then
                                    for k3, v3 in pairs(v2[4].liststuff) do
                                        for i, v4 in ipairs(v3) do
                                            for i1, v5 in ipairs(v4) do
                                                v5.Visible = false
                                            end
                                        end
                                    end
                                    for i = 1, v2[6] do
                                        if v2[5][i + v2[3] - 1] ~= nil then
                                            for i1 = 1, v2[7] do
                                                v2[4].liststuff.words[i][i1].Text = v2[5][i + v2[3] - 1][i1][1]
                                                v2[4].liststuff.words[i][i1].Visible = true

                                                if v2[5][i + v2[3] - 1][i1][1] == v2[1] and i1 == 1 then
                                                    if menu.options["Settings"]["Cheat Settings"]["Menu Accent"][1]
                                                    then
                                                        local clr = menu.options["Settings"]["Cheat Settings"]["Menu Accent"][5][1]
                                                        v2[4].liststuff.words[i][i1].Color = RGB(clr[1], clr[2], clr[3])
                                                    else
                                                        v2[4].liststuff.words[i][i1].Color = RGB(menu.mc[1], menu.mc[2], menu.mc[3])
                                                    end
                                                else
                                                    v2[4].liststuff.words[i][i1].Color = v2[5][i + v2[3] - 1][i1][2]
                                                end
                                            end
                                            for k3, v3 in pairs(v2[4].liststuff.rows[i]) do
                                                v3.Visible = true
                                            end
                                        elseif v2[3] > 1 then
                                            v2[3] -= 1
                                        end
                                    end
                                    if v2[3] == 1 then
                                        for k3, v3 in pairs(v2[4].uparrow) do
                                            if v3.Visible then
                                                v3.Visible = false
                                            end
                                        end
                                    else
                                        for k3, v3 in pairs(v2[4].uparrow) do
                                            if not v3.Visible then
                                                v3.Visible = true
                                                menu:SetMenuPos(menu.x, menu.y)
                                            end
                                        end
                                    end
                                    if v2[5][v2[3] + v2[6]] == nil then
                                        for k3, v3 in pairs(v2[4].downarrow) do
                                            if v3.Visible then
                                                v3.Visible = false
                                            end
                                        end
                                    else
                                        for k3, v3 in pairs(v2[4].downarrow) do
                                            if not v3.Visible then
                                                v3.Visible = true
                                                menu:SetMenuPos(menu.x, menu.y)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            menu.inmenu = LOCAL_MOUSE.x > menu.x and LOCAL_MOUSE.x < menu.x + menu.w and LOCAL_MOUSE.y > menu.y - 32 and LOCAL_MOUSE.y < menu.y + menu.h - 34
            menu.intabs = LOCAL_MOUSE.x > menu.x + 9 and LOCAL_MOUSE.x < menu.x + menu.w - 9 and LOCAL_MOUSE.y > menu.y - 9 and LOCAL_MOUSE.y < menu.y + 24
            menu.inmiddlemenu = LOCAL_MOUSE.x > menu.x + 18 and LOCAL_MOUSE.x < menu.x + menu.w - 18 and LOCAL_MOUSE.y > menu.y + 33 and LOCAL_MOUSE.y < menu.y + menu.h - 56
            if (
                    --[[(
                        LOCAL_MOUSE.x > menu.x and LOCAL_MOUSE.x < menu.x + menu.w and LOCAL_MOUSE.y > menu.y - 32 and LOCAL_MOUSE.y < menu.y - 11
                    )]]
                    (
                        menu.inmenu and
                        not menu.intabs and
                        not menu.inmiddlemenu
                    ) or menu.dragging
                ) and not menu.dontdrag
            then
                if menu.mousedown and not menu.colorPickerOpen and not dropbox_open then
                    if not menu.dragging then
                        clickspot_x = LOCAL_MOUSE.x
                        clickspot_y = LOCAL_MOUSE.y - 36 original_menu_X = menu.x original_menu_y = menu.y
                        menu.dragging = true
                    end
                    menu.x = (original_menu_X - clickspot_x) + LOCAL_MOUSE.x
                    menu.y = (original_menu_y - clickspot_y) + LOCAL_MOUSE.y - 36
                    if menu.y < 0 then
                        menu.y = 0
                    end
                    if menu.x < -menu.w / 4 * 3 then
                        menu.x = -menu.w / 4 * 3
                    end
                    if menu.x + menu.w / 4 > SCREEN_SIZE.x then
                        menu.x = SCREEN_SIZE.x - menu.w / 4
                    end
                    if menu.y > SCREEN_SIZE.y - 20 then
                        menu.y = SCREEN_SIZE.y - 20
                    end
                    menu:SetMenuPos(menu.x, menu.y)
                else
                    menu.dragging = false
                end
            elseif menu.mousedown then
                menu.dontdrag = true
            elseif not menu.mousedown then
                menu.dontdrag = false
            end
            if menu.colorPickerOpen then
                if cp.dragging_m then
                    menu:SetDragBarM(
                        clamp(LOCAL_MOUSE.x, cp.x + 12, cp.x + 167) - 2,
                        clamp(LOCAL_MOUSE.y + 36, cp.y + 25, cp.y + 180) - 2
                    )

                    cp.hsv.s = (clamp(LOCAL_MOUSE.x, cp.x + 12, cp.x + 167) - cp.x - 12) / 155
                    cp.hsv.v = 1 - ((clamp(LOCAL_MOUSE.y + 36, cp.y + 23, cp.y + 178) - cp.y - 23) / 155)
                    newcolor.Color = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                    local tempclr = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                    menu.colorPickerOpen[4][1].Color = tempclr
                    for i = 2, 3 do
                        menu.colorPickerOpen[4][i].Color = RGB(
                            math.floor(tempclr.R * 255) - 40,
                            math.floor(tempclr.G * 255) - 40,
                            math.floor(tempclr.B * 255) - 40
                        )
                    end
                    if cp.alpha then
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                            cp.hsv.a,
                        }
                    else
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                        }
                    end
                elseif cp.dragging_r then
                    menu:SetDragBarR(cp.x + 175, clamp(LOCAL_MOUSE.y + 36, cp.y + 23, cp.y + 178))

                    maincolor.Color = Color3.fromHSV(
                            1 - ((clamp(LOCAL_MOUSE.y + 36, cp.y + 23, cp.y + 178) - cp.y - 23) / 155),
                            1,
                            1
                        )

                    cp.hsv.h = 1 - ((clamp(LOCAL_MOUSE.y + 36, cp.y + 23, cp.y + 178) - cp.y - 23) / 155)
                    newcolor.Color = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                    local tempclr = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                    menu.colorPickerOpen[4][1].Color = tempclr
                    for i = 2, 3 do
                        menu.colorPickerOpen[4][i].Color = RGB(
                            math.floor(tempclr.R * 255) - 40,
                            math.floor(tempclr.G * 255) - 40,
                            math.floor(tempclr.B * 255) - 40
                        )
                    end
                    if cp.alpha then
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                            cp.hsv.a,
                        }
                    else
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                        }
                    end
                elseif cp.dragging_b then
                    local tempclr = Color3.fromHSV(cp.hsv.h, cp.hsv.s, cp.hsv.v)
                    menu.colorPickerOpen[4][1].Color = tempclr
                    for i = 2, 3 do
                        menu.colorPickerOpen[4][i].Color = RGB(
                            math.floor(tempclr.R * 255) - 40,
                            math.floor(tempclr.G * 255) - 40,
                            math.floor(tempclr.B * 255) - 40
                        )
                    end
                    if cp.alpha then
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                            cp.hsv.a,
                        }
                    else
                        menu.colorPickerOpen[1] = {
                            math.floor(tempclr.R * 255),
                            math.floor(tempclr.G * 255),
                            math.floor(tempclr.B * 255),
                        }
                    end
                    menu:SetDragBarB(clamp(LOCAL_MOUSE.x, cp.x + 10, cp.x + 168), cp.y + 188)
                    newcolor.Transparency = (clamp(LOCAL_MOUSE.x, cp.x + 10, cp.x + 168) - cp.x - 10) / 158
                    cp.hsv.a = math.floor(((clamp(LOCAL_MOUSE.x, cp.x + 10, cp.x + 168) - cp.x - 10) / 158) * 255)
                else
                    local setvisnew = menu:MouseInColorPicker(197, 37, 75, 40)

                    for i, v in ipairs(newcopy) do
                        v.Visible = setvisnew
                    end

                    local setvisold = menu:MouseInColorPicker(197, 91, 75, 40)

                    for i, v in ipairs(oldcopy) do
                        v.Visible = setvisold
                    end
                end
            end
        else
            menu.dragging = false
        end
        if settooltip then
            menu:SetToolTip(nil, nil, nil, false, fdt)
        end
    end

    menu.connections.inputstart = INPUT_SERVICE.InputBegan:Connect(function(input)
        if menu then
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                menu.mousedown = true
                if menu.open and not menu.fading then
                    MouseButton1Event()
                end
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                if menu.open and not menu.fading then
                    MouseButton2Event()
                end
            end

            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode.Name:match("Shift") then
                    local kcn = input.KeyCode.Name
                    local direction = kcn:split("Shift")[1]
                    menu.modkeys.shift.direction = direction:lower()
                end
                if input.KeyCode.Name:match("Alt") then
                    local kcn = input.KeyCode.Name
                    local direction = kcn:split("Alt")[1]
                    menu.modkeys.alt.direction = direction:lower()
                end
            end
            if not menu then
                return
            end -- this fixed shit with unload
            menu:InputBeganMenu(input)
            menu:InputBeganKeybinds(input)
            if menu.open then
                if menu.tabnames[menu.activetab] == "Settings" then
                    local menutext = menu:GetVal("Settings", "Cheat Settings", "Custom Menu Name") and menu:GetVal("Settings", "Cheat Settings", "MenuName") or "Bitch Bot"

                    bbmenu[27].Text = menutext

                    menu.watermark.text[1].Text = menutext.. menu.watermark.textString

                    for i, v in ipairs(menu.watermark.rect) do
                        local len = #menu.watermark.text[1].Text * 7 + 10
                        if i == #menu.watermark.rect then
                            len += 2
                        end
                        v.Size = Vector2.new(len, v.Size.y)
                    end
                end
            end
            if input.KeyCode == Enum.KeyCode.F2 then
                menu.stat_menu = not menu.stat_menu

                for k, v in pairs(graphs) do
                    if k ~= "other" then
                        for k1, v1 in pairs(v) do
                            if k1 ~= "pos" then
                                for k2, v2 in pairs(v1) do
                                    v2.Visible = menu.stat_menu
                                end
                            end
                        end
                    end
                end

                for k, v in pairs(graphs.other) do
                    v.Visible = menu.stat_menu
                end
            end
        end
    end)

    menu.connections.inputended = INPUT_SERVICE.InputEnded:Connect(function(input)
        menu:InputEndedKeybinds(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            menu.mousedown = false
            if menu.open and not menu.fading then
                mousebutton1upfunc()
            end
        end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode.Name:match("Shift") then
                menu.modkeys.shift.direction = nil
            end
            if input.KeyCode.Name:match("Alt") then
                menu.modkeys.alt.direction = nil
            end
        end
    end)

    menu.connections.renderstepped = game:GetService("RunService").RenderStepped:Connect(renderSteppedMenu) -- fucking asshole 🖕🖕🖕

    function menu:unload()
        getgenv().v2 = nil
        self.unloaded = true

        for k, conn in next, self.connections do
            if not getrawmetatable(conn) then
                conn()
            else
                conn:Disconnect()
            end
            self.connections[k] = nil
        end

        game:service("ContextActionService"):UnbindAction("BB Keycheck")
        if self.game == "pf" then
            game:service("ContextActionService"):UnbindAction("BB PF check")
        elseif self.game == "uni" then
            game:service("ContextActionService"):UnbindAction("BB UNI check")
        end

        local mt = getrawmetatable(game)

        setreadonly(mt, false)

        local oldmt = menu.oldmt

        if oldmt then
            for k, v in next, mt do
                if oldmt[k] then
                    mt[k] = oldmt[k]
                end
            end
        else
            --TODO nate do this please
            -- remember to store any "game" metatable hooks PLEASE PLEASE because this will ensure it replaces the meta so that it UNLOADS properly
            -- rconsoleerr("fatal error: no old game meta found! (UNLOAD PROBABLY WON'T WORK AS EXPECTED)")
        end

        setreadonly(mt, true)

        if menu.game == "pf" or menu.pfunload then
            menu:pfunload()
        end

        Draw:UnRender()
        CreateNotification = nil
        allrender = nil
        menu = nil
        Draw = nil
        self.unloaded = true
    end
end

local avgfps = 100

-- I STOLE THE FPS COUNTER FROM https://devforum.roblox.com/t/get-client-fps-trough-a-script/282631/14 😿😿😿😢😭
-- fixed ur shitty fps counter
local StatMenuRendered = event.new("StatMenuRendered")
menu.connections.heartbeatmenu = game:GetService("RunService").Heartbeat:Connect(function() --ANCHOR MENU HEARTBEAT
    if menu.open then
        if menu.y < 0 then
            menu.y = 0
            menu:SetMenuPos(menu.x, 0)
        end
        if menu.x < -menu.w / 4 * 3 then
            menu.x = -menu.w / 4 * 3
            menu:SetMenuPos(-menu.w / 4 * 3, menu.y)
        end
        if menu.x + menu.w / 4 > SCREEN_SIZE.x then
            menu.x = SCREEN_SIZE.x - menu.w / 4
            menu:SetMenuPos(SCREEN_SIZE.x - menu.w / 4, menu.y)
        end
        if menu.y > SCREEN_SIZE.y - 20 then
            menu.y = SCREEN_SIZE.y - 20
            menu:SetMenuPos(menu.x, SCREEN_SIZE.y - 20)
        end
    end
    if menu.stat_menu == false then
        return
    end
    local fps = 1 / (menu.dt or 1)
    avgfps = (fps + avgfps * 49) / 50
    local CurrentFPS = math.floor(avgfps)

    if tick() > lasttick + 0.25 then
        table.remove(networkin.incoming, 1)
        table.insert(networkin.incoming, stats.DataReceiveKbps)

        table.remove(networkin.outgoing, 1)
        table.insert(networkin.outgoing, stats.DataSendKbps)

        --incoming
        local biggestnum = 80
        for i = 1, 21 do
            if math.ceil(networkin.incoming[i]) > biggestnum - 10 then
                biggestnum = (math.ceil(networkin.incoming[i] / 10) + 1) * 10
                --graphs.incoming.pos.x - 21, graphs.incoming.pos.y - 7,
            end
        end

        local numstr = tostring(biggestnum)
        graphs.incoming.sides[2].Text = numstr
        graphs.incoming.sides[2].Position = Vector2.new(graphs.incoming.pos.x - ((#numstr + 1) * 7), graphs.incoming.pos.y - 7)

        for i = 1, 20 do
            local line = graphs.incoming.graph[i]

            line.From = Vector2.new(
                ((i - 1) * 11) + graphs.incoming.pos.x,
                graphs.incoming.pos.y + 80 - math.floor(networkin.incoming[i] / biggestnum * 80)
            )

            line.To = Vector2.new(
                (i * 11) + graphs.incoming.pos.x,
                graphs.incoming.pos.y + 80 - math.floor(networkin.incoming[i + 1] / biggestnum * 80)
            )
        end

        local avgbar_h = average(networkin.incoming)

        local avg_color = menu:GetVal("Settings", "Cheat Settings", "Menu Accent") and RGB(unpack(menu.mc)) or RGB(59, 214, 28)

        graphs.incoming.graph[21].From = Vector2.new(
            graphs.incoming.pos.x + 1,
            graphs.incoming.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80)
        )
        graphs.incoming.graph[21].To = Vector2.new(
            graphs.incoming.pos.x + 220,
            graphs.incoming.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80)
        )
        graphs.incoming.graph[21].Color = avg_color
        graphs.incoming.graph[21].Thickness = 2

        graphs.incoming.graph[22].Position = Vector2.new(
            graphs.incoming.pos.x + 222,
            graphs.incoming.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80) - 8
        )
        graphs.incoming.graph[22].Text = "avg: " .. tostring(round(avgbar_h, 2))
        graphs.incoming.graph[22].Color = avg_color

        graphs.incoming.sides[1].Text = "incoming kbps: " .. tostring(round(networkin.incoming[21], 2))

        -- outgoing
        local biggestnum = 10
        for i = 1, 21 do
            if math.ceil(networkin.outgoing[i]) > biggestnum - 5 then
                biggestnum = (math.ceil(networkin.outgoing[i] / 5) + 1) * 5
            end
        end

        local numstr = tostring(biggestnum)
        graphs.outgoing.sides[2].Text = numstr
        graphs.outgoing.sides[2].Position = Vector2.new(graphs.outgoing.pos.x - ((#numstr + 1) * 7), graphs.outgoing.pos.y - 7)

        for i = 1, 20 do
            local line = graphs.outgoing.graph[i]

            line.From = Vector2.new(
                ((i - 1) * 11) + graphs.outgoing.pos.x,
                graphs.outgoing.pos.y + 80 - math.floor(networkin.outgoing[i] / biggestnum * 80)
            )

            line.To = Vector2.new(
                (i * 11) + graphs.outgoing.pos.x,
                graphs.outgoing.pos.y + 80 - math.floor(networkin.outgoing[i + 1] / biggestnum * 80)
            )
        end

        local avgbar_h = average(networkin.outgoing)

        graphs.outgoing.graph[21].From = Vector2.new(
            graphs.outgoing.pos.x + 1,
            graphs.outgoing.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80)
        )
        graphs.outgoing.graph[21].To = Vector2.new(
            graphs.outgoing.pos.x + 220,
            graphs.outgoing.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80)
        )
        graphs.outgoing.graph[21].Color = avg_color
        graphs.outgoing.graph[21].Thickness = 2

        graphs.outgoing.graph[22].Position = Vector2.new(
            graphs.outgoing.pos.x + 222,
            graphs.outgoing.pos.y + 80 - math.floor(avgbar_h / biggestnum * 80) - 8
        )
        graphs.outgoing.graph[22].Text = "avg: " .. tostring(round(avgbar_h, 2))
        graphs.outgoing.graph[22].Color = avg_color

        graphs.outgoing.sides[1].Text = "outgoing kbps: " .. tostring(round(networkin.outgoing[21], 2))

        local drawnobjects = 0
        for k, v in pairs(allrender) do
            drawnobjects += #v
        end

        graphs.other[1].Text = string.format(
            "initiation time: %d ms\ndrawn objects: %d\ntick: %d\nfps: %d\nlatency: %d",
            menu.load_time,
            drawnobjects,
            tick(),
            CurrentFPS,
            math.ceil(GetLatency() * 1000)
        )
        lasttick = tick()
        StatMenuRendered:fire(graphs.other[1])

        local logsstr = "[DEBUG LOGS]\n"
        for i, v in ipairs(reverse_table(NotifLogs)) do
            logsstr = logsstr.. v.. "\n"
            if i >= 13 then break end
        end
        graphs.other[2].Text = logsstr
    end
end)

local function keycheck(actionName, inputState, inputObject)
    if actionName == "BB Keycheck" then
        if menu.open then
            if menu.textboxopen then
                if inputObject.KeyCode == Enum.KeyCode.Backspace then
                    if menu.selectall then
                        menu.textboxopen[1] = ""
                        menu.textboxopen[4].Text = "|"
                        menu.textboxopen[4].Color = RGB(unpack(menu.mc))
                        menu.selectall = false
                    end
                    local on = inputState == Enum.UserInputState.Begin
                    menu.backspaceheld = on
                    menu.backspacetime = on and tick() or -1
                    if not on then
                        menu.backspaceflags = 0
                    end
                end

                if inputObject.KeyCode ~= Enum.KeyCode.A and (not inputObject.KeyCode.Name:match("^Left") and not inputObject.KeyCode.Name:match("^Right")) and inputObject.KeyCode ~= Enum.KeyCode.Delete
                then
                    if menu.selectall then
                        menu.textboxopen[4].Color = RGB(unpack(menu.mc))
                        menu.selectall = false
                    end
                end

                if inputObject.KeyCode == Enum.KeyCode.A then
                    if inputState == Enum.UserInputState.Begin and INPUT_SERVICE:IsKeyDown(Enum.KeyCode.LeftControl)
                    then
                        menu.selectall = true
                        local textbox = menu.textboxopen
                        textbox[4].Color = RGB(menu.mc[3], menu.mc[2], menu.mc[1])
                    end
                end

                return Enum.ContextActionResult.Sink
            end
        end

        return Enum.ContextActionResult.Pass
    end
end

game:service("ContextActionService"):BindAction("BB Keycheck", keycheck, false, Enum.UserInputType.Keyboard)

if menu.game == "uni" then --SECTION UNIVERSAL
    menu.activetab = 4

    menu.mousebehavior = Enum.MouseBehavior.Default

    local metatable = getrawmetatable(INPUT_SERVICE)
    local old = metatable.__newindex

    setreadonly(metatable, false)

    metatable.__newindex = newcclosure(function(t, p, v)
        if (not checkcaller()) then
            if (p == "MouseBehavior") then
                menu.mousebehavior = v
                if menu.open then
                    old(t, p, Enum.MouseBehavior.Default)
                    return
                end
            end
        end

        return old(t, p, v)
    end)

    menu.oldmt = {
        __newindex = old,
    }

    setreadonly(metatable, true)

    local allesp = {
        headdotoutline = {},
        headdot = {},
        name = {},
        displayname = {},
        outerbox = {},
        box = {},
        filledbox = {},
        innerbox = {},
        healthouter = {},
        healthinner = {},
        hptext = {},
        distance = {},
        team = {},
    }

    for i = 1, Players.MaxPlayers do
        Draw:FilledRect(false, 20, 20, 20, 20, { 0, 0, 0, 220 }, allesp.filledbox)

        Draw:Circle(false, 20, 20, 10, 3, 10, { 10, 10, 10, 215 }, allesp.headdotoutline)
        Draw:Circle(false, 20, 20, 10, 1, 10, { 255, 255, 255, 255 }, allesp.headdot)

        Draw:OutlinedRect(false, 20, 20, 20, 20, { 0, 0, 0, 220 }, allesp.innerbox)
        Draw:OutlinedRect(false, 20, 20, 20, 20, { 0, 0, 0, 220 }, allesp.outerbox)
        Draw:OutlinedRect(false, 20, 20, 20, 20, { 255, 255, 255, 255 }, allesp.box)

        Draw:FilledRect(false, 20, 20, 4, 20, { 10, 10, 10, 215 }, allesp.healthouter)
        Draw:FilledRect(false, 20, 20, 20, 20, { 255, 255, 255, 255 }, allesp.healthinner)

        Draw:OutlinedText("", 1, false, 20, 20, 13, false, { 255, 255, 255, 255 }, { 0, 0, 0 }, allesp.hptext)
        Draw:OutlinedText("", 2, false, 20, 20, 13, true, { 255, 255, 255, 255 }, { 0, 0, 0 }, allesp.distance)
        Draw:OutlinedText("", 2, false, 20, 20, 13, true, { 255, 255, 255, 255 }, { 0, 0, 0 }, allesp.name)
        Draw:OutlinedText("", 2, false, 20, 20, 13, true, { 255, 255, 255, 255 }, { 0, 0, 0 }, allesp.displayname)
        Draw:OutlinedText("", 2, false, 20, 20, 13, true, { 255, 255, 255, 255 }, { 0, 0, 0 }, allesp.team)
    end

    menu.crosshair = { outline = {}, inner = {} }
    for i, v in pairs(menu.crosshair) do
        for i = 1, 2 do
            Draw:FilledRect(false, 20, 20, 20, 20, { 10, 10, 10, 215 }, v)
        end
    end

    menu.fovcircle = {}
    Draw:Circle(false, 20, 20, 10, 3, 20, { 10, 10, 10, 215 }, menu.fovcircle)
    Draw:Circle(false, 20, 20, 10, 1, 20, { 255, 255, 255, 255 }, menu.fovcircle)

    menu.Initialize({
        {
            name = "Combat",
            content = {
                {
                    name = "Aim Assist",
                    autopos = "left",
                    autofill = true,
                    content = {
                        {
                            type = TOGGLE,
                            name = "Enabled",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.J,
                                toggletype = 1,
                            },
                        },
                        {
                            type = DROPBOX,
                            name = "Use Mouse Keys",
                            value = 1,
                            values = { "Off", "Mouse 1", "Mouse 2" },
                        },
                        {
                            type = TOGGLE,
                            name = "Target Priority Only",
                            value = false,
                        },
                        {
                            type = COMBOBOX,
                            name = "Checks",
                            values = { { "Alive", true }, { "Same Team", false }, { "Distance", false } },
                        },
                        {
                            type = SLIDER,
                            name = "Max Distance",
                            value = 100,
                            minvalue = 30,
                            maxvalue = 500,
                            stradd = "m",
                        },
                        {
                            type = DROPBOX,
                            name = "FOV Calculation",
                            value = 1,
                            values = { "Pixel", "Actual Fov", "Custom FOV" },
                        },
                        {
                            type = SLIDER,
                            name = "Custom FOV Value",
                            value = 60,
                            minvalue = 60,
                            maxvalue = 120,
                            stradd = "°",
                        },
                        {
                            type = SLIDER,
                            name = "Aimbot FOV",
                            value = 0,
                            minvalue = 0,
                            maxvalue = 360,
                            stradd = "°",
                            custom = {
                                [0] = "Unlimited"
                            }
                        },
                        {
                            type = DROPBOX,
                            name = "Hitbox",
                            value = 1,
                            values = { "Head", "Torso" },
                        },
                        {
                            type = TOGGLE,
                            name = "Force Angles In First Person",
                            unsafe = true,
                            value = false,
                        },
                        {
                            type = TOGGLE,
                            name = "Smoothing",
                            value = false,
                        },
                        {
                            type = SLIDER,
                            name = "Smoothing Ammount",
                            value = 0,
                            minvalue = 0,
                            maxvalue = 100,
                            stradd = "%",
                        },
                        -- {
                        --     type = TOGGLE,
                        --     name = "Visibility Check",
                        --     value = false,
                        -- },
                        -- {
                        --     type = COMBOBOX,
                        --     name = "Visibility Check Filters",
                        --     values = { { "Transparent", true }, { "Force Feild", false }, { "Collisionless", false }, { "Thickness", false } },
                        -- },
                        -- {
                        --     type = TOGGLE,
                        --     name = "Auto Shoot",
                        --     value = false,
                        -- },
                    },
                },
                {
                    name = "Trigger Bot",
                    autopos = "right",
                    autofill = true,
                    content = {
                        {
                            -- type = TOGGLE,
                            -- name = "Enabled",
                            -- value = false,
                            -- extra = {
                            --     type = KEYBIND,
                            --     key = Enum.KeyCode.J,
                            --     toggletype = 1,
                            -- },
                        },
                    },
                }
            },
        },
        {
            name = "Visuals",
            content = {
                {
                    name = "Player ESP",
                    autopos = "left",
                    content = {
                        {
                            type = TOGGLE,
                            name = "Name",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Name ESP",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Display Name",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Display Name ESP",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Head Dot",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Head Dot",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Box",
                            value = false,
                            extra = {
                                type = DOUBLE_COLORPICKER,
                                name = { "Box Fill", "Box ESP" },
                                color = { { 255, 0, 0, 0 }, { 255, 0, 0, 150 } },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Health Bar",
                            value = false,
                            extra = {
                                type = DOUBLE_COLORPICKER,
                                name = { "Low Health", "Max Health" },
                                color = { { 255, 0, 0 }, { 0, 255, 0 } },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Health Number",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Health Number ESP",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Team",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Team ESP",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Team Color Based",
                            value = false,
                        },
                        {
                            type = TOGGLE,
                            name = "Distance",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Distance ESP",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                    },
                },
                {
                    name = "ESP Settings",
                    autopos = "left",
                    autofill = true,
                    content = {
                        -- {
                        --     type = DROPBOX,
                        --     name = "ESP Sorting",
                        --     value = 1,
                        --     values = { "None", "Distance" },
                        -- },
                        {
                            type = COMBOBOX,
                            name = "Checks",
                            values = { { "Alive", true }, { "Same Team", false }, { "Distance", false } },
                        },
                        {
                            type = SLIDER,
                            name = "Max Distance",
                            value = 100,
                            minvalue = 30,
                            maxvalue = 500,
                            stradd = "m",
                        },
                        {
                            type = SLIDER,
                            name = "Max HP Visibility Cap",
                            value = 90,
                            minvalue = 50,
                            maxvalue = 100,
                            stradd = "% hp",
                            custom = {
                                [100] = "Always"
                            }
                        },
                        {
                            type = DROPBOX,
                            name = "Text Case",
                            value = 2,
                            values = { "lowercase", "Normal", "UPPERCASE" },
                        },
                        {
                            type = SLIDER,
                            name = "Max Text Length",
                            value = 0,
                            minvalue = 0,
                            maxvalue = 32,
                            custom = { [0] = "Unlimited" },
                            stradd = " letters",
                        },
                        {
                            type = TOGGLE,
                            name = "Highlight Target",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Aimbot Target",
                                color = { 255, 0, 0, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Highlight Friends",
                            value = true,
                            extra = {
                                type = COLORPICKER,
                                name = "Friended Players",
                                color = { 0, 255, 255, 255 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Highlight Priority",
                            value = true,
                            extra = {
                                type = COLORPICKER,
                                name = "Priority Players",
                                color = { 255, 210, 0, 255 },
                            },
                        },
                    },
                },
                {
                    name = "Local Visuals",
                    autopos = "right",
                    content = {
                        {
                            type = TOGGLE,
                            name = "Change FOV",
                            value = false,
                        },
                        {
                            type = SLIDER,
                            name = "Camera FOV",
                            value = 60,
                            minvalue = 60,
                            maxvalue = 120,
                            stradd = "°",
                        },
                    },
                },
                {
                    name = "World Visuals",
                    autopos = "right",
                    content = {
                        {
                            type = TOGGLE,
                            name = "Force Time",
                            value = false,
                            --tooltip = "Forces the time to the time set by your below.",
                        },
                        {
                            type = SLIDER,
                            name = "Custom Time",
                            value = 0,
                            minvalue = 0,
                            maxvalue = 24,
                            decimal = 0.1,
                            stradd = "hr",
                        },
                    }
                },
                {
                    name = "Misc",
                    autopos = "right",
                    autofill = true,
                    content = {
                        {
                            type = TOGGLE,
                            name = "Custom Crosshair",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Crosshair Color",
                                color = { 255, 255, 255, 255 },
                            },
                        },

                        {
                            type = DROPBOX,
                            name = "Crosshair Position",
                            value = 1,
                            values = { "Center Of Screen", "Mouse" },
                        },
                        {
                            type = SLIDER,
                            name = "Crosshair Size",
                            value = 10,
                            minvalue = 5,
                            maxvalue = 15,
                            stradd = "px",
                        },
                        {
                            type = TOGGLE,
                            name = "Draw Aimbot FOV",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Aimbot FOV Circle Color",
                                color = { 255, 255, 255, 255 },
                            },
                        },
                    },
                },
            },
        },
        {
            name = "Misc",
            content = {
                {
                    name = "Movement",
                    autopos = "left",
                    autofill = true,
                    content = {
                        {
                            type = TOGGLE,
                            name = "Speed",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.LeftShift,
                                toggletype = 1,
                            },
                        },
                        {
                            type = SLIDER,
                            name = "Speed Factor",
                            value = 40,
                            minvalue = 1,
                            maxvalue = 200,
                            stradd = " stud/s",
                        },
                        {
                            type = DROPBOX,
                            name = "Speed Method",
                            value = 1,
                            values = { "Velocity", "Walk Speed" },
                        },
                        -- {
                        --     type = COMBOBOX,
                        --     name = COMBOBOX,
                        --     values = {{"Head", true}, {"Body", true}, {"Arms", false}, {"Legs", false}}
                        -- },
                        {
                            type = TOGGLE,
                            name = "Fly",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.B,
                            },
                        },
                        {
                            type = DROPBOX,
                            name = "Fly Method",
                            value = 1,
                            values = { "Velocity", "Noclip" },
                        },
                        {
                            type = SLIDER,
                            name = "Fly Speed",
                            value = 40,
                            minvalue = 1,
                            maxvalue = 200,
                            stradd = " stud/s",
                        },
                        {
                            type = TOGGLE,
                            name = "Mouse Teleport",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.Q,
                                toggletype = 0
                            },
                        },
                    },
                },
                {
                    name = "Exploits",
                    autopos = "right",
                    autofill = true,
                    content = {
                        {
                            type = TOGGLE,
                            name = "Enable Timer Exploits",
                            unsafe = true,
                            value = false,
                        },
                        {
                            type = TOGGLE,
                            name = "Timer",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.E,
                            },
                        },
                        {
                            type = SLIDER,
                            name = "Timer Factor",
                            value = 20,
                            minvalue = 1,
                            maxvalue = 1000,
                            stradd = "ms",
                        },
                        {
                            type = TOGGLE,
                            name = "Instant Tick Shift",
                            value = false,
                            extra = {
                                type = KEYBIND,
                                key = Enum.KeyCode.R,
                                toggletype = 0,
                            },
                        },
                        {
                            type = SLIDER,
                            name = "Instant Tick Shift Delay",
                            value = 0,
                            minvalue = 0,
                            maxvalue = 30,
                            stradd = "s",
                            custom = {
                                [0] = "Off"
                            }
                        },
                        {
                            type = SLIDER,
                            name = "Instant Tick Shift Factor",
                            value = 5,
                            minvalue = 1,
                            maxvalue = 30,
                            stradd = "s",
                        },
                    },
                },
            },
        },
        {
            name = "Settings",
            content = {
                {
                    name = "Player List",
                    x = menu.columns.left,
                    y = 66,
                    width = menuWidth - 34, -- this does nothing?
                    height = 328,
                    content = {
                        {
                            type = "list",
                            name = "Players",
                            multiname = { "Name", "Team", "Status" },
                            size = 9,
                            columns = 3,
                        },
                        {
                            type = IMAGE,
                            name = "Player Info",
                            text = "No Player Selected",
                            size = 72,
                        },
                        {
                            type = DROPBOX,
                            name = "Player Status",
                            x = 307,
                            y = 314,
                            w = 160,
                            value = 1,
                            values = { "None", "Friend", "Priority" },
                        },
                        {
                            type = BUTTON,
                            name = "Teleport",
                            doubleclick = true,
                            x = 307,
                            y = 356,
                            w = 160
                        },
                    },
                },
                {
                    name = "Cheat Settings",
                    x = menu.columns.left,
                    y = 400,
                    width = menu.columns.width,
                    height = 182,
                    content = {
                        {
                            type = TOGGLE,
                            name = "Menu Accent",
                            value = false,
                            extra = {
                                type = COLORPICKER,
                                name = "Accent Color",
                                color = { 127, 72, 163 },
                            },
                        },
                        {
                            type = TOGGLE,
                            name = "Watermark",
                            value = true,
                        },
                        {
                            type = TOGGLE,
                            name = "Custom Menu Name",
                            value = MenuName and true or false,
                        },
                        {
                            type = TEXTBOX,
                            name = "MenuName",
                            text = MenuName or "Bitch Bot",
                        },
                        {
                            type = BUTTON,
                            name = "Set Clipboard Game ID",
                        },
                        {
                            type = BUTTON,
                            name = "Unload Cheat",
                            doubleclick = true,
                        },
                        {
                            type = TOGGLE,
                            name = "Allow Unsafe Features",
                            value = false,
                        },
                    },
                },
                {
                    name = "Configuration",
                    x = menu.columns.right,
                    y = 400,
                    width = menu.columns.width,
                    height = 182,
                    content = {
                        {
                            type = TEXTBOX,
                            name = "ConfigName",
                            file = true,
                            text = "",
                        },
                        {
                            type = DROPBOX,
                            name = "Configs",
                            value = 1,
                            values = GetConfigs(),
                        },
                        {
                            type = BUTTON,
                            name = "Load Config",
                            doubleclick = true,
                        },
                        {
                            type = BUTTON,
                            name = "Save Config",
                            doubleclick = true,
                        },
                        {
                            type = BUTTON,
                            name = "Delete Config",
                            doubleclick = true,
                        },
                    },
                },
            },
        },
    })

    local plistinfo = menu.options["Settings"]["Player List"]["Player Info"][1]
    local plist = menu.options["Settings"]["Player List"]["Players"]
    local function updateplist()
        if menu == nil then
            return
        end
        local playerlistval = menu:GetVal("Settings", "Player List", "Players")
        local playerz = {}

        for i, team in pairs(TEAMS:GetTeams()) do
            local sorted_players = {}
            for i1, player in pairs(team:GetPlayers()) do
                table.insert(sorted_players, player.Name)
            end
            table.sort(sorted_players)
            for i1, player_name in pairs(sorted_players) do
                table.insert(playerz, Players:FindFirstChild(player_name))
            end
        end

        local sorted_players = {}
        for i, player in pairs(Players:GetPlayers()) do
            if player.Team == nil then
                table.insert(sorted_players, player.Name)
            end
        end
        table.sort(sorted_players)
        for i, player_name in pairs(sorted_players) do
            table.insert(playerz, Players:FindFirstChild(player_name))
        end
        sorted_players = nil

        local templist = {}
        for k, v in pairs(playerz) do
            local playername = { v.Name, RGB(255, 255, 255) }
            local teamtext = { "None", RGB(255, 255, 255) }
            local playerstatus = { "None", RGB(255, 255, 255) }
            if v.Team ~= nil then
                teamtext[1] = v.Team.Name
                teamtext[2] = v.TeamColor.Color
            end
            if v == LOCAL_PLAYER then
                playerstatus[1] = "Local Player"
                playerstatus[2] = RGB(66, 135, 245)
            elseif table.find(menu.friends, v.Name) then
                playerstatus[1] = "Friend"
                playerstatus[2] = RGB(0, 255, 0)
            elseif table.find(menu.priority, v.Name) then
                playerstatus[1] = "Priority"
                playerstatus[2] = RGB(255, 210, 0)
            end

            table.insert(templist, { playername, teamtext, playerstatus })
        end
        plist[5] = templist
        if playerlistval ~= nil then
            for i, v in ipairs(playerz) do
                if v.Name == playerlistval then
                    selectedPlayer = v
                    break
                end
                if i == #playerz then
                    selectedPlayer = nil
                    menu.list.setval(plist, nil)
                end
            end
        end
        menu:SetMenuPos(menu.x, menu.y)
    end

    local function setplistinfo(player, textonly)
        if not menu then
            return
        end
        if player ~= nil then
            local playerteam = "None"
            if player.Team ~= nil then
                playerteam = player.Team.Name
            end
            local playerhealth = "?"

            if player.Character ~= nil then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid ~= nil then
                    if humanoid.Health ~= nil then
                        playerhealth = tostring(humanoid.Health) .. "/" .. tostring(humanoid.MaxHealth)
                    else
                        playerhealth = "No health found"
                    end
                else
                    playerhealth = "Humanoid not found"
                end
            end

            plistinfo[1].Text = "Display Name: " .. player.DisplayName .. "\nName: ".. player.Name .. "\nTeam: " .. playerteam .. "\nHealth: " .. playerhealth

            if textonly == nil then
                plistinfo[2].Data = BBOT_IMAGES[5]
                plistinfo[2].Data = game:HttpGet(string.format(
                    "https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=100&height=100&format=png",
                    player.UserId
                ))
            end
        else
            plistinfo[2].Data = BBOT_IMAGES[5]
            plistinfo[1].Text = "No Player Selected"
        end
    end

    menu.list.removeall(menu.options["Settings"]["Player List"]["Players"])
    updateplist()
    setplistinfo(nil)

    menu.tickbase_manip_added = false
    menu.tickbaseadd = 0
end

do
    local wm = menu.watermark
    wm.textString = " | " .. BBOT.username .. " | " .. os.date("%b. %d, %Y")
    wm.pos = Vector2.new(50, 9)
    wm.text = {}
    local fulltext = menu.options["Settings"]["Cheat Settings"]["MenuName"][1] .. wm.textString
    wm.width = #fulltext * 7 + 10
    wm.height = 19
    wm.rect = {}

    Draw:FilledRect(
        false,
        wm.pos.x,
        wm.pos.y + 1,
        wm.width,
        2,
        { menu.mc[1] - 40, menu.mc[2] - 40, menu.mc[3] - 40, 255 },
        wm.rect
    )
    Draw:FilledRect(false, wm.pos.x, wm.pos.y, wm.width, 2, { menu.mc[1], menu.mc[2], menu.mc[3], 255 }, wm.rect)
    Draw:FilledRect(false, wm.pos.x, wm.pos.y + 3, wm.width, wm.height - 5, { 50, 50, 50, 255 }, wm.rect)
    for i = 0, wm.height - 4 do
        Draw:FilledRect(
            false,
            wm.pos.x,
            wm.pos.y + 3 + i,
            wm.width,
            1,
            { 50 - i * 1.7, 50 - i * 1.7, 50 - i * 1.7, 255 },
            wm.rect
        )
    end
    Draw:OutlinedRect(false, wm.pos.x, wm.pos.y, wm.width, wm.height, { 0, 0, 0, 255 }, wm.rect)
    Draw:OutlinedRect(false, wm.pos.x - 1, wm.pos.y - 1, wm.width + 2, wm.height + 2, { 0, 0, 0, 255 * 0.4 }, wm.rect)
    Draw:OutlinedText(
        fulltext,
        2,
        false,
        wm.pos.x + 5,
        wm.pos.y + 3,
        13,
        false,
        { 255, 255, 255, 255 },
        { 0, 0, 0, 255 },
        wm.text
    )
end

--ANCHOR watermak
for k, v in pairs(menu.watermark.rect) do
    v.Visible = true
end

menu.watermark.text[1].Visible = true

local textbox = menu.options["Settings"]["Configuration"]["ConfigName"]
local relconfigs = GetConfigs()
textbox[1] = relconfigs[menu.options["Settings"]["Configuration"]["Configs"][1]]
textbox[4].Text = textbox[1]

menu.load_time = math.floor((tick() - loadstart) * 1000)

CreateNotification(string.format("Done loading the " .. menu.game .. " cheat. (%d ms)", menu.load_time))
CreateNotification("Press DELETE to open and close the menu!")

CreateThread(function()
    local x = loadingthing.Position.x

    for i = 1, 20 do
        loadingthing.Transparency = 1-i/20
        loadingthing.Position -= Vector2.new(x/10, 0)
        wait()
    end

    loadingthing.Visible = false -- i do it this way because otherwise it would fuck up the Draw:UnRender function, it doesnt cause any lag sooooo
end)
if not menu.open then
    menu.fading = true
    menu.fadestart = tick()
end

menu.Initialize = nil -- let me freeeeee
_G.CreateNotification = CreateNotification
