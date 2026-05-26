-- UI.lua - Fixed UI Framework with Draggable Window
local UI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function UI:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxFruitsUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Window Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "Main"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -277, 0.5, -176)
    MainFrame.Size = UDim2.new(0, 555, 0, 352)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame
    
    -- Top Bar (Draggable)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.Active = true
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 6)
    TopBarCorner.Parent = TopBar
    
    -- Fix corners
    local TopBarFix = Instance.new("Frame")
    TopBarFix.Parent = TopBar
    TopBarFix.BackgroundColor3 = TopBar.BackgroundColor3
    TopBarFix.BorderSizePixel = 0
    TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarFix.Size = UDim2.new(1, 0, 0.5, 0)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title .. " // Premium"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = TopBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.Size = UDim2.new(0, 35, 1, 0)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.TextSize = 16
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Drag Functionality
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Tab Container (Left Side)
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 35)
    TabContainer.Size = UDim2.new(0, 140, 1, -35)
    
    local TabContainerCorner = Instance.new("UICorner")
    TabContainerCorner.CornerRadius = UDim.new(0, 6)
    TabContainerCorner.Parent = TabContainer
    
    local TabFix = Instance.new("Frame")
    TabFix.Parent = TabContainer
    TabFix.BackgroundColor3 = TabContainer.BackgroundColor3
    TabFix.BorderSizePixel = 0
    TabFix.Position = UDim2.new(0.5, 0, 0, 0)
    TabFix.Size = UDim2.new(0.5, 0, 1, 0)
    
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Parent = TabContainer
    TabList.Active = true
    TabList.BackgroundTransparency = 1
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.ScrollBarThickness = 2
    TabList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabList
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    
    -- Page Container (Right Side)
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = MainFrame
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 140, 0, 35)
    PageContainer.Size = UDim2.new(1, -140, 1, -35)
    
    local PageFolder = Instance.new("Folder")
    PageFolder.Name = "Pages"
    PageFolder.Parent = PageContainer
    
    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.TweenTime = 0.3
    UIPageLayout.FillDirection = Enum.FillDirection.Vertical
    UIPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local Window = {}
    local Tabs = {}
    local TabCount = 0
    
    function Window:addtab(name)
        TabCount = TabCount + 1
        
        -- Tab Button
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = name .. "Tab"
        TabBtn.Parent = TabList
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 60)
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(1, -10, 0, 32)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 12
        TabBtn.Text = "  " .. name
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.AutoButtonColor = false
        
        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 4)
        TabBtnCorner.Parent = TabBtn
        
        -- Page
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "_Page"
        Page.Parent = PageFolder
        Page.Active = true
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 10)
        PagePadding.PaddingBottom = UDim.new(0, 10)
        PagePadding.PaddingLeft = UDim.new(0, 10)
        PagePadding.PaddingRight = UDim.new(0, 10)
        
        -- Tab Click Handler
        local function SelectTab()
            for _, child in pairs(TabList:GetDescendants()) do
                if child:IsA("TextButton") then
                    TweenService:Create(child, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 55, 60)}):Play()
                    TweenService:Create(child, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(189, 52, 235)}):Play()
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            UIPageLayout:JumpTo(Page)
        end
        
        TabBtn.MouseButton1Click:Connect(SelectTab)
        
        -- Select first tab by default
        if TabCount == 1 then
            wait(0.1)
            SelectTab()
        end
        
        -- Tab Object
        local Tab = {}
        
        function Tab:addButton(text, callback)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Parent = Page
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Size = UDim2.new(1, 0, 0, 38)
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = ButtonFrame
            
            local TextBtn = Instance.new("TextButton")
            TextBtn.Name = "TextBtn"
            TextBtn.Parent = ButtonFrame
            TextBtn.BackgroundTransparency = 1
            TextBtn.Size = UDim2.new(1, 0, 1, 0)
            TextBtn.Font = Enum.Font.GothamSemibold
            TextBtn.Text = text
            TextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBtn.TextSize = 13
            
            -- Hover effect
            TextBtn.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 60, 65)}):Play()
            end)
            
            TextBtn.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 50, 55)}):Play()
            end)
            
            TextBtn.MouseButton1Click:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0, 38)}):Play()
                wait(0.05)
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 38)}):Play()
                if callback then callback() end
            end)
        end
        
        function Tab:addToggle(text, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 4)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 13
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Toggle Button
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleFrame
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Position = UDim2.new(1, -55, 0.5, -10)
            ToggleBtn.Size = UDim2.new(0, 45, 0, 20)
            ToggleBtn.Text = ""
            ToggleBtn.AutoButtonColor = false
            
            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(0, 10)
            ToggleBtnCorner.Parent = ToggleBtn
            
            -- Circle
            local Circle = Instance.new("Frame")
            Circle.Name = "Circle"
            Circle.Parent = ToggleBtn
            Circle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            Circle.BorderSizePixel = 0
            Circle.Position = UDim2.new(0, 2, 0.5, -8)
            Circle.Size = UDim2.new(0, 16, 0, 16)
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = Circle
            
            local enabled = default or false
            
            local function UpdateToggle()
                if enabled then
                    TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 27, 0.5, -8)}):Play()
                    TweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(189, 52, 235)}):Play()
                else
                    TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
                    TweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 35, 40)}):Play()
                end
                if callback then callback(enabled) end
            end
            
            ToggleBtn.MouseButton1Click:Connect(function()
                enabled = not enabled
                UpdateToggle()
            end)
            
            UpdateToggle()
        end
        
        function Tab:addDropdown(text, options, callback)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Parent = Page
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.ClipsDescendants = true
            DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 4)
            DropdownCorner.Parent = DropdownFrame
            
            local DropTitle = Instance.new("TextLabel")
            DropTitle.Name = "DropTitle"
            DropTitle.Parent = DropdownFrame
            DropTitle.BackgroundTransparency = 1
            DropTitle.Position = UDim2.new(0, 15, 0, 0)
            DropTitle.Size = UDim2.new(0.8, 0, 0, 40)
            DropTitle.Font = Enum.Font.GothamSemibold
            DropTitle.Text = text
            DropTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropTitle.TextSize = 13
            DropTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local DropArrow = Instance.new("TextLabel")
            DropArrow.Parent = DropdownFrame
            DropArrow.BackgroundTransparency = 1
            DropArrow.Position = UDim2.new(1, -35, 0, 0)
            DropArrow.Size = UDim2.new(0, 30, 0, 40)
            DropArrow.Font = Enum.Font.GothamBold
            DropArrow.Text = "▼"
            DropArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
            DropArrow.TextSize = 12
            
            local DropScroll = Instance.new("ScrollingFrame")
            DropScroll.Name = "DropScroll"
            DropScroll.Parent = DropdownFrame
            DropScroll.Active = true
            DropScroll.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
            DropScroll.BorderSizePixel = 0
            DropScroll.Position = UDim2.new(0, 5, 0, 42)
            DropScroll.Size = UDim2.new(1, -10, 0, 0)
            DropScroll.ScrollBarThickness = 2
            DropScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
            DropScroll.Visible = false
            
            local DropList = Instance.new("UIListLayout")
            DropList.Parent = DropScroll
            DropList.SortOrder = Enum.SortOrder.LayoutOrder
            DropList.Padding = UDim.new(0, 3)
            
            local isOpen = false
            
            for _, option in ipairs(options) do
                local Item = Instance.new("TextButton")
                Item.Name = "Item"
                Item.Parent = DropScroll
                Item.BackgroundTransparency = 1
                Item.Size = UDim2.new(1, 0, 0, 28)
                Item.Font = Enum.Font.GothamSemibold
                Item.Text = "  " .. tostring(option)
                Item.TextColor3 = Color3.fromRGB(200, 200, 200)
                Item.TextSize = 12
                Item.TextXAlignment = Enum.TextXAlignment.Left
                
                Item.MouseButton1Click:Connect(function()
                    isOpen = false
                    TweenService:Create(DropArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    DropScroll.Visible = false
                    DropTitle.Text = text .. ": " .. Item.Text
                    if callback then callback(Item.Text) end
                end)
                
                Item.MouseEnter:Connect(function()
                    TweenService:Create(Item, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(Item, TweenInfo.new(0.2), {BackgroundTransparency = 0.9}):Play()
                end)
                
                Item.MouseLeave:Connect(function()
                    TweenService:Create(Item, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                    TweenService:Create(Item, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                end)
            end
            
            DropScroll.CanvasSize = UDim2.new(0, 0, 0, #options * 31)
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Parent = DropdownFrame
            ToggleBtn.BackgroundTransparency = 1
            ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
            ToggleBtn.Text = ""
            
            ToggleBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    local contentHeight = math.min(#options * 31, 120)
                    DropScroll.Size = UDim2.new(1, -10, 0, contentHeight)
                    DropScroll.Visible = true
                    TweenService:Create(DropArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 45 + contentHeight)}):Play()
                else
                    TweenService:Create(DropArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    wait(0.2)
                    DropScroll.Visible = false
                end
            end)
        end
        
        table.insert(Tabs, Tab)
        return Tab
    end
    
    return Window
end

return UI
