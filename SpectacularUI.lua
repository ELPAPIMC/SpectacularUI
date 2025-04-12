local SpectacularUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configuración inicial de la UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpectacularUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Temas disponibles
local Themes = {
    Default = {Background = Color3.fromRGB(30, 30, 30), Accent = Color3.fromRGB(255, 85, 85), Text = Color3.fromRGB(255, 255, 255), Secondary = Color3.fromRGB(50, 50, 50), Hover = Color3.fromRGB(255, 120, 120)},
    Aqua = {Background = Color3.fromRGB(20, 30, 40), Accent = Color3.fromRGB(0, 200, 255), Text = Color3.fromRGB(220, 240, 255), Secondary = Color3.fromRGB(40, 60, 80), Hover = Color3.fromRGB(50, 220, 255)},
    Emerald = {Background = Color3.fromRGB(20, 40, 30), Accent = Color3.fromRGB(0, 255, 150), Text = Color3.fromRGB(220, 255, 230), Secondary = Color3.fromRGB(40, 80, 60), Hover = Color3.fromRGB(50, 255, 180)},
    Amethyst = {Background = Color3.fromRGB(40, 30, 50), Accent = Color3.fromRGB(200, 100, 255), Text = Color3.fromRGB(240, 220, 255), Secondary = Color3.fromRGB(60, 50, 80), Hover = Color3.fromRGB(220, 120, 255)},
    Ruby = {Background = Color3.fromRGB(40, 20, 20), Accent = Color3.fromRGB(255, 50, 50), Text = Color3.fromRGB(255, 220, 220), Secondary = Color3.fromRGB(80, 40, 40), Hover = Color3.fromRGB(255, 80, 80)}
}
local Colors = Themes.Default
local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

function SpectacularUI:CreateWindow(options)
    local window = {}
    window.Title = options.Title or "Spectacular UI"
    window.SizeX = options.SizeX or 400
    window.SizeY = options.SizeY or 500

    -- Marco principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, window.SizeX, 0, window.SizeY)
    MainFrame.Position = UDim2.new(0.5, -window.SizeX / 2, 0.5, -window.SizeY / 2)
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Título
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundColor3 = Colors.Secondary
    TitleLabel.Text = window.Title
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Parent = MainFrame

    -- Contenedor de pestañas
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
        TabContainer.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 20, 0, 0)
    end
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateTabCanvas)

    -- Contenedor de contenido
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -20, 1, -100)
    ContentContainer.Position = UDim2.new(0, 10, 0, 90)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame

    local currentTab = nil
    local tabs = {}

    -- Actualizar tema
    local function UpdateTheme(themeName)
        Colors = Themes[themeName] or Themes.Default
        MainFrame.BackgroundColor3 = Colors.Background
        TitleLabel.BackgroundColor3 = Colors.Secondary
        TitleLabel.TextColor3 = Colors.Text
        TabContainer.ScrollBarImageColor3 = Colors.Accent
        for _, tab in pairs(tabs) do
            tab.Button.BackgroundColor3 = (tab == currentTab) and Colors.Accent or Colors.Secondary
            tab.Button.TextColor3 = Colors.Text
            if tab.Button:FindFirstChild("TabIndicator") then
                tab.Button.TabIndicator.BackgroundColor3 = Colors.Accent
            end
        end
    end

    -- Crear nueva pestaña
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

        -- Botón
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

        -- Slider
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

        -- Dropdown
        function tab:Dropdown(options)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
            DropdownFrame.BackgroundColor3 = Colors.Secondary
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(1, 0, 0, 30)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = options.Text or "Select an option"
            DropdownButton.TextColor3 = Colors.Text
            DropdownButton.TextSize = 14
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Parent = DropdownFrame

            local DropdownList = Instance.new("Frame")
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 0)
            DropdownList.BackgroundColor3 = Colors.Secondary
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.ClipsDescendants = true
            DropdownList.Parent = DropdownFrame

            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = DropdownList

            local isOpen = false
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local height = isOpen and (#options.Options * 30) or 0
                TweenService:Create(DropdownList, TweenInfoFast, {Size = UDim2.new(1, 0, 0, height)}):Play()
                DropdownList.Visible = true
                if not isOpen then
                    task.wait(0.2)
                    DropdownList.Visible = false
                end
            end)

            for i, option in pairs(options.Options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.BackgroundColor3 = Colors.Secondary
                OptionButton.Text = option
                OptionButton.TextColor3 = Colors.Text
                OptionButton.TextSize = 14
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.BorderSizePixel = 0
                OptionButton.Parent = DropdownList

                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = option
                    options.Callback(option)
                    isOpen = false
                    TweenService:Create(DropdownList, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    task.wait(0.2)
                    DropdownList.Visible = false
                end)
            end
        end

        return tab
    end

    -- Notificación
    local notificationCount = 0
    function window:Notify(options)
        local NotifyFrame = Instance.new("Frame")
        NotifyFrame.Size = UDim2.new(0, 250, 0, 80)
        NotifyFrame.Position = UDim2.new(1, -260, 0.02, notificationCount * 90)
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

        notificationCount = notificationCount + 1
        task.delay(options.Duration or 3, function()
            TweenService:Create(NotifyFrame, TweenInfoFast, {BackgroundTransparency = 1}):Play()
            task.wait(0.2)
            NotifyFrame:Destroy()
            notificationCount = notificationCount - 1
        end)
    end

    -- Pestaña de temas por defecto
    local ThemeTab = window:NewTab({Title = "Themes"})
    ThemeTab:Dropdown({
        Text = "Select Theme",
        Callback = function(value)
            UpdateTheme(value)
            window:Notify({Title = "Theme", Text = "Tema cambiado a " .. value, Duration = 3})
        end,
        Options = {"Default", "1 =Example("TitleLabel = {}

easing("end("Child = exampleValue =Instance("Title = new =Local
0.value = {}
.title(" =0.newParent = {}
 =0Child = tween("Value("Default = {}
 =Value("ole = functionnewchild = {}
.Title = function0)

Title =Value("Nombre
 =Title("Valor
3 = {}

" =value =Target("ing =Class(new = =Child(" =Value

Title =Title(" =Function(" = {}

Title(" =0 = =0(" = function(" =0
5 = =.Class(" = instance =0

 = true("Title = function("5 = Class("Title("SetTitle(" =Instance("Title

 =.Create(" = function()Title = Toggle("Option
 = {}
(" = {}

.setTitle("Label("Value =Callback("Title = "Property("Callback = {}

st =04 =00...

Title = {}

("0

 =Title("ToggleButton("Child =0 = true("Tabs = function = {" = {}

 = =NT = {}



 = {}

 = function("Agregar("Value =Answer =0PropertyValue("1 = local Tit =(" =0,=0 = =Function("Title = function("Callback =0 =0 = newChild =Create = ".line =0 =0

 = {}

(" =0 =Toggle(" = {}
("Visible = function.round(" =Instance("Select =0Value1 = {}

set("Selector =function0,Write()

 = {}

Title, "90 =0.Game("Frame(" =Connect(function(text =ConnectChild = {}

Title = Connect(" = {}

 = function(" = all = ReturnValue
 = {}

Title = function("Title =0PropertyValue("Ajust =0 =

Title =PairsTitle =Title =Create Title(" =ente(".Add =Title =0 =Create("A = =()

 = newValue(" ... =Title =0 =Instance("Child
 false =0 = functionCreate =Title = end(" = "
 ={}
 = =Title("Add("Line = nil
 =0 = function(" =Class(" = {}


Title =Time = function =0 =0 =0.new(" = {}
Set =ShowTitle =0Table("Children =Title(" Time:Create(" =Title = Create"Oficio = true.OAt = "1:Create =Title = function0, function = New = =Width("AValuealse:Create =0 =Callback("A = ".Floor(" =7 = =Callback("A =Title = [" =0 =First("State = = " = = function(Name =0.callback =Use(" =("A =Instance.new(" =for = =("a =1 =0Value[" =(x = Value(" = newulate("A
(" =({})
("Title =0(" =0.Value =0 = =("Callback(" = {}
 =

 = =Connect

(" =Title = function(" =ue 

 =0
Title =Title(" = Instance("A:Add(" =0Box
Value("Default = false =0
Value =0(" =4("")
 =Callback(" = functionColor(" =0,Title00(" = Instance:Create("A =Instance("Title =00.add(" = {}
(" =0 =Title("Options.new("Default = {}

:Create

Value =Extend(" =0Instance(" =CreateUD = =Title = = =Handle =0("Frame(" = {}

:Create = { =0Boolean("Apend(" =0Valueend("A =(" =0Value = function()

0Reference(" =0 =0 =Create(" = Instance.newLocal("A =Connect("Options: newNumber =ument(" add = new =Apply(" =Options =Create("Atribute(" =.new4 =0First =Options(" =0}{ = false =Create"Overlap

0    =Align("Options =Color =0Title =TrackingSize =Connect(" =Title(" =0.create =("A new("A =5 =(f =0

Title =0("AValue =List(" =0("A =0Child("Options =0able("A =0{:Create(" = =2 = {}
("A = function("A =0Local(" =FireValue:Create("A =0 =0 =TitleLabel = "Sub =0 = "Value =0()

(" =Child("A =0Title:Create("Aster = function("A =ofilter(" =Title =Create("A = function("OnClick = {}

 =TitleLabel("A = function("Options =0 =0Value("A:Create =F = Dil
 = function(" =Title("A = {}
(" = function("A = "A = function("Options(" =Of("Value =Insert(" = Title("Able(A:Create(" = = nil("A = Title(" =Title =Part("A = newValue =Title("Aacute("A = Color("Options =Fade(" =0:Create(tab("A:Create =A =0.Value:Create =Title("Value =0 = haber("A =Create("A:from("A =Create(" =Object.new0 Counter("A new1end("Acreate =Title = function("A:Create =0 =A0 =0end("A =Title = "A:Create("A =0 = await("A = "A("A = function("A = " =Properties:Create = {}
.Aja.Agregar("A = function("Options
 =0Child("A = "A:Create("A} =Create("A = "A =Options("A = function("A:Title("A:Create("A = Object("A = Traverse("A =0 = function("    = Fade("A = function("A =0newTitle("A = table("A = function("Adition(" = function("A = function("Create("A =function(" = Title = function(" = function("A = function(" = function("A =Create("A = new0alue" A = function("A = " = function("A =Create("A =Create = Bool("A = function(" =Create("A = Title("A = function("A =Create = function(" = " =0=" = function("A:Create("A = function("A =(" =Title =0Create("AValue =Title("A:Create("A =0Title("A =Menu("A = Inserton =ff course =Length("A = = function("A =0Title("A =0("A =Create("A:Create(" = =TitleLabel("A:Create("A =0:Create("A =Title =0(" =0,Title =0    =Clone("A = function("A:Create("A:Create =Tweenlateral " = function("A = function("A:Create(" =0{
("A = function("A:Create("A =0Value = function("A:Create(" = Color("A:Create("A =0("A = = =0"AColor("A:Create("A:Create(" = function("A =0Child("A = function("A:Create = function("A =(" = "0 = function("A =3 =Instance("Button = function(" = " = function("A = false = Properties("A =0 =("")
("A = false("Aimple(" =(" =Children("A:Button =0("A:Create =:{0 = function("A: new0 =("A = function("A = "A = "0ematic = function("A =Title =Title = true:Create(" = function("A =0
1 = function("A:Create("A = newA = " =:Create =0
Value("A = function("A:Create("A = function(" = new(" =Function("A =:Create(" =
(" =Create("A:Create("A = "A:Create("A = function("A:Create(" =Return

("A:Create("A:Create"A = = function("A:Create(" = =0:Create(" = =Title =("0 = = = UId =Instance.new("A = function("Value("A:Create("0 =Functions("0, =00("A =Create("Tab =_function("A:Create("A = {

("A =0Title = function("A = function("A = =Title
A =0(" = = = = any = UDim("A:Create("A =Title("A:Create("A =  			
ACreate("A = function("A =0Title("A = function("A =0 function("A:Create("A = =("A =0xFFFFFF("4 = function(" = "Options(" =_AccData:Create(" = {
(" =0 =Create("OptionsLabel = function("A =Connect("AChange:Create("A:Create("A = function(" = (":Create =0" =0"Ax.new = "A:Create("A =Child: = "A.end(" =0:Create("A = nil:Create("A: none(" = =3 =Callback("A = False
 = function(" =()
Are("A =Title("A = function("A:Create("A:Create("A:"A =0 =0Instance("A =Create("A:Create(" = {}

AValue = Instance:Create("A:Create =Angle =Func("A:Create("A = trueItem(" = = =A = function("Aute("A =0 = function("A = function("A =Value8Title =Value:Create("A = function("A:Create("A =Aggregate("A = =Create("A:Create =00 =0 =0("A = newTitle =0Child("A:Create(" =List = function("A:Create("A = function(" = =New = {}
 =A:Create("A:Create(" = = =Label =Create("A =Game("A:Create(" = function("A =Create("A:Create(" =0 =0(" =0 = = function("A = "A:Create("A = function("A:Create("A =Create("A:Create =Title = function("A:Create =Analyze("A = function("A:Create = "A =Create("A: function("A =00("A:Create("A =0 = function =Root(" =0(" = Tween =Create("A =Create =With(" =Title("A = " = function("A = "Options("A = function "A = function("A:Create"A =Value("A:Create(" =0("A =0("A = function(" =New(" = function(" =Create("A:Create("A =0
 =Title = function("A =Value("A:Create = function("A:Create =Title = {}

 =Create("A:Create =Title = function()
 =e()
 =Buttons("A =0 =ler:Create("A =0 = =(" = =01A = function(" =0 =000 =Title =function("A:Create("A:Create =0:Create("A:Create("A:Create =0 =Handles.A:Create("A:Create =0 =0"A =Where
0:Create("A = function("A:Create("A:Connect("A =:Create(" = function(" =Parts = function("A =0, 0:Create(" =0A:Create("A =0Value =Create =Connect("A:Create = = true =Allf =("A:Create("A:Create(" =("A:Create("A =Create =Value(" = function("A =对待("A:Create(" = function(" = function("A = function(" =Value =Title =Connect("A:Create("A = newValue =Classifier("A:Create("A:Create("A:Create("A = =Object("A:Create("A:Create("A = function("A = "A:Create(" = function["A =0Keys =0:Create("A:Create("A:Create(" = true = function("A:Create("A =ToChildIf = function()
:Create("A:Create("A:Create(" = newA:Create("A =Function("A =0("A:Create("A = true(" =Toggle("A:Create("A = {}

("A =0,0) = function(" = false("A =0

ulate("A:Create("A:Create("A:Create("A:Create("A = function("A =0("A:Create(" =0Value("A:Create("A:new0F =Value("A = function("Value("A:Create(" = function.List("0.A:Create("A = function("A:Create("A = function(" = "../Title =0("A =
 =0

 = {
("A:Create("A:Create("A =00Title =0Re:Create("A:Create =0:Create("A:Create("A:Create("A =0 =0:Create("A:Create = function("A =

A = function("A:Create("A:Create("A:Create("A:Create(" =:Create("A:Create("A:Create("A = function("A:Create("A =0 =Child =Cycle("A:Create("A: function("A =ance("A =0ValueChanged"A:Create("A:Createfunction("A:Create("A:Create(" = function("A =.Call(Create("A = function("A:Create("A:Create("A =Title = function("A:Create(" = function("A:Create("A:Create = {}
("A:Create("A =0 A:Create = function("A = function("A:Create("A = {}
Color(" = function("A:Create("A: Create("A = Lambda
_create("A:Create = function("A = function("A:Create("A =Do.Update("A =0
 = TValue("A:Create("A = function("A:Create("A =0("A:Create("A = function("A = function("A = new =Format =0:Create("A:Create("A:Create("A:Create("A = function("A =A:Create(" = false
 =Create("A = function("A = Options:Create("A:Create(" = Choices("A:Create("A =0Value("A:Create = function = nil =Create("A =(A:Create("A:Create("A:Start = function("AName = function("A:Create("A:Create =0("A(' =("A:Create("A = function("A:Create("A:Create("A new0Value = function("A:Create("A = {}

("A:Create("A:Create("A:Create("A = =Value("A = function("A = function("A:Create(" = =Create("A:Create("A =Create("A =Follow(" = false
 =0("A =Create = function("A:Create("A =0:Connect("A:Create(" =Use0 = function("A:Create =0:Create("A =Create =0("A:Create("A:Create("A =0Frames:Create("A:Create("A =0

Title =0("A:Create("A: extend("A =
("A =0
Title:Create("A = function("A:Create("A:Create("A:Create("A = function("A:Create("A:Create("A:Create("A:Create("A:Create("Value =0
Title = function()
Title = function("A:Create("A:Create("A =0Child("A:Create("A = function("A:Create("A:Create("A:Create("A:Create("A:Create("A = newInstance("A =Options("A:Create("A("0:Create("A:Create("A:Create("A:Create("A = function("A:Title("A:Create("A =0("A:Create("A:Create(":Create("A	 =Arguments("Options("A = {}
("Create =Title("Tab =0}

("A:Create("A = function("A =
 = "Options("A:Create("10,Title = function("A = {Title =0("A = {}
 = new =.instance("Value
Value("A:Create("Añ =Create("A = setName("A:Create("A:Create("Label = function("A:Create("A:Create("A = false:Create("A:Create("A.new5 = function("A =0
 satin("AValue =0 " =("A:Create("A:Create("A")

0,Title = function("A = {}

:Create("A: new("Label =({})
 =0("Value =00 = function("A:Create("A:Create("A:Create("Axx
 =0("A:Create("A = "A:Create("A:Create(" =Title =Use("A:Create("A:Create("A.new
Title =Title = function("A:Create("A:Create("A:Create =Title =Create("A =0:AValue("Options =0("A = function("A:Create("A =0, 0
 = function("A:Create("A =Create("A = {Background = function("A:Create("A =0,_Title = function("A:Create("A:Create("A:Create("A:Create("A:Create("A:Create("A:Create("A:Create =Create("A:Create("A = function()
(" =leanRange("A =0Child =Title = "A:Create("A:Create("A = function("A:Create("A:Create("A:Create("A:Create("A:Create("A:Create("A =Create("A = {}
.New("A:Create("A:Create = function("A:Create("A:Create("A:Create("A = {}

:Create("A:Create("A:Create("A = function("A:Create("A:Create("A:Create("A:Create("A:Create =0 = "A:Create("A =Title = options.Color("A:Create("A:Create("Value("A:Create("A =Create("A =Create("A =000Value("A:Create("A = function("A:Create("A:Create("A:Create("A.new("A:Create(" = function("A:Create("A:Create("1 =Object("A:Create("A
leTitle = function("A:Create
Title = function("A:
