local uis = game:GetService("UserInputService") 
local players = game:GetService("Players") 
local ws = game:GetService("Workspace")
local http_service = game:GetService("HttpService")
local gui_service = game:GetService("GuiService")
local lighting = game:GetService("Lighting")
local run = game:GetService("RunService")
local stats = game:GetService("Stats")
local coregui = game:GetService("CoreGui")
local debris = game:GetService("Debris")
local tween_service = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")

local vec2 = Vector2.new
local vec3 = Vector3.new
local dim2 = UDim2.new
local dim = UDim.new 
local rect = Rect.new
local cfr = CFrame.new

local color = Color3.new
local rgb = Color3.fromRGB
local hex = Color3.fromHex
local hsv = Color3.fromHSV
local rgbseq = ColorSequence.new
local rgbkey = ColorSequenceKeypoint.new

local camera = ws.CurrentCamera
local lp = players.LocalPlayer 
local mouse = lp:GetMouse() 
local gui_offset = gui_service:GetGuiInset().Y

local max = math.max 
local floor = math.floor 
local min = math.min 
local abs = math.abs 

-- library init
    local library = {
        flags = {},
        config_flags = {},
        connections = {},   
        notifications = {}, 
        instances = {},
        main_frame = {}, 
        config_holder,
        current_tab, 
        current_element_open, 
        dock_button_holder,  
        gui, 
        sin = 0,
        keybind_path; 
        panel_open = false, 

        directory = "inactivity",
        folders = {
            "/fonts",
            "/configs"
        },
        font, 
    }

    local flags = library.flags
    local config_flags = library.config_flags
    
    local themes = {
        preset = {
            ["outline"] = rgb(32, 32, 38), -- 
            ["inline"] = rgb(60, 55, 75), --
            ["accent"] = rgb(100, 100, 255), --
            ["contrast"] = rgb(35, 35, 47),
            ["text"] = rgb(170, 170, 170),
            ["unselected_text"] = rgb(90, 90, 90),
            ["text_outline"] = rgb(0, 0, 0),
            ["glow"] = rgb(100, 100, 255), 
        }, 	

        utility = {
            ["outline"] = {
                ["BackgroundColor3"] = {}, 	
                ["Color"] = {}, 
            },
            ["inline"] = {
                ["BackgroundColor3"] = {}, 	
            },
            ["accent"] = {
                ["BackgroundColor3"] = {}, 	
                ["TextColor3"] = {}, 
                ["ImageColor3"] = {}, 
                ["BorderColor3"] = {},
                ["ScrollBarImageColor3"] = {} 
            },
            ["contrast"] = {
                ["Color"] = {}, 	
            },
            ["text"] = {
                ["TextColor3"] = {}, 	
            },
            ["text_outline"] = {
                ["Color"] = {}, 	
            },
            ["glow"] = {
                ["ImageColor3"] = {}, 	
            }, 
        }, 
    }

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end 

    if not isfile(library.directory .. "/fonts/main.ttf") then 
        writefile(library.directory .. "/fonts/main.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/uis/font.ttf"))
    end 
    
    local tahoma = {
        name = "SmallestPixel7",
        faces = {
            {
                name = "Regular",
                weight = 400,
                style = "normal",
                assetId = getcustomasset(library.directory .. "/fonts/main.ttf")
            }
        }
    }
    
    if not isfile(library.directory .. "/fonts/main_encoded.ttf") then 
        writefile(library.directory .. "/fonts/main_encoded.ttf", http_service:JSONEncode(tahoma))
    end 
    
    library.font = Font.new(getcustomasset(library.directory .. "/fonts/main_encoded.ttf"), Enum.FontWeight.Regular)
-- 

-- functions 
    -- misc functions
        function library.to_screen_point(position) 
            return camera:WorldToViewportPoint(position)
        end 	

        function library:convert_string_rgb(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                table.insert(values, tonumber(value))
            end
            
            if #values == 4 then
                local r, g, b, a = values[1], values[2], values[3], values[4]
                
                return r, g, b, a
            else 
                library:notification({text = "Input a correct RGBA value (in the format 255, 255, 255, 0.5)"})
            end
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            table.insert(library.connections, connection)

            return connection 
        end

        function library:make_resizable(frame) 
            local Frame = Instance.new("TextButton")
            Frame.Position = dim2(1, -10, 1, -10)
            Frame.BorderColor3 = rgb(0, 0, 0)
            Frame.Size = dim2(0, 10, 0, 10)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = rgb(255, 255, 255)
            Frame.Parent = frame
            Frame.BackgroundTransparency = 1 
            Frame.Text = ""

            local resizing = false 
            local start_size 
            local start 
            local og_size = frame.Size  

            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = true
                    start = input.Position
                    start_size = frame.Size
                end
            end)

            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mouse_pos = vec2(mouse.X, mouse.Y)
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    current_size = dim2(
                        start_size.X.Scale,
                        math.clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            og_size.X.Offset,
                            viewport_x
                        ),
                        start_size.Y.Scale,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            og_size.Y.Offset,
                            viewport_y
                        )
                    )
                    frame.Size = current_size
                end
            end)
        end

        function library:new_item(class, properties) 
            local ins = Instance.new(class)

            for _, v in next, properties do 
                ins[_] = v
            end 

            table.insert(library.instances, ins)

            return ins 
        end 
        
        function library:animation(text) 
            local pattern = {} for i = 1, tonumber(text:len()) do table.insert(pattern, string.sub(text, 1, i)) end for i = tonumber(text:len()) - 1, 0, -1 do table.insert(pattern, string.sub(text, 1, i)) end return pattern 
        end 

        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                table.insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        function library:config_list_update() 
            if not library.config_holder then return end; 
        
            local list = {};
        
            for idx, file in next, listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(library.directory .. "\\configs\\", ""):gsub(".cfg", "")
                list[#list + 1] = name;
            end;
            
            library.config_holder:refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
        
            for _, v in flags do
                if type(v) == "table" and v.key then
                    Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
                elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                    Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
                else
                    Config[_] = v
                end
            end 
            
            return http_service:JSONEncode(Config)
        end

        function library:load_config(config_json) 
            local config = http_service:JSONDecode(config_json)
        
            for _, v in next, config do 
                local function_set = library.config_flags[_]
        
                if function_set then 
                    if type(v) == "table" and v["Transparency"] and v["Color"] then
                        function_set(hex(v["Color"]), v["Transparency"])
                    elseif type(v) == "table" and v["active"] then 
                        function_set(v)
                    else 
                        function_set(v)
                    end
                end 
            end 
        end 
        
        function library:round(number, float) 
            local multiplier = 1 / (float or 1)
            return math.floor(number * multiplier + 0.5) / multiplier
        end 

        function library:apply_theme(instance, theme, property) 
            table.insert(themes.utility[theme][property], instance)
        end

        function library:update_theme(theme, color)
            for _, property in next, themes.utility[theme] do 

                for m, object in next, property do 
                    if object[_] == themes.preset[theme] or object.ClassName == "UIGradient" then 
                        object[_] = color 
                    end 
                end 
            end 

            themes.preset[theme] = color 
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            table.insert(library.connections, connection)

            return connection 
        end

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in next, options do 
                ins[prop] = value
            end

            return ins 
        end
    -- 

    library.gui = library:create("ScreenGui", {
        Enabled = true,
        Parent = coregui,
        Name = "",
        DisplayOrder = 2, 
        ZIndexBehavior = 1, 
    })
    
    -- library functions 
        function library:window(properties) 
            local cfg = {
                name = properties.Name or properties.name or properties.Title or properties.title or "ledger.live", 
                size = properties.Size or properties.size or dim2(0, 500, 0, 650)
            }
            
            local animated_text = library:animation( cfg.name .. " | developer | uid 1") 

            -- watermark 
                local __holder = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 20, 0, 20),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })
                
                local inline1 = library:create("Frame", {
                    Parent = __holder,
                    Name = "",
                    Active = true, 
                    Draggable = true, 
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, ((#animated_text / 2) * 5) + 13, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })
                
                local accent_line = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent 
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 
                
                local depth = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                local inline2 = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local main = library:create("Frame", {
                    Parent = inline2,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(57, 57, 57),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local tab_inline = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 6, 0, 6),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(19, 19, 19)
                })
                
                local tabs = library:create("Frame", {
                    Parent = tab_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local name = library:create("TextLabel", {
                    Parent = tabs,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "ledger.live",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(0, 0, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local TEXT_ANIMATION_GRADIENT = library:create("UIGradient", {
                    Parent = name,
                    Name = "",
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(0.01, themes.preset.accent),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    }
                })                
                
                local UIPadding = library:create("UIPadding", {
                    Parent = tabs,
                    Name = "",
                    PaddingRight = UDim.new(0, 21)
                })
                
                local glow = library:create("ImageLabel", {
                    Parent = accent_line,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 0, 42),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
                
                task.spawn(function()
                    while true do 
                        if __holder.Visible then 
                            for i = 1, #animated_text do 
                                task.wait(.2)
                                name.Text = animated_text[i]
                            end 
                        end 
                        task.wait(.2)
                    end 
                end)
            -- 

            -- window
                local inline1 = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    Active = true, 
                    Draggable = true,
                    Position = UDim2.new(0.5, -cfg.size.X.Offset/2, 0.5, -cfg.size.Y.Offset/2),
                    BorderColor3 = Color3.fromRGB(8, 8, 8),
                    ZIndex = 2,
                    Size = cfg.size,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }) table.insert(library.main_frame, inline1)
                local WINDOW_PATH = inline1
                library:make_resizable(inline1)
                
                local inline2 = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local main = library:create("Frame", {
                    Parent = inline2,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(57, 57, 57),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local tab_buttons = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 16, 0, 4),
                    Size = UDim2.new(1, -32, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                cfg["tab_holder"] = tab_buttons
                
                local list = library:create("UIListLayout", {
                    Parent = tab_buttons,
                    Name = "",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local tab_inline = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 15, 0, 33),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -30, 1, -48),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(19, 19, 19)
                })
                
                local tabs = library:create("Frame", {
                    Parent = tab_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })

                cfg["tab_instance_holder"] = tabs
                
                local accent_line = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 
                
                local name = library:create("TextLabel", {
                    Parent = inline1,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local glow = library:create("ImageLabel", {
                    Parent = inline1,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 0, 42),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })
                library:apply_theme(glow, "accent", "ImageColor3") 
                
                local depth = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                local holder = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 20, 0, 0),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })      

                task.spawn(function()
                    while true do 
                        if flags["color_picker_anim_speed"] then 
                            library.sin = math.abs(math.sin(tick() * flags["color_picker_anim_speed"]))

                            TEXT_ANIMATION_GRADIENT.Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(math.abs(math.sin(tick())), themes.preset.accent),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                            }
                        end 
                        task.wait()
                    end 
                end)
            -- 

            -- esp preview
                local esp_preview = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    Visible = false, 
                    Active = true, 
                    Draggable = true, 
                    Position = UDim2.new(0, inline1.AbsolutePosition.X + inline1.AbsoluteSize.X + 8, 0, inline1.AbsolutePosition.Y + 1), 
                    BorderColor3 = Color3.fromRGB(8, 8, 8),
                    Size = UDim2.new(0, 328, 0, 376),
                    BackgroundColor3 = Color3.fromRGB(56, 56, 56)
                }) library:make_resizable(esp_preview)

                local name = library:create("TextLabel", {
                    Parent = esp_preview,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "esp preview",
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local UIPadding = library:create("UIPadding", {
                    Parent = name,
                    Name = ""
                })

                local main = library:create("Frame", {
                    Parent = esp_preview,
                    Name = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(26, 26, 26),
                    Size = UDim2.new(1, -8, 1, -8),
                    BorderSizePixel = 2,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })

                library:create("UIStroke", {
                    Parent = main,
                    Name = "",
                    Color = Color3.fromRGB(57, 57, 57),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local tabs = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 8, 0, 8),
                    BorderColor3 = Color3.fromRGB(8, 8, 8),
                    Size = UDim2.new(1, -16, 1, -16),
                    BorderSizePixel = 2,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })

                library:create("UIStroke", {
                    Parent = tabs,
                    Name = "",
                    Color = Color3.fromRGB(57, 57, 57),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local hitpart = library:create("Frame", {
                    Parent = tabs,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 20),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })

                local head = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -25, 0, 16),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 50, 0, 44),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local torso = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 84, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local l_arm = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -86, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local r_arm = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 46, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local r_leg = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 2, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local l_leg = library:create("Frame", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local hrp = library:create("Frame", {
                    Parent = hrp_out,
                    Name = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -8, 1, -8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                local glow_patterns = {} 

                for _, v in next, hitpart:GetChildren() do 
                    local glow = library:create("ImageLabel", {
                        Parent = v,
                        Name = "",
                        Visible = false, 
                        ImageColor3 = themes.preset.accent,
                        ScaleType = Enum.ScaleType.Slice,
                        ImageTransparency = 0.8999999761581421,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Image = "http://www.roblox.com/asset/?id=18245826428",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, -20, 0, -20),
                        Size = UDim2.new(1, 40, 1, 40),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                    })

                    library:apply_theme(glow, "accent", "ImageColor3") 

                    table.insert(glow_patterns, glow)
                end 

                function cfg.preview_chams(bool) 
                    for _, glow in next, glow_patterns do 
                        glow.Visible = bool
                    end 

                    for _, part in next, hitpart:GetChildren() do 
                        part.BackgroundColor3 = bool and themes.preset.accent or Color3.fromRGB(38, 38, 38)
                    end 
                end 

                local player = library:create("Frame", {
                    Parent = tabs,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 43, 0, 28),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -86, 1, -106),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local line_holder = library:create("Frame", {
                    Parent = player,
                    Name = "",
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 50,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local box_outline = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -1, 0, -1),
                    ZIndex = 50,
                    Size = UDim2.new(1, 2, 1, 2),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local BoxLine2 = library:create("UIStroke", {
                    Parent = box_outline,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local box_color = library:create("UIStroke", {
                    Parent = line_holder,
                    Name = "",
                    Color = Color3.fromRGB(255, 255, 255),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local corner_box = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local top_left = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0, 1, 0.30000001192092896, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local top_right = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -1, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0, 1, 0.30000001192092896, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local bottom_left = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0.4000000059604645, 0, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local bottom_right = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, -1, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0.4000000059604645, 0, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local bottom_left2 = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0, 1, 0.30000001192092896, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local bottom_right2 = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0, 1, 0.30000001192092896, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local top_left2 = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0.4000000059604645, 0, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local top_right2 = library:create("Frame", {
                    Parent = corner_box,
                    Name = "",
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, -1, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    Size = UDim2.new(0.4000000059604645, 0, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                function cfg.preview_corner_boxes(bool)
                    corner_box.Visible = bool == "Corner" and true or false 
                    BoxLine2.Enabled = bool == "Corner" and false or true 
                    box_outline.Visible = bool == "Corner" and false or true 
                    box_color.Enabled = bool == "Corner" and false or true 
                end 

                function cfg.preview_bounding_box(bool)
                    BoxLine2.Enabled = bool
                    box_outline.Visible = bool 
                    box_color.Enabled = bool 
                end  

                local bottom_holder = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -1, 1, 3),
                    Size = UDim2.new(1, 2, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local UIListLayout = library:create("UIListLayout", {
                    Parent = bottom_holder,
                    Name = "",
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                local UIPadding = library:create("UIPadding", {
                    Parent = bottom_holder,
                    Name = "",
                    PaddingTop = UDim.new(0, 1)
                })

                local bar_holder = library:create("Frame", {
                    Parent = bottom_holder,
                    Name = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 4),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local reload_bar = library:create("Frame", {
                    Parent = bar_holder,
                    Name = "",
                    Size = UDim2.new(1, 0, 0, 4),
                    ZIndex = 50,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                function cfg.preview_reload_bar(bool)
                    bar_holder.Visible = bool
                end 

                local reload_slider = library:create("Frame", {
                    Parent = reload_bar,
                    Name = "",
                    Size = UDim2.new(0.5, -2, 0, 2),
                    Position = UDim2.new(0, 1, 0, 1),
                    ZIndex = 50,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(28, 145, 255)
                })

                local gradient = library:create("UIGradient", {
                    Parent = reload_slider,
                    Name = "",
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 238)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 238))
                }
                })

                local UIStroke = library:create("UIStroke", {
                    Parent = distance,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local weapon = library:create("TextLabel", {
                    Parent = bottom_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Text = "double barrel",
                    TextStrokeTransparency = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.031031031161546707, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ZIndex = 50,
                    TextSize = 12,
                    Size = UDim2.new(1, 0, 0, 4)
                })

                function cfg.preview_weapon(bool)
                    weapon.Visible = bool
                end 

                local UIStroke = library:create("UIStroke", {
                    Parent = weapon,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local UIStroke = library:create("UIStroke", {
                    Parent = distance,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local image_holder = library:create("Frame", {
                    Parent = bottom_holder,
                    Name = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                function cfg.preview_icons(bool)
                    image_holder.Visible = bool
                end 

                local ImageLabel = library:create("ImageLabel", {
                    Parent = image_holder,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0),
                    Image = "rbxassetid://130516018594923",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Size = UDim2.new(0, 64, 0, 27),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local armor = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    Position = UDim2.new(0, -14, 0, -2),
                    Size = UDim2.new(0, 4, 1, 4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                function cfg.preview_armor(bool)
                    armor.Visible = bool
                end 

                local armor_slider = library:create("Frame", {
                    Parent = armor,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0.5, 0, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 13, 255)
                })

                local armor_gradient = library:create("UIGradient", {
                    Parent = armor_slider,
                    Name = "",
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 242, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 17, 255))
                },
                    Enabled = false
                })

                local armor_text = library:create("TextLabel", {
                    Parent = armor_slider,
                    Name = "",
                    ZIndex = 99,
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(0, 13, 255),
                    Text = "100",
                    Position = UDim2.new(0, -2, 0.75, -2),
                    TextStrokeTransparency = 0,
                    AnchorPoint = Vector2.new(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Active = true,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(26, 255, 0)
                })

                library:create("UIStroke", {
                    Parent = armor_text,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local health = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    Position = UDim2.new(0, -8, 0, -2),
                    Size = UDim2.new(0, 4, 1, 4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                function cfg.preview_health(bool)
                    health.Visible = bool
                end 

                local health_slider = library:create("Frame", {
                    Parent = health,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0.5, 0, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 255, 42)
                })

                local health_text = library:create("TextLabel", {
                    Parent = health_slider,
                    Name = "",
                    Visible = false,
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(0, 255, 0),
                    Text = "100",
                    ZIndex = 99,
                    TextStrokeTransparency = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0, -4, 0.5, -2),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Active = true,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(26, 255, 0)
                })

                local UIStroke = library:create("UIStroke", {
                    Parent = health_text,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local box_inline = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 1, 0, 1),
                    ZIndex = 50,
                    Size = UDim2.new(1, -2, 1, -2),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local BoxLine3 = library:create("UIStroke", {
                    Parent = box_inline,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local gradient = library:create("UIGradient", {
                    Parent = line_holder,
                    Name = "",
                    Rotation = -180,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0.5),
                    NumberSequenceKeypoint.new(1, 0.5)
                },
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                }
                })

                function cfg.preview_filler(bool)
                    line_holder.BackgroundTransparency = bool and 0 or 1
                    gradient.Enabled = bool
                end 

                local top_holder = library:create("Frame", {
                    Parent = line_holder,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -2, 0, -4),
                    Size = UDim2.new(1, 4, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                library:create("UIListLayout", {
                    Parent = top_holder,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                library:create("UIPadding", {
                    Parent = top_holder,
                    Name = "",
                    PaddingTop = UDim.new(0, 1)
                })

                local player_name = library:create("TextLabel", {
                    Parent = top_holder,
                    Name = "",
                    RichText = true,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Text = "hello there",
                    FontFace = library.font,
                    AnchorPoint = Vector2.new(0, 1),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -2),
                    BorderSizePixel = 0,
                    ZIndex = 50,
                    TextSize = 12,
                    Size = UDim2.new(1, 0, 0, 0)
                })

                function cfg.preview_names(bool)
                    player_name.Visible = bool
                end 

                local UIStroke = library:create("UIStroke", {
                    Parent = player_name,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                local accent_line = library:create("Frame", {
                    Parent = esp_preview,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 

                local depth = library:create("Frame", {
                    Parent = esp_preview,
                    Name = "",
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                local glow = library:create("ImageLabel", {
                    Parent = esp_preview,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 0, 42),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
            -- 
            
            -- playerlist 
                local selected_button; 
                local selected_player; 
                local player_buttons = {}

                function library.get_priority(player)
                    return player_buttons[player.Name].priority.Text
                end 

                local playerlist = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    Active = true,
                    Draggable = true, 
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, inline1.AbsolutePosition.X - 358 - 8, 0, inline1.AbsolutePosition.Y + 1),
                    BorderColor3 = Color3.fromRGB(8, 8, 8),
                    Size = UDim2.new(0, 358, 0, 328),
                    BackgroundColor3 = Color3.fromRGB(56, 56, 56)
                }) library:make_resizable(playerlist)
                
                table.insert(library.main_frame, playerlist)
                
                local name = library:create("TextLabel", {
                    Parent = playerlist,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "playerlist",
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = name,
                    Name = ""
                })
                
                local main = library:create("Frame", {
                    Parent = playerlist,
                    Name = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(26, 26, 26),
                    Size = UDim2.new(1, -8, 1, -8),
                    BorderSizePixel = 2,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                library:create("UIStroke", {
                    Parent = main,
                    Name = "",
                    Color = Color3.fromRGB(57, 57, 57),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                local tabs = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 8, 0, 8),
                    BorderColor3 = Color3.fromRGB(8, 8, 8),
                    Size = UDim2.new(1, -16, 1, -16),
                    BorderSizePixel = 2,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                library:create("UIStroke", {
                    Parent = tabs,
                    Name = "",
                    Color = Color3.fromRGB(57, 57, 57),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                local list = library:create("Frame", {
                    Parent = tabs,
                    Name = "",
                    Position = UDim2.new(0, 14, 0, 14),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -28, 0.75, -28),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local inline = library:create("Frame", {
                    Parent = list,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = background,
                    Name = "",
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(167, 167, 167))
                }
                })
                
                local contrast = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local __ScrollingFrame = library:create("ScrollingFrame", {
                    Parent = contrast,
                    Name = "",
                    ScrollBarImageColor3 = themes.preset.accent,
                    MidImage = "rbxassetid://18406573371",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    TopImage = "rbxassetid://18406573371",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1.0099999904632568,
                    BottomImage = "rbxassetid://18406573371",
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })

                library:apply_theme(__ScrollingFrame, "accent", "ScrollBarImageColor3") 
                
                local UIPadding = library:create("UIPadding", {
                    Parent = __ScrollingFrame,
                    Name = "",
                    PaddingTop = UDim.new(0, 4),
                    PaddingBottom = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 4),
                    PaddingLeft = UDim.new(0, 4)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = __ScrollingFrame,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local info = library:create("Frame", {
                    Parent = tabs,
                    Name = "",
                    Position = UDim2.new(0, 14, 0.75, -5),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -28, 0.30000001192092896, -23),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local inline = library:create("Frame", {
                    Parent = info,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = background,
                    Name = "",
                    Rotation = 90,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(167, 167, 167))
                    }
                })
                
                local contrast = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local ScrollingFrame = library:create("ScrollingFrame", {
                    Parent = contrast,
                    Name = "",
                    ScrollBarImageColor3 = Color3.fromRGB(155, 125, 175),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 3,
                    BackgroundTransparency = 1.0099999904632568,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = ScrollingFrame,
                    Name = "",
                    PaddingTop = UDim.new(0, 7),
                    PaddingBottom = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 4),
                    PaddingLeft = UDim.new(0, 10)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = ScrollingFrame,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local display_name_label = library:create("TextLabel", {
                    Parent = ScrollingFrame,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(180, 180, 180),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "Display Name: ...",
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                library:create("UIStroke", {
                    Parent = display_name_label,
                    Name = ""
                })
                
                local name_label = library:create("TextLabel", {
                    Parent = ScrollingFrame,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(180, 180, 180),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "Name: ...",
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                library:create("UIStroke", {
                    Parent = name_label,
                    Name = ""
                })
                
                local priority_label = library:create("TextLabel", {
                    Parent = ScrollingFrame,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(180, 180, 180),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "Priority: Friendly",
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                library:create("UIStroke", {
                    Parent = priority_label,
                    Name = ""
                })
                
                local Frame = library:create("Frame", {
                    Parent = contrast,
                    Name = "",
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -10, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -200, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local button_inline = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    Position = UDim2.new(0, -15, 0, 2),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -26, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local button = library:create("TextButton", {
                    Parent = button_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "Neutral",
                    TextStrokeTransparency = 0.5,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(1, -4, 1, -4),
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                button.MouseButton1Click:Connect(function()
                    player_buttons[selected_player.Name].priority.Text = "Neutral"
                    player_buttons[selected_player.Name].priority.TextColor3 = rgb(180, 180, 180)
                end)
                
                local button_inline = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    Position = UDim2.new(0, -15, 0, 2),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -26, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local button = library:create("TextButton", {
                    Parent = button_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "Friendly",
                    TextStrokeTransparency = 0.5,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(1, -4, 1, -4),
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                button.MouseButton1Click:Connect(function()
                    player_buttons[selected_player.Name].priority.Text = "Friendly"
                    player_buttons[selected_player.Name].priority.TextColor3 = rgb(15, 179, 255)
                end)
                
                local button_inline = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    Position = UDim2.new(0, -15, 0, 2),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -26, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local button = library:create("TextButton", {
                    Parent = button_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "Enemy",
                    TextStrokeTransparency = 0.5,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(1, -4, 1, -4),
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })

                button.MouseButton1Click:Connect(function()
                    player_buttons[selected_player.Name].priority.Text = "Enemy"
                    player_buttons[selected_player.Name].priority.TextColor3 = rgb(255, 44, 44)
                end)
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = Frame,
                    Name = "",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 4)
                })
                
                local accent_line = library:create("Frame", {
                    Parent = playerlist,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 
                
                local depth = library:create("Frame", {
                    Parent = playerlist,
                    Name = "",
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                local glow = library:create("ImageLabel", {
                    Parent = playerlist,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 0, 42),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })  

                library:apply_theme(glow, "accent", "ImageColor3") 

                local function create_player(player)
                    local TextButton = library:create("TextButton", {
                        Parent = __ScrollingFrame,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    player_buttons[player.Name] = {}
                    player_buttons[player.Name].instance = TextButton

                    local TextLabel = library:create("TextLabel", {
                        Parent = TextButton,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = player.Name,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    library:create("UIStroke", {
                        Parent = TextLabel,
                        Name = ""
                    })

                    local TextLabel = library:create("TextLabel", {
                        Parent = TextButton,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = player.Team and tostring(player.Team) or "None",
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    library:create("UIStroke", {
                        Parent = TextLabel,
                        Name = ""
                    })

                    local Frame = library:create("Frame", {
                        Parent = TextLabel,
                        Name = "",
                        Position = UDim2.new(0, -10, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 1, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(32, 32, 38)
                    })

                    local TextLabel = library:create("TextLabel", {
                        Parent = TextButton,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "Neutral",
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    player_buttons[player.Name].priority = TextLabel

                    library:create("UIStroke", {
                        Parent = TextLabel,
                        Name = ""
                    })

                    local Frame = library:create("Frame", {
                        Parent = TextLabel,
                        Name = "",
                        Position = UDim2.new(0, -10, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 1, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(32, 32, 38)
                    })

                    local UIListLayout = library:create("UIListLayout", {
                        Parent = TextButton,
                        Name = "",
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    })

                    local UIPadding = library:create("UIPadding", {
                        Parent = TextButton,
                        Name = "",
                        PaddingRight = UDim.new(0, 2),
                        PaddingLeft = UDim.new(0, 2)
                    })

                    local line = library:create("Frame", {
                        Parent = tabs,
                        Name = "",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(1, 0, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(32, 32, 38)
                    })

                    TextButton.MouseButton1Click:Connect(function()
                        if selected_button then 
                            selected_button.BackgroundTransparency = 1
                        end 

                        selected_button = TextButton
                        selected_player = player 
                        TextButton.BackgroundTransparency = .85

                        priority_label.Text = "Priority: " .. library.get_priority(player)
                        name_label.Text = "Name: " .. player.Name 
                        display_name_label.Text = "Display: " .. player.DisplayName 
                    end)
                end 
                
                for _, player in next, players:GetPlayers() do 
                    create_player(player)
                end 

                library:connection(players.PlayerAdded, function(player)
                    create_player(player)
                end)

                library:connection(players.PlayerRemoving, function(player)
                    player_buttons[player.Name].instance:Destroy() 
                end)
            -- 
            
            -- keybind list
                local old_kblist = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 20, 0.5, 0),
                    ZIndex = 2,
                    Active = true, 
                    Draggable = true, 
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })
                
                local glow = library:create("ImageLabel", {
                    Parent = old_kblist,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 0, 42),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
                
                local inline1 = library:create("Frame", {
                    Parent = old_kblist,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })
                
                local accent_line = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 
                
                local name = library:create("TextLabel", {
                    Parent = inline1,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "keybinds",
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local inline2 = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local main = library:create("Frame", {
                    Parent = inline2,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(57, 57, 57),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local tab_inline = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 6, 0, 6),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(19, 19, 19)
                })
                
                local tabs = library:create("Frame", {
                    Parent = tab_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = tabs,
                    Name = "",
                    PaddingBottom = UDim.new(0, 22),
                    PaddingRight = UDim.new(0, 20),
                    PaddingLeft = UDim.new(0, 20)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = tabs,
                    Name = "",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 3)
                })
                
                local UIStroke = library:create("UIStroke", {
                    Parent = tabs,
                    Name = "",
                    Color = Color3.fromRGB(57, 57, 57),
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                local depth = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                library.keybind_path = tabs
            -- 

            function cfg.toggle_list(bool) 
                old_kblist.Visible = bool 
            end

            function cfg.toggle_playerlist(bool) 
                playerlist.Visible = bool 
            end   
            
            function cfg.toggle_watermark(bool) 
                __holder.Visible = bool
            end   

            function cfg.set_menu_visibility(bool, pl)
                WINDOW_PATH.Visible = bool

                playerlist.Visible = flags["player_list"] and bool or false 
            end 

            return setmetatable(cfg, library)
        end 

        function library:new_keybind(properties)
            local cfg = {text = properties.name or properties.text or "[mb1] aimbot (hold)"}

            local aimbot = library:create("TextLabel", {
                Parent = library.keybind_path,
                Name = "",
                FontFace = library.font,
                LineHeight = 1.2000000476837158,
                TextStrokeTransparency = 0.5,
                AnchorPoint = Vector2.new(0.5, 0),
                TextSize = 12,
                Size = UDim2.new(0, 0, 0, 11),
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Text = "[mb1] aimbot (hold)",
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0, 8),
                BorderSizePixel = 0,
                Visible = true, 
                TextYAlignment = Enum.TextYAlignment.Top,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })
            
            local UIPadding = library:create("UIPadding", {
                Parent = aimbot,
                Name = "",
                PaddingTop = UDim.new(0, 6)
            })

            function cfg.set_visible(bool) 
                aimbot.Visible = bool
            end 

            function cfg.change_text(text)
                aimbot.Text = text
            end 

            cfg.change_text(cfg.text)

            return cfg 
        end 

        function library:notification(properties)
            local cfg = {
                time = properties.time or 5,
                text = properties.text or properties.name or "ledger.live is pasted"
            }

            -- 28 offset

            function cfg:refresh_notifications()  
                for _, notif in next, library.notifications do 
                    tween_service:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Position = dim2(0, 20, 0, 72 + (_ * 28))}):Play()
                end     
            end 

            -- Instances
                local holder = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 20, 0, 72 + (#library.notifications * 28)),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    AnchorPoint = Vector2.new(1, 0)
                })

                local inline1 = library:create("Frame", {
                    Parent = holder,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 0, 0, 24),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                })
                
                local inline2 = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    Position = UDim2.new(0, 0, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local main = library:create("Frame", {
                    Parent = inline2,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(57, 57, 57),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                })
                
                local tab_inline = library:create("Frame", {
                    Parent = main,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(19, 19, 19)
                })
                
                local name = library:create("TextLabel", {
                    Parent = tab_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.text,
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(0, 0, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = tab_inline,
                    Name = "",
                    PaddingRight = UDim.new(0, 14)
                })
                
                local depth = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 1, 0, 0),
                    Size = UDim2.new(0, 1, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                local accent_line = library:create("Frame", {
                    Parent = inline1,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(34, 34, 34),
                    Size = UDim2.new(0, 2, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })

                library:apply_theme(accent_line, "accent", "BackgroundColor3") 
                
                local glow = library:create("ImageLabel", {
                    Parent = holder,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, 0),
                    Size = UDim2.new(0, 42, 1, 40),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
            -- 

            task.spawn(function()
                tween_service:Create(holder, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(0, 0)}):Play()

                task.wait(cfg.time)

                tween_service:Create(holder, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1, 0)}):Play()
                for _, v in next, holder:GetDescendants() do 
                    if v:IsA("TextLabel") then 
                        tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
                    elseif v:IsA("Frame") then 
                        tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
                    elseif v:IsA("ImageLabel") then 
                        tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 1}):Play()
                    end 
                end   
            end)

            task.delay(cfg.time + .1, function()
                table.remove(library.notifications, table.find(library.notifications, holder))
                cfg:refresh_notifications()   
                task.wait(.5)
                holder:Destroy()
            end)

            table.insert(library.notifications, holder)
        end 

        function library:tab(properties)
            local cfg = {
                name = properties.name or "tab", 
                enabled = false, 
            }

            -- Button
                local TAB_BUTTON = library:create("TextButton", {
                    Parent = self.tab_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = themes.preset.unselected_text,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.3330000042915344, -4, 0, 22),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local line = library:create("Frame", {
                    Parent = TAB_BUTTON,
                    Name = "",
                    Position = UDim2.new(0, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(57, 57, 57)
                })

                library:apply_theme(line, "accent", "BackgroundColor3") 
                
                local glow = library:create("ImageLabel", {
                    Parent = line,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 1, 40),
                    ZIndex = 2,
                    Visible = false, 
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
                
                local depth = library:create("Frame", {
                    Parent = line,
                    Name = "",
                    BackgroundTransparency = 0.5,
                    Position = UDim2.new(0, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
            -- 

            -- Tab Instances
                local TAB = library:create("Frame", {
                    Parent = self.tab_instance_holder,
                    Name = "",
                    Visible = false,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,1,0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local scrolling_columns = library:create("Frame", {
                    Parent = TAB,
                    Name = "",
                    ClipsDescendants = true,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 6, 0, 6),
                    Size = UDim2.new(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                cfg["column_holder"] = scrolling_columns
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = scrolling_columns,
                    Name = "",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                local left = library:create("ScrollingFrame", {
                    Parent = scrolling_columns,
                    Name = "",
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    Size = UDim2.new(0.5, -64, 1, 0),
                    ClipsDescendants = false,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 4, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })

                left:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    if library.current_element_open then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                        library.current_element_open = nil
                    end
                end)   

                cfg["left"] = left
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = left,
                    Name = "",
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = left,
                    Name = "",
                    PaddingBottom = UDim.new(0, 15)
                })

                local right = library:create("ScrollingFrame", {
                    Parent = scrolling_columns, 
                    Name = "",
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    Size = UDim2.new(0.5, -64, 1, 0),
                    ClipsDescendants = false,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, -50, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })

                right:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    if library.current_element_open then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                        library.current_element_open = nil
                    end
                end) 
                
                cfg["right"] = right
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = right,
                    Name = "",
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = right,
                    Name = "",
                    PaddingBottom = UDim.new(0, 15)
                })                
            -- 

            function cfg.open_tab()
                if library.current_tab and library.current_tab[1] ~= TAB_BUTTON then 
                    local button = library.current_tab[1]
                    button.TextColor3 = themes.preset.unselected_text

                    local parent = button:FindFirstChildOfClass("Frame")
                    parent.BackgroundColor3 = rgb(57, 57, 57)
                    parent:FindFirstChildOfClass("ImageLabel").Visible = false

                    library.current_tab[2].Visible = false 
                end
                
                library.current_tab = {
                    TAB_BUTTON, TAB
                }
                
                line.BackgroundColor3 = themes.preset.accent 
                glow.Visible = true
                TAB_BUTTON.TextColor3 = themes.preset.text 
                TAB.Visible = true

                if library.current_element_open and library.current_element_open ~= cfg then 
                    library.current_element_open.set_visible(false)
                    library.current_element_open.open = false 
                    library.current_element_open = nil 
                end
            end 

            TAB_BUTTON.MouseButton1Click:Connect(cfg.open_tab) 

            return setmetatable(cfg, library) 
        end 

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "Section", 
                side = properties.side or properties.Side or "left" 
            }

            -- Instances
                local section = library:create("Frame", {
                    Parent = self[cfg.side],
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local section_inline = library:create("Frame", {
                    Parent = section,
                    Name = "",
                    Position = UDim2.new(0, 0, 0, 4),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, 0, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local name = library:create("TextLabel", {
                    Parent = section_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 8, 0, 0),
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local section = library:create("Frame", {
                    Parent = section_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                local elements = library:create("Frame", {
                    Parent = section,
                    Name = "",
                    Position = UDim2.new(0, 12, 0, 12),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -24, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = elements,
                    Name = "",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 3)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = section,
                    Name = "",
                    PaddingBottom = UDim.new(0, 13)
                })    
            --        

            cfg["holder"] = elements

            return setmetatable(cfg, library)
        end

        function library:hitpart_picker(properties) 
            local cfg = {
                name = properties.name or properties.Name or "Hitpart", 
                side = properties.side or properties.Side or "left",
                flag = properties.flag or "Hitpart", 
                default = properties.default or {"Head"},
                type_char = properties.type or "R6",
            }

            flags[cfg.flag] = {}

            local bodyparts = {}
            local bools = {} 

            local r15_hitpart_holder = library:create("Frame", {
                Parent = self[cfg.side],
                Name = "",
                BackgroundTransparency = 1,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, 0, 0, 272),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })
            
            local hitpart_inline = library:create("Frame", {
                Parent = r15_hitpart_holder,
                Name = "",
                Position = UDim2.new(0, 0, 0, 4),
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                Size = UDim2.new(1, 0, 1, -4),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            })
            
            local hitpart = library:create("Frame", {
                Parent = hitpart_inline,
                Name = "",
                Position = UDim2.new(0, 2, 0, 2),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Size = UDim2.new(1, -4, 1, -4),
                BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            })
            
            if cfg.type_char == "R15" then 
                bodyparts.Head = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -25, 0, 16),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 50, 0, 44),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.UpperTorso = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 84, 0, 76),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftUpperArm = library:create("TextButton", {
                    Text = "", 
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -86, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 34),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightUpperArm = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 46, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 34),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftUpperLeg = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 34),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftLowerLeg = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 196),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightFoot = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 2, 0, 242),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftFoot = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 242),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightLowerLeg = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 2, 0, 196),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightUpperLeg = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 2, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 34),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftHand = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -86, 0, 148),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightHand = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 46, 0, 148),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LowerTorso = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 144),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 84, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightLowerArm = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 46, 0, 102),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftLowerArm = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -86, 0, 102),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local outline = library:create("TextButton", {
                    Text = "",
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -10, 0, 96),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                bodyparts.HumanoidRootPart = library:create("TextButton", {
                    Text = "",
                    Parent = outline,
                    Name = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -8, 1, -8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
            else 
                bodyparts.Head = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Text = "",
                    Position = UDim2.new(0.5, -25, 0, 16),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 50, 0, 44),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(100, 100, 255)
                })
                
                bodyparts.Torso = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Text = "",
                    Position = UDim2.new(0.5, -42, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 84, 0, 90),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftArm = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -86, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightArm = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 46, 0, 64),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    Text = "",
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.RightLeg = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, 2, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                bodyparts.LeftLeg = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -42, 0, 158),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 40, 0, 90),
                    BorderSizePixel = 0,
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(100, 100, 255)
                })
                
                local hrp_out = library:create("TextButton", {
                    Parent = hitpart,
                    Name = "",
                    Position = UDim2.new(0.5, -10, 0, 99),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    BorderSizePixel = 0,
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })
                
                bodyparts.HumanoidRootPart = library:create("TextButton", {
                    Parent = hrp_out,
                    Name = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -8, 1, -8),
                    BorderSizePixel = 0,
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })            
            end 
            
            local name = library:create("TextLabel", {
                Parent = hitpart_inline,
                Name = "",
                FontFace = library.font,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Text = cfg.name,
                TextStrokeTransparency = 0.5,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2.new(0, 8, 0, 0),
                ZIndex = 2,
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })

            for name, button in next, bodyparts do 
                bools[name] = false 

                library:apply_theme(button, "accent", "BackgroundColor3") 
                
                local glow = library:create("ImageLabel", {
                    Parent = button,
                    Name = "",
                    Visible = false, 
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 1, 40),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 

                button.MouseButton1Click:Connect(function()
                    bools[name] = not bools[name]

                    if bools[name] then
                        table.insert(flags[cfg.flag], name)
                    else 
                        local index = table.find(flags[cfg.flag], name)
                        table.remove(flags[cfg.flag], index)
                    end 

                    glow.Visible = bools[name]
                    button.BackgroundColor3 = bools[name] and themes.preset.accent or Color3.fromRGB(38, 38, 38)
                end)
            end 

            for _, button in next, cfg.default do 
                bools[button] = true 
                table.insert(flags[cfg.flag], button)
                bodyparts[button].BackgroundColor3 = themes.preset.accent
                bodyparts[button]:FindFirstChildOfClass("ImageLabel").Visible = true 
            end 
        end 

        function library:toggle(properties) 
            local cfg = {
                enabled = properties.enabled or nil,
                name = properties.name or "Toggle",
                flag = properties.flag or tostring(math.random(1,9999999)),
                callback = properties.callback or function() end,
                default = properties.default or false,
                previous_holder = self
            }

            -- Instances
                local object = library:create("TextButton", {
                    Parent = self.holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, -26, 0, 12),
                    ZIndex = 1,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local right_components = library:create("Frame", {
                    Parent = object,
                    Name = "",
                    Position = UDim2.new(1, 15, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local list = library:create("UIListLayout", {
                    Parent = right_components,
                    Name = "",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDim.new(0, 3),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local icon_inline = library:create("TextButton", {
                    Parent = object,
                    Name = "",
                    Position = UDim2.new(0, -15, 0, 1),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    Text = "", 
                    AutoButtonColor = false, 
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local icon = library:create("Frame", {
                    Parent = icon_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                })

                local icon_2 = library:create("Frame", {
                    Parent = icon,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = themes.preset.accent
                })
                library:apply_theme(icon_2, "accent", "BackgroundColor3") 

                local glow = library:create("ImageLabel", {
                    Parent = icon_inline,
                    Name = "",
                    Visible = false, 
                    ImageColor3 = themes.preset.accent,
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.75,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -12, 0, -12),
                    Size = UDim2.new(1, 24, 1, 24),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                library:apply_theme(glow, "accent", "ImageColor3") 
            
                local bottom_components = library:create("Frame", {
                    Parent = object,
                    Name = "",
                    Visible = true,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 13),
                    Size = UDim2.new(1, 26, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local list = library:create("UIListLayout", {
                    Parent = bottom_components,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            -- 
                
            function cfg.set(bool)
                icon_2.Visible = bool
                glow.Visible = bool
                
                flags[cfg.flag] = bool
                
                cfg.callback(bool)
            end 
        
            library:connection(object.MouseButton1Click, function()
                cfg.enabled = not cfg.enabled
        
                cfg.set(cfg.enabled)
            end)

            library:connection(icon_inline.MouseButton1Click, function()
                cfg.enabled = not cfg.enabled
        
                cfg.set(cfg.enabled)
            end)

            cfg.set(cfg.default)
        
            self.previous_holder = left_components
            self.bottom_holder = bottom_components
            self.right_holder = right_components
            
            config_flags[cfg.flag] = cfg.set

             return setmetatable(cfg, library)  
        end 
        
        function library:slider(properties)
            local cfg = {
                name = properties.name or nil,
                suffix = properties.suffix or "",
                flag = properties.flag or tostring(2^789),
                callback = properties.callback or function() end, 

                min = properties.min or properties.minimum or 0,
                max = properties.max or properties.maximum or 100,
                intervals = properties.interval or properties.decimal or 1,
                default = properties.default or 10,

                dragging = false,
                value = properties.default or 10, 

                previous_holder = self
            } 

            local bottom_components; 
            if cfg.name then 
                object = library:create("TextLabel", {
                    Parent = self.holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, -26, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                bottom_components = library:create("Frame", {
                    Parent = object,
                    Name = "",
                    Visible = true,
                    Position = UDim2.new(0, 0, 0, 13),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 26, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local list = library:create("UIListLayout", {
                    Parent = bottom_components,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })    
            else 
                self.bottom_holder.Parent.AutomaticSize = Enum.AutomaticSize.Y 
                self.bottom_holder.Parent.TextYAlignment = Enum.TextYAlignment.Top            
            end 

            local slider_holder = library:create("Frame", {
                Parent = cfg.name and bottom_components or self.bottom_holder,
                Name = "",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })
            
            local slider_inline = library:create("TextButton", {
                Parent = slider_holder,
                Name = "",
                Position = UDim2.new(0, 0, 0, 1),
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                Size = UDim2.new(1, -26, 0, 8),
                BorderSizePixel = 0,
                Text = "", 
                AutoButtonColor = false, 
                BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            })
            
            local fill_inline = library:create("Frame", {
                Parent = slider_inline,
                Name = "",
                Size = UDim2.new(0.5, 0, 1, 0),
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(19, 19, 19)
            })
            
            local fill = library:create("Frame", {
                Parent = fill_inline,
                Name = "",
                Position = UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(1, 0, 1, -4),
                BackgroundColor3 = themes.preset.accent
            })

            library:apply_theme(fill, "accent", "BackgroundColor3") 
            library:apply_theme(fill, "accent", "BorderColor3") 
            
            local VALUE_TEXT = library:create("TextLabel", {
                Parent = fill_inline,
                Name = "",
                RichText = true,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                TextStrokeTransparency = 0.5,
                Size = UDim2.new(0, 1, 0, 11),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 0, 0, 1),
                BorderSizePixel = 0,
                FontFace = library.font,
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })
            
            local glow = library:create("ImageLabel", {
                Parent = fill_inline,
                Name = "",
                ImageColor3 = themes.preset.accent,
                ScaleType = Enum.ScaleType.Slice,
                ImageTransparency = 0.8999999761581421,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Image = "http://www.roblox.com/asset/?id=18245826428",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, -18, 0, -18),
                Size = UDim2.new(1, 36, 1, 36),
                ZIndex = 2,
                BorderSizePixel = 0,
                SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
            })

            library:apply_theme(glow, "accent", "ImageColor3") 
            
            local add = library:create("TextButton", {
                Parent = slider_inline,
                Name = "",
                TextWrapped = true,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Text = "+",
                TextStrokeTransparency = 0.5,
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 5, 0, -1),
                Size = UDim2.new(0, 8, 0, 8),
                FontFace = library.font,
                TextSize = 8,
                BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            })
            
            local sub = library:create("TextButton", {
                Parent = slider_inline,
                Name = "",
                TextWrapped = true,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Text = "-",
                TextStrokeTransparency = 0.5,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, -15, 0, -1),
                Size = UDim2.new(0, 8, 0, 8),
                FontFace = library.font,
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            })
            
            local slider = library:create("Frame", {
                Parent = slider_inline,
                Name = "",
                Position = UDim2.new(0, 2, 0, 2),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Size = UDim2.new(1, -4, 1, -4),
                BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            })
            
            local pad = library:create("UIPadding", {
                Parent = slider_holder,
                Name = "",
                PaddingBottom = UDim.new(0, -17)
            })
            
            function cfg.set(value)
                if type(value) ~= "number" then 
                    return 
                end

                cfg.value = math.clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                fill_inline.Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)
                VALUE_TEXT.Text = tostring(cfg.value) .. cfg.suffix
                flags[cfg.flag] = cfg.value

                cfg.callback(flags[cfg.flag])
            end

            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                    local size_x = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    cfg.dragging = false 
                end 
            end)

            slider_inline.MouseButton1Down:Connect(function()
                cfg.dragging = true
            end)

            add.MouseButton1Down:Connect(function()
                cfg.value += cfg.intervals
                cfg.set(cfg.value)
            end) 

            sub.MouseButton1Down:Connect(function()
                cfg.value -= cfg.intervals
                cfg.set(cfg.value)
            end) 

            cfg.set(cfg.default)
            
            config_flags[cfg.flag] = cfg.set

            library.config_flags[cfg.flag] = cfg.set

             return setmetatable(cfg, library)  
        end 

        function library:dropdown(properties) 
            local cfg = {
                name = properties.name or nil,
                flag = properties.flag or tostring(math.random(1,9999999)),

                items = properties.items or {"1", "2", "3"},
                callback = properties.callback or function() end,
                multi = properties.multi or false, 

                open = false, 
                option_instances = {}, 
                multi_items = {}, 

                previous_holder = self
            }
            cfg.default = properties.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or nil

            local bottom_components;
            local object; 
            if cfg.name then 
                object = library:create("TextLabel", {
                    Parent = self.holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = cfg.name,
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, -26, 0, 12),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                bottom_components = library:create("Frame", {
                    Parent = object,
                    Name = "",
                    Visible = true,
                    Position = UDim2.new(0, 0, 0, 13),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 26, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local list = library:create("UIListLayout", {
                    Parent = bottom_components,
                    Name = "",
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })    
            else 
                self.bottom_holder.Parent.AutomaticSize = Enum.AutomaticSize.Y 
                self.bottom_holder.Parent.TextYAlignment = Enum.TextYAlignment.Top
            end      

            -- Instances
                local dropdown_inline = library:create("Frame", {
                    Parent = cfg.name and bottom_components or self.bottom_holder, 
                    Name = "",
                    Position = UDim2.new(0, -15, 0, 2),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -26, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local dropdown = library:create("TextButton", {
                    Parent = dropdown_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "option 1, option 3",
                    TextStrokeTransparency = 0.5,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, -4, 1, -4),
                    Position = UDim2.new(0, 2, 0, 2),
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = dropdown,
                    Name = "",
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local icon = library:create("TextLabel", {
                    Parent = dropdown,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "+",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(0, 1, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Position = UDim2.new(1, -6, 0, -1),
                    BorderSizePixel = 0,
                    TextSize = 8,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local content_inline = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, dropdown_inline.AbsoluteSize.X, 0, 0),
                    Position = UDim2.new(0, dropdown_inline.AbsolutePosition.X, 0, dropdown_inline.AbsolutePosition.Y + dropdown_inline.AbsoluteSize.Y + 2),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    Visible = false, 
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })

                dropdown_inline:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                    content_inline.Position = UDim2.new(0, dropdown_inline.AbsolutePosition.X, 0, dropdown_inline.AbsolutePosition.Y + dropdown_inline.AbsoluteSize.Y + 2)
                end)    

                dropdown_inline:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    content_inline.Size = UDim2.new(0, dropdown_inline.AbsoluteSize.X, 0, 0)
                end)
                
                local content = library:create("Frame", {
                    Parent = content_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local options = library:create("Frame", {
                    Parent = content,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = options,
                    Name = "",
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                 
                local UIPadding = library:create("UIPadding", {
                    Parent = options,
                    Name = "",
                    PaddingBottom = UDim.new(0, 4)
                })
                
                -- local op3 = library:create("TextButton", {
                --     Parent = options,
                --     Name = "",
                --     FontFace = library.font,
                --     TextColor3 = Color3.fromRGB(170, 170, 170),
                --     BorderColor3 = Color3.fromRGB(56, 56, 56),
                --     Text = "option 3",
                --     TextStrokeTransparency = 0.5,
                --     Size = UDim2.new(1, 0, 0, 14),
                --     TextXAlignment = Enum.TextXAlignment.Left,
                --     Position = UDim2.new(0, 2, 0, 2),
                --     BorderSizePixel = 0,
                --     TextSize = 12,
                --     BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                -- })
                
                -- local UIPadding = library:create("UIPadding", {
                --     Parent = op3,
                --     Name = "",
                --     PaddingLeft = UDim.new(0, 5)
                -- })
            -- 

            function cfg.set_visible(bool) 
                content_inline.Visible = bool

                icon.Text = bool and "-" or "+"
                icon.TextSize = bool and 12 or 8

                if cfg.name then 
                    object.ZIndex = bool and 9999 or 3
                end 

                if bool then 
                    if library.current_element_open and library.current_element_open ~= cfg then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                    end

                    library.current_element_open = cfg 
                end
            end

            function cfg.set(value) 
                local selected = {}

                local is_table = type(value) == "table"

                for _,v in next, cfg.option_instances do 
                    if v.Text == value or (is_table and table.find(value, v.Text)) then 
                        table.insert(selected, v.Text)
                        cfg.multi_items = selected
                        v.BackgroundTransparency = 0
                    else 
                        v.BackgroundTransparency = 1
                    end
                end

                dropdown.Text = is_table and table.concat(selected, ",  ") or selected[1] or "nun"
                flags[cfg.flag] = is_table and selected or selected[1]
                cfg.callback(flags[cfg.flag]) 
            end

            function cfg:refresh_options(refreshed_list) 
                for _, v in next, cfg.option_instances do 
                    v:Destroy() 
                end

                cfg.option_instances = {} 

                for i,v in next, refreshed_list do 
                    local op3 = library:create("TextButton", {
                        Parent = options,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(170, 170, 170),
                        BorderColor3 = Color3.fromRGB(56, 56, 56),
                        Text = v,
                        BackgroundTransparency = 1,
                        TextStrokeTransparency = 0.5,
                        Size = UDim2.new(1, 0, 0, 14),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Position = UDim2.new(0, 2, 0, 2),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                    })
                    
                    local UIPadding = library:create("UIPadding", {
                        Parent = op3,
                        Name = "",
                        PaddingLeft = UDim.new(0, 5)
                    })

                    table.insert(cfg.option_instances, op3)

                    op3.MouseButton1Down:Connect(function()
                        if cfg.multi then 
                            local selected_index = table.find(cfg.multi_items, op3.Text)

                            if selected_index then 
                                table.remove(cfg.multi_items, selected_index)
                            else
                                table.insert(cfg.multi_items, op3.Text)
                            end

                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 

                            cfg.set(op3.Text)
                        end
                    end)
                end

                dropdown.Text = ""
            end

            dropdown.MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            cfg:refresh_options(cfg.items) 

            cfg.set(cfg.default)

            library.config_flags[cfg.flag] = cfg.set

             return setmetatable(cfg, library)
        end 

        function library:colorpicker(properties)            
            local cfg = {
                name = properties.name or nil, 
                flag = properties.flag or tostring(2^789),
                color = properties.color or Color3.new(1, 1, 1), -- Default to white color if not provided
                alpha = properties.alpha or 1,
                callback = properties.callback or function() end,
                animation = "normal",
                saved_color,
                right_holder = self.right_holder or nil,
                holder = self.holder or nil
            }

            flags[cfg.flag] = {}
            
            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            -- Button Instances
                local right_components; 
                if cfg.name then 
                    local object = library:create("TextLabel", {
                        Parent = self.holder,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(170, 170, 170),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = cfg.name,
                        TextStrokeTransparency = 0.5,
                        Size = UDim2.new(1, -26, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    
                    right_components = library:create("Frame", {
                        Parent = object,
                        Name = "",
                        Position = UDim2.new(1, 15, 0, 1),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    
                    local list = library:create("UIListLayout", {
                        Parent = right_components,
                        Name = "",
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = UDim.new(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })                               
                end 

                local icon_inline = library:create("TextButton", {
                    Parent = cfg.name and right_components or self.right_holder,
                    Name = "",
                    Text = "",
                    Size = UDim2.new(0, 16, 0, 10),
                    Position = UDim2.new(0, -15, 0, 1),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(9, 9, 44)
                })
                
                local icon = library:create("Frame", {
                    Parent = icon_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(22, 22, 108),
                    ZIndex = 2,
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(41, 41, 204)
                })
                
                local glow = library:create("ImageLabel", {
                    Parent = icon_inline,
                    Name = "",
                    ImageColor3 = Color3.fromRGB(41, 41, 204),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.8999999761581421,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -20, 0, -20),
                    Size = UDim2.new(1, 40, 1, 40),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })
            -- 

            -- Colorpicker Instances
                local picker_inline = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    Size = UDim2.new(0, 142, 0, 146),
                    Position = dim2(0, icon_inline.AbsolutePosition.X + 1, 0, icon_inline.AbsolutePosition.Y + 17),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    ZIndex = 9999,
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local picker = library:create("Frame", {
                    Parent = picker_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local sat_inline = library:create("TextButton", {
                    Parent = picker,
                    Name = "",
                    Text = "",
                    Position = UDim2.new(0, 4, 0, 4),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -8, 1, -50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local sat = library:create("Frame", {
                    Parent = sat_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                })
                
                local sat_white = library:create("Frame", {
                    Parent = sat,
                    Name = "",
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = sat_white,
                    Name = "",
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1)
                }
                })
                
                local sat_black = library:create("Frame", {
                    Parent = sat_white,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = sat_black,
                    Name = "",
                    Rotation = 90,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                },
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                }
                })
                
                local sat_black_cursor = library:create("Frame", {
                    Parent = sat_black,
                    Name = "",
                    Position = UDim2.new(0.800000011920929, 0, 0.20000000298023224, 0),
                    BorderColor3 = Color3.fromRGB(108, 22, 22),
                    Size = UDim2.new(0, 1, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(204, 41, 41)
                })
                
                local preview_inline = library:create("Frame", {
                    Parent = picker,
                    Name = "",
                    Position = UDim2.new(1, -20, 1, -20),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(35,35,35)
                })
                
                local preview = library:create("Frame", {
                    Parent = preview_inline,
                    Name = "",
                    BackgroundTransparency = 0,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 2,
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(204, 41, 41)
                })
                
                local preview_image = library:create("ImageLabel", {
                    Parent = preview_inline,
                    Name = "",
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Image = "http://www.roblox.com/asset/?id=18274452449",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(1, -4, 1, -4),
                    TileSize = UDim2.new(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local hue_inline = library:create("TextButton", {
                    Parent = picker,
                    Text = "",
                    Name = "",
                    Position = UDim2.new(0, 4, 1, -44),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -8, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local hue_border = library:create("Frame", {
                    Parent = hue_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local hue = library:create("Frame", {
                    Parent = hue_border,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = hue,
                    Name = "",
                        Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.16699999570846558, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.3330000042915344, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.6669999957084656, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.8330000042915344, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }
                })
                
                local hue_cursor = library:create("Frame", {
                    Parent = hue,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(108, 22, 22),
                    Size = UDim2.new(0, 1, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(204, 41, 41)
                })
                
                local input_inline = library:create("Frame", {
                    Parent = picker,
                    Name = "",
                    Position = UDim2.new(0, 4, 1, -20),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -26, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local __input = library:create("TextBox", {
                    Parent = input_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "204, 41, 41, 0.5",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, -4, 1, -4),
                    PlaceholderColor3 = Color3.fromRGB(90, 90, 90),
                    Position = UDim2.new(0, 2, 0, 2),
                    PlaceholderText = "r, g, b, a",
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local alpha_inline = library:create("TextButton", {
                    Parent = picker,
                    Name = "",
                    Text = "",
                    Position = UDim2.new(0, 4, 1, -32),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(1, -8, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
                
                local alpha = library:create("Frame", {
                    Parent = alpha_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(204, 41, 41)
                })
                
                local alpha_image = library:create("ImageLabel", {
                    Parent = alpha,
                    Name = "",
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Image = "http://www.roblox.com/asset/?id=18343135386",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    TileSize = UDim2.new(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = alpha_image,
                    Name = "",
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                local alpha_cursor = library:create("Frame", {
                    Parent = alpha_image,
                    Name = "",
                    Position = UDim2.new(0.5, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(108, 22, 22),
                    Size = UDim2.new(0, 1, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(204, 41, 41)
                })
                
                
            -- 

            -- Animation Handling 
                local content_inline = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, 73, 0, 0),
                    Position = dim2(0, icon_inline.AbsolutePosition.X + 20, 0, icon_inline.AbsolutePosition.Y),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    Visible = false, 
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })

                local content = library:create("Frame", {
                    Parent = content_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local options = library:create("Frame", {
                    Parent = content,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = options,
                    Name = "",
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local normal = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "normal",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = normal,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local rainbow = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "rainbow",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = rainbow,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local fade = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "fade",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = fade,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = options,
                    Name = "",
                    PaddingBottom = UDim.new(0, 4)
                })
                
                local fade_alpha = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "fade alpha",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = fade_alpha,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })            
            -- 

            function cfg.set_visible(bool)
                picker_inline.Visible = bool
                content_inline.Visible = false
                
                if bool then    
                    if library.current_element_open and library.current_element_open ~= cfg then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                    end

                    library.current_element_open = cfg  
                end
            end 

            icon_inline.MouseButton1Click:Connect(function()		
                cfg.open = not cfg.open

                cfg.set_visible(cfg.open) 
            end)

            icon_inline.MouseButton2Click:Connect(function()
                if cfg.open then 
                    cfg.open = false 
                    cfg.set_visible(false)
                end 

                content_inline.Visible = not content_inline.Visible
            end)

            icon_inline:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                picker_inline.Position = dim2(0, icon_inline.AbsolutePosition.X + 1, 0, icon_inline.AbsolutePosition.Y + 17)
                content_inline.Position = dim2(0, icon_inline.AbsolutePosition.X + 20, 0, icon_inline.AbsolutePosition.Y)
            end)

            function cfg.set(color, alpha)
                if color then 
                    h, s, v = color:ToHSV()
                else 
                    cfg.saved_color = hsv(s,s,v)
                end 
            
                if alpha then 
                    a = alpha
                end 

                local visual = alpha_inline:FindFirstChildOfClass("Frame")

                if not visual then 
                    return 
                end

                local hsv_position = Color3.fromHSV(h, s, v)
                local Color = Color3.fromHSV(h, s, v)
                
                local value = h
                local offset = (value < 1) and 0 or -4
                hue_cursor.Position = dim2(value, offset, 0, 0)

                local offset = (a < 1) and 0 or -4
                alpha_cursor.Position = dim2(a, offset, 0, 0)

                visual.BackgroundColor3 = Color
                glow.ImageColor3 = Color
                
                local RGB_Format = visual.BackgroundColor3

                icon_inline.BackgroundColor3 = Color3.fromRGB(RGB_Format.R / 4, RGB_Format.G / 4, RGB_Format.B / 4)
                icon.BorderColor3 = Color3.fromRGB(math.floor((Color.R * 255) + 0.5) / 2, math.floor((Color.G * 255)+0.5) / 2, math.floor((Color.B * 255) + 0.5) / 2)
                icon.BackgroundColor3 = Color
                    
                __input.Text = math.floor(RGB_Format.R * 255) .. ", " .. math.floor(RGB_Format.G * 255)  .. ", " .. math.floor(RGB_Format.B * 255) .. ", " .. library:round(a, 0.01) 
                preview.BackgroundColor3 = Color
                preview_image.ImageTransparency = 1 - a

                sat.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                
                local s_offset = (s < 1) and 0 or -3
                local v_offset = (1 - v < 1) and 0 or -3
                sat_black_cursor.Position = dim2(s, s_offset, 1 - v, v_offset)

                cfg.color = Color
                cfg.alpha = a
 
                flags[cfg.flag] = {
                    Color = Color,
                    Transparency = a
                }
                cfg.saved_color = hsv(s,s,v)

                cfg.callback(Color, a)
            end
            
            __input.FocusLost:Connect(function()
                local text = __input.Text
                local r, g, b, a = library:convert_string_rgb(text)

                if r and g and b and a then 
                    cfg.set(rgb(r, g, b), a)
                end 
            end)
            
            function cfg.update_color() 
                local mouse = uis:GetMouseLocation() 

                if dragging_sat then	
                    s = math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - sat_white.AbsolutePosition).X / sat_white.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - sat_black.AbsolutePosition).Y / sat_black.AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then 
                    h = 1 - math.clamp(1 - (vec2(mouse.X, mouse.Y - gui_offset) - hue_inline.AbsolutePosition).X / hue_inline.AbsoluteSize.X, 0, 1)
                elseif dragging_alpha then 
                    a = math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - alpha_inline.AbsolutePosition).X / alpha_inline.AbsoluteSize.X, 0, 1)
                end

                cfg.set(nil, nil)
            end

            alpha_inline.MouseButton1Down:Connect(function()
                dragging_alpha = true 
            end)

            hue_inline.MouseButton1Down:Connect(function()
                dragging_hue = true 
            end)

            sat_inline.MouseButton1Down:Connect(function()
                dragging_sat = true  
            end)

            cfg.saved_color = hsv(h, s, v)
            local selected = normal
            flags[cfg.flag]["animation"] = "normal"

            rainbow.MouseButton1Down:Connect(function()
                selected.BackgroundTransparency = 1; 
                selected = rainbow 
                rainbow.BackgroundTransparency = 0 

                flags[cfg.flag]["animation"] = "rainbow"
                cfg.saved_color = hsv(s,s,v)
            end)

            fade_alpha.MouseButton1Down:Connect(function()
                selected.BackgroundTransparency = 1; 
                selected = fade_alpha 
                fade_alpha.BackgroundTransparency = 0 

                flags[cfg.flag]["animation"] = "fade_alpha"
                cfg.saved_color = hsv(s,s,v)
            end)

            fade.MouseButton1Down:Connect(function()
                selected.BackgroundTransparency = 1; 
                selected = fade 
                fade.BackgroundTransparency = 0 

                flags[cfg.flag]["animation"] = "fade"
                cfg.saved_color = hsv(s,s,v)
            end)

            normal.MouseButton1Down:Connect(function()
                selected.BackgroundTransparency = 1; 
                selected = normal 
                normal.BackgroundTransparency = 0 

                flags[cfg.flag]["animation"] = "normal"
                cfg.set(cfg.saved_color)
            end)

            uis.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false 
                end
            end)

            uis.InputChanged:Connect(function(input)
                if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    cfg.update_color() 
                end
            end)	

            cfg.set(cfg.color, cfg.alpha)

            self.previous_holder = parent

            library.config_flags[cfg.flag] = cfg.set

            task.spawn(function()
                while true do 
                    if selected ~= "normal" then 
                        cfg.set(
                            hsv(
                                selected == "rainbow" and library.sin or h, 
                                selected == "rainbow" and 1 or s, 
                                selected == "fade" and library.sin or v
                            )
                            , selected == "fade_alpha" and library.sin
                        )
                    end 
                    task.wait() 
                end     
            end)    
            
            return setmetatable(cfg, library)  
        end     

        function library:keybind(properties)
            local cfg = {
                flag = properties.flag or tostring(2^math.random(1,30)*3),
                keybind_name = properties.keybind_name or nil, 
                callback = properties.callback or function() end,
                open = false,
                binding = nil, 
                name = properties.name or nil, 

                key = properties.key or nil, 
                mode = properties.mode or "toggle",
                active = properties.default or false, 

                hold_instances = {},
            }

            flags[cfg.flag] = {} 

            local key = library:new_keybind({})

            -- Instances
                local right_components; 
                if cfg.name then 
                    local object = library:create("TextLabel", {
                        Parent = self.holder,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = Color3.fromRGB(170, 170, 170),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = cfg.name,
                        TextStrokeTransparency = 0.5,
                        Size = UDim2.new(1, -26, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    
                    right_components = library:create("Frame", {
                        Parent = object,
                        Name = "",
                        Position = UDim2.new(1, 15, 0, 1),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    
                    local list = library:create("UIListLayout", {
                        Parent = right_components,
                        Name = "",
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = UDim.new(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })                               
                end

                local keybind = library:create("TextButton", {
                    Parent = cfg.name and right_components or self.right_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "ERROR",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(0, 16, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                local content_inline = library:create("Frame", {
                    Parent = library.gui,
                    Name = "",
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, 57, 0, 0),
                    Position = dim2(0, keybind.AbsolutePosition.X, 0, keybind.AbsolutePosition.Y - 5),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Visible = false, 
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })

                keybind:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                    content_inline.Position = UDim2.new(0, keybind.AbsolutePosition.X, 0, keybind.AbsolutePosition.Y + 15)
                end)
                
                local content = library:create("Frame", {
                    Parent = content_inline,
                    Name = "",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                local options = library:create("Frame", {
                    Parent = content,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = options,
                    Name = "",
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local press = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "press",
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = press,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local hold = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "hold",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = hold,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local always = library:create("TextButton", {
                    Parent = options,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = "always",
                    TextStrokeTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = always,
                    Name = "",
                    PaddingBottom = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 5)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = options,
                    Name = "",
                    PaddingBottom = UDim.new(0, 4)
                })
            --  

            function cfg.set_visible(bool)
                content_inline.Visible = bool

                if bool then 
                    if library.current_element_open and library.current_element_open ~= cfg then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                    end

                    library.current_element_open = cfg 
                end
            end 

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "always" then
                    cfg.set(true)
                elseif mode == "hold" then
                    cfg.set(false)
                end

                flags[cfg.flag] = {
                    mode = cfg.mode, 
                    key = cfg.key,
                    active = cfg.active 
                }

                flags[cfg.flag]["mode"] = mode
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    local __cached = input 

                    if cfg.mode == "always" then 
                        __cached = true 
                    end 

                    cfg.active = __cached 
                    flags[cfg.flag]["active"] = __cached 
                    cfg.callback(__cached)

                    flags[cfg.flag] = {
                        mode = cfg.mode, 
                        key = cfg.key,
                        active = cfg.active
                    }
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "..." or input

                    cfg.key = input or "..."	

                    local _text = keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")
                    local _text2 = (tostring(_text):gsub("KeyCode.", ""):gsub("UserInputType.", "")) or "..."
                    cfg.key_name = _text2

                    flags[cfg.flag]["mode"] = cfg.mode 
                    flags[cfg.flag]["key"] = cfg.key 

                    keybind.Text = "[" .. string.lower(_text2) .. "]"

                    cfg.callback(cfg.active or false)

                    flags[cfg.flag] = {
                        mode = cfg.mode, 
                        key = cfg.key,
                        active = cfg.active 
                    }
                elseif table.find({"toggle", "hold", "always"}, input) then 
                    cfg.set_mode(input)

                    if input == "always" then 
                        cfg.active = true 
                    end 

                    cfg.callback(cfg.active or false)

                    flags[cfg.flag] = {
                        mode = cfg.mode ,
                        key = cfg.key,
                        active = cfg.active
                    }
                    
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "..." and library:convert_enum(input.key) or input.key

                    input.key = input.key == Enum.KeyCode.Escape and "..." or input.key
                    cfg.key = input.key or "..."
                    
                    cfg.mode = input.mode or "toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    flags[cfg.flag] = {
                        mode = cfg.mode,
                        key = cfg.key, 
                        active = cfg.active
                    }

                    local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                    local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))

                    keybind.Text = "[" .. string.lower(__text)  .. "]" or "..."
                    cfg.key_name = __text
                end 

                if cfg.keybind_name then 
                    key.change_text(keybind.Text ..  " " .. cfg.keybind_name .. " (" .. flags[cfg.flag].mode  .. ")")
                    key.set_visible(cfg.active)
                end 
            end

            local selected; 

            hold.MouseButton1Click:Connect(function()
                if selected then 
                    selected.BackgroundTransparency = 1
                end 
                selected = hold
                hold.BackgroundTransparency = 0 

                cfg.set_mode("hold") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 

            press.MouseButton1Click:Connect(function()
                if selected then 
                    selected.BackgroundTransparency = 1
                end 
                selected = press
                press.BackgroundTransparency = 0 

                cfg.set_mode("toggle") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 

            always.MouseButton1Click:Connect(function()
                if selected then 
                    selected.BackgroundTransparency = 1
                end 
                selected = always
                
                always.BackgroundTransparency = 0 
                cfg.set_mode("always") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 

            keybind.MouseButton2Click:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)
            
            keybind.MouseButton1Down:Connect(function()
                task.wait()
                keybind.Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then 
                    if input.KeyCode == cfg.key then 
                        if cfg.mode == "toggle" then 
                            toggled = not toggled
                            cfg.set(toggled)
                        elseif cfg.mode == "hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "hold" then 
                        cfg.set(false)
                    end
                end
            end)
    
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})
    
            library.config_flags[cfg.flag] = cfg.set

             return setmetatable(cfg, library) 
        end 

        function library:button(properties)
            local cfg = {
                callback = properties.callback or function() end, 
                name = properties.text or properties.name or "Button",
            } 

            local button_inline = library:create("Frame", {
                Parent = self.holder,
                Name = "",
                Position = UDim2.new(0, -15, 0, 2),
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                Size = UDim2.new(1, -26, 0, 16),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            })
            
            local button = library:create("TextButton", {
                Parent = button_inline,
                Name = "",
                FontFace = library.font,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Text = cfg.name,
                TextStrokeTransparency = 0.5,
                Position = UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(1, -4, 1, -4),
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            })

            button.MouseButton1Click:Connect(function()
                cfg.callback() 
            end)
            
            return setmetatable(cfg, library)  
        end 

        function library:textbox(properties)
            local cfg = {
                placeholder = properties.placeholder or properties.placeholdertext or properties.holder or properties.holdertext or "type here...",
                default = properties.default,
                clear_on_focus = properties.clearonfocus or false,
                flag = properties.flag or "SET ME NIGGA",
                callback = properties.callback or function() end 
            }

            local textbox_inline = library:create("Frame", {
                Parent = self.holder,
                Name = "",
                Position = UDim2.new(0, -15, 0, 2),
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                Size = UDim2.new(1, -26, 0, 16),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            })
            
            local textbox = library:create("TextBox", {
                Parent = textbox_inline,
                Name = "",
                FontFace = library.font,
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(56, 56, 56),
                Text = "",
                TextStrokeTransparency = 0.5,
                Position = UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(1, -4, 1, -4),
                ClearTextOnFocus = cfg.clear_on_focus, 
                PlaceholderColor3 = Color3.fromRGB(90, 90, 90),
                CursorPosition = -1,
                PlaceholderText = cfg.placeholder,
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            })
            
            textbox:GetPropertyChangedSignal("Text"):Connect(function()
                flags[cfg.flag] = textbox.text
                cfg.callback(textbox.text)
            end)

            function cfg.set(text) 
                flags[cfg.flag] = text
                textbox.Text = text
                cfg.callback(text)
            end 

            if cfg.default then 
                cfg.set(cfg.default) 
            end 

            library.config_flags[cfg.flag] = cfg.set

             return setmetatable(cfg, library)  
        end 

        function library:panel(properties)
            if library.__panel == true then 
                return 
            end 

            library.__panel = true 

            local cfg = {
                name = properties.name or "Are you sure?", 
                options = properties.options or {"Confirm", "Discard"},
                callback = properties.callback or function() end, 
            }

            local panel_main_frame = library:create("Frame", {
                Parent = library.gui,
                Name = "",
                BackgroundTransparency = 0.4000000059604645,
                Size = UDim2.new(1, 0, 1, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                ZIndex = 3,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            })

            local holder = library:create("Frame", {
                Parent = panel_main_frame,
                Name = "",
                BorderColor3 = Color3.fromRGB(19, 19, 19),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                ZIndex = 4,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            })

            local inline1 = library:create("Frame", {
                Parent = holder,
                Name = "",
                BorderColor3 = Color3.fromRGB(8, 8, 8),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = Color3.fromRGB(56, 56, 56)
            })

            local main = library:create("Frame", {
                Parent = inline1,
                Name = "",
                Position = UDim2.new(0, 4, 0, 4),
                BorderColor3 = Color3.fromRGB(26, 26, 26),
                Size = UDim2.new(1, -8, 1, -8),
                BorderSizePixel = 2,
                BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            })

            local UIStroke = library:create("UIStroke", {
                Parent = main,
                Name = "",
                Color = Color3.fromRGB(57, 57, 57),
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            local tabs = library:create("Frame", {
                Parent = main,
                Name = "",
                Position = UDim2.new(0, 8, 0, 8),
                BorderColor3 = Color3.fromRGB(8, 8, 8),
                Size = UDim2.new(1, -16, 1, -16),
                BorderSizePixel = 2,
                BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            })

            local UIStroke = library:create("UIStroke", {
                Parent = tabs,
                Name = "",
                Color = Color3.fromRGB(57, 57, 57),
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            local UIPadding = library:create("UIPadding", {
                Parent = tabs,
                Name = "",
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 22),
                PaddingRight = UDim.new(0, 20),
                PaddingLeft = UDim.new(0, 20)
            })

            local aimbot = library:create("TextLabel", {
                Parent = tabs,
                Name = "",
                FontFace = library.font,
                LineHeight = 1.2000000476837158,
                TextStrokeTransparency = 0.5,
                AnchorPoint = Vector2.new(0.5, 0),
                TextSize = 12,
                Size = UDim2.new(0, 0, 0, 11),
                TextColor3 = Color3.fromRGB(170, 170, 170),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Text = cfg.name,
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0, 8),
                BorderSizePixel = 0,
                TextYAlignment = Enum.TextYAlignment.Top,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })

            local UIPadding = library:create("UIPadding", {
                Parent = aimbot,
                Name = "",
                PaddingTop = UDim.new(0, 6)
            })

            local UIListLayout = library:create("UIListLayout", {
                Parent = tabs,
                Name = "",
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 4)
            })

            local Frame = library:create("Frame", {
                Parent = tabs,
                Name = "",
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })

            local UIListLayout = library:create("UIListLayout", {
                Parent = Frame,
                Name = "",
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 3)
            })

            local UIPadding = library:create("UIPadding", {
                Parent = Frame,
                Name = ""
            })

            -- local textbox_inline = library:create("Frame", {
            --     Parent = Frame,
            --     Name = "",
            --     Position = UDim2.new(0, -15, 0, 2),
            --     BorderColor3 = Color3.fromRGB(19, 19, 19),
            --     Size = UDim2.new(0, 130, 0, 16),
            --     BorderSizePixel = 0,
            --     BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            -- })

            -- local textbox = library:create("TextBox", {
            --     Parent = textbox_inline,
            --     Name = "",
            --     FontFace = library.font,
            --     TextColor3 = Color3.fromRGB(170, 170, 170),
            --     BorderColor3 = Color3.fromRGB(56, 56, 56),
            --     Text = "",
            --     TextStrokeTransparency = 0.5,
            --     Size = UDim2.new(1, -4, 1, -4),
            --     PlaceholderColor3 = Color3.fromRGB(90, 90, 90),
            --     Position = UDim2.new(0, 2, 0, 2),
            --     PlaceholderText = "name",
            --     TextSize = 12,
            --     BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            -- })

            for _, v in next, cfg.options do 
                local button_inline = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    Position = UDim2.new(0, 0, 0, 4),
                    BorderColor3 = Color3.fromRGB(19, 19, 19),
                    Size = UDim2.new(0, 130, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                })
        
                local button = library:create("TextButton", {
                    Parent = button_inline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = Color3.fromRGB(170, 170, 170),
                    BorderColor3 = Color3.fromRGB(56, 56, 56),
                    Text = v,
                    TextStrokeTransparency = 0.5,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(1, -4, 1, -4),
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                })
                
                button.MouseButton1Click:Connect(function()
                    cfg.callback(v) 
                    panel_main_frame:Destroy() 
                    library.__panel = false 
                end)
            end     
        end 
    -- 
-- 

return library;
