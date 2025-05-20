-- UI Library para Roblox Mejorada
local Library = {}

-- Colores y configuración
local Config = {
    Background = Color3.fromRGB(120, 190, 200),
    AccentColor = Color3.fromRGB(100, 160, 170),
    TextColor = Color3.fromRGB(255, 255, 255),
    ToggleOnColor = Color3.fromRGB(80, 140, 150),
    BorderSize = 1,
    BorderColor = Color3.fromRGB(90, 150, 160),
    AnimationSpeed = 0.3,
    NotificationDuration = 3,
    NotificationOffset = 10
}

local TweenService = game:GetService("TweenService")
local rblx = "rbxassetid://"

local IconTypes = {
    Info = "ℹ️",
    Warning = "⚠️",
    Error = "❌",
    Success = "✅",
    Notify = rblx.."6023426923",
    SuccessL = rblx.."6023426926",
    Human = rblx.."6022668945",
    Block = rblx.."6023565892",
    Document = rblx.."6022668888"
}

-- Cola de notificaciones
local NotificationQueue = {}
local NotificationActive = false

function Library:CreateWindow(title, icon)
    local windowIcon = icon or IconTypes.Block
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = title
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Config.Background
    MainFrame.BorderSizePixel = Config.BorderSize
    MainFrame.BorderColor3 = Config.BorderColor
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    -- Efecto de sombra
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.SliceScale = 1
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Encabezado con el icono
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
    HeaderFrame.BackgroundColor3 = Config.AccentColor
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Parent = MainFrame
    
    -- Agregamos efecto de gradiente al encabezado
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 160, 170)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 140, 150))
    })
    HeaderGradient.Rotation = 90
    HeaderGradient.Parent = HeaderFrame
    
    local WindowIcon = Instance.new("ImageLabel")
    WindowIcon.Size = UDim2.new(0, 25, 0, 25)
    WindowIcon.Position = UDim2.new(0, 10, 0, 7)
    WindowIcon.BackgroundTransparency = 1
    WindowIcon.Image = windowIcon
    WindowIcon.Parent = HeaderFrame
    
    -- Efecto de rotación para el icono (animación)
    local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(WindowIcon, tweenInfo, {Rotation = 360})
    tween:Play()
    
    local TitleBar = Instance.new("TextLabel")
    TitleBar.Text = title
    TitleBar.Size = UDim2.new(1, -50, 1, 0)
    TitleBar.Position = UDim2.new(0, 45, 0, 0)
    TitleBar.BackgroundTransparency = 1
    TitleBar.TextColor3 = Config.TextColor
    TitleBar.TextXAlignment = Enum.TextXAlignment.Left
    TitleBar.Font = Enum.Font.GothamSemibold
    TitleBar.TextSize = 16
    TitleBar.Parent = HeaderFrame
    
    -- Animación de entrada
    MainFrame.Position = UDim2.new(0.5, -225, 0, -400)
    MainFrame.BackgroundTransparency = 1
    Shadow.ImageTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -225, 0.5, -175),
        BackgroundTransparency = 0
    }):Play()
    
    TweenService:Create(Shadow, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ImageTransparency = 0.6
    }):Play()
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Divisiones izquierda y derecha
    local LeftGroup = Instance.new("ScrollingFrame")
    LeftGroup.Size = UDim2.new(0.25, 0, 1, 0)
    LeftGroup.BackgroundTransparency = 0.5
    LeftGroup.BackgroundColor3 = Config.Background
    LeftGroup.BorderSizePixel = 0
    LeftGroup.ScrollBarThickness = 2
    LeftGroup.CanvasSize = UDim2.new(0, 0, 0, 0)
    LeftGroup.AutomaticCanvasSize = Enum.AutomaticSize.Y
    LeftGroup.Parent = ContentFrame
    
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Padding = UDim.new(0, 5)
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Parent = LeftGroup
    
    local RightGroup = Instance.new("Frame")
    RightGroup.Size = UDim2.new(0.75, 0, 1, 0)
    RightGroup.Position = UDim2.new(0.25, 0, 0, 0)
    RightGroup.BackgroundTransparency = 1
    RightGroup.Parent = ContentFrame
    
    local TabButtons = {}
    local Tabs = {}
    local SelectedTab = nil
    
    local Window = {}
    
    -- Sistema de notificaciones
    function Window:Notify(title, description, icon, duration)
        local notifIcon = icon or IconTypes.Info
        local notifDuration = duration or Config.NotificationDuration
        
        local notification = {
            Title = title,
            Description = description,
            Icon = notifIcon,
            Duration = notifDuration
        }
        
        table.insert(NotificationQueue, notification)
        
        if not NotificationActive then
            self:ProcessNotificationQueue()
        end
    end
    
    function Window:ProcessNotificationQueue()
        if #NotificationQueue == 0 then
            NotificationActive = false
            return
        end
        
        NotificationActive = true
        local notification = table.remove(NotificationQueue, 1)
        
        local NotifFrame = Instance.new("Frame")
        NotifFrame.Size = UDim2.new(0, 280, 0, 80)
        NotifFrame.Position = UDim2.new(1, 10, 1, -100 - ((#NotificationQueue) * (80 + Config.NotificationOffset)))
        NotifFrame.BackgroundColor3 = Config.Background
        NotifFrame.BorderSizePixel = 0
        NotifFrame.Parent = ScreenGui
        
        -- Efecto de sombra para notificación
        local NotifShadow = Instance.new("ImageLabel")
        NotifShadow.Size = UDim2.new(1, 30, 1, 30)
        NotifShadow.Position = UDim2.new(0, -15, 0, -15)
        NotifShadow.BackgroundTransparency = 1
        NotifShadow.Image = "rbxassetid://5554236805"
        NotifShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        NotifShadow.ImageTransparency = 0.6
        NotifShadow.ScaleType = Enum.ScaleType.Slice
        NotifShadow.SliceCenter = Rect.new(23, 23, 277, 277)
        NotifShadow.SliceScale = 0.5
        NotifShadow.ZIndex = -1
        NotifShadow.Parent = NotifFrame
        
        local NotifIcon = Instance.new("ImageLabel")
        if string.sub(notification.Icon, 1, 2) == "rb" then -- rbxassetid
            NotifIcon.Image = notification.Icon
        else
            NotifIcon.Text = notification.Icon
            NotifIcon:Destroy()
            NotifIcon = Instance.new("TextLabel")
            NotifIcon.Text = notification.Icon
            NotifIcon.BackgroundTransparency = 1
            NotifIcon.TextScaled = true
        end
        
        NotifIcon.Size = UDim2.new(0, 30, 0, 30)
        NotifIcon.Position = UDim2.new(0, 10, 0, 10)
        NotifIcon.BackgroundTransparency = 1
        NotifIcon.Parent = NotifFrame
        
        local NotifTitle = Instance.new("TextLabel")
        NotifTitle.Text = notification.Title
        NotifTitle.Size = UDim2.new(1, -60, 0, 25)
        NotifTitle.Position = UDim2.new(0, 50, 0, 5)
        NotifTitle.BackgroundTransparency = 1
        NotifTitle.TextColor3 = Config.TextColor
        NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotifTitle.Font = Enum.Font.GothamBold
        NotifTitle.TextSize = 16
        NotifTitle.Parent = NotifFrame
        
        local NotifDesc = Instance.new("TextLabel")
        NotifDesc.Text = notification.Description
        NotifDesc.Size = UDim2.new(1, -20, 0, 40)
        NotifDesc.Position = UDim2.new(0, 10, 0, 35)
        NotifDesc.BackgroundTransparency = 1
        NotifDesc.TextColor3 = Config.TextColor
        NotifDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotifDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotifDesc.TextWrapped = true
        NotifDesc.Font = Enum.Font.Gotham
        NotifDesc.TextSize = 14
        NotifDesc.Parent = NotifFrame
        
        -- Animación de entrada
        NotifFrame.Position = UDim2.new(1, 10, 1, -100)
        NotifFrame.BackgroundTransparency = 1
        if NotifShadow then NotifShadow.ImageTransparency = 1 end
        if NotifIcon then NotifIcon.ImageTransparency = 1 end
        NotifTitle.TextTransparency = 1
        NotifDesc.TextTransparency = 1
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = NotifFrame
        
        -- Animación de entrada
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(1, -290, 1, -100),
            BackgroundTransparency = 0
        }):Play()
        
        if NotifShadow then 
            TweenService:Create(NotifShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                ImageTransparency = 0.6
            }):Play()
        end
        
        if string.sub(notification.Icon, 1, 2) == "rb" then
            TweenService:Create(NotifIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                ImageTransparency = 0
            }):Play()
        end
        
        TweenService:Create(NotifTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            TextTransparency = 0
        }):Play()
        
        TweenService:Create(NotifDesc, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            TextTransparency = 0
        }):Play()
        
        -- Temporizador para la salida
        local function closeNotification()
            TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                Position = UDim2.new(1, 10, 1, -100),
                BackgroundTransparency = 1
            }):Play()
            
            if NotifShadow then
                TweenService:Create(NotifShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                    ImageTransparency = 1
                }):Play()
            end
            
            if string.sub(notification.Icon, 1, 2) == "rb" then
                TweenService:Create(NotifIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                    ImageTransparency = 1
                }):Play()
            end
            
            TweenService:Create(NotifTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                TextTransparency = 1
            }):Play()
            
            TweenService:Create(NotifDesc, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                TextTransparency = 1
            }):Play()
            
            wait(0.5)
            NotifFrame:Destroy()
            
            -- Procesar la siguiente notificación
            window:ProcessNotificationQueue()
        end
        
        delay(notification.Duration, closeNotification)
    end
    
    function Window:AddTab(name, icon)
        local tabIcon = icon or IconTypes.Document
        
        -- Botón del tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 40)
        TabButton.Position = UDim2.new(0, 5, 0, 5 + (#TabButtons * 45))
        TabButton.BackgroundColor3 = Config.AccentColor
        TabButton.TextColor3 = Config.TextColor
        TabButton.Text = ""
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.TextSize = 14
        TabButton.Parent = LeftGroup
        TabButton.BorderSizePixel = 0
        TabButton.AutoButtonColor = false
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = tabIcon
        TabIcon.Parent = TabButton
        
        local TabText = Instance.new("TextLabel")
        TabText.Text = name
        TabText.Size = UDim2.new(1, -50, 1, 0)
        TabText.Position = UDim2.new(0, 40, 0, 0)
        TabText.BackgroundTransparency = 1
        TabText.TextColor3 = Config.TextColor
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.Font = Enum.Font.GothamSemibold
        TabText.TextSize = 14
        TabText.Parent = TabButton
        
        -- Contenido del tab
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, -10, 1, -10)
        TabContent.Position = UDim2.new(0, 5, 0, 5)
        TabContent.BackgroundColor3 = Config.AccentColor
        TabContent.BackgroundTransparency = 0.2
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Parent = RightGroup
        
        local TabContentCorner = Instance.new("UICorner")
        TabContentCorner.CornerRadius = UDim.new(0, 6)
        TabContentCorner.Parent = TabContent
        
        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Padding = UDim.new(0, 10)
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Parent = TabContent
        
        TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        table.insert(TabButtons, TabButton)
        
        -- Animación al hacer clic
        TabButton.MouseButton1Click:Connect(function()
            -- Deseleccionar el tab actual
            if SelectedTab then
                TweenService:Create(TabButtons[SelectedTab], TweenInfo.new(Config.AnimationSpeed), {
                    BackgroundColor3 = Config.AccentColor
                }):Play()
                Tabs[SelectedTab].Visible = false
            end
            
            -- Seleccionar el nuevo tab
            for i, button in pairs(TabButtons) do
                if button == TabButton then
                    SelectedTab = i
                    TweenService:Create(button, TweenInfo.new(Config.AnimationSpeed), {
                        BackgroundColor3 = Config.ToggleOnColor
                    }):Play()
                    
                    -- Animación de aparición
                    Tabs[i].Visible = true
                    Tabs[i].Position = UDim2.new(0.05, 0, 0, 5)
                    Tabs[i].BackgroundTransparency = 1
                    
                    TweenService:Create(Tabs[i], TweenInfo.new(Config.AnimationSpeed), {
                        Position = UDim2.new(0, 5, 0, 5),
                        BackgroundTransparency = 0.2
                    }):Play()
                end
            end
        end)
        
        -- Efectos de hover
        TabButton.MouseEnter:Connect(function()
            if TabButton ~= TabButtons[SelectedTab] then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(
                        Config.AccentColor.R * 255 - 20,
                        Config.AccentColor.G * 255 - 20,
                        Config.AccentColor.B * 255 - 20
                    )
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if TabButton ~= TabButtons[SelectedTab] then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Config.AccentColor
                }):Play()
            end
        end)
        
        table.insert(Tabs, TabContent)
        
        if #Tabs == 1 then
            SelectedTab = 1
            TabButton.BackgroundColor3 = Config.ToggleOnColor
            TabContent.Visible = true
        end
        
        local Tab = {}
        
        function Tab:AddLabel(text, color)
            local labelColor = color or Config.TextColor
            
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Size = UDim2.new(1, -20, 0, 30)
            LabelFrame.BackgroundTransparency = 1
            LabelFrame.Parent = TabContent
            
            local LabelText = Instance.new("TextLabel")
            LabelText.Text = text
            LabelText.Size = UDim2.new(1, 0, 1, 0)
            LabelText.BackgroundTransparency = 1
            LabelText.TextColor3 = labelColor
            LabelText.Font = Enum.Font.GothamSemibold
            LabelText.TextSize = 14
            LabelText.Parent = LabelFrame
            
            -- Efecto de aparición con animación de escritura
            LabelText.MaxVisibleGraphemes = 0
            
            local length = string.len(text)
            for i = 1, length do
                LabelText.MaxVisibleGraphemes = i
                wait(0.02) -- Velocidad de escritura
            end
            
            local Label = {
                Instance = LabelFrame,
                SetText = function(self, newText)
                    LabelText.Text = newText
                end,
                SetColor = function(self, newColor)
                    LabelText.TextColor3 = newColor
                end
            }
            
            return Label
        end
        
        function Tab:AddToggle(name, default, callback, icon)
            local toggleIcon = icon or IconTypes.Block
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -20, 0, 60)
            ToggleFrame.BackgroundColor3 = Config.Background
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleIcon = Instance.new("ImageLabel")
            ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
            ToggleIcon.Position = UDim2.new(0, 10, 0, 10)
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Image = toggleIcon
            ToggleIcon.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Text = name
            ToggleLabel.Size = UDim2.new(1, -80, 0, 30)
            ToggleLabel.Position = UDim2.new(0, 40, 0, 5)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.TextColor3 = Config.TextColor
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.TextSize = 14
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("Frame")
            ToggleButton.Size = UDim2.new(0, 50, 0, 24)
            ToggleButton.Position = UDim2.new(1, -60, 0, 8)
            ToggleButton.BackgroundColor3 = Config.AccentColor
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Parent = ToggleFrame
            
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
            ToggleCircle.Position = UDim2.new(0, 2, 0, 2)
            ToggleCircle.BackgroundColor3 = Config.TextColor
            ToggleCircle.BorderSizePixel = 0
            
            -- Redondeamos el círculo
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = ToggleCircle
            
            ToggleCircle.Parent = ToggleButton
            
            local UICornerToggle = Instance.new("UICorner")
            UICornerToggle.CornerRadius = UDim.new(0, 12)
            UICornerToggle.Parent = ToggleButton
            
            -- Estado del toggle
            local Enabled = default or false
            
            local function UpdateToggle()
                if Enabled then
                    TweenService:Create(ToggleButton, TweenInfo.new(Config.AnimationSpeed), {
                        BackgroundColor3 = Config.ToggleOnColor
                    }):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(Config.AnimationSpeed), {
                        Position = UDim2.new(0, 28, 0, 2)
                    }):Play()
                else
                    TweenService:Create(ToggleButton, TweenInfo.new(Config.AnimationSpeed), {
                        BackgroundColor3 = Config.AccentColor
                    }):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(Config.AnimationSpeed), {
                        Position = UDim2.new(0, 2, 0, 2)
                    }):Play()
                end
                
                if callback then
                    callback(Enabled)
                end
            end
            
            -- Hacer clic en el toggle
            ToggleButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Enabled = not Enabled
                    UpdateToggle()
                end
            end)
            
            -- Agregar el mismo efecto al hacer clic en el círculo
            ToggleCircle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Enabled = not Enabled
                    UpdateToggle()
                end
            end)
            
            -- Configuración inicial
            UpdateToggle()
            
            -- Modo y valor (como en la imagen)
            local ModeLabel = Instance.new("TextLabel")
            ModeLabel.Text = "Mode:"
            ModeLabel.Size = UDim2.new(0, 50, 0, 20)
            ModeLabel.Position = UDim2.new(0, 10, 0, 35)
            ModeLabel.BackgroundTransparency = 1
            ModeLabel.TextColor3 = Config.TextColor
            ModeLabel.TextXAlignment = Enum.TextXAlignment.Left
            ModeLabel.Font = Enum.Font.Gotham
            ModeLabel.TextSize = 12
            ModeLabel.Parent = ToggleFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Text = "eaa"
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -60, 0, 35)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.TextColor3 = Config.TextColor
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.TextSize = 12
            ValueLabel.Parent = ToggleFrame
            
            -- Animación de entrada
            ToggleFrame.BackgroundTransparency = 1
            ToggleLabel.TextTransparency = 1
            ToggleButton.BackgroundTransparency = 1
            ToggleCircle.BackgroundTransparency = 1
            ModeLabel.TextTransparency = 1
            ValueLabel.TextTransparency = 1
            
            TweenService:Create(ToggleFrame, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(ToggleLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(ToggleButton, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(ToggleCircle, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(ModeLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(ValueLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            local Toggle = {
                Instance = ToggleFrame,
                SetValue = function(self, value)
                    Enabled = value
                    UpdateToggle()
                end,
                GetValue = function(self)
                    return Enabled
                end,
                SetMode = function(self, text)
                    ValueLabel.Text = text
                end
            }
            
            return Toggle
        end
        
        function Tab:AddSlider(name, min, max, default, callback, icon)
            local sliderIcon = icon or IconTypes.Document
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -20, 0, 70)
            SliderFrame.BackgroundColor3 = Config.Background
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = SliderFrame
            
            local SliderIcon = Instance.new("ImageLabel")
            SliderIcon.Size = UDim2.new(0, 20, 0, 20)
            SliderIcon.Position = UDim2.new(0, 10, 0, 10)
            SliderIcon.BackgroundTransparency = 1
            SliderIcon.Image = sliderIcon
            SliderIcon.Parent = SliderFrame
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Text = name
            SliderLabel.Size = UDim2.new(1, -80, 0, 30)
            SliderLabel.Position = UDim2.new(0, 40, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.TextColor3 = Config.TextColor
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.GothamSemibold
            SliderLabel.TextSize = 14
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 40, 0, 30)
            ValueLabel.Position = UDim2.new(1, -50, 0, 5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.TextColor3 = Config.TextColor
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.GothamSemibold
            ValueLabel.TextSize = 14
            ValueLabel.Text = tostring(default)
            ValueLabel.Parent = SliderFrame
            
            local SliderBG = Instance.new("Frame")
            SliderBG.Size = UDim2.new(1, -20, 0, 10)
            SliderBG.Position = UDim2.new(0, 10, 0, 45)
            SliderBG.BackgroundColor3 = Config.AccentColor
            SliderBG.BorderSizePixel = 0
            SliderBG.Parent = SliderFrame
            
            local UICornerSlider = Instance.new("UICorner")
            UICornerSlider.CornerRadius = UDim.new(0, 5)
            UICornerSlider.Parent = SliderBG
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Config.ToggleOnColor
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBG
            
            local UICornerFill = Instance.new("UICorner")
            UICornerFill.CornerRadius = UDim.new(0, 5)
            UICornerFill.Parent = SliderFill
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderBG
            
            -- Animación de entrada
            SliderFrame.BackgroundTransparency = 1
            SliderLabel.TextTransparency = 1
            ValueLabel.TextTransparency = 1
            SliderBG.BackgroundTransparency = 1
            SliderFill.BackgroundTransparency = 1
            
            TweenService:Create(SliderFrame, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(SliderLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(ValueLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(SliderBG, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(SliderFill, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            local Value = default
            
            local function UpdateSlider(input)
                local pos = UDim2.new(math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1), 0, 1, 0)
                SliderFill.Size = pos
                
                local value = math.floor(min + ((max - min) * pos.X.Scale))
                Value = value
                ValueLabel.Text = tostring(value)
                
                if callback then
                    callback(value)
                end
            end
            
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    UpdateSlider(input)
                    local connection
                    connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            UpdateSlider(input)
                        end
                    end)
                    
                    game:GetService("UserInputService").InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if connection then
                                connection:Disconnect()
                            end
                        end
                    end)
                end
            end)
            
            local Slider = {
                Instance = SliderFrame,
                SetValue = function(self, value)
                    Value = math.clamp(value, min, max)
                    ValueLabel.Text = tostring(Value)
                    SliderFill.Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
                    if callback then
                        callback(Value)
                    end
                end,
                GetValue = function(self)
                    return Value
                end
            }
            
            return Slider
        end
        
        function Tab:AddButton(name, callback, icon)
            local buttonIcon = icon or IconTypes.Document
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Size = UDim2.new(1, -20, 0, 40)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Parent = TabContent
            
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.BackgroundColor3 = Config.AccentColor
            Button.BorderSizePixel = 0
            Button.Text = ""
            Button.TextColor3 = Config.TextColor
            Button.Font = Enum.Font.GothamSemibold
            Button.TextSize = 14
            Button.ClipsDescendants = true
            Button.Parent = ButtonFrame
            Button.AutoButtonColor = false
            
            local ButtonIcon = Instance.new("ImageLabel")
            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
            ButtonIcon.Position = UDim2.new(0, 10, 0.5, -10)
            ButtonIcon.BackgroundTransparency = 1
            ButtonIcon.Image = buttonIcon
            ButtonIcon.Parent = Button
            
            local ButtonText = Instance.new("TextLabel")
            ButtonText.Text = name
            ButtonText.Size = UDim2.new(1, -50, 1, 0)
            ButtonText.Position = UDim2.new(0, 40, 0, 0)
            ButtonText.BackgroundTransparency = 1
            ButtonText.TextColor3 = Config.TextColor
            ButtonText.TextXAlignment = Enum.TextXAlignment.Left
            ButtonText.Font = Enum.Font.GothamSemibold
            ButtonText.TextSize = 14
            ButtonText.Parent = Button
            
            local UICornerButton = Instance.new("UICorner")
            UICornerButton.CornerRadius = UDim.new(0, 6)
            UICornerButton.Parent = Button
            
            -- Efectos del botón
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Config.ToggleOnColor
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Config.AccentColor
                }):Play()
            end)
            
            Button.MouseButton1Down:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    Size = UDim2.new(0.98, 0, 0.95, 0),
                    Position = UDim2.new(0.01, 0, 0.025, 0)
                }):Play()
                
                -- Efecto de ondas al hacer clic (ripple effect)
                local Circle = Instance.new("Frame")
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 0.7
                Circle.BorderSizePixel = 0
                Circle.Position = UDim2.new(0, Mouse.X - Button.AbsolutePosition.X, 0, Mouse.Y - Button.AbsolutePosition.Y)
                Circle.Size = UDim2.new(0, 0, 0, 0)
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = Circle
                
                Circle.Parent = Button
                
                local Size = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * 2
                
                TweenService:Create(Circle, TweenInfo.new(0.5), {
                    Position = UDim2.new(0.5, -Size/2, 0.5, -Size/2),
                    Size = UDim2.new(0, Size, 0, Size),
                    BackgroundTransparency = 1
                }):Play()
                
                game.Debris:AddItem(Circle, 0.5)
            end)
            
            Button.MouseButton1Up:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0)
                }):Play()
                
                if callback then
                    callback()
                end
            end)
            
            -- Animación de entrada
            Button.BackgroundTransparency = 1
            ButtonText.TextTransparency = 1
            ButtonIcon.ImageTransparency = 1
            
            TweenService:Create(Button, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(ButtonText, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(ButtonIcon, TweenInfo.new(0.5), {
                ImageTransparency = 0
            }):Play()
            
            return Button
        end
        
        function Tab:AddDropdown(name, options, callback, icon)
            local dropIcon = icon or IconTypes.Document
            
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, -20, 0, 40)
            DropdownFrame.BackgroundColor3 = Config.Background
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.ClipsDescendants = true
            DropdownFrame.Parent = TabContent
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Parent = DropdownFrame
            
            local DropdownIcon = Instance.new("ImageLabel")
            DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
            DropdownIcon.Position = UDim2.new(0, 10, 0, 10)
            DropdownIcon.BackgroundTransparency = 1
            DropdownIcon.Image = dropIcon
            DropdownIcon.Parent = DropdownFrame
            
            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Text = name
            DropdownLabel.Size = UDim2.new(1, -80, 0, 40)
            DropdownLabel.Position = UDim2.new(0, 40, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.TextColor3 = Config.TextColor
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Font = Enum.Font.GothamSemibold
            DropdownLabel.TextSize = 14
            DropdownLabel.Parent = DropdownFrame
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(0, 30, 0, 30)
            DropdownButton.Position = UDim2.new(1, -35, 0, 5)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = "▼"
            DropdownButton.TextColor3 = Config.TextColor
            DropdownButton.Font = Enum.Font.GothamSemibold
            DropdownButton.TextSize = 14
            DropdownButton.Parent = DropdownFrame
            
            local DropdownOptionsFrame = Instance.new("Frame")
            DropdownOptionsFrame.Size = UDim2.new(1, -20, 0, #options * 30)
            DropdownOptionsFrame.Position = UDim2.new(0, 10, 0, 45)
            DropdownOptionsFrame.BackgroundColor3 = Config.AccentColor
            DropdownOptionsFrame.BackgroundTransparency = 0.5
            DropdownOptionsFrame.BorderSizePixel = 0
            DropdownOptionsFrame.Visible = false
            DropdownOptionsFrame.Parent = DropdownFrame
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 6)
            OptionsCorner.Parent = DropdownOptionsFrame
            
            local SelectedOption = options[1]
            local IsOpen = false
            
            local function UpdateDropdown()
                if IsOpen then
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, -20, 0, 40 + DropdownOptionsFrame.AbsoluteSize.Y)
                    }):Play()
                    TweenService:Create(DropdownButton, TweenInfo.new(0.3), {
                        Rotation = 180
                    }):Play()
                    DropdownOptionsFrame.Visible = true
                else
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, -20, 0, 40)
                    }):Play()
                    TweenService:Create(DropdownButton, TweenInfo.new(0.3), {
                        Rotation = 0
                    }):Play()
                    DropdownOptionsFrame.Visible = false
                end
            end
            
            -- Crear opciones
            for i, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                OptionButton.BackgroundTransparency = 1
                OptionButton.Text = option
                OptionButton.TextColor3 = Config.TextColor
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.TextSize = 12
                OptionButton.Parent = DropdownOptionsFrame
                
                OptionButton.MouseEnter:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.8
                    }):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                        BackgroundTransparency = 1
                    }):Play()
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    SelectedOption = option
                    DropdownLabel.Text = name .. ": " .. option
                    IsOpen = false
                    UpdateDropdown()
                    
                    if callback then
                        callback(option)
                    end
                end)
            end
            
            DropdownButton.MouseButton1Click:Connect(function()
                IsOpen = not IsOpen
                UpdateDropdown()
            end)
            
            -- Animación de entrada
            DropdownFrame.BackgroundTransparency = 1
            DropdownLabel.TextTransparency = 1
            DropdownButton.TextTransparency = 1
            
            TweenService:Create(DropdownFrame, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(DropdownLabel, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            TweenService:Create(DropdownButton, TweenInfo.new(0.5), {
                TextTransparency = 0
            }):Play()
            
            local Dropdown = {
                Instance = DropdownFrame,
                SetValue = function(self, option)
                    if table.find(options, option) then
                        SelectedOption = option
                        DropdownLabel.Text = name .. ": " .. option
                        
                        if callback then
                            callback(option)
                        end
                    end
                end,
                GetValue = function(self)
                    return SelectedOption
                end,
                Toggle = function(self)
                    IsOpen = not IsOpen
                    UpdateDropdown()
                end,
                AddOption = function(self, option)
                    if not table.find(options, option) then
                        table.insert(options, option)
                        
                        -- Recrear opciones
                        for _, child in pairs(DropdownOptionsFrame:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        for i, opt in ipairs(options) do
                            local OptionButton = Instance.new("TextButton")
                            OptionButton.Size = UDim2.new(1, 0, 0, 30)
                            OptionButton.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                            OptionButton.BackgroundTransparency = 1
                            OptionButton.Text = opt
                            OptionButton.TextColor3 = Config.TextColor
                            OptionButton.Font = Enum.Font.Gotham
                            OptionButton.TextSize = 12
                            OptionButton.Parent = DropdownOptionsFrame
                            
                            OptionButton.MouseButton1Click:Connect(function()
                                SelectedOption = opt
                                DropdownLabel.Text = name .. ": " .. opt
                                IsOpen = false
                                UpdateDropdown()
                                
                                if callback then
                                    callback(opt)
                                end
                            end)
                        end
                        
                        DropdownOptionsFrame.Size = UDim2.new(1, -20, 0, #options * 30)
                    end
                end
            }
            
            return Dropdown
        end
        
        return Tab
    end
    
    function Window:AddLeftGroup(name, icon)
        local groupIcon = icon or IconTypes.Document
        
        local GroupButton = Instance.new("TextButton")
        GroupButton.Size = UDim2.new(1, -10, 0, 40)
        GroupButton.BackgroundColor3 = Config.AccentColor
        GroupButton.TextColor3 = Config.TextColor
        GroupButton.Text = ""
        GroupButton.Font = Enum.Font.GothamSemibold
        GroupButton.TextSize = 14
        GroupButton.Parent = LeftGroup
        GroupButton.BorderSizePixel = 0
        
        local GroupCorner = Instance.new("UICorner")
        GroupCorner.CornerRadius = UDim.new(0, 6)
        GroupCorner.Parent = GroupButton
        
        local GroupIcon = Instance.new("ImageLabel")
        GroupIcon.Size = UDim2.new(0, 20, 0, 20)
        GroupIcon.Position = UDim2.new(0, 10, 0.5, -10)
        GroupIcon.BackgroundTransparency = 1
        GroupIcon.Image = groupIcon
        GroupIcon.Parent = GroupButton
        
        local GroupText = Instance.new("TextLabel")
        GroupText.Text = name
        GroupText.Size = UDim2.new(1, -50, 1, 0)
        GroupText.Position = UDim2.new(0, 40, 0, 0)
        GroupText.BackgroundTransparency = 1
        GroupText.TextColor3 = Config.TextColor
        GroupText.TextXAlignment = Enum.TextXAlignment.Left
        GroupText.Font = Enum.Font.GothamSemibold
        GroupText.TextSize = 14
        GroupText.Parent = GroupButton
        
        -- Efectos de hover para el grupo
        GroupButton.MouseEnter:Connect(function()
            TweenService:Create(GroupButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Config.ToggleOnColor
            }):Play()
        end)
        
        GroupButton.MouseLeave:Connect(function()
            TweenService:Create(GroupButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Config.AccentColor
            }):Play()
        end)
        
        -- Animación de clic
        GroupButton.MouseButton1Down:Connect(function()
            TweenService:Create(GroupButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0.95, 0, 0.95, 0),
                Position = UDim2.new(0.025, 0, 0.025, 0)
            }):Play()
        end)
        
        GroupButton.MouseButton1Up:Connect(function()
            TweenService:Create(GroupButton, TweenInfo.new(0.1), {
                Size = UDim2.new(1, -10, 0, 40),
                Position = UDim2.new(0, 0, 0, 0)
            }):Play()
        end)
        
        -- Animación de entrada
        GroupButton.BackgroundTransparency = 1
        GroupText.TextTransparency = 1
        GroupIcon.ImageTransparency = 1
        
        TweenService:Create(GroupButton, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play()
        
        TweenService:Create(GroupText, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play()
        
        TweenService:Create(GroupIcon, TweenInfo.new(0.5), {
            ImageTransparency = 0
        }):Play()
        
        return GroupButton
    end
    
    function Window:AddRightGroup(name, icon)
        local groupIcon = icon or IconTypes.Document
        
        local GroupFrame = Instance.new("Frame")
        GroupFrame.Size = UDim2.new(1, -10, 0, 100)
        GroupFrame.BackgroundColor3 = Config.AccentColor
        GroupFrame.BorderSizePixel = 0
        GroupFrame.Parent = RightGroup
        
        local GroupCorner = Instance.new("UICorner")
        GroupCorner.CornerRadius = UDim.new(0, 6)
        GroupCorner.Parent = GroupFrame
        
        local GroupTitle = Instance.new("TextLabel")
        GroupTitle.Text = name
        GroupTitle.Size = UDim2.new(1, -40, 0, 30)
        GroupTitle.Position = UDim2.new(0, 40, 0, 0)
        GroupTitle.BackgroundColor3 = Config.Background
        GroupTitle.BackgroundTransparency = 1
        GroupTitle.BorderSizePixel = 0
        GroupTitle.TextColor3 = Config.TextColor
        GroupTitle.TextXAlignment = Enum.TextXAlignment.Left
        GroupTitle.Font = Enum.Font.GothamSemibold
        GroupTitle.TextSize = 14
        GroupTitle.Parent = GroupFrame
        
        local GroupIcon = Instance.new("ImageLabel")
        GroupIcon.Size = UDim2.new(0, 20, 0, 20)
        GroupIcon.Position = UDim2.new(0, 10, 0, 5)
        GroupIcon.BackgroundTransparency = 1
        GroupIcon.Image = groupIcon
        GroupIcon.Parent = GroupFrame
        
        local GroupContent = Instance.new("Frame")
        GroupContent.Size = UDim2.new(1, 0, 1, -30)
        GroupContent.Position = UDim2.new(0, 0, 0, 30)
        GroupContent.BackgroundTransparency = 1
        GroupContent.Parent = GroupFrame
        
        local GroupLayout = Instance.new("UIListLayout")
        GroupLayout.Padding = UDim.new(0, 5)
        GroupLayout.SortOrder = Enum.SortOrder.LayoutOrder
        GroupLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        GroupLayout.Parent = GroupContent
        
        -- Animación de entrada
        GroupFrame.BackgroundTransparency = 1
        GroupTitle.TextTransparency = 1
        GroupIcon.ImageTransparency = 1
        
        TweenService:Create(GroupFrame, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play()
        
        TweenService:Create(GroupTitle, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play()
        
        TweenService:Create(GroupIcon, TweenInfo.new(0.5), {
            ImageTransparency = 0
        }):Play()
        
        local Group = {
            Instance = GroupFrame,
            Content = GroupContent,
            AddButton = function(self, name, callback, icon)
                local buttonIcon = icon or IconTypes.Document
                
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, -20, 0, 30)
                Button.BackgroundColor3 = Config.Background
                Button.BorderSizePixel = 0
                Button.TextColor3 = Config.TextColor
                Button.Font = Enum.Font.GothamSemibold
                Button.TextSize = 12
                Button.Text = ""
                Button.Parent = GroupContent
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button
                
                local ButtonIcon = Instance.new("ImageLabel")
                ButtonIcon.Size = UDim2.new(0, 16, 0, 16)
                ButtonIcon.Position = UDim2.new(0, 5, 0.5, -8)
                ButtonIcon.BackgroundTransparency = 1
                ButtonIcon.Image = buttonIcon
                ButtonIcon.Parent = Button
                
                local ButtonText = Instance.new("TextLabel")
                ButtonText.Text = name
                ButtonText.Size = UDim2.new(1, -30, 1, 0)
                ButtonText.Position = UDim2.new(0, 25, 0, 0)
                ButtonText.BackgroundTransparency = 1
                ButtonText.TextColor3 = Config.TextColor
                ButtonText.TextXAlignment = Enum.TextXAlignment.Left
                ButtonText.Font = Enum.Font.Gotham
                ButtonText.TextSize = 12
                ButtonText.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Config.ToggleOnColor
                    }):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Config.Background
                    }):Play()
                end)
                
                Button.MouseButton1Click:Connect(function()
                    if callback then
                        callback()
                    end
                end)
                
                return Button
            end,
            AddToggle = function(self, name, default, callback)
                -- Código similar al toggle normal pero adaptado al grupo
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
                ToggleFrame.BackgroundColor3 = Config.Background
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Parent = GroupContent
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 4)
                ToggleCorner.Parent = ToggleFrame
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Text = name
                ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.TextColor3 = Config.TextColor
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.TextSize = 12
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("Frame")
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
                ToggleButton.BackgroundColor3 = Config.AccentColor
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Parent = ToggleFrame
                
                local ToggleCornerBtn = Instance.new("UICorner")
                ToggleCornerBtn.CornerRadius = UDim.new(0, 10)
                ToggleCornerBtn.Parent = ToggleButton
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleCircle.BackgroundColor3 = Config.TextColor
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Parent = ToggleButton
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = ToggleCircle
                
                local Enabled = default or false
                
                local function UpdateToggle()
                    if Enabled then
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
                            BackgroundColor3 = Config.ToggleOnColor
                        }):Play()
                        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {
                            Position = UDim2.new(0, 22, 0.5, -8)
                        }):Play()
                    else
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
                            BackgroundColor3 = Config.AccentColor
                        }):Play()
                        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {
                            Position = UDim2.new(0, 2, 0.5, -8)
                        }):Play()
                    end
                    
                    if callback then
                        callback(Enabled)
                    end
                end
                
                ToggleButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Enabled = not Enabled
                        UpdateToggle()
                    end
                end)
                
                ToggleCircle.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Enabled = not Enabled
                        UpdateToggle()
                    end
                end)
                
                UpdateToggle()
                
                local Toggle = {
                    Instance = ToggleFrame,
                    SetValue = function(self, value)
                        Enabled = value
                        UpdateToggle()
                    end,
                    GetValue = function(self)
                        return Enabled
                    end
                }
                
                return Toggle
            end
        }
        
        return Group
    end
    
    if #Tabs > 0 then
        TabButtons[1].BackgroundColor3 = Config.ToggleOnColor
        Tabs[1].Visible = true
        SelectedTab = 1
    end
    
    return Window
end

-- Mouse para efectos de botones
local Mouse = game.Players.LocalPlayer:GetMouse()

return Library
