local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local TextService = game:GetService("TextService")

-- Tema lunar para Soon Moon
local Themes = {
    Lunar = {
        MainFrame = Color3.fromRGB(30, 30, 50), -- Azul oscuro lunar
        Minimise = Color3.fromRGB(255, 200, 100), -- Amarillo suave
        MinimiseAccent = Color3.fromRGB(200, 150, 50),
        Maximise = Color3.fromRGB(100, 255, 200), -- Verde azulado
        MaximiseAccent = Color3.fromRGB(50, 200, 150),
        NavBar = Color3.fromRGB(40, 40, 70), -- Fondo de barra
        NavBarAccent = Color3.fromRGB(200, 200, 220), -- Acentos plateados
        NavBarInvert = Color3.fromRGB(20, 20, 30),
        TitleBar = Color3.fromRGB(40, 40, 70),
        TitleBarAccent = Color3.fromRGB(200, 200, 220),
        Overlay = Color3.fromRGB(50, 50, 80),
        Banner = Color3.fromRGB(30, 30, 50),
        BannerAccent = Color3.fromRGB(200, 200, 220),
        Content = Color3.fromRGB(50, 50, 80),
        Button = Color3.fromRGB(60, 60, 100), -- Botones azulados
        ButtonAccent = Color3.fromRGB(200, 200, 220),
        ChipSet = Color3.fromRGB(60, 60, 100),
        ChipSetAccent = Color3.fromRGB(200, 200, 220),
        DataTable = Color3.fromRGB(60, 60, 100),
        DataTableAccent = Color3.fromRGB(200, 200, 220),
        Slider = Color3.fromRGB(50, 50, 80),
        SliderAccent = Color3.fromRGB(100, 150, 255), -- Azul brillante
        Toggle = Color3.fromRGB(60, 60, 100),
        ToggleAccent = Color3.fromRGB(200, 200, 220),
        Dropdown = Color3.fromRGB(50, 50, 80),
        DropdownAccent = Color3.fromRGB(200, 200, 220),
        ColorPicker = Color3.fromRGB(50, 50, 80),
        ColorPickerAccent = Color3.fromRGB(200, 200, 220),
        TextField = Color3.fromRGB(60, 60, 100),
        TextFieldAccent = Color3.fromRGB(200, 200, 220),
        Notification = Color3.fromRGB(30, 30, 50), -- Fondo de notificaciones
        NotificationAccent = Color3.fromRGB(100, 150, 255),
    }
}

-- Tipos de componentes
local Types = {
    "RoundFrame", "Shadow", "Circle", "CircleButton", "Frame", "Label",
    "Button", "SmoothButton", "Box", "ScrollingFrame", "Menu", "NavBar"
}

local ActualTypes = {
    RoundFrame = "ImageLabel", Shadow = "ImageLabel", Circle = "ImageLabel",
    CircleButton = "ImageButton", Frame = "Frame", Label = "TextLabel",
    Button = "TextButton", SmoothButton = "ImageButton", Box = "TextBox",
    ScrollingFrame = "ScrollingFrame", Menu = "ImageButton", NavBar = "ImageButton"
}

-- Propiedades de los componentes
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

-- Funciones auxiliares
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
    local NewImage = Instance.new(TargetType and ActualTypes[TargetType] or Type)
    if TargetType and Properties[TargetType] then
        for Property, Value in next, Properties[TargetType] do
            NewImage[Property] = Value
        end
    end
    return NewImage
end

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
    local Size = GuiObject.AbsoluteSize.X * 1.5
    TweenService:Create(Circle, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(PX, PY) - UDim2.fromOffset(Size / 2, Size / 2),
        ImageTransparency = 1,
        ImageColor3 = EndColour,
        Size = UDim2.fromOffset(Size, Size)
    }):Play()
    spawn(function()
        wait(0.5)
        Circle:Destroy()
    end)
end

-- Sistema de notificaciones
local NotificationHolder
local function CreateNotificationHolder()
    NotificationHolder = Objects.new("Frame")
    NotificationHolder.Name = "NotificationHolder"
    NotificationHolder.Size = UDim2.fromScale(0.3, 1)
    NotificationHolder.Position = UDim2.fromScale(0.7, 0)
    NotificationHolder.BackgroundTransparency = 1
    NotificationHolder.Parent = CoreGuiService

    local ListLayout = Objects.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.FillDirection = Enum.FillDirection.Vertical
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.Parent = NotificationHolder
end

local function ShowNotification(Config)
    if not NotificationHolder then
        CreateNotificationHolder()
    end

    local Text = Config.Text or "Notification"
    local Duration = Config.Duration or 3
    local Callback = Config.Callback or function() end
    local Buttons = Config.Buttons or {}

    local Notification = Objects.new("RoundFrame")
    Notification.Size = UDim2.fromOffset(200, 60)
    Notification.ImageColor3 = Themes.Lunar.Notification
    Notification.ImageTransparency = 1
    Notification.ZIndex = 300
    Notification.Parent = NotificationHolder

    local Shadow = Objects.new("Shadow")
    Shadow.ImageColor3 = Themes.Lunar.Notification
    Shadow.ImageTransparency = 1
    Shadow.Parent = Notification

    local Label = Objects.new("Label")
    Label.Text = Text
    Label.TextColor3 = Themes.Lunar.NotificationAccent
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextWrapped = true
    Label.Size = UDim2.fromScale(1, 0.6)
    Label.Position = UDim2.fromOffset(5, 5)
    Label.TextTransparency = 1
    Label.Parent = Notification

    local ButtonContainer = Objects.new("Frame")
    ButtonContainer.Size = UDim2.fromScale(1, 0.3)
    ButtonContainer.Position = UDim2.fromScale(0, 0.7)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = Notification

    local ButtonLayout = Objects.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ButtonLayout.Padding = UDim.new(0, 5)
    ButtonLayout.Parent = ButtonContainer

    for ButtonText, ButtonCallback in pairs(Buttons) do
        local Button = Objects.new("SmoothButton")
        Button.Size = UDim2.fromOffset(60, 20)
        Button.ImageColor3 = Themes.Lunar.Button
        Button.ImageTransparency = 1
        Button.Parent = ButtonContainer

        local ButtonLabel = Objects.new("Label")
        ButtonLabel.Text = ButtonText
        ButtonLabel.TextColor3 = Themes.Lunar.ButtonAccent
        ButtonLabel.TextSize = 10
        ButtonLabel.Font = Enum.Font.Gotham
        ButtonLabel.Size = UDim2.fromScale(1, 1)
        ButtonLabel.TextTransparency = 1
        ButtonLabel.Parent = Button

        TweenService:Create(Button, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
        TweenService:Create(ButtonLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

        Button.MouseButton1Down:Connect(function()
            ButtonCallback()
            CircleAnim(Button, Themes.Lunar.ButtonAccent, Themes.Lunar.Button)
        end)
    end

    TweenService:Create(Notification, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(Shadow, TweenInfo.new(0.3), {ImageTransparency = 0.5}):Play()
    TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    spawn(function()
        wait(Duration)
        TweenService:Create(Notification, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        TweenService:Create(Shadow, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        for _, Button in pairs(ButtonContainer:GetChildren()) do
            if Button:IsA("GuiButton") then
                TweenService:Create(Button, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                TweenService:Create(Button:FindFirstChild("Label"), TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            end
        end
        wait(0.3)
        Notification:Destroy()
        Callback()
    end)
end

-- Librería principal
local SoonMoon = {}
local ThisTheme
local MainGUI

function CreateNewButton(ButtonConfig, Parent)
    local ButtonText = ButtonConfig.Text or "Button"
    local ButtonCallback = ButtonConfig.Callback or function() print("Button clicked") end
    local Menu = ButtonConfig.Menu or {}

    local Button = Objects.new("SmoothButton")
    Button.Name = "Button"
    Button.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 35) -- Botón más alto
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
    ButtonLabel.Font = Enum.Font.GothamBold
    ButtonLabel.TextSize = 16 -- Texto más grande
    ButtonLabel.ClipsDescendants = true
    ButtonLabel.TextTransparency = 1
    ButtonLabel.Parent = Button

    -- Efecto de brillo al pasar el mouse
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {ImageColor3 = ThisTheme.ButtonAccent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {ImageColor3 = ThisTheme.Button}):Play()
    end)

    TweenService:Create(Button, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
    TweenService:Create(ButtonShadow, TweenInfo.new(0.5), {ImageTransparency = 0.5}):Play()
    TweenService:Create(ButtonLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    Button.MouseButton1Down:Connect(function()
        CircleAnim(ButtonLabel, ThisTheme.ButtonAccent, ThisTheme.Button)
        ButtonCallback()
        ShowNotification({
            Text = "Botón '" .. ButtonText .. "' presionado!",
            Duration = 2,
            Callback = function() end
        })
    end)

    local function TryAddMenu(Object, Menu, ReturnTable)
        local MenuToggle = false
        local Total = 0
        table.foreach(Menu, function(_, Value) Total = Total + ((typeof(Value) == "function") and 1 or 0) end)

        if Total > 0 then
            local MenuButton = Objects.new("Menu")
            MenuButton.ImageTransparency = 1
            MenuButton.Parent = Object
            TweenService:Create(MenuButton, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            local MenuBuild = Objects.new("Round")
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
                TweenService:Create(MenuBuild, TweenInfo.new(0.15), {Size = MenuToggle and UDim2.fromOffset(120, Total * 30 + ((Total + 1) * 2)) or UDim2.fromOffset(120, 0)}):Play()
            end)

            table.foreach(Menu, function(Option, Value)
                if typeof(Value) == "function" then
                    local MenuOption = Objects.new("SmoothButton")
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
                    OptionValue.Position = UDim2.fromScale(0, 0)
                    OptionValue.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0)
                    OptionValue.Text = Option
                    OptionValue.TextColor3 = ThisTheme.ButtonAccent
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
            end)
            return true, MenuButton
        end
        return false
    end

    local MenuAdded = TryAddMenu(Button, Menu, {})
    return Button, ButtonLabel
end

function SoonMoon.Load(Config)
    local Style = Config.Style or 1
    local Title = Config.Title or "Soon Moon"
    local SizeX = Config.SizeX or 300
    local SizeY = Config.SizeY or 500
    local Theme = Config.Theme or "Lunar"
    local Overrides = Config.ColorOverrides or {}
    local Open = true

    Theme = Themes[Theme] or Themes.Lunar
    ThisTheme = Theme

    for KeyOverride, ValueOverride in next, Overrides do
        ThisTheme[KeyOverride] = ValueOverride
    end

    pcall(function() OldInstance:Destroy() end)

    local function GetExploit()
        local Table = {
            Synapse = rawget(_G, "syn"),
            ProtoSmasher = rawget(_G, "pebc_create"),
            Sentinel = rawget(_G, "issentinelclosure"),
            ScriptWare = rawget(_G, "getexecutorname")
        }
        for ExploitName, ExploitFunction in next, Table do
            if ExploitFunction then return ExploitName end
        end
        return "Undefined"
    end

    local ProtectFunctions = {
        Synapse = function(GuiObject) rawget(_G, "syn").protect_gui(GuiObject); GuiObject.Parent = CoreGuiService end,
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

    local MainFrame = Objects.new("Round")
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
        MouseKill = InputService.InputEnded:Connect(function(UserInput)
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

    local Content = Objects.new("Round")
    Content.Name = "Content"
    Content.ImageColor3 = Theme.Content
    Content.Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(10, 75)
    Content.Position = UDim2.fromOffset(5, 70)
    Content.ImageTransparency = 1
    Content.Parent = MainFrame

    local NavigationBar = Objects.new("Round")
    NavigationBar.Name = "NavBar"
    NavigationBar.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-10, 30)
    NavigationBar.Position = UDim2.fromOffset(5, 35)
    NavigationBar.ImageColor3 = Theme.NavBar
    NavigationBar.ZIndex = 100
    NavigationBar.Parent = MainFrame

    local NavBarShadow = Objects.new("Shadow")
    NavBarShadow.ImageColor3 = Theme.NavBar
    NavBarShadow.Parent = NavigationBar
    NavBarShadow.ZIndex = 100

    local NavBarContent = Objects.new("Frame")
    NavBarContent.Name = "Content"
    NavBarContent.Parent = NavigationBar

    local NavBarList = Objects.new("UIListLayout")
    NavBarList.FillDirection = Enum.FillDirection.Horizontal
    NavBarList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    NavBarList.VerticalAlignment = Enum.VerticalAlignment.Center
    NavBarList.SortOrder = Enum.SortOrder.LayoutOrder
    NavBarList.Parent = NavBarContent

    local NavBarPadding = Objects.new("UIPadding")
    NavBarPadding.PaddingLeft = UDim.new(0, 5)
    NavBarPadding.Parent = NavBarContent

    TweenService:Create(TitleBar, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(ExtraBar, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()
    TweenService:Create(TitleShadow, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(TitleText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    TweenService:Create(MinimiseButton, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(MinimiseShadow, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(Content, TweenInfo.new(1), {ImageTransparency = 0.8}):Play()

    local TabLibrary = {}

    function TabLibrary.Notify(NotifyConfig)
        ShowNotification(NotifyConfig)
    end

    function TabLibrary.New(TabConfig)
        local Title = TabConfig.Title or "Tab"
        local ImageID = TabConfig.ID

        local Button = Objects.new("Button")
        Button.Name = Title:upper()
        Button.Text = Title:upper()
        Button.TextColor3 = ThisTheme.NavBarAccent
        Button.TextSize = 12
        Button.Font = Enum.Font.GothamBold
        Button.Size = UDim2.fromScale(0, 1) + UDim2.fromOffset(TextService:GetTextSize(Title:upper(), 12, Enum.Font.GothamBold, Vector2.new(0, 0)).X + 10, 0)
        Button.TextTransparency = 1
        Button.ZIndex = 200
        Button.Parent = NavBarContent

        TweenService:Create(Button, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

        local PageContentFrame = Objects.new("ScrollingFrame")
        PageContentFrame.Name = Title:upper()
        PageContentFrame.Visible = false
        PageContentFrame.ZIndex = 50
        PageContentFrame.Parent = Content

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

        local OptionLibrary = {}

        function OptionLibrary.Button(ButtonConfig)
            local NewButton, ButtonLabel = CreateNewButton(ButtonConfig, PageContentFrame)
            local ButtonLibrary = {}
            function ButtonLibrary:SetText(Value) ButtonLabel.Text = Value end
            function ButtonLibrary:GetText() return ButtonLabel.Text end
            return ButtonLibrary
        end

        function OptionLibrary.Slider(SliderConfig)
            local SliderText = SliderConfig.Text or "Slider"
            local SliderCallback = SliderConfig.Callback or function() print("Slider moved") end
            local SliderMin = SliderConfig.Min or 0
            local SliderMax = SliderConfig.Max or 100
            local SliderPrecision = SliderConfig.Precision or 0
            local SliderDef = math.clamp(SliderConfig.Def or 50, SliderMin, SliderMax)
            local DefaultScale = (SliderDef - SliderMin) / (SliderMax - SliderMin)

            local Slider = Objects.new("Round")
            Slider.Name = "Slider"
            Slider.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 40)
            Slider.ImageColor3 = ThisTheme.Slider
            Slider.ImageTransparency = 1
            Slider.Parent = PageContentFrame

            local SliderShadow = Objects.new("Shadow")
            SliderShadow.ImageColor3 = ThisTheme.Slider
            SliderShadow.ImageTransparency = 1
            SliderShadow.Parent = Slider

            local SliderTitle = Objects.new("Label")
            SliderTitle.Text = SliderText
            SliderTitle.TextColor3 = ThisTheme.SliderAccent
            SliderTitle.TextSize = 14
            SliderTitle.Font = Enum.Font.GothamBold
            SliderTitle.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-5, 25)
            SliderTitle.TextTransparency = 1
            SliderTitle.Parent = Slider

            local SliderValue = Objects.new("Label")
            SliderValue.Text = tostring(SliderDef)
            SliderValue.TextColor3 = ThisTheme.SliderAccent
            SliderValue.TextTransparency = 1
            SliderValue.TextSize = 14
            SliderValue.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-5, 25)
            SliderValue.Position = UDim2.fromScale(0, 0)
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Parent = Slider

            local SliderTracker = Objects.new("Frame")
            SliderTracker.BackgroundColor3 = ThisTheme.SliderAccent
            SliderTracker.BackgroundTransparency = 1
            SliderTracker.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(-20, 5)
            SliderTracker.Position = UDim2.fromScale(0, 1) + UDim2.fromOffset(10, -10)
            SliderTracker.Parent = Slider

            local SliderFill = SliderTracker:Clone()
            SliderFill.BackgroundTransparency = 1
            SliderFill.Position = UDim2.fromScale(0, 0)
            SliderFill.Size = UDim2.fromScale(DefaultScale, 1)
            SliderFill.Parent = SliderTracker

            local SliderDot = Objects.new("CircleButton")
            SliderDot.Size = UDim2.fromOffset(15, 15)
            SliderDot.Position = UDim2.fromScale(DefaultScale, 0.5) - UDim2.fromOffset(7.5, 7.5)
            SliderDot.ImageColor3 = ThisTheme.SliderAccent
            SliderDot.ImageTransparency = 1
            SliderDot.ZIndex = 50
            SliderDot.Parent = SliderTracker

            TweenService:Create(Slider, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(SliderShadow, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(SliderTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(SliderValue, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            TweenService:Create(SliderTracker, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
            TweenService:Create(SliderFill, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
            TweenService:Create(SliderDot, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()

            SliderDot.MouseButton1Down:Connect(function()
                local MouseMove, MouseKill
                MouseMove = Mouse.Move:Connect(function()
                    local Px = GetXY(SliderTracker)
                    local Power = 10 ^ SliderPrecision
                    local Value = math.floor((SliderMin + ((SliderMax - SliderMin) * Px)) * Power) / Power
                    TweenService:Create(SliderDot, TweenInfo.new(0.15), {Position = UDim2.fromScale(Px, 0.5) - UDim2.fromOffset(7.5, 7.5)}):Play()
                    TweenService:Create(SliderFill, TweenInfo.new(0.15), {Size = UDim2.fromScale(Px, 1)}):Play()
                    SliderValue.Text = tostring(Value)
                    SliderCallback(Value)
                end)
                MouseKill = InputService.InputEnded:Connect(function(UserInput)
                    if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseMove:Disconnect()
                        MouseKill:Disconnect()
                        ShowNotification({
                            Text = "Slider set to " .. SliderValue.Text,
                            Duration = 2
                        })
                    end
                end)
            end)

            local SliderLibrary = {}
            function SliderLibrary:SetText(Value) SliderTitle.Text = Value end
            function SliderLibrary:GetText() return SliderTitle.Text end
            function SliderLibrary:GetValue() return tonumber(SliderValue.Text) end
            return SliderLibrary
        end

        function OptionLibrary.Toggle(ToggleConfig)
            local ToggleText = ToggleConfig.Text or "Toggle"
            local ToggleCallback = ToggleConfig.Callback or function() print("Toggle clicked") end
            local ToggleDefault = ToggleConfig.Enabled or false

            local Toggle = Objects.new("SmoothButton")
            Toggle.Name = "Toggle"
            Toggle.Size = UDim2.fromScale(1, 0) + UDim2.fromOffset(0, 35)
            Toggle.ImageColor3 = ThisTheme.Toggle
            Toggle.ImageTransparency = 1
            Toggle.Parent = PageContentFrame

            local ToggleTracker = Objects.new("Round")
            ToggleTracker.Size = UDim2.fromOffset(40, 20)
            ToggleTracker.Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(45, 10)
            ToggleTracker.ImageColor3 = ThisTheme.Toggle
            ToggleTracker.ImageTransparency = 1
            ToggleTracker.Parent = Toggle

            local MoonIcon = Objects.new("Circle")
            MoonIcon.Size = UDim2.fromOffset(16, 16)
            MoonIcon.Position = ToggleDefault and UDim2.fromScale(1, 0.5) - UDim2.fromOffset(18, 8) or UDim2.fromScale(0, 0.5) - UDim2.fromOffset(2, 8)
            MoonIcon.ImageColor3 = ThisTheme.ToggleAccent
            MoonIcon.ImageTransparency = 1
            MoonIcon.Parent = ToggleTracker

            local ToggleLabel = Objects.new("Label")
            ToggleLabel.Text = ToggleText
            ToggleLabel.TextColor3 = ThisTheme.ToggleAccent
            ToggleLabel.Font = Enum.Font.GothamBold
            ToggleLabel.TextSize = 14
            ToggleLabel.ClipsDescendants = true
            ToggleLabel.TextTransparency = 1
            ToggleLabel.Parent = Toggle

            TweenService:Create(Toggle, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()
            TweenService:Create(ToggleTracker, TweenInfo.new(0.5), {ImageTransparency = 0.5}):Play()
            TweenService:Create(MoonIcon, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            TweenService:Create(ToggleLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

            Toggle.MouseButton1Down:Connect(function()
                ToggleDefault = not ToggleDefault
                TweenService:Create(MoonIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = ToggleDefault and UDim2.fromScale(1, 0.5) - UDim2.fromOffset(18, 8) or UDim2.fromScale(0, 0.5) - UDim2.fromOffset(2, 8),
                    ImageColor3 = ToggleDefault and ThisTheme.ToggleAccent or ThisTheme.Toggle
                }):Play()
                ToggleCallback(ToggleDefault)
                CircleAnim(ToggleLabel, ThisTheme.ToggleAccent, ThisTheme.Toggle)
                ShowNotification({
                    Text = ToggleText .. " " .. (ToggleDefault and "enabled" or "disabled"),
                    Duration = 2
                })
            end)

            local ToggleLibrary = {}
            function ToggleLibrary:SetText(Value) ToggleLabel.Text = Value end
            function ToggleLibrary:GetText() return ToggleLabel.Text end
            function ToggleLibrary:SetState(Value)
                ToggleDefault = Value
                TweenService:Create(MoonIcon, TweenInfo.new(0.2), {
                    Position = ToggleDefault and UDim2.fromScale(1, 0.5) - UDim2.fromOffset(18, 8) or UDim2.fromScale(0, 0.5) - UDim2.fromOffset(2, 8),
                    ImageColor3 = ToggleDefault and ThisTheme.ToggleAccent or ThisTheme.Toggle
                }):Play()
                ToggleCallback(ToggleDefault)
            end
            function ToggleLibrary:GetState() return ToggleDefault end
            return ToggleLibrary
        end

        return OptionLibrary
    end

    return TabLibrary
end

return SoonMoon
