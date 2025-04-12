local SpectacularUI = {}

-- Servicios de Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Definición de tipos y propiedades base (inspirado en Material)
local Types = {
    "RoundFrame", "Shadow", "Circle", "CircleButton", "Frame", "Label", "Button",
    "SmoothButton", "Box", "ScrollingFrame", "Menu", "NavBar"
}

local ActualTypes = {
    RoundFrame = "ImageLabel", Shadow = "ImageLabel", Circle = "ImageLabel",
    CircleButton = "ImageButton", Frame = "Frame", Label = "TextLabel",
    Button = "TextButton", SmoothButton = "ImageButton", Box = "TextBox",
    ScrollingFrame = "ScrollingFrame", Menu = "ImageButton", NavBar = "ImageButton"
}

local Properties = {
    RoundFrame = {
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554237731",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3, 3, 297, 297)
    },
    SmoothButton = {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554237731",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3, 3, 297, 297)
    },
    Shadow = {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554236805",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
        Position = UDim2.fromOffset(-15, -15)
    },
    Circle = {
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554831670"
    },
    CircleButton = {
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Image = "http://www.roblox.com/asset/?id=5554831670"
    },
    Frame = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1)
    },
    Label = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    Button = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    Box = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    ScrollingFrame = {
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(1, 1)
    },
    Menu = {
        Name = "More",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5555108481",
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(25, 10)
    },
    NavBar = {
        Name = "SheetToggle",
        Image = "http://www.roblox.com/asset/?id=5576439039",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.fromOffset(5, 5),
        AutoButtonColor = false
    }
}

function FindType(String)
    for _, Type in next, Types do
        if Type:sub(1, #String):lower() == String:lower() then
            return Type
        end
    end
    return false
end

local Objects = {}
function Objects.new(Type)
    local TargetType = FindType(Type)
    if TargetType then
        local NewImage = Instance.new(ActualTypes[TargetType])
        if Properties[TargetType] then
            for Property, Value in next, Properties[TargetType] do
                NewImage[Property] = Value
            end
        end
        return NewImage
    else
        return Instance.new(Type)
    end
end

-- Temas avanzados (inspirado en Material)
local Themes = {
    Default = {
        MainFrame = Color3.fromRGB(30, 30, 30),
        Minimise = Color3.fromRGB(255, 85, 85),
        MinimiseAccent = Color3.fromRGB(200, 50, 50),
        Maximise = Color3.fromRGB(0, 255, 150),
        MaximiseAccent = Color3.fromRGB(0, 200, 120),
        NavBar = Color3.fromRGB(50, 50, 50),
        NavBarAccent = Color3.fromRGB(255, 255, 255),
        NavBarInvert = Color3.fromRGB(220, 220, 220),
        TitleBar = Color3.fromRGB(50, 50, 50),
        TitleBarAccent = Color3.fromRGB(255, 255, 255),
        Overlay = Color3.fromRGB(50, 50, 50),
        Banner = Color3.fromRGB(30, 30, 30),
        BannerAccent = Color3.fromRGB(255, 255, 255),
        Content = Color3.fromRGB(40, 40, 40),
        Button = Color3.fromRGB(50, 50, 50),
        ButtonAccent = Color3.fromRGB(255, 255, 255),
        ChipSet = Color3.fromRGB(220, 220, 220),
        ChipSetAccent = Color3.fromRGB(50, 50, 50),
        DataTable = Color3.fromRGB(220, 220, 220),
        DataTableAccent = Color3.fromRGB(50, 50, 50),
        Slider = Color3.fromRGB(40, 40, 40),
        SliderAccent = Color3.fromRGB(255, 85, 85),
        Toggle = Color3.fromRGB(50, 50, 50),
        ToggleAccent = Color3.fromRGB(255, 255, 255),
        Dropdown = Color3.fromRGB(40, 40, 40),
        DropdownAccent = Color3.fromRGB(255, 255, 255),
        ColorPicker = Color3.fromRGB(40, 40, 40),
        ColorPickerAccent = Color3.fromRGB(255, 255, 255),
        TextField = Color3.fromRGB(50, 50, 50),
        TextFieldAccent = Color3.fromRGB(255, 255, 255),
    },
    Aqua = {
        MainFrame = Color3.fromRGB(20, 30, 40),
        Minimise = Color3.fromRGB(0, 200, 255),
        MinimiseAccent = Color3.fromRGB(0, 150, 200),
        Maximise = Color3.fromRGB(0, 255, 200),
        MaximiseAccent = Color3.fromRGB(0, 200, 150),
        NavBar = Color3.fromRGB(40, 60, 80),
        NavBarAccent = Color3.fromRGB(220, 240, 255),
        NavBarInvert = Color3.fromRGB(200, 220, 240),
        TitleBar = Color3.fromRGB(40, 60, 80),
        TitleBarAccent = Color3.fromRGB(220, 240, 255),
        Overlay = Color3.fromRGB(40, 60, 80),
        Banner = Color3.fromRGB(20, 30, 40),
        BannerAccent = Color3.fromRGB(220, 240, 255),
        Content = Color3.fromRGB(30, 40, 50),
        Button = Color3.fromRGB(40, 60, 80),
        ButtonAccent = Color3.fromRGB(220, 240, 255),
        ChipSet = Color3.fromRGB(200, 220, 240),
        ChipSetAccent = Color3.fromRGB(40, 60, 80),
        DataTable = Color3.fromRGB(200, 220, 240),
        DataTableAccent = Color3.fromRGB(40, 60, 80),
        Slider = Color3.fromRGB(30, 40, 50),
        SliderAccent = Color3.fromRGB(0, 200, 255),
        Toggle = Color3.fromRGB(40, 60, 80),
        ToggleAccent = Color3.fromRGB(220, 240, 255),
        Dropdown = Color3.fromRGB(30, 40, 50),
        DropdownAccent = Color3.fromRGB(220, 240, 255),
        ColorPicker = Color3.fromRGB(30, 40, 50),
        ColorPickerAccent = Color3.fromRGB(220, 240, 255),
        TextField = Color3.fromRGB(40, 60, 80),
        TextFieldAccent = Color3.fromRGB(220, 240, 255),
    }
}

local ThisTheme
local Styles = { [1] = "Normal", [2] = "Invert", [3] = "Sheets" }
local MainGUI

-- Funciones auxiliares
local function GetXY(GuiObject)
    local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
    local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
    return Px / Max, Py / May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
    local PX, PY = GetXY(GuiObject)
    local Circle = Objects.new("Circle")
    Circle.Size = UDim2.fromScale(0, 0)
    Circle.Position = UDim2.fromScale(PX, PY)
    Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
    Circle.ZIndex = 200
    Circle.Parent = GuiObject
    local Size = GuiObject.AbsoluteSize.X
    TweenService:Create(Circle, TweenInfo.new(1), {
        Position = UDim2.fromScale(PX, PY) - UDim2.fromOffset(Size / 2, Size / 2),
        ImageTransparency = 1,
        ImageColor3 = EndColour,
        Size = UDim2.fromOffset(Size, Size)
    }):Play()
    spawn(function()
        wait(2)
        Circle:Destroy()
    end)
end

local function TryAddMenu(Object, Menu, ReturnTable)
    local Total = 0
    for _, Value in pairs(Menu) do
        if typeof(Value) == "function" then
            Total = Total + 1
        end
    end

    if Total > 0 then
        local MenuToggle = false
        local MenuButton = Objects.new("Menu")
        MenuButton.ImageTransparency = 1
        MenuButton.Parent = Object
        TweenService:Create(MenuButton, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

        local Size = Total * 30 + ((Total + 1) * 2)
        local MenuBuild = Objects.new("RoundFrame")
        MenuBuild.Name = "Menu"
        MenuBuild.ImageColor3 = ThisTheme.ButtonAccent
        MenuBuild.Size = UDim2.fromOffset(120, 0)
        MenuBuild.Position = UDim2.fromOffset(MenuButton.AbsolutePosition.X, MenuButton.AbsolutePosition.Y) - UDim2.fromOffset(125, 5)
        MenuBuild.ZIndex = 100
        MenuBuild.ClipsDescendants = true
        MenuBuild.Parent = MainGUI

        MenuButton:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            MenuBuild.Position = UDim2.fromOffset(MenuButton.AbsolutePosition.X, MenuButton.AbsolutePosition.Y) - UDim2.fromOffset(125, 5)
        end)

        local MenuContent = Objects.new("Frame")
        MenuContent.Name = "Content"
        MenuContent.Parent = MenuBuild

        local MenuList = Objects.new("UIListLayout")
        MenuList.Padding = UDim.new(0, 2)
        MenuList.Parent = MenuContent

        local MenuPadding = Objects.new("UIPadding")
        MenuPadding.PaddingTop = UDim.new(0, 2)
        MenuPadding.PaddingRight = UDim.new(0, 2)
        MenuPadding.PaddingLeft = UDim.new(0, 2)
        MenuPadding.PaddingBottom = UDim.new(0, 2)
        MenuPadding.Parent = MenuContent

        MenuButton.MouseButton1Down:Connect(function()
            MenuToggle = not MenuToggle
            TweenService:Create(MenuBuild, TweenInfo.new(0.15), {Size = MenuToggle and UDim2.fromOffset(120, Size) or UDim2.fromOffset(120, 0)}):Play()
        end)

        for Option, Value in pairs(Menu) do
            if typeof(Value) == "function" then
                local MenuOption = Objects.new("SmoothButton")
                MenuOption.Name = "MenuOption"
                MenuOption.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
                MenuOption.ImageColor3 = ThisTheme.Button
                MenuOption.ImageTransparency = 1
                MenuOption.ZIndex = 150
                MenuOption.Parent = MenuContent

                local OptionShadow = Objects.new("Shadow")
                OptionShadow.ImageColor3 = ThisTheme.Button
                OptionShadow.ImageTransparency = 1
                OptionShadow.Parent = MenuOption

                local OptionValue = Objects.new("Label")
                OptionValue.Name = "Value"
                OptionValue.Position = UDim2.fromScale(0, 0)
                OptionValue.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0)
                OptionValue.Text = Option
                OptionValue.TextColor3 = ThisTheme.Button
                OptionValue.Font = Enum.Font.Gotham
                OptionValue.TextSize = 12
                OptionValue.ZIndex = 150
                OptionValue.TextXAlignment = Enum.TextXAlignment.Right
                OptionValue.Parent = MenuOption

                MenuOption.MouseButton1Down:Connect(function()
                    Value(ReturnTable)
                    MenuToggle = false
                    TweenService:Create(MenuBuild, TweenInfo.new(0.15), {Size = UDim2.fromOffset(120, 0)}):Play()
                end)

                MenuOption.MouseEnter:Connect(function()
                    TweenService:Create(MenuOption, TweenInfo.new(0.15), {ImageTransparency = 0.8}):Play()
                    TweenService:Create(OptionShadow, TweenInfo.new(0.15), {ImageTransparency = 0.8}):Play()
                end)

                MenuOption.MouseLeave:Connect(function()
                    TweenService:Create(MenuOption, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
                    TweenService:Create(OptionShadow, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
                end)
            end
        end
        return true, MenuButton
    end
    return false
end

-- Estilos de navegación (inspirado en Material)
local NavBar = {
    Normal = function()
        local NewNavBar = Objects.new("RoundFrame")
        NewNavBar.Name = "NavBar"
        NewNavBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 30)
        NewNavBar.Position = UDim2.fromOffset(5, 35)
        NewNavBar.ImageColor3 = ThisTheme.NavBar
        NewNavBar.ZIndex = 100

        local NavBarShadow = Objects.new("Shadow")
        NavBarShadow.ImageColor3 = ThisTheme.NavBar
        NavBarShadow.Parent = NewNavBar
        NavBarShadow.ZIndex = 100

        local NavBarContent = Objects.new("Frame")
        NavBarContent.Name = "Content"
        NavBarContent.Parent = NewNavBar

        NavBarContent.ChildAdded:Connect(function(Child)
            pcall(function()
                local Children = #NavBarContent:GetChildren() - 2
                TweenService:Create(Child, TweenInfo.new(1), {TextTransparency = (Children > 1) and 0.5 or 0}):Play()
            end)
            pcall(function()
                Child.TextColor3 = ThisTheme.NavBarAccent
            end)
        end)

        local NavBarList = Objects.new("UIListLayout")
        NavBarList.FillDirection = Enum.FillDirection.Horizontal
        NavBarList.HorizontalAlignment = Enum.HorizontalAlignment.Left
        NavBarList.VerticalAlignment = Enum.VerticalAlignment.Center
        NavBarList.SortOrder = Enum.SortOrder.LayoutOrder
        NavBarList.Parent = NavBarContent

        local NavBarPadding = Objects.new("UIPadding")
        NavBarPadding.PaddingLeft = UDim.new(0, 5)
        NavBarPadding.Parent = NavBarContent

        return NewNavBar, NavBarContent
    end,
    Invert = function()
        local NewNavBar = Objects.new("RoundFrame")
        NewNavBar.Name = "NavBar"
        NewNavBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 30)
        NewNavBar.Position = UDim2.fromOffset(5, 35)
        NewNavBar.ImageColor3 = ThisTheme.NavBarAccent
        NewNavBar.ImageTransparency = 1
        NewNavBar.ZIndex = 100

        local NavBarShadow = Objects.new("Shadow")
        NavBarShadow.ImageColor3 = ThisTheme.NavBarInvert
        NavBarShadow.ImageTransparency = 1
        NavBarShadow.Parent = NewNavBar
        NavBarShadow.ZIndex = 100

        TweenService:Create(NewNavBar, TweenInfo.new(1), {ImageTransparency = 0}):Play()
        TweenService:Create(NavBarShadow, TweenInfo.new(1), {ImageTransparency = 0}):Play()

        local NavBarContent = Objects.new("Frame")
        NavBarContent.Name = "Content"
        NavBarContent.Parent = NewNavBar

        NavBarContent.ChildAdded:Connect(function(Child)
            pcall(function()
                local Children = #NavBarContent:GetChildren() - 2
                TweenService:Create(Child, TweenInfo.new(1), {TextTransparency = (Children > 1) and 0.5 or 0}):Play()
            end)
            pcall(function()
                Child.TextColor3 = ThisTheme.NavBar
            end)
        end)

        local NavBarList = Objects.new("UIListLayout")
        NavBarList.FillDirection = Enum.FillDirection.Horizontal
        NavBarList.HorizontalAlignment = Enum.HorizontalAlignment.Left
        NavBarList.VerticalAlignment = Enum.VerticalAlignment.Center
        NavBarList.SortOrder = Enum.SortOrder.LayoutOrder
        NavBarList.Parent = NavBarContent

        local NavBarPadding = Objects.new("UIPadding")
        NavBarPadding.PaddingLeft = UDim.new(0, 5)
        NavBarPadding.Parent = NavBarContent

        return NewNavBar, NavBarContent
    end,
    Sheets = function()
        local NewNavBar = Objects.new("RoundFrame")
        NewNavBar.ClipsDescendants = true
        NewNavBar.Name = "NavBar"
        NewNavBar.Size = UDim2.fromScale(0, 1) - UDim2.fromOffset(0, 30)
        NewNavBar.Position = UDim2.fromOffset(0, 30)
        NewNavBar.ImageColor3 = ThisTheme.NavBarAccent
        NewNavBar.ZIndex = 100

        local NavBarOverlay = Objects.new("Frame")
        NavBarOverlay.Name = "Overlay"
        NavBarOverlay.BackgroundColor3 = ThisTheme.NavBar
        NavBarOverlay.BackgroundTransparency = 1
        NavBarOverlay.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(0, 30)
        NavBarOverlay.Position = UDim2.fromOffset(0, 30)
        NavBarOverlay.ZIndex = 75

        local NavBarMenu = Objects.new("NavBar")
        NavBarMenu.ZIndex = 100

        local NavBarShadow = Objects.new("Shadow")
        NavBarShadow.ImageColor3 = ThisTheme.NavBar
        NavBarShadow.Parent = NewNavBar
        NavBarShadow.ZIndex = 100

        local Effect1, Effect2, Effect3 = Objects.new("Frame"), Objects.new("Frame"), Objects.new("Frame")
        Effect1.ZIndex = 100
        Effect2.ZIndex = 100
        Effect3.ZIndex = 100
        Effect1.BackgroundTransparency = 0
        Effect2.BackgroundTransparency = 0
        Effect3.BackgroundTransparency = 0
        Effect1.BackgroundColor3 = ThisTheme.NavBarAccent
        Effect2.BackgroundColor3 = ThisTheme.NavBarAccent
        Effect3.BackgroundColor3 = ThisTheme.NavBar
        Effect1.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 5)
        Effect2.Size = UDim2.fromScale(0, 1) + UDim2.fromOffset(5, 0)
        Effect3.Size = UDim2.fromScale(0, 1) + UDim2.fromOffset(1, 0)
        Effect1.Position = UDim2.fromScale(0, 0)
        Effect2.Position = UDim2.fromScale(1, 0) - UDim2.fromOffset(5, 0)
        Effect3.Position = UDim2.fromScale(1, 0)
        Effect1.Parent = NewNavBar
        Effect2.Parent = NewNavBar
        Effect3.Parent = NewNavBar

        local NavBarContent = Objects.new("Frame")
        NavBarContent.Name = "Content"
        NavBarContent.Parent = NewNavBar

        local NavBarList = Objects.new("UIListLayout")
        NavBarList.FillDirection = Enum.FillDirection.Vertical
        NavBarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        NavBarList.VerticalAlignment = Enum.VerticalAlignment.Top
        NavBarList.SortOrder = Enum.SortOrder.LayoutOrder
        NavBarList.Parent = NavBarContent

        local NavBarPadding = Objects.new("UIPadding")
        NavBarPadding.PaddingLeft = UDim.new(0, 5)
        NavBarPadding.PaddingRight = UDim.new(0, 5)
        NavBarPadding.PaddingTop = UDim.new(0, 5)
        NavBarPadding.PaddingBottom = UDim.new(0, 5)
        NavBarPadding.Parent = NavBarContent

        NavBarContent.ChildAdded:Connect(function(Child)
            pcall(function()
                local Children = #NavBarContent:GetChildren() - 2
                TweenService:Create(Child, TweenInfo.new(1), {TextTransparency = (Children > 1) and 0.5 or 0}):Play()
            end)
            pcall(function()
                Child.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            end)
            pcall(function()
                Child.TextColor3 = ThisTheme.NavBar
            end)
        end)

        return NewNavBar, NavBarContent, NavBarMenu, NavBarOverlay
    end
}

-- Función para crear un botón (inspirado en Material)
local function CreateNewButton(ButtonConfig, Parent)
    local ButtonText = ButtonConfig.Text or "nil button"
    local ButtonCallback = ButtonConfig.Callback or function() print("nil button") end
    local Menu = ButtonConfig.Menu or {}

    local Button = Objects.new("SmoothButton")
    Button.Name = "Button"
    Button.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
    Button.ImageColor3 = ThisTheme.Button
    Button.ImageTransparency = 1
    Button.Parent = Parent

    local ButtonShadow = Objects.new("Shadow")
    ButtonShadow.ImageColor3 = ThisTheme.Button
    ButtonShadow.ImageTransparency = 1
    ButtonShadow.Parent = Button

    local ButtonLabel = Objects.new("Label")
    ButtonLabel.Text = ButtonText
    ButtonLabel.TextColor3 = ThisTheme.ButtonAccent
    ButtonLabel.Font = Enum.Font.GothamSemibold
    ButtonLabel.TextSize = 14
    ButtonLabel.ClipsDescendants = true
    ButtonLabel.TextTransparency = 1
    ButtonLabel.Parent = Button

    TweenService:Create(Button, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
    TweenService:Create(ButtonShadow, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
    TweenService:Create(ButtonLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    Button.MouseButton1Down:Connect(function()
        CircleAnim(ButtonLabel, ThisTheme.ButtonAccent, ThisTheme.Button)
        ButtonCallback()
    end)

    local MenuAdded = TryAddMenu(Button, Menu, {})

    return Button, ButtonLabel
end

-- Función principal para crear una ventana
function SpectacularUI:CreateWindow(Config)
    local Style = (Config.Style and math.clamp(Config.Style, 1, 3)) or 1
    local Title = Config.Title or "SpectacularUI"
    local SizeX = Config.SizeX or 300
    local SizeY = Config.SizeY or 500
    local Theme = Config.Theme or "Default"
    local Overrides = Config.ColorOverrides or {}
    local Open = true

    Theme = Themes[Theme] or Themes.Default
    ThisTheme = Theme

    for KeyOverride, ValueOverride in next, Overrides do
        ThisTheme[KeyOverride] = ValueOverride
    end

    pcall(function() OldInstance:Destroy() end)

    local function GetExploit()
        local Table = {}
        Table.Synapse = syn
        Table.ProtoSmasher = pebc_create
        Table.Sentinel = issentinelclosure
        Table.ScriptWare = getexecutorname

        for ExploitName, ExploitFunction in next, Table do
            if ExploitFunction then
                return ExploitName
            end
        end
        return "Undefined"
    end

    local ProtectFunctions = {
        Synapse = function(GuiObject) syn.protect_gui(GuiObject); GuiObject.Parent = CoreGuiService end,
        ProtoSmasher = function(GuiObject) GuiObject.Parent = get_hidden_gui() end,
        Sentinel = function(GuiObject) GuiObject.Parent = CoreGuiService end,
        ScriptWare = function(GuiObject) GuiObject.Parent = gethui() end,
        Undefined = function(GuiObject) GuiObject.Parent = CoreGuiService end
    }

    local NewInstance = Objects.new("ScreenGui")
    NewInstance.Name = Title
    ProtectFunctions[GetExploit()](NewInstance)

    getgenv().OldInstance = NewInstance
    MainGUI = NewInstance

    local MainFrame = Objects.new("RoundFrame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.fromOffset(0, SizeY)
    MainFrame.Position = UDim2.fromScale(0.5, 0.5) - UDim2.fromOffset(SizeX / 2, SizeY / 2)
    MainFrame.ImageColor3 = Theme.MainFrame
    MainFrame.Parent = NewInstance

    TweenService:Create(MainFrame, TweenInfo.new(1), {Size = UDim2.fromOffset(SizeX, SizeY)}):Play()

    wait(1)

    local MainShadow = Objects.new("Shadow")
    MainShadow.ImageColor3 = Theme.MainFrame
    MainShadow.Parent = MainFrame

    local TitleBar = Objects.new("SmoothButton")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
    TitleBar.ImageColor3 = Theme.TitleBar
    TitleBar.ImageTransparency = 1
    TitleBar.Parent = MainFrame

    local ExtraBar = Objects.new("Frame")
    ExtraBar.Name = "Hidden"
    ExtraBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 5)
    ExtraBar.Position = UDim2.fromScale(0, 1) - UDim2.fromOffset(0, 5)
    ExtraBar.BackgroundColor3 = Theme.TitleBar
    ExtraBar.Parent = TitleBar

    local TitleShadow = Objects.new("Shadow")
    TitleShadow.ImageColor3 = Theme.TitleBar
    TitleShadow.ImageTransparency = 1
    TitleShadow.Parent = TitleBar

    local TitleText = Objects.new("Button")
    TitleText.Name = "Title"
    TitleText.Text = Title
    TitleText.TextColor3 = Theme.TitleBarAccent
    TitleText.TextTransparency = 1
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Parent = TitleBar

    TitleText.MouseButton1Down:Connect(function()
        local Mx, My = Mouse.X, Mouse.Y
        local MouseMove, MouseKill
        MouseMove = Mouse.Move:Connect(function()
            local nMx, nMy = Mouse.X, Mouse.Y
            local Dx, Dy = nMx - Mx, nMy - My
            MainFrame.Position = MainFrame.Position + UDim2.fromOffset(Dx, Dy)
            Mx, My = nMx, nMy
        end)
        MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
            if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                MouseMove:Disconnect()
                MouseKill:Disconnect()
            end
        end)
    end)

    local MinimiseButton = Objects.new("SmoothButton")
    MinimiseButton.Size = UDim2.fromOffset(20, 20)
    MinimiseButton.Position = UDim2.fromScale(1, 0) + UDim2.fromOffset(-25, 5)
    MinimiseButton.ImageColor3 = Theme.Minimise
    MinimiseButton.ImageTransparency = 1
    MinimiseButton.Parent = TitleBar

    local MinimiseShadow = Objects.new("Shadow")
    MinimiseShadow.ImageColor3 = Theme.MinimiseAccent
    MinimiseShadow.ImageTransparency = 1
    MinimiseShadow.Parent = MinimiseButton

    MinimiseButton.MouseButton1Down:Connect(function()
        Open = not Open
        TweenService:Create(MainShadow, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.15), {Size = Open and UDim2.fromOffset(SizeX, SizeY) or UDim2.fromOffset(SizeX, 30)}):Play()
        TweenService:Create(MinimiseButton, TweenInfo.new(0.15), {ImageColor3 = Open and Theme.Minimise or Theme.Maximise}):Play()
        TweenService:Create(MinimiseShadow, TweenInfo.new(0.15), {ImageColor3 = Open and Theme.MinimiseAccent or Theme.MaximiseAccent}):Play()
        if Open then
            wait(0.15)
            MainFrame.ClipsDescendants = false
            TweenService:Create(MainShadow, TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
        else
            MainFrame.ClipsDescendants = true
        end
    end)

    local Content = Objects.new("RoundFrame")
    Content.Name = "Content"
    Content.ImageColor3 = Theme.Content
    Content.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(10, 75)
    Content.Position = UDim2.fromOffset(5, 70)
    Content.ImageTransparency = 1
    Content.Parent = MainFrame

    local NavigationBar, NavigationBarContent, NavBarMenu, NavBarOverlay = NavBar[Styles[Style]]()
    NavigationBar.Parent = MainFrame

    TweenService:Create(TitleBar, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(ExtraBar, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()
    TweenService:Create(TitleShadow, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(TitleText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    TweenService:Create(MinimiseButton, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(MinimiseShadow, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(Content, TweenInfo.new(1), {ImageTransparency = 0.8}):Play()

    wait(1)

    if NavBarMenu then
        TweenService:Create(TitleText, TweenInfo.new(0.5), {
            Size = TitleText.Size - UDim2.fromOffset(25, 0),
            Position = TitleText.Position + UDim2.fromOffset(25, 0)
        }):Play()
        TweenService:Create(Content, TweenInfo.new(0.5), {
            Size = Content.Size + UDim2.fromOffset(0, 35),
            Position = Content.Position - UDim2.fromOffset(0, 35)
        }):Play()

        NavBarMenu.ImageTransparency = 1
        NavBarMenu.Parent = TitleBar

        TweenService:Create(NavBarMenu, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

        NavBarOverlay.Parent = MainFrame

        local MenuToggle = false

        NavBarMenu.MouseButton1Down:Connect(function()
            MenuToggle = not MenuToggle
            TweenService:Create(NavigationBar, TweenInfo.new(0.15), {Size = (MenuToggle and UDim2.fromScale(0.5, 1) or UDim2.fromScale(0, 1)) - UDim2.fromOffset(0, 30)}):Play()
            TweenService:Create(NavBarOverlay, TweenInfo.new(0.15), {BackgroundTransparency = MenuToggle and 0.5 or 1}):Play()
            if MenuToggle then
                wait(0.15)
                NavigationBar.ClipsDescendants = false
            else
                NavigationBar.ClipsDescendants = true
            end
        end)
    end

    local TabCount = 0
    local TabLibrary = {}
    local ButtonTrack = {}
    local PageTrack = {}

    function TabLibrary:Banner(BannerConfig)
        local BannerText = BannerConfig.Text
        local BannerOptions = BannerConfig.Options or {}

        local ExistingBanner, ExistingBannerOverlay = MainFrame:FindFirstChild("BannerOverlay"), MainFrame:FindFirstChild("Banner")

        if ExistingBanner then
            ExistingBanner:Destroy()
        end

        if ExistingBannerOverlay then
            ExistingBannerOverlay:Destroy()
        end

        local BannerOverlay = Objects.new("Frame")
        BannerOverlay.Name = "BannerOverlay"
        BannerOverlay.BackgroundColor3 = ThisTheme.BannerAccent
        BannerOverlay.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(0, 30)
        BannerOverlay.Position = UDim2.fromOffset(0, 30)
        BannerOverlay.ZIndex = 75
        BannerOverlay.Parent = MainFrame

        local TextSize = TextService:GetTextSize(BannerText, 12, Enum.Font.Gotham, Vector2.new(0, 0)).X
        local Lines = math.ceil((TextSize) / (MainFrame.AbsoluteSize.X - 10))

        local BannerSize = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, (Lines * 20) + 40)
        local BannerPosition = UDim2.fromScale(0, 1) + UDim2.fromOffset(5, (-Lines * 20) - 45)

        local Banner = Objects.new("RoundFrame")
        Banner.Name = "Banner"
        Banner.ImageTransparency = 1
        Banner.ImageColor3 = ThisTheme.Banner
        Banner.Size = BannerSize
        Banner.Position = BannerPosition
        Banner.ZIndex = 80
        Banner.Parent = MainFrame

        local BannerLabel = Objects.new("Label")
        BannerLabel.Name = "Value"
        BannerLabel.Text = BannerText
        BannerLabel.TextColor3 = ThisTheme.BannerAccent
        BannerLabel.TextSize = 12
        BannerLabel.Font = Enum.Font.Gotham
        BannerLabel.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-5, (Lines * 20) + 5)
        BannerLabel.TextWrapped = true
        BannerLabel.Position = UDim2.fromOffset(5, 0)
        BannerLabel.TextTransparency = 1
        BannerLabel.ZIndex = 80
        BannerLabel.Parent = Banner

        TweenService:Create(BannerOverlay, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(Banner, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
        TweenService:Create(BannerLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

        local BannerContainer = Objects.new("Frame")
        BannerContainer.Name = "Options"
        BannerContainer.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 0)
        BannerContainer.Position = UDim2.fromScale(0, 1) - UDim2.fromOffset(-5, 35)
        BannerContainer.ZIndex = 80
        BannerContainer.ClipsDescendants = true
        BannerContainer.Parent = Banner

        local BannerList = Objects.new("UIListLayout")
        BannerList.FillDirection = Enum.FillDirection.Horizontal
        BannerList.HorizontalAlignment = Enum.HorizontalAlignment.Right
        BannerList.SortOrder = Enum.SortOrder.LayoutOrder
        BannerList.Padding = UDim.new(0, 5)
        BannerList.Parent = BannerContainer

        BannerOptions["Ok"] = function()
            TweenService:Create(BannerContainer, TweenInfo.new(0.5), {Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 0)}):Play()
            TweenService:Create(BannerOverlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Banner, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
            TweenService:Create(BannerLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        end

        table.foreach(BannerOptions, function(Option, Value)
            if typeof(Value) == "function" then
                local TextSize = TextService:GetTextSize(Option:upper(), 12, Enum.Font.GothamBold, Vector2.new(0, 0)).X

                local OptionItem = Objects.new("SmoothButton")
                OptionItem.ImageColor3 = ThisTheme.BannerAccent
                OptionItem.ImageTransparency = 0.9
                OptionItem.Size = UDim2.fromOffset(TextSize + 10, 30)
                OptionItem.ZIndex = 80
                OptionItem.ClipsDescendants = true
                OptionItem.Parent = BannerContainer

                local OptionLabel = Objects.new("Label")
                OptionLabel.Text = Option:upper()
                OptionLabel.TextSize = 12
                OptionLabel.TextColor3 = ThisTheme.BannerAccent
                OptionLabel.Font = Enum.Font.GothamBold
                OptionLabel.Size = UDim2.fromScale(1, 1)
                OptionLabel.Position = UDim2.fromScale(0, 0)
                OptionLabel.TextXAlignment = Enum.TextXAlignment.Center
                OptionLabel.ZIndex = 80
                OptionLabel.Parent = OptionItem

                OptionItem.MouseButton1Down:Connect(function()
                    Value()
                    CircleAnim(OptionItem, ThisTheme.Banner)
                end)
            end
        end)

        TweenService:Create(BannerContainer, TweenInfo.new(0.5), {Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 30)}):Play()
    end

    function TabLibrary:New(TabConfig)
        local ImageID = TabConfig.ID
        local Title = TabConfig.Title

        local Button

        if ImageID then
            if Title then
                local Settings = {
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    Vector = Vector2.new(0, 0)
                }

                local TextSize = TextService:GetTextSize(Title:upper(), Settings.TextSize, Settings.Font, Settings.Vector).X

                Button = Objects.new("Button")
                Button.Name = Title:upper()
                Button.TextXAlignment = Enum.TextXAlignment.Right
                Button.TextSize = Settings.TextSize
                Button.Font = Settings.Font
                Button.Text = Title:upper()
                Button.Size = UDim2.fromScale(0, 1) + UDim2.fromOffset(TextSize + 35)
                Button.ZIndex = 200
                Button.TextTransparency = 1
            end

            local FetchURL = "rbxassetid://" .. ImageID
            local Image = RunService:IsStudio() and "http://www.roblox.com/asset/?id=5472131383" or game:GetObjects(FetchURL)[1].Texture

            local NewImage = Objects.new(Button and "RoundFrame" or "SmoothButton")
            NewImage.Name = ImageID
            NewImage.BackgroundTransparency = 1
            NewImage.Size = UDim2.fromOffset(20, 20)
            NewImage.ScaleType = Enum.ScaleType.Stretch
            NewImage.Image = Image
            NewImage.ZIndex = 200
            NewImage.ImageTransparency = 1

            if Button then
                NewImage.Position = UDim2.fromScale(0, 0.5) - UDim2.fromOffset(0, 10)
                NewImage.Parent = Button
            else
                Button = NewImage
            end
        else
            local Settings = {
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                Vector = Vector2.new(0, 0)
            }

            local TextSize = TextService:GetTextSize(Title:upper(), Settings.TextSize, Settings.Font, Settings.Vector).X

            Button = Objects.new("Button")
            Button.Name = Title:upper()
            Button.TextXAlignment = Enum.TextXAlignment.Center
            Button.TextSize = Settings.TextSize
            Button.Font = Settings.Font
            Button.Text = Title:upper()
            Button.Size = UDim2.fromScale(0, 1) + UDim2.fromOffset(TextSize + 10)
            Button.ZIndex = 200
            Button.TextTransparency = 1
        end

        Button.Parent = NavigationBarContent

        local PageContentFrame = Objects.new("ScrollingFrame")
        PageContentFrame.Name = Title:upper() or ImageID
        PageContentFrame.Visible = (TabCount == 0)
        PageContentFrame.ZIndex = 50
        PageContentFrame.Parent = Content

        table.insert(ButtonTrack, Button)
        table.insert(PageTrack, PageContentFrame)

        Button.MouseButton1Down:Connect(function()
            for _, Track in next, ButtonTrack do
                if not (Track == Button) then
                    TweenService:Create(Track, TweenInfo.new(0.15), {TextTransparency = 0.5}):Play()
                    pcall(function()
                        TweenService:Create(Track:FindFirstChildWhichIsA("ImageLabel"), TweenInfo.new(0.15), {ImageTransparency = 0.5}):Play()
                    end)
                else
                    TweenService:Create(Track, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
                    pcall(function()
                        TweenService:Create(Track:FindFirstChildWhichIsA("ImageLabel"), TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
                    end)
                end
            end
            for _, Track in next, PageTrack do
                Track.Visible = (Track == PageContentFrame)
            end
        end)

        local PagePadding = Objects.new("UIPadding")
        PagePadding.PaddingLeft = UDim.new(0, 5)
        PagePadding.PaddingRight = UDim.new(0, 5)
        PagePadding.PaddingTop = UDim.new(0, 5)
        PagePadding.PaddingBottom = UDim.new(0, 5)
        PagePadding.Parent = PageContentFrame

        local PageList = Objects.new("UIListLayout")
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 5)
        PageList.Parent = PageContentFrame

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            PageContentFrame.CanvasSize = UDim2.fromOffset(0, PageList.AbsoluteContentSize.Y + 10)
        end)

        TabCount = TabCount + 1

        local OptionLibrary = {}

        function OptionLibrary:Button(ButtonConfig)
            local NewButton, ButtonLabel = CreateNewButton(ButtonConfig, PageContentFrame)

            local ButtonLibrary = {}
            function ButtonLibrary:SetText(Value)
                ButtonLabel.Text = Value
            end
            function ButtonLibrary:GetText()
                return ButtonLabel.Text
            end
            return ButtonLibrary
        end

        function OptionLibrary:Dropdown(DropdownConfig)
            local DropdownText = DropdownConfig.Text or "nil dropdown"
            local DropdownValue = DropdownConfig.Default
            local DropdownCallback = DropdownConfig.Callback or function() print("nil dropdown") end
            local DropdownOptions = DropdownConfig.Options or {}
            local Menu = DropdownConfig.Menu or {}

            local Dropdown = Objects.new("Frame")
            Dropdown.Name = "Dropdown"
            Dropdown.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            Dropdown.Parent = PageContentFrame

            local DropdownBar = Objects.new("RoundFrame")
            DropdownBar.Name = "TitleBar"
            DropdownBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            DropdownBar.ImageColor3 = ThisTheme.Dropdown
            DropdownBar.ImageTransparency = 1
            DropdownBar.Parent = Dropdown

            local DropdownTitle = Objects.new("Button")
            DropdownTitle.Name = "Title"
            DropdownTitle.Font = Enum.Font.GothamSemibold
            DropdownTitle.Text = DropdownValue and DropdownText .. ": " .. DropdownValue or DropdownText
            DropdownTitle.TextColor3 = ThisTheme.DropdownAccent
            DropdownTitle.TextTransparency = 1
            DropdownTitle.TextSize = 14
            DropdownTitle.Parent = DropdownBar

            local DropdownToggle = Objects.new("RoundFrame")
            DropdownToggle.Name = "Container"
            DropdownToggle.Size = UDim2.fromOffset(24, 24)
            DropdownToggle.Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(27, 12)
            DropdownToggle.ImageColor3 = ThisTheme.DropdownAccent
            DropdownToggle.ImageTransparency = 1
            DropdownToggle.Parent = DropdownBar

            local DropdownButton = Objects.new("RoundFrame")
            DropdownButton.Name = "Drop"
            DropdownButton.Image = "http://www.roblox.com/asset/?id=5574299686"
            DropdownButton.ScaleType = Enum.ScaleType.Stretch
            DropdownButton.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(4, 4)
            DropdownButton.Position = UDim2.fromOffset(2, 2)
            DropdownButton.ImageColor3 = ThisTheme.DropdownAccent
            DropdownButton.ImageTransparency = 1
            DropdownButton.Parent = DropdownToggle

            TweenService:Create(DropdownBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(DropdownTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(DropdownToggle, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()
            TweenService:Create(DropdownButton, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            local DropdownContent = Objects.new("Frame")
            DropdownContent.Name = "Content"
            DropdownContent.Size = UDim2.fromScale(1, 0)
            DropdownContent.Position = UDim2.fromOffset(0, 35)
            DropdownContent.ClipsDescendants = true
            DropdownContent.Parent = Dropdown

            local NumberOfOptions = #DropdownOptions
            local DropToggle = false
            local DropdownSize = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (NumberOfOptions * 20) + ((NumberOfOptions - 1) * 5))

            local DropdownList = Objects.new("UIListLayout")
            DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownList.Padding = UDim.new(0, 5)
            DropdownList.Parent = DropdownContent

            DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if DropToggle then
                    DropdownContent.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(DropdownList.AbsoluteContentSize.Y)
                    DropdownSize = UDim2.fromScale(1, 0) + UDim2.fromOffset(DropdownList.AbsoluteContentSize.Y)
                end
            end)

            table.foreach(DropdownOptions, function(_, Value)
                local NewButton = CreateNewButton({
                    Text = Value,
                    Callback = function() end
                }, DropdownContent)

                NewButton.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 20)
                NewButton.MouseButton1Down:Connect(function()
                    DropdownCallback(Value)
                    DropdownTitle.Text = DropdownText .. ": " .. Value
                    DropdownValue = Value
                end)
            end)

            DropdownTitle.MouseButton1Down:Connect(function()
                DropToggle = not DropToggle
                TweenService:Create(DropdownButton, TweenInfo.new(0.15), {Rotation = DropToggle and 135 or 0}):Play()
                TweenService:Create(DropdownContent, TweenInfo.new(0.15), {Size = DropToggle and DropdownSize or UDim2.fromScale(1, 0)}):Play()
                TweenService:Create(Dropdown, TweenInfo.new(0.15), {Size = DropToggle and (DropdownSize + UDim2.fromOffset(0, 35)) or (UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30))}):Play()
            end)

            local MenuAdded, MenuButton = TryAddMenu(DropdownBar, Menu, {})

            if MenuAdded then
                DropdownToggle.Position = DropdownToggle.Position - UDim2.fromOffset(25, 0)
                MenuButton.ImageColor3 = ThisTheme.DropdownAccent
            end

            local DropdownLibrary = {}
            function DropdownLibrary:SetText(Value)
                DropdownTitle.Text = Value
            end
            function DropdownLibrary:GetText()
                return DropdownTitle.Text
            end
            function DropdownLibrary:GetValue()
                return DropdownValue
            end
            function DropdownLibrary:SetOptions(NewMenu)
                DropdownOptions = NewMenu or {}
                NumberOfOptions = #DropdownOptions
                DropdownSize = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (NumberOfOptions * 20) + ((NumberOfOptions - 1) * 5))

                if DropdownContent then
                    DropdownContent:Destroy()
                end

                TweenService:Create(Dropdown, TweenInfo.new(0.15), {Size = DropToggle and (DropdownSize + UDim2.fromOffset(0, 35)) or (UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30))}):Play()

                DropdownContent = Objects.new("Frame")
                DropdownContent.Name = "Content"
                DropdownContent.Size = DropToggle and DropdownSize or UDim2.fromScale(1, 0)
                DropdownContent.Position = UDim2.fromOffset(0, 35)
                DropdownContent.ClipsDescendants = true
                DropdownContent.Parent = Dropdown

                local DropdownList = Objects.new("UIListLayout")
                DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownList.Padding = UDim.new(0, 5)
                DropdownList.Parent = DropdownContent

                table.foreach(DropdownOptions, function(_, Value)
                    local NewButton = CreateNewButton({
                        Text = Value,
                        Callback = function() end
                    }, DropdownContent)

                    NewButton.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 20)
                    NewButton.MouseButton1Down:Connect(function()
                        DropdownCallback(Value)
                        DropdownTitle.Text = DropdownText .. ": " .. Value
                        DropdownValue = Value
                    end)
                end)
            end
            function DropdownLibrary:GetOptions()
                return DropdownOptions
            end

            if DropdownConfig.Default then
                DropdownTitle.Text = DropdownText .. ": " .. DropdownConfig.Default
            end

            return DropdownLibrary
        end

        function OptionLibrary:ChipSet(ChipSetConfig)
            local ChipSetText = ChipSetConfig.Text or "nil chipset"
            local ChipSetCallback = ChipSetConfig.Callback or function() print("nil chipset") end
            local ChipSetOptions = ChipSetConfig.Options or {}

            local TotalOptions = 0
            table.foreach(ChipSetOptions, function()
                TotalOptions = TotalOptions + 1
            end)

            if TotalOptions > 0 then
                local Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (TotalOptions * 30) + ((TotalOptions + 1) * 5))

                local ChipSet = Objects.new("RoundFrame")
                ChipSet.Name = "ChipSet"
                ChipSet.Size = Size
                ChipSet.ImageColor3 = ThisTheme.ChipSet
                ChipSet.ImageTransparency = 1
                ChipSet.Parent = PageContentFrame

                local ChipList = Objects.new("UIListLayout")
                ChipList.SortOrder = Enum.SortOrder.LayoutOrder
                ChipList.Padding = UDim.new(0, 5)
                ChipList.Parent = ChipSet

                local ChipPadding = Objects.new("UIPadding")
                ChipPadding.PaddingBottom = UDim.new(0, 5)
                ChipPadding.PaddingTop = UDim.new(0, 5)
                ChipPadding.PaddingRight = UDim.new(0, 5)
                ChipPadding.PaddingLeft = UDim.new(0, 5)
                ChipPadding.Parent = ChipSet

                local BuildTable = {}
                table.foreach(ChipSetOptions, function(Key, Value)
                    if typeof(Value) == "table" then
                        BuildTable[Key] = Value.Enabled
                    else
                        BuildTable[Key] = Value
                    end
                end)

                ChipSetCallback(BuildTable)

                TweenService:Create(ChipSet, TweenInfo.new(0.5), {ImageTransparency = 0.9}):Play()

                table.foreach(ChipSetOptions, function(Key, Value)
                    local ChipItem = Objects.new("SmoothButton")
                    ChipItem.Name = "ChipItem"
                    ChipItem.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
                    ChipItem.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSet or ThisTheme.ChipSetAccent
                    ChipItem.ImageTransparency = 1
                    ChipItem.Parent = ChipSet

                    local ChipShadow = Objects.new("Shadow")
                    ChipShadow.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSet or ThisTheme.ChipSetAccent
                    ChipShadow.ImageTransparency = 1
                    ChipShadow.Parent = ChipItem

                    local Tick = Objects.new("RoundFrame")
                    Tick.ScaleType = Enum.ScaleType.Stretch
                    Tick.Image = "http://www.roblox.com/asset/?id=5554953789"
                    Tick.ImageColor3 = ThisTheme.ChipSetAccent
                    Tick.ImageTransparency = 1
                    Tick.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(10, 10)
                    Tick.SizeConstraint = Enum.SizeConstraint.RelativeYY
                    Tick.Position = UDim2.fromOffset(5, 5)
                    Tick.Parent = ChipItem

                    local ChipLabel = Objects.new("Label")
                    ChipLabel.Size = BuildTable[Key] and (UDim2.fromScale(1, 1) - UDim2.fromOffset(30)) or (UDim2.fromScale(1, 1) - UDim2.fromOffset(5))
                    ChipLabel.Position = BuildTable[Key] and UDim2.fromOffset(30) or UDim2.fromOffset(5)
                    ChipLabel.Text = Key
                    ChipLabel.Font = Enum.Font.Gotham
                    ChipLabel.TextSize = 12
                    ChipLabel.TextColor3 = BuildTable[Key] and ThisTheme.ChipSetAccent or ThisTheme.ChipSet
                    ChipLabel.TextTransparency = 1
                    ChipLabel.Parent = ChipItem

                    TweenService:Create(ChipItem, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
                    TweenService:Create(ChipShadow, TweenInfo.new(0.5), {ImageTransparency = 0.2}):Play()
                    TweenService:Create(Tick, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 1}):Play()
                    TweenService:Create(ChipLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

                    local ChipMenu
                    if typeof(Value) == "table" then
                        local Menu = Value.Menu or {}
                        local MenuAdded, MenuButton = TryAddMenu(ChipItem, Menu, {})
                        MenuButton.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSetAccent or ThisTheme.ChipSet
                        ChipMenu = MenuButton
                    end

                    ChipItem.MouseButton1Down:Connect(function()
                        BuildTable[Key] = not BuildTable[Key]
                        local Enabled = BuildTable[Key]
                        TweenService:Create(ChipItem, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSet or ThisTheme.ChipSetAccent}):Play()
                        TweenService:Create(ChipShadow, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSet or ThisTheme.ChipSetAccent}):Play()
                        TweenService:Create(Tick, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 1}):Play()
                        TweenService:Create(ChipLabel, TweenInfo.new(0.15), {TextColor3 = Enabled and ThisTheme.ChipSetAccent or ThisTheme.ChipSet, Position = Enabled and UDim2.fromOffset(30) or UDim2.fromOffset(5), Size = Enabled and (UDim2.fromScale(1, 1) - UDim2.fromOffset(30)) or (UDim2.fromScale(1, 1) - UDim2.fromOffset(5))}):Play()
                        if ChipMenu then
                            TweenService:Create(ChipMenu, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSetAccent or ThisTheme.ChipSet}):Play()
                        end
                        ChipSetCallback(BuildTable)
                    end)
                end)

                local ChipSetLibrary = {}
                function ChipSetLibrary:SetOptions(NewMenu)
                    ChipSetOptions = NewMenu or {}
                    TotalOptions = 0
                    table.foreach(ChipSetOptions, function()
                        TotalOptions = TotalOptions + 1
                    end)

                    for _, Element in next, ChipSet:GetChildren() do
                        Element:Destroy()
                    end

                    Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (TotalOptions * 30) + ((TotalOptions + 1) * 5))
                    TweenService:Create(ChipSet, TweenInfo.new(0.15), {Size = Size}):Play()

                    local ChipList = Objects.new("UIListLayout")
                    ChipList.SortOrder = Enum.SortOrder.LayoutOrder
                    ChipList.Padding = UDim.new(0, 5)
                    ChipList.Parent = ChipSet

                    local ChipPadding = Objects.new("UIPadding")
                    ChipPadding.PaddingBottom = UDim.new(0, 5)
                    ChipPadding.PaddingTop = UDim.new(0, 5)
                    ChipPadding.PaddingRight = UDim.new(0, 5)
                    ChipPadding.PaddingLeft = UDim.new(0, 5)
                    ChipPadding.Parent = ChipSet

                    local BuildTable = {}
                    table.foreach(ChipSetOptions, function(Key, Value)
                        if typeof(Value) == "table" then
                            BuildTable[Key] = Value.Enabled
                        else
                            BuildTable[Key] = Value
                        end
                    end)

                    ChipSetCallback(BuildTable)

                    TweenService:Create(ChipSet, TweenInfo.new(0.5), {ImageTransparency = 0.9}):Play()

                    table.foreach(ChipSetOptions, function(Key, Value)
                        local ChipItem = Objects.new("SmoothButton")
                        ChipItem.Name = "ChipItem"
                        ChipItem.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
                        ChipItem.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSet or ThisTheme.ChipSetAccent
                        ChipItem.ImageTransparency = 1
                        ChipItem.Parent = ChipSet

                        local ChipShadow = Objects.new("Shadow")
                        ChipShadow.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSet or ThisTheme.ChipSetAccent
                        ChipShadow.ImageTransparency = 1
                        ChipShadow.Parent = ChipItem

                        local Tick = Objects.new("RoundFrame")
                        Tick.ScaleType = Enum.ScaleType.Stretch
                        Tick.Image = "http://www.roblox.com/asset/?id=5554953789"
                        Tick.ImageColor3 = ThisTheme.ChipSetAccent
                        Tick.ImageTransparency = 1
                        Tick.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(10, 10)
                        Tick.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        Tick.Position = UDim2.fromOffset(5, 5)
                        Tick.Parent = ChipItem

                        local ChipLabel = Objects.new("Label")
                        ChipLabel.Size = BuildTable[Key] and (UDim2.fromScale(1, 1) - UDim2.fromOffset(30)) or (UDim2.fromScale(1, 1) - UDim2.fromOffset(5))
                        ChipLabel.Position = BuildTable[Key] and UDim2.fromOffset(30) or UDim2.fromOffset(5)
                        ChipLabel.Text = Key
                        ChipLabel.Font = Enum.Font.Gotham
                        ChipLabel.TextSize = 12
                        ChipLabel.TextColor3 = BuildTable[Key] and ThisTheme.ChipSetAccent or ThisTheme.ChipSet
                        ChipLabel.TextTransparency = 1
                        ChipLabel.Parent = ChipItem

                        TweenService:Create(ChipItem, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
                        TweenService:Create(ChipShadow, TweenInfo.new(0.5), {ImageTransparency = 0.2}):Play()
                        TweenService:Create(Tick, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 1}):Play()
                        TweenService:Create(ChipLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

                        local ChipMenu
                        if typeof(Value) == "table" then
                            local Menu = Value.Menu or {}
                            local MenuAdded, MenuButton = TryAddMenu(ChipItem, Menu, {})
                            MenuButton.ImageColor3 = BuildTable[Key] and ThisTheme.ChipSetAccent or ThisTheme.ChipSet
                            ChipMenu = MenuButton
                        end

                        ChipItem.MouseButton1Down:Connect(function()
                            BuildTable[Key] = not BuildTable[Key]
                            local Enabled = BuildTable[Key]
                            TweenService:Create(ChipItem, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSet or ThisTheme.ChipSetAccent}):Play()
                            TweenService:Create(ChipShadow, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSet or ThisTheme.ChipSetAccent}):Play()
                            TweenService:Create(Tick, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 1}):Play()
                            TweenService:Create(ChipLabel, TweenInfo.new(0.15), {TextColor3 = Enabled and ThisTheme.ChipSetAccent or ThisTheme.ChipSet, Position = Enabled and UDim2.fromOffset(30) or UDim2.fromOffset(5), Size = Enabled and (UDim2.fromScale(1, 1) - UDim2.fromOffset(30)) or (UDim2.fromScale(1, 1) - UDim2.fromOffset(5))}):Play()
                            if ChipMenu then
                                TweenService:Create(ChipMenu, TweenInfo.new(0.15), {ImageColor3 = Enabled and ThisTheme.ChipSetAccent or ThisTheme.ChipSet}):Play()
                            end
                            ChipSetCallback(BuildTable)
                        end)
                    end)
                end)
                function ChipSetLibrary:GetOptions()
                    return ChipSetOptions
                end
                return ChipSetLibrary
            end
        end

        function OptionLibrary:DataTable(DataTableConfig)
            local DataTableText = DataTableConfig.Text or "nil chipset"
            local DataTableCallback = DataTableConfig.Callback or function() print("nil chipset") end
            local DataTableOptions = DataTableConfig.Options or {}

            local TotalOptions = 0
            table.foreach(DataTableOptions, function()
                TotalOptions = TotalOptions + 1
            end)

            if TotalOptions > 0 then
                local Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (TotalOptions * 30) + ((TotalOptions + 1) * 5))

                local DataTable = Objects.new("RoundFrame")
                DataTable.Name = "DataTable"
                DataTable.Size = Size
                DataTable.ImageColor3 = ThisTheme.DataTable
                DataTable.ImageTransparency = 1
                DataTable.Parent = PageContentFrame

                local DataShadow = Objects.new("Shadow")
                DataShadow.ImageColor3 = ThisTheme.DataTable
                DataShadow.ImageTransparency = 1
                DataShadow.Parent = DataTable

                local DataContainer = Objects.new("Frame")
                DataContainer.Name = "Container"
                DataContainer.Parent = DataTable

                local DataList = Objects.new("UIListLayout")
                DataList.SortOrder = Enum.SortOrder.LayoutOrder
                DataList.Padding = UDim.new(0, 5)
                DataList.Parent = DataContainer

                local DataPadding = Objects.new("UIPadding")
                DataPadding.PaddingBottom = UDim.new(0, 5)
                DataPadding.PaddingTop = UDim.new(0, 5)
                DataPadding.PaddingRight = UDim.new(0, 5)
                DataPadding.PaddingLeft = UDim.new(0, 5)
                DataPadding.Parent = DataContainer

                local BuildTable = {}
                table.foreach(DataTableOptions, function(Key, Value)
                    if typeof(Value) == "table" then
                        BuildTable[Key] = Value.Enabled
                    else
                        BuildTable[Key] = Value
                    end
                end)

                DataTableCallback(BuildTable)

                TweenService:Create(DataTable, TweenInfo.new(0.5), {ImageTransparency = 0.9}):Play()
                TweenService:Create(DataShadow, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()

                table.foreach(DataTableOptions, function(Key, Value)
                    local DataItem = Objects.new("SmoothButton")
                    DataItem.Name = "DataItem"
                    DataItem.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
                    DataItem.ImageColor3 = BuildTable[Key] and ThisTheme.DataTable or ThisTheme.DataTableAccent
                    DataItem.ImageTransparency = 1
                    DataItem.Parent = DataContainer

                    local DataTracker = Objects.new("RoundFrame")
                    DataTracker.Name = "Tracker"
                    DataTracker.Size = UDim2.fromOffset(24, 24)
                    DataTracker.Position = UDim2.fromScale(0, 0.5) + UDim2.fromOffset(3, -12)
                    DataTracker.ImageColor3 = ThisTheme.DataTable
                    DataTracker.ImageTransparency = 1
                    DataTracker.Parent = DataItem

                    local Tick = Objects.new("RoundFrame")
                    Tick.Name = "Tick"
                    Tick.ScaleType = Enum.ScaleType.Stretch
                    Tick.Image = "http://www.roblox.com/asset/?id=5554953789"
                    Tick.ImageColor3 = ThisTheme.DataTableAccent
                    Tick.ImageTransparency = 1
                    Tick.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(4, 4)
                    Tick.SizeConstraint = Enum.SizeConstraint.RelativeYY
                    Tick.Position = UDim2.fromOffset(2, 2)
                    Tick.Parent = DataTracker

                    local DataLabel = Objects.new("Label")
                    DataLabel.Name = "Value"
                    DataLabel.Size = (UDim2.fromScale(1, 1) - UDim2.fromOffset(30))
                    DataLabel.Position = UDim2.fromOffset(30) or UDim2.fromOffset(5)
                    DataLabel.Text = Key
                    DataLabel.Font = Enum.Font.Gotham
                    DataLabel.TextSize = 14
                    DataLabel.TextColor3 = ThisTheme.DataTable
                    DataLabel.TextTransparency = 1
                    DataLabel.Parent = DataItem

                    TweenService:Create(DataItem, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0.8 or 0}):Play()
                    TweenService:Create(DataTracker, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 0.8}):Play()
                    TweenService:Create(Tick, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 0.7}):Play()
                    TweenService:Create(DataLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

                    local DataMenu
                    if typeof(Value) == "table" then
                        local Menu = Value.Menu or {}
                        local MenuAdded, MenuButton = TryAddMenu(DataItem, Menu, {})
                        MenuButton.ImageColor3 = ThisTheme.DataTable
                        DataMenu = MenuButton
                    end

                    DataItem.MouseButton1Down:Connect(function()
                        BuildTable[Key] = not BuildTable[Key]
                        local Enabled = BuildTable[Key]
                        TweenService:Create(DataItem, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0.8 or 0, ImageColor3 = Enabled and ThisTheme.DataTable or ThisTheme.DataTableAccent}):Play()
                        TweenService:Create(Tick, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 0.7}):Play()
                        TweenService:Create(DataTracker, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 0.8}):Play()
                        DataTableCallback(BuildTable)
                    end)
                end)

                local DataTableLibrary = {}
                function DataTableLibrary:SetOptions(NewMenu)
                    if DataContainer then
                        DataContainer:Destroy()
                    end

                    DataTableOptions = NewMenu or {}
                    TotalOptions = 0
                    table.foreach(DataTableOptions, function()
                        TotalOptions = TotalOptions + 1
                    end)

                    Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, (TotalOptions * 30) + ((TotalOptions + 1) * 5))
                    DataTable.Size = Size

                    DataContainer = Objects.new("Frame")
                    DataContainer.Name = "Container"
                    DataContainer.Parent = DataTable

                    local DataList = Objects.new("UIListLayout")
                    DataList.SortOrder = Enum.SortOrder.LayoutOrder
                    DataList.Padding = UDim.new(0, 5)
                    DataList.Parent = DataContainer

                    local DataPadding = Objects.new("UIPadding")
                    DataPadding.PaddingBottom = UDim.new(0, 5)
                    DataPadding.PaddingTop = UDim.new(0, 5)
                    DataPadding.PaddingRight = UDim.new(0, 5)
                    DataPadding.PaddingLeft = UDim.new(0, 5)
                    DataPadding.Parent = DataContainer

                    local BuildTable = {}
                    table.foreach(DataTableOptions, function(Key, Value)
                        if typeof(Value) == "table" then
                            BuildTable[Key] = Value.Enabled
                        else
                            BuildTable[Key] = Value
                        end
                    end)

                    DataTableCallback(BuildTable)

                    TweenService:Create(DataTable, TweenInfo.new(0.5), {ImageTransparency = 0.9}):Play()
                    TweenService:Create(DataShadow, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()

                                        table.foreach(DataTableOptions, function(Key, Value)
                        local DataItem = Objects.new("SmoothButton")
                        DataItem.Name = "DataItem"
                        DataItem.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
                        DataItem.ImageColor3 = BuildTable[Key] and ThisTheme.DataTable or ThisTheme.DataTableAccent
                        DataItem.ImageTransparency = 1
                        DataItem.Parent = DataContainer

                        local DataTracker = Objects.new("RoundFrame")
                        DataTracker.Name = "Tracker"
                        DataTracker.Size = UDim2.fromOffset(24, 24)
                        DataTracker.Position = UDim2.fromScale(0, 0.5) + UDim2.fromOffset(3, -12)
                        DataTracker.ImageColor3 = ThisTheme.DataTable
                        DataTracker.ImageTransparency = 1
                        DataTracker.Parent = DataItem

                        local Tick = Objects.new("RoundFrame")
                        Tick.Name = "Tick"
                        Tick.ScaleType = Enum.ScaleType.Stretch
                        Tick.Image = "http://www.roblox.com/asset/?id=5554953789"
                        Tick.ImageColor3 = ThisTheme.DataTableAccent
                        Tick.ImageTransparency = 1
                        Tick.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(4, 4)
                        Tick.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        Tick.Position = UDim2.fromOffset(2, 2)
                        Tick.Parent = DataTracker

                        local DataLabel = Objects.new("Label")
                        DataLabel.Name = "Value"
                        DataLabel.Size = (UDim2.fromScale(1, 1) - UDim2.fromOffset(30))
                        DataLabel.Position = UDim2.fromOffset(30) or UDim2.fromOffset(5)
                        DataLabel.Text = Key
                        DataLabel.Font = Enum.Font.Gotham
                        DataLabel.TextSize = 14
                        DataLabel.TextColor3 = ThisTheme.DataTable
                        DataLabel.TextTransparency = 1
                        DataLabel.Parent = DataItem

                        TweenService:Create(DataItem, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0.8 or 0}):Play()
                        TweenService:Create(DataTracker, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 0.8}):Play()
                        TweenService:Create(Tick, TweenInfo.new(0.5), {ImageTransparency = BuildTable[Key] and 0 or 0.7}):Play()
                        TweenService:Create(DataLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

                        local DataMenu
                        if typeof(Value) == "table" then
                            local Menu = Value.Menu or {}
                            local MenuAdded, MenuButton = TryAddMenu(DataItem, Menu, {})
                            MenuButton.ImageColor3 = ThisTheme.DataTable
                            DataMenu = MenuButton
                        end

                        DataItem.MouseButton1Down:Connect(function()
                            BuildTable[Key] = not BuildTable[Key]
                            local Enabled = BuildTable[Key]
                            TweenService:Create(DataItem, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0.8 or 0, ImageColor3 = Enabled and ThisTheme.DataTable or ThisTheme.DataTableAccent}):Play()
                            TweenService:Create(Tick, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 0.7}):Play()
                            TweenService:Create(DataTracker, TweenInfo.new(0.15), {ImageTransparency = Enabled and 0 or 0.8}):Play()
                            DataTableCallback(BuildTable)
                        end)
                    end)
                end
                function DataTableLibrary:GetOptions()
                    return DataTableOptions
                end
                return DataTableLibrary
            end
        end

        function OptionLibrary:Slider(SliderConfig)
            local SliderText = SliderConfig.Text or "nil slider"
            local SliderCallback = SliderConfig.Callback or function() print("nil slider") end
            local SliderMin = SliderConfig.Min or 0
            local SliderMax = SliderConfig.Max or 100
            local SliderDefault = SliderConfig.Default or 50
            local SliderPrecision = SliderConfig.Precision or 0
            local Menu = SliderConfig.Menu or {}

            local Slider = Objects.new("Frame")
            Slider.Name = "Slider"
            Slider.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 50)
            Slider.Parent = PageContentFrame

            local SliderBar = Objects.new("RoundFrame")
            SliderBar.Name = "TitleBar"
            SliderBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 50)
            SliderBar.ImageColor3 = ThisTheme.Slider
            SliderBar.ImageTransparency = 1
            SliderBar.Parent = Slider

            local SliderShadow = Objects.new("Shadow")
            SliderShadow.ImageColor3 = ThisTheme.Slider
            SliderShadow.ImageTransparency = 1
            SliderShadow.Parent = SliderBar

            local SliderTitle = Objects.new("Label")
            SliderTitle.Name = "Title"
            SliderTitle.Text = SliderText .. ": " .. SliderDefault
            SliderTitle.TextColor3 = ThisTheme.SliderAccent
            SliderTitle.TextTransparency = 1
            SliderTitle.Font = Enum.Font.GothamSemibold
            SliderTitle.TextSize = 14
            SliderTitle.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-5, 25)
            SliderTitle.Parent = SliderBar

            local SliderTrack = Objects.new("RoundFrame")
            SliderTrack.Name = "Track"
            SliderTrack.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 5)
            SliderTrack.Position = UDim2.fromOffset(5, 30)
            SliderTrack.ImageColor3 = ThisTheme.SliderAccent
            SliderTrack.ImageTransparency = 1
            SliderTrack.Parent = SliderBar

            local SliderFill = Objects.new("RoundFrame")
            SliderFill.Name = "Fill"
            SliderFill.Size = UDim2.fromScale((SliderDefault - SliderMin) / (SliderMax - SliderMin), 1)
            SliderFill.ImageColor3 = ThisTheme.SliderAccent
            SliderFill.ImageTransparency = 1
            SliderFill.Parent = SliderTrack

            local SliderButton = Objects.new("TextButton")
            SliderButton.Size = UDim2.fromScale(1, 1)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderTrack

            TweenService:Create(SliderBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(SliderShadow, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()
            TweenService:Create(SliderTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(SliderTrack, TweenInfo.new(0.5), {ImageTransparency = 0.5}):Play()
            TweenService:Create(SliderFill, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            local SliderValue = SliderDefault
            local Dragging = false

            SliderButton.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                end
            end)

            SliderButton.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(Input)
                if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    local RelativeX = math.clamp((Input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local Power = 10 ^ SliderPrecision
                    local Value = math.floor((SliderMin + (RelativeX * (SliderMax - SliderMin))) * Power) / Power
                    SliderFill.Size = UDim2.fromScale(RelativeX, 1)
                    SliderValue = Value
                    SliderTitle.Text = SliderText .. ": " .. Value
                    SliderCallback(Value)
                end
            end)

            local MenuAdded, MenuButton = TryAddMenu(SliderBar, Menu, {})

            local SliderLibrary = {}
            function SliderLibrary:SetText(Value)
                SliderTitle.Text = Value .. ": " .. SliderValue
            end
            function SliderLibrary:GetText()
                return SliderTitle.Text
            end
            function SliderLibrary:GetValue()
                return SliderValue
            end
            function SliderLibrary:SetMin(Value)
                SliderMin = Value
                if SliderValue < SliderMin then
                    SliderValue = SliderMin
                    SliderFill.Size = UDim2.fromScale(0, 1)
                    SliderTitle.Text = SliderText .. ": " .. SliderValue
                end
            end
            function SliderLibrary:SetMax(Value)
                SliderMax = Value
                if SliderValue > SliderMax then
                    SliderValue = SliderMax
                    SliderFill.Size = UDim2.fromScale(1, 1)
                    SliderTitle.Text = SliderText .. ": " .. SliderValue
                end
            end
            function SliderLibrary:GetMin()
                return SliderMin
            end
            function SliderLibrary:GetMax()
                return SliderMax
            end
            return SliderLibrary
        end

        function OptionLibrary:Toggle(ToggleConfig)
            local ToggleText = ToggleConfig.Text or "nil toggle"
            local ToggleCallback = ToggleConfig.Callback or function() print("nil toggle") end
            local ToggleDefault = ToggleConfig.Default or false
            local Menu = ToggleConfig.Menu or {}

            local Toggle = Objects.new("Frame")
            Toggle.Name = "Toggle"
            Toggle.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            Toggle.Parent = PageContentFrame

            local ToggleBar = Objects.new("RoundFrame")
            ToggleBar.Name = "TitleBar"
            ToggleBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            ToggleBar.ImageColor3 = ThisTheme.Toggle
            ToggleBar.ImageTransparency = 1
            ToggleBar.Parent = Toggle

            local ToggleTitle = Objects.new("Label")
            ToggleTitle.Name = "Title"
            ToggleTitle.Text = ToggleText
            ToggleTitle.TextColor3 = ThisTheme.ToggleAccent
            ToggleTitle.TextTransparency = 1
            ToggleTitle.Font = Enum.Font.GothamSemibold
            ToggleTitle.TextSize = 14
            ToggleTitle.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(30, 0)
            ToggleTitle.Parent = ToggleBar

            local ToggleSwitch = Objects.new("RoundFrame")
            ToggleSwitch.Name = "Switch"
            ToggleSwitch.Size = UDim2.fromOffset(24, 24)
            ToggleSwitch.Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(27, 12)
            ToggleSwitch.ImageColor3 = ToggleDefault and ThisTheme.ToggleAccent or ThisTheme.Toggle
            ToggleSwitch.ImageTransparency = 1
            ToggleSwitch.Parent = ToggleBar

            local ToggleIndicator = Objects.new("RoundFrame")
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Image = "http://www.roblox.com/asset/?id=5554831670"
            ToggleIndicator.Size = UDim2.fromOffset(16, 16)
            ToggleIndicator.Position = ToggleDefault and UDim2.fromOffset(4, 4) or UDim2.fromOffset(2, 4)
            ToggleIndicator.ImageColor3 = ThisTheme.ToggleAccent
            ToggleIndicator.ImageTransparency = 1
            ToggleIndicator.Parent = ToggleSwitch

            TweenService:Create(ToggleBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(ToggleTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(ToggleSwitch, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(ToggleIndicator, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            local ToggleValue = ToggleDefault

            ToggleBar.MouseButton1Down:Connect(function()
                ToggleValue = not ToggleValue
                TweenService:Create(ToggleSwitch, TweenInfo.new(0.15), {ImageColor3 = ToggleValue and ThisTheme.ToggleAccent or ThisTheme.Toggle}):Play()
                TweenService:Create(ToggleIndicator, TweenInfo.new(0.15), {Position = ToggleValue and UDim2.fromOffset(4, 4) or UDim2.fromOffset(2, 4)}):Play()
                ToggleCallback(ToggleValue)
            end)

            local MenuAdded, MenuButton = TryAddMenu(ToggleBar, Menu, {})

            if MenuAdded then
                ToggleSwitch.Position = ToggleSwitch.Position - UDim2.fromOffset(25, 0)
                MenuButton.ImageColor3 = ThisTheme.ToggleAccent
            end

            local ToggleLibrary = {}
            function ToggleLibrary:SetText(Value)
                ToggleTitle.Text = Value
            end
            function ToggleLibrary:GetText()
                return ToggleTitle.Text
            end
            function ToggleLibrary:GetValue()
                return ToggleValue
            end
            return ToggleLibrary
        end

        function OptionLibrary:ColorPicker(ColorPickerConfig)
            local ColorPickerText = ColorPickerConfig.Text or "nil color picker"
            local ColorPickerCallback = ColorPickerConfig.Callback or function() print("nil color picker") end
            local ColorPickerDefault = ColorPickerConfig.Default or Color3.fromRGB(255, 255, 255)
            local Menu = ColorPickerConfig.Menu or {}

            local ColorPicker = Objects.new("Frame")
            ColorPicker.Name = "ColorPicker"
            ColorPicker.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            ColorPicker.Parent = PageContentFrame

            local ColorPickerBar = Objects.new("RoundFrame")
            ColorPickerBar.Name = "TitleBar"
            ColorPickerBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            ColorPickerBar.ImageColor3 = ThisTheme.ColorPicker
            ColorPickerBar.ImageTransparency = 1
            ColorPickerBar.Parent = ColorPicker

            local ColorPickerTitle = Objects.new("Label")
            ColorPickerTitle.Name = "Title"
            ColorPickerTitle.Text = ColorPickerText
            ColorPickerTitle.TextColor3 = ThisTheme.ColorPickerAccent
            ColorPickerTitle.TextTransparency = 1
            ColorPickerTitle.Font = Enum.Font.GothamSemibold
            ColorPickerTitle.TextSize = 14
            ColorPickerTitle.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(30, 0)
            ColorPickerTitle.Parent = ColorPickerBar

            local ColorPickerPreview = Objects.new("RoundFrame")
            ColorPickerPreview.Name = "Preview"
            ColorPickerPreview.Size = UDim2.fromOffset(24, 24)
            ColorPickerPreview.Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(27, 12)
            ColorPickerPreview.ImageColor3 = ColorPickerDefault
            ColorPickerPreview.ImageTransparency = 1
            ColorPickerPreview.Parent = ColorPickerBar

            TweenService:Create(ColorPickerBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(ColorPickerTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(ColorPickerPreview, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            local ColorPickerContent = Objects.new("Frame")
            ColorPickerContent.Name = "Content"
            ColorPickerContent.Size = UDim2.fromScale(1, 0)
            ColorPickerContent.Position = UDim2.fromOffset(0, 35)
            ColorPickerContent.ClipsDescendants = true
            ColorPickerContent.Parent = ColorPicker

            local ColorPickerToggle = false
            local ColorPickerSize = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 150)

            ColorPickerBar.MouseButton1Down:Connect(function()
                ColorPickerToggle = not ColorPickerToggle
                TweenService:Create(ColorPickerContent, TweenInfo.new(0.15), {Size = ColorPickerToggle and ColorPickerSize or UDim2.fromScale(1, 0)}):Play()
                TweenService:Create(ColorPicker, TweenInfo.new(0.15), {Size = ColorPickerToggle and (ColorPickerSize + UDim2.fromOffset(0, 35)) or (UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30))}):Play()
            end)

            -- Color Picker Internals (Simplified for brevity, can expand if needed)
            local ColorPickerValue = ColorPickerDefault
            local HueSlider = Objects.new("Frame")
            HueSlider.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 20)
            HueSlider.Position = UDim2.fromOffset(5, 5)
            HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSlider.Parent = ColorPickerContent

            local HueGradient = Instance.new("UIGradient")
            HueGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
            }
            HueGradient.Parent = HueSlider

            local HueButton = Objects.new("TextButton")
            HueButton.Size = UDim2.fromScale(1, 1)
            HueButton.BackgroundTransparency = 1
            HueButton.Text = ""
            HueButton.Parent = HueSlider

            local HueDragging = false
            HueButton.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    HueDragging = true
                end
            end)

            HueButton.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    HueDragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(Input)
                if HueDragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    local RelativeX = math.clamp((Input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
                    local Hue = RelativeX
                    local Saturation = 1
                    local Value = 1
                    local NewColor = Color3.fromHSV(Hue, Saturation, Value)
                    ColorPickerValue = NewColor
                    ColorPickerPreview.ImageColor3 = NewColor
                    ColorPickerCallback(NewColor)
                end
            end)

            local MenuAdded, MenuButton = TryAddMenu(ColorPickerBar, Menu, {})
            if MenuAdded then
                ColorPickerPreview.Position = ColorPickerPreview.Position - UDim2.fromOffset(25, 0)
                MenuButton.ImageColor3 = ThisTheme.ColorPickerAccent
            end

            local ColorPickerLibrary = {}
            function ColorPickerLibrary:SetText(Value)
                ColorPickerTitle.Text = Value
            end
            function ColorPickerLibrary:GetText()
                return ColorPickerTitle.Text
            end
            function ColorPickerLibrary:GetValue()
                return ColorPickerValue
            end
            return ColorPickerLibrary
        end

        function OptionLibrary:TextField(TextFieldConfig)
            local TextFieldText = TextFieldConfig.Text or "nil text field"
            local TextFieldCallback = TextFieldConfig.Callback or function() print("nil text field") end
            local TextFieldDefault = TextFieldConfig.Default or ""
            local Menu = TextFieldConfig.Menu or {}

            local TextField = Objects.new("Frame")
            TextField.Name = "TextField"
            TextField.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            TextField.Parent = PageContentFrame

            local TextFieldBar = Objects.new("RoundFrame")
            TextFieldBar.Name = "TitleBar"
            TextFieldBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 30)
            TextFieldBar.ImageColor3 = ThisTheme.TextField
            TextFieldBar.ImageTransparency = 1
            TextFieldBar.Parent = TextField

            local TextFieldInput = Objects.new("TextBox")
            TextFieldInput.Name = "Input"
            TextFieldInput.Text = TextFieldDefault
            TextFieldInput.PlaceholderText = TextFieldText
            TextFieldInput.TextColor3 = ThisTheme.TextFieldAccent
            TextFieldInput.TextTransparency = 1
            TextFieldInput.Font = Enum.Font.Gotham
            TextFieldInput.TextSize = 14
            TextFieldInput.BackgroundTransparency = 1
            TextFieldInput.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0)
            TextFieldInput.Parent = TextFieldBar

            TweenService:Create(TextFieldBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(TextFieldInput, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

            TextFieldInput.FocusLost:Connect(function()
                TextFieldCallback(TextFieldInput.Text)
            end)

            local MenuAdded, MenuButton = TryAddMenu(TextFieldBar, Menu, {})
            if MenuAdded then
                MenuButton.ImageColor3 = ThisTheme.TextFieldAccent
            end

            local TextFieldLibrary = {}
            function TextFieldLibrary:SetText(Value)
                TextFieldInput.PlaceholderText = Value
            end
            function TextFieldLibrary:GetText()
                return TextFieldInput.Text
            end
            return TextFieldLibrary
        end

        function OptionLibrary:Label(LabelConfig)
            local LabelText = LabelConfig.Text or "nil label"

            local Label = Objects.new("Frame")
            Label.Name = "Label"
            Label.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 20)
            Label.Parent = PageContentFrame

            local LabelBar = Objects.new("RoundFrame")
            LabelBar.Name = "TitleBar"
            LabelBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 20)
            LabelBar.ImageColor3 = ThisTheme.Content
            LabelBar.ImageTransparency = 1
            LabelBar.Parent = Label

            local LabelTitle = Objects.new("Label")
            LabelTitle.Name = "Title"
            LabelTitle.Text = LabelText
            LabelTitle.TextColor3 = ThisTheme.TitleBarAccent
            LabelTitle.TextTransparency = 1
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.TextSize = 12
            LabelTitle.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0)
            LabelTitle.Parent = LabelBar

            TweenService:Create(LabelBar, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(LabelTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

            local LabelLibrary = {}
            function LabelLibrary:SetText(Value)
                LabelTitle.Text = Value
            end
            function LabelLibrary:GetText()
                return LabelTitle.Text
            end
            return LabelLibrary
        end

        return OptionLibrary
    end

    return TabLibrary
end

return SpectacularUI
