local Fonts = {
    ["Verdana"] = 0,
    ["Smallest Pixel-7"] = 1,
    ["Proggy"] = 2,
    ["Minecraftia"] = 3,
    ["Verdana Bold"] = 4,
    ["Tahoma"] = 5,
    ["Tahoma Bold"] = 6
}


-- define random utils 
local BLRayParams = RaycastParams.new()
BLRayParams.FilterDescendantsInstances = { Camera, workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Ignored"), workspace:FindFirstChild("ignored"), workspace:FindFirstChild("ignore"), workspace:FindFirstChild("Debris"), workspace:FindFirstChild("debris") }
BLRayParams.FilterType = Enum.RaycastFilterType.Exclude
BLRayParams.IgnoreWater = true
Utility.Blacklist = BLRayParams 
function Utility:New(type, props, secondarg)
    local IsDrawing = tablefind(Utility.DrawingTypes, type)
    local NewFunction = IsDrawing and Drawingnew or Instancenew
    
    local Object = NewFunction(type, secondarg)
    if props then
        for _,v in props do
            Object[_] = v
        end
    end
    if IsDrawing then
        Utility.Drawings[#Utility.Drawings + 1] = Object
    else
        Utility.Objects[#Utility.Objects + 1] = Object
    end
    return Object
end
function Utility:Connect(signal, func, name)
    name = name or "Undefined"
    local Connection; Connection = signal:Connect(function(...)
        local Args = {...}
        local Success, Message = pcall(function() coroutinewrap(func)(unpack(Args)) end)
        if not Success and not Utility.Errors[Message] then
            warn(('ERROR!!!\nAn error has occurred with the message:\n%s\nSignal Type: %s\nName: %s'):format(Message, tostring(signal), name))
            if Library.Notify then
                Library:Notify({
                    Text =('<font color="rgb(255, 0, 0)">ERROR!!! </font>\nAn error has occurred with the message:\n%s\nSignal Type: %s\nName: %s'):format(Message, tostring(signal), name),
                    Time = 5000,
                    Type = "Warning",
                    Animation = "Bounce",
                })
            end
            Utility.Errors[Message] = Message
            
            if Utility.Connections[Connection] then
                Utility.Connections[Connection] = nil
            end
            return Connection:Disconnect()
        end
    end)
    if Connection then
        tableinsert(Utility.Connections, Connection)
    end
    
    return Connection
end
function Utility:BindToRenderStep(name, enum, callback)
    RunService:BindToRenderStep(name, enum, callback)
    Utility.BindToRenderSteps[name] = name
end 
function Utility:CFrameToVector3(cframe)
    return Vector3new(cframe.X, cframe.Y, cframe.Z)
end
function Utility:Lerp(a, b, c)
    c = c or 1 / 8
    
    local offset = mathabs(b - a)
    if (offset < c) then 
        return b 
    end 
    return a + (b - a) * c
end
function Utility:Round(number, float)
    local multiplier = 1 / (float or 1)
    return mathfloor(number * multiplier + 0.5) / multiplier
end
function Utility:CalculateVelocity(Part, Type)
    if not Type then 
        return Part.Velocity; 
    else 
        local OldPosition = Part.Position
        local OldTime = tick()

        taskwait()

        local NewPosition = Part.Position
        local NewTime = tick()

        local DistanceTraveled = NewPosition - OldPosition

        local TimeInterval = NewTime - OldTime

        local Velocity = DistanceTraveled / TimeInterval

        return Velocity
    end
end
function Utility:ConvertToEnum(Value)
    local enumParts = {}
    for part in string.gmatch(Value, "[%w_]+") do
        tableinsert(enumParts, part)
    end
    local enumTable = Enum
    for i = 2, #enumParts do
        local enumItem = enumTable[enumParts[i]]
        enumTable = enumItem
    end
    return enumTable
end
function Utility:GetRotate(Vec, Rads)
    local vec = Vec.Unit
    local sin = mathsin(Rads)
    local cos = mathcos(Rads)
    local x = (cos * vec.x) - (sin * vec.y)
    local y = (sin * vec.x) + (cos * vec.y)
    return Vector2new(x, y).Unit * Vec.Magnitude
end
function Utility:MouseOver(object)
    local posX, posY = object.AbsolutePosition.X, object.AbsolutePosition.Y
    local size = object.AbsoluteSize
    local sizeX, sizeY = posX + size.X, posY + size.Y
    local position = UserInputService:GetMouseLocation() - Vector2new(0, 38)
    if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
        return true
    end
    return false
end
function Utility:CreateBulletTracer(origin, endpos, color, trans, time, decal)
    local Decal = Visuals.BulletTracers[decal] or "rbxassetid://446111271"
    local OriginAttachment = Utility:New("Attachment", {
        Position = origin,
        Parent = workspace.Terrain
    })
    local EndAttachment = Utility:New("Attachment", {
        Position = endpos,
        Parent = workspace.Terrain
    })
    
    local Beam = Utility:New("Beam", {
        Texture = Decal,
        LightEmission = 1,
        LightInfluence = 0,
        TextureSpeed = 10,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(1, color)
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, trans),
            NumberSequenceKeypoint.new(1, trans),
        }),
        Width0 = 1.2,
        Width1 = 1.2,
        Attachment0 = OriginAttachment,
        Attachment1 = EndAttachment,
        Enabled = true,
        Parent = Workspace.Terrain
    })
    Debris:AddItem(OriginAttachment, time)
    Debris:AddItem(EndAttachment, time)
    Debris:AddItem(Beam, time)
end
function Utility:PlaySound(id, volume, pitch)	
	local Sound = Utility:New("Sound", {
		Parent = Camera,
		Volume = volume / 100,
		Pitch = pitch / 100,
		SoundId = id,
		PlayOnRemove = true
	}):Destroy()
end
function Utility:GetPrediction(ping, distance)
    local PingTable = distance <= 37 and Misc.Prediction.Close or distance <= 68 and Misc.Prediction.Mid or distance <= 9e9 and Misc.Prediction.Far

    if ping <= 30 then
        return PingTable[30]
    elseif ping <= 40 then
        return PingTable[40]
    elseif ping <= 50 then
        return PingTable[50]
    elseif ping <= 60 then
        return PingTable[60]
    elseif ping <= 80 then
        return PingTable[80]
    elseif ping <= 90 then
        return PingTable[90]
    elseif ping <= 120 then
        return PingTable[120]
    elseif ping <= 140 then
        return PingTable[140]
    elseif ping <= 200 then
        return PingTable[200]
    end
end
function Utility:Line(obj, from, to)
    local direction = (to - from)
    local center = (to + from) / 2
    local distance = direction.Magnitude
    local theta = math.deg(math.atan2(direction.Y, direction.X))
    obj.Position = UDim2new(0, math.floor(center.X), 0, math.floor(center.Y))
    obj.Rotation = theta
    obj.Size = UDim2new(0, math.floor(distance), 0, 1)
end
function Utility.GetFiles(folder, extensions)
    local LibraryFolder = Library.Folder .. "/" .. folder .. "/"
    if not isfolder(LibraryFolder) then
        makefolder(LibraryFolder)
    end
    local Files = isfolder(LibraryFolder) and listfiles(LibraryFolder) or {}
    local StoredFiles = {}
    local FileNames = {}
    for _,v in Files do
        for _,ext in extensions do
            if v:find(ext) then
                StoredFiles[#StoredFiles + 1] = v
                FileNames[#FileNames + 1] = v:gsub(LibraryFolder, ""):gsub(ext, "")
            end
        end
    end

    return StoredFiles, FileNames
end
-- Functions to change for multi-game support.
    function Utility:GetTeam(player)
        return IsA(player, "Player") and player.Team or nil
    end
    function Utility:GetCharacter(player)
        return player.Character or nil
    end
    function Utility:GetHumanoid(character)
        return FindFirstChildWhichIsA(character, "Humanoid")
    end
    function Utility:GetRootPart(character, humanoid)
        return FindFirstChild(character, "HumanoidRootPart") or humanoid and humanoid.RootPart or character.PrimaryPart or nil
    end
    function Utility:GetPlayers()
        return Players:GetPlayers()
    end
    function Utility:GetName(player)
        return player.Name
    end
    function Utility:GetStyleName(player)
        return player.Name
    end
    function Utility:GetHealth(plr, humanoid)
        return humanoid and humanoid.Health or 100, humanoid and humanoid.MaxHealth or 100
    end
    function Utility:GetBodyPart(character, name)
        return name == "HumanoidRootPart" and Utility:GetRootPart(character, nil) or FindFirstChild(character, name)
    end
    local RigParts = {
        ["Left Arm"] = "LeftLowerArm",
        ["Right Arm"] = "RightLowerArm",
        ["Left Leg"] = "LeftLowerLeg",
        ["Right Leg"] = "RightLowerLeg"
    }
    function Utility:GetPart(character, name)
        return FindFirstChild(character, name) or RigParts[name] and FindFirstChild(character, RigParts[name]) or nil
    end
    function Utility:GetLocalPlayerCharacter()
        return Utility:GetCharacter(LocalPlayer)
    end
    function Utility:GetToolName(player, character)
        local Tool = FindFirstChildWhichIsA(character, "Tool")
        return Tool and Tool.Name
    end
    function Utility:GetRootPart(character, humanoid)
        local BodyEffects = FindFirstChild(character, "BodyEffects")
        local Knocked = BodyEffects and FindFirstChild(BodyEffects, "K.O")
        local KnockedValue = Knocked and Knocked.Value or false
        return KnockedValue and FindFirstChild(character, "LowerTorso") or FindFirstChild(character, "HumanoidRootPart") or humanoid and humanoid.RootPart or character.PrimaryPart or nil
    end
--

-- generic unloading
function Utility:Unload()
    for _,v in Utility.Connections do
        v:Disconnect()
    end
    for _,v in Utility.BindToRenderSteps do
        RunService:UnbindFromRenderStep(v)
    end
    for _,v in Utility.Objects do
        v:Destroy()
    end
    
    for _,v in Utility.Drawings do
        if v and v.Remove then
            v:Remove()
        end
    end
end

Library.__index = Library
if not isfolder(Library.Folder) then
    makefolder(Library.Folder)
end
if not isfolder(Library.Folder .. "/Configs") then
    makefolder(Library.Folder .. "/Configs")
end
if not isfolder(Library.Folder .. "/Images") then
    makefolder(Library.Folder .. "/Images")
end
if not isfile(Library.Folder .. "/Chat-Spam.txt") then
    writefile(Library.Folder .. "/Chat-Spam.txt", "Hey change your chatspam!\nWoah, this guy didn't change his chatspam >_<.\nJust change your chatspam.")
end
Library.Font = GetFontFromIndex(2)
Library.FontSize = 12
Library.ScreenGui = Utility:New("ScreenGui", {
    Name = "\0",
    Parent = CoreGui,
})
Library.Popups = Utility:New("ScreenGui",{
    Name = "\0",
    Parent = CoreGui
})
Library.ListsGui = Utility:New("ScreenGui", {
    Name = "\0",
    Parent = CoreGui
})
--[[
    Toggle - Done,
    Slider - Done,
    Button - Done,
    Dropdown - Done,
    Keybind - Done,
    Colorpicker - Not Done,
    List - Not Done,
    Textbox - Done
]]--
function Library:CreateSelects(position)
    local Selectables = {}
    -- Keybind Mode
        local KeybindMode = {
            Flag = ""
        }
        
        local KeybindModeOutline = Library:New("Frame", {
            Name = "KeybindModeOutline",
            Visible = false,
            Parent = Library.Popups,
            BorderSizePixel = 0,
            Position = UDim2new(0, 500, 0, 500),
            Size = UDim2new(0, 200, 0, 46),
        })
        KeybindMode.Holder = KeybindModeOutline
        KeybindModeOutline.Active = true
        KeybindModeOutline.Draggable = true
        Library:AddTheme(KeybindModeOutline, {
            BackgroundColor3 = "Outline",
        })
        local KeybindModeBackground = Library:New("Frame", {
            Name = "KeybindModeBackground",
            Parent = KeybindModeOutline,
            BorderSizePixel = 0,
            Position = UDim2new(0, 1, 0, 1),
            Size = UDim2new(1, -2, 1, -2),
        })
        Library:AddTheme(KeybindModeBackground, {
            BackgroundColor3 = "Background",
        })
        local KeybindModeDropdownHolder = Library:New("Frame", {
            Name = "KeybindModeBackground",
            Parent = KeybindModeOutline,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2new(0, 5, 0, 5),
            Size = UDim2new(1, -10, 1, -10),
        })
        local KeybindModeDropdown; KeybindModeDropdown = Library.Dropdown({Holder = KeybindModeDropdownHolder, ContentHolder = Library.Popups}, {Name = "Keybind Mode", Values = {"Toggle", "Hold", "Always"}, Ignore = true, Callback = function(v)
            local ConfigFlag = Library.ConfigFlags[KeybindMode.Flag]
            if ConfigFlag then
                KeybindModeDropdown.Show(false)
                ConfigFlag.Set(v)
                KeybindModeOutline.Visible = false
                KeybindMode.Flag = ""
            end
        end})
        KeybindMode.Dropdown = KeybindModeDropdown
        Selectables.KeybindMode = KeybindMode
    --
    
    -- Colorpicker
        local Colorpicker = {
            Transparency = 0,
            Color = Color3fromRGB(255, 255, 255),
            HuePosition = 0,
            SlidingSaturation = false,
            SlidingHue = false,
            SlidingAlpha = false,
            Flag = ""
        }
        local ColorpickerWindow = Library:Window({
            Name = "Colorpicker Window",
            Size = Vector2new(230, 281),
            Selects = false,
            Holder = Library.Popups,
            Position = UDim2new(0, position.x - 235, 0, position.y)
        })
        --ColorpickerWindow.OutlineHolder.Visible = false
        Colorpicker.Window = ColorpickerWindow
        -- Picker Tab
            local PickerTab = ColorpickerWindow:Tab({
                Name = "Picker"
            })
            local Hue, Sat, Val
            local ColorpickerHolder = Library:New("Frame", {
                Name = "ColorpickerHolder",
                Parent = PickerTab.Page,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2new(0, 0, 0, 0),
                Size = UDim2new(1, 0, 1, 0),
            })
            -- Saturation
                local ColorpickerSaturationOutline = Library:New("Frame", {
                    Name = "ColorpickerSaturationOutline",
                    Parent = ColorpickerHolder,
                    BackgroundColor3 = Color3fromRGB(0, 0, 0),
                    BorderColor3 = Color3fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    Size = UDim2new(1, -24, 1, -24),
                })
                Library:AddTheme(ColorpickerSaturationOutline, {
                    BackgroundColor3 = "Outline",
                })
                
                local ColorpickerSaturationBackground = Library:New("Frame", {
                    Name = "ColorpickerSaturationBackground",
                    Parent = ColorpickerSaturationOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 1),
                    Size = UDim2new(1, -2, 1, -2),
                })
                
                Library:New("ImageLabel", {
                    Name = "ColorpickerSaturationImage",
                    Parent = ColorpickerSaturationBackground,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2new(1, 0, 1, 0),
                    Image = Library.Images.Saturation,
                })
                local ColorpickerSaturationPickerOutline = Library:New("Frame", {
                    Name = "ColorpickerSaturationPickerOutline",
                    Parent = ColorpickerSaturationBackground,
                    BorderSizePixel = 0,
                    Size = UDim2new(0, 4, 0, 4),
                })
                
                Library:AddTheme(ColorpickerSaturationPickerOutline, {
                    BackgroundColor3 = "Outline",
                })
                Library:New("Frame", {
                    Name = "ColorpickerSaturationPickerBackground",
                    Parent = ColorpickerSaturationPickerOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 1),
                    Size = UDim2new(1, -2, 1, -2),
                })
                local ColorpickerSaturationButton = Library:New("TextButton", {
                    Parent = ColorpickerSaturationBackground,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    TextSize = 1,
                })
            --
            -- Alpha
                local ColorpickerAlphaOutline = Library:New("Frame", {
                    Name = "ColorpickerAlphaOutline",
                    Parent = ColorpickerHolder,
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 0, 1, -20),
                    Size = UDim2new(1, -24, 0, 20),
                })
                Library:AddTheme(ColorpickerAlphaOutline, {
                    BackgroundColor3 = "Outline",
                })
                local ColorpickerAlphaImage = Library:New("ImageLabel", {
                    Name = "ColorpickerAlphaImage",
                    Parent = ColorpickerAlphaOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 1),
                    Size = UDim2new(1, -2, 1, -2),
                    Image = Library.Images.Checkers,
                    ScaleType = Enum.ScaleType.Tile,
                    TileSize = UDim2new(0, 6, 0, 6),
                })
                local ColorpickerAlphaBackground = Library:New("Frame", {
                    Name = "ColorpickerAlphaBackground",
                    Parent = ColorpickerAlphaImage,
                    BackgroundTransparency = 0,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 0, 0, 0),
                    Size = UDim2new(1, 0, 1, 0),
                })
                local ColorpickerAlphaGradient = Library:New("UIGradient", {
                    Parent = ColorpickerAlphaBackground,
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                })
                
                local ColorpickerAlphaPickerOutline = Library:New("Frame", {
                    Name = "ColorpickerAlphaPickerOutline",
                    Parent = ColorpickerAlphaBackground,
                    BorderSizePixel = 0,
                    Size = UDim2new(0, 3, 1, 0),
                })
                Library:AddTheme(ColorpickerAlphaPickerOutline, {
                    BackgroundColor3 = "Outline",
                })
                
                Library:New("Frame", {
                    Name = "ColorpickerAlphaPickerBackground",
                    Parent = ColorpickerAlphaPickerOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 0),
                    Size = UDim2new(1, -2, 1, 0),
                })
                local ColorpickerAlphaButton = Library:New("TextButton", {
                    Parent = ColorpickerAlphaBackground,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    TextSize = 1,
                })
            --
            -- Hue
                local ColorpickerHueOutline = Library:New("Frame", {
                    Name = "ColorpickerHueOutline",
                    Parent = ColorpickerHolder,
                    BorderSizePixel = 0,
                    Position = UDim2new(1, -20, 0, 0),
                    Size = UDim2new(0, 20, 1, -24),
                })
                Library:AddTheme(ColorpickerHueOutline, {
                    BackgroundColor3 = "Outline",
                })
                
                local ColorpickerHueBackground = Library:New("Frame", {
                    Name = "ColorpickerHueBackground",
                    Parent = ColorpickerHueOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 1),
                    Size = UDim2new(1, -2, 1, -2),
                })
                
                Library:New("UIGradient", {
                    Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.33, Color3fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.50, Color3fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.67, Color3fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.83, Color3fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(255, 0, 0))},
                    Rotation = 90,
                    Parent = ColorpickerHueBackground,
                })
                
                local ColorpickerHuePickerOutline = Library:New("Frame", {
                    Name = "ColorpickerHuePickerOutline",
                    Parent = ColorpickerHueBackground,
                    BorderSizePixel = 0,
                    Size = UDim2new(1, 0, 0, 3),
                })
                Library:AddTheme(ColorpickerHuePickerOutline, {
                    BackgroundColor3 = "Outline",
                })
                
                Library:New("Frame", {
                    Name = "ColorpickerHuePickerBackground",
                    Parent = ColorpickerHuePickerOutline,
                    BackgroundColor3 = Color3fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 0, 0, 1),
                    Size = UDim2new(1, 0, 1, -2),
                })
                local ColorpickerHueButton = Library:New("TextButton", {
                    Parent = ColorpickerHueBackground,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    TextSize = 1,
                })
            --
            -- Color Value
                local ColorpickerOutline = Library:New("Frame", {
                    Name = "ColorpickerOutline",
                    Parent = ColorpickerHolder,
                    BorderSizePixel = 0,
                    Position = UDim2new(1, -20, 1, -20),
                    Size = UDim2new(0, 20, 0, 20),
                })
        
                Library:AddTheme(ColorpickerOutline, {
                    BackgroundColor3 = "Outline"
                })
                
                local ColorpickerBackground = Library:New("Frame", {
                    Name = "ColorpickerBackground",
                    Parent = ColorpickerOutline,
                    BorderSizePixel = 0,
                    Position = UDim2new(0, 1, 0, 1),
                    Size = UDim2new(1, -2, 1, -2),
                })
                
                Library:New("UIGradient", {
                    Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(149, 149, 149))},
                    Rotation = 90,
                    Parent = ColorpickerBackground,
                })
            --
            function Colorpicker.Set(color, transparency, ignore)
                transparency = transparency or Colorpicker.Transparency
                
                if type(color) == "table" then
                    transparency = color.a
                    color = color.c
                end
                Hue, Sat, Val = color:ToHSV()
                Colorpicker.Color = color
                Colorpicker.Transparency = transparency
                if not ignore then
                    ColorpickerSaturationPickerOutline.Position = UDim2new(
                        mathclamp(Sat, 0, 1),
                        Sat < 1 and -1 or -3,
                        mathclamp(1 - Val, 0, 1),
                        1 - Val < 1 and -1 or -3
                    )               
                    Colorpicker.HuePosition = Hue
                    ColorpickerHuePickerOutline.Position = UDim2new(
                        0,
                        0,
                        mathclamp(1 - Hue, 0, 1),
                        1 - Hue < 1 and -1 or -2
                    )    
                    ColorpickerAlphaPickerOutline.Position = UDim2new(
                        mathclamp(transparency, 0, 1),
                        transparency < 1 and -1 or -2,
                        0,
                        0
                    )     
                end
                if Library.ConfigFlags[Colorpicker.Flag] then
                    Library.ConfigFlags[Colorpicker.Flag].Set({
                        c = color,
                        a = transparency
                    })
                end
                ColorpickerAlphaBackground.BackgroundColor3 = color
                ColorpickerSaturationBackground.BackgroundColor3 = Color3fromHSV(Colorpicker.HuePosition, 1, 1)
                ColorpickerBackground.BackgroundColor3 = color
            end
            function Colorpicker.SlideSaturation(input)
                local SizeX = mathclamp((input.Position.X - ColorpickerSaturationOutline.AbsolutePosition.X) / ColorpickerSaturationOutline.AbsoluteSize.X, 0, 1)
                local SizeY = 1 - mathclamp((input.Position.Y - ColorpickerSaturationOutline.AbsolutePosition.Y) / ColorpickerSaturationOutline.AbsoluteSize.Y, 0, 1)
                
                ColorpickerSaturationPickerOutline.Position = UDim2new(SizeX, SizeX < 1 and -1 or -3, 1 - SizeY, 1 - SizeY < 1 and -1 or -3)
                Colorpicker.Set(Color3fromHSV(Colorpicker.HuePosition, SizeX, SizeY), Colorpicker.Transparency, true)
            end
            Utility:Connect(ColorpickerSaturationButton.MouseButton1Down, function()
                Colorpicker.SlidingSaturation = true
                Colorpicker.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
            end)

            function Colorpicker.SlideHue(input)
                local SizeY = 1 - mathclamp((input.Position.Y - ColorpickerHueOutline.AbsolutePosition.Y) / ColorpickerHueOutline.AbsoluteSize.Y, 0, 1)
                
                ColorpickerHuePickerOutline.Position = UDim2new(0, 0, 1 - SizeY, 1 - SizeY < 1 and -1 or -2)
                Colorpicker.HuePosition = SizeY
            
                Colorpicker.Set(Color3fromHSV(SizeY, Sat, Val), Colorpicker.Transparency, true)
            end

            Utility:Connect(ColorpickerHueButton.MouseButton1Down, function()
                Colorpicker.SlidingHue = true
                Colorpicker.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
            end)
            function Colorpicker.SlideAlpha(input)
                local SizeX = mathclamp((input.Position.X - ColorpickerAlphaOutline.AbsolutePosition.X) / ColorpickerAlphaOutline.AbsoluteSize.X, 0, 1)
                
                ColorpickerAlphaPickerOutline.Position = UDim2new(SizeX, SizeX < 1 and -1 or -2, 0, 0)
                Colorpicker.Set(Color3fromHSV(Colorpicker.HuePosition, Sat, Val), SizeX, true)
            end
        
            Utility:Connect(ColorpickerAlphaButton.MouseButton1Down, function()
                Colorpicker.SlidingAlpha = true
                Colorpicker.SlideAlpha({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
            end)

            Utility:Connect(UserInputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Colorpicker.SlidingSaturation, Colorpicker.SlidingHue, Colorpicker.SlidingAlpha = false, false, false
                end
            end)

            Utility:Connect(UserInputService.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    if Colorpicker.SlidingSaturation then
                        Colorpicker.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
                    elseif Colorpicker.SlidingHue then
                        Colorpicker.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
                    elseif Colorpicker.SlidingAlpha then
                        Colorpicker.SlideAlpha({ Position = UserInputService:GetMouseLocation() - Vector2new(0, 38) })
                    end
                end
            end)
            Colorpicker.Set(Colorpicker.Color, Colorpicker.Transparency)
        --
        -- Animation Tab
            -- local AnimationsTab = ColorpickerWindow:Tab({
            --     Name = "Animations"
            -- })
        --
        -- Copying
            local CopyingTab = ColorpickerWindow:Tab({
                Name = "Copying"
            })
            local CopyingHolder = Library:New("Frame", {
                Name = "CopyingHolder",
                Parent = CopyingTab.Page,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2new(0, 0, 0, 0),
                Size = UDim2new(1, 0, 1, 0),
            })
            Library:New("UIListLayout", {
                Parent = CopyingHolder,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDimnew(0, 4),
            })
            
            local ColorBackground
            local ColorAlphaBackground
            local ColorLine = Library:New("Frame", {
                Name = "ColorLine",
                Parent = CopyingHolder,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Position = UDim2new(0, 0, 0, 0),
                Size = UDim2new(1, 0, 0, 103),
            })
            Library:AddTheme(ColorLine, {
                BackgroundColor3 = "Outline",
            })
            ColorBackground = Library:New("Frame", {
                Name = "ColorBackground",
                Parent = ColorLine,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Position = UDim2new(0, 1, 0, 1),
                Size = UDim2new(0.5, -2, 1, -2),
            })
            local ColorBackgroundImage = Library:New("ImageLabel", {
                Name = "ColorBackgroundImage",
                Parent = ColorLine,
                BackgroundColor3 = Color3fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2new(0.5, 1, 0, 1),
                Size = UDim2new(0.5, -2, 1, -2),
                Image = Library.Images.Checkers,
                ScaleType = Enum.ScaleType.Tile,
                TileSize = UDim2new(0, 6, 0, 6),
            })
            ColorAlphaBackground = Library:New("Frame", {
                Name = "ColorBackground",
                Parent = ColorBackgroundImage,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Position = UDim2new(0, 0, 0, 0),
                Size = UDim2new(1, 0, 1, 0),
            })
            local RGBValue
            local HSVValue
            local AlphaValue
            function Colorpicker.UpdateValues()
                local Color = Library.CopiedColor.c
                if RGBValue then
                    RGBValue.ChangeText(("RGB: %s, %s, %s"):format(mathfloor(Color.r * 255), mathfloor(Color.g * 255), mathfloor(Color.b * 255)))
                end
                Hue, Sat, Val = Color:ToHSV()
                if HSVValue then
                    HSVValue.ChangeText(("HSV: %s, %s, %s"):format(tostring(Hue):sub(0, 3), tostring(Sat):sub(0, 3), tostring(Val):sub(0, 3)))
                end
                if AlphaValue then
                    AlphaValue.ChangeText(("Alpha: %s"):format(tostring(Library.CopiedColor.a):sub(0, 3)))
                end
                if ColorBackground then
                    ColorBackground.BackgroundColor3 = Color
                end
                if ColorAlphaBackground then
                    ColorAlphaBackground.BackgroundColor3 = Color
                    ColorAlphaBackground.BackgroundTransparency = 1 - Library.CopiedColor.a
                end
            end
            Library.Button({Holder = CopyingHolder}, {Name = "Copy", Callback = function()
                Library.CopiedColor = {
                    c = Colorpicker.Color,
                    a = Colorpicker.Transparency
                }
                Colorpicker.UpdateValues()
            end})
            Library.Button({Holder = CopyingHolder}, {Name = "Paste", Callback = function()
                Colorpicker.Set(Library.CopiedColor)
            end})
            RGBValue = Library.Label({Holder = CopyingHolder}, {Name = "RGB: "})
            HSVValue = Library.Label({Holder = CopyingHolder}, {Name = "HSV: "})
            AlphaValue = Library.Label({Holder = CopyingHolder}, {Name = "Alpha: "})
            Colorpicker.UpdateValues()
        --
        PickerTab.Select(true)
        Selectables.Colorpicker = Colorpicker
    --
    return Selectables
end
function Library:MakeResizable(Holder, Drag)
    local start, startSize, resizing
    local CurrentSize = Holder.Size
    local OriginalSize = Holder.Size
    Drag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            start = input.Position
            startSize = Holder.Size
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and resizing then
            local viewportWidth = Camera.ViewportSize.X
            local viewportHeight = Camera.ViewportSize.Y
            CurrentSize = UDim2.new(
                startSize.X.Scale,
                mathclamp(
                    startSize.X.Offset + (input.Position.X - start.X),
                    OriginalSize.X.Offset,
                    viewportWidth
                ),
                startSize.Y.Scale,
                mathclamp(
                    startSize.Y.Offset + (input.Position.Y - start.Y),
                    OriginalSize.Y.Offset,
                    viewportHeight
                )
            )
            Holder.Size = CurrentSize
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and resizing then
            resizing = false
        end
    end)
end
function Library:New(type, props, ignore)
    ignore = ignore or false
    local Object = Utility:New(type, props)
    if not ignore then
        Library.Objects[#Library.Objects + 1] = Object
    end
    return Object
end
function Library:AddTheme(obj, props)
    local Data = {
        Instance = obj,
        Properties = props,
        Index = #Library.ThemeInstances + 1
    }
    for _,v in Data.Properties do
        if type(v) == "string" then
            Data.Instance[_] = Library.Theme[v]
        else
            Data.Instance[_] = v()
        end
    end
    table.insert(Library.ThemeInstances, Data)
    Library.ThemeMap[obj] = Data
end
function Library:Tween(obj, info, props)
    info = not info and TweenInfo.new(Library.TweenSpeed, Library.TweenEasingStyle) or info
    local Tween = TweenService:Create(obj, info, props)
    Tween:Play()
    return Tween
end
function Library:ChangeObjectTheme(obj, props, tween)
    if Library.ThemeMap[obj] then
        local Data = Library.ThemeMap[obj]
        Data.Properties = props
        
        for i,v in props do
            if type(v) == "string" then
                if tween then
                    Data.Tween = Library:Tween(Data.Instance, nil, {
                        [i] = Library.Theme[v],
                    })
                else
                    Data.Instance[i] = Library.Theme[v]
                end
            else
                Data.Instance[i] = v()
            end
        end
        Library.ThemeMap[obj] = Data
    end
end
function Library:ChangeTheme(theme, color)
    Library.Theme[theme] = color
    for obj,v in Library.ThemeMap do
        local Properties = v.Properties
        for propName, propTheme in Properties do
            if propTheme == theme then
                if v.Tween then
                    v.Tween:Cancel()
                end
                obj[propName] = color
            end
        end
    end
end
function Library:Notify(cfg)
    cfg = {
        Time = cfg.Time or 5,
        Text = cfg.Text or "this is a test notification.",
        Prefix = cfg.Prefix or "[Puppyware] ",
        Type = cfg.Type or "Normal",
        Animation = cfg.Animation or "None"
    }

    local Notification = {
        Text = cfg.Text,
        Time = cfg.Time,
        ClockTime = osclock() + cfg.Time,
        Prefix = cfg.Prefix,
        Type = cfg.Type,
        Animation = cfg.Animation,
        Direction = 1,
        Lerps = {
            Offset = 1,
            Main = 1,
            Once = 1,
            OffsetOnce = 1,          
            SizeX = 1,
            SizeY = 1,
        }
    }

    local NotificationBackground = Library:New("Frame", {
        Parent = Library.ListsGui,
        BackgroundTransparency = 1,
        Size = UDim2new(0, 0, 0, 0),
        ClipsDescendants = true,
    }, true)

    Library:AddTheme(NotificationBackground, {
        BorderColor3 = "Outline",
        BackgroundColor3 = "Element Background",
    })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = NotificationBackground,
    })

    Notification.Background = NotificationBackground

    local NotificationText = Library:New("TextLabel", {
        BackgroundTransparency = 1,
        TextTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2new(0, 0, 0, 0),
        Position = UDim2new(0, 5, 0, 2),
        FontFace = Library.Font,
        Text = cfg.Prefix .. cfg.Text,
        TextSize = Library.FontSize,
        Parent = NotificationBackground,
        TextStrokeTransparency = 0,
        RichText = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, true)

    Library:AddTheme(NotificationText, {
        TextColor3 = "Text",
    })

    Notification.Lerps.SizeY = NotificationText.TextBounds.Y + 5
    Notification.Lerps.SizeX = NotificationText.TextBounds.X + 8

    Notification.TextObj = NotificationText

    local NotificationAccent = Library:New("Frame", {
        Name = "NotificationAccent",
        Parent = NotificationBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 0),
        Size = UDim2new(0, 1, 1, 0),
    }, true)

    Notification.Accent = NotificationAccent

    local NotificationLine = Library:New("Frame", {
        Name = "NotificationLine",
        Parent = NotificationBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 1, -1),
        Size = UDim2new(0, 0, 0, 1),
    }, true)
    Notification.Line = NotificationLine

    Library.Notifications[#Library.Notifications + 1] = Notification

    return Notification
end
local NotificationPosition = Vector2new(10, 32)
local function Sine(delta)
    return mathsin(halfpi * delta - halfpi) + 1
end
    
Utility:Connect(RunService.Heartbeat, function(step)
    Library.Fps = mathfloor(1 / step)

    local YOffset = 0

    local AccentColor = Library.Theme.Accent
    local ClockPulse = osclock()

    for _,v in Library.Notifications do
        if not v.ClockTime then
            continue
        end

        -- Random Variables
        local Time = v.Time
        local ClockTime = v.ClockTime

        -- Lerps
        local Lerps = v.Lerps

        if ClockPulse >= ClockTime then
            Lerps.Main = Utility:Lerp(Lerps.Main, 0, Library.LerpSpeed)
        else
            Lerps.Main = Utility:Lerp(Lerps.Main, 255, Library.LerpSpeed)
            Lerps.Once = Utility:Lerp(Lerps.Once, 255, Library.LerpSpeed)
            Lerps.OffsetOnce = Utility:Lerp(Lerps.OffsetOnce, 255, Library.LerpSpeed)
        end

        local MainLerp = Lerps.Main
        local MainLerpSine = MainLerp / 255
        local OnceLerpSine = Lerps.Once / 255

        -- Objects
        local Background = v.Background
        local Text = v.TextObj
        local Accent = v.Accent
        local Line = v.Line

        local WarningColor = Color3new(0, mathabs(mathsin(ClockPulse * 3)), 0)

        local PrefixColor = v.Type == "Warning" and WarningColor or AccentColor
        local Prefix = v.Prefix

        Text.Text = (Prefix ~= "" and ('<font color="rgb(%s, %s, %s)">%s</font>'):format(
            mathfloor(PrefixColor.r * 255), 
            mathfloor(PrefixColor.g * 255), 
            mathfloor(PrefixColor.b * 255), 
            v.Prefix
        ) or "") .. v.Text

        local TextBounds = Text.TextBounds

        Lerps.SizeX = Utility:Lerp(Lerps.SizeX, TextBounds.X + 8, Library.LerpSpeed)
        Lerps.SizeY = Utility:Lerp(Lerps.SizeY, TextBounds.Y + 5, Library.LerpSpeed)

        local SizeX = Lerps.SizeX
        local SizeY = Lerps.SizeY

        Background.Size = UDim2new(0, SizeX, 0, SizeY)
        Background.Position = UDim2new(0, NotificationPosition.x, 0, NotificationPosition.y + YOffset) - UDim2new(0, 45 * (1 - OnceLerpSine))

        local Animation = v.Animation

        if Animation == "Bounce" then
            local ClockPulseSine = ClockPulse / 2
        
            local SineValue = 0
    
            if ClockPulseSine <= 0.5 then
                SineValue = 0.5 * Sine(2 * ClockPulseSine)
            else
                SineValue = 0.5 * (1 - Sine(-2 * ClockPulseSine + 2)) + 0.5
            end
            local LineSize = (SizeX / 3) * mathmax(0, 1 - mathabs(SineValue - 0.5) * 2)

            Line.Size = UDim2new(0, LineSize, 0, 1)

            Line.Position = UDim2new(SineValue, 0, 1, -1)
        elseif Animation == "Time" then
            Line.Size = UDim2new(1 - ((ClockTime - ClockPulse) / Time), 0, 0, 1)
        end

        if v.Type == "Warning" then
            Accent.BackgroundColor3 = WarningColor

            if Line then
                Line.BackgroundColor3 = WarningColor
            end
        else
            Accent.BackgroundColor3 = AccentColor

            if Line then
                Line.BackgroundColor3 = AccentColor
            end
        end

        Background.BackgroundTransparency = 1 - MainLerpSine
        Text.TextTransparency = 1 - MainLerpSine
        Accent.BackgroundTransparency = 1 - MainLerpSine

        if Line then
            Line.BackgroundTransparency = 1 - MainLerpSine
        end

        Lerps.Offset = Utility:Lerp(Lerps.Offset, (SizeY + 5) * (Lerps.OffsetOnce / 255), Library.LerpSpeed)

        YOffset += Lerps.Offset

        if MainLerp <= 80 then
            Lerps.OffsetOnce = Utility:Lerp(Lerps.OffsetOnce, 0, Library.LerpSpeed)
        end
        if Lerps.OffsetOnce <= 0 then
            Background:Destroy()

            --tableremove(Library.Notifications, _)

            Library.Notifications[_] = {}

            continue
        end
    end
end, "Main UI Loop")

function Library:Window(cfg)
    cfg = {
        Name = cfg.Name or "New Window",
        Size = cfg.Size or Vector2new(498, 398),
        Selects = cfg.Selects == nil and true or cfg.Selects,
        Holder = cfg.Holder or Library.ScreenGui,
        Position = cfg.Position or nil,
        Watermark = cfg.Watermark == nil and false or cfg.Watermark,
        Keybinds = cfg.Keybinds == nil and false or cfg.Keybinds,
        Fading = cfg.Fading == nil and true or cfg.Fading,
        Tabs = cfg.Tabs == nil and true or cfg.Tabs,
        Resizing = cfg.Resizing == nil and true or cfg.Resizing,
    }
    local Watermark
    if cfg.Watermark then
        Watermark = Library:Watermark({
            Visible = true
        })
    end
    local WindowOutline = Library:New("Frame", {
        Name = "WindowOutline",
        Parent = cfg.Holder,
        BorderSizePixel = 0,
        Position = cfg.Position or UDim2new(0.5, -(cfg.Size.x / 2), 0.5, -(cfg.Size.y / 2)),
        Size = UDim2new(0, cfg.Size.x, 0, cfg.Size.y),
    })
    if cfg.Selects then
        Library.Selectables = Library:CreateSelects(WindowOutline.AbsolutePosition)
    end
    WindowOutline.Active = true
    WindowOutline.Draggable = true
    Library:AddTheme(WindowOutline, {
        BackgroundColor3 = "Outline",
    })
    local WindowBackground = Library:New("Frame", {
        Name = "WindowBackground",
        Parent = WindowOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(WindowBackground, {
        BackgroundColor3 = "Background",
    })
    if cfg.Resizing then
        local ResizeBox = Library:New("TextButton", {
            Name = "ResizeBox",
            Parent = WindowBackground,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            Position = UDim2new(1, -10, 1, -10),
            Size = UDim2new(0, 10, 0, 10),
        })
        Library:MakeResizable(WindowOutline, ResizeBox)
    end
    local TitleBackground = Library:New("Frame", {
        Name = "TitleBackground",
        Parent = WindowBackground,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 24),
    })
    Library:AddTheme(TitleBackground, {
        BackgroundColor3 = "Accent",
    })
    
    Library:New("UIPadding", {
        Parent = TitleBackground,
        PaddingBottom = UDimnew(0, 5),
        PaddingLeft = UDimnew(0, 5),
        PaddingRight = UDimnew(0, 5),
        PaddingTop = UDimnew(0, 5),
    })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(149, 149, 149))},
        Rotation = 90,
        Parent = TitleBackground,
    })
    local TitleLabel = Library:New("TextLabel", {
        Name = "TitleLabel",
        Parent = TitleBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(TitleLabel, {
        TextColor3 = "Text",
    })
    local TabHolderBackground 
    if cfg.Tabs then
        local TabHolderOutline = Library:New("Frame", {
            Name = "TabHolderOutline",
            Parent = WindowBackground,
            BorderSizePixel = 0,
            Position = UDim2new(0, 0, 0, 24),
            Size = UDim2new(1, 0, 0, 27),
        })
        
        Library:AddTheme(TabHolderOutline, {
            BackgroundColor3 = "Outline",
        })
        TabHolderBackground = Library:New("Frame", {
            Name = "TabHolderBackground",
            Parent = TabHolderOutline,
            BackgroundColor3 = Color3fromRGB(65, 65, 65),
            BorderColor3 = Color3fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Position = UDim2new(0, 0, 0, 1),
            Size = UDim2new(1, 0, 1, -2),
        })
        Library:AddTheme(TabHolderBackground, {
            BackgroundColor3 = "Tab Enabled",
        })
        
        Library:New("UIGradient", {
            Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(111, 111, 111))},
            Rotation = 90,
            Parent = TabHolderBackground,
        })
        Library:New("UITableLayout", {
            Parent = TabHolderBackground,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillEmptySpaceColumns = true,
            FillEmptySpaceRows = true,
            Padding = UDim2new(0, 1, 0, 0),
        })
    end
    local WindowPageHolder = Library:New("Frame", {
        Visible = false,
        Name = "WindowPageHolder",
        Parent = WindowBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 9, 0, 60),
        Size = UDim2new(1, -18, 1, -69),
    })
    local KeybindList
    if cfg.Keybinds then
        KeybindList = Library:InitList({Name = "Keybinds List", Position = UDim2new(0, 10, 0.5, 0)})
        KeybindList.GetItems = function()
            return Library.Keybinds
        end
    end 
    if cfg.Keybinds or cfg.Watermark then
        Utility:Connect(RunService.Heartbeat, function(step)            
            if Watermark then
                Watermark.Think()
            end
        
            if KeybindList then
                KeybindList.Think()
            end
        end, "UI Window Loop")
    end

    local Items = {}
    return setmetatable({
        OutlineHolder = WindowOutline,
        Holder = WindowBackground,
        TabHolder = TabHolderBackground,
        Items = Items,
        Title = TitleLabel,
        Watermark = Watermark,
        KeybindList = KeybindList,
        SelectedTab = nil,
        OldTab = nil,
        Fading = cfg.Fading,
        PageHolder = WindowPageHolder,
    }, Library)
end
function Library:Tab(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Tab"
    }
    local TabHolder = Parent.TabHolder
    local Holder = Parent.Holder
    local Items = Parent.Items
    local TabOutline = Library:New("Frame", {
        Name = "TabOutline",
        Parent = TabHolder,
        Size = UDim2new(1, 0, 1, 0),
    })
    Library:AddTheme(TabOutline, {
        BorderColor3 = "Outline",
        BackgroundColor3 = "Tab Disabled"
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = TabOutline,
    })
    local TabLabel = Library:New("TextLabel", {
        Name = "TabLabel",
        Parent = TabOutline,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
        Text = cfg.Name,
        FontFace = Library.Font,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
    })
    Library:AddTheme(TabLabel, {
        TextColor3 = "Text",
    })
    local PageHolder = Library:New("Frame", {
        Visible = false,
        Name = "PageHolder",
        Parent = Holder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 9, 0, 60),
        Size = UDim2new(1, -18, 1, -69),
    })
    local LeftSide = Library:New("Frame", {
        Name = "LeftSide",
        Parent = PageHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(0.5, -5, 1, 0),
    })
    
    Library:New("UIListLayout", {
        Parent = LeftSide,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 10),
    })
    
    local RightSide = Library:New("Frame", {
        Name = "RightSide",
        Parent = PageHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0.5, 5, 0, 0),
        Size = UDim2new(0.5, -5, 1, 0),
    })
    
    Library:New("UIListLayout", {
        Parent = RightSide,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 10),
    })
    local MiddleSide = Library:New("Frame", {
        Name = "MiddleSide",
        Parent = PageHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 0),
        Size = UDim2new(1, 0, 1, 0),
    })
    
    Library:New("UIListLayout", {
        Parent = RightSide,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 10),
    })
    local PageFade = Library:New("Frame", {
        Name = "PageFade",
        Parent = Holder,
        BackgroundTransparency = 1,
        Visible = false,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 55),
        Size = UDim2new(1, 0, 1, -64),
    })
    Library:AddTheme(PageFade, {
        BackgroundColor3 = "Background",
    })
    local Tab = {
        Name = cfg.Name,
        Selected = false,
        TabOutline = TabOutline,
        Page = PageHolder,
        Left = LeftSide,
        Right = RightSide,
        Middle = MiddleSide,
        PageFade = PageFade,
        CurrentTween = nil
    }
    tableinsert(Items, Tab)
    function Tab.Select(status, looped, oldpage)
        Tab.Selected = status
        Library:Tween(TabOutline, nil, {
            Transparency = status and 1 or 0
        })
        if not looped then
            for _,v in Items do
                if v == Tab then
                    continue
                end
                if Parent.SelectedTab == v then
                    Parent.OldTab = v
                    v.Select(false, true, Parent.SelectedTab)
                else
                    v.Select(false, true)
                end
            end
            Parent.SelectedTab = Tab
        end
        if Parent.Fading then
            if not looped then
                taskspawn(function()
                    local OldTab = Parent.OldTab
                    if OldTab then
                        OldTab.PageFade.Visible = true
                        Tab.CurrentTween = Library:Tween(OldTab.PageFade, nil, {
                            BackgroundTransparency = 0
                        })
    
                        taskwait(Library.TweenSpeed)
        
                        OldTab.Page.Visible = false
                        OldTab.PageFade.Visible  = false
                        PageFade.Visible = true
                        PageFade.BackgroundTransparency = 0
                        PageHolder.Visible = true
                        Tab.CurrentTween = Library:Tween(PageFade, nil, {
                            BackgroundTransparency = 1
                        })
    
                        taskwait(Library.TweenSpeed)
    
                        PageFade.Visible = false
                    else
                        PageFade.Visible = true
                        PageFade.BackgroundTransparency = 0
        
                        PageHolder.Visible = true
                        Tab.CurrentTween = Library:Tween(PageFade, nil, {
                            BackgroundTransparency = 1
                        })
                        taskwait(Library.TweenSpeed)
                        PageFade.Visible = false
                    end                
                end)
            elseif not oldpage then
                PageHolder.Visible = false
            end
        else
            PageHolder.Visible = status
        end
    end
    Utility:Connect(TabOutline.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Tab.Select(true, false)
        end
    end)
    if #Items == 1 then
        Tab.Select(true)
    end
    return setmetatable(Tab, Library)
end
function Library:Section(cfg)
    local Parent = self
    cfg = {
        Size = cfg.Size or UDim2new(1, 0, 1, 0),
        Name = cfg.Name or "New Section",
        Side = cfg.Side or "Left",
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Section = {}
    local Left = Parent.Left
    local Right = Parent.Right
    local Middle = Parent.Middle
    local Side = cfg.Side == "Left" and Left or cfg.Side == "Middle" and Middle or Right
    local FMiddleSide, SMiddleSide
    if cfg.Side == "Middle" then
        FMiddleSide = Library:New("Frame", {
            Name = "FMiddleSide",
            Parent = Left,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = cfg.Size,
            Visible = cfg.Visible,
        })
        SMiddleSide = Library:New("Frame", {
            Name = "SMiddleSide",
            Parent = Right,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = cfg.Size,
            Visible = cfg.Visible,
        })
    end
    local SectionOutline = Library:New("Frame", {
        Name = "SectionOutline",
        Parent = Side,
        BorderSizePixel = 0,
        Size = cfg.Size,
        Visible = cfg.Visible,
    })
    
    Library:AddTheme(SectionOutline, {
        BackgroundColor3 = "Outline"
    })
    local SectionAccent = Library:New("Frame", {
        Name = "SectionAccent",
        Parent = SectionOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(SectionAccent, {
        BackgroundColor3 = "Accent"
    })
    
    local SectionInline = Library:New("Frame", {
        Name = "SectionInline",
        Parent = SectionAccent,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(SectionInline, {
        BackgroundColor3 = "Outline"
    })
    
    local SectionBackground = Library:New("Frame", {
        Name = "SectionBackground",
        Parent = SectionInline,
        BackgroundColor3 = Color3fromRGB(37, 37, 37),
        BorderColor3 = Color3fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(SectionBackground, {
        BackgroundColor3 = "Background"
    })
    local SectionLabel = Library:New("TextLabel", {
        Name = "SectionLabel",
        Parent = SectionBackground,
        BorderSizePixel = 0,
        Position = UDim2new(0, 5, 0, -8),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2new(0, 0, 0, 12),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(SectionLabel, {
        BackgroundColor3 = "Background",
        TextColor3 = "Text"
    })
    local SectionScrollingHolder = Library:New("ScrollingFrame", {
        Name = "SectionScrollingHolder",
        Parent = SectionBackground,
        Active = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Position = UDim2new(0, 5, 0, 10),
        Size = UDim2new(1, -10, 1, -15),
        BottomImage = Library.Images.Scroll,
        CanvasSize = UDim2new(0, 0, 0, 0),
        MidImage = Library.Images.Scroll,
        ScrollBarThickness = 3,
        TopImage = Library.Images.Scroll,
    })
    Library:AddTheme(SectionScrollingHolder, {
        ScrollBarImageColor3 = "Accent",
    })
    local SectionHolder = Library:New("TextButton", {
        Name = "SectionHolder",
        Parent = SectionScrollingHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2new(1, 0, 0, 0),
        Text = "",
        TextSize = 0,
    })
    Library:New("UIListLayout", {
        Parent = SectionHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 4),
    })
    Utility:Connect(SectionScrollingHolder:GetPropertyChangedSignal("AbsoluteSize"), function()
        if SectionScrollingHolder.AbsoluteCanvasSize.Y > SectionScrollingHolder.AbsoluteSize.Y then
            SectionHolder.Size = UDim2new(1, -8, 0, 0)
        else
            SectionHolder.Size = UDim2new(1, 0, 0, 0)
        end
    end)
    
    Utility:Connect(SectionScrollingHolder:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
        if SectionScrollingHolder.AbsoluteCanvasSize.Y > SectionScrollingHolder.AbsoluteSize.Y then
            SectionHolder.Size = UDim2new(1, -8, 0, 0)
        else
            SectionHolder.Size = UDim2new(1, 0, 0, 0)
        end
    end)
    Section.Holder = SectionHolder
    function Section.SetVisibility(status)
        SectionOutline.Visible = status
        if FMiddleSide then
            FMiddleSide.Visible = status
        end
        if SMiddleSide then
            SMiddleSide.Visible = status
        end
    end
    return setmetatable(Section, Library)
end
function Library:Toggle(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Toggle",
        Status = cfg.Status == nil and false or cfg.Status,
        Visible = cfg.Visible == nil and true or cfg.Visible,
        Flag = cfg.Flag or math.random(5^12),
        Callback = cfg.Callback or function() end
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local Toggle = {
        Status = false,
    }
    local ToggleHolder = Library:New("Frame", {
        Name = "ToggleHolder",
        Parent = ChildHolder or Holder,
        Visible = cfg.Visible,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    --if not ChildHolder then
        Library:New("UIListLayout", {
            Parent = ToggleHolder,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDimnew(0, 3),
        })
    --end
    local ToggleLine = Library:New("Frame", {
        Name = "ToggleLine",
        Parent = ToggleHolder,
        Visible = not ChildHolder and cfg.Visible or true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
    })
    
    local ToggleLabel = Library:New("TextLabel", {
        Name = "ToggleLabel",
        Parent = ToggleLine,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 18, 0, 0),
        Size = UDim2new(1, -18, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(ToggleLabel, {
        TextColor3 = "Text"
    })
    Library:New("UIListLayout", {
        Parent = ToggleLabel,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    local ToggleOutline = Library:New("Frame", {
        Name = "ToggleOutline",
        Parent = ToggleLine,
        BorderSizePixel = 0,
        Size = UDim2new(0, 13, 0, 13),
    })
    Library:AddTheme(ToggleOutline, {
        BackgroundColor3 = "Outline"
    })
    local ToggleBackground = Library:New("Frame", {
        Name = "ToggleBackground",
        Parent = ToggleOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(ToggleBackground, {
        BackgroundColor3 = "Element Background"
    })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = ToggleBackground,
    })
    function Toggle.Set(status)
        Toggle.Status = status
        Library:ChangeObjectTheme(ToggleBackground, {
            BackgroundColor3 = status and "Accent" or "Element Background"
        }, true)
        Library.Flags[cfg.Flag] = status
        cfg.Callback(status)
    end
    function Toggle.SetVisibility(status)
        ToggleHolder.Visible = status
    end
    Utility:Connect(ToggleLine.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle.Set(not Toggle.Status)
        end
    end)
    Toggle.Set(cfg.Status)
    Library.ConfigFlags[cfg.Flag] = Toggle
    Toggle.ChildHolder = ToggleHolder
    Toggle.TextLabel = ToggleLabel
    return setmetatable(Toggle, Library)
end
function Library:Slider(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Slider",
        Value = cfg.Value or 0,
        Min = cfg.Min or -50,
        Max = cfg.Max or 50,
        Float = cfg.Float or 0.1,
        Suffix = cfg.Suffix or "",
        Flag = cfg.Flag or math.random(5^12),
        Visible = cfg.Visible == nil and true or cfg.Visible,
        Callback = cfg.Callback or function() end
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local Slider = {
        Value = 0,
        Sliding = false
    }
    local SliderHolder = Library:New("Frame", {
        Name = "SliderHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        Visible = cfg.Visible,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Library:New("UIListLayout", {
        Parent = SliderHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    if not ChildHolder then
        Library:New("UIListLayout", {
            Parent = SliderHolder,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDimnew(0, 3),
        })
    end
    local SliderLine = Library:New("Frame", {
        Name = "SliderLine",
        Parent = SliderHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    local SliderLabel = Library:New("TextLabel", {
        Name = "SliderLabel",
        Parent = SliderLine,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:New("UIListLayout", {
        Parent = SliderLabel,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    Library:AddTheme(SliderLabel, {
        TextColor3 = "Text"
    })
    local SliderOutline = Library:New("Frame", {
        Name = "SliderOutline",
        Parent = SliderLine,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 15),
        Size = UDim2new(1, 0, 0, 15),
    })
    Library:AddTheme(SliderOutline, {
        BackgroundColor3 = "Outline"
    })
    local SliderBackground = Library:New("Frame", {
        Name = "SliderBackground",
        Parent = SliderOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(SliderBackground, {
        BackgroundColor3 = "Element Background"
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = SliderBackground,
    })
    local SliderAccent = Library:New("Frame", {
        Name = "SliderAccent",
        Parent = SliderBackground,
        BorderSizePixel = 0,
        Size = UDim2new(0, 0, 1, 0),
    })
    Library:AddTheme(SliderAccent, {
        BackgroundColor3 = "Accent"
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = SliderAccent,
    })
    local SliderValue = Library:New("TextLabel", {
        Name = "SliderValue",
        Parent = SliderOutline,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
        FontFace = Library.Font,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
    })
    Library:AddTheme(SliderValue, {
        TextColor3 = "Text"
    })
    function Slider.Set(value)
        Slider.Value = mathclamp(Utility:Round(value, cfg.Float), cfg.Min, cfg.Max)
        SliderValue.Text = stringformat("%s%s", tostring(Slider.Value), cfg.Suffix)
        Library:Tween(SliderAccent, nil, {
            Size = UDim2new((Slider.Value - cfg.Min) / (cfg.Max - cfg.Min), 0, 1, 0)
        })
        Library.Flags[cfg.Flag] = Slider.Value
        cfg.Callback(Slider.Value)
    end
    function Slider.SetVisibility(status)
        SliderHolder.Visible = status
    end
    Utility:Connect(SliderLine.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Slider.Sliding = true
            local sizeX = (input.Position.X - SliderLine.AbsolutePosition.X) / SliderLine.AbsoluteSize.X
            local value = ((cfg.Max - cfg.Min) * sizeX) + cfg.Min
            Slider.Set(value)
        end
    end)
    Utility:Connect(SliderLine.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Slider.Sliding = false
        end
    end)
    Utility:Connect(UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if Slider.Sliding then
                local sizeX = (input.Position.X - SliderLine.AbsolutePosition.X)
                    / SliderLine.AbsoluteSize.X
                local value = ((cfg.Max - cfg.Min) * sizeX) + cfg.Min
                Slider.Set(value)
            end
        end
    end)
    Slider.Set(cfg.Value)
    Library.ConfigFlags[cfg.Flag] = Slider
    Slider.ChildHolder = SliderHolder
    Slider.TextLabel = SliderLabel
    return setmetatable(Slider, Library)
end
function Library:Button(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Button",
        Confirm = cfg.Confirm or false,
        Callback = cfg.Callback or function() end,
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Button = {
        Clicked = false,
        ConfirmCountdown = 0,
        ConfirmationWrap = nil
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local ButtonHolder = Library:New("Frame", {
        Name = "ButtonHolder",
        Parent = ChildHolder or Holder,
        BorderSizePixel = 0,
        Visible = cfg.Visible,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Library:New("UIListLayout", {
        Parent = ButtonHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    
    local ButtonLine = Library:New("Frame", {
        Name = "ButtonLine",
        Parent = ButtonHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 20),
    })
    
    local ButtonOutline = Library:New("Frame", {
        Name = "ButtonOutline",
        Parent = ButtonLine,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
    })
    Library:AddTheme(ButtonOutline, {
        BackgroundColor3 = "Outline"
    })
    local ButtonBackground = Library:New("Frame", {
        Name = "ButtonBackground",
        Parent = ButtonOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(ButtonBackground, {
        BackgroundColor3 = "Element Background"
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = ButtonBackground,
    })
    
    local ButtonLabel = Library:New("TextLabel", {
        Name = "ButtonLabel",
        Parent = ButtonBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 5, 0, 0),
        Size = UDim2new(1, -5, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
    })
    Library:AddTheme(ButtonLabel, {
        TextColor3 = "Text"
    })
    function Button.StartConfirmation()
        Button.Clicked = true
        Button.ConfirmCountdown = 5
        ButtonLabel.Text = "Confirm: " .. cfg.Name .. " (" .. Button.ConfirmCountdown .. "s)?"
        Button.ConfirmationWrap = coroutine.create(function()
            for _ = 1, 5 do 
                taskwait(1)
                Button.ConfirmCountdown = Button.ConfirmCountdown - 1
                if Button.ConfirmCountdown > 0 then
                    ButtonLabel.Text = "Confirm: " .. cfg.Name .. " (" .. Button.ConfirmCountdown .. "s)?"           
                else
                    ButtonLabel.Text = cfg.Name
                    if Button.Clicked then 
                        Library:ChangeObjectTheme(ButtonLabel, {
                            TextColor3 = "Text"
                        }, true)
                        Button.Clicked = false
                    end
                    break
                end
            end
        end)
        coroutine.resume(Button.ConfirmationWrap)
    end
    function Button.SetVisibility(status)
        ButtonHolder.Visible = status
    end
    Utility:Connect(ButtonLine.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if not cfg.Confirm then
                Library:ChangeObjectTheme(ButtonLabel, {
                    TextColor3 = "Accent"
                }, true)
                taskwait(Library.TweenSpeed)
                Library:ChangeObjectTheme(ButtonLabel, {
                    TextColor3 = "Text"
                }, true)
                cfg.Callback(true)
            else
                if not Button.Clicked then
                    Library:ChangeObjectTheme(ButtonLabel, {
                        TextColor3 = "Accent"
                    }, true)
                    Button.StartConfirmation()
                elseif Button.Clicked then
                    Library:ChangeObjectTheme(ButtonLabel, {
                        TextColor3 = "Text"
                    }, true)
                    coroutine.close(Button.ConfirmationWrap)
                    ButtonLabel.Text = cfg.Name
                    Button.Clicked = false
                    cfg.Callback(true)
                end
            end
        end
    end)
    Button.ChildHolder = ButtonHolder
    return setmetatable(Button, Library)
end
function Library:Dropdown(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Dropdown",
        Value = cfg.Value or "Value 1",
        Values = cfg.Values or {"Value 1", "Value 2", "Value 3", "Value 4"},
        Multi = cfg.Multi or false,
        Flag = cfg.Flag or math.random(5^12),
        Ignore = cfg.Ignore or false,
        Callback = cfg.Callback or function() end,
        Visible = cfg.Visible == nil and true or cfg.Visible,
        Close = cfg.Close or false,
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local ContentHolder = Parent.ContentHolder
    local Dropdown = {
        Items = {},
        Selected = cfg.Multi and {} or ""
    }
    local DropdownHolder = Library:New("Frame", {
        Name = "DropdownHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Visible = cfg.Visible,
    })
    
    Library:New("UIListLayout", {
        Parent = DropdownHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    
    local DropdownLine = Library:New("Frame", {
        Name = "DropdownLine",
        Parent = DropdownHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    
    local DropdownOutline = Library:New("Frame", {
        Name = "DropdownOutline",
        Parent = DropdownLine,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 15),
        Size = UDim2new(1, 0, 0, 20),
    })
    Library:AddTheme(DropdownOutline, {
        BackgroundColor3 = "Outline"
    })
    
    local DropdownBackground = Library:New("Frame", {
        Name = "DropdownBackground",
        Parent = DropdownOutline,
        BackgroundColor3 = Color3fromRGB(45, 45, 45),
        BorderColor3 = Color3fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    
    Library:AddTheme(DropdownBackground, {
        BackgroundColor3 = "Element Background"
    })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = DropdownBackground,
    })
    
    local DropdownValue = Library:New("TextLabel", {
        Name = "DropdownValue",
        Parent = DropdownOutline,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 5, 0, 0),
        Size = UDim2new(1, -5, 1, 0),
        FontFace = Library.Font,
        Text = "-",
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(DropdownValue, {
        TextColor3 = "Text"
    })
    local DropdownStatusOutline = Library:New("Frame", {
        Name = "DropdownStatusOutline",
        Parent = DropdownOutline,
        BorderSizePixel = 0,
        Position = UDim2new(1, -20, 0, 0),
        Size = UDim2new(0, 20, 0, 20),
    })
    Library:AddTheme(DropdownStatusOutline, {
        BackgroundColor3 = "Outline"
    })
    local DropdownStatusBackground = Library:New("Frame", {
        Name = "DropdownStatusBackground",
        Parent = DropdownStatusOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(DropdownStatusBackground, {
        BackgroundColor3 = "Accent"
    })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(149, 149, 149))},
        Rotation = 90,
        Parent = DropdownStatusBackground,
    })
    local DropdownStatusLabel = Library:New("TextLabel", {
        Name = "DropdownStatusLabel",
        Parent = DropdownStatusBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
        FontFace = Library.Font,
        Text = "↓",
        TextScaled = true,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextWrapped = true,
    })
    Library:AddTheme(DropdownStatusLabel, {
        TextColor3 = "Text"
    })
    local DropdownLabel = Library:New("TextLabel", {
        Name = "DropdownLabel",
        Parent = DropdownLine,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(DropdownLabel, {
        TextColor3 = "Text"
    })
    
    Library:New("UIListLayout", {
        Parent = DropdownLabel,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    local DropdownContentOutline = Library:New("Frame", {
        Name = "DropdownContentOutline",
        Parent = ContentHolder or Library.ScreenGui,
        Visible = false,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 0),
        Size = UDim2new(0, 0, 0, 0),
    })
    Library:New("TextButton", {
        Name = "IgnoreButton",
        Parent = DropdownContentOutline,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
        Text = "",
        TextSize = 0,
    })
    Library:AddTheme(DropdownContentOutline, {
        BackgroundColor3 = "Outline"
    })
    
    local DropdownContentBackground = Library:New("Frame", {
        Name = "DropdownContentBackground",
        Parent = DropdownContentOutline,
        BackgroundColor3 = Color3fromRGB(37, 37, 37),
        BorderColor3 = Color3fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(DropdownContentBackground, {
        BackgroundColor3 = "Background"
    })
    Library:New("UIPadding", {
        Parent = DropdownContentBackground,
        PaddingBottom = UDimnew(0, 5),
        PaddingTop = UDimnew(0, 5),
        PaddingRight = UDimnew(0, 5)
    })
    local DropdownScrollingHolder = Library:New("ScrollingFrame", {
        Name = "DropdownScrollingHolder",
        Parent = DropdownContentBackground,
        Active = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Size = UDim2new(1, 0, 1, 0),
        BottomImage = Library.Images.Scroll,
        CanvasSize = UDim2new(0, 0, 0, 0),
        MidImage = Library.Images.Scroll,
        ScrollBarThickness = 3,
        TopImage = Library.Images.Scroll,
    })
    
    Library:AddTheme(DropdownScrollingHolder, {
        ScrollBarImageColor3 = "Accent",
    })
    Library:New("UIListLayout", {
        Parent = DropdownScrollingHolder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 2),
    })
    
    Library:New("UIPadding", {
        Parent = DropdownScrollingHolder,
        PaddingLeft = UDimnew(0, 5),
    })
    function Dropdown.UpdateAbsolute()
        DropdownContentOutline.Size = UDim2new(0, DropdownOutline.AbsoluteSize.x, 0, DropdownContentOutline.AbsoluteSize.y)
        DropdownContentOutline.Position = UDim2new(0, DropdownOutline.AbsolutePosition.x, 0, DropdownOutline.AbsolutePosition.y + DropdownOutline.AbsoluteSize.y - 1)
    end
    function Dropdown.SetVisibility(status)
        DropdownHolder.Visible = status
        if not status then
            Dropdown.Show(status)
        end
    end
    function Dropdown.Show(status)
        DropdownContentOutline.Visible = status
        Library:Tween(DropdownStatusLabel, nil, {
            Rotation = status and 180 or 0,
            Position = UDim2new(0, status and 1 or 0, 0, status and 2 or 0)
        })
        
        Dropdown.UpdateAbsolute()
    end
    function Dropdown.Display()
        if cfg.Multi then
            local CurrentText = {}
            if #Dropdown.Selected > 0 then
                for _, option in Dropdown.Selected do
                    tableinsert(CurrentText, option)

                    local Text = tableconcat(CurrentText, ", ")
                    DropdownValue.Text = Text
                end
            else
                DropdownValue.Text = "-"
            end
        else
            local Selected = Dropdown.Selected
            DropdownValue.Text = Selected == "" or Selected == nil and "-" or Selected
        end
    end
    function Dropdown.Set(item)
        if cfg.Multi then
            if type(item) == "table" then
                -- too lazy to implement a for loop for a table, just set it for every item ig.
                for _,v in item do
                    if not tablefind(Dropdown.Selected, v) then
                        Dropdown.Set(v)
                    end
                end
            else
                local Index = tablefind(Dropdown.Selected, item)
                local Item = Dropdown.Items[item]

                if Item then
                    if Index then    
                        Item.Selected = false

                        Library:ChangeObjectTheme(Item.Text, {
                            TextColor3 = "Text"
                        }, true)

                        tableremove(Dropdown.Selected, Index)
                        Dropdown.Display()

                        if not cfg.Ignore then
                            Library.Flags[cfg.Flag] = Dropdown.Selected
                        end

                        cfg.Callback(Dropdown.Selected)
                    else    
                        Item.Selected = true

                        Library:ChangeObjectTheme(Item.Text, {
                            TextColor3 = "Accent"
                        }, true)

                        tableinsert(Dropdown.Selected, item)

                        Dropdown.Display()

                        if not cfg.Ignore then
                            Library.Flags[cfg.Flag] = Dropdown.Selected
                        end

                        cfg.Callback(Dropdown.Selected)
                    end
                end
            end
        else
            for _,v in Dropdown.Items do
                Library:ChangeObjectTheme(v.Text, {
                    TextColor3 = _ == item and "Accent" or "Text"
                }, true)
                v.Selected = _ == item
            end
            Dropdown.Selected = item
            Dropdown.Display()
            if not cfg.Ignore then
                Library.Flags[cfg.Flag] = item
            end
            cfg.Callback(item)
        end
        if cfg.Close then
            Dropdown.Show(false)
        end
    end
    local function GetTblSize(tbl)
        local Count = 0
        for _,v in tbl do
            Count += 1
        end
        return Count
    end
    function Dropdown.NewItem(item)
        if Dropdown.Items[item] then
            return
        end
        
        local Item = {
            Name = item,
            Selected = false
        }
        local DropdownContentLabel = Library:New("TextLabel", {
            Name = "DropdownContentLabel",
            Parent = DropdownScrollingHolder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 0, 15),
            FontFace = Library.Font,
            Text = item,
            TextSize = Library.FontSize,
            TextStrokeTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        Library:AddTheme(DropdownContentLabel, {
            TextColor3 = "Text"
        })
        Item.Text = DropdownContentLabel
        Utility:Connect(DropdownContentLabel.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dropdown.Set(item)
            end
        end)
        Dropdown.Items[item] = Item
        -- SOME GAY SIZE MATH
            local Size = 0
            for _,v in DropdownScrollingHolder:GetChildren() do
                if IsA(v, "TextLabel") then
                    Size += v.AbsoluteSize.y + 2
                end
            end
            Size += 10 -- uipadding shiz.
        --
        
        if GetTblSize(Dropdown.Items) <= 6 then
            DropdownContentOutline.Size = UDim2new(0, DropdownContentOutline.AbsoluteSize.x, 0, Size)
        end
    end
    function Dropdown.Refresh(tbl)
        for _,v in Dropdown.Items do
            v.Text:Destroy()
            Dropdown.Items[_] = nil
        end
        for _,v in tbl do
            Dropdown.NewItem(v)
        end
    end
    
    for _,v in cfg.Values do
        Dropdown.NewItem(v)
    end
    Dropdown.Set(cfg.Value)
    Library.Flags[cfg.Flag] = Dropdown.Selected
    Library.ConfigFlags[cfg.Flag] = Dropdown
    Utility:Connect(DropdownLine.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dropdown.Show(not DropdownContentOutline.Visible)
        end
    end)
    Utility:Connect(DropdownOutline:GetPropertyChangedSignal("AbsolutePosition"), function()
        Dropdown.UpdateAbsolute()
    end)
    Utility:Connect(DropdownOutline:GetPropertyChangedSignal("AbsoluteSize"), function()
        Dropdown.UpdateAbsolute()
    end)
    Dropdown.ChildHolder = DropdownHolder
    Dropdown.TextLabel = DropdownLabel
    return setmetatable(Dropdown, Library)
end
function Library:List(cfg)
    local Parent = self
    cfg = {
        Size = cfg.Size or 150,
        Name = cfg.Name or "New List",
        Value = cfg.Value or "Value 1",
        Values = cfg.Values or {"Value 1", "Value 2", "Value 3", "Value 4"},
        Multi = cfg.Multi or false,
        Flag = cfg.Flag or math.random(5^12),
        Ignore = cfg.Ignore or false,
        Callback = cfg.Callback or function() end,
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local List = {
        Items = {},
        Selected = cfg.Multi and {} or ""
    }
    local ListHolder = Library:New("Frame", {
        Name = "ListHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Visible = cfg.Visible,
    })
    Library:New("UIListLayout", {
        Parent = ListHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    
    local ListLine = Library:New("Frame", {
        Name = "ListLine",
        Parent = ListHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    local ListOutline = Library:New("Frame", {
        Name = "ListOutline",
        Parent = ListLine,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 15),
        Size = UDim2new(1, 0, 0, cfg.Size),
    })
    Library:AddTheme(ListOutline, {
        BackgroundColor3 = "Outline"
    })
    
    local ListBackground = Library:New("Frame", {
        Name = "ListBackground",
        Parent = ListOutline,
        BackgroundColor3 = Color3fromRGB(45, 45, 45),
        BorderColor3 = Color3fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(ListBackground, {
        BackgroundColor3 = "Element Background"
    })
    Library:New("UIPadding", {
        Parent = ListBackground,
        PaddingBottom = UDimnew(0, 5),
        PaddingTop = UDimnew(0, 5),
        PaddingRight = UDimnew(0, 5)
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = ListBackground,
    })
    local ListScrollingHolder = Library:New("ScrollingFrame", {
        Name = "ListScrollingHolder",
        Parent = ListBackground,
        Active = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Size = UDim2new(1, 0, 1, 0),
        BottomImage = Library.Images.Scroll,
        CanvasSize = UDim2new(0, 0, 0, 0),
        MidImage = Library.Images.Scroll,
        ScrollBarThickness = 3,
        TopImage = Library.Images.Scroll,
    })
    
    Library:AddTheme(ListScrollingHolder, {
        ScrollBarImageColor3 = "Accent",
    })
    Library:New("UIListLayout", {
        Parent = ListScrollingHolder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 2),
    })
    
    Library:New("UIPadding", {
        Parent = ListScrollingHolder,
        PaddingLeft = UDimnew(0, 5),
    })
    local ListLabel = Library:New("TextLabel", {
        Name = "ListLabel",
        Parent = ListLine,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextColor3 = Color3fromRGB(255, 255, 255),
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Library:AddTheme(ListLabel, {
        TextColor3 = "Text"
    })
    
    Library:New("UIListLayout", {
        Parent = ListLabel,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    function List.SetVisibility(status)
        ListHolder.Visible = status
    end
    function List.Set(item)
        if cfg.Multi then
            if type(item) == "table" then
                for _,v in item do
                    if not tablefind(List.Selected, v) then
                        List.Set(v)
                    end
                end
                return
            end
            local Index = tablefind(List.Selected, item)
            local Item = List.Items[item]
            if Item then
                if Index then
                    tableremove(List.Selected, Index)
                    Item.Selected = false
                    Library:ChangeObjectTheme(Item.Text, {
                        TextColor3 = "Text"
                    }, true)
                    if not cfg.Ignore then
                        Library.Flags[cfg.Flag] = List.Selected
                    end
                    cfg.Callback(List.Selected)
                else
                    tableinsert(List.Selected, item)
                    Item.Selected = true
                    Library:ChangeObjectTheme(Item.Text, {
                        TextColor3 = "Accent"
                    }, true)
                    if not cfg.Ignore then
                        Library.Flags[cfg.Flag] = List.Selected
                    end
                    cfg.Callback(List.Selected)
                end
            end
        else
            for _,v in List.Items do
                Library:ChangeObjectTheme(v.Text, {
                    TextColor3 = _ == item and "Accent" or "Text"
                }, true)
                v.Selected = _ == item
            end
            List.Selected = item
            if not cfg.Ignore then
                Library.Flags[cfg.Flag] = item
            end
            cfg.Callback(item)
        end
    end
    function List.NewItem(item)
        local ImageId = nil
        if type(item) == "table" then
            ImageId = item.ImageId
            item = item.Name
        end
        if List.Items[item] then
            return
        end
        local Item = {
            Name = item,
            Selected = false
        }
        local ListContentBackground = Library:New("Frame", {
            Name = "ListContentBackground",
            BackgroundTransparency = 1,
            Parent = ListScrollingHolder,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 0, 15),            
        })
        local ListContentLabel = Library:New("TextLabel", {
            Name = "ListContentLabel",
            Parent = ListContentBackground,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2new(0, ImageId and 18 or 0, 0, 0),
            Size = UDim2new(1, ImageId and -18 or 0, 1, 0),
            FontFace = Library.Font,
            Text = item,
            TextSize = Library.FontSize,
            TextStrokeTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        if ImageId then
            local ListContentImage = Library:New("ImageLabel", {
                Name = "ListContentImage",
                Parent = ListContentBackground,
                BackgroundColor3 = Color3fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2new(0, 0, 0, 0),
                Size = UDim2new(0, 15, 0, 15),
                Image = ImageId,
            })
        end
        
        Library:AddTheme(ListContentLabel, {
            TextColor3 = "Text"
        })
        Item.Holder = ListContentBackground
        Item.Text = ListContentLabel
        Utility:Connect(ListContentBackground.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                List.Set(item)
            end
        end)
        List.Items[item] = Item
    end
    function List.Refresh(tbl)
        for _,v in List.Items do
            v.Holder:Destroy()
            List.Items[_] = nil
        end
        for _,v in tbl do
            List.NewItem(v)
        end
    end
    
    for _,v in cfg.Values do
        List.NewItem(v)
    end
    List.Set(cfg.Value)
    Library.Flags[cfg.Flag] = List.Selected
    Library.ConfigFlags[cfg.Flag] = List
    List.ChildHolder = ListHolder
    List.TextLabel = ListLabel
    return setmetatable(List, Library)
end
function Library:Keybind(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Keybind",
        Key = cfg.Key or "-",
        Mode = cfg.Mode or "Toggle",
        Modes = cfg.Modes or true,
        Value = cfg.Value or false,
        Flag = cfg.Flag or math.random(5^12),
        Ignore = cfg.Ignore or false,
        Callback = cfg.Callback or function() end,
        Child = cfg.Child == nil and true or cfg.Child,
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local TextLabelHolder = Parent.TextLabel
    local Keybind = {
        Listening = false,
        Key = "",
        Value = cfg.Value,
        Mode = ""
    }
    local KeybindMode = Library.Selectables.KeybindMode
    local KeybindHolder = cfg.Child and TextLabelHolder or Library:New("Frame", {
        Name = "KeybindHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        Visible = not TextLabelHolder and cfg.Visible or true,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    
    local KeybindLabel
    if not (TextLabelHolder and cfg.Child) then
        local KeybindLine = Library:New("Frame", {
            Name = "KeybindLine",
            Parent = KeybindHolder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 0, 13),
        })    
        KeybindLabel = Library:New("TextLabel", {
            Name = "KeybindLabel",
            Parent = KeybindLine,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 1, 0),
            FontFace = Library.Font,
            Text = cfg.Name,
            TextSize = Library.FontSize,
            TextStrokeTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        Library:AddTheme(KeybindLabel, {
            TextColor3 = "Text"
        })
        
        Library:New("UIListLayout", {
            Parent = KeybindLabel,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDimnew(0, 3),
        })
    end
    local KeybindValue = Library:New("TextButton", {
        Name = "KeybindHolder",
        Parent = cfg.Child and TextLabelHolder or KeybindLabel,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = TextLabelHolder and cfg.Visible or true,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2new(0, 0, 1, 0),
        FontFace = Library.Font,
        Text = "[E]",
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
    })
    Library:AddTheme(KeybindValue, {
        TextColor3 = "Text"
    })
    function Keybind.ChangeMode(mode)
        Keybind.Mode = mode 
        if mode == "Always" then
            Keybind.Set(true)
        elseif mode == "Hold" then
            Keybind.Set(false)
        end
    end
    function Keybind.Set(input)
        if type(input) == "boolean" then
            local Value = input
            if Keybind.Mode == "Always" then
                Value = true
            end
            Keybind.Value = Value
            cfg.Callback(Keybind.Value or false)
        elseif tostring(input):find("Enum") then 
            input = input.Name == "Escape" and "-" or input
            Keybind.Key = input or "-"
            local Text = (ConvertKeys[Keybind.Key] or tostring(Keybind.Key):gsub("Enum.", ""))
            local Text2 = (tostring(Text):gsub("KeyCode.", ""):gsub("UserInputType.", "")) or "-"
            KeybindValue.Text = "[" .. Text2 .. "]"
            cfg.Callback(Keybind.Value or false)
        elseif tablefind({"Toggle", "Hold", "Always"}, input) then 
            Keybind.ChangeMode(input)
            cfg.Callback(Keybind.Value or false)
        elseif type(input) == "table" then
            input.Key = type(input.Key) == "string" and input.Key ~= "-" and Utility:ConvertToEnum(input.Key) or input.Key
            input.Key = input.Key == Enum.KeyCode.Escape and "-" or input.Key
            Keybind.Key = input.Key or "-"
            Keybind.Mode = input.Mode or "Toggle"
            if input.Value then
                Keybind.Value = input.Value
            end
            local Text = tostring(Keybind.Key) ~= "Enums" and (ConvertKeys[Keybind.Key] or tostring(Keybind.Key):gsub("Enum.", "")) or nil
            local Text2 = Text and (tostring(Text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
            KeybindValue.Text = "[" .. Text2 .. "]" or "[-]"
            cfg.Callback(Keybind.Value or false)
        end
        if not cfg.Ignore then
            Library.Keybinds[cfg.Flag] = {
                Flag = cfg.Flag,
                Status = Keybind.Value,
                Text = ("[%s]: %s"):format(tostring(Keybind.Key):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", ""), cfg.Name)
            }
        end
        Library.Flags[cfg.Flag] = Keybind.Value
        Library.Flags[cfg.Flag .. "_data"] = {
            Key = Keybind.Key,
            Mode = Keybind.Mode,
            Value = Keybind.Value,
        }
    end
    function Keybind.SetVisibility(status)
        if not TextLabelHolder then
            KeybindHolder.Visible = status
        end
        if TextLabelHolder then
            KeybindValue.Visible = status
        end
    end
    Utility:Connect(KeybindValue.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Keybind.Listening then
            Library:ChangeObjectTheme(KeybindValue, {
                TextColor3 = "Accent"
            }, true)
            taskwait()
            Keybind.Listening = true
        end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            KeybindMode.Holder.Position = UDim2new(0, KeybindValue.AbsolutePosition.x, 0, KeybindValue.AbsolutePosition.y + KeybindValue.AbsoluteSize.y + 2)
            if KeybindMode.Flag ~= cfg.Flag then
                KeybindMode.Holder.Visible = true
                KeybindMode.Dropdown.Set(Keybind.Mode ~= "" and Keybind.Mode or "Toggle")
                KeybindMode.Flag = cfg.Flag
            else
                KeybindMode.Holder.Visible = false
                KeybindMode.Flag = ""
            end
        end
    end)
    Utility:Connect(UserInputService.InputBegan, function(input)
        if Keybind.Listening then
            Keybind.Set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
            Keybind.Listening = false
            Library:ChangeObjectTheme(KeybindValue, {
                TextColor3 = "Text"
            }, true)
        elseif input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then
            Keybind.Set(not Keybind.Value)
        end
    end)
    Utility:Connect(UserInputService.InputEnded, function(input)
        if Keybind.Mode == "Hold" and (input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key) and not Keybind.Listening then
            Keybind.Set(false)
        end
    end)
    Keybind.Set({
        Key = cfg.Key,
        Mode = cfg.Mode
    })
    Library.ConfigFlags[cfg.Flag] = Keybind
    Library.ConfigFlags[cfg.Flag .. "_data"] = Keybind
    Keybind.ChildHolder = KeybindHolder
    Keybind.TextLabel = cfg.Child and TextLabelHolder or KeybindLabel
    return setmetatable(Keybind, Library)
end
function Library:Textbox(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Textbox",
        Value = cfg.Value or "",
        Flag = cfg.Flag or  math.random(5^12),
        Callback = cfg.Callback or function() end,
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Textbox = {}
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local TextboxHolder = Library:New("Frame", {
        Name = "TextboxHolder",
        Parent = ChildHolder or Holder,
        BorderSizePixel = 0,
        Visible = cfg.Visible,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Library:New("UIListLayout", {
        Parent = TextboxHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    
    local TextboxLine = Library:New("Frame", {
        Name = "TextboxLine",
        Parent = TextboxHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 20),
    })
    
    local TextboxOutline = Library:New("Frame", {
        Name = "TextboxOutline",
        Parent = TextboxLine,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
    })
    Library:AddTheme(TextboxOutline, {
        BackgroundColor3 = "Outline"
    })
    local TextboxBackground = Library:New("Frame", {
        Name = "TextboxBackground",
        Parent = TextboxOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    })
    Library:AddTheme(TextboxBackground, {
        BackgroundColor3 = "Element Background"
    })
    
    -- Library:New("UIGradient", {
    --     Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
    --     Rotation = 90,
    --     Parent = TextboxBackground,
    -- })
    
    local TextboxLabel = Library:New("TextBox", {
        Name = "TextboxLabel",
        Parent = TextboxBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 5, 0, 0),
        Size = UDim2new(1, -5, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Value,
        PlaceholderText = cfg.Name,
        TextSize = Library.FontSize,
        ClearTextOnFocus = false,
        TextStrokeTransparency = 0,
    })
    Library:AddTheme(TextboxLabel, {
        TextColor3 = "Text",
        PlaceholderColor3 = "Dark Text"
    })
    function Textbox.SetVisibility(status)
        TextboxHolder.Visible = status
    end
    function Textbox.Set(value)
        TextboxLabel.Text = value
        Library.Flags[cfg.Flag] = value
        cfg.Callback(value)
    end
    Utility:Connect(TextboxLabel.FocusLost, function()
        Textbox.Set(TextboxLabel.Text)
    end)
    Utility:Connect(TextboxLabel:GetPropertyChangedSignal("Text"), function()
        Textbox.Set(TextboxLabel.Text)
    end)
    Textbox.ChildHolder = TextboxHolder
    Library.ConfigFlags[cfg.Flag] = Textbox
    return setmetatable(Textbox, Library)
end
function Library:Label(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Label",
    }
    local Label = {}
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local LabelHolder = Library:New("Frame", {
        Name = "LabelHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = cfg.Visible,
        Size = UDim2new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Library:New("UIListLayout", {
        Parent = LabelHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    
    local LabelLine = Library:New("Frame", {
        Name = "LabelLine",
        Parent = LabelHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
    })
    local LabelLabel = Library:New("TextLabel", {
        Name = "LabelLabel",
        Parent = LabelLine,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 0),
        Size = UDim2new(1, 0, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
    })
    Library:AddTheme(LabelLabel, {
        TextColor3 = "Text"
    })
    Library:New("UIListLayout", {
        Parent = LabelLabel,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimnew(0, 3),
    })
    function Label.SetVisibility(status)
        LabelHolder.Visible = status
    end
    function Label.ChangeText(text)
        LabelLabel.Text = text
    end
    Label.ChildHolder = LabelHolder
    Label.TextLabel = LabelLabel
    return setmetatable(Label, Library)
end
function Library:Colorpicker(cfg)
    local Parent = self
    cfg = {
        Name = cfg.Name or "New Colorpicker",
        Color = cfg.Color or Color3fromRGB(255, 255, 255),
        Transparency = cfg.Transparency or 1,
        Flag = cfg.Flag or math.random(5^12),
        Callback = cfg.Callback or function() end,
        Child = cfg.Child == nil and true or cfg.Child,
        Visible = cfg.Visible == nil and true or cfg.Visible,
    }
    local Holder = Parent.Holder
    local ChildHolder = Parent.ChildHolder
    local TextLabelHolder = Parent.TextLabel
    local Colorpicker = {
        Color = cfg.Color,
        Transparency = cfg.Transparency
    }
    local ColorpickerHolder = cfg.Child and TextLabelHolder or Library:New("Frame", {
        Name = "ColorpickerHolder",
        Parent = ChildHolder or Holder,
        BackgroundTransparency = 1,
        Visible = not TextLabelHolder and cfg.Visible or true,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 13),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    local ColorpickerLabel
    if not (TextLabelHolder and cfg.Child) then
        local ColorpickerLine = Library:New("Frame", {
            Name = "ColorpickerLine",
            Parent = ColorpickerHolder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 0, 13),
        })
        
        ColorpickerLabel = Library:New("TextLabel", {
            Name = "ColorpickerLabel",
            Parent = ColorpickerLine,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2new(1, 0, 1, 0),
            FontFace = Library.Font,
            Text = cfg.Name,
            TextSize = Library.FontSize,
            TextStrokeTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        Library:AddTheme(ColorpickerLabel, {
            TextColor3 = "Text"
        })
        Library:New("UIListLayout", {
            Parent = ColorpickerLabel,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDimnew(0, 3),
        })
    end
    
    local ColorpickerOutline = Library:New("Frame", {
        Name = "ColorpickerOutline",
        Parent = cfg.Child and TextLabelHolder or ColorpickerLabel,
        Visible = TextLabelHolder and cfg.Visible == nil and true or cfg.Visible,
        BorderSizePixel = 0,
        Size = UDim2new(0, 27, 1, 0),
    })
    Library:AddTheme(ColorpickerOutline, {
        BackgroundColor3 = "Outline"
    })
    
    local ColorpickerImage = Library:New("ImageLabel", {
        Name = "ColorpickerImage",
        Parent = ColorpickerOutline,
        BackgroundColor3 = Color3fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
        Image = Library.Images.Checkers,
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2new(0, 6, 0, 6),
    })
    local ColorpickerBackground = Library:New("Frame", {
        Name = "ColorpickerBackground",
        Parent = ColorpickerImage,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 1, 0),
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(149, 149, 149))},
        Rotation = 90,
        Parent = ColorpickerBackground,
    })
    local ColorpickerButton = Library:New("TextButton", {
        Name = "ColorpickerButton",
        BackgroundTransparency = 1,
        Parent = ColorpickerBackground,
        BorderSizePixel = 0,
        Text = "",
        Size = UDim2new(1, 0, 1, 0),
        ZIndex = 10,
    })
    function Colorpicker.Set(color, transparency)
        transparency = transparency or Colorpicker.Transparency
        if type(color) == "table" then
            transparency = color.a
            color = color.c
        end
        Colorpicker.Color = color
        Colorpicker.Transparency = transparency
        ColorpickerBackground.BackgroundColor3 = color
        ColorpickerBackground.BackgroundTransparency = 1 - transparency
        Library.Flags[cfg.Flag] = {
            a = transparency,
            c = color
        }
        cfg.Callback({
            a = transparency,
            c = color
        })
    end
    function Colorpicker.SetVisibility(status)
        if not TextLabelHolder then
            ColorpickerHolder.Visible = status
        end
        if TextLabelHolder then
            ColorpickerOutline.Visible = status
        end
    end
    Colorpicker.Set({
        c = Colorpicker.Color,
        a = Colorpicker.Transparency
    })
    Utility:Connect(ColorpickerButton.MouseButton1Down, function()
        local ColorpickerSelect = Library.Selectables.Colorpicker
        ColorpickerSelect.Window.Title.Text = cfg.Name
        -- if ColorpickerSelect.Window.OutlineHolder.Visible then
        --     ColorpickerSelect.Flag = ""
        --     --ColorpickerSelect.Window.OutlineHolder.Visible = false
        -- else
            ColorpickerSelect.Flag = cfg.Flag
            ColorpickerSelect.Set({
                c = Colorpicker.Color,
                a = Colorpicker.Transparency
            })
            --ColorpickerSelect.Window.OutlineHolder.Visible = true
        -- end
    end)
    Library.ConfigFlags[cfg.Flag] = Colorpicker
    Colorpicker.ChildHolder = ColorpickerHolder
    Colorpicker.TextLabel = cfg.Child and TextLabelHolder or ColorpickerLabel
    return setmetatable(Colorpicker, Library)
end
function Library:Show(value)
    Library.ScreenGui.Enabled = value
    Library.Popups.Enabled = value
end
function Library:GetConfig()
    local Config = {}
    for _,v in Library.ConfigFlags do
        local Value = Library.Flags[_]
        if type(Value) == "table" and Value["Key"] then
            Config[_] = {Value = Value.Value, Mode = Value.Mode, Key = tostring(Value.Key)}
        elseif type(Value) == "table" and Value["a"] and Value["c"] then
            Config[_] = {a = Value.a, c = Value.c:ToHex()}
        else
            Config[_] = Value
        end
    end
    return HttpService:JSONEncode(Config)
end
function Library:LoadConfig(config)
    local Config = HttpService:JSONDecode(config)
    for _,v in Config do
        local ConfigTable = Library.ConfigFlags[_]
        if ConfigTable then
            local Func = ConfigTable.Set
            if Func then
                if type(v) == "table" and v["a"] and v["c"] then
                    Func({
                        a = v.a,
                        c = type(v.c) == "string" and Color3fromHex(v.c) or v.c
                    })
                else
                    Func(v)
                end
            end
        end
    end
end
function Library:InitList(cfg)
    cfg = {
        Name = cfg.Name or "New List",
        Position = cfg.Position or UDim2new(0, 300, 0, 300)
    }
    local WindowOutline = Library:New("Frame", {
        Name = "WindowOutline",
        Parent = Library.ListsGui,
        BorderSizePixel = 0,
        Position = cfg.Position,
        Size = UDim2new(0, 100, 0, 0),
        --AutomaticSize = Enum.AutomaticSize.Y,
    }, true)
    WindowOutline.Active = true
    WindowOutline.Draggable = true
    Library:AddTheme(WindowOutline, {
        BackgroundColor3 = "Outline",
    })
    local WindowBackground = Library:New("Frame", {
        Name = "WindowBackground",
        Parent = WindowOutline,
        BorderSizePixel = 0,
        Position = UDim2new(0, 1, 0, 1),
        Size = UDim2new(1, -2, 1, -2),
    }, true)
    Library:AddTheme(WindowBackground, {
        BackgroundColor3 = "Background",
    })
    local ItemsHolder = Library:New("Frame", {
        Name = "WindowBackground",
        Parent = WindowBackground,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 0),
        Size = UDim2new(1, 0, 0, 0),
    }, true)
    Library:New("UIPadding", {
        Parent = ItemsHolder,
        PaddingLeft = UDimnew(0, 5),
        PaddingRight = UDimnew(0, 5),
    }, true)
    local TitleBackground = Library:New("Frame", {
        Name = "TitleBackground",
        Parent = WindowBackground,
        BorderSizePixel = 0,
        Size = UDim2new(1, 0, 0, 24),
    }, true)
    Library:AddTheme(TitleBackground, {
        BackgroundColor3 = "Accent",
    })
    
    Library:New("UIPadding", {
        Parent = TitleBackground,
        PaddingBottom = UDimnew(0, 5),
        PaddingLeft = UDimnew(0, 5),
        PaddingRight = UDimnew(0, 5),
        PaddingTop = UDimnew(0, 5),
    }, true)
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(149, 149, 149))},
        Rotation = 90,
        Parent = TitleBackground,
    }, true)
    local TitleLabel = Library:New("TextLabel", {
        Name = "TitleLabel",
        Parent = TitleBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2new(0, 0, 1, 0),
        FontFace = Library.Font,
        Text = cfg.Name,
        TextSize = Library.FontSize,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, true)
    Library:AddTheme(TitleLabel, {
        TextColor3 = "Text",
    })
    local TitleOutline = Library:New("Frame", {
        Name = "TitleOutline",
        Parent = WindowBackground,
        BorderSizePixel = 0,
        Position = UDim2new(0, 0, 0, 24),
        Size = UDim2new(1, 0, 0, 1),
    }, true)
    Library:AddTheme(TitleOutline, {
        BackgroundColor3 = "Outline",
    })
    local List = {
        Items = {},
    }
    local YOffset = 0
    local BiggestX = TitleLabel.TextBounds.X
    local LerpedSize = TitleLabel.TextBounds.X
    function List.RenderItem(flag, text, status)
        if not List.Items[flag] then
            List.Items[flag] = {
                Object = Library:New("TextLabel", {
                    Name = "ItemLabel",
                    Parent = ItemsHolder,
                    BackgroundTransparency = 1,
                    TextTransparency = 1,
                    Position = UDim2new(0, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Size = UDim2new(0, 0, 0, 0),
                    FontFace = Library.Font,
                    Text = text,
                    TextSize = Library.FontSize,
                    TextStrokeTransparency = 0,
                }, true),
                Text = text,
                Status = status,
                Fade = 2,
            }
            Library:AddTheme(List.Items[flag].Object, {
                TextColor3 = "Text"
            })        
            return
        end
        local Item = List.Items[flag]
        local Object = Item.Object
        Item.Fade = Utility:Lerp(Item.Fade, status and 255 or 0, Library.LerpSpeed)
        Item.Text = text
        Item.Status = status
        
        Object.Text = Item.Text
        Object.Position = UDim2new(0, -(Object.TextBounds.X - (Object.TextBounds.X * (Item.Fade / 255))), 0, 30 + YOffset)
        Object.TextTransparency = 1 - (1 * (Item.Fade / 255))
        if status and BiggestX < Object.TextBounds.X then
            BiggestX = mathmax(BiggestX, Object.TextBounds.X)
        end
        YOffset += (Object.TextBounds.Y + 3) * (Item.Fade / 255)
    end
    function List.GetItems()
        return {
            {
                Text = "Test22222222",
                Flag = "flag1",
                Status = true,
            },
            {
                Text = "Test2",
                Flag = "flag2",
                Status = true,
            },
            {
                Text = "Test3",
                Flag = "flag3",
                Status = true,
            },
            {
                Text = "Test4",
                Flag = "flag4",
                Status = true,
            },
            {
                Text = "Test5",
                Flag = "flag5",
                Status = true,
            },
        }
    end
    function List.SetVisibility(status)
        WindowOutline.Visible = status
    end
    function List.Think()
        if not WindowOutline.Visible then
            return
        end
        YOffset = 0
        BiggestX = TitleLabel.TextBounds.X
        for _,v in List.GetItems() do
            List.RenderItem(v.Flag, v.Text, v.Status)
        end
        LerpedSize = Utility:Lerp(LerpedSize, BiggestX + 15, Library.LerpSpeed)
        WindowOutline.Size = UDim2new(0, LerpedSize, 0, 35 + YOffset)
    end
    return List
end
function Library:TextTriggers(text)
    local AccentTheme = Library.Theme.Accent
    local Triggers = {
        ['{user}'] = Lib.User,
        ['{name}'] = ('<font color="rgb(%s, %s, %s)">Puppyware</font>'):format(mathfloor(AccentTheme.r * 255), mathfloor(AccentTheme.g * 255), mathfloor(AccentTheme.b * 255)),
        ['{hour}'] = os.date("%H"),
        ['{minute}'] = os.date("%M"),
        ['{second}'] = os.date("%S"),
        ['{ap}'] = os.date("%p"),
        ['{month}'] = os.date("%b"),
        ['{day}'] = os.date("%d"),
        ['{year}'] = os.date("%Y"),
        ['{fps}'] = Library.Fps,
        ['{ping}'] = mathfloor(Stats.PerformanceStats.Ping:GetValue() or 0),
        ['{time}'] = os.date("%H:%M:%S"),
        ['{date}'] = os.date("%b. %d, %Y")
    }
    for _,v in Triggers do
        text = string.gsub(text, _, v)
    end
    return text
end
function Library:Watermark(cfg)
    cfg = {
        Text = cfg.Text or "{name} | {user} | rtt: {ping}ms | {time}",
        Visible = cfg.Visible or true,
        TickRate = cfg.TickRate or 0.2
    }
    local Watermark = {
        Visible = cfg.Visible,
        Text = cfg.Text,
        TickRate = cfg.TickRate,
        Time = osclock() - 1000
    }
    local WatermarkBackground = Library:New("Frame", {
        Name = "WatermarkBackground",
        Parent = Library.ListsGui,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2new(0, 10, 0, 5),
        Size = UDim2new(0, 0, 0, 0),
        Visible = cfg.Visible,
    }, true)
    local WatermarkLabel = Library:New("TextLabel", {
        Name = "WatermarkLabel",
        Parent = WatermarkBackground,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2new(0, 0, 0, 0),
        FontFace = Library.Font,
        TextSize = Library.FontSize,
        TextTransparency = 0,
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
    }, true)
    local WatermarkAccent = Library:New("Frame", {
        Name = "WatermarkAccent",
        Parent = WatermarkBackground,
        BorderSizePixel = 0,
        Position = UDim2new(0, -3, 0, -5),
        Size = UDim2new(1, 6, 0, 1),
    }, true)
    -- Utility:New("UIGradient", {
    --     Enabled = true,
    --     Rotation = 0,
    --     Parent = WatermarkBackground,
    --     Transparency = NumberSequence.new({
    --         NumberSequenceKeypoint.new(0, 0),
    --         NumberSequenceKeypoint.new(1, 1),
    --     })
    -- })
    Library:New("UIPadding", {
        Parent = WatermarkBackground,
        PaddingBottom = UDimnew(0, 3),
        PaddingLeft = UDimnew(0, 3),
        PaddingRight = UDimnew(0, 3),
        PaddingTop = UDimnew(0, 5),
    })
    Library:AddTheme(WatermarkAccent, {
        BackgroundColor3 = "Accent",
    })
    Library:AddTheme(WatermarkBackground, {
        BorderColor3 = "Outline",
        BackgroundColor3 = "Element Background",
    })
    -- Library:AddTheme(ToggleBackground, {
    --     BackgroundColor3 = "Element Background"
    -- })
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3fromRGB(124, 124, 124))},
        Rotation = 90,
        Parent = WatermarkBackground,
    })
    Library:AddTheme(WatermarkLabel, {
        TextColor3 = "Text",
    })
    function Watermark.Think()
        local ClockPulse = osclock()
        if ClockPulse - Watermark.Time < Watermark.TickRate then
            return
        end
        Watermark.Time = ClockPulse
        if WatermarkBackground.Visible ~= Watermark.Visible then
            WatermarkBackground.Visible = Watermark.Visible
        end
        if Watermark.Visible then
            local Text = Library:TextTriggers(Watermark.Text)
            WatermarkLabel.Text = Text
        end
    end
    function Watermark.SetText(text)
        Watermark.Text = text
    end
    function Watermark.SetTickRate(rate)
        Watermark.TickRate = rate
    end
    function Watermark.SetVisibility(status)
        Watermark.Visible = status
    end
    return Watermark
end 
local Flags = Library.Flags
