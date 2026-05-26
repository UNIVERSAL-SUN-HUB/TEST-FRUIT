-- Core.lua - Game Logic and Features
local Core = {}
local UI = nil

-- World Detection
local World1 = false
local World2 = false  
local World3 = false

-- Configuration
_G.AutoFarm = false
_G.AutoQuest = false
_G.AutoStats = false
_G.FastAttack = false
_G.AutoHaki = false
_G.SafeFarm = true

-- Initialize World
function Core:Init()
    if game.PlaceId == 2753915549 then
        World1 = true
    elseif game.PlaceId == 4442272183 then
        World2 = true
    elseif game.PlaceId == 7449423635 then
        World3 = true
    end
    
    -- Anti-Cheat Bypass
    self:SetupBypass()
    
    -- Safe Farm Setup
    self:SetupSafeFarm()
end

function Core:SetupUI(Tabs, UILib)
    UI = UILib
    
    -- Settings Tab
    Tabs.Settings:addToggle("Safe Farm Mode", true, function(value)
        _G.SafeFarm = value
        if not value then
            game.Players.LocalPlayer:Kick("Please don't turn off safe farm if you don't want to get banned")
        end
    end)
    
    Tabs.Settings:addToggle("Anti AFK", true, function(value)
        _G.AntiAFK = value
    end)
    
    Tabs.Settings:addButton("FPS Boost", function()
        self:FPSBoost()
    end)
    
    -- Main Farm Tab
    Tabs.Main:addToggle("Auto Farm Level", false, function(value)
        _G.AutoFarm = value
        if value then
            self:StartAutoFarm()
        end
    end)
    
    Tabs.Main:addToggle("Auto Quest", true, function(value)
        _G.AutoQuest = value
    end)
    
    Tabs.Main:addToggle("Fast Attack", false, function(value)
        _G.FastAttack = value
    end)
    
    Tabs.Main:addDropdown("Farm Mode", {"Level Farm", "Mastery Farm", "Boss Farm"}, function(selected)
        _G.FarmMode = selected
    end)
    
    -- Auto Stats Tab
    Tabs.Stats:addToggle("Auto Stats", false, function(value)
        _G.AutoStats = value
        if value then
            self:AutoStats()
        end
    end)
    
    Tabs.Stats:addDropdown("Stat Type", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, function(selected)
        _G.StatType = selected
    end)
    
    -- Teleport Tab
    Tabs.Teleport:addButton("Teleport to Sea 1", function()
        self:TeleportSea(1)
    end)
    
    Tabs.Teleport:addButton("Teleport to Sea 2", function()
        self:TeleportSea(2)
    end)
    
    Tabs.Teleport:addButton("Teleport to Sea 3", function()
        self:TeleportSea(3)
    end)
    
    -- Misc Tab
    Tabs.Misc:addButton("Rejoin Server", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
    
    Tabs.Misc:addButton("Server Hop", function()
        self:ServerHop()
    end)
    
    Tabs.Misc:addToggle("No Clip", false, function(value)
        _G.NoClip = value
    end)
    
    Tabs.Misc:addToggle("Infinite Jump", false, function(value)
        _G.InfiniteJump = value
        if value then
            game:GetService("UserInputService").JumpRequest:connect(function()
                game.Players.LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end)
        end
    end)
end

-- Quest Detection
function Core:CheckQuest()
    local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    local QuestData = {}
    
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 then
            QuestData = {
                Mon = "Bandit",
                LevelQuest = 1,
                NameQuest = "BanditQuest1",
                NameMon = "Bandit",
                CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231),
                CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
            }
        elseif MyLevel >= 10 and MyLevel <= 14 then
            QuestData = {
                Mon = "Monkey",
                LevelQuest = 1,
                NameQuest = "JungleQuest",
                NameMon = "Monkey",
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
            }
        -- Add more levels as needed...
        elseif MyLevel >= 650 then
            QuestData = {
                Mon = "Galley Captain",
                LevelQuest = 2,
                NameQuest = "FountainQuest",
                NameMon = "Galley Captain",
                CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293),
                CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
            }
        end
    elseif World2 then
        -- World 2 Quests
        if MyLevel >= 700 and MyLevel <= 724 then
            QuestData = {
                Mon = "Raider",
                LevelQuest = 1,
                NameQuest = "Area1Quest",
                NameMon = "Raider",
                CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188),
                CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
            }
        end
        -- Add more World 2 levels...
    elseif World3 then
        -- World 3 Quests  
        if MyLevel >= 1500 and MyLevel <= 1524 then
            QuestData = {
                Mon = "Pirate Millionaire",
                LevelQuest = 1,
                NameQuest = "PiratePortQuest",
                NameMon = "Pirate Millionaire",
                CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984),
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            }
        end
        -- Add more World 3 levels...
    end
    
    return QuestData
end

-- Auto Farm Function
function Core:StartAutoFarm()
    spawn(function()
        while _G.AutoFarm do
            wait()
            local QuestData = self:CheckQuest()
            
            if QuestData.NameQuest and _G.AutoQuest then
                -- Check if quest is active
                local questActive = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                
                if not questActive then
                    -- Get Quest
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestData.NameQuest, QuestData.LevelQuest)
                end
                
                -- Teleport to mob
                if QuestData.CFrameMon then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = QuestData.CFrameMon
                end
                
                -- Attack logic here
                self:AttackMob(QuestData.NameMon)
            end
        end
    end)
end

function Core:AttackMob(monsterName)
    -- Attack logic
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v.Name == monsterName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            repeat
                wait()
                if _G.FastAttack then
                    -- Fast attack logic
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack", true)
                end
            until v.Humanoid.Health <= 0 or not _G.AutoFarm
        end
    end
end

-- Auto Stats
function Core:AutoStats()
    spawn(function()
        while _G.AutoStats do
            wait(1)
            if _G.StatType then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.StatType, 1)
            end
        end
    end)
end

-- Teleport Functions
function Core:TeleportSea(seaNumber)
    if seaNumber == 1 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    elseif seaNumber == 2 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    elseif seaNumber == 3 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
end

-- Server Hop
function Core:ServerHop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" then
            foundAnything = Site.nextPageCursor
        end
        
        for _, v in pairs(Site.data) do
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                table.insert(AllIDs, v.id)
                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, v.id, game.Players.LocalPlayer)
                wait(0.1)
            end
        end
    end
    
    TPReturner()
end

-- Anti-Cheat Bypass
function Core:SetupBypass()
    if getrawmetatable and setreadonly and newcclosure then
        local grm = getrawmetatable(game)
        setreadonly(grm, false)
        local old = grm.__namecall
        grm.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = tostring(args[1])
            
            if method == "TeleportDetect" or 
               method == "CHECKER_1" or 
               method == "CHECKER" or 
               method == "GUI_CHECK" or 
               method == "OneMoreTime" or 
               method == "checkingSPEED" or 
               method == "BANREMOTE" or 
               method == "PERMAIDBAN" or 
               method == "KICKREMOTE" or 
               method == "BR_KICKPC" or 
               method == "BR_KICKMOBILE" then
                return
            end
            
            return old(self, ...)
        end)
    end
end

-- Safe Farm Setup
function Core:SetupSafeFarm()
    spawn(function()
        while _G.SafeFarm do
            wait(1)
            for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                if v:IsA("LocalScript") then
                    if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" or 
                       v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or 
                       v.Name == "Looking" or v.Name == "Run" then
                        v:Destroy()
                    end
                end
            end
            
            for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
                if v:IsA("LocalScript") then
                    if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes" or
                       v.Name == "CustomForceField" or v.Name == "MenuBloodSp" or v.Name == "PlayerList" then
                        v:Destroy()
                    end
                end
            end
        end
    end)
end

-- FPS Boost
function Core:FPSBoost()
    local decalsyeeted = false
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    
    for _, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        end
    end
    
    for _, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end

return Core
