local SpectacularUI = {}

-- Servicios
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configuración de la UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpectacularUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Temas predefinidos
local Themes = {
    Default = {
        Background = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(255, 85, 85),
        Text = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(50, 50, 50),
        Hover = Color3.fromRGB(255, 120, 120),
    },
    Aqua = {
        Background = Color3.fromRGB(20, 30, 40),
        Accent = Color3.fromRGB(0, 200, 255),
        Text = Color3.fromRGB(220, 240, 255),
        Secondary = Color3.fromRGB(40, 60, 80),
        Hover = Color3.fromRGB(50, 220, 255),
    },
    Emerald = {
        Background = Color3.fromRGB(20, 40, 30),
        Accent = Color3.fromRGB(0, 255, 150),
        Text = Color3.fromRGB(220, 255, 230),
        Secondary = Color3.fromRGB(40, 80, 60),
        Hover = Color3.fromRGB(50, 255, 180),
    },
    Amethyst = {
        Background = Color3.fromRGB(40, 30, 50),
        Accent = Color3.fromRGB(200, 100, 255),
        Text = Color3.fromRGB(240, 220, 255),
        Secondary = Color3.fromRGB(60, 50, 80),
        Hover = Color3.fromRGB(220, 120, 255),
    },
    Ruby = {
        Background = Color3.fromRGB(40, 20, 20),
        Accent = Color3.fromRGB(255, 50, 50),
        Text = Color3.fromRGB(255, 220, 220),
        Secondary = Color3.fromRGB(80, 40, 40),
        Hover = Color3.fromRGB(255, 80, 80),
    }
}

-- Colores actuales (inicialmente el tema Default)
local Colors = Themes.Default

-- Animaciones
local TweenInfoSmooth = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TweenInfoFade = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

-- Lista para rastrear dropdowns abiertos
local openDropdowns = {}

-- Crear la ventana principal
function SpectacularUI:CreateWindow(options)
    local window = {}
    window.Title = options.Title or "Spectacular UI"
    window.SizeX = options.SizeX or 400
    window.SizeY = options.SizeY or 500

    -- Frame principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, window.SizeX, 0, window.SizeY)
    MainFrame.Position = UDim2.new(0.5, -window.SizeX / 2, 1, 0) -- Fuera de la pantalla (abajo)
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BackgroundTransparency = 1 -- Para el efecto de desvanecimiento
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Título
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundColor3 = Colors.Secondary
    TitleLabel.Text = window.Title
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleLabel

    -- Botón para cerrar/abrir
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 30, 0, 30)
    ToggleButton.Position = UDim2.new(1, -40, 0, 5)
    ToggleButton.BackgroundColor3 = Colors.Accent
    ToggleButton.Text = "X"
    ToggleButton.TextColor3 = Colors.Text
    ToggleButton.TextSize = 14
    ToggleButton.Font = Enum.Font.Gotham
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = TitleLabel

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleButton

    -- Animación de hover y clic para el botón de cerrar
    ToggleButton.MouseEnter:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {BackgroundColor3 = Colors.Hover, Size = UDim2.new(0, 32, 0, 32)}):Play()
    end)
    ToggleButton.MouseLeave:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(0, 30, 0, 30)}):Play()
    end)
    ToggleButton.MouseButton1Down:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {Size = UDim2.new(0, 28, 0, 28)}):Play()
    end)
    ToggleButton.MouseButton1Up:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {Size = UDim2.new(0, 30, 0, 30)}):Play()
    end)

    -- Lista de pestañas
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, -20, 0, 40)
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 10)
    TabListLayout.Parent = TabContainer

    -- Contenedor de contenido
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -20, 1, -100)
    ContentContainer.Position = UDim2.new(0, 10, 0, 90)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame

    local currentTab = nil
    local tabs = {}

    -- Animación de apertura/cierre con desvanecimiento
    local isOpen = false
    local function ToggleWindow()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(MainFrame, TweenInfoSmooth, {Position = UDim2.new(0.5, -window.SizeX / 2, 0.5, -window.SizeY / 2)}):Play()
            TweenService:Create(MainFrame, TweenInfoFade, {BackgroundTransparency = 0}):Play()
            ToggleButton.Text = "X"
        else
            TweenService:Create(MainFrame, TweenInfoSmooth, {Position = UDim2.new(0.5, -window.SizeX / 2, 1, 0)}):Play()
            TweenService:Create(MainFrame, TweenInfoFade, {BackgroundTransparency = 1}):Play()
            ToggleButton.Text = "^"
        end
    end

    ToggleButton.MouseButton1Click:Connect(ToggleWindow)

    -- Función para actualizar los colores del tema
    local function UpdateTheme(themeName)
        Colors = Themes[themeName] or Themes.Default
        MainFrame.BackgroundColor3 = Colors.Background
        TitleLabel.BackgroundColor3 = Colors.Secondary
        TitleLabel.TextColor3 = Colors.Text
        ToggleButton.BackgroundColor3 = Colors.Accent
        ToggleButton.TextColor3 = Colors.Text

        for _, tab in pairs(tabs) do
            tab.Button.BackgroundColor3 = (tab == currentTab) and Colors.Accent or Colors.Secondary
            tab.Button.TextColor3 = Colors.Text
            for _, child in pairs(tab.Content:GetChildren()) do
                if child:IsA("Frame") or child:IsA("TextButton") then
                    child.BackgroundColor3 = Colors.Secondary
                    if child:FindFirstChild("Indicator") then
                        child.Indicator.BackgroundColor3 = child.Enabled and Colors.Accent or Colors.Background
                    end
                    for _, subChild in pairs(child:GetChildren()) do
                        if subChild:IsA("TextLabel") or subChild:IsA("TextButton") then
                            subChild.TextColor3 = Colors.Text
                        end
                        if subChild:IsA("Frame") and subChild.Name == "DropdownList" then
                            subChild.BackgroundColor3 = Colors.Secondary
                            for _, option in pairs(subChild:GetChildren()) do
                                if option:IsA("TextButton") then
                                    option.BackgroundColor3 = Colors.Background
                                    option.TextColor3 = Colors.Text
                                end
                            end
                        elseif subChild:IsA("Frame") and subChild.Name == "SliderTrack" then
                            subChild.BackgroundColor3 = Colors.Background
                            subChild.SliderFill.BackgroundColor3 = Colors.Accent
                        end
                    end
                end
            end
        end
    end

    -- Crear una nueva pestaña
    function window:NewTab(options)
        local tab = {}
        tab.Title = options.Title or "Tab"

        -- Botón de la pestaña
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.BackgroundColor3 = Colors.Secondary
        TabButton.Text = tab.Title
        TabButton.TextColor3 = Colors.Text
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 5)
        TabCorner.Parent = TabButton

        -- Indicador de pestaña activa (borde inferior)
        local TabIndicator = Instance.new("Frame")
        TabIndicator.Size = UDim2.new(1, 0, 0, 3)
        TabIndicator.Position = UDim2.new(0, 0, 1, -3)
        TabIndicator.BackgroundColor3 = Colors.Accent
        TabIndicator.BorderSizePixel = 0
        TabIndicator.Visible = false
        TabIndicator.Parent = TabButton

        -- Animación de hover y clic para el botón de la pestaña
        TabButton.MouseEnter:Connect(function()
            if currentTab ~= tab then
                TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(0, 105, 0, 32)}):Play()
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if currentTab ~= tab then
                TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(0, 100, 0, 30)}):Play()
            end
        end)
        TabButton.MouseButton1Down:Connect(function()
            TweenService:Create(TabButton, TweenInfoFast, {Size = UDim2.new(0, 95, 0, 28)}):Play()
        end)
        TabButton.MouseButton1Up:Connect(function()
            TweenService:Create(TabButton, TweenInfoFast, {Size = UDim2.new(0, 100, 0, 30)}):Play()
        end)

        -- Contenido de la pestaña
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Position = UDim2.new(0, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 5
        TabContent.ScrollBarImageColor3 = Colors.Accent
        TabContent.Visible = false
        TabContent.Parent = ContentContainer

        local ContentListLayout = Instance.new("UIListLayout")
        ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentListLayout.Padding = UDim.new(0, 10)
        ContentListLayout.Parent = TabContent

        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 10)
        ContentPadding.PaddingBottom = UDim.new(0, 10)
        ContentPadding.PaddingLeft = UDim.new(0, 10)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.Parent = TabContent

        -- Ajustar el tamaño del canvas dinámicamente
        local function UpdateCanvasSize()
            local totalHeight = ContentListLayout.AbsoluteContentSize.Y + 20
            for _, dropdown in pairs(tab.Dropdowns or {}) do
                if dropdown.IsOpen then
                    totalHeight = totalHeight + dropdown.ListHeight
                end
            end
            TabContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
        end

        ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

        -- Cambiar pestaña
        TabButton.MouseButton1Click:Connect(function()
            if currentTab == tab then return end
            if currentTab then
                currentTab.Content.Visible = false
                TweenService:Create(currentTab.Button, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(0, 100, 0, 30)}):Play()
                currentTab.Button.TabIndicator.Visible = false
            end
            currentTab = tab
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(0, 100, 0, 30)}):Play()
            TabIndicator.Visible = true
            UpdateCanvasSize()
        end)

        tab.Button = TabButton
        tab.Content = TabContent
        tab.Dropdowns = {} -- Para rastrear dropdowns en esta pestaña
        table.insert(tabs, tab)

        -- Toggle
        function tab:Toggle(options)
            local toggle = {}
            toggle.Text = options.Text or "Toggle"
            toggle.Callback = options.Callback or function() end
            toggle.Enabled = options.Enabled or false

            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
            ToggleFrame.BackgroundColor3 = Colors.Secondary
            ToggleFrame.Text = ""
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Parent = ToggleFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggle.Text
            ToggleLabel.TextColor3 = Colors.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Size = UDim2.new(0, 40, 0, 20)
            ToggleIndicator.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleIndicator.BackgroundColor3 = toggle.Enabled and Colors.Accent or Colors.Background
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleFrame

            local IndicatorCorner = Instance.new("UICorner")
            IndicatorCorner.CornerRadius = UDim.new(0, 5)
            IndicatorCorner.Parent = ToggleIndicator

            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 16, 0, 16)
            Circle.Position = toggle.Enabled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
            Circle.BackgroundColor3 = Colors.Text
            Circle.Parent = ToggleIndicator

            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(0, 8)
            CircleCorner.Parent = Circle

            -- Inicializar estado visual
            ToggleIndicator.BackgroundColor3 = toggle.Enabled and Colors.Accent or Colors.Background
            Circle.Position = toggle.Enabled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)

            ToggleFrame.MouseButton1Click:Connect(function()
                toggle.Enabled = not toggle.Enabled
                TweenService:Create(ToggleIndicator, TweenInfoFast, {BackgroundColor3 = toggle.Enabled and Colors.Accent or Colors.Background}):Play()
                TweenService:Create(Circle, TweenInfoFast, {Position = toggle.Enabled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play()
                TweenService:Create(Circle, TweenInfoFast, {Size = UDim2.new(0, 14, 0, 14)}):Play() -- Efecto de clic
                task.delay(0.1, function()
                    TweenService:Create(Circle, TweenInfoFast, {Size = UDim2.new(0, 16, 0, 16)}):Play()
                end)
                toggle.Callback(toggle.Enabled)
            end)

            ToggleFrame.MouseEnter:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(1, 0, 0, 32)}):Play()
            end)
            ToggleFrame.MouseLeave:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(1, 0, 0, 30)}):Play()
            end)

            toggle.Frame = ToggleFrame
            return toggle
        end

        -- Slider
        function tab:Slider(options)
            local slider = {}
            slider.Text = options.Text or "Slider"
            slider.Callback = options.Callback or function() end
            slider.Min = options.Min or 0
            slider.Max = options.Max or 100
            slider.Default = options.Default or 50

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Colors.Secondary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 5)
            SliderCorner.Parent = SliderFrame

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -60, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = slider.Text .. ": " .. slider.Default
            SliderLabel.TextColor3 = Colors.Text
            SliderLabel.TextSize = 14
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "SliderTrack"
            SliderTrack.Size = UDim2.new(1, -20, 0, 5)
            SliderTrack.Position = UDim2.new(0, 10, 1, -15)
            SliderTrack.BackgroundColor3 = Colors.Background
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame

            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(0, 3)
            TrackCorner.Parent = SliderTrack

            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "SliderFill"
            SliderFill.Size = UDim2.new((slider.Default - slider.Min) / (slider.Max - slider.Min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Colors.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(0, 3)
            FillCorner.Parent = SliderFill

            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderTrack

            local dragging = false
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)

            SliderButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mouseX = input.Position.X
                    local sliderX = SliderTrack.AbsolutePosition.X
                    local sliderWidth = SliderTrack.AbsoluteSize.X
                    local relativeX = math.clamp((mouseX - sliderX) / sliderWidth, 0, 1)
                    local value = slider.Min + (relativeX * (slider.Max - slider.Min))
                    value = math.floor(value)
                    SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                    SliderLabel.Text = slider.Text .. ": " .. value
                    slider.Callback(value)
                end
            end)

            SliderFrame.MouseEnter:Connect(function()
                TweenService:Create(SliderFrame, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(1, 0, 0, 52)}):Play()
            end)
            SliderFrame.MouseLeave:Connect(function()
                TweenService:Create(SliderFrame, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(1, 0, 0, 50)}):Play()
            end)

            slider.Frame = SliderFrame
            return slider
        end

        -- Dropdown
        function tab:Dropdown(options)
            local dropdown = {}
            dropdown.Text = options.Text or "Dropdown"
            dropdown.Callback = options.Callback or function() end
            dropdown.Options = options.Options or {"Option 1", "Option 2"}
            dropdown.Default = options.Options[1]
            dropdown.ListHeight = 0

            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
            DropdownFrame.BackgroundColor3 = Colors.Secondary
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent

            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Parent = DropdownFrame

            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
            DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = dropdown.Text .. ": " .. dropdown.Default
            DropdownLabel.TextColor3 = Colors.Text
            DropdownLabel.TextSize = 14
            DropdownLabel.Font = Enum.Font.Gotham
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = DropdownFrame

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(0, 30, 0, 30)
            DropdownButton.Position = UDim2.new(1, -40, 0, 0)
            DropdownButton.BackgroundColor3 = Colors.Accent
            DropdownButton.Text = "▼"
            DropdownButton.TextColor3 = Colors.Text
            DropdownButton.TextSize = 14
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Parent = DropdownFrame

            local DropdownCornerButton = Instance.new("UICorner")
            DropdownCornerButton.CornerRadius = UDim.new(0, 5)
            DropdownCornerButton.Parent = DropdownButton

            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 5)
            DropdownList.BackgroundColor3 = Colors.Secondary
            DropdownList.BackgroundTransparency = 1 -- Para el efecto de desvanecimiento
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.Parent = DropdownFrame

            local ListCorner = Instance.new("UICorner")
            ListCorner.CornerRadius = UDim.new(0, 5)
            ListCorner.Parent = DropdownList

            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Padding = UDim.new(0, 5)
            ListLayout.Parent = DropdownList

            local ListPadding = Instance.new("UIPadding")
            ListPadding.PaddingTop = UDim.new(0, 5)
            ListPadding.PaddingBottom = UDim.new(0, 5)
            ListPadding.PaddingLeft = UDim.new(0, 5)
            ListPadding.PaddingRight = UDim.new(0, 5)
            ListPadding.Parent = DropdownList

            local function UpdateListSize()
                DropdownList.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
                dropdown.ListHeight = ListLayout.AbsoluteContentSize.Y + 10
                UpdateCanvasSize()
            end

            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateListSize)

            local isOpen = false
            local function ToggleList()
                -- Cerrar otros dropdowns abiertos
                for _, openDropdown in pairs(openDropdowns) do
                    if openDropdown ~= dropdown and openDropdown.IsOpen then
                        openDropdown.Toggle()
                    end
                end

                isOpen = not isOpen
                DropdownList.Visible = true
                if isOpen then
                    table.insert(openDropdowns, dropdown)
                    TweenService:Create(DropdownList, TweenInfoFast, {Size = UDim2.new(1, 0, 0, dropdown.ListHeight), BackgroundTransparency = 0}):Play()
                    DropdownButton.Text = "▲"
                    -- Desactivar interacción con elementos debajo
                    for _, child in pairs(TabContent:GetChildren()) do
                        if child:IsA("TextButton") or child:IsA("Frame") then
                            if child ~= DropdownFrame and child.ZIndex <= DropdownFrame.ZIndex then
                                child.Active = false
                            end
                        end
                    end
                else
                    table.remove(openDropdowns, table.find(openDropdowns, dropdown))
                    TweenService:Create(DropdownList, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}):Play()
                    task.delay(0.2, function()
                        if not isOpen then
                            DropdownList.Visible = false
                        end
                    end)
                    DropdownButton.Text = "▼"
                    -- Reactivar interacción con elementos debajo
                    for _, child in pairs(TabContent:GetChildren()) do
                        if child:IsA("TextButton") or child:IsA("Frame") then
                            child.Active = true
                        end
                    end
                end
                TweenService:Create(DropdownButton, TweenInfoFast, {BackgroundColor3 = isOpen and Colors.Hover or Colors.Accent, Size = isOpen and UDim2.new(0, 32, 0, 32) or UDim2.new(0, 30, 0, 30)}):Play()
                UpdateCanvasSize()
            end

            dropdown.IsOpen = isOpen
            dropdown.Toggle = ToggleList
            table.insert(tab.Dropdowns, dropdown)

            DropdownButton.MouseButton1Click:Connect(ToggleList)

            for _, option in pairs(dropdown.Options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, -10, 0, 25)
                OptionButton.BackgroundColor3 = Colors.Background
                OptionButton.Text = option
                OptionButton.TextColor3 = Colors.Text
                OptionButton.TextSize = 14
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.BorderSizePixel = 0
                OptionButton.Parent = DropdownList

                local OptionCorner = Instance.new("UICorner")
                OptionCorner.CornerRadius = UDim.new(0, 5)
                OptionCorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    dropdown.Default = option
                    DropdownLabel.Text = dropdown.Text .. ": " .. option
                    dropdown.Callback(option)
                    ToggleList()
                end)

                OptionButton.MouseEnter:Connect(function()
                    TweenService:Create(OptionButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(1, -8, 0, 27)}):Play()
                end)
                OptionButton.MouseLeave:Connect(function()
                    TweenService:Create(OptionButton, TweenInfoFast, {BackgroundColor3 = Colors.Background, Size = UDim2.new(1, -10, 0, 25)}):Play()
                end)
            end

            UpdateListSize()

            DropdownFrame.MouseEnter:Connect(function()
                TweenService:Create(DropdownFrame, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(1, 0, 0, 32)}):Play()
            end)
            DropdownFrame.MouseLeave:Connect(function()
                TweenService:Create(DropdownFrame, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(1, 0, 0, 30)}):Play()
            end)

            dropdown.Frame = DropdownFrame
            return dropdown
        end

        -- Botón
        function tab:Button(options)
            local button = {}
            button.Text = options.Text or "Button"
            button.Callback = options.Callback or function() end

            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
            ButtonFrame.BackgroundColor3 = Colors.Secondary
            ButtonFrame.Text = button.Text
            ButtonFrame.TextColor3 = Colors.Text
            ButtonFrame.TextSize = 14
            ButtonFrame.Font = Enum.Font.Gotham
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabContent

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Parent = ButtonFrame

            ButtonFrame.MouseButton1Click:Connect(function()
                button.Callback()
                TweenService:Create(ButtonFrame, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 28)}):Play()
                task.delay(0.1, function()
                    TweenService:Create(ButtonFrame, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 30)}):Play()
                end)
            end)

            ButtonFrame.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(1, 0, 0, 32)}):Play()
            end)
            ButtonFrame.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfoFast, {BackgroundColor3 = Colors.Secondary, Size = UDim2.new(1, 0, 0, 30)}):Play()
            end)

            button.Frame = ButtonFrame
            return button
        end

        -- Abrir la primera pestaña por defecto
        if #tabs == 1 then
            currentTab = tab
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent, Size = UDim2.new(0, 100, 0, 30)}):Play()
            TabIndicator.Visible = true
        end

        return tab
    end

    -- Función para mostrar notificaciones con apilamiento
    local notificationOffset = 0
    local maxNotifications = 5 -- Máximo de notificaciones visibles a la vez
    local notificationQueue = {}

    local function ShowNotification(options)
        local notify = {}
        notify.Title = options.Title or "Notification"
        notify.Text = options.Text or "This is a notification!"
        notify.Duration = options.Duration or 3

        local NotifyFrame = Instance.new("Frame")
        NotifyFrame.Size = UDim2.new(0, 250, 0, 80)
        NotifyFrame.Position = UDim2.new(1, 0, 0.02, notificationOffset)
        NotifyFrame.BackgroundColor3 = Colors.Background
        NotifyFrame.BackgroundTransparency = 1 -- Para el efecto de desvanecimiento
        NotifyFrame.BorderSizePixel = 0
        NotifyFrame.Parent = ScreenGui

        local NotifyCorner = Instance.new("UICorner")
        NotifyCorner.CornerRadius = UDim.new(0, 5)
        NotifyCorner.Parent = NotifyFrame

        local NotifyTitle = Instance.new("TextLabel")
        NotifyTitle.Size = UDim2.new(1, -10, 0, 20)
        NotifyTitle.Position = UDim2.new(0, 5, 0, 5)
        NotifyTitle.BackgroundTransparency = 1
        NotifyTitle.Text = notify.Title
        NotifyTitle.TextColor3 = Colors.Accent
        NotifyTitle.TextSize = 16
        NotifyTitle.Font = Enum.Font.GothamBold
        NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotifyTitle.Parent = NotifyFrame

        local NotifyText = Instance.new("TextLabel")
        NotifyText.Size = UDim2.new(1, -10, 0, 40)
        NotifyText.Position = UDim2.new(0, 5, 0, 25)
        NotifyText.BackgroundTransparency = 1
        NotifyText.Text = notify.Text
        NotifyText.TextColor3 = Colors.Text
        NotifyText.TextSize = 14
        NotifyText.Font = Enum.Font.Gotham
        NotifyText.TextXAlignment = Enum.TextXAlignment.Left
        NotifyText.TextWrapped = true
        NotifyText.Parent = NotifyFrame

        -- Animación de entrada con rebote
        TweenService:Create(NotifyFrame, TweenInfoSmooth, {Position = UDim2.new(1, -260, 0.02, notificationOffset)}):Play()
        TweenService:Create(NotifyFrame, TweenInfoFade, {BackgroundTransparency = 0}):Play()

        -- Ajustar el offset para la próxima notificación
        notificationOffset = notificationOffset + 90
        table.insert(notificationQueue, NotifyFrame)

        -- Animación de salida después de la duración
        task.delay(notify.Duration, function()
            TweenService:Create(NotifyFrame, TweenInfoSmooth, {Position = UDim2.new(1, 0, 0.02, notificationOffset - 90)}):Play()
            TweenService:Create(NotifyFrame, TweenInfoFade, {BackgroundTransparency = 1}):Play()
            task.delay(0.5, function()
                NotifyFrame:Destroy()
                notificationOffset = notificationOffset - 90
                table.remove(notificationQueue, table.find(notificationQueue, NotifyFrame))
                -- Ajustar posiciones de notificaciones restantes
                for i, frame in ipairs(notificationQueue) do
                    TweenService:Create(frame, TweenInfoFast, {Position = UDim2.new(1, -260, 0.02, (i - 1) * 90)}):Play()
                end
            end)
        end)
    end

    function window:Notify(options)
        if #notificationQueue >= maxNotifications then
            task.delay(1, function()
                window:Notify(options)
            end)
        else
            ShowNotification(options)
        end
    end

    -- Cerrar dropdowns al hacer clic fuera
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            for _, dropdown in pairs(openDropdowns) do
                if dropdown.IsOpen then
                    dropdown.Toggle()
                end
            end
        end
    end)

    -- Pestaña para cambiar temas
    local ThemeTab = window:NewTab({
        Title = "Themes"
    })

    ThemeTab:Dropdown({
        Text = "Select Theme",
        Callback = function(value)
            UpdateTheme(value)
            window:Notify({
                Title = "Theme",
                Text = "Theme changed to " .. value,
                Duration = 3
            })
        end,
        Options = {"Default", "Aqua", "Emerald", "Amethyst", "Ruby"}
    })

    -- Abrir la ventana al iniciar
    ToggleWindow()
    return window
end

return SpectacularUI
