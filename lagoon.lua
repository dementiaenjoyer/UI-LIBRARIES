
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local CoreGui = game:GetService('CoreGui')

local HttpService = game:GetService('HttpService')

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Library = {}

Library.Colors = {
	primary_color = Color3.fromRGB(85, 170, 255),
	secondary_color = Color3.fromRGB(18, 35, 53),
	text_color = Color3.fromRGB(255, 255, 255)
}

function Library:validate(defaults, options)
	for i,v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function Library:tween(obj, goal, cb)
	local t = TweenService:Create(obj, tweenInfo, goal)
	t.Completed:Connect(cb or function() end)
	t:Play()
end


function Library:new(options)
	options = Library:validate({
		title = '<font color="rgb(85, 170, 255)">lagoon</font>script',
		name = 'lagoon'
	}, options or {})
	
	local NewWindow = {
		
		MenuName = options.name,
		
		Elements = {},
		ElementId = 0,
		
		SelectedTab = nil,
		ColorpickerWindow = nil,
		
		MenuBind = Enum.KeyCode.Insert,
		
		DragToggle = nil,
		DragSpeed = 0,
		DragStart = nil,
		StartPos = nil,
		
		MenuKeybinds = {},
		IsBinding = false,
		CurrentlyBinding = nil,
		TableStructure = nil,
		BindOptions = nil,
		
		CurrentListToggled = nil,
		
		Watermark = nil
		
		
		
	}
	
	NewWindow.ElementsStored = {}
	
	--MainWindow
	
	do
		NewWindow["1"] = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui")); --		NewWindow["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui);
		NewWindow["1"]["Name"] = options["name"];
		NewWindow["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
		NewWindow["1"]["IgnoreGuiInset"] = true
        NewWindow["1"]["ResetOnSpawn"] = false

		-- StarterGui.NewNewWindow.MainNewWindow
		NewWindow["2"] = Instance.new("Frame", NewWindow["1"]);
		NewWindow["2"]["BorderSizePixel"] = 0;
		NewWindow["2"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		NewWindow["2"]["AnchorPoint"] = Vector2.new(0,0);
		NewWindow["2"]["Size"] = UDim2.new(0, 624, 0, 468);
		NewWindow["2"]["Position"] = UDim2.fromOffset((Viewport.X/2) - (NewWindow["2"].Size.X.Offset / 2), (Viewport.Y/2) - (NewWindow["2"].Size.Y.Offset / 2))
		NewWindow["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["2"]["Name"] = [[Window]];
		NewWindow["2"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewNewWindow.MainNewWindow._border
		NewWindow["3"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["3"]["BorderSizePixel"] = 2;
		NewWindow["3"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
		NewWindow["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["3"]["Size"] = UDim2.new(0, 608, 0, 427);
		NewWindow["3"]["Position"] = UDim2.new(0, 312, 0, 243);
		NewWindow["3"]["BorderColor3"] = Color3.fromRGB(61, 61, 61);
		NewWindow["3"]["Name"] = [[_border]];

		-- StarterGui.NewNewWindow.MainNewWindow.Header
		NewWindow["4"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["4"]["ZIndex"] = 4;
		NewWindow["4"]["BorderSizePixel"] = 0;
		NewWindow["4"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		NewWindow["4"]["Size"] = UDim2.new(0, 608, 0, 24);
		NewWindow["4"]["Position"] = UDim2.new(0, 8, 0, 4);
		NewWindow["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["4"]["Name"] = [[Header]];
		NewWindow["4"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewNewWindow.MainNewWindow.Header.UIListLayout
		NewWindow["5"] = Instance.new("UIListLayout", NewWindow["4"]);
		NewWindow["5"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
		NewWindow["5"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.NewNewWindow.MainNewWindow.Header.MenuTitle
		NewWindow["6"] = Instance.new("TextLabel", NewWindow["4"]);
		NewWindow["6"]["TextWrapped"] = true;
		NewWindow["6"]["ZIndex"] = 2;
		NewWindow["6"]["BorderSizePixel"] = 0;
		NewWindow["6"]["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
		NewWindow["6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		NewWindow["6"]["TextScaled"] = true;
		NewWindow["6"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
		NewWindow["6"]["TextSize"] = 14;
		NewWindow["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		NewWindow["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		NewWindow["6"]["BackgroundTransparency"] = 1;
		NewWindow["6"]["RichText"] = true;
		NewWindow["6"]["Size"] = UDim2.new(0, 608, 0, 16);
		NewWindow["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["6"]["Text"] = options["title"];
		NewWindow["6"]["Name"] = [[MenuTitle]];
		NewWindow["6"]["Position"] = UDim2.new(0, 0, 0, 4);

		-- StarterGui.NewNewWindow.MainNewWindow._border
		NewWindow["7"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["7"]["ZIndex"] = 0;
		NewWindow["7"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
		NewWindow["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["7"]["Size"] = UDim2.new(0, 618, 0, 459);
		NewWindow["7"]["Position"] = UDim2.new(0, 312, 0, 233);
		NewWindow["7"]["BorderColor3"] = Color3.fromRGB(61, 61, 61);
		NewWindow["7"]["Name"] = [[_border]];

		-- StarterGui.NewNewWindow.MainNewWindow._border
		NewWindow["8"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["8"]["ZIndex"] = -1;
		NewWindow["8"]["BorderSizePixel"] = 2;
		NewWindow["8"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["8"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["8"]["Size"] = UDim2.new(0, 618, 0, 459);
		NewWindow["8"]["Position"] = UDim2.new(0, 312, 0, 233);
		NewWindow["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["8"]["Name"] = [[_border]];

		-- StarterGui.NewNewWindow.MainNewWindow._border
		NewWindow["9"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["9"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
		NewWindow["9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["9"]["Size"] = UDim2.new(0, 608, 0, 427);
		NewWindow["9"]["Position"] = UDim2.new(0, 312, 0, 243);
		NewWindow["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["9"]["Name"] = [[_border]];

		-- StarterGui.NewNewWindow.MainNewWindow._borderadv
		NewWindow["a"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["a"]["ZIndex"] = 5;
		NewWindow["a"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
		NewWindow["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["a"]["Size"] = UDim2.new(0, 606, 0, 0);
		NewWindow["a"]["Position"] = UDim2.new(0, 312, 0, 56);
		NewWindow["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["a"]["Name"] = [[_borderadv]];

		-- StarterGui.NewNewWindow.MainNewWindow._borderadv.UIStroke
		NewWindow["b"] = Instance.new("UIStroke", NewWindow["a"]);
		NewWindow["b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
		NewWindow["b"]["Color"] = Color3.fromRGB(61, 61, 61);

		-- StarterGui.NewNewWindow.MainNewWindow.TabContents
		NewWindow["1b"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["1b"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
		NewWindow["1b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["1b"]["Size"] = UDim2.new(0, 608, 0, 402);
		NewWindow["1b"]["Position"] = UDim2.new(0, 312, 0, 255);
		NewWindow["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["1b"]["Name"] = [[TabContents]];

		-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left
		NewWindow["1c"] = Instance.new("ScrollingFrame", NewWindow["1b"]);
		NewWindow["1c"]["Active"] = true;
		NewWindow["1c"]["ZIndex"] = 5;
		NewWindow["1c"]["BorderSizePixel"] = 0;
		NewWindow["1c"]["CanvasSize"] = UDim2.new(0, 0, 100, 0);
		NewWindow["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
		NewWindow["1c"]["Name"] = [[Left]];
		NewWindow["1c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["1c"]["ClipsDescendants"] = false;
		NewWindow["1c"]["Size"] = UDim2.new(0, 290, 0, 384);
		NewWindow["1c"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["1c"]["Position"] = UDim2.new(0, 152, 0, 200);
		NewWindow["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["1c"]["ScrollBarThickness"] = 0;
		NewWindow["1c"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left.UIListLayout
		NewWindow["1d"] = Instance.new("UIListLayout", NewWindow["1c"]);
		NewWindow["1d"]["Wraps"] = true;
		NewWindow["1d"]["Padding"] = UDim.new(0, 5);
		NewWindow["1d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		NewWindow["1d"]["FillDirection"] = Enum.FillDirection.Horizontal;

		-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Right
		NewWindow["62"] = Instance.new("ScrollingFrame", NewWindow["1b"]);
		NewWindow["62"]["Active"] = true;
		NewWindow["62"]["ZIndex"] = 5;
		NewWindow["62"]["BorderSizePixel"] = 0;
		NewWindow["62"]["CanvasSize"] = UDim2.new(0, 0, 100, 0);
		NewWindow["62"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
		NewWindow["62"]["Name"] = [[Right]];
		NewWindow["62"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["62"]["ClipsDescendants"] = false;
		NewWindow["62"]["Size"] = UDim2.new(0, 290, 0, 384);
		NewWindow["62"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["62"]["Position"] = UDim2.new(0, 455, 0, 200);
		NewWindow["62"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["62"]["ScrollBarThickness"] = 0;
		NewWindow["62"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Right.UIListLayout
		NewWindow["63"] = Instance.new("UIListLayout", NewWindow["62"]);
		NewWindow["63"]["Wraps"] = true;
		NewWindow["63"]["Padding"] = UDim.new(0, 5);
		NewWindow["63"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		NewWindow["63"]["FillDirection"] = Enum.FillDirection.Horizontal;
	end
	
	--inner functions
	
	function NewWindow:isMenuOpen()
		return NewWindow["2"].Visible
	end
	
	--Colorpicker Handler
	
	function NewWindow:CreateColorpicker()
		
		if NewWindow.ColorpickerWindow ~= nil then return end
		
		local Colorpicker = {
			SelectedColor = Color3.fromHSV(1,1,1),
			ColorData = {1,1,1},
			MouseDown = false,
			Element = nil,
			Picking = false,
			IgnoreBounds = true,
			DragToggle = nil,
			DragSpeed = 0,
			DragStart = nil,
			StartPos = nil
		}
		
		-- create
		
		do
			-- StarterGui.NewColorpicker.Colorpicker
			Colorpicker["65"] = Instance.new("Frame", NewWindow["1"]);
			Colorpicker["65"]["BorderSizePixel"] = 2;
			Colorpicker["65"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			Colorpicker["65"]["Size"] = UDim2.new(0, 199, 0, 228);
			Colorpicker["65"]["Position"] = UDim2.fromOffset((Viewport.X/2) - (Colorpicker["65"].Size.X.Offset/2), (Viewport.Y/2) - (Colorpicker["65"].Size.Y.Offset / 2))
			Colorpicker["65"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["65"]["Name"] = [[Colorpicker]];
			Colorpicker["65"].Visible = false

			-- StarterGui.NewColorpicker.Colorpicker.UIStroke
			Colorpicker["66"] = Instance.new("UIStroke", Colorpicker["65"]);
			Colorpicker["66"]["Color"] = Color3.fromRGB(61, 61, 61);

			-- StarterGui.NewColorpicker.Colorpicker.Header
			Colorpicker["67"] = Instance.new("Frame", Colorpicker["65"]);
			Colorpicker["67"]["ZIndex"] = 4;
			Colorpicker["67"]["BorderSizePixel"] = 0;
			Colorpicker["67"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
			Colorpicker["67"]["Size"] = UDim2.new(0, 189, 0, 23);
			Colorpicker["67"]["Position"] = UDim2.new(0, 4, 0, 0);
			Colorpicker["67"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["67"]["Name"] = [[Header]];
			Colorpicker["67"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewColorpicker.Colorpicker.Header.UIListLayout
			Colorpicker["68"] = Instance.new("UIListLayout", Colorpicker["67"]);
			Colorpicker["68"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
			Colorpicker["68"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.NewColorpicker.Colorpicker.Header.ColorpickerTitle
			Colorpicker["69"] = Instance.new("TextLabel", Colorpicker["67"]);
			Colorpicker["69"]["TextWrapped"] = true;
			Colorpicker["69"]["ZIndex"] = 2;
			Colorpicker["69"]["BorderSizePixel"] = 0;
			Colorpicker["69"]["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
			Colorpicker["69"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Colorpicker["69"]["TextScaled"] = true;
			Colorpicker["69"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
			Colorpicker["69"]["TextSize"] = 14;
			Colorpicker["69"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Colorpicker["69"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["69"]["BackgroundTransparency"] = 1;
			Colorpicker["69"]["RichText"] = true;
			Colorpicker["69"]["Size"] = UDim2.new(0, 184, 0, 16);
			Colorpicker["69"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["69"]["Text"] = [[Colorpicker]];
			Colorpicker["69"]["Name"] = [[ColorpickerTitle]];
			Colorpicker["69"]["Position"] = UDim2.new(0, 0, 0, 3);

			-- StarterGui.NewColorpicker.Colorpicker.Main
			Colorpicker["6a"] = Instance.new("Frame", Colorpicker["65"]);
			Colorpicker["6a"]["BorderSizePixel"] = 2;
			Colorpicker["6a"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			Colorpicker["6a"]["Size"] = UDim2.new(0, 189, 0, 195);
			Colorpicker["6a"]["Position"] = UDim2.new(0, 4, 0, 26);
			Colorpicker["6a"]["BorderColor3"] = Color3.fromRGB(61, 61, 61);
			Colorpicker["6a"]["Name"] = [[Main]];

			-- StarterGui.NewColorpicker.Colorpicker.Main.UIStroke
			Colorpicker["6b"] = Instance.new("UIStroke", Colorpicker["6a"]);


			-- StarterGui.NewColorpicker.Colorpicker.Main.RGB
			Colorpicker["6c"] = Instance.new("ImageLabel", Colorpicker["6a"]);
			Colorpicker["6c"]["ZIndex"] = 4;
			Colorpicker["6c"]["SliceCenter"] = Rect.new(10, 10, 90, 90);
			Colorpicker["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["6c"]["AnchorPoint"] = Vector2.new(0.5, 0);
			Colorpicker["6c"]["Image"] = [[rbxassetid://1433361550]];
			Colorpicker["6c"]["Size"] = UDim2.new(0, 150, 0, 151);
			Colorpicker["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["6c"]["Name"] = [[RGB]];
			Colorpicker["6c"]["Position"] = UDim2.new(0, 82, 0, 5);

			-- StarterGui.NewColorpicker.Colorpicker.Main.RGB.Marker
			Colorpicker["6d"] = Instance.new("Frame", Colorpicker["6c"]);
			Colorpicker["6d"]["ZIndex"] = 5;
			Colorpicker["6d"]["BorderSizePixel"] = 2;
			Colorpicker["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["6d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Colorpicker["6d"]["Size"] = UDim2.new(0, 2, 0, 2);
			Colorpicker["6d"]["Position"] = UDim2.new(0, 0, 0, 150);
			Colorpicker["6d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["6d"]["Name"] = [[Marker]];

			-- StarterGui.NewColorpicker.Colorpicker.Main.RGB.Marker.UICorner
			Colorpicker["6e"] = Instance.new("UICorner", Colorpicker["6d"]);


			-- StarterGui.NewColorpicker.Colorpicker.Main.RGB.Marker.UIStroke
			Colorpicker["6f"] = Instance.new("UIStroke", Colorpicker["6d"]);


			-- StarterGui.NewColorpicker.Colorpicker.Main.Value
			Colorpicker["70"] = Instance.new("ImageLabel", Colorpicker["6a"]);
			Colorpicker["70"]["ZIndex"] = 4;
			Colorpicker["70"]["BorderSizePixel"] = 0;
			Colorpicker["70"]["SliceCenter"] = Rect.new(10, 10, 90, 90);
			Colorpicker["70"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["70"]["AnchorPoint"] = Vector2.new(0.5, 0);
			Colorpicker["70"]["Image"] = [[rbxassetid://359311684]];
			Colorpicker["70"]["Size"] = UDim2.new(0, 18, 0, 151);
			Colorpicker["70"]["BorderColor3"] = Color3.fromRGB(41, 41, 41);
			Colorpicker["70"]["Name"] = [[Value]];
			Colorpicker["70"]["Position"] = UDim2.new(0, 173, 0, 5);

			-- StarterGui.NewColorpicker.Colorpicker.Main.Value.Marker
			Colorpicker["71"] = Instance.new("Frame", Colorpicker["70"]);
			Colorpicker["71"]["ZIndex"] = 5;
			Colorpicker["71"]["BorderSizePixel"] = 0;
			Colorpicker["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["71"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Colorpicker["71"]["Size"] = UDim2.new(0, 21, 0, 1);
			Colorpicker["71"]["Position"] = UDim2.new(0, 9, 0, 0);
			Colorpicker["71"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["71"]["Name"] = [[Marker]];

			-- StarterGui.NewColorpicker.Colorpicker.Main.Value.Marker.UIStroke
			Colorpicker["72"] = Instance.new("UIStroke", Colorpicker["71"]);


			-- StarterGui.NewColorpicker.Colorpicker.Main.Value.UIStroke
			Colorpicker["73"] = Instance.new("UIStroke", Colorpicker["70"]);


			-- StarterGui.NewColorpicker.Colorpicker.Main.CurrentColor
			Colorpicker["74"] = Instance.new("Frame", Colorpicker["6a"]);
			Colorpicker["74"]["BorderSizePixel"] = 0;
			Colorpicker["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["74"]["Size"] = UDim2.new(0, 18, 0, 18);
			Colorpicker["74"]["Position"] = UDim2.new(0, 164, 0, 164);
			Colorpicker["74"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["74"]["Name"] = [[CurrentColor]];

			-- StarterGui.NewColorpicker.Colorpicker.Main.CurrentColor.UICorner
			Colorpicker["75"] = Instance.new("UICorner", Colorpicker["74"]);
			Colorpicker["75"]["CornerRadius"] = UDim.new(0, 1);

			-- StarterGui.NewColorpicker.Colorpicker.Main.CurrentColor.UIGradient
			Colorpicker["76"] = Instance.new("UIGradient", Colorpicker["74"]);
			Colorpicker["76"]["Enabled"] = false;
			Colorpicker["76"]["Rotation"] = 90;
			Colorpicker["76"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(171, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(36, 0, 2))};

			-- StarterGui.NewColorpicker.Colorpicker.Main.CurrentColor.UIStroke
			Colorpicker["77"] = Instance.new("UIStroke", Colorpicker["74"]);
			Colorpicker["77"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

			-- StarterGui.NewColorpicker.Colorpicker.Main.HexCode
			Colorpicker["78"] = Instance.new("Frame", Colorpicker["6a"]);
			Colorpicker["78"]["BorderSizePixel"] = 2;
			Colorpicker["78"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
			Colorpicker["78"]["Size"] = UDim2.new(0, 148, 0, 18);
			Colorpicker["78"]["Position"] = UDim2.new(0, 7, 0, 164);
			Colorpicker["78"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["78"]["Name"] = [[HexCode]];

			-- StarterGui.NewColorpicker.Colorpicker.Main.HexCode.UIStroke
			Colorpicker["79"] = Instance.new("UIStroke", Colorpicker["78"]);
			Colorpicker["79"]["Color"] = Color3.fromRGB(61, 61, 61);

			-- StarterGui.NewColorpicker.Colorpicker.Main.HexCode.cInput
			Colorpicker["7a"] = Instance.new("TextBox", Colorpicker["78"]);
			Colorpicker["7a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["7a"]["PlaceholderColor3"] = Color3.fromRGB(142, 142, 142);
			Colorpicker["7a"]["BorderSizePixel"] = 0;
			Colorpicker["7a"]["TextWrapped"] = true;
			Colorpicker["7a"]["TextSize"] = 14;
			Colorpicker["7a"]["Name"] = [[cInput]];
			Colorpicker["7a"]["TextScaled"] = true;
			Colorpicker["7a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Colorpicker["7a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Colorpicker["7a"]["PlaceholderText"] = [[#FFFFFF]];
			Colorpicker["7a"]["Size"] = UDim2.new(0, 148, 0, 12);
			Colorpicker["7a"]["Position"] = UDim2.new(0, 0, 0, 2);
			Colorpicker["7a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Colorpicker["7a"]["Text"] = [[]];
			Colorpicker["7a"]["BackgroundTransparency"] = 1;
		end
		
		-- functions
		
		do
			
			function Colorpicker:RGBToHSV(color)
				local r, g, b = color.R, color.G, color.B
				local max = math.max(r, g, b)
				local min = math.min(r, g, b)
				local delta = max - min
				local h, s, v = 0, 0, max
				if max ~= 0 then
					s = delta / max
				end
				if delta ~= 0 then
					if max == r then
						h = (g - b) / delta
						if g < b then
							h = h + 6
						end
					elseif max == g then
						h = (b - r) / delta + 2
					elseif max == b then
						h = (r - g) / delta + 4
					end
					h = h / 6
				end
				return h, s, v
			end
			
			function Colorpicker:color3ToHex(color)
				local r = math.floor(color.r * 255)
				local g = math.floor(color.g * 255)
				local b = math.floor(color.b * 255)
				return string.format("#%02X%02X%02X", r, g, b)
			end
			local Colorcode = Colorpicker["78"]
			function Colorpicker:updateColorCode()
				local color = Colorpicker["74"].BackgroundColor3
				local hexColorCode = Colorpicker:color3ToHex(color)
				Colorcode.cInput.Text = hexColorCode
			end

			function Colorpicker:setColor(hue,sat,val)
				Colorpicker.ColorData = {hue or Colorpicker.ColorData[1],sat or Colorpicker.ColorData[2],val or Colorpicker.ColorData[3]}
				Colorpicker.SelectedColor = Color3.fromHSV(Colorpicker.ColorData[1],Colorpicker.ColorData[2],Colorpicker.ColorData[3])
				Colorpicker["74"].BackgroundColor3 = Colorpicker.SelectedColor
				Colorpicker["70"].ImageColor3 = Color3.fromHSV(Colorpicker.ColorData[1],Colorpicker.ColorData[2],1)
				if Colorpicker.Element ~= nil then
					Colorpicker.Element.BackgroundColor3 = Colorpicker.SelectedColor
				end
			end

			function Colorpicker:inBounds(frame)
				local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
				local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
				if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
					return x/maxX,y/maxY
				end
			end

			function Colorpicker:updateRGB()
				if Colorpicker.MouseDown and Colorpicker["65"].Visible then
					local x,y = Colorpicker:inBounds(Colorpicker["6c"])
					if x and y then
						Colorpicker["6d"].Position = UDim2.new(x,0,y,0)
						Colorpicker:setColor(1 - x,1 - y)
						Colorpicker.Picking = true
					else
						Colorpicker.Picking = false
					end

					local x,y = Colorpicker:inBounds(Colorpicker["70"])
					if x and y then
						Colorpicker["71"].Position = UDim2.new(0.5,0,y,0)
						Colorpicker:setColor(nil,nil,1 - y)
						Colorpicker.Picking = true
					else
						Colorpicker.Picking = false
					end
				end
				Colorpicker:updateColorCode()
			end
			
			function Colorpicker:Toggle(options)
				options = Library:validate({
					name = 'default',
					color = Color3.fromRGB(255, 255, 255),
					element = nil
				}, options or {})
				if options.element == nil then return end
				Colorpicker["69"].Text = 'Colorpicker ['..tostring(options.name)..']'
				Colorpicker.IgnoreBounds = true
				if options.element ~= Colorpicker.Element then
					Colorpicker["65"].Visible = true
					Colorpicker.Picking = false
					Colorpicker.Element = nil
					Colorpicker.MouseDown = false
					Colorpicker.IgnoreBounds = true
					Colorpicker.SelectedColor = Color3.fromHSV(1,1,1)
					Colorpicker.ColorData = {1,1,1}
					Colorpicker.Element = options.element
					local tohsv = Colorpicker:RGBToHSV(options.element.BackgroundColor3)
					Colorpicker.SelectedColor = tohsv
					Colorpicker["74"].BackgroundColor3 = options.element.BackgroundColor3
				else
					local pickerw = Colorpicker["65"]
					pickerw.Visible = not pickerw.Visible
					if pickerw.Visible then
						Colorpicker.Element = options.element
						local tohsv = Colorpicker:RGBToHSV(options.element.BackgroundColor3)
						Colorpicker.SelectedColor = tohsv
						Colorpicker["74"].BackgroundColor3 = options.element.BackgroundColor3
					else
						Colorpicker.Picking = false
						Colorpicker.IgnoreBounds = true
						Colorpicker.Element = nil
						Colorpicker.MouseDown = false
						Colorpicker.SelectedColor = Color3.fromHSV(1,1,1)
						Colorpicker.ColorData = {1,1,1}
					end
				end
			end
		end
		
		
		--
		
	
		do
			
			-- handling1
			
			Mouse.Move:Connect(Colorpicker.updateRGB)
			UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Colorpicker["65"].Visible then
					local x,y = Colorpicker:inBounds(Colorpicker["65"])
					if x and y then
						Colorpicker.MouseDown = true
						Colorpicker.updateRGB()
					else
						if Colorpicker.IgnoreBounds then
							Colorpicker.IgnoreBounds = false
							return
						end
						Colorpicker["65"].Visible = false
						Colorpicker.Picking = false
						Colorpicker.Element = nil
						Colorpicker.MouseDown = false
						Colorpicker.SelectedColor = Color3.fromHSV(1,1,1)
						Colorpicker.ColorData = {1,1,1}
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Colorpicker.MouseDown = false
				end
			end)
			
			Colorpicker["74"]:GetPropertyChangedSignal("BackgroundColor3"):Connect(Colorpicker.updateColorCode)
			
			-- drag
			
			function Colorpicker:updateInput(input)
				local delta = input.Position - Colorpicker.DragStart
				local position = UDim2.new(Colorpicker.StartPos.X.Scale, Colorpicker.StartPos.X.Offset + delta.X,
					Colorpicker.StartPos.Y.Scale, Colorpicker.StartPos.Y.Offset + delta.Y)
				game:GetService('TweenService'):Create(Colorpicker["65"], TweenInfo.new(Colorpicker.DragSpeed), {Position = position}):Play()
			end
			Colorpicker["67"].InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (NewWindow["2"].Visible == true) then 
					Colorpicker.DragToggle = true
					Colorpicker.DragStart = input.Position
					Colorpicker.StartPos = Colorpicker["65"].Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							Colorpicker.DragToggle = false
						end
					end)
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch and (NewWindow["2"].Visible == true) then
					if Colorpicker.DragToggle then
						Colorpicker:updateInput(input)
					end
				end
			end)
			
		end
		
		
		return Colorpicker
	end
	
	NewWindow.ColorpickerWindow = NewWindow:CreateColorpicker()
	
	-- tooltip
	
	local Tooltip = {}
	
	-- create
	
	do
		-- StarterGui.NewWindow.Tooltip
		Tooltip["73"] = Instance.new("Frame", NewWindow["1"]);
		Tooltip["73"]["BorderSizePixel"] = 2;
		Tooltip["73"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
		Tooltip["73"]["Size"] = UDim2.new(0, 115, 0, 16);
		Tooltip["73"]["Position"] = UDim2.new(0, 529, 0, 71);
		Tooltip["73"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Tooltip["73"]["Name"] = [[Tooltip]];
		Tooltip["73"].Visible = false

		-- StarterGui.NewWindow.Tooltip.UIStroke
		Tooltip["74"] = Instance.new("UIStroke", Tooltip["73"]);
		Tooltip["74"]["Color"] = Color3.fromRGB(61, 61, 61);

		-- StarterGui.NewWindow.Tooltip.Header
		Tooltip["75"] = Instance.new("Frame", Tooltip["73"]);
		Tooltip["75"]["ZIndex"] = 4;
		Tooltip["75"]["BorderSizePixel"] = 0;
		Tooltip["75"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		Tooltip["75"]["Size"] = UDim2.new(0, 115, 0, 16);
		Tooltip["75"]["Position"] = UDim2.new(0, 0, 0, 0);
		Tooltip["75"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Tooltip["75"]["Name"] = [[Header]];
		Tooltip["75"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewWindow.Tooltip.Header.UIListLayout
		Tooltip["76"] = Instance.new("UIListLayout", Tooltip["75"]);
		Tooltip["76"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
		Tooltip["76"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.NewWindow.Tooltip.Header.Tip
		Tooltip["77"] = Instance.new("TextLabel", Tooltip["75"]);
		Tooltip["77"]["TextWrapped"] = true;
		Tooltip["77"]["ZIndex"] = 2;
		Tooltip["77"]["BorderSizePixel"] = 0;
		Tooltip["77"]["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
		Tooltip["77"]["TextXAlignment"] = Enum.TextXAlignment.Center;
		Tooltip["77"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
		Tooltip["77"]["TextSize"] = 14;
		Tooltip["77"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Tooltip["77"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Tooltip["77"]["BackgroundTransparency"] = 1;
		Tooltip["77"]["RichText"] = true;
		Tooltip["77"]["Size"] = UDim2.new(1,0,1,0)
		Tooltip["77"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Tooltip["77"]["Text"] = [[Enemy visible color]];
		Tooltip["77"]["Name"] = [[Tip]];
		Tooltip["77"]["Position"] = UDim2.new(0, 0, 0.03125, 0);
	end
	
	--watermark
	
	-- create
	
	function NewWindow:DisplayWatermark()
		
		if NewWindow.Watermark ~= nil then return end
		
		local NewWatermark = {
			Title = options.title
		}

		do
			-- StarterGui.NewNewWatermark.Watermark
			NewWatermark["8f"] = Instance.new("Frame", NewWindow["1"]);
			NewWatermark["8f"]["BorderSizePixel"] = 2;
			NewWatermark["8f"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			NewWatermark["8f"]["Size"] = UDim2.new(0, 418, 0, 19);
			NewWatermark["8f"]["Position"] = UDim2.new(0, 24, 0, 70);
			NewWatermark["8f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NewWatermark["8f"]["Name"] = [[Watermark]];

			-- StarterGui.NewNewWatermark.Watermark.UIStroke
			NewWatermark["90"] = Instance.new("UIStroke", NewWatermark["8f"]);
			NewWatermark["90"]["Color"] = Color3.fromRGB(61, 61, 61);

			-- StarterGui.NewNewWatermark.Watermark.Header
			NewWatermark["91"] = Instance.new("Frame", NewWatermark["8f"]);
			NewWatermark["91"]["ZIndex"] = 4;
			NewWatermark["91"]["BorderSizePixel"] = 0;
			NewWatermark["91"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
			NewWatermark["91"]["Size"] = UDim2.new(0, 427, 0, 15);
			NewWatermark["91"]["Position"] = UDim2.new(0, 4, 0, 2);
			NewWatermark["91"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NewWatermark["91"]["Name"] = [[Header]];
			NewWatermark["91"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewNewWatermark.Watermark.Header.UIListLayout
			NewWatermark["92"] = Instance.new("UIListLayout", NewWatermark["91"]);
			NewWatermark["92"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
			NewWatermark["92"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.NewNewWatermark.Watermark.Header.MenuTitle
			NewWatermark["93"] = Instance.new("TextLabel", NewWatermark["91"]);
			NewWatermark["93"]["TextWrapped"] = true;
			NewWatermark["93"]["ZIndex"] = 2;
			NewWatermark["93"]["BorderSizePixel"] = 0;
			NewWatermark["93"]["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
			NewWatermark["93"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			NewWatermark["93"]["TextScaled"] = true;
			NewWatermark["93"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
			NewWatermark["93"]["TextSize"] = 14;
			NewWatermark["93"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			NewWatermark["93"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			NewWatermark["93"]["BackgroundTransparency"] = 1;
			NewWatermark["93"]["RichText"] = true;
			NewWatermark["93"]["Size"] = UDim2.new(3, 0, 1, 0);
			NewWatermark["93"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NewWatermark["93"]["Text"] = NewWatermark.Title;
			NewWatermark["93"]["Name"] = [[MenuTitle]];
		end

		--scripts

		do
			local frame = NewWatermark["91"]
			local textlabel = NewWatermark["93"]

			local function adjust()
				textlabel.Size = UDim2.new(3,0,1,0)
				local textSize = textlabel.TextBounds
				NewWatermark["8f"].Size = UDim2.new(0, textSize.X + 10, NewWatermark["8f"].Size.Y.Scale, NewWatermark["8f"].Size.Y.Offset)
			end

			textlabel:GetPropertyChangedSignal('Text'):Connect(adjust)

			adjust()
		end

		-- functions
		

		do
			function NewWatermark:SetTitle(text)
				if typeof(text) ~= 'string' then return end
				NewWatermark["93"]["Text"] = NewWatermark.Title..' | '..text
			end

			function NewWatermark:SetVisible(bool)
				if bool == nil then
					NewWatermark["8f"].Visible = not NewWatermark["8f"].Visible
				else
					NewWatermark["8f"].Visible = bool
				end
			end
		end

		return NewWatermark
		
	end
	
	NewWindow.Watermark = NewWindow:DisplayWatermark()
	
	-- end watermark
	
	-- functions 
	
	do
		function Tooltip:size()
			Tooltip["77"].Size = UDim2.new((1+math.huge),0,1,0)
			local width = Tooltip["77"].TextBounds.X
			Tooltip["77"].Size = UDim2.new(0, width + 10, Tooltip["77"].Size.Y.Scale, Tooltip["77"].Size.Y.Offset)
			Tooltip["73"].Size = UDim2.new(0, width + 10, Tooltip["73"].Size.Y.Scale, Tooltip["73"].Size.Y.Offset)
		end
	end
	
	-- handling
	
	do
		Tooltip["77"]:GetPropertyChangedSignal('Text'):Connect(Tooltip.size)
	end
	
	-- windowscripts
	
	do
		function NewWindow:updateInput(input)
			local delta = input.Position - NewWindow.DragStart
			local position = UDim2.new(NewWindow.StartPos.X.Scale, NewWindow.StartPos.X.Offset + delta.X,
				NewWindow.StartPos.Y.Scale, NewWindow.StartPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(NewWindow["2"], TweenInfo.new(NewWindow.DragSpeed), {Position = position}):Play()
		end
		NewWindow["4"].InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (NewWindow["2"].Visible == true) then 
				NewWindow.DragToggle = true
				NewWindow.DragStart = input.Position
				NewWindow.StartPos = NewWindow["2"].Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						NewWindow.DragToggle = false
					end
				end)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch and (NewWindow["2"].Visible == true) then
				if NewWindow.DragToggle then
					NewWindow:updateInput(input)
				end
			end
		end)
	end
	
	-- Navigation
	
	do
		-- StarterGui.NewNewWindow.MainNewWindow.TabButtons
		NewWindow["c"] = Instance.new("Frame", NewWindow["2"]);
		NewWindow["c"]["ZIndex"] = 7;
		NewWindow["c"]["BorderSizePixel"] = 0;
		NewWindow["c"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		NewWindow["c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		NewWindow["c"]["Size"] = UDim2.new(0, 585, 0, 23);
		NewWindow["c"]["Position"] = UDim2.new(0, 311, 0, 41);
		NewWindow["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		NewWindow["c"]["Name"] = [[TabButtons]];
		NewWindow["c"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewNewWindow.MainNewWindow.TabButtons.UIListLayout
		NewWindow["d"] = Instance.new("UIListLayout", NewWindow["c"]);
		NewWindow["d"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
		NewWindow["d"]["Padding"] = UDim.new(0, 3);
		NewWindow["d"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
		NewWindow["d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		NewWindow["d"]["FillDirection"] = Enum.FillDirection.Horizontal;
	end
	
	-- navigation scripts
	
	do
		local layout = NewWindow["d"]
		function NewWindow:getTabs()
			local count = 0
			for i,v in ipairs(NewWindow["c"]:GetChildren()) do
				if v ~= nil and v:IsA('Frame') and v:FindFirstChild('Trigger') ~= nil then
					count += 1
				end
			end
			return count
		end
		function NewWindow:resizeButtons()
			local width = NewWindow["c"].AbsoluteSize.X
			local buttonCount = NewWindow:getTabs()
			warn(buttonCount)
			local spacing = layout.Padding.Offset * (buttonCount - 1)
			local widthLeft = (width - spacing)
			if buttonCount > 5 then
				local buttonWidth = (widthLeft / buttonCount)
				for i,v in ipairs(NewWindow["c"]:GetChildren()) do
					if v ~= nil and v:IsA('Frame') and v:FindFirstChild('Trigger') ~= nil then
						local DefaultY = v.Background.Size.Y
						v.Size = UDim2.new(0, buttonWidth, v.Size.Y.Scale, v.Size.Y.Offset)
						v.Background.Size = UDim2.new(0, buttonWidth, DefaultY.Scale, DefaultY.Offset)
						v.tabNameHolder.Size = UDim2.new(0, buttonWidth, DefaultY.Scale, DefaultY.Offset)
					end
				end
			end
		end
		NewWindow:resizeButtons()
		NewWindow["c"]:GetPropertyChangedSignal('AbsoluteSize'):Connect(NewWindow.resizeButtons)
	end
	
	
	-- keybindlist
	
	local BindsList = {
		DragToggle = nil,
		DragSpeed = 0,
		DragStart = nil,
		StartPos = nil
	}

	--render
	do
		-- StarterGui.NewBindsList.Keybindslist
		BindsList["7d"] = Instance.new("Frame", NewWindow["1"]);
		BindsList["7d"]["BorderSizePixel"] = 0;
		BindsList["7d"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 5);
		BindsList["7d"]["Size"] = UDim2.new(0, 193, 0, 136);
		BindsList["7d"]["Position"] = UDim2.new(0, 24, 0, 235);
		BindsList["7d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		BindsList["7d"]["Name"] = [[Keybindslist]];
		BindsList["7d"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewBindsList.Keybindslist._topBar
		BindsList["7e"] = Instance.new("Frame", BindsList["7d"]);
		BindsList["7e"]["BorderSizePixel"] = 0;
		BindsList["7e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		BindsList["7e"]["Size"] = UDim2.new(0, 198, 0, 1);
		BindsList["7e"]["Position"] = UDim2.new(-0.01036, 0, -0.02206, 0);
		BindsList["7e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		BindsList["7e"]["Name"] = [[_topBar]];

		-- StarterGui.NewBindsList.Keybindslist._topBar.UIGradient
		BindsList["7f"] = Instance.new("UIGradient", BindsList["7e"]);
		BindsList["7f"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Library.Colors.primary_color),ColorSequenceKeypoint.new(1.000, Library.Colors.secondary_color)};

		-- StarterGui.NewBindsList.Keybindslist.BindsListsFrame
		BindsList["80"] = Instance.new("Frame", BindsList["7d"]);
		BindsList["80"]["BorderSizePixel"] = 2;
		BindsList["80"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
		BindsList["80"]["Size"] = UDim2.new(0, 195, 0, 38);
		BindsList["80"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		BindsList["80"]["Name"] = [[BindsListsFrame]];

		-- StarterGui.NewBindsList.Keybindslist.BindsListsFrame.UIStroke
		BindsList["81"] = Instance.new("UIStroke", BindsList["80"]);
		BindsList["81"]["Color"] = Color3.fromRGB(61, 61, 61);

		-- StarterGui.NewBindsList.Keybindslist.BindsListsFrame.Container
		BindsList["82"] = Instance.new("Frame", BindsList["80"]);
		BindsList["82"]["BorderSizePixel"] = 0;
		BindsList["82"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		BindsList["82"]["Size"] = UDim2.new(0, 186, 0, 36);
		BindsList["82"]["Position"] = UDim2.new(0.02564, 0, 0.0354, 0);
		BindsList["82"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		BindsList["82"]["Name"] = [[Container]];
		BindsList["82"]["BackgroundTransparency"] = 1;

		-- StarterGui.NewBindsList.Keybindslist.BindsListsFrame.Container.UIListLayout
		BindsList["83"] = Instance.new("UIListLayout", BindsList["82"]);
		BindsList["83"]["Padding"] = UDim.new(0, 1);
		BindsList["83"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.NewBindsList.Keybindslist.BindsListsFrame.UIListLayout
		BindsList["86"] = Instance.new("UIListLayout", BindsList["80"]);
		BindsList["86"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
		BindsList["86"]["VerticalAlignment"] = Enum.VerticalAlignment.Top;
		BindsList["86"]["SortOrder"] = Enum.SortOrder.LayoutOrder;



	end

	--list functions 
	
	do
		function NewWindow:ToggleKeybinds(state)
			if state == nil then
				BindsList["7d"].Visible = not BindsList["7d"].Visible
			else
				BindsList["7d"].Visible = state
			end
		end
	end
	
	NewWindow:ToggleKeybinds(true)

	-- keybindslistscripts

	do
		
		-- sizing

		local pFrame = BindsList["80"] -- bindingsframe (list visible)
		local contentFrame = BindsList["82"] -- bindingsframe.container (labels holder)
		local layout = BindsList["83"] -- bindingsframe.container.uilistlayout
		function BindsList:resizeFrame(child)
			local cSize = layout.AbsoluteContentSize
			local pSize = pFrame.Size
			pFrame.Size = UDim2.new(pSize.X.Scale, pSize.X.Offset, 0, cSize.Y + 5)
			contentFrame.Size = UDim2.new(contentFrame.Size.X.Scale, contentFrame.Size.X.Offset, 0, cSize.Y)
		end
		BindsList:resizeFrame()

		--drag
		local function updateInput(input)
			local delta = input.Position - BindsList.DragStart
			local position = UDim2.new(BindsList.StartPos.X.Scale, BindsList.StartPos.X.Offset + delta.X,
				BindsList.StartPos.Y.Scale, BindsList.StartPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(BindsList["7d"], TweenInfo.new(BindsList.DragSpeed), {Position = position}):Play()
		end
		BindsList["7d"].InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (BindsList["7d"].Visible == true) then 
				BindsList.DragToggle = true
				BindsList.DragStart = input.Position
				BindsList.StartPos = BindsList["7d"].Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						BindsList.DragToggle = false
					end
				end)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch and (BindsList["7d"].Visible == true) then
				if BindsList.DragToggle then
					updateInput(input)
				end
			end
		end)
		--cons
		BindsList["7d"]:GetPropertyChangedSignal('Visible'):Connect(function() BindsList.DragToggle = false end)
	end
	
	--
	
	function NewWindow:ToggleWindow()
		NewWindow["2"].Visible = not NewWindow["2"].Visible
		if NewWindow["2"].Visible == false then NewWindow.DragToggle = false end
		if NewWindow.ColorpickerWindow ~= nil and not NewWindow["2"].Visible then
			NewWindow.ColorpickerWindow.DragToggle = false
			NewWindow.ColorpickerWindow["65"].Visible = false
			NewWindow.ColorpickerWindow.Picking = false
			NewWindow.ColorpickerWindow.Element = nil
			NewWindow.ColorpickerWindow.MouseDown = false
			NewWindow.ColorpickerWindow.SelectedColor = Color3.fromHSV(1,1,1)
			NewWindow.ColorpickerWindow.ColorData = {1,1,1}
		end
	end
	
	function NewWindow:SetMenuBind(Bind)
		NewWindow.MenuBind = Bind
	end
	
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == NewWindow.MenuBind then
			NewWindow:ToggleWindow()
		end
	end)
	
	function NewWindow:NewTab(options)
		options = Library:validate({
			name = 'tab'
		}, options or {})
		
		local Tab = {
			Hover = false,
			Active = false,
			Contents = nil
		}
		
		
		
		-- Buttons
		
		do
			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample
			Tab["f"] = Instance.new("Frame", NewWindow["c"]);
			Tab["f"]["BorderSizePixel"] = 2;
			Tab["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["f"]["Size"] = UDim2.new(0, 100, 0, 20);
			Tab["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["f"]["Name"] = [[_buttonExample]];
			Tab["f"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample.Background
			Tab["10"] = Instance.new("ImageLabel", Tab["f"]);
			Tab["10"]["BorderSizePixel"] = 0;
			Tab["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["10"]["Image"] = [[rbxassetid://18802371854]];
			Tab["10"]["Size"] = UDim2.new(0, 104, 0, 26);
			Tab["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["10"]["BackgroundTransparency"] = 1;
			Tab["10"]["Name"] = [[Background]];
			Tab["10"]["Position"] = UDim2.new(0, -1, 0, -2);
			Tab["10"]["Visible"] = false;

			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample.Trigger
			Tab["11"] = Instance.new("TextButton", Tab["f"]);
			Tab["11"]["BorderSizePixel"] = 0;
			Tab["11"]["TextSize"] = 14;
			Tab["11"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Tab["11"]["ZIndex"] = 4;
			Tab["11"]["Size"] = UDim2.new(0, 104, 0, 24);
			Tab["11"]["BackgroundTransparency"] = 1;
			Tab["11"]["Name"] = [[Trigger]];
			Tab["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["11"]["Text"] = [[]];
			Tab["11"]["Position"] = UDim2.new(0, -1, 0, -2);

			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample.tabNameHolder
			Tab["12"] = Instance.new("Frame", Tab["f"]);
			Tab["12"]["BorderSizePixel"] = 0;
			Tab["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["12"]["Size"] = UDim2.new(0, 104, 0, 23);
			Tab["12"]["Position"] = UDim2.new(0, 0, -0.1, 0);
			Tab["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["12"]["Name"] = [[tabNameHolder]];
			Tab["12"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample.tabNameHolder.UIListLayout
			Tab["13"] = Instance.new("UIListLayout", Tab["12"]);
			Tab["13"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			Tab["13"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
			Tab["13"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.NewTab.MainTab.TabButtons._buttonExample.tabNameHolder._tabname
			Tab["14"] = Instance.new("TextLabel", Tab["12"]);
			Tab["14"]["TextWrapped"] = true;
			Tab["14"]["TextStrokeTransparency"] = 0;
			Tab["14"]["ZIndex"] = 2;
			Tab["14"]["BorderSizePixel"] = 0;
			Tab["14"]["TextScaled"] = true;
			Tab["14"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
			Tab["14"]["TextSize"] = 14;
			Tab["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Tab["14"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["14"]["BackgroundTransparency"] = 1;
			Tab["14"]["RichText"] = true;
			Tab["14"]["Size"] = UDim2.new(0, 93, 0, 16);
			Tab["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["14"]["Text"] = options["name"];
			Tab["14"]["Name"] = [[_tabname]];
			Tab["14"]["Position"] = UDim2.new(0, 2, 0, 1);
		end
	
		-- Contents
		
		do
			-- StarterGui.NewNewWindow.MainNewWindow.TabContents
			Tab["1b"] = Instance.new("Frame", NewWindow["2"]);
			Tab["1b"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			Tab["1b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Tab["1b"]["Size"] = UDim2.new(0, 608, 0, 402);
			Tab["1b"]["Position"] = UDim2.new(0, 312, 0, 255);
			Tab["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["1b"]["Name"] = options["name"];
			Tab["1b"]["ClipsDescendants"] = true
			Tab["1b"].Visible = false

			-- StarterGui.NewTab.MainTab.TabContents.Left
			Tab["1c"] = Instance.new("ScrollingFrame", Tab["1b"]);
			Tab["1c"]["Active"] = true;
			Tab["1c"]["ZIndex"] = 5;
			Tab["1c"]["BorderSizePixel"] = 0;
			Tab["1c"]["CanvasSize"] = UDim2.new(0, 0, 100, 0);
			Tab["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
			Tab["1c"]["Name"] = [[Left]];
			Tab["1c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Tab["1c"]["ClipsDescendants"] = false;
			Tab["1c"]["Size"] = UDim2.new(0, 290, 0, 384);
			Tab["1c"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["1c"]["Position"] = UDim2.new(0, 152, 0, 200);
			Tab["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["1c"]["ScrollBarThickness"] = 0;
			Tab["1c"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewTab.MainTab.TabContents.Left.UIListLayout
			Tab["1d"] = Instance.new("UIListLayout", Tab["1c"]);
			Tab["1d"]["Wraps"] = true;
			Tab["1d"]["Padding"] = UDim.new(0, 5);
			Tab["1d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			Tab["1d"]["FillDirection"] = Enum.FillDirection.Horizontal;
			
			-- StarterGui.NewTab.MainTab.TabContents.Right
			Tab["62"] = Instance.new("ScrollingFrame", Tab["1b"]);
			Tab["62"]["Active"] = true;
			Tab["62"]["ZIndex"] = 5;
			Tab["62"]["BorderSizePixel"] = 0;
			Tab["62"]["CanvasSize"] = UDim2.new(0, 0, 100, 0);
			Tab["62"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
			Tab["62"]["Name"] = [[Right]];
			Tab["62"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Tab["62"]["ClipsDescendants"] = false;
			Tab["62"]["Size"] = UDim2.new(0, 290, 0, 384);
			Tab["62"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["62"]["Position"] = UDim2.new(0, 455, 0, 200);
			Tab["62"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["62"]["ScrollBarThickness"] = 0;
			Tab["62"]["BackgroundTransparency"] = 1;

			-- StarterGui.NewTab.MainTab.TabContents.Right.UIListLayout
			Tab["63"] = Instance.new("UIListLayout", Tab["62"]);
			Tab["63"]["Wraps"] = true;
			Tab["63"]["Padding"] = UDim.new(0, 5);
			Tab["63"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			Tab["63"]["FillDirection"] = Enum.FillDirection.Horizontal;
			Tab.Contents = Tab["1b"]
		end
		
		NewWindow:resizeButtons()
		
		--
		
		function Tab:NewSection(options)
			options = Library:validate({
				name = 'section',
				side = 'Left'
			}, options or {})
			
			local Section = {}

			local containers = {
				["left"] = Tab["1c"],
				["right"] = Tab["62"]
			}
			
			
			-- section render
			do
				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample
				Section["1e"] = Instance.new("Frame", containers[string.lower(options["side"])]);
				Section["1e"]["BorderSizePixel"] = 0;
				Section["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
				Section["1e"]["Size"] = UDim2.new(0, 295, 0, 308);
				Section["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["1e"]["Name"] = [[_sectionExample]];
				Section["1e"]["BackgroundTransparency"] = 1;

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.UIListLayout
				Section["1f"] = Instance.new("UIListLayout", Section["1e"]);
				Section["1f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder
				Section["20"] = Instance.new("Frame", Section["1e"]);
				Section["20"]["BorderSizePixel"] = 0;
				Section["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["20"]["Size"] = UDim2.new(0, 287, 0, 28);
				Section["20"]["Position"] = UDim2.new(0, 3, 0, 27);
				Section["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["20"]["Name"] = [[Holder]];
				Section["20"]["BackgroundTransparency"] = 1;

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder.Container
				Section["21"] = Instance.new("Frame", Section["20"]);
				Section["21"]["BorderSizePixel"] = 2;
				Section["21"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
				Section["21"]["Size"] = UDim2.new(0, 283,0, 34);
				Section["21"]["Position"] = UDim2.new(0, 3, 0, 5);
				Section["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["21"]["Name"] = [[Container]];

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder.Container.UIStroke
				Section["22"] = Instance.new("UIStroke", Section["21"]);
				Section["22"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
				Section["22"]["Color"] = Color3.fromRGB(61, 61, 61);

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder._sectionName
				Section["23"] = Instance.new("TextLabel", Section["20"]);
				Section["23"]["TextWrapped"] = true;
				Section["23"]["TextStrokeTransparency"] = 0;
				Section["23"]["ZIndex"] = 2;
				Section["23"]["BorderSizePixel"] = 0;
				Section["23"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["23"]["TextScaled"] = true;
				Section["23"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
				Section["23"]["TextSize"] = 14;
				Section["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Section["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["23"]["BackgroundTransparency"] = 1;
				Section["23"]["RichText"] = true;
				Section["23"]["Size"] = UDim2.new(0, 261, 0, 15);
				Section["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["23"]["Text"] = options["name"];
				Section["23"]["Name"] = [[_sectionName]];
				Section["23"]["Position"] = UDim2.new(0, 13, 0, -2);

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder.Children
				Section["24"] = Instance.new("Frame", Section["20"]);
				Section["24"]["BorderSizePixel"] = 0;
				Section["24"]["BackgroundColor3"] = Color3.fromRGB(171, 255, 0);
				Section["24"]["Size"] = UDim2.new(0, 266, 0, 256);
				Section["24"]["Position"] = UDim2.new(0, 13, 0, 20);
				Section["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["24"]["Name"] = [[Children]];
				Section["24"]["BackgroundTransparency"] = 1;

				-- StarterGui.NewNewWindow.MainNewWindow.TabContents.Left._sectionExample.Holder.Children.UIListLayout
				Section["25"] = Instance.new("UIListLayout", Section["24"]);
				Section["25"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
				
			end
			
			
			-- scripts
			
			do
				--// sizing

				local parentFrame = Section["24"]
				local container2 = parentFrame.Parent.Container
				local listLayout = Section["25"]
				local padding = listLayout.Padding.Offset
				local function adjustParentFrameHeight()
					local contentHeight = 0
					for _, child in ipairs(parentFrame:GetChildren()) do
						if child:IsA("GuiObject") then
							contentHeight = contentHeight + child.Size.Y.Offset
						end
					end
					contentHeight = contentHeight + padding * (#parentFrame:GetChildren() - 1)
					if contentHeight > parentFrame.AbsoluteSize.Y then
						parentFrame.Size = UDim2.new(parentFrame.Size.X.Scale, parentFrame.Size.X.Offset, 0, contentHeight)
						container2.Size = UDim2.new(container2.Size.X.Scale, container2.Size.X.Offset, 0, contentHeight + 30)
						Section["1e"].Size = UDim2.new(Section["1e"].Size.X.Scale, Section["1e"].Size.X.Offset, container2.Size.Y.Scale, container2.Size.Y.Offset + 10)
					else
						parentFrame.Size = UDim2.new(parentFrame.Size.X.Scale, parentFrame.Size.X.Offset, 0, contentHeight)
						container2.Size = UDim2.new(container2.Size.X.Scale, container2.Size.X.Offset, 0, contentHeight + 30)
						Section["1e"].Size = UDim2.new(Section["1e"].Size.X.Scale, Section["1e"].Size.X.Offset, container2.Size.Y.Scale, container2.Size.Y.Offset + 10)
					end
				end
				listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(adjustParentFrameHeight)
				parentFrame.ChildAdded:Connect(adjustParentFrameHeight)
				parentFrame.ChildRemoved:Connect(adjustParentFrameHeight)
				adjustParentFrameHeight()
			end
			


			-- elements
			
			function Section:AddButton(options)
				options = Library:validate({
					name = 'Button',
					callback = function() end
				}, options or {})
				
				
				local Button = {
					Hover = false,
					MouseDown = false
				}
				
				-- create
				
				do
					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample
					Button["26"] = Instance.new("Frame", Section["24"]);
					Button["26"]["BorderSizePixel"] = 0;
					Button["26"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					Button["26"]["Size"] = UDim2.new(0, 261, 0, 39);
					Button["26"]["Position"] = UDim2.new(0, 0, 0, 50);
					Button["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["26"]["Name"] = [[_buttonExample]];
					Button["26"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border
					Button["27"] = Instance.new("Frame", Button["26"]);
					Button["27"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					Button["27"]["Size"] = UDim2.new(0, 261, 0, 26);
					Button["27"]["Position"] = UDim2.new(0, 0, 0, 5);
					Button["27"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["27"]["Name"] = [[_border]];

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border._toggleName
					Button["28"] = Instance.new("TextLabel", Button["27"]);
					Button["28"]["TextWrapped"] = true;
					Button["28"]["TextStrokeTransparency"] = 0;
					Button["28"]["ZIndex"] = 2;
					Button["28"]["BorderSizePixel"] = 0;
					Button["28"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Button["28"]["TextScaled"] = true;
					Button["28"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Button["28"]["TextSize"] = 14;
					Button["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Button["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Button["28"]["BackgroundTransparency"] = 1;
					Button["28"]["RichText"] = true;
					Button["28"]["Size"] = UDim2.new(0, 259, 0, 16);
					Button["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["28"]["Text"] = options["name"];
					Button["28"]["Name"] = [[_toggleName]];
					Button["28"]["Position"] = UDim2.new(0, 1, 0, 5);

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border.buttontrigger
					Button["29"] = Instance.new("Frame", Button["27"]);
					Button["29"]["BorderSizePixel"] = 0;
					Button["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["29"]["Size"] = UDim2.new(0, 259, 0, 24);
					Button["29"]["Name"] = [[buttontrigger]];
					Button["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["29"]["Position"] = UDim2.new(0, 1, 0, 1);

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border.buttontrigger.UICorner
					Button["2a"] = Instance.new("UICorner", Button["29"]);
					Button["2a"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border.buttontrigger.UIStroke
					Button["2b"] = Instance.new("UIStroke", Button["29"]);
					Button["2b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					Button["2b"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewButton.MainButton.TabContents.Left._sectionExample.Holder.Children._buttonExample._border.buttontrigger.UIGradient
					Button["2c"] = Instance.new("UIGradient", Button["29"]);
					Button["2c"]["Rotation"] = 90;
					Button["2c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};
					
				end
				
				--
				
				function Button:SetText(text)
					if text == nil or typeof(text) ~= 'string' then return end
					Button["28"].Text = text
				end
				
				function Button:SetCallback(cb)
					options.callback = cb
				end
				
				-- logic
				
				do
					
					Button["26"].MouseEnter:Connect(function()
						Button.Hover = true
					end)
					
					Button["26"].MouseLeave:Connect(function()
						Button.Hover = false
					end)
					
					UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover and NewWindow:isMenuOpen() then
							Button.MouseDown = true
							Library:tween(Button["28"], {TextColor3 = Library.Colors.primary_color})
							options.callback()
						end
					end)
					
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
							Button.MouseDown = false
							Library:tween(Button["28"], {TextColor3 = Library.Colors.text_color})
						end
					end)
					
				end
				
				return Button
			end
			
			function Section:AddSlider(options)
                options = Library:validate({
                    name = 'Slider',
                    min = 0,
                    max = 100,
                    default = 50,
                    icon = '%',
                    callback = function(v) print(v) end
                }, options or {})
            
                local Slider = {
                    element = 'slider',
                    MouseDown = false,
                    Hover = false,
                    Connection = nil,
                    Amount = options.default,
                    ElementId = 0
                }
            
                Slider["2d"] = Instance.new("Frame", Section["24"])
                Slider["2d"]["BorderSizePixel"] = 0
                Slider["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0)
                Slider["2d"]["Size"] = UDim2.new(0, 261, 0, 39)
                Slider["2d"]["Position"] = UDim2.new(0, 0, 0, 50)
                Slider["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                Slider["2d"]["Name"] = [[_sliderExample]]
                Slider["2d"]["BackgroundTransparency"] = 1
            
                Slider["2e"] = Instance.new("TextLabel", Slider["2d"])
                Slider["2e"]["TextWrapped"] = true
                Slider["2e"]["TextStrokeTransparency"] = 0
                Slider["2e"]["ZIndex"] = 2
                Slider["2e"]["BorderSizePixel"] = 0
                Slider["2e"]["TextXAlignment"] = Enum.TextXAlignment.Left
                Slider["2e"]["TextScaled"] = true
                Slider["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59)
                Slider["2e"]["TextSize"] = 14
                Slider["2e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Slider["2e"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
                Slider["2e"]["BackgroundTransparency"] = 1
                Slider["2e"]["RichText"] = true
                Slider["2e"]["Size"] = UDim2.new(0, 259, 0, 16)
                Slider["2e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                Slider["2e"]["Text"] = options["name"]
                Slider["2e"]["Name"] = [[_sliderName]]
                Slider["2e"]["Position"] = UDim2.new(0, 0, 0, 2)
            
                Slider["2f"] = Instance.new("Frame", Slider["2d"])
                Slider["2f"]["BorderSizePixel"] = 0
                Slider["2f"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26)
                Slider["2f"]["Size"] = UDim2.new(0, 259, 0, 7)
                Slider["2f"]["Position"] = UDim2.new(0, 0, 0, 20)
                Slider["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                Slider["2f"]["Name"] = [[Slider]]
            
                Slider["30"] = Instance.new("UICorner", Slider["2f"])
                Slider["30"]["CornerRadius"] = UDim.new(0, 1)
            
                Slider["31"] = Instance.new("UIStroke", Slider["2f"])
                Slider["31"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
            
                Slider["32"] = Instance.new("Frame", Slider["2f"])
                Slider["32"]["BorderSizePixel"] = 0
                Slider["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
                Slider["32"]["Size"] = UDim2.new(0, 129, 0, 7)
                Slider["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                Slider["32"]["Name"] = [[Bar]]
            
                Slider["33"] = Instance.new("UICorner", Slider["32"])
                Slider["33"]["CornerRadius"] = UDim.new(0, 1)
            
                Slider["34"] = Instance.new("UIGradient", Slider["32"])
                Slider["34"]["Rotation"] = 90
                Slider["34"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Library.Colors.primary_color), ColorSequenceKeypoint.new(1.000, Library.Colors.secondary_color)}
            
                Slider["35"] = Instance.new("TextLabel", Slider["2d"])
                Slider["35"]["TextWrapped"] = true
                Slider["35"]["TextStrokeTransparency"] = 0
                Slider["35"]["ZIndex"] = 2
                Slider["35"]["BorderSizePixel"] = 0
                Slider["35"]["TextScaled"] = true
                Slider["35"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59)
                Slider["35"]["TextSize"] = 14
                Slider["35"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Slider["35"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
                Slider["35"]["BackgroundTransparency"] = 1
                Slider["35"]["RichText"] = true
                Slider["35"]["Size"] = UDim2.new(0, 261, 0, 16)
                Slider["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                Slider["35"]["Text"] = tostring(options["default"]) .. options["icon"]
                Slider["35"]["Name"] = [[amount]]
                Slider["35"]["Position"] = UDim2.new(0, 0, 0, 20)
            
                local newid = NewWindow.ElementId + 1
                NewWindow.Elements[newid] = {id = newid, state = Slider.Amount}
                NewWindow.ElementsStored[newid] = Slider
                Slider.ElementId = newid
                NewWindow.ElementId += 1
            
                function Slider:SetValue(v)
                    local valueTotal
                    if v == nil then
                        local percentage = math.clamp((Mouse.X - Slider["2f"].AbsolutePosition.X) / (Slider["2f"].AbsoluteSize.X), 0, 1)
                        local value = math.floor(((options.max - options.min) * percentage) + options.min)
                        Slider["35"].Text = tostring(value..options["icon"])
                        Slider["32"].Size = UDim2.new(percentage, 0, 1, 0)
                        valueTotal = tonumber(value)
                    else
                        Slider["35"].Text = tostring(v..options["icon"])
                        Slider["32"].Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
                        valueTotal = tonumber(v)
                    end
                    Slider.Amount = valueTotal
                    options.callback(valueTotal)
                    NewWindow.Elements[Slider.ElementId].state = valueTotal
                end
            
                Slider:SetValue(options["default"])
            
                Slider["2d"].MouseEnter:Connect(function()
                    Slider.Hover = true
                end)
            
                Slider["2d"].MouseLeave:Connect(function()
                    Slider.Hover = false
                end)
            
                UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover and NewWindow:isMenuOpen() then
                        Slider.MouseDown = true
                        if not Slider.Connection then
                            Slider.Connection = RunService.RenderStepped:Connect(function()
                                Slider:SetValue()
                            end)
                        end
                    end
                end)
            
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Slider.MouseDown = false
                        if Slider.Connection then Slider.Connection:Disconnect() end
                        Slider.Connection = nil
                    end
                end)
            
                return Slider
            end
			
			function Section:AddToggle(options)
				options = Library:validate({
					name = 'Toggle',
					tooltipenabled = false,
					tooltip = '',
					callback = function() end
				}, options or {})
				
				local Toggle = {
					element = 'toggle',
					Hover = false,
					MouseDown = false,
					State = false,
					Connection = nil,
					TooltipConnection = nil,
					ElementId = 0,
					
					
				}
				
				-- create
				
				do
					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample
					Toggle["36"] = Instance.new("Frame", Section["24"]);
					Toggle["36"]["BorderSizePixel"] = 0;
					Toggle["36"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					Toggle["36"]["Size"] = UDim2.new(0, 261, 0, 25);
					Toggle["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["36"]["Name"] = [[_toggleExample]];
					Toggle["36"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.togglebtn
					Toggle["37"] = Instance.new("Frame", Toggle["36"]);
					Toggle["37"]["BorderSizePixel"] = 0;
					Toggle["37"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["37"]["Size"] = UDim2.new(0, 10, 0, 10);
					Toggle["37"]["Name"] = [[togglebtn]];
					Toggle["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["37"]["Position"] = UDim2.new(0, 0, 0, 6);

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.togglebtn.UICorner
					Toggle["38"] = Instance.new("UICorner", Toggle["37"]);
					Toggle["38"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.togglebtn.UIStroke
					Toggle["39"] = Instance.new("UIStroke", Toggle["37"]);
					Toggle["39"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.togglebtn.UIGradient
					Toggle["3a"] = Instance.new("UIGradient", Toggle["37"]);
					Toggle["3a"]["Rotation"] = 90;
					Toggle["3a"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(122, 122, 122)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(36, 36, 36))};

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample._toggleName
					Toggle["3c"] = Instance.new("TextLabel", Toggle["36"]);
					Toggle["3c"]["TextWrapped"] = true;
					Toggle["3c"]["TextStrokeTransparency"] = 0;
					Toggle["3c"]["ZIndex"] = 2;
					Toggle["3c"]["BorderSizePixel"] = 0;
					Toggle["3c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Toggle["3c"]["TextScaled"] = true;
					Toggle["3c"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Toggle["3c"]["TextSize"] = 14;
					Toggle["3c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Toggle["3c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["3c"]["BackgroundTransparency"] = 1;
					Toggle["3c"]["RichText"] = true;
					Toggle["3c"]["Size"] = UDim2.new(0, 111, 0, 16);
					Toggle["3c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["3c"]["Text"] = options["name"];
					Toggle["3c"]["Name"] = [[_toggleName]];
					Toggle["3c"]["Position"] = UDim2.new(0, 17, 0, 3);

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements
					Toggle["3d"] = Instance.new("Frame", Toggle["36"]);
					Toggle["3d"]["BorderSizePixel"] = 0;
					Toggle["3d"]["BackgroundColor3"] = Color3.fromRGB(0, 171, 128);
					Toggle["3d"]["Size"] = UDim2.new(0, 114, 0, 15);
					Toggle["3d"]["Position"] = UDim2.new(0, 145, 0, 3);
					Toggle["3d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["3d"]["Name"] = [[Elements]];
					Toggle["3d"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewToggle.MainToggle.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.UIListLayout
					Toggle["3e"] = Instance.new("UIListLayout", Toggle["3d"]);
					Toggle["3e"]["Padding"] = UDim.new(0, 5);
					Toggle["3e"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
					Toggle["3e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					Toggle["3e"]["FillDirection"] = Enum.FillDirection.Horizontal;
					
					local newid = NewWindow.ElementId+1
					NewWindow.Elements[newid] = {id=newid, state=Toggle.State}
					Toggle.ElementId = newid
					NewWindow.ElementId+=1	
					NewWindow.ElementsStored[newid] = Toggle
					print('stored toggle in elements, id: '..NewWindow.ElementId)
				end
				
				--functions
				
				do
					function Toggle:SetState(state)
						if state == nil then
							Toggle.State = not Toggle.State
						else
							Toggle.State = state
						end
						
						if Toggle.Connection ~= nil then
							Toggle.Connection:Disconnect()
							Toggle.Connection = nil
						end
						
						if Toggle.State then
							Toggle["3c"].BackgroundColor3 = Color3.fromRGB(0,255,0)
							local data = {
								ColorSequenceKeypoint.new(0, Library.Colors.primary_color),
								ColorSequenceKeypoint.new(1, Library.Colors.secondary_color)
							}
							local begin = tick()
							Toggle.Connection = RunService.RenderStepped:Connect(function()
								local timepassed = tick() - begin
								local clamp = math.clamp(timepassed / 0.2, 0, 1)
								local c1, c2 = Toggle["3a"].Color.Keypoints[1].Value:Lerp(data[1].Value, clamp), Toggle["3a"].Color.Keypoints[2].Value:Lerp(data[2].Value, clamp)
								Toggle["3a"].Color = ColorSequence.new{
									ColorSequenceKeypoint.new(0, c1),
									ColorSequenceKeypoint.new(1, c2)
								}
								if clamp >= 1 then
									if Toggle.Connection ~= nil then
										Toggle.Connection:Disconnect()
										Toggle.Connection = nil
									end
									return
								end
							end)
						else
							Toggle["3c"].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
							local data = {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(122, 122, 122)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(36, 36, 36))
							}
							local begin = tick()
							Toggle.Connection = RunService.RenderStepped:Connect(function()
								local timepassed = tick() - begin
								local clamp = math.clamp(timepassed / 0.2, 0, 1)
								local c1, c2 = Toggle["3a"].Color.Keypoints[1].Value:Lerp(data[1].Value, clamp), Toggle["3a"].Color.Keypoints[2].Value:Lerp(data[2].Value, clamp)
								Toggle["3a"].Color = ColorSequence.new{
									ColorSequenceKeypoint.new(0, c1),
									ColorSequenceKeypoint.new(1, c2)
								}
								if clamp >= 1 then
									if Toggle.Connection ~= nil then
										Toggle.Connection:Disconnect()
										Toggle.Connection = nil
									end
									return
								end
							end)
						end
						options.callback(Toggle.State)	
						NewWindow.Elements[Toggle.ElementId].state = Toggle.State
						
					end
					
					
				end
				
				-- logic
				
				
				do
					Toggle["37"].MouseEnter:Connect(function()
						Toggle.Hover = true
						--[[
												if options.tooltipenabled then
							local tipframe = Tooltip["73"]
							Toggle.TooltipConnection = RunService.RenderStepped:Connect(function()
								if Toggle.Hover then
									tipframe.Header.Tip.Text = options.tooltip
									tipframe.Position = UDim2.fromOffset((Mouse.X), (Mouse.Y))
									tipframe.Visible = true
								else
									if Toggle.TooltipConnection ~= nil then
										Toggle.TooltipConnection:Disconnect()
										Toggle.TooltipConnection = nil
									end
									tipframe.Visible = false
								end
							end)
						end]]
					end)
					Toggle["37"].MouseLeave:Connect(function()
						Toggle.Hover = false
					end)
					
					UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover and NewWindow:isMenuOpen() then
							Toggle.MouseDown = true
							Toggle:SetState()
						end
					end)
					
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
							Toggle.MouseDown = false
						end
					end)
					
				end
				
				
				-- elements
				
				do
					function Toggle:NewColorpicker(options)
						options = Library:validate({
							name = 'default',
							defaultcolor = Library.Colors.secondary_color,
							tooltipenabled = false,
							tooltip = '',
							callback = function(color) print(color) end
						}, options or {})

						local NewPicker = {
							element = 'picker',
							Hover = false,
							MouseDown = false,
							CurrentColor = options["defaultcolor"],
							TooltipConnection = nil,
							ElementId = 0
						}


						-- create

						do
							-- StarterGui.NewNewPicker.MainNewPicker.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Colorpicker
							NewPicker["43"] = Instance.new("Frame", Toggle["3d"]);
							NewPicker["43"]["BorderSizePixel"] = 0;
							NewPicker["43"]["BackgroundColor3"] = options["defaultcolor"];
							NewPicker["43"]["Size"] = UDim2.new(0, 20, 0, 13);
							NewPicker["43"]["Position"] = UDim2.new(0, 0, 0, 1);
							NewPicker["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							NewPicker["43"]["Name"] = [[Colorpicker]];

							-- StarterGui.NewNewPicker.MainNewPicker.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Colorpicker.UIStroke
							NewPicker["44"] = Instance.new("UIStroke", NewPicker["43"]);
							NewPicker["44"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

							-- StarterGui.NewNewPicker.MainNewPicker.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Colorpicker.UICorner
							NewPicker["45"] = Instance.new("UICorner", NewPicker["43"]);
							NewPicker["45"]["CornerRadius"] = UDim.new(0, 1);
							
							local newid = NewWindow.ElementId+1
							NewWindow.Elements[newid] = {id=newid, state={red=NewPicker.CurrentColor.R, green=NewPicker.CurrentColor.G, blue=NewPicker.CurrentColor.B}}
							NewPicker.ElementId = newid
							NewWindow.ElementsStored[newid] = NewPicker
							NewWindow.ElementId+=1
						end

						--fuctions
						do
							function NewPicker:GetColor()
								local color = NewPicker["43"].BackgroundColor3
								local r = math.floor(color.R * 255)
								local g = math.floor(color.G * 255)
								local b = math.floor(color.B * 255)
								NewWindow.Elements[NewPicker.ElementId].state = {red=r,green=g,blue=b}
								return options.callback(Color3.fromRGB(r, g, b))
							end
							
							function NewPicker:ChangeColor(r, g, b)
								local color = NewPicker["43"]
								color.BackgroundColor3 = Color3.fromRGB(r, g, b)
								NewPicker.CurrentColor = Color3.fromRGB(r, g, b)
								NewWindow.Elements[NewPicker.ElementId].state = {red=r,green=g,blue=b}
								return options.callback(Color3.fromRGB(r, g, b))
							end

						end
						-- logic
						do
							NewPicker["43"].MouseEnter:Connect(function()
								NewPicker.Hover = true
								if NewPicker.TooltipConnection ~= nil then
									NewPicker.TooltipConnection:Disconnect()
									NewPicker.TooltipConnection = nil
								end
								--[[
																if options.tooltipenabled then
									local tipframe = Tooltip["73"]
									NewPicker.TooltipConnection = RunService.RenderStepped:Connect(function()
										if NewPicker.Hover then
											tipframe.Header.Tip.Text = options.tooltip
											tipframe.Position = UDim2.fromOffset((Mouse.X), (Mouse.Y))
											tipframe.Visible = true
										else
											if NewPicker.TooltipConnection ~= nil then
												NewPicker.TooltipConnection:Disconnect()
												NewPicker.TooltipConnection = nil
											end
											tipframe.Visible = false
										end
									end)
								end]]
							end)
							NewPicker["43"].MouseLeave:Connect(function()
								NewPicker.Hover = false
								if NewPicker.TooltipConnection ~= nil then
									NewPicker.TooltipConnection:Disconnect()
									NewPicker.TooltipConnection = nil
								end
								Tooltip["73"].Visible = false
							end)

							UserInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and NewPicker.Hover and NewWindow:isMenuOpen() then
									NewPicker.MouseDown = true
									NewWindow.ColorpickerWindow:Toggle({
										name = options.name,
										color = NewPicker["43"].BackgroundColor3,
										element = NewPicker["43"]
									})
								end
							end)						
							UserInputService.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and NewPicker.Hover then
									NewPicker.MouseDown = false
								end
							end)

							NewPicker["43"]:GetPropertyChangedSignal('BackgroundColor3'):Connect(NewPicker.GetColor)
						end
						return NewPicker
					end
					
					function Toggle:NewBind(options)
						options = Library:validate({
							callback = function(bind) print(bind) end,
							bind = nil
						}, options or {})
						
						local Binding = {
							element = 'bind',
							Hover = false,
							MouseDown = false,
							Bind = options.bind,
							ElementId = 0
						}
						
						-- create
						
						do
							-- StarterGui.NewBinding.MainBinding.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Keybind
							Binding["47"] = Instance.new("Frame", Toggle["3d"]);
							Binding["47"]["BorderSizePixel"] = 2;
							Binding["47"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
							Binding["47"]["Size"] = UDim2.new(0, 30, 0, 13);
							Binding["47"]["Position"] = UDim2.new(0, 49, 0, 1);
							Binding["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Binding["47"]["Name"] = [[Keybind]];

							-- StarterGui.NewBinding.MainBinding.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Keybind.UIStroke
							Binding["48"] = Instance.new("UIStroke", Binding["47"]);
							Binding["48"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
							Binding["48"]["Color"] = Color3.fromRGB(61, 61, 61);

							-- StarterGui.NewBinding.MainBinding.TabContents.Left._sectionExample.Holder.Children._toggleExample.Elements.Keybind.selected
							Binding["49"] = Instance.new("TextLabel", Binding["47"]);
							Binding["49"]["TextWrapped"] = true;
							Binding["49"]["TextStrokeTransparency"] = 0;
							Binding["49"]["ZIndex"] = 2;
							Binding["49"]["BorderSizePixel"] = 0;
							Binding["49"]["TextScaled"] = true;
							Binding["49"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
							Binding["49"]["TextSize"] = 14;
							Binding["49"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Binding["49"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
							Binding["49"]["BackgroundTransparency"] = 1;
							Binding["49"]["RichText"] = true;
							Binding["49"]["Size"] = UDim2.new(0, 30, 0, 14);
							Binding["49"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Binding["49"]["Text"] = 'none';
							Binding["49"]["Name"] = [[selected]];
							
							local newid = NewWindow.ElementId+1
							NewWindow.Elements[newid] = {id=newid, state=string.split(tostring(Binding.Bind), '.')[3]}
							Binding.ElementId = newid
							NewWindow.ElementsStored[newid] = Binding
							NewWindow.ElementId+=1
							print('stored binding in elements, id: '..NewWindow.ElementId)
							
						end
						
						-- functions
						
						
						do
							function Binding:SetBind(element, bind, manual)
								Binding.Bind = bind
								if element ~= nil then
									NewWindow.MenuKeybinds[element] = bind
								end
								NewWindow.Elements[Binding.ElementId].state = string.split(tostring(bind), '.')[3]
								Binding:RefreshList()
								if manual ~= nil and manual == true then
									Binding["49"].Text = Binding:GetBindName(bind)
								end
							end

							function Binding:GetBindName(bind)
								if bind == nil or typeof(bind) ~= 'EnumItem' then return end
								return string.split(tostring(bind), '.')[3]
							end


							function Binding:inBounds(frame)
								if frame == nil then return end
								local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
								local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
								if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
									return x/maxX,y/maxY
								end
							end
							
							function Binding:RefreshList()
								
								for i,v in pairs(BindsList["82"]:GetDescendants()) do
									if v ~= nil and v:IsA('TextLabel') then
										v:Destroy()
									end
								end 
								
								--create new
								
								
								
								for i,v in pairs(NewWindow.MenuKeybinds) do
									if v ~= nil then
										local label = i.Parent.Parent['_toggleName']
										local bindlabel = Instance.new("TextLabel", BindsList["82"]);
										bindlabel["Name"] = [[BindExample]];
										bindlabel["TextWrapped"] = true;
										bindlabel["ZIndex"] = 2;
										bindlabel["BorderSizePixel"] = 0;
										bindlabel["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
										bindlabel["TextXAlignment"] = Enum.TextXAlignment.Left;
										bindlabel["TextScaled"] = true;
										bindlabel["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
										bindlabel["TextSize"] = 14;
										bindlabel["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
										
										if label.BackgroundColor3 == Color3.fromRGB(0,255,0) then
											bindlabel["TextColor3"] = Library.Colors.primary_color
										elseif label.BackgroundColor3 == Color3.fromRGB(255,0,0) then
											bindlabel["TextColor3"] = Library.Colors.text_color
										else
											bindlabel["TextColor3"] = Library.Colors.text_color
										end
										bindlabel["BackgroundTransparency"] = 1;
										bindlabel["RichText"] = true;
										bindlabel["Size"] = UDim2.new(0, 186, 0, 16);
										bindlabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
										bindlabel["Text"] = "["..Binding:GetBindName(v).."]".." "..i.Parent.Parent:FindFirstChildOfClass('TextLabel').Text.." (Toggle)"
										bindlabel["Position"] = UDim2.new(0, 5, 0, 1);
										local obj = Instance.new('ObjectValue', bindlabel)
										obj.Value = i
										
										
									end
								end
								
								BindsList:resizeFrame()
								
							end
							
							Binding:RefreshList()
							
						end
						
						-- functionality

						
						
						do
							
							
							if NewWindow.MenuKeybinds[Binding["47"]] == nil then
								NewWindow.MenuKeybinds[Binding["47"]] = nil
							end
							
							if Binding.Bind ~= nil then
								Binding["49"]["Text"] = Binding:GetBindName(Binding.Bind)
								NewWindow.MenuKeybinds[Binding["47"]] = options.bind
								Binding:RefreshList()
								Binding["47"].Parent.Parent._toggleName:GetPropertyChangedSignal('BackgroundColor3'):Connect(function()
									if NewWindow.MenuKeybinds[Binding["47"]] ~= nil then
										for i,v in pairs(BindsList["82"]:GetDescendants()) do
											if v ~= nil and v:IsA('ObjectValue') and v.Value == Binding["47"] then
												local label = Binding["47"].Parent.Parent['_toggleName']
												if label.BackgroundColor3 == Color3.fromRGB(0,255,0) then
													Library:tween(v.Parent, {TextColor3 = Library.Colors.primary_color})
												elseif Binding["47"].Parent.Parent._toggleName.BackgroundColor3 == Color3.fromRGB(255,0,0) then
													Library:tween(v.Parent, {TextColor3 = Library.Colors.text_color})
												end
											end
										end 
									end
								end)
							end
							
							Binding["47"].MouseEnter:Connect(function()
								Binding.Hover = true
							end)
							Binding["47"].MouseLeave:Connect(function()
								Binding.Hover = false
							end)

							UserInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and Binding.Hover and NewWindow:isMenuOpen() then
									Binding.MouseDown = true

									if NewWindow.IsBinding then
										print('1a')
										NewWindow.IsBinding = false
										if NewWindow.CurrentlyBinding ~= nil and NewWindow.CurrentlyBinding ~= Binding["47"] then
											print('2a')
											local bindFrame = NewWindow.CurrentlyBinding

											Binding:SetBind(bindFrame, nil)

											NewWindow.CurrentlyBinding = nil
										end
									end
									


									NewWindow.IsBinding = true
									NewWindow.CurrentlyBinding = Binding["47"]
									NewWindow.TableStructure = Binding
									NewWindow.CurrentlyBinding.selected.Text = '...'
									NewWindow.BindOptions = options
								elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
									local x,y = Binding:inBounds(NewWindow.CurrentlyBinding)
									if not x and not y and NewWindow.IsBinding then
										NewWindow.IsBinding = false
										NewWindow.CurrentlyBinding.selected.Text = 'none'
										Binding:SetBind(NewWindow.CurrentlyBinding, nil)
										NewWindow.TableStructure = nil
										if NewWindow.CurrentlyBinding ~= nil and NewWindow.CurrentlyBinding ~= Binding["47"] then
											local bindFrame = NewWindow.CurrentlyBinding

											Binding:SetBind(bindFrame, nil)

											NewWindow.CurrentlyBinding = nil
										end
									end
								end
							end)
							UserInputService.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Binding.MouseDown = false
								end
							end)

							-- bind press

							UserInputService.InputBegan:Connect(function(input)
								if Binding.Bind ~= nil and input.KeyCode == Binding.Bind then
									options.callback(Binding.Bind)
								end
							end)
							-- bind detect
							UserInputService.InputBegan:Connect(function(input)
								if input.KeyCode and input.UserInputType == Enum.UserInputType.Keyboard and NewWindow.IsBinding and NewWindow.CurrentlyBinding ~= nil then
									NewWindow.IsBinding = false
									local bind = input.KeyCode
									local struct = NewWindow.TableStructure
									local ins = NewWindow.CurrentlyBinding
									if struct == nil then
										ins.selected.Text = 'none'
										struct:SetBind(ins, nil)
										NewWindow.TableStructure = nil
										NewWindow.CurrentlyBinding = nil
										return
									end
									ins.Parent.Parent._toggleName:GetPropertyChangedSignal('BackgroundColor3'):Connect(function()
										if NewWindow.MenuKeybinds[ins] ~= nil then
											
											for i,v in pairs(BindsList["82"]:GetDescendants()) do
												if v ~= nil and v:IsA('ObjectValue') and v.Value == ins then
													local label = ins.Parent.Parent['_toggleName']
													if label.BackgroundColor3 == Color3.fromRGB(0,255,0) then
														Library:tween(v.Parent, {TextColor3 = Library.Colors.primary_color})
													elseif ins.Parent.Parent._toggleName.BackgroundColor3 == Color3.fromRGB(255,0,0) then
														Library:tween(v.Parent, {TextColor3 = Library.Colors.text_color})
													end
												end
											end 
											
										end
									end)
									
									local bindname = struct:GetBindName(bind)
									struct:SetBind(ins, bind, true)
									NewWindow.BindOptions.callback(bind)
									NewWindow.CurrentlyBinding = nil
								end
							end)
						end
						
						
						return Binding
					end
					

					
					
				end
				return Toggle
			end
			
			function Section:AddTextLabel(options)
				options = Library:validate({
					text = 'TextLabel'
				}, options or {})
				
				local TextLabel = {}
				
				do
					-- StarterGui.NewTextLabel.MainTextLabel.TabContents.Left._sectionExample.Holder.Children._textlabelExample
					TextLabel["57"] = Instance.new("Frame", Section["24"]);
					TextLabel["57"]["BorderSizePixel"] = 0;
					TextLabel["57"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					TextLabel["57"]["Size"] = UDim2.new(0, 261, 0, 25);
					TextLabel["57"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					TextLabel["57"]["Name"] = [[_textlabelExample]];
					TextLabel["57"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewTextLabel.MainTextLabel.TabContents.Left._sectionExample.Holder.Children._textlabelExample._toggleName
					TextLabel["58"] = Instance.new("TextLabel", TextLabel["57"]);
					TextLabel["58"]["TextWrapped"] = true;
					TextLabel["58"]["TextStrokeTransparency"] = 0;
					TextLabel["58"]["ZIndex"] = 2;
					TextLabel["58"]["BorderSizePixel"] = 0;
					TextLabel["58"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					TextLabel["58"]["TextScaled"] = true;
					TextLabel["58"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					TextLabel["58"]["TextSize"] = 14;
					TextLabel["58"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					TextLabel["58"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					TextLabel["58"]["BackgroundTransparency"] = 1;
					TextLabel["58"]["RichText"] = true;
					TextLabel["58"]["Size"] = UDim2.new(0, 111, 0, 16);
					TextLabel["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					TextLabel["58"]["Text"] = options["text"];
					TextLabel["58"]["Name"] = [[_toggleName]];
					TextLabel["58"]["Position"] = UDim2.new(0, 0, 0, 3);
					
					-- StarterGui.NewTextLabel.MainTextLabel.TabContents.Left._sectionExample.Holder.Children._textlabelExample.Elements
					TextLabel["59"] = Instance.new("Frame", TextLabel["57"]);
					TextLabel["59"]["BorderSizePixel"] = 0;
					TextLabel["59"]["BackgroundColor3"] = Color3.fromRGB(0, 171, 128);
					TextLabel["59"]["Size"] = UDim2.new(0, 114, 0, 15);
					TextLabel["59"]["Position"] = UDim2.new(0, 145, 0, 3);
					TextLabel["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					TextLabel["59"]["Name"] = [[Elements]];
					TextLabel["59"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewTextLabel.MainTextLabel.TabContents.Left._sectionExample.Holder.Children._textlabelExample.Elements.UIListLayout
					TextLabel["5a"] = Instance.new("UIListLayout", TextLabel["59"]);
					TextLabel["5a"]["Padding"] = UDim.new(0, 5);
					TextLabel["5a"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
					TextLabel["5a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					TextLabel["5a"]["FillDirection"] = Enum.FillDirection.Horizontal;
				end
				
				
				-- elements
				
				
				return TextLabel
				
			end
			
			function Section:AddDropdown(options)
				options = Library:validate({
					name = 'Dropdown',
					items = {},
					callback = function(v) print(v) end
				}, options or {})
				
				local Dropdown = {
					element = 'dropdown',
					Items = {
						["id"] = {
							"value"
						}
					},
					Open = false,
					MouseDown = false,
					Hover = false,
					Selected = nil,
					ElementId = 0
				}
				
				--render
				
				do
					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample
					Dropdown["4a"] = Instance.new("Frame", Section["24"]);
					Dropdown["4a"]["ZIndex"] = 2;
					Dropdown["4a"]["BorderSizePixel"] = 0;
					Dropdown["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					Dropdown["4a"]["Size"] = UDim2.new(0, 261, 0, 47);
					Dropdown["4a"]["Position"] = UDim2.new(0, 0, 0, 152);
					Dropdown["4a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["4a"]["Name"] = [[_dropdownExample]];
					Dropdown["4a"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background
					Dropdown["4b"] = Instance.new("Frame", Dropdown["4a"]);
					Dropdown["4b"]["BorderSizePixel"] = 2;
					Dropdown["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["4b"]["Size"] = UDim2.new(0, 259, 0, 20);
					Dropdown["4b"]["Position"] = UDim2.new(0, 0, 0, 21);
					Dropdown["4b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["4b"]["Name"] = [[Background]];

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.UIStroke
					Dropdown["4c"] = Instance.new("UIStroke", Dropdown["4b"]);
					Dropdown["4c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					Dropdown["4c"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.UIGradient
					Dropdown["4d"] = Instance.new("UIGradient", Dropdown["4b"]);
					Dropdown["4d"]["Rotation"] = 90;
					Dropdown["4d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.ListOpener
					Dropdown["4e"] = Instance.new("ImageLabel", Dropdown["4b"]);
					Dropdown["4e"]["BorderSizePixel"] = 0;
					Dropdown["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["4e"]["Image"] = [[rbxassetid://120622981093648]];
					Dropdown["4e"]["Size"] = UDim2.new(0, 12, 0, 12);
					Dropdown["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["4e"]["BackgroundTransparency"] = 1;
					Dropdown["4e"]["Rotation"] = 90;
					Dropdown["4e"]["Name"] = [[ListOpener]];
					Dropdown["4e"]["Position"] = UDim2.new(0, 242, 0, 4);

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background._toggleName
					Dropdown["4f"] = Instance.new("TextLabel", Dropdown["4b"]);
					Dropdown["4f"]["TextWrapped"] = true;
					Dropdown["4f"]["TextStrokeTransparency"] = 0;
					Dropdown["4f"]["ZIndex"] = 2;
					Dropdown["4f"]["BorderSizePixel"] = 0;
					Dropdown["4f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["4f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Dropdown["4f"]["TextScaled"] = true;
					Dropdown["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Dropdown["4f"]["TextSize"] = 14;
					Dropdown["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Dropdown["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["4f"]["BackgroundTransparency"] = 1;
					Dropdown["4f"]["RichText"] = true;
					Dropdown["4f"]["Size"] = UDim2.new(0, 198, 0, 16);
					Dropdown["4f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["4f"]["Text"] = [[...]];
					Dropdown["4f"]["Name"] = [[_toggleName]];
					Dropdown["4f"]["Position"] = UDim2.new(0, 8, 0, 1);

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.Options
					Dropdown["50"] = Instance.new("Frame", Dropdown["4b"]);
					Dropdown["50"]["Visible"] = false;
					Dropdown["50"]["BorderSizePixel"] = 2;
					Dropdown["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["50"]["Size"] = UDim2.new(0, 260, 0, 0);
					Dropdown["50"]["Position"] = UDim2.new(0, 0, 0, 27);
					Dropdown["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["50"]["Name"] = [[Options]];

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.Options.UIStroke
					Dropdown["51"] = Instance.new("UIStroke", Dropdown["50"]);
					Dropdown["51"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					Dropdown["51"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.Options.UIGradient
					Dropdown["52"] = Instance.new("UIGradient", Dropdown["50"]);
					Dropdown["52"]["Rotation"] = -90;
					Dropdown["52"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.Options.Container
					Dropdown["53"] = Instance.new("ScrollingFrame", Dropdown["50"]);
					Dropdown["53"]["Active"] = true;
					Dropdown["53"]["BorderSizePixel"] = 0;
					Dropdown["53"]["CanvasSize"] = UDim2.new(0, 0, 10, 0);
					Dropdown["53"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["53"]["Name"] = [[Container]];
					Dropdown["53"]["Size"] = UDim2.new(0, 245, 0, 0);
					Dropdown["53"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["53"]["Position"] = UDim2.new(0, 8, 0, 1);
					Dropdown["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["53"]["ScrollBarThickness"] = 0;
					Dropdown["53"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample.Background.Options.Container.UIListLayout
					Dropdown["54"] = Instance.new("UIListLayout", Dropdown["53"]);
					Dropdown["54"]["Padding"] = UDim.new(0, 5);
					Dropdown["54"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


					-- StarterGui.NewDropdown.MainDropdown.TabContents.Left._sectionExample.Holder.Children._dropdownExample._toggleName
					Dropdown["56"] = Instance.new("TextLabel", Dropdown["4a"]);
					Dropdown["56"]["TextWrapped"] = true;
					Dropdown["56"]["TextStrokeTransparency"] = 0;
					Dropdown["56"]["ZIndex"] = 2;
					Dropdown["56"]["BorderSizePixel"] = 0;
					Dropdown["56"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["56"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Dropdown["56"]["TextScaled"] = true;
					Dropdown["56"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Dropdown["56"]["TextSize"] = 14;
					Dropdown["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Dropdown["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["56"]["BackgroundTransparency"] = 1;
					Dropdown["56"]["RichText"] = true;
					Dropdown["56"]["Size"] = UDim2.new(0, 260, 0, 16);
					Dropdown["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["56"]["Text"] = options.name;
					Dropdown["56"]["Name"] = [[_toggleName]];
					
					local newid = NewWindow.ElementId+1
					NewWindow.Elements[newid] = {id=newid, state=Dropdown.Selected}
					Dropdown.ElementId = newid
					NewWindow.ElementsStored[newid] = Dropdown
					NewWindow.ElementId+=1
					print('stored dropdown in elements, id: '..NewWindow.ElementId)
					
				end
				
				-- functions
				
				do
					
					function Dropdown:Select(id)
						if Dropdown.Selected ~= nil then
							Library:tween(Dropdown.Items[Dropdown.Selected].instance["55"], {TextColor3 = Library.Colors.text_color})
						end
						Dropdown["4f"].Text = id
						Dropdown.Selected = id
						NewWindow.Elements[Dropdown.ElementId].state = Dropdown.Selected
						Library:tween(Dropdown.Items[id].instance["55"], {TextColor3 = Library.Colors.primary_color})
						options.callback(id)
						
					end
					
					function Dropdown:Add(id, value)

						local Item = {
							Hover = false,
							MouseDown = false
						}

						if Dropdown.Items[id] ~= nil then
							return
						end

						Dropdown.Items[id] = {
							instance = {},
							value = value
						}

						Dropdown.Items[id].instance["55"] = Instance.new("TextLabel", Dropdown["53"]);
						Dropdown.Items[id].instance["55"]["TextWrapped"] = true;
						Dropdown.Items[id].instance["55"]["TextStrokeTransparency"] = 0;
						Dropdown.Items[id].instance["55"]["ZIndex"] = 2;
						Dropdown.Items[id].instance["55"]["BorderSizePixel"] = 0;
						Dropdown.Items[id].instance["55"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Dropdown.Items[id].instance["55"]["TextScaled"] = true;
						Dropdown.Items[id].instance["55"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
						Dropdown.Items[id].instance["55"]["TextSize"] = 14;
						Dropdown.Items[id].instance["55"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Dropdown.Items[id].instance["55"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Dropdown.Items[id].instance["55"]["BackgroundTransparency"] = 1;
						Dropdown.Items[id].instance["55"]["RichText"] = true;
						Dropdown.Items[id].instance["55"]["Size"] = UDim2.new(0, 246, 0, 16);
						Dropdown.Items[id].instance["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Dropdown.Items[id].instance["55"]["Text"] = id;
						Dropdown.Items[id].instance["55"]["Name"] = [[dropoption]];

						Dropdown.Items[id].instance["55"].MouseEnter:Connect(function()
							Item.Hover = true
							if Dropdown.Selected ~= id then
								Library:tween(Dropdown.Items[id].instance["55"], {TextColor3 = Library.Colors.primary_color})
							end
						end)
						Dropdown.Items[id].instance["55"].MouseLeave:Connect(function()
							Item.Hover = false
							if Dropdown.Selected ~= id then
								Library:tween(Dropdown.Items[id].instance["55"], {TextColor3 = Library.Colors.text_color})
							end
						end)

						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover and NewWindow:isMenuOpen() then
								Item.MouseDown = true
								
								Dropdown:Select(id)
								Dropdown:Toggle()
							end
						end)

						UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
								Item.MouseDown = false
							end
						end)
						

					end

					function Dropdown:Remove(id)
						if Dropdown.Items[id] ~= nil then
							if #Dropdown.Items[id].instance > 0 then
								for i,v in pairs(Dropdown.Items[id].instance) do
									v:Destroy()
								end
							end
							Dropdown.Items[id] = nil
						end
					end

					function Dropdown:Clear()
						for i,v in pairs(Dropdown.Items) do
							Dropdown:Remove(i)
						end
					end


					function Dropdown:Toggle()
						
						if NewWindow.CurrentListToggled ~= nil then
							Dropdown.Open = false
							local old; old = NewWindow.CurrentListToggled
							NewWindow.CurrentListToggled = nil
							old.ZIndex = 2
							Section["1e"].ZIndex = 1
							Library:tween(old.Background.ListOpener, {Rotation = 90})
							Library:tween(old.Background.Options, {Size = UDim2.new(1, 0, 0, 0)})
							Library:tween(old.Background.Options.Container, {Size = UDim2.new(1, 0, 0, 0)}, function()
								old.Background.Options.Visible = false
							end)
							return
						end
						
						if Dropdown.Open then
							Library:tween(Dropdown["4e"], {Rotation = 90})
							Library:tween(Dropdown["50"], {Size = UDim2.new(1, 0, 0, 0)})
							Library:tween(Dropdown["53"], {Size = UDim2.new(1, 0, 0, 0)}, function()
								Dropdown["50"].Visible = false
							end)
						else
							local count = 0
							for i,v in pairs(Dropdown.Items) do
								if v ~= nil then
									count += 1
								end
							end
							local c = (count-1)
							Library:tween(Dropdown["4e"], {Rotation = 0})
							Dropdown["4a"].ZIndex = 3
							Section["1e"].ZIndex = 2
							Dropdown["50"].Visible = true
							Library:tween(Dropdown["50"], {Size = UDim2.new(1, 0, c + .2, 0)})
							Library:tween(Dropdown["53"], {Size = UDim2.new(1, 0, c, 0)})
							NewWindow.CurrentListToggled = Dropdown["4a"]
						end
						Dropdown.Open = not Dropdown.Open
					end
					
					function Dropdown:inBounds(frame)
						if frame == nil then return end
						local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
						local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
						if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
							return x/maxX,y/maxY
						end
					end
					
				end
				
				--functionality
				
				do
					
					for value, item in pairs(options.items) do
						if typeof(item) ~= 'string' then return end
						Dropdown:Add(item, value)
					end
					
					Dropdown["4a"].MouseEnter:Connect(function()
						Dropdown.Hover = true
					end)
					Dropdown["4a"].MouseLeave:Connect(function()
						Dropdown.Hover = false
					end)

					UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Hover and NewWindow:isMenuOpen() then
							Dropdown.MouseDown = true
							Dropdown:Toggle()
						elseif Dropdown["50"].Visible then
							local x,y = Dropdown:inBounds(Dropdown["50"])
							if not x and not y then
								if Dropdown.Open then
									Dropdown.Open = false
									Library:tween(Dropdown["4e"], {Rotation = 90})
									Library:tween(Dropdown["50"], {Size = UDim2.new(1, 0, 0, 0)})
									Library:tween(Dropdown["53"], {Size = UDim2.new(1, 0, 0, 0)}, function()
										Dropdown["50"].Visible = false
									end)
									if NewWindow.CurrentListToggled ~= nil then
										local old; old = NewWindow.CurrentListToggled
										NewWindow.CurrentListToggled = nil
										old.ZIndex = 2
										Section["1e"].ZIndex = 1
										Library:tween(old.Background.ListOpener, {Rotation = 90})
										Library:tween(old.Background.Options, {Size = UDim2.new(1, 0, 0, 0)})
										Library:tween(old.Background.Options.Container, {Size = UDim2.new(1, 0, 0, 0)}, function()
											old.Background.Options.Visible = false
										end)
										return
									end
								end
							end
						end
					end)

					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Hover then
							Dropdown.MouseDown = false
						end
					end)
					
				end

				
				return Dropdown
			end
			
			function Section:AddCombolist(options)
				options = Library:validate({
					name = 'Combo',
					items = {},
					callback = function(v) print(v) end
				}, options or {})

				local Combolist = {
					element = 'combolist',
					Items = {
						["id"] = {
							"value"
						}
					},
					Open = false,
					MouseDown = false,
					Hover = false,
					Selected = {},
					ElementId = 0
				}

				--render

				do
					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample
					Combolist["4a"] = Instance.new("Frame", Section["24"]);
					Combolist["4a"]["ZIndex"] = 2;
					Combolist["4a"]["BorderSizePixel"] = 0;
					Combolist["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					Combolist["4a"]["Size"] = UDim2.new(0, 261, 0, 47);
					Combolist["4a"]["Position"] = UDim2.new(0, 0, 0, 152);
					Combolist["4a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["4a"]["Name"] = [[_CombolistExample]];
					Combolist["4a"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background
					Combolist["4b"] = Instance.new("Frame", Combolist["4a"]);
					Combolist["4b"]["BorderSizePixel"] = 2;
					Combolist["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["4b"]["Size"] = UDim2.new(0, 259, 0, 20);
					Combolist["4b"]["Position"] = UDim2.new(0, 0, 0, 21);
					Combolist["4b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["4b"]["Name"] = [[Background]];

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.UIStroke
					Combolist["4c"] = Instance.new("UIStroke", Combolist["4b"]);
					Combolist["4c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					Combolist["4c"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.UIGradient
					Combolist["4d"] = Instance.new("UIGradient", Combolist["4b"]);
					Combolist["4d"]["Rotation"] = 90;
					Combolist["4d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.ListOpener
					Combolist["4e"] = Instance.new("ImageLabel", Combolist["4b"]);
					Combolist["4e"]["BorderSizePixel"] = 0;
					Combolist["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["4e"]["Image"] = [[rbxassetid://120622981093648]];
					Combolist["4e"]["Size"] = UDim2.new(0, 12, 0, 12);
					Combolist["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["4e"]["BackgroundTransparency"] = 1;
					Combolist["4e"]["Rotation"] = 90;
					Combolist["4e"]["Name"] = [[ListOpener]];
					Combolist["4e"]["Position"] = UDim2.new(0, 242, 0, 4);

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background._toggleName
					Combolist["4f"] = Instance.new("TextLabel", Combolist["4b"]);
					Combolist["4f"]["TextWrapped"] = true;
					Combolist["4f"]["TextStrokeTransparency"] = 0;
					Combolist["4f"]["ZIndex"] = 2;
					Combolist["4f"]["BorderSizePixel"] = 0;
					Combolist["4f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Combolist["4f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Combolist["4f"]["TextScaled"] = true;
					Combolist["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Combolist["4f"]["TextSize"] = 14;
					Combolist["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Combolist["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["4f"]["BackgroundTransparency"] = 1;
					Combolist["4f"]["RichText"] = true;
					Combolist["4f"]["Size"] = UDim2.new(0, 198, 0, 16);
					Combolist["4f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["4f"]["Text"] = [[...]];
					Combolist["4f"]["Name"] = [[_toggleName]];
					Combolist["4f"]["Position"] = UDim2.new(0, 8, 0, 1);

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.Options
					Combolist["50"] = Instance.new("Frame", Combolist["4b"]);
					Combolist["50"]["Visible"] = false;
					Combolist["50"]["BorderSizePixel"] = 2;
					Combolist["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["50"]["Size"] = UDim2.new(0, 260, 0, 0);
					Combolist["50"]["Position"] = UDim2.new(0, 0, 0, 27);
					Combolist["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["50"]["Name"] = [[Options]];

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.Options.UIStroke
					Combolist["51"] = Instance.new("UIStroke", Combolist["50"]);
					Combolist["51"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					Combolist["51"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.Options.UIGradient
					Combolist["52"] = Instance.new("UIGradient", Combolist["50"]);
					Combolist["52"]["Rotation"] = -90;
					Combolist["52"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.Options.Container
					Combolist["53"] = Instance.new("ScrollingFrame", Combolist["50"]);
					Combolist["53"]["Active"] = true;
					Combolist["53"]["BorderSizePixel"] = 0;
					Combolist["53"]["CanvasSize"] = UDim2.new(0, 0, 10, 0);
					Combolist["53"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["53"]["Name"] = [[Container]];
					Combolist["53"]["Size"] = UDim2.new(0, 245, 0, 0);
					Combolist["53"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["53"]["Position"] = UDim2.new(0, 8, 0, 1);
					Combolist["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["53"]["ScrollBarThickness"] = 0;
					Combolist["53"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample.Background.Options.Container.UIListLayout
					Combolist["54"] = Instance.new("UIListLayout", Combolist["53"]);
					Combolist["54"]["Padding"] = UDim.new(0, 5);
					Combolist["54"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


					-- StarterGui.NewCombolist.MainCombolist.TabContents.Left._sectionExample.Holder.Children._CombolistExample._toggleName
					Combolist["56"] = Instance.new("TextLabel", Combolist["4a"]);
					Combolist["56"]["TextWrapped"] = true;
					Combolist["56"]["TextStrokeTransparency"] = 0;
					Combolist["56"]["ZIndex"] = 2;
					Combolist["56"]["BorderSizePixel"] = 0;
					Combolist["56"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Combolist["56"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Combolist["56"]["TextScaled"] = true;
					Combolist["56"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					Combolist["56"]["TextSize"] = 14;
					Combolist["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Combolist["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Combolist["56"]["BackgroundTransparency"] = 1;
					Combolist["56"]["RichText"] = true;
					Combolist["56"]["Size"] = UDim2.new(0, 260, 0, 16);
					Combolist["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Combolist["56"]["Text"] = options.name;
					Combolist["56"]["Name"] = [[_toggleName]];
					
					local newid = NewWindow.ElementId+1
					NewWindow.Elements[newid] = {id=newid, state=Combolist.Selected}
					Combolist.ElementId = newid
					NewWindow.ElementsStored[newid] = Combolist
					NewWindow.ElementId+=1
					print('stored combolist in elements, id: '..NewWindow.ElementId)
					
				end

				-- functions

				do
					
					function Combolist:UpdateValues()
						local tabtoname = Combolist:UpdateCombos(Combolist.Selected)
						Combolist["4f"].Text = tabtoname

						for i,v in pairs(Combolist["53"]:GetChildren()) do
							if v ~= nil and v:IsA('TextLabel') then
								v.TextColor3 = Color3.fromRGB(255,255,255)
								for _,nam in pairs(Combolist.Selected) do
									if nam == v.Text then
										Library:tween(v, {TextColor3 = Library.Colors.primary_color})
									end
								end
							end
						end

					end
					
					function Combolist:Add(id, value)

						local Item = {
							Hover = false,
							MouseDown = false
						}

						if Combolist.Items[id] ~= nil then
							return
						end

						Combolist.Items[id] = {
							instance = {},
							value = value
						}

						Combolist.Items[id].instance["55"] = Instance.new("TextLabel", Combolist["53"]);
						Combolist.Items[id].instance["55"]["TextWrapped"] = true;
						Combolist.Items[id].instance["55"]["TextStrokeTransparency"] = 0;
						Combolist.Items[id].instance["55"]["ZIndex"] = 2;
						Combolist.Items[id].instance["55"]["BorderSizePixel"] = 0;
						Combolist.Items[id].instance["55"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Combolist.Items[id].instance["55"]["TextScaled"] = true;
						Combolist.Items[id].instance["55"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
						Combolist.Items[id].instance["55"]["TextSize"] = 14;
						Combolist.Items[id].instance["55"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Combolist.Items[id].instance["55"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Combolist.Items[id].instance["55"]["BackgroundTransparency"] = 1;
						Combolist.Items[id].instance["55"]["RichText"] = true;
						Combolist.Items[id].instance["55"]["Size"] = UDim2.new(0, 246, 0, 16);
						Combolist.Items[id].instance["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Combolist.Items[id].instance["55"]["Text"] = id;
						Combolist.Items[id].instance["55"]["Name"] = [[dropoption]];

						Combolist.Items[id].instance["55"].MouseEnter:Connect(function()
							Item.Hover = true
							if table.find(Combolist.Selected, id) == nil then
								Library:tween(Combolist.Items[id].instance["55"], {TextColor3 = Library.Colors.primary_color})
							end
						end)
						Combolist.Items[id].instance["55"].MouseLeave:Connect(function()
							Item.Hover = false
							if table.find(Combolist.Selected, id) == nil then
								Library:tween(Combolist.Items[id].instance["55"], {TextColor3 = Library.Colors.text_color})
							end
						end)

						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover and NewWindow:isMenuOpen() then
								Item.MouseDown = true
								if table.find(Combolist.Selected, id) ~= nil then
									table.remove(Combolist.Selected, table.find(Combolist.Selected, id))
									if #Combolist.Selected <= 0 then Combolist["4f"].Text = '...' return options.callback(Combolist.Selected) end
									Combolist["4f"].Text = Combolist:UpdateCombos(Combolist.Selected)
									Library:tween(Combolist.Items[id].instance["55"], {TextColor3 = Library.Colors.text_color})
									
									return options.callback(Combolist.Selected)
								end
								table.insert(Combolist.Selected, id)
								Combolist["4f"].Text = Combolist:UpdateCombos(Combolist.Selected)
								NewWindow.Elements[Combolist.ElementId].state = Combolist.Selected
								Library:tween(Combolist.Items[id].instance["55"], {TextColor3 = Library.Colors.primary_color})
								return options.callback(Combolist.Selected)

							end
						end)

						UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
								Item.MouseDown = false
							end
						end)
						
					end
					
					function Combolist:UpdateCombos(list)
						if list == nil or list ~= nil and type(list) ~= 'table' then return end
						return table.concat(list, ', ')
					end

					function Combolist:Remove(id)
						if Combolist.Items[id] ~= nil then
							if #Combolist.Items[id].instance > 0 then
								for i,v in pairs(Combolist.Items[id].instance) do
									v:Destroy()
								end
							end
							Combolist.Items[id] = nil
						end
					end

					function Combolist:Clear()
						for i,v in pairs(Combolist.Items) do
							Combolist:Remove(i)
						end
					end

					function Combolist:Toggle()
						
						if NewWindow.CurrentListToggled ~= nil then
							Combolist.Open = false
							local old; old = NewWindow.CurrentListToggled
							NewWindow.CurrentListToggled = nil
							old.ZIndex = 2
							Section["1e"].ZIndex = 2
							Library:tween(old.Background.ListOpener, {Rotation = 90})
							Library:tween(old.Background.Options, {Size = UDim2.new(1, 0, 0, 0)})
							Library:tween(old.Background.Options.Container, {Size = UDim2.new(1, 0, 0, 0)}, function()
								old.Background.Options.Visible = false
							end)
							return
						end
						
						if Combolist.Open then
							Library:tween(Combolist["4e"], {Rotation = 90})
							Library:tween(Combolist["50"], {Size = UDim2.new(1, 0, 0, 0)})
							Library:tween(Combolist["53"], {Size = UDim2.new(1, 0, 0, 0)}, function()
								Combolist["50"].Visible = false
							end)
						else
							local count = 0
							for i,v in pairs(Combolist.Items) do
								if v ~= nil then
									count += 1
								end
							end
							local c = (count-1)
							Library:tween(Combolist["4e"], {Rotation = 0})
							Combolist["4a"].ZIndex = 3
							Section["1e"].ZIndex = 2
							Combolist["50"].Visible = true
							Library:tween(Combolist["50"], {Size = UDim2.new(1, 0, c + .2, 0)})
							Library:tween(Combolist["53"], {Size = UDim2.new(1, 0, c, 0)})
							NewWindow.CurrentListToggled = Combolist["4a"]
						end
						Combolist.Open = not Combolist.Open
					end

					function Combolist:inBounds(frame)
						if frame == nil then return end
						local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
						local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
						if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
							return x/maxX,y/maxY
						end
					end

				end

				--functionality

				do

					for value, item in pairs(options.items) do
						if typeof(item) ~= 'string' then return end
						Combolist:Add(item, value)
					end

					Combolist["4a"].MouseEnter:Connect(function()
						Combolist.Hover = true
					end)
					Combolist["4a"].MouseLeave:Connect(function()
						Combolist.Hover = false
					end)

					UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Combolist.Hover and NewWindow:isMenuOpen() then
							Combolist.MouseDown = true
							Combolist:Toggle()
						elseif Combolist["50"].Visible then
							local x,y = Combolist:inBounds(Combolist["50"])
							if not x and not y then
								if Combolist.Open then
									Combolist.Open = false
									Library:tween(Combolist["4e"], {Rotation = 90})
									Library:tween(Combolist["50"], {Size = UDim2.new(1, 0, 0, 0)})
									Library:tween(Combolist["53"], {Size = UDim2.new(1, 0, 0, 0)}, function()
										Combolist["50"].Visible = false
									end)
									if NewWindow.CurrentListToggled ~= nil then
										local old; old = NewWindow.CurrentListToggled
										NewWindow.CurrentListToggled = nil
										old.ZIndex = 2
										Library:tween(old.Background.ListOpener, {Rotation = 90})
										Library:tween(old.Background.Options, {Size = UDim2.new(1, 0, 0, 0)})
										Library:tween(old.Background.Options.Container, {Size = UDim2.new(1, 0, 0, 0)}, function()
											old.Background.Options.Visible = false
										end)
										return
									end

								end
							end
						end
					end)

					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Combolist.Hover then
							Combolist.MouseDown = false
						end
					end)

				end


				return Combolist
			end
			
			
			function Section:Configlist(options)
				
				options = Library:validate({
					placeids = nil
				}, options or {})
				
				local ConfigsTable = {
					Hover = nil,
					ButtonDown = false,
					SelectedConfig = nil,
					filename = '',
					configplaceids = nil
				}
				
				-- functions place ids
				
				do
					function ConfigsTable:filenameToTable(str)
						if str == nil or typeof(str) ~= 'string' then return end
						local ids = {}
						local toTable = string.split(str, '-')
						for i,v in pairs(toTable) do ids[i] = tonumber(v) end
						return ids
					end
				end
				
				-- place ids handling
				

				do				
					if type(options.placeids) == 'table' then
						if (#options.placeids > 0) then
							local insep = tostring(table.concat(options.placeids, '-'))
							ConfigsTable.configplaceids = {ids=options.placeids,filename=insep}
						end
					end
				end
				
				--create
				
				do
					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer
					ConfigsTable["20"] = Instance.new("Frame", Section["24"]);
					ConfigsTable["20"]["BorderSizePixel"] = 0;
					ConfigsTable["20"]["BackgroundColor3"] = Color3.fromRGB(171, 255, 0);
					ConfigsTable["20"]["Size"] = UDim2.new(0, 266, 0, 310);
					ConfigsTable["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["20"]["Name"] = [[ConfigsContainer]];
					ConfigsTable["20"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.UIListLayout
					ConfigsTable["21"] = Instance.new("UIListLayout", ConfigsTable["20"]);
					ConfigsTable["21"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore
					ConfigsTable["22"] = Instance.new("Frame", ConfigsTable["20"]);
					ConfigsTable["22"]["BorderSizePixel"] = 0;
					ConfigsTable["22"]["BackgroundColor3"] = Color3.fromRGB(255, 171, 0);
					ConfigsTable["22"]["Size"] = UDim2.new(0, 261, 0, 190);
					ConfigsTable["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["22"]["Name"] = [[ignore]];
					ConfigsTable["22"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.newlabel
					ConfigsTable["23"] = Instance.new("TextLabel", ConfigsTable["22"]);
					ConfigsTable["23"]["TextWrapped"] = true;
					ConfigsTable["23"]["TextStrokeTransparency"] = 0;
					ConfigsTable["23"]["ZIndex"] = 2;
					ConfigsTable["23"]["BorderSizePixel"] = 0;
					ConfigsTable["23"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					ConfigsTable["23"]["TextScaled"] = true;
					ConfigsTable["23"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					ConfigsTable["23"]["TextSize"] = 14;
					ConfigsTable["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["23"]["BackgroundTransparency"] = 1;
					ConfigsTable["23"]["RichText"] = true;
					ConfigsTable["23"]["Size"] = UDim2.new(0, 259, 0, 16);
					ConfigsTable["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["23"]["Text"] = [[Name:]];
					ConfigsTable["23"]["Name"] = [[newlabel]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.ConfigName
					ConfigsTable["24"] = Instance.new("Frame", ConfigsTable["22"]);
					ConfigsTable["24"]["BorderSizePixel"] = 2;
					ConfigsTable["24"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
					ConfigsTable["24"]["Size"] = UDim2.new(0, 259, 0, 15);
					ConfigsTable["24"]["Position"] = UDim2.new(0, 0, 0, 21);
					ConfigsTable["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["24"]["Name"] = [[ConfigName]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.ConfigName.UIStroke
					ConfigsTable["25"] = Instance.new("UIStroke", ConfigsTable["24"]);
					ConfigsTable["25"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					ConfigsTable["25"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.ConfigName.NameInput
					ConfigsTable["26"] = Instance.new("TextBox", ConfigsTable["24"]);
					ConfigsTable["26"]["CursorPosition"] = -1;
					ConfigsTable["26"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["26"]["BorderSizePixel"] = 0;
					ConfigsTable["26"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					ConfigsTable["26"]["TextWrapped"] = true;
					ConfigsTable["26"]["TextSize"] = 14;
					ConfigsTable["26"]["Name"] = [[NameInput]];
					ConfigsTable["26"]["TextScaled"] = true;
					ConfigsTable["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["26"]["Size"] = UDim2.new(0, 255, 0, 15);
					ConfigsTable["26"]["Position"] = UDim2.new(0.00772, 0, 0, 0);
					ConfigsTable["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["26"]["Text"] = [[]];
					ConfigsTable["26"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.ConfigName.UIListLayout
					ConfigsTable["27"] = Instance.new("UIListLayout", ConfigsTable["24"]);
					ConfigsTable["27"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
					ConfigsTable["27"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create
					ConfigsTable["28"] = Instance.new("Frame", ConfigsTable["22"]);
					ConfigsTable["28"]["BorderSizePixel"] = 0;
					ConfigsTable["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["28"]["Size"] = UDim2.new(0, 261, 0, 25);
					ConfigsTable["28"]["Position"] = UDim2.new(0, 0, 0.21579, 0);
					ConfigsTable["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["28"]["Name"] = [[Create]];
					ConfigsTable["28"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create.UIListLayout
					ConfigsTable["29"] = Instance.new("UIListLayout", ConfigsTable["28"]);
					ConfigsTable["29"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border
					ConfigsTable["2a"] = Instance.new("Frame", ConfigsTable["28"]);
					ConfigsTable["2a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["2a"]["Size"] = UDim2.new(0, 261, 0, 20);
					ConfigsTable["2a"]["Position"] = UDim2.new(0, 0, 0, 5);
					ConfigsTable["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["2a"]["Name"] = [[_border]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border._toggleName
					ConfigsTable["2b"] = Instance.new("TextLabel", ConfigsTable["2a"]);
					ConfigsTable["2b"]["TextWrapped"] = true;
					ConfigsTable["2b"]["TextStrokeTransparency"] = 0;
					ConfigsTable["2b"]["ZIndex"] = 2;
					ConfigsTable["2b"]["BorderSizePixel"] = 0;
					ConfigsTable["2b"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					ConfigsTable["2b"]["TextScaled"] = true;
					ConfigsTable["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					ConfigsTable["2b"]["TextSize"] = 14;
					ConfigsTable["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["2b"]["BackgroundTransparency"] = 1;
					ConfigsTable["2b"]["RichText"] = true;
					ConfigsTable["2b"]["Size"] = UDim2.new(0, 259, 0, 16);
					ConfigsTable["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["2b"]["Text"] = [[Create]];
					ConfigsTable["2b"]["Name"] = [[_toggleName]];
					ConfigsTable["2b"]["Position"] = UDim2.new(0, 1, 0, 2);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border.buttontrigger
					ConfigsTable["2c"] = Instance.new("Frame", ConfigsTable["2a"]);
					ConfigsTable["2c"]["BorderSizePixel"] = 0;
					ConfigsTable["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["2c"]["Size"] = UDim2.new(0, 259, 0, 18);
					ConfigsTable["2c"]["Name"] = [[buttontrigger]];
					ConfigsTable["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["2c"]["Position"] = UDim2.new(0, 1, 0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border.buttontrigger.UICorner
					ConfigsTable["2d"] = Instance.new("UICorner", ConfigsTable["2c"]);
					ConfigsTable["2d"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border.buttontrigger.UIStroke
					ConfigsTable["2e"] = Instance.new("UIStroke", ConfigsTable["2c"]);
					ConfigsTable["2e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					ConfigsTable["2e"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Create._border.buttontrigger.UIGradient
					ConfigsTable["2f"] = Instance.new("UIGradient", ConfigsTable["2c"]);
					ConfigsTable["2f"]["Rotation"] = 90;
					ConfigsTable["2f"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.ConfigsHolder
					ConfigsTable["30"] = Instance.new("ScrollingFrame", ConfigsTable["22"]);
					ConfigsTable["30"]["Active"] = true;
					ConfigsTable["30"]["BorderSizePixel"] = 0;
					ConfigsTable["30"]["CanvasSize"] = UDim2.new(0, 0, 10, 0);
					ConfigsTable["30"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
					ConfigsTable["30"]["Name"] = [[ConfigsHolder]];
					ConfigsTable["30"]["Size"] = UDim2.new(0, 261, 0, 141);
					ConfigsTable["30"]["ScrollBarImageColor3"] = Library.Colors.primary_color;
					ConfigsTable["30"]["Position"] = UDim2.new(0, 0, 0.34737, 0);
					ConfigsTable["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["30"]["ScrollBarThickness"] = 2;
					
					ConfigsTable["32"] = Instance.new("UIListLayout", ConfigsTable["30"]);
					ConfigsTable["32"]["Padding"] = UDim.new(0, 2);
					ConfigsTable["32"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons
					ConfigsTable["31"] = Instance.new("Frame", ConfigsTable["22"]);
					ConfigsTable["31"]["BorderSizePixel"] = 0;
					ConfigsTable["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["31"]["Size"] = UDim2.new(0, 261, 0, 80);
					ConfigsTable["31"]["Position"] = UDim2.new(0.00383, 0, 1.12105, 0);
					ConfigsTable["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["31"]["Name"] = [[Buttons]];
					ConfigsTable["31"]["BackgroundTransparency"] = 1;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons.UIListLayout
					ConfigsTable["32"] = Instance.new("UIListLayout", ConfigsTable["31"]);
					ConfigsTable["32"]["Padding"] = UDim.new(0, 5);
					ConfigsTable["32"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border
					ConfigsTable["33"] = Instance.new("Frame", ConfigsTable["31"]);
					ConfigsTable["33"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["33"]["Size"] = UDim2.new(0, 261, 0, 20);
					ConfigsTable["33"]["Position"] = UDim2.new(0, 0, 0, 5);
					ConfigsTable["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["33"]["Name"] = [[_border]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border._toggleName
					ConfigsTable["34"] = Instance.new("TextLabel", ConfigsTable["33"]);
					ConfigsTable["34"]["TextWrapped"] = true;
					ConfigsTable["34"]["TextStrokeTransparency"] = 0;
					ConfigsTable["34"]["ZIndex"] = 2;
					ConfigsTable["34"]["BorderSizePixel"] = 0;
					ConfigsTable["34"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					ConfigsTable["34"]["TextScaled"] = true;
					ConfigsTable["34"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					ConfigsTable["34"]["TextSize"] = 14;
					ConfigsTable["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["34"]["BackgroundTransparency"] = 1;
					ConfigsTable["34"]["RichText"] = true;
					ConfigsTable["34"]["Size"] = UDim2.new(0, 259, 0, 16);
					ConfigsTable["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["34"]["Text"] = [[Load]];
					ConfigsTable["34"]["Name"] = [[_toggleName]];
					ConfigsTable["34"]["Position"] = UDim2.new(0, 1, 0, 2);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger
					ConfigsTable["35"] = Instance.new("Frame", ConfigsTable["33"]);
					ConfigsTable["35"]["BorderSizePixel"] = 0;
					ConfigsTable["35"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["35"]["Size"] = UDim2.new(0, 259, 0, 18);
					ConfigsTable["35"]["Name"] = [[buttontrigger]];
					ConfigsTable["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["35"]["Position"] = UDim2.new(0, 1, 0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UICorner
					ConfigsTable["36"] = Instance.new("UICorner", ConfigsTable["35"]);
					ConfigsTable["36"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIStroke
					ConfigsTable["37"] = Instance.new("UIStroke", ConfigsTable["35"]);
					ConfigsTable["37"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					ConfigsTable["37"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIGradient
					ConfigsTable["38"] = Instance.new("UIGradient", ConfigsTable["35"]);
					ConfigsTable["38"]["Rotation"] = 90;
					ConfigsTable["38"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border
					ConfigsTable["39"] = Instance.new("Frame", ConfigsTable["31"]);
					ConfigsTable["39"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["39"]["Size"] = UDim2.new(0, 261, 0, 20);
					ConfigsTable["39"]["Position"] = UDim2.new(0, 0, 0, 5);
					ConfigsTable["39"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["39"]["Name"] = [[_border]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border._toggleName
					ConfigsTable["3a"] = Instance.new("TextLabel", ConfigsTable["39"]);
					ConfigsTable["3a"]["TextWrapped"] = true;
					ConfigsTable["3a"]["TextStrokeTransparency"] = 0;
					ConfigsTable["3a"]["ZIndex"] = 2;
					ConfigsTable["3a"]["BorderSizePixel"] = 0;
					ConfigsTable["3a"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					ConfigsTable["3a"]["TextScaled"] = true;
					ConfigsTable["3a"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					ConfigsTable["3a"]["TextSize"] = 14;
					ConfigsTable["3a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["3a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["3a"]["BackgroundTransparency"] = 1;
					ConfigsTable["3a"]["RichText"] = true;
					ConfigsTable["3a"]["Size"] = UDim2.new(0, 259, 0, 16);
					ConfigsTable["3a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["3a"]["Text"] = [[Overwrite]];
					ConfigsTable["3a"]["Name"] = [[_toggleName]];
					ConfigsTable["3a"]["Position"] = UDim2.new(0, 1, 0, 2);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger
					ConfigsTable["3b"] = Instance.new("Frame", ConfigsTable["39"]);
					ConfigsTable["3b"]["BorderSizePixel"] = 0;
					ConfigsTable["3b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["3b"]["Size"] = UDim2.new(0, 259, 0, 18);
					ConfigsTable["3b"]["Name"] = [[buttontrigger]];
					ConfigsTable["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["3b"]["Position"] = UDim2.new(0, 1, 0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UICorner
					ConfigsTable["3c"] = Instance.new("UICorner", ConfigsTable["3b"]);
					ConfigsTable["3c"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIStroke
					ConfigsTable["3d"] = Instance.new("UIStroke", ConfigsTable["3b"]);
					ConfigsTable["3d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					ConfigsTable["3d"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIGradient
					ConfigsTable["3e"] = Instance.new("UIGradient", ConfigsTable["3b"]);
					ConfigsTable["3e"]["Rotation"] = 90;
					ConfigsTable["3e"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border
					ConfigsTable["3f"] = Instance.new("Frame", ConfigsTable["31"]);
					ConfigsTable["3f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["3f"]["Size"] = UDim2.new(0, 261, 0, 20);
					ConfigsTable["3f"]["Position"] = UDim2.new(0, 0, 0, 5);
					ConfigsTable["3f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["3f"]["Name"] = [[_border]];

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border._toggleName
					ConfigsTable["40"] = Instance.new("TextLabel", ConfigsTable["3f"]);
					ConfigsTable["40"]["TextWrapped"] = true;
					ConfigsTable["40"]["TextStrokeTransparency"] = 0;
					ConfigsTable["40"]["ZIndex"] = 2;
					ConfigsTable["40"]["BorderSizePixel"] = 0;
					ConfigsTable["40"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					ConfigsTable["40"]["TextScaled"] = true;
					ConfigsTable["40"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
					ConfigsTable["40"]["TextSize"] = 14;
					ConfigsTable["40"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					ConfigsTable["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["40"]["BackgroundTransparency"] = 1;
					ConfigsTable["40"]["RichText"] = true;
					ConfigsTable["40"]["Size"] = UDim2.new(0, 259, 0, 16);
					ConfigsTable["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["40"]["Text"] = [[Delete]];
					ConfigsTable["40"]["Name"] = [[_toggleName]];
					ConfigsTable["40"]["Position"] = UDim2.new(0, 1, 0, 2);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger
					ConfigsTable["41"] = Instance.new("Frame", ConfigsTable["3f"]);
					ConfigsTable["41"]["BorderSizePixel"] = 0;
					ConfigsTable["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					ConfigsTable["41"]["Size"] = UDim2.new(0, 259, 0, 18);
					ConfigsTable["41"]["Name"] = [[buttontrigger]];
					ConfigsTable["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					ConfigsTable["41"]["Position"] = UDim2.new(0, 1, 0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UICorner
					ConfigsTable["42"] = Instance.new("UICorner", ConfigsTable["41"]);
					ConfigsTable["42"]["CornerRadius"] = UDim.new(0, 1);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIStroke
					ConfigsTable["43"] = Instance.new("UIStroke", ConfigsTable["41"]);
					ConfigsTable["43"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					ConfigsTable["43"]["Color"] = Color3.fromRGB(61, 61, 61);

					-- StarterGui.NewWindow.MainWindow.TabContents.Right._sectionExample.Holder.Children.ConfigsContainer.ignore.Buttons._border.buttontrigger.UIGradient
					ConfigsTable["44"] = Instance.new("UIGradient", ConfigsTable["41"]);
					ConfigsTable["44"]["Rotation"] = 90;
					ConfigsTable["44"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 27, 27)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(41, 41, 41))};
				end
				
				--functions
				
				function ConfigsTable:CheckConfigName(str)
					return #str > 0 and str:match("%S") ~= nil
				end
				
				function ConfigsTable:CreateConfigLabel(cfgname)
					
					local Label = {
						Hover = false,
						MouseDown = false
					}
					
					-- create
					
					do
						Label["33"] = Instance.new("TextLabel", ConfigsTable["30"]);
						Label["33"]["TextWrapped"] = true;
						Label["33"]["ZIndex"] = 2;
						Label["33"]["BorderSizePixel"] = 0;
						Label["33"]["TextStrokeColor3"] = Color3.fromRGB(61, 61, 61);
						Label["33"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Label["33"]["TextScaled"] = true;
						Label["33"]["BackgroundColor3"] = Color3.fromRGB(255, 59, 59);
						Label["33"]["TextSize"] = 14;
						Label["33"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Label["33"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Label["33"]["BackgroundTransparency"] = 1;
						Label["33"]["Size"] = UDim2.new(0, 253, 0, 16);
						Label["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Label["33"]["Text"] = tostring(cfgname)..'.txt';
						Label["33"]["Name"] = tostring(cfgname);
					end
					
					
					-- logic
					

					do
					
						
						Label["33"].MouseEnter:Connect(function()
							Label.Hover = true
						end)
						Label["33"].MouseLeave:Connect(function()
							Label.Hover = false
						end)

						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Label.Hover and NewWindow:isMenuOpen() then
								Label.MouseDown = true
								if ConfigsTable.SelectedConfig ~= nil then
									Library:tween(ConfigsTable.SelectedConfig, {TextColor3 = Library.Colors.text_color})
								end
								Library:tween(Label["33"], {TextColor3 = Library.Colors.primary_color})
								ConfigsTable.SelectedConfig = Label["33"]
								ConfigsTable.filename = tostring(cfgname)..'.txt'
							end
						end)
						UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Label.Hover and NewWindow:isMenuOpen() then
								Label.MouseDown = false
							end
						end)
					end
					
					return Label
					
				end
				
				do
					function ConfigsTable:UpdateConfigList()
						
						for _,v in pairs(ConfigsTable["30"]:GetChildren()) do
							if v ~= nil and v:IsA('TextLabel') then
								v:Destroy()
							end
						end
						ConfigsTable.SelectedConfig = nil
						
						if not isfolder(NewWindow.MenuName) then makefolder(NewWindow.MenuName) end

						if ConfigsTable.configplaceids == nil then
							
							for index, cfg in pairs(listfiles(NewWindow.MenuName..'\\configs')) do

								if isfile(cfg) then
									local newname = string.split(cfg, '/')[3]
									newname = newname:gsub('.txt', '')
									ConfigsTable:CreateConfigLabel(newname)
								end
							end
							
						else
							
							
							if not isfolder(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename) then
								makefolder(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename)
							end
							
							for _,v in pairs(ConfigsTable["30"]:GetChildren()) do
								if v ~= nil and v:IsA('TextLabel') then
									v:Destroy()
								end
							end
							ConfigsTable.SelectedConfig = nil

							
							for index, cfg in pairs(listfiles(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename)) do
								if isfile(cfg) then
									local newname = string.split(cfg, '/')[4]
									newname = newname:gsub('.txt', '')
									ConfigsTable:CreateConfigLabel(newname)
								end
							end
							
						end

					end

					ConfigsTable:UpdateConfigList()
				end
				
				--logic
				
				do
					ConfigsTable["2b"].MouseEnter:Connect(function() -- create
						ConfigsTable.Hover = ConfigsTable["2b"]
					end)
					ConfigsTable["2b"].MouseLeave:Connect(function()
						ConfigsTable.Hover = nil
					end)

					ConfigsTable["34"].MouseEnter:Connect(function() -- load
						ConfigsTable.Hover = ConfigsTable["34"]
					end)
					ConfigsTable["34"].MouseLeave:Connect(function()
						ConfigsTable.Hover = nil
					end)

					ConfigsTable["3a"].MouseEnter:Connect(function() -- overwrite
						ConfigsTable.Hover = ConfigsTable["3a"]
					end)
					ConfigsTable["3a"].MouseLeave:Connect(function()
						ConfigsTable.Hover = nil
					end)

					ConfigsTable["40"].MouseEnter:Connect(function() -- delete
						ConfigsTable.Hover = ConfigsTable["40"]
					end)
					ConfigsTable["40"].MouseLeave:Connect(function()
						ConfigsTable.Hover = nil
					end)




					UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and ConfigsTable.Hover ~= nil and NewWindow:isMenuOpen() then
							Library:tween(ConfigsTable.Hover, {TextColor3 = Library.Colors.primary_color})
							ConfigsTable.ButtonDown = true
							local action = string.lower(ConfigsTable.Hover.Text)
							if (action == 'create') then
								local configname = tostring(ConfigsTable["26"].Text)
								local check = ConfigsTable:CheckConfigName(configname)
								if check == false then configname = 'config'..tostring(math.random(10000,99999)) end
								configname = configname:gsub(" ", "_"); configname = configname:gsub(".txt", "")
								local data = HttpService:JSONEncode(NewWindow.Elements)
								if not isfolder(NewWindow.MenuName) then makefolder(NewWindow.MenuName) end				
								if not isfolder(NewWindow.MenuName..'\\configs') then makefolder(NewWindow.MenuName..'\\configs') end
								if not isfolder(NewWindow.MenuName..'\\configs') then makefolder(NewWindow.MenuName..'\\configs') end
								if ConfigsTable.configplaceids ~= nil then if not isfolder(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename) then makefolder(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename) end end
								
								
								
								if not isfile(NewWindow.MenuName..'\\configs\\'..configname..'.txt') then
									if ConfigsTable.configplaceids == nil then
										writefile(NewWindow.MenuName..'\\configs\\'..configname..'.txt', data)
									else
										writefile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..configname..'.txt', data)
									end
								else
									if ConfigsTable.configplaceids == nil then
										local count = 0
										for index, cfg in pairs(listfiles(NewWindow.MenuName..'\\configs')) do
											local newname = string.split(cfg, '/')[2]
											newname = newname:gsub('.txt', '')
											if string.find(string.lower(newname), string.lower(configname)) and #configname > 3 then
												count += 1
											end
										end
										configname = configname..'('..count..')'
										writefile(NewWindow.MenuName..'\\configs\\'..configname..'.txt', data)
									else
										local count = 0
										for index, cfg in pairs(listfiles(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename)) do
											local newname = string.split(cfg, '/')[2]
											newname = newname:gsub('.txt', '')
											if string.find(string.lower(newname), string.lower(configname)) and #configname > 3 then
												count += 1
											end
										end
										configname = configname..'('..count..')'
										writefile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..configname..'.txt', data)
									end
								end
								ConfigsTable.SelectedConfig = nil
								ConfigsTable:UpdateConfigList()
							elseif (action == 'delete') then
								local selectedcfg = ConfigsTable.SelectedConfig
								if selectedcfg == nil then return end
								selectedcfg:Destroy()
								ConfigsTable.SelectedConfig = nil
								if ConfigsTable.configplaceids == nil then
									if isfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.filename) then
										delfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.filename)
									end
								else
									if isfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..ConfigsTable.filename) then
										delfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..ConfigsTable.filename)
									end
								end
								ConfigsTable:UpdateConfigList()
							elseif (action == 'overwrite') then
								local selectedcfg = ConfigsTable.SelectedConfig
								local filename = ConfigsTable.filename
								if selectedcfg == nil then return end
								local data = HttpService:JSONEncode(NewWindow.Elements)
								if ConfigsTable.configplaceids == nil then
									if isfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.filename) then 
										appendfile(NewWindow.MenuName..'\\configs'..ConfigsTable.filename, data)
									end
								else
									if isfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..ConfigsTable.filename) then 
										appendfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..ConfigsTable.filename, data)
									end
								end
								ConfigsTable.SelectedConfig = nil
								ConfigsTable:UpdateConfigList()
							elseif (action == 'load') then
								local selectedcfg = ConfigsTable.SelectedConfig
								local filename = ConfigsTable.filename
								if selectedcfg == nil then return end
								local filePath
								if ConfigsTable.configplaceids == nil then
									filePath = NewWindow.MenuName..'\\configs\\'..filename
								else
									filePath = NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..filename
								end
								local data
								if ConfigsTable.configplaceids == nil then
									data = HttpService:JSONDecode(readfile(NewWindow.MenuName..'\\configs\\'..filename))
								else
									
									data = HttpService:JSONDecode(readfile(NewWindow.MenuName..'\\configs\\'..ConfigsTable.configplaceids.filename..'\\'..filename))
								end
								for i,v in pairs(data) do
									if NewWindow.ElementsStored[v.id] ~= nil then
										if (string.lower(NewWindow.ElementsStored[v.id].element) == 'toggle') then
											NewWindow.ElementsStored[v.id]:SetState(v.state)
										elseif (string.lower(NewWindow.ElementsStored[v.id].element) == 'slider') then
											NewWindow.ElementsStored[v.id]:SetValue(v.state)
										elseif (string.lower(NewWindow.ElementsStored[v.id].element) == 'dropdown') then
											NewWindow.ElementsStored[v.id]:Select(v.state)
										elseif (string.lower(NewWindow.ElementsStored[v.id].element) == 'combolist') then
											NewWindow.ElementsStored[v.id].Selected = v.state
											NewWindow.ElementsStored[v.id]:UpdateValues()
										elseif (string.lower(NewWindow.ElementsStored[v.id].element) == 'bind') then
											NewWindow.ElementsStored[v.id]:SetBind(NewWindow.ElementsStored[v.id]["47"], Enum.KeyCode[v.state], true)
										elseif (string.lower(NewWindow.ElementsStored[v.id].element) == 'picker') then
											NewWindow.ElementsStored[v.id]:ChangeColor(v.state.red, v.state.green, v.state.blue)
										end
									end 
								end
								ConfigsTable.SelectedConfig = nil
								ConfigsTable:UpdateConfigList()
							end
						end
					end)	

					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and ConfigsTable.Hover ~= nil then
							Library:tween(ConfigsTable.Hover, {TextColor3 = Library.Colors.text_color})
							ConfigsTable.ButtonDown = false
						end
					end)
				end
				
				
				return ConfigsTable
				
			end
			
			return Section
		end
		
		function Tab:Activate()
			if not Tab.Active then
				if NewWindow.SelectedTab ~= nil then
					NewWindow.SelectedTab:Deactivate()
				end
				
				
				Tab.Active = true
				Library:tween(Tab["14"], {TextColor3 = Library.Colors.primary_color})
				Tab["10"].Visible = true
				
				Tab.Contents.Visible = true
				NewWindow.SelectedTab = Tab
			end
		end
		
		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Library:tween(Tab["14"], {TextColor3 = Library.Colors.text_color})
				Tab["10"].Visible = false
				Tab.Contents.Visible = false
			end
		end
		

--

		do
			Tab["f"].MouseEnter:Connect(function()
				Tab.Hover = true
				if not Tab.Active then
					Library:tween(Tab["14"], {TextColor3 = Library.Colors.primary_color})
				end
			end)

			Tab["f"].MouseLeave:Connect(function()
				Tab.Hover = false
				if not Tab.Active then
					Library:tween(Tab["14"], {TextColor3 = Library.Colors.text_color})
				end
			end)

			UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if Tab.Hover and NewWindow:isMenuOpen() then
						Tab:Activate()
					end
				end
			end)

			if NewWindow.SelectedTab == nil then
				Tab:Activate()
			end

		end
		
		
		
		return Tab
	end

	
	return NewWindow
end

return Library
