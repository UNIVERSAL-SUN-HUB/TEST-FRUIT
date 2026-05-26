-- UI.lua - Custom UI Library Module
local UI = {}

function UI:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxFruitsUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "Main"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(41, 53, 61)
    MainFrame.Position = UDim2.new(0.5, -277, 0.5, -176)
    MainFrame.Size = UDim2.new(0, 555, 0, 352)
    MainFrame.ClipsDescendants = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = MainFrame
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "Top"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(126, 165, 191)
    TopBar.Size = UDim2.new(0, 556, 0, 30)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 30, 0.05, 0)
    Title.Size = UDim2.new(0, 255, 0.05, 25)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title .. " // Premium"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 14, 0, 33)
    TabContainer.Size = UDim2.new(0, 138, 0, 307)
    
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Parent = TabContainer
    TabList.Active = true
    TabList.BackgroundTransparency = 1
    TabList.Size = UDim2.new(0, 138, 0, 307)
    TabList.ScrollBarThickness = 0
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    
    -- Page Container
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = MainFrame
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 162, 0, 33)
    PageContainer.Size = UDim2.new(0, 380, 0, 308)
    
    local PageFolder = Instance.new("Folder")
    PageFolder.Name = "Pages"
    PageFolder.Parent = PageContainer
    
    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.TweenTime = 0.4
    
    local Window = {}
    local Tabs = {}
    
    function Window:addtab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = name .. "Tab"
        TabBtn.Parent = TabList
        TabBtn.BackgroundColor3 = Color3.fromRGB(41, 53, 61)
        TabBtn.BackgroundTransparency = 0.8
        TabBtn.Size = UDim2.new(0, 136, 0, 30)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.TextSize = 12
        TabBtn.Text = "| " .. name
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 5)
        TabCorner.Parent = TabBtn
        
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "_Page"
        Page.Parent = PageFolder
        Page.Active = true
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(0, 380, 0, 307)
        Page.ScrollBarThickness = 0
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 5)
        
        TabBtn.MouseButton1Click:Connect(function()
            UIPageLayout:JumpTo(Page)
        end)
        
        local Tab = {}
        
        function Tab:addButton(text, callback)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Parent = Page
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Size = UDim2.new(0, 358, 0, 33)
            
            local TextBtn = Instance.new("TextButton")
            TextBtn.Name = "TextBtn"
            TextBtn.Parent = ButtonFrame
            TextBtn.BackgroundColor3 = Color3.fromRGB(41, 53, 61)
            TextBtn.BackgroundTransparency = 0.8
            TextBtn.Size = UDim2.new(0, 379, 0, 33)
            TextBtn.Font = Enum.Font.GothamSemibold
            TextBtn.Text = text
            TextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBtn.TextSize = 15
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 5)
            BtnCorner.Parent = TextBtn
            
            TextBtn.MouseButton1Click:Connect(function()
                TextBtn.TextSize = 0
                game:GetService("TweenService"):Create(TextBtn, TweenInfo.new(0.4), {TextSize = 15}):Play()
                if callback then callback() end
            end)
        end
        
        function Tab:addToggle(text, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(41, 53, 61)
            ToggleFrame.BackgroundTransparency = 0.8
            ToggleFrame.Size = UDim2.new(0, 379, 0, 46)
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 40, 0, 0)
            ToggleLabel.Size = UDim2.new(0, 280, 0, 46)
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.Text = "|  " .. text
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 15
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleFrame
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            ToggleBtn.BackgroundTransparency = 0.1
            ToggleBtn.Position = UDim2.new(0, 320, 0, 13)
            ToggleBtn.Size = UDim2.new(0, 45, 0, 20)
            ToggleBtn.Text = ""
            
            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(0, 10)
            ToggleBtnCorner.Parent = ToggleBtn
            
            local Circle = Instance.new("Frame")
            Circle.Name = "Circle"
            Circle.Parent = ToggleBtn
            Circle.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            Circle.BackgroundTransparency = 0.7
            Circle.Position = UDim2.new(0, 2, 0, 2)
            Circle.Size = UDim2.new(0, 16, 0, 16)
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(0, 10)
            CircleCorner.Parent = Circle
            
            local enabled = default or false
            
            ToggleBtn.MouseButton1Click:Connect(function()
                enabled = not enabled
                if enabled then
                    Circle:TweenPosition(UDim2.new(0, 27, 0, 2), "Out", "Sine", 0.2, true)
                    game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(189, 52, 235)}):Play()
                else
                    Circle:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Sine", 0.2, true)
                    game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(12, 12, 12)}):Play()
                end
                if callback then callback(enabled) end
            end)
            
            if default then
                Circle:TweenPosition(UDim2.new(0, 27, 0, 2), "Out", "Sine", 0.2, true)
                game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(189, 52, 235)}):Play()
            end
        end
        
        function Tab:addDropdown(text, options, callback)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Parent = Page
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(41, 53, 61)
            DropdownFrame.BackgroundTransparency = 0.8
            DropdownFrame.ClipsDescendants = true
            DropdownFrame.Size = UDim2.new(0, 379, 0, 38)
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 3)
            DropdownCorner.Parent = DropdownFrame
            
            local DropTitle = Instance.new("TextLabel")
            DropTitle.Name = "DropTitle"
            DropTitle.Parent = DropdownFrame
            DropTitle.BackgroundTransparency = 1
            DropTitle.Size = UDim2.new(0, 379, 0, 38)
            DropTitle.Font = Enum.Font.GothamSemibold
            DropTitle.Text = "| " .. text
            DropTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropTitle.TextSize = 15
            DropTitle.TextXAlignment = Enum.TextXAlignment.Left
            DropTitle.Position = UDim2.new(0, 40, 0, 0)
            
            local DropScroll = Instance.new("ScrollingFrame")
            DropScroll.Name = "DropScroll"
            DropScroll.Parent = DropdownFrame
            DropScroll.Active = true
            DropScroll.BackgroundColor3 = Color3.fromRGB(13, 102, 158)
            DropScroll.BackgroundTransparency = 0.1
            DropScroll.BorderSizePixel = 0
            DropScroll.Position = UDim2.new(0, 2, 0, 40)
            DropScroll.Size = UDim2.new(0, 375, 0, 100)
            DropScroll.ScrollBarThickness = 3
            
            local DropList = Instance.new("UIListLayout")
            DropList.Parent = DropScroll
            DropList.SortOrder = Enum.SortOrder.LayoutOrder
            DropList.Padding = UDim.new(0, 5)
            
            local isOpen = false
            
            for _, option in ipairs(options) do
                local Item = Instance.new("TextButton")
                Item.Name = "Item"
                Item.Parent = DropScroll
                Item.BackgroundTransparency = 1
                Item.Size = UDim2.new(0, 379, 0, 26)
                Item.Font = Enum.Font.GothamSemibold
                Item.Text = tostring(option)
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 12
                Item.TextTransparency = 0.5
                
                Item.MouseButton1Click:Connect(function()
                    isOpen = false
                    DropdownFrame:TweenSize(UDim2.new(0, 379, 0, 38), "Out", "Quad", 0.3, true)
                    DropTitle.Text = "| " .. text .. " : " .. Item.Text
                    if callback then callback(Item.Text) end
                end)
            end
            
            DropScroll.CanvasSize = UDim2.new(0, 0, 0, DropList.AbsoluteContentSize.Y + 10)
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Parent = DropdownFrame
            ToggleBtn.BackgroundTransparency = 1
            ToggleBtn.Size = UDim2.new(0, 379, 0, 38)
            ToggleBtn.Text = ""
            
            ToggleBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    DropdownFrame:TweenSize(UDim2.new(0, 379, 0, 142), "Out", "Quad", 0.3, true)
                else
                    DropdownFrame:TweenSize(UDim2.new(0, 379, 0, 38), "Out", "Quad", 0.3, true)
                end
            end)
        end
        
        table.insert(Tabs, Tab)
        return Tab
    end
    
    return Window
end

return UI
