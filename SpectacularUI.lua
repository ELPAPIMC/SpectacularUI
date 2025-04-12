local SpectacularUI = {}

-- Servicios
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
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
    Default = {Background = Color3.fromRGB(30, 30, 30), Accent = Color3.fromRGB(255, 85, 85), Text = Color3.fromRGB(255, 255, 255), Secondary = Color3.fromRGB(50, 50, 50), Hover = Color3.fromRGB(255, 120, 120)},
    Aqua = {Background = Color3.fromRGB(20, 30, 40), Accent = Color3.fromRGB(0, 200, 255), Text = Color3.fromRGB(220, 240, 255), Secondary = Color3.fromRGB(40, 60, 80), Hover = Color3.fromRGB(50, 220, 255)},
    Emerald = {Background = Color3.fromRGB(20, 40, 30), Accent = Color3.fromRGB(0, 255, 150), Text = Color3.fromRGB(220, 255, 230), Secondary = Color3.fromRGB(40, 80, 60), Hover = Color3.fromRGB(50, 255, 180)},
    Amethyst = {Background = Color3.fromRGB(40, 30, 50), Accent = Color3.fromRGB(200, 100, 255), Text = Color3.fromRGB(240, 220, 255), Secondary = Color3.fromRGB(60, 50, 80), Hover = Color3.fromRGB(220, 120, 255)},
    Ruby = {Background = Color3.fromRGB(40, 20, 20), Accent = Color3.fromRGB(255, 50, 50), Text = Color3.fromRGB(255, 220, 220), Secondary = Color3.fromRGB(80, 40, 40), Hover = Color3.fromRGB(255, 80, 80)}
}

local Colors = Themes.Default
local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TweenInfoFade = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local openDropdowns = {}

function SpectacularUI:CreateWindow(options)
    local window = {}
    window.Title = options.Title or "Spectacular UI"
    window.SizeX = options.SizeX or 400
    window.SizeY = options.SizeY or 500

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, window.SizeX, 0, window.SizeY)
    MainFrame.Position = UDim2.new(0.5, -window.SizeX / 2, 0.5, -window.SizeY / 2)
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundColor3 = Colors.Secondary
    TitleLabel.Text = window.Title
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Parent = MainFrame

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, -20, 0, 40)
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 5
    TabContainer.ScrollBarImageColor3 = Colors.Accent
    TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    TabContainer.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 10)
    TabListLayout.Parent = TabContainer

    local function UpdateTabCanvas()
        TabContainer.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X, 0, 0)
    end
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateTabCanvas)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -20, 1, -100)
    ContentContainer.Position = UDim2.new(0, 10, 0, 90)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame

    local currentTab = nil
    local tabs = {}

    local function UpdateTheme(themeName)
        Colors = Themes[themeName] or Themes.Default
        MainFrame.BackgroundColor3 = Colors.Background
        TitleLabel.BackgroundColor3 = Colors.Secondary
        TitleLabel.TextColor3 = Colors.Text
        TabContainer.ScrollBarImageColor3 = Colors.Accent

        for _, tab in pairs(tabs) do
            tab.Button.BackgroundColor3 = (tab == currentTab) and Colors.Accent or Colors.Secondary
            tab.Button.TextColor3 = Colors.Text
            tab.Button.TabIndicator.BackgroundColor3 = Colors.Accent
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
                    end
                end
            end
        end
    end

    function window:NewTab(options)
        local tab = {}
        tab.Title = options.Title or "Tab"

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.BackgroundColor3 = Colors.Secondary
        TabButton.Text = tab.Title
        TabButton.TextColor3 = Colors.Text
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabContainer

        local TabIndicator = Instance.new("Frame")
        TabIndicator.Name = "TabIndicator"
        TabIndicator.Size = UDim2.new(1, 0, 0, 3)
        TabIndicator.Position = UDim2.new(0, 0, 1, -3)
        TabIndicator.BackgroundColor3 = Colors.Accent
        TabIndicator.BorderSizePixel = 0
        TabIndicator.Visible = false
        TabIndicator.Parent = TabButton

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
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

        local function UpdateCanvasSize()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + 20)
        end
        ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

        TabButton.MouseButton1Click:Connect(function()
            if currentTab == tab then return end
            if currentTab then
                currentTab.Content.Visible = false
                currentTab.Button.BackgroundColor3 = Colors.Secondary
                currentTab.Button.TabIndicator.Visible = false
            end
            currentTab = tab
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Colors.Accent
            TabIndicator.Visible = true
            UpdateCanvasSize()
        end)

        tab.Button = TabButton
        tab.Content = TabContent
        table.insert(tabs, tab)

        function tab:Button(options)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
            ButtonFrame.BackgroundColor3 = Colors.Secondary
            ButtonFrame.Text = options.Text or "Button"
            ButtonFrame.TextColor3 = Colors.Text
            ButtonFrame.TextSize = 14
            ButtonFrame.Font = Enum.Font.Gotham
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabContent

            ButtonFrame.MouseButton1Click:Connect(function()
                options.Callback()
            end)
        end

        function tab:Slider(options)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Colors.Secondary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -60, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = (options.Text or "Slider") .. ": " .. (options.Default or 50)
            SliderLabel.TextColor3 = Colors.Text
            SliderLabel.TextSize = 14
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Size = UDim2.new(1, -20, 0, 5)
            SliderTrack.Position = UDim2.new(0, 10, 1, -15)
            SliderTrack.BackgroundColor3 = Colors.Background
            SliderTrack.Parent = SliderFrame

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((options.Default or 50) / (options.Max or 100), 0, 1, 0)
            SliderFill.BackgroundColor3 = Colors.Accent
            SliderFill.Parent = SliderTrack

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
                    local relativeX = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local value = (options.Min or 0) + (relativeX * ((options.Max or 100) - (options.Min or 0)))
                    SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                    SliderLabel.Text = (options.Text or "Slider") .. ": " .. math.floor(value)
                    options.Callback(value)
                end
            end)
        end

        if #tabs == 1 then
            currentTab = tab
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Colors.Accent
            TabIndicator.Visible = true
        end

        UpdateTabCanvas()
        return tab
    end

    function window:Notify(options)
        local NotifyFrame = Instance.new("Frame")
        NotifyFrame.Size = UDim2.new(0, 250, 0, 80)
        NotifyFrame.Position = UDim2.new(1, -260, 0.02, 0)
        NotifyFrame.BackgroundColor3 = Colors.Background
        NotifyFrame.Parent = ScreenGui

        local NotifyTitle = Instance.new("TextLabel")
        NotifyTitle.Size = UDim2.new(1, -10, 0, 20)
        NotifyTitle.Position = UDim2.new(0, 5, 0, 5)
        NotifyTitle.BackgroundTransparency = 1
        NotifyTitle.Text = options.Title or "Notification"
        NotifyTitle.TextColor3 = Colors.Accent
        NotifyTitle.TextSize = 16
        NotifyTitle.Font = Enum.Font.GothamBold
        NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotifyTitle.Parent = NotifyFrame

        local NotifyText = Instance.new("TextLabel")
        NotifyText.Size = UDim2.new(1, -10, 0, 40)
        NotifyText.Position = UDim2.new(0, 5, 0, 25)
        NotifyText.BackgroundTransparency = 1
        NotifyText.Text = options.Text or "This is a notification!"
        NotifyText.TextColor3 = Colors.Text
        NotifyText.TextSize = 14
        NotifyText.Font = Enum.Font.Gotham
        NotifyText.TextXAlignment = Enum.TextXAlignment.Left
        NotifyText.TextWrapped = true
        NotifyText.Parent = NotifyFrame

        task.delay(options.Duration or 3, function()
            NotifyFrame:Destroy()
        end)
    end

    local ThemeTab = window:NewTab({Title = "Themes"})
    ThemeTab:Dropdown({
        Text = "Select Theme",
        Callback = function(value)
            UpdateTheme(value)
            window:Notify({Title = "Theme", Text = "Theme changed to " .. value, Duration = 3})
        end,
        Options = {"Default", "Aqua", "Emerald", "Amethyst", "Ruby"}
    })

    return window
end

return SpectacularUI
