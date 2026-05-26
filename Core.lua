-- Core.lua - Blox Fruits Hub (FIXED QUEST DETECTION)
local Core = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Remotes
local Remotes = {
    CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"),
    CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
}

-- World Detection
local World1, World2, World3 = false, false, false

-- Settings
local Settings = {
    AutoFarm = false,
    AutoQuest = true,
    FastAttack = false,
    AutoHaki = false,
    BringMob = true,
    Weapon = "Melee",
    NoClip = false,
    AutoStats = false,
    StatType = "Melee",
    TweenToIsland = false,
    SelectedIsland = nil
}

local CurrentTween = nil

-- Initialize
function Core:Init()
    if game.PlaceId == 2753915549 then
        World1 = true
        print("World 1 Detected")
    elseif game.PlaceId == 4442272183 then
        World2 = true
        print("World 2 Detected")
    elseif game.PlaceId == 7449423635 then
        World3 = true
        print("World 3 Detected")
    end
    
    LocalPlayer.CharacterAdded:Connect(function(char)
        Character = char
        Humanoid = char:WaitForChild("Humanoid")
        HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    end)
    
    self:StartLoops()
    print("Blox Fruits Hub Loaded Successfully!")
end

-- Anti AFK
spawn(function()
    while true do
        task.wait(300)
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- NO CLIP
function Core:UpdateNoClip()
    if Settings.NoClip and Character then
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end

-- LEVEL DETECTION (Fixed)
function Core:GetLevel()
    return LocalPlayer.Data.Level.Value
end

-- QUEST CHECKING (Fixed based on your test code)
function Core:GetActiveQuest()
    local mainGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
    local questGui = mainGui and mainGui:FindFirstChild("Quest")
    
    if not questGui or not questGui.Visible then 
        return nil 
    end
    
    local questData = {
        MonsterName = nil,
        CurrentKills = 0,
        MaxKills = 0
    }
    
    -- Parse quest text: "Defeat 8 Cocoa Warriors (0/8)"
    for _, child in ipairs(questGui:GetDescendants()) do
        if child:IsA("TextLabel") then
            -- Try different patterns
            local count, name, current, max = string.match(child.Text, "Defeat (%d+) (.-) %((%d+)/(%d+)%)")
            if name then
                questData.MonsterName = name
                questData.CurrentKills = tonumber(current)
                questData.MaxKills = tonumber(max)
                return questData
            end
        end
    end
    
    return nil
end

function Core:HasQuest()
    return self:GetActiveQuest() ~= nil
end

-- SEA 3 QUEST DATA ONLY (For testing)
function Core:GetQuestData()
    local Level = self:GetLevel()
    
    if World3 then
        if Level >= 1500 and Level <= 1524 then
            return {Mon = "Pirate Millionaire", LevelQuest = 1, NameQuest = "PiratePortQuest", CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984), CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)}
        elseif Level >= 1525 and Level <= 1574 then
            return {Mon = "Pistol Billionaire", LevelQuest = 2, NameQuest = "PiratePortQuest", NameMon = "Pistol Billionaire", CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984), CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)}
        elseif Level >= 1575 and Level <= 1599 then
            return {Mon = "Dragon Crew Warrior", LevelQuest = 1, NameQuest = "AmazonQuest", NameMon = "Dragon Crew Warrior", CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51562), CFrameMon = CFrame.new(6221.52197265625, 51.68061065673828, -1683.949951171875)}
        elseif Level >= 1600 and Level <= 1624 then
            return {Mon = "Dragon Crew Archer", LevelQuest = 2, NameQuest = "AmazonQuest", NameMon = "Dragon Crew Archer", CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51562), CFrameMon = CFrame.new(6667.09716796875, 403.51629638671875, -729.3095703125)}
        elseif Level >= 1625 and Level <= 1649 then
            return {Mon = "Female Islander", LevelQuest = 1, NameQuest = "AmazonQuest2", NameMon = "Female Islander", CFrameQuest = CFrame.new(5448.93115, 601.649963, 751.131958), CFrameMon = CFrame.new(4696.0888671875, 735.9605102539062, 1669.56640625)}
        elseif Level >= 1650 and Level <= 1699 then
            return {Mon = "Giant Islander", LevelQuest = 2, NameQuest = "AmazonQuest2", NameMon = "Giant Islander", CFrameQuest = CFrame.new(5448.93115, 601.649963, 751.131958), CFrameMon = CFrame.new(4888.53125, 652.9526977539062, 1444.47265625)}
        elseif Level >= 1700 and Level <= 1724 then
            return {Mon = "Marine Commodore", LevelQuest = 1, NameQuest = "MarineTreeIsland", NameMon = "Marine Commodore", CFrameQuest = CFrame.new(2180.54126, 28.2316393, -6281.91699), CFrameMon = CFrame.new(2498.33935546875, 190.23890686035156, -7165.31005859375)}
        elseif Level >= 1725 and Level <= 1774 then
            return {Mon = "Marine Rear Admiral", LevelQuest = 2, NameQuest = "MarineTreeIsland", NameMon = "Marine Rear Admiral", CFrameQuest = CFrame.new(2180.54126, 28.2316393, -6281.91699), CFrameMon = CFrame.new(2498.33935546875, 190.23890686035156, -7165.31005859375)}
        elseif Level >= 1775 and Level <= 1799 then
            return {Mon = "Fishman Raider", LevelQuest = 1, NameQuest = "DeepForestIsland3", NameMon = "Fishman Raider", CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652), CFrameMon = CFrame.new(-10533.7705078125, 331.7626647949219, -8654.29296875)}
        elseif Level >= 1800 and Level <= 1824 then
            return {Mon = "Fishman Captain", LevelQuest = 2, NameQuest = "DeepForestIsland3", NameMon = "Fishman Captain", CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652), CFrameMon = CFrame.new(-10876.0390625, 331.7626647949219, -8759.5947265625)}
        elseif Level >= 1825 and Level <= 1849 then
            return {Mon = "Forest Pirate", LevelQuest = 1, NameQuest = "DeepForestIsland", NameMon = "Forest Pirate", CFrameQuest = CFrame.new(-13234.165, 332.378052, -7625.40137), CFrameMon = CFrame.new(-13225.681640625, 428.1938781738281, -7758.15625)}
        elseif Level >= 1850 and Level <= 1899 then
            return {Mon = "Mythological Pirate", LevelQuest = 2, NameQuest = "DeepForestIsland", NameMon = "Mythological Pirate", CFrameQuest = CFrame.new(-13234.165, 332.378052, -7625.40137), CFrameMon = CFrame.new(-13869.2216796875, 453.95343017578125, -9893.0498046875)}
        elseif Level >= 1900 and Level <= 1924 then
            return {Mon = "Jungle Pirate", LevelQuest = 1, NameQuest = "DeepForestIsland2", NameMon = "Jungle Pirate", CFrameQuest = CFrame.new(-12680.3818, 389.791931, -9902.01953), CFrameMon = CFrame.new(-11975.634765625, 331.7626647949219, -10053.19921875)}
        elseif Level >= 1925 and Level <= 1974 then
            return {Mon = "Musketeer Pirate", LevelQuest = 2, NameQuest = "DeepForestIsland2", NameMon = "Musketeer Pirate", CFrameQuest = CFrame.new(-12680.3818, 389.791931, -9902.01953), CFrameMon = CFrame.new(-11314.1669921875, 520.7034301757812, -10610.521484375)}
        elseif Level >= 1975 and Level <= 1999 then
            return {Mon = "Reborn Skeleton", LevelQuest = 1, NameQuest = "HauntedQuest1", NameMon = "Reborn Skeleton", CFrameQuest = CFrame.new(-9479.2168, 142.130844, 5566.0918), CFrameMon = CFrame.new(-8761.58984375, 191.1676025390625, 6168.03125)}
        elseif Level >= 2000 and Level <= 2024 then
            return {Mon = "Living Zombie", LevelQuest = 2, NameQuest = "HauntedQuest1", NameMon = "Living Zombie", CFrameQuest = CFrame.new(-9479.2168, 142.130844, 5566.0918), CFrameMon = CFrame.new(-10144.7607421875, 140.94931030273438, 5983.23046875)}
        elseif Level >= 2025 and Level <= 2049 then
            return {Mon = "Demonic Soul", LevelQuest = 1, NameQuest = "HauntedQuest2", NameMon = "Demonic Soul", CFrameQuest = CFrame.new(-9516.2627, 178.79451, 6078.45996), CFrameMon = CFrame.new(-9701.615234375, 204.69522094726562, 6042.61279296875)}
        elseif Level >= 2050 and Level <= 2074 then
            return {Mon = "Posessed Mummy", LevelQuest = 2, NameQuest = "HauntedQuest2", NameMon = "Posessed Mummy", CFrameQuest = CFrame.new(-9516.2627, 178.79451, 6078.45996), CFrameMon = CFrame.new(-9701.615234375, 204.69522094726562, 6042.61279296875)}
        elseif Level >= 2075 and Level <= 2099 then
            return {Mon = "Peanut Scout", LevelQuest = 1, NameQuest = "NutsIslandQuest", NameMon = "Peanut Scout", CFrameQuest = CFrame.new(-2104.39062, 38.1041679, -10194.2188), CFrameMon = CFrame.new(-2095.8095703125, 192.6106414794922, -10252.4609375)}
        elseif Level >= 2100 and Level <= 2124 then
            return {Mon = "Peanut President", LevelQuest = 2, NameQuest = "NutsIslandQuest", NameMon = "Peanut President", CFrameQuest = CFrame.new(-2104.39062, 38.1041679, -10194.2188), CFrameMon = CFrame.new(-1876.642578125, 194.45343017578125, -10545.548828125)}
        elseif Level >= 2125 and Level <= 2149 then
            return {Mon = "Ice Cream Chef", LevelQuest = 1, NameQuest = "IceCreamIslandQuest", NameMon = "Ice Cream Chef", CFrameQuest = CFrame.new(-820.648254, 37.8186607, -10965.8359), CFrameMon = CFrame.new(-890.9402465820312, 186.72894287109375, -11127.306640625)}
        elseif Level >= 2150 and Level <= 2199 then
            return {Mon = "Ice Cream Commander", LevelQuest = 2, NameQuest = "IceCreamIslandQuest", NameMon = "Ice Cream Commander", CFrameQuest = CFrame.new(-820.648254, 37.8186607, -10965.8359), CFrameMon = CFrame.new(-890.9402465820312, 186.72894287109375, -11127.306640625)}
        elseif Level >= 2200 and Level <= 2224 then
            return {Mon = "Cookie Crafter", LevelQuest = 1, NameQuest = "CakeQuest1", NameMon = "Cookie Crafter", CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295), CFrameMon = CFrame.new(-2358.543212890625, 192.6106414794922, -12148.916015625)}
        elseif Level >= 2225 and Level <= 2249 then
            return {Mon = "Cake Guard", LevelQuest = 2, NameQuest = "CakeQuest1", NameMon = "Cake Guard", CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295), CFrameMon = CFrame.new(-1500.79052734375, 194.41064453125, -11446.662109375)}
        elseif Level >= 2250 and Level <= 2274 then
            return {Mon = "Baking Staff", LevelQuest = 1, NameQuest = "CakeQuest2", NameMon = "Baking Staff", CFrameQuest = CFrame.new(-1927.91064, 37.7981339, -12843.7852), CFrameMon = CFrame.new(-1886.18701171875, 192.6106414794922, -12984.5390625)}
        elseif Level >= 2275 and Level <= 2299 then
            return {Mon = "Head Baker", LevelQuest = 2, NameQuest = "CakeQuest2", NameMon = "Head Baker", CFrameQuest = CFrame.new(-1927.91064, 37.7981339, -12843.7852), CFrameMon = CFrame.new(-2216.92724609375, 192.6106414794922, -12985.833984375)}
        elseif Level >= 2300 and Level <= 2324 then
            return {Mon = "Cocoa Warrior", LevelQuest = 1, NameQuest = "ChocQuest1", NameMon = "Cocoa Warrior", CFrameQuest = CFrame.new(233.228516, 29.8760014, -12201.2334), CFrameMon = CFrame.new(21.745283126831055, 80.57499694824219, -12352.240234375)}
        elseif Level >= 2325 and Level <= 2349 then
            return {Mon = "Chocolate Bar Battler", LevelQuest = 2, NameQuest = "ChocQuest1", NameMon = "Chocolate Bar Battler", CFrameQuest = CFrame.new(233.228516, 29.8760014, -12201.2334), CFrameMon = CFrame.new(582.0524291992188, 77.1630859375, -12463.1669921875)}
        elseif Level >= 2350 and Level <= 2374 then
            return {Mon = "Sweet Thief", LevelQuest = 1, NameQuest = "ChocQuest2", NameMon = "Sweet Thief", CFrameQuest = CFrame.new(150.506424, 30.293663, -12774.5029), CFrameMon = CFrame.new(-134.5806884765625, 77.1630859375, -12880.470703125)}
        elseif Level >= 2375 and Level <= 2399 then
            return {Mon = "Candy Rebel", LevelQuest = 2, NameQuest = "ChocQuest2", NameMon = "Candy Rebel", CFrameQuest = CFrame.new(150.506424, 30.293663, -12774.5029), CFrameMon = CFrame.new(-134.5806884765625, 77.1630859375, -12880.470703125)}
        elseif Level >= 2400 and Level <= 2424 then
            return {Mon = "Candy Pirate", LevelQuest = 1, NameQuest = "CandyQuest1", NameMon = "Candy Pirate", CFrameQuest = CFrame.new(-1150.04004, 20.3789349, -14446.3691), CFrameMon = CFrame.new(-1310.5001220703125, 26.85352325439453, -14562.755859375)}
        elseif Level >= 2425 and Level <= 2449 then
            return {Mon = "Snow Conjurer", LevelQuest = 2, NameQuest = "CandyQuest1", NameMon = "Snow Conjurer", CFrameQuest = CFrame.new(-1150.04004, 20.3789349, -14446.3691), CFrameMon = CFrame.new(-1310.5001220703125, 26.85352325439453, -14562.755859375)}
        elseif Level >= 2450 then
            return {Mon = "Isle Outlaw", LevelQuest = 1, NameQuest = "TikiQuest1", NameMon = "Isle Outlaw", CFrameQuest = CFrame.new(-16547.748, 61.1353683, -180.214249), CFrameMon = CFrame.new(-16442.521484375, 96.65082550048828, -269.1958923339844)}
        end
    end
    
    return nil
end

-- Tween Function
function Core:TweenTo(cf, speed)
    if CurrentTween then
        CurrentTween:Cancel()
    end
    
    local dist = (cf.Position - HumanoidRootPart.Position).Magnitude
    local tweenSpeed = speed or (dist / 300)
    
    CurrentTween = TweenService:Create(HumanoidRootPart, TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {CFrame = cf})
    CurrentTween:Play()
    
    return CurrentTween
end

-- Find Enemy
function Core:FindEnemy(name)
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    return nil
end

-- Bring Mobs
function Core:BringMobs()
    pcall(function()
        local questData = self:GetQuestData()
        if not questData then return end
        
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == questData.Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                if v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < 300 then
                    v.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -20)
                    v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                    v.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end)
end

-- Equip Tool
function Core:EquipTool(toolType)
    pcall(function()
        for _, v in pairs(Character:GetChildren()) do
            if v:IsA("Tool") then
                if toolType == "Melee" and (v.Name == "Combat" or v.ToolTip == "Melee") then
                    Humanoid:EquipTool(v)
                elseif toolType == "Sword" and v.ToolTip == "Sword" then
                    Humanoid:EquipTool(v)
                elseif toolType == "Gun" and v.ToolTip == "Gun" then
                    Humanoid:EquipTool(v)
                elseif toolType == "Blox Fruit" and v.ToolTip == "Blox Fruit" then
                    Humanoid:EquipTool(v)
                end
            end
        end
    end)
end

-- Check if quest matches current level
function Core:IsCorrectQuest()
    local activeQuest = self:GetActiveQuest()
    local questData = self:GetQuestData()
    
    if not activeQuest or not questData then return false end
    
    -- Check if monster name matches
    return activeQuest.MonsterName == questData.Mon
end

-- Auto Farm Logic (Fixed)
function Core:DoAutoFarm()
    local questData = self:GetQuestData()
    if not questData then 
        print("No quest data for level:", self:GetLevel())
        return 
    end
    
    print("Target mob:", questData.Mon)
    
    -- Check and take quest
    if Settings.AutoQuest then
        if not self:HasQuest() then
            print("No quest active, taking quest...")
            -- Teleport to quest giver
            self:TweenTo(questData.CFrameQuest, 0.5)
            task.wait(0.6)
            
            -- Start quest
            local success = pcall(function()
                Remotes.CommF_:InvokeServer("StartQuest", questData.NameQuest, questData.LevelQuest)
            end)
            if success then print("Quest taken") end
            task.wait(0.3)
        else
            -- Check if we have the right quest
            if not self:IsCorrectQuest() then
                print("Wrong quest, getting new one...")
                local success = pcall(function()
                    Remotes.CommF_:InvokeServer("StartQuest", questData.NameQuest, questData.LevelQuest)
                end)
                task.wait(0.3)
            else
                print("Correct quest active")
            end
        end
    end
    
    -- Find and attack enemy
    local enemy = self:FindEnemy(questData.Mon)
    if enemy then
        print("Found enemy:", enemy.Name)
        
        -- Tween to enemy
        self:TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0), 0.3)
        
        -- Attack
        if Settings.FastAttack then
            pcall(function()
                Remotes.CommF_:InvokeServer("Attack", true)
            end)
        end
        
        -- Bring mobs
        if Settings.BringMob then
            self:BringMobs()
        end
        
        -- Auto Haki
        if Settings.AutoHaki then
            if not Character:FindFirstChild("HasBuso") then
                Remotes.CommF_:InvokeServer("Buso")
            end
        end
        
        -- Equip weapon
        self:EquipTool(Settings.Weapon)
    else
        -- No enemy found, go to spawn location
        print("No enemy found, going to spawn...")
        self:TweenTo(questData.CFrameMon, 0.5)
    end
end

-- Main Loops
function Core:StartLoops()
    -- Auto Farm Loop
    task.spawn(function()
        while true do
            task.wait(0.1)
            if Settings.AutoFarm then
                pcall(function()
                    self:DoAutoFarm()
                end)
            end
        end
    end)
    
    -- Fast Attack Loop
    task.spawn(function()
        while true do
            task.wait(0.1)
            if Settings.FastAttack and Settings.AutoFarm then
                pcall(function()
                    Remotes.CommF_:InvokeServer("Attack", true)
                end)
            end
        end
    end)
    
    -- Auto Stats Loop
    task.spawn(function()
        while true do
            task.wait(1)
            if Settings.AutoStats and Settings.StatType then
                pcall(function()
                    Remotes.CommF_:InvokeServer("AddPoint", Settings.StatType, 1)
                end)
            end
        end
    end)
    
    -- Auto Haki Loop
    task.spawn(function()
        while true do
            task.wait(3)
            if Settings.AutoHaki then
                pcall(function()
                    if not Character:FindFirstChild("HasBuso") then
                        Remotes.CommF_:InvokeServer("Buso")
                    end
                end)
            end
        end
    end)
    
    -- Bring Mob Loop
    task.spawn(function()
        while true do
            task.wait(0.5)
            if Settings.BringMob and Settings.AutoFarm then
                pcall(function()
                    self:BringMobs()
                end)
            end
        end
    end)
    
    -- No Clip Loop
    task.spawn(function()
        while true do
            task.wait(0.1)
            if Settings.NoClip then
                pcall(function()
                    self:UpdateNoClip()
                end)
            end
        end
    end)
end

-- Settings Functions
function Core:SetAutoFarm(value)
    Settings.AutoFarm = value
    print("Auto Farm:", value)
end

function Core:SetAutoQuest(value)
    Settings.AutoQuest = value
end

function Core:SetFastAttack(value)
    Settings.FastAttack = value
end

function Core:SetAutoHaki(value)
    Settings.AutoHaki = value
end

function Core:SetBringMob(value)
    Settings.BringMob = value
end

function Core:SetNoClip(value)
    Settings.NoClip = value
end

function Core:SetAutoStats(value)
    Settings.AutoStats = value
end

function Core:SetStatType(value)
    Settings.StatType = value
end

function Core:SetWeapon(value)
    Settings.Weapon = value
end

-- Teleport Functions
function Core:SetSelectedIsland(value)
    Settings.SelectedIsland = value
end

function Core:GetSelectedIsland()
    return Settings.SelectedIsland
end

function Core:IsTweenEnabled()
    return Settings.TweenToIsland
end

function Core:TweenToIsland(value)
    Settings.TweenToIsland = value
end

-- Island CFrames
local IslandLocations = {
    ["Starter Island"] = CFrame.new(1041.60803, 16.4550056, 1427.32788),
    ["Marine Start"] = CFrame.new(-2577.21118, 6.88819456, -2044.46521),
    ["Middle Town"] = CFrame.new(-655.970886, 7.87804699, 1509.74121),
    ["Jungle"] = CFrame.new(-1499.04285, 22.8779125, 349.74231),
    ["Pirate Village"] = CFrame.new(-1142.45349, 4.78799629, 3829.66626),
    ["Desert"] = CFrame.new(1094.14502, 6.47301674, 4231.43311),
    ["Frozen Village"] = CFrame.new(1196.48816, 27.0074673, -1218.20569),
    ["Marine Fortress"] = CFrame.new(-4833.0249, 20.6520329, 4256.0332),
    ["Skylands"] = CFrame.new(-4967.83691, 717.671326, -2623.84326),
    ["Prison"] = CFrame.new(4854.4585, 5.67397165, 636.706055),
    ["Colosseum"] = CFrame.new(-1427.72754, 7.28907394, -3014.50342),
    ["Magma Village"] = CFrame.new(-5245.24805, 12.2589903, 8452.47461),
    ["Fishman Island"] = CFrame.new(61123.6523, 18.4736748, 1569.39966),
    ["Sky Castle"] = CFrame.new(-7894.61768, 5547.1416, -380.291199),
    ["Fountain City"] = CFrame.new(5259.81982, 37.3500175, 4050.0293)
}

function Core:GetIslandCFrame(islandName)
    return IslandLocations[islandName]
end

function Core:TweenToPosition(islandName)
    local cf = self:GetIslandCFrame(islandName)
    if cf then
        self:TweenTo(cf, 1)
    end
end

function Core:InstantTeleport(islandName)
    local cf = self:GetIslandCFrame(islandName)
    if cf then
        HumanoidRootPart.CFrame = cf
    end
end

-- Return the module
return Core
