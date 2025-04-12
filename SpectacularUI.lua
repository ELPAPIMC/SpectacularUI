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

-- Colores y estilos
local Colors = {
    Background = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(255, 85, 85),
    Text = Color3.fromRGB(255, 255, 255),
    Secondary = Color3.fromRGB(50, 50, 50),
    Hover = Color3.fromRGB(255, 120, 120),
}

-- Animaciones
local TweenInfoSmooth = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

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

    -- Animación de hover para el botón de cerrar
    ToggleButton.MouseEnter:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {BackgroundColor3 = Colors.Hover}):Play()
    end)
    ToggleButton.MouseLeave:Connect(function()
        TweenService:Create(ToggleButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
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

    -- Animación de apertura/cierre
    local isOpen = false
    local function ToggleWindow()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(MainFrame, TweenInfoSmooth, {Position = UDim2.new(0.5, -window.SizeX / 2, 0.5, -window.SizeY / 2)}):Play()
            ToggleButton.Text = "X"
        else
            TweenService:Create(MainFrame, TweenInfoSmooth, {Position = UDim2.new(0.5, -window.SizeX / 2, 1, 0)}):Play()
            ToggleButton.Text = "^"
        end
    end

    ToggleButton.MouseButton1Click:Connect(ToggleWindow)

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

        -- Animación de hover para el botón de la pestaña
        TabButton.MouseEnter:Connect(function()
            if currentTab ~= tab then
                TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if currentTab ~= tab then
                TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Secondary}):Play()
            end
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
        ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + 20)
        end)

        -- Cambiar pestaña
        TabButton.MouseButton1Click:Connect(function()
            if currentTab == tab then return end
            if currentTab then
                currentTab.Content.Visible = false
                TweenService:Create(currentTab.Button, TweenInfoFast, {BackgroundColor3 = Colors.Secondary}):Play()
            end
            currentTab = tab
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
        end)

        tab.Button = TabButton
        tab.Content = TabContent
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
            Circle.Position = toggle.Enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Circle.BackgroundColor3 = Colors.Text
            Circle.Parent = ToggleIndicator

            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(0, 8)
            CircleCorner.Parent = Circle

            ToggleFrame.MouseButton1Click:Connect(function()
                toggle.Enabled = not toggle.Enabled
                TweenService:Create(ToggleIndicator, TweenInfoFast, {BackgroundColor3 = toggle.Enabled and Colors.Accent or Colors.Background}):Play()
                TweenService:Create(Circle, TweenInfoFast, {Position = toggle.Enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                toggle.Callback(toggle.Enabled)
            end)

            ToggleFrame.MouseEnter:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
            end)
            ToggleFrame.MouseLeave:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfoFast, {BackgroundColor3 = Colors.Secondary}):Play()
            end)

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
            SliderTrack.Size = UDim2.new(1, -20, 0, 5)
            SliderTrack.Position = UDim2.new(0, 10, 1, -15)
            SliderTrack.BackgroundColor3 = Colors.Background
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame

            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(0, 3)
            TrackCorner.Parent = SliderTrack

            local SliderFill = Instance.new("Frame")
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

            return slider
        end

        -- Dropdown
        function tab:Dropdown(options)
            local dropdown = {}
            dropdown.Text = options.Text or "Dropdown"
            dropdown.Callback = options.Callback or function() end
            dropdown.Options = options.Options or {"Option 1", "Option 2"}
            dropdown.Default = options.Options[1]

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
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 5)
            DropdownList.BackgroundColor3 = Colors.Secondary
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
            end

            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateListSize)

            local isOpen = false
            local function ToggleList()
                isOpen = not isOpen
                DropdownList.Visible = isOpen
                DropdownButton.Text = isOpen and "▲" or "▼"
                TweenService:Create(DropdownButton, TweenInfoFast, {BackgroundColor3 = isOpen and Colors.Hover or Colors.Accent}):Play()
            end

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
                    TweenService:Create(OptionButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
                end)
                OptionButton.MouseLeave:Connect(function()
                    TweenService:Create(OptionButton, TweenInfoFast, {BackgroundColor3 = Colors.Background}):Play()
                end)
            end

            UpdateListSize()
            return dropdown
        end

        -- Abrir la primera pestaña por defecto
        if #tabs == 1 then
            currentTab = tab
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfoFast, {BackgroundColor3 = Colors.Accent}):Play()
        end

        return tab
    end

    -- Función para mostrar notificaciones
    function window:Notify(options)
        local notify = {}
        notify.Title = options.Title or "Notification"
        notify.Text = options.Text or "This is a notification!"
        notify.Duration = options.Duration or 3

        local NotifyFrame = Instance.new("Frame")
        NotifyFrame.Size = UDim2.new(0, 250, 0, 80)
        NotifyFrame.Position = UDim2.new(1, 0, 0, 10)
        NotifyFrame.BackgroundColor3 = Colors.Background
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

        -- Animación de entrada
        TweenService:Create(NotifyFrame, TweenInfoSmooth, {Position = UDim2.new(1, -260, 0, 10)}):Play()

        -- Animación de salida después de la duración
        task.delay(notify.Duration, function()
            TweenService:Create(NotifyFrame, TweenInfoSmooth, {Position = UDim2.new(1, 0, 0, 10)}):Play()
            task.delay(0.3, function()
                NotifyFrame:Destroy()
            end)
        end)
    end

    -- Abrir la ventana al iniciar
    ToggleWindow()
    return window
end

return SpectacularUI
