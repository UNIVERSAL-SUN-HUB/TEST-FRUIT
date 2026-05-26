-- Core.lua - Blox Fruits Hub (FIXED VERSION)
local Core = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Remotes (Auto-detected)
local Remotes = {
    CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"),
    CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE"),
    Attack = nil -- Will detect
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
    FarmMode = "Level Farm",
    Weapon = "Melee",
    SafeFarm = true,
    AutoStats = false,
    StatType = "Melee",
    AutoSeaBeast = false,
    AutoRaid = false,
    AutoAwaken = false,
    RaidType = "Flame",
    AutoFarmFruit = false,
    AutoStoreFruit = false,
    NoClip = false,
    ESP = {
        Player = false,
        Fruit = false,
        Chest = false,
        Flower = false,
        Mob = false
    }
}

-- Connections
local Connections = {}
local ESPObjects = {}
local CurrentTween = nil

-- Initialize
function Core:Init()
    -- Detect World
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
    
    -- Setup Character
    LocalPlayer.CharacterAdded:Connect(function(char)
        Character = char
        Humanoid = char:WaitForChild("Humanoid")
        HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
        if Settings.NoClip then
            self:SetupNoClip()
        end
    end)
    
    -- Setup Bypasses
    self:SetupBypass()
    
    -- Start Loops
    self:StartLoops()
    
    print("Blox Fruits Hub Loaded Successfully!")
end

-- Setup Bypasses
function Core:SetupBypass()
    -- Anti Cheat Bypass
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "Kick" then
            return wait(9e9)
        end
        
        return old(self, ...)
    end)
    
    setreadonly(mt, true)
    
    -- Disable some detection
    for _, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
        v:Disable()
    end
end

-- Quest Data (Complete for all levels)
function Core:GetQuestData()
    local Level = LocalPlayer.Data.Level.Value
    
    if World1 then
        if Level >= 1 and Level <= 9 then
            return {Mon = "Bandit", LevelQuest = 1, NameQuest = "BanditQuest1", NameMon = "Bandit", CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231), CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)}
        elseif Level >= 10 and Level <= 14 then
            return {Mon = "Monkey", LevelQuest = 1, NameQuest = "JungleQuest", NameMon = "Monkey", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)}
        elseif Level >= 15 and Level <= 29 then
            return {Mon = "Gorilla", LevelQuest = 2, NameQuest = "JungleQuest", NameMon = "Gorilla", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-112.20606231689453, 40.5460319519043, -671.4652099609375)}
        elseif Level >= 30 and Level <= 39 then
            return {Mon = "Pirate", LevelQuest = 1, NameQuest = "BuggyQuest1", NameMon = "Pirate", CFrameQuest = CFrame.new(-1141.07483, 4.1000198, 3831.5498), CFrameMon = CFrame.new(-1201.8880615234375, 4.75205135345459, 3915.201416015625)}
        elseif Level >= 40 and Level <= 59 then
            return {Mon = "Brute", LevelQuest = 2, NameQuest = "BuggyQuest1", NameMon = "Brute", CFrameQuest = CFrame.new(-1141.07483, 4.1000198, 3831.5498), CFrameMon = CFrame.new(-1147.395751953125, 14.809885025024414, 4322.35009765625)}
        elseif Level >= 60 and Level <= 74 then
            return {Mon = "Desert Bandit", LevelQuest = 1, NameQuest = "DesertQuest", NameMon = "Desert Bandit", CFrameQuest = CFrame.new(894.488647, 5.85000658, 4392.43359), CFrameMon = CFrame.new(924.9287719726562, 6.4485554695129395, 4481.58544921875)}
        elseif Level >= 75 and Level <= 89 then
            return {Mon = "Desert Officer", LevelQuest = 2, NameQuest = "DesertQuest", NameMon = "Desert Officer", CFrameQuest = CFrame.new(894.488647, 5.85000658, 4392.43359), CFrameMon = CFrame.new(1608.2822265625, 8.742778778076172, 4371.11865234375)}
        elseif Level >= 90 and Level <= 99 then
            return {Mon = "Snow Bandit", LevelQuest = 1, NameQuest = "SnowQuest", NameMon = "Snow Bandit", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.044677734375)}
        elseif Level >= 100 and Level <= 119 then
            return {Mon = "Snowman", LevelQuest = 2, NameQuest = "SnowQuest", NameMon = "Snowman", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.425048828125)}
        elseif Level >= 120 and Level <= 149 then
            return {Mon = "Chief Petty Officer", LevelQuest = 1, NameQuest = "MarineQuest2", NameMon = "Chief Petty Officer", CFrameQuest = CFrame.new(-5039.49658, 27.3500385, 4324.18408), CFrameMon = CFrame.new(-4882.8623046875, 22.65203857421875, 4255.0283203125)}
        elseif Level >= 150 and Level <= 174 then
            return {Mon = "Sky Bandit", LevelQuest = 1, NameQuest = "SkyQuest", NameMon = "Sky Bandit", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)}
        elseif Level >= 175 and Level <= 189 then
            return {Mon = "Dark Master", LevelQuest = 2, NameQuest = "SkyQuest", NameMon = "Dark Master", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-5259.8447265625, 388.6519470214844, -2272.0205078125)}
        elseif Level >= 190 and Level <= 209 then
            return {Mon = "Prisoner", LevelQuest = 1, NameQuest = "PrisonerQuest", NameMon = "Prisoner", CFrameQuest = CFrame.new(5308.93115, 1.65520716, 475.120514), CFrameMon = CFrame.new(5183.478515625, 23.82689094543457, 466.7683410644531)}
        elseif Level >= 210 and Level <= 249 then
            return {Mon = "Dangerous Prisoner", LevelQuest = 2, NameQuest = "PrisonerQuest", NameMon = "Dangerous Prisoner", CFrameQuest = CFrame.new(5308.93115, 1.65520716, 475.120514), CFrameMon = CFrame.new(5300.326171875, 12.268465042114258, 1307.0758056640625)}
        elseif Level >= 250 and Level <= 274 then
            return {Mon = "Toga Warrior", LevelQuest = 1, NameQuest = "ColosseumQuest", NameMon = "Toga Warrior", CFrameQuest = CFrame.new(-1580.04663, 6.35000658, -2986.47534), CFrameMon = CFrame.new(-1835.69189453125, 44.29234313964844, -2743.864501953125)}
        elseif Level >= 275 and Level <= 299 then
            return {Mon = "Gladiator", LevelQuest = 2, NameQuest = "ColosseumQuest", NameMon = "Gladiator", CFrameQuest = CFrame.new(-1580.04663, 6.35000658, -2986.47534), CFrameMon = CFrame.new(-1292.8388671875, 56.3807258605957, -3339.74853515625)}
        elseif Level >= 300 and Level <= 324 then
            return {Mon = "Military Soldier", LevelQuest = 1, NameQuest = "MagmaQuest", NameMon = "Military Soldier", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5363.36083984375, 58.268394470214844, 8556.9296875)}
        elseif Level >= 325 and Level <= 374 then
            return {Mon = "Military Spy", LevelQuest = 2, NameQuest = "MagmaQuest", NameMon = "Military Spy", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5984.4443359375, 58.9001579284668, 8751.517578125)}
        elseif Level >= 375 and Level <= 399 then
            return {Mon = "Fishman Warrior", LevelQuest = 1, NameQuest = "FishmanQuest", NameMon = "Fishman Warrior", CFrameQuest = CFrame.new(61122.6523, 18.4716406, 1568.7937), CFrameMon = CFrame.new(60952.40625, 17.3828125, 1616.265625)}
        elseif Level >= 400 and Level <= 449 then
            return {Mon = "Fishman Commando", LevelQuest = 2, NameQuest = "FishmanQuest", NameMon = "Fishman Commando", CFrameQuest = CFrame.new(61122.6523, 18.4716406, 1568.7937), CFrameMon = CFrame.new(61872.30078125, 17.3828125, 1476.57421875)}
        elseif Level >= 450 and Level <= 474 then
            return {Mon = "God's Guard", LevelQuest = 1, NameQuest = "SkyExp1Quest", NameMon = "God's Guard", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-4716.95703125, 845.303955078125, -1927.98291015625)}
        elseif Level >= 475 and Level <= 524 then
            return {Mon = "Shanda", LevelQuest = 2, NameQuest = "SkyExp1Quest", NameMon = "Shanda", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-7655.1689453125, 560.4237060546875, -1458.455078125)}
        elseif Level >= 525 and Level <= 549 then
            return {Mon = "Royal Squad", LevelQuest = 1, NameQuest = "SkyExp2Quest", NameMon = "Royal Squad", CFrameQuest = CFrame.new(-7861.09766, 5545.49316, -381.476593), CFrameMon = CFrame.new(-7823.08984375, 560.4237060546875, -525.3544921875)}
        elseif Level >= 550 and Level <= 624 then
            return {Mon = "Royal Soldier", LevelQuest = 2, NameQuest = "SkyExp2Quest", NameMon = "Royal Soldier", CFrameQuest = CFrame.new(-7861.09766, 5545.49316, -381.476593), CFrameMon = CFrame.new(-7823.08984375, 560.4237060546875, -525.3544921875)}
        elseif Level >= 625 and Level <= 649 then
            return {Mon = "Galley Pirate", LevelQuest = 1, NameQuest = "FountainQuest", NameMon = "Galley Pirate", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.212890625)}
        elseif Level >= 650 then
            return {Mon = "Galley Captain", LevelQuest = 2, NameQuest = "FountainQuest", NameMon = "Galley Captain", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)}
        end
    elseif World2 then
        if Level >= 700 and Level <= 724 then
            return {Mon = "Raider", LevelQuest = 1, NameQuest = "Area1Quest", NameMon = "Raider", CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188), CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)}
        elseif Level >= 725 and Level <= 774 then
            return {Mon = "Mercenary", LevelQuest = 2, NameQuest = "Area1Quest", NameMon = "Mercenary", CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188), CFrameMon = CFrame.new(-1004.3114013671875, 76.798828125, 1428.529296875)}
        elseif Level >= 775 and Level <= 874 then
            return {Mon = "Swan Pirate", LevelQuest = 1, NameQuest = "Area2Quest", NameMon = "Swan Pirate", CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898), CFrameMon = CFrame.new(893.0174560546875, 122.22753143310547, 1234.7099609375)}
        elseif Level >= 875 and Level <= 899 then
            return {Mon = "Marine Lieutenant", LevelQuest = 1, NameQuest = "MarineQuest3", NameMon = "Marine Lieutenant", CFrameQuest = CFrame.new(-2442.65015, 72.3590546, -3219.19141), CFrameMon = CFrame.new(-2561.26806640625, 160.30355834960938, -3208.867919921875)}
        elseif Level >= 900 and Level <= 949 then
            return {Mon = "Marine Captain", LevelQuest = 2, NameQuest = "MarineQuest3", NameMon = "Marine Captain", CFrameQuest = CFrame.new(-2442.65015, 72.3590546, -3219.19141), CFrameMon = CFrame.new(-1819.37109375, 160.30355834960938, -3269.6611328125)}
        elseif Level >= 950 and Level <= 974 then
            return {Mon = "Zombie", LevelQuest = 1, NameQuest = "ZombieQuest", NameMon = "Zombie", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -793.731079), CFrameMon = CFrame.new(-5634.83837890625, 48.95122146606445, -966.1624145507812)}
        elseif Level >= 975 and Level <= 999 then
            return {Mon = "Vampire", LevelQuest = 2, NameQuest = "ZombieQuest", NameMon = "Vampire", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -793.731079), CFrameMon = CFrame.new(-6032.4541015625, 6.437736988067627, -1310.5552978515625)}
        elseif Level >= 1000 and Level <= 1049 then
            return {Mon = "Snow Trooper", LevelQuest = 1, NameQuest = "SnowMountainQuest", NameMon = "Snow Trooper", CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928), CFrameMon = CFrame.new(535.41845703125, 400.11993408203125, -5323.63671875)}
        elseif Level >= 1050 and Level <= 1099 then
            return {Mon = "Winter Warrior", LevelQuest = 2, NameQuest = "SnowMountainQuest", NameMon = "Winter Warrior", CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928), CFrameMon = CFrame.new(1223.7802734375, 400.11993408203125, -5368.49609375)}
        elseif Level >= 1100 and Level <= 1124 then
            return {Mon = "Lab Subordinate", LevelQuest = 1, NameQuest = "IceSideQuest", NameMon = "Lab Subordinate", CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852), CFrameMon = CFrame.new(-5720.1435546875, 63.526493072509766, -4784.01171875)}
        elseif Level >= 1125 and Level <= 1174 then
            return {Mon = "Horned Warrior", LevelQuest = 2, NameQuest = "IceSideQuest", NameMon = "Horned Warrior", CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852), CFrameMon = CFrame.new(-6287.59423828125, 77.7818603515625, -5754.92529296875)}
        elseif Level >= 1175 and Level <= 1199 then
            return {Mon = "Magma Ninja", LevelQuest = 1, NameQuest = "FireSideQuest", NameMon = "Magma Ninja", CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.59082), CFrameMon = CFrame.new(-5461.83837890625, 101.95329284667969, -5806.81640625)}
        elseif Level >= 1200 and Level <= 1249 then
            return {Mon = "Lava Pirate", LevelQuest = 2, NameQuest = "FireSideQuest", NameMon = "Lava Pirate", CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.59082), CFrameMon = CFrame.new(-5250.75830078125, 58.97810363769531, -4889.30224609375)}
        elseif Level >= 1250 and Level <= 1274 then
            return {Mon = "Ship Deckhand", LevelQuest = 1, NameQuest = "ShipQuest1", NameMon = "Ship Deckhand", CFrameQuest = CFrame.new(1037.80127, 125.092911, 32911.6016), CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33073.97265625)}
        elseif Level >= 1275 and Level <= 1299 then
            return {Mon = "Ship Engineer", LevelQuest = 2, NameQuest = "ShipQuest1", NameMon = "Ship Engineer", CFrameQuest = CFrame.new(1037.80127, 125.092911, 32911.6016), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 32939.21484375)}
        elseif Level >= 1300 and Level <= 1324 then
            return {Mon = "Ship Steward", LevelQuest = 1, NameQuest = "ShipQuest2", NameMon = "Ship Steward", CFrameQuest = CFrame.new(968.798583, 125.092911, 33245.5425), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 33235.24609375)}
        elseif Level >= 1325 and Level <= 1349 then
            return {Mon = "Ship Officer", LevelQuest = 2, NameQuest = "ShipQuest2", NameMon = "Ship Officer", CFrameQuest = CFrame.new(968.798583, 125.092911, 33245.5425), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 33235.24609375)}
        elseif Level >= 1350 and Level <= 1374 then
            return {Mon = "Arctic Warrior", LevelQuest = 1, NameQuest = "FrostQuest", NameMon = "Arctic Warrior", CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984), CFrameMon = CFrame.new(5934.50927734375, 65.46015930175781, -6521.0224609375)}
        elseif Level >= 1375 and Level <= 1424 then
            return {Mon = "Snow Lurker", LevelQuest = 2, NameQuest = "FrostQuest", NameMon = "Snow Lurker", CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984), CFrameMon = CFrame.new(5934.50927734375, 65.46015930175781, -6521.0224609375)}
        elseif Level >= 1425 and Level <= 1449 then
            return {Mon = "Sea Soldier", LevelQuest = 1, NameQuest = "ForgottenQuest", NameMon = "Sea Soldier", CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193), CFrameMon = CFrame.new(-3029.62255859375, 64.45532989501953, -9864.6337890625)}
        elseif Level >= 1450 then
            return {Mon = "Water Fighter", LevelQuest = 2, NameQuest = "ForgottenQuest", NameMon = "Water Fighter", CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193), CFrameMon = CFrame.new(-3356.73828125, 284.89801025390625, -10502.462890625)}
        end
    elseif World3 then
        if Level >= 1500 and Level <= 1524 then
            return {Mon = "Pirate Millionaire", LevelQuest = 1, NameQuest = "PiratePortQuest", NameMon = "Pirate Millionaire", CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984), CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)}
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

-- Check if quest is active
function Core:HasQuest()
    local success, result = pcall(function()
        local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
        if questGui then
            return questGui.Visible
        end
        return false
    end)
    return success and result
end

-- Get current quest title
function Core:GetCurrentQuestTitle()
    local success, result = pcall(function()
        local questGui = LocalPlayer.PlayerGui.Main.Quest
        local container = questGui:FindFirstChild("Container") or questGui:FindFirstChild("QuestContainer")
        if container then
            local title = container:FindFirstChild("QuestTitle") or container:FindFirstChild("Title")
            if title then
                return title.Text
            end
        end
        return ""
    end)
    return success and result or ""
end

-- Main Loops
function Core:StartLoops()
    -- Auto Farm Loop
    task.spawn(function()
        while true do
            task.wait()
            if Settings.AutoFarm then
                pcall(function()
                    self:DoAutoFarm()
                end)
            end
        end
    end)
    
    -- Fast Attack Loop (Fixed)
    task.spawn(function()
        while true do
            task.wait(0.1)
            if Settings.FastAttack then
                pcall(function()
                    -- Try different attack methods
                    local args = {
                        [1] = "Attack",
                        [2] = true
                    }
                    Remotes.CommF_:InvokeServer(unpack(args))
                    
                    -- Alternative method
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
    
    -- Anti AFK
    task.spawn(function()
        while true do
            task.wait(300)
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end)
end

-- Auto Farm Logic (Fixed)
function Core:DoAutoFarm()
    local QuestData = self:GetQuestData()
    if not QuestData then return end
    
    -- Check and take quest
    if Settings.AutoQuest then
        if not self:HasQuest() then
            -- Teleport to quest giver first
            self:TweenTo(QuestData.CFrameQuest)
            task.wait(0.5)
            
            -- Start quest
            Remotes.CommF_:InvokeServer("StartQuest", QuestData.NameQuest, QuestData.LevelQuest)
            task.wait(0.5)
        else
            -- Check if we have the right quest
            local currentTitle = self:GetCurrentQuestTitle()
            if not string.find(currentTitle, QuestData.Mon) then
                -- Wrong quest, get new one
                Remotes.CommF_:InvokeServer("StartQuest", QuestData.NameQuest, QuestData.LevelQuest)
                task.wait(0.5)
            end
        end
    end
    
    -- Find and Attack Mob
    local target = self:FindMob(QuestData.Mon)
    if target and target:FindFirstChild("HumanoidRootPart") and target:FindFirstChild("Humanoid") then
        local mobHRP = target.HumanoidRootPart
        local mobHumanoid = target.Humanoid
        
        -- Attack loop
        while target.Parent and mobHumanoid.Health > 0 and Settings.AutoFarm do
            task.wait()
            pcall(function()
                if Character:FindFirstChild("HumanoidRootPart") and Humanoid.Health > 0 then
                    -- Position above mob
                    local offset = CFrame.new(0, 30, 0)
                    if Settings.Weapon == "Melee" then
                        offset = CFrame.new(0, 7, 0) -- Closer for melee
                    elseif Settings.Weapon == "Sword" then
                        offset = CFrame.new(0, 5, 5)
                    end
                    
                    Character.HumanoidRootPart.CFrame = mobHRP.CFrame * offset
                    
                    -- Attack
                    if Settings.FastAttack then
                        -- Fast attack is handled in separate loop
                    else
                        -- Normal attack
                        Remotes.CommF_:InvokeServer("Attack", true)
                    end
                end
            end)
        end
        
        -- Wait for loot
        task.wait(0.5)
    else
        -- No mob found, maybe wait or teleport to spawn area
        task.wait(0.5)
    end
end

function Core:FindMob(mobName)
    -- Check main enemies folder
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    
    -- Check if enemies are in different folders (some bosses)
    for _, folder in pairs(Workspace:GetChildren()) do
        if folder:IsA("Folder") and (folder.Name:find("Enemies") or folder.Name:find("Enemy")) then
            for _, v in pairs(folder:GetChildren()) do
                if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    if v.Humanoid.Health > 0 then
                        return v
                    end
                end
            end
        end
    end
    
    return nil
end

function Core:BringMobs()
    local QuestData = self:GetQuestData()
    if not QuestData then return end
    
    local hrp = Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == QuestData.Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                local distance = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                if distance <= 200 then -- Only bring nearby mobs
                    v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -15)
                    v.Humanoid.PlatformStand = true
                    v.HumanoidRootPart.CanCollide = false
                    
                    -- Reset after delay
                    task.delay(2, function()
                        if v and v:FindFirstChild("Humanoid") then
                            v.Humanoid.PlatformStand = false
                        end
                    end)
                end
            end
        end
    end
end

-- Tween Function (Fixed with death check)
function Core:TweenTo(cf)
    if not Character:FindFirstChild("HumanoidRootPart") then return end
    if Humanoid.Health <= 0 then return end
    
    -- Cancel existing tween
    if CurrentTween then
        CurrentTween:Cancel()
        CurrentTween = nil
    end
    
    local distance = (cf.Position - Character.HumanoidRootPart.Position).Magnitude
    local speed = 300
    
    if distance < 50 then
        Character.HumanoidRootPart.CFrame = cf
    else
        local tweenInfo = TweenInfo.new(distance/speed, Enum.EasingStyle.Linear)
        CurrentTween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
        CurrentTween:Play()
        
        -- Wait with death check
        local completed = false
        local connection
        connection = Humanoid.Died:Connect(function()
            if CurrentTween then
                CurrentTween:Cancel()
                completed = true
            end
        end)
        
        CurrentTween.Completed:Wait()
        completed = true
        connection:Disconnect()
        
        if not completed then return end
    end
end

-- No Clip Functions
function Core:SetupNoClip()
    -- Setup character collision
end

function Core:UpdateNoClip()
    if not Character then return end
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Setters
function Core:SetAutoFarm(value) Settings.AutoFarm = value end
function Core:SetAutoQuest(value) Settings.AutoQuest = value end
function Core:SetFastAttack(value) Settings.FastAttack = value end
function Core:SetAutoHaki(value) Settings.AutoHaki = value end
function Core:SetBringMob(value) Settings.BringMob = value end
function Core:SetFarmMode(mode) Settings.FarmMode = mode end
function Core:SetWeapon(weapon) Settings.Weapon = weapon end
function Core:SetAutoStats(value) Settings.AutoStats = value end
function Core:SetStatType(stat) Settings.StatType = stat end
function Core:SetSafeFarm(value) Settings.SafeFarm = value end
function Core:SetAntiAFK(value) end -- Handled automatically

function Core:SetNoClip(value)
    Settings.NoClip = value
    if value then
        self:SetupNoClip()
    else
        -- Restore collision
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

function Core:SetInfiniteJump(value)
    Settings.InfiniteJump = value
    if value then
        local function onJumpRequest()
            if Settings.InfiniteJump and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
    end
end

-- Teleport Functions (Placeholders - implement based on your game)
function Core:TeleportSea(seaNumber)
    if seaNumber == 1 then
        game:GetService("TeleportService"):Teleport(2753915549, LocalPlayer)
    elseif seaNumber == 2 then
        game:GetService("TeleportService"):Teleport(4442272183, LocalPlayer)
    elseif seaNumber == 3 then
        game:GetService("TeleportService"):Teleport(7449423635, LocalPlayer)
    end
end

function Core:TeleportToIsland(islandName)
    -- Implement island teleportation using in-game NPCs or CFrame
    print("Teleporting to: " .. islandName)
end

function Core:TeleportMirage()
    -- Implement mirage island detection and teleport
end

-- Item Quest Functions (Placeholders)
function Core:GetSaber() print("Getting Saber...") end
function Core:GetPole() print("Getting Pole...") end
function Core:GetBisento() print("Getting Bisento...") end
function Core:GetSaddi() print("Getting Saddi...") end
function Core:GetWando() print("Getting Wando...") end
function Core:GetShisui() print("Getting Shisui...") end
function Core:GetRengoku() print("Getting Rengoku...") end
function Core:GetDarkCoat() print("Getting Dark Coat...") end
function Core:GetSwanGlasses() print("Getting Swan Glasses...") end
function Core:GetPaleScarf() print("Getting Pale Scarf...") end
function Core:GetDarkDagger() print("Getting Dark Dagger...") end
function Core:GetDragonTrident() print("Getting Dragon Trident...") end
function Core:GetSoulCane() print("Getting Soul Cane...") end

-- Sea Event Functions
function Core:SetAutoSeaBeast(value) Settings.AutoSeaBeast = value end
function Core:SetAutoShark(value) end
function Core:SetAutoPiranha(value) end
function Core:SetAutoTerrorshark(value) end
function Core:SetAutoGhostShip(value) end
function Core:BuyBoat() end

-- Raid Functions
function Core:SetAutoRaid(value) Settings.AutoRaid = value end
function Core:SetAutoAwaken(value) Settings.AutoAwaken = value end
function Core:SetRaidType(raidType) Settings.RaidType = raidType end
function Core:BuyRaidChip() end

-- Fruit Functions
function Core:SetAutoFarmFruit(value) Settings.AutoFarmFruit = value end
function Core:SetAutoStoreFruit(value) Settings.AutoStoreFruit = value end
function Core:TeleportToFruit() end
function Core:RandomSurprise() end

-- PvP Functions
function Core:SetAutoPvP(value) end
function Core:SetAimbot(value) end

-- Race Functions
function Core:TeleportRaceTrial() end
function Core:CompleteRaceTrial() end
function Core:SetAutoRaceTrial(value) end

-- ESP Functions
function Core:ToggleESP(espType, value)
    Settings.ESP[espType] = value
    if value then
        self:EnableESP(espType)
    else
        self:DisableESP(espType)
    end
end

function Core:EnableESP(espType)
    -- Implement ESP drawing here
end

function Core:DisableESP(espType)
    -- Remove ESP
end

-- Shop Functions
function Core:BuyHaki(hakiType)
    Remotes.CommF_:InvokeServer("BuyHaki", hakiType)
end

function Core:BuyAllHaki()
    local hakis = {"Geppo", "Buso", "Soru", "Ken"}
    for _, haki in ipairs(hakis) do
        Remotes.CommF_:InvokeServer("BuyHaki", haki)
        task.wait(0.1)
    end
end

function Core:BuyFightingStyle(style)
    Remotes.CommF_:InvokeServer("BuyFightingStyle", style)
end

-- Misc Functions
function Core:FPSBoost()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 100000
    settings().Rendering.QualityLevel = 1
end

function Core:RejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end

function Core:ServerHop()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    
    local function ListServers(cursor)
        local Raw = game:HttpGet(Api .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
    end
    
    local Servers = ListServers()
    while true do
        for _, v in pairs(Servers.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                return
            end
        end
        if Servers.nextPageCursor then
            Servers = ListServers(Servers.nextPageCursor)
        else
            break
        end
    end
end

function Core:DestroyUI()
    for _, gui in pairs(game.CoreGui:GetChildren()) do
        if gui.Name == "BloxFruitsUI" then
            gui:Destroy()
        end
    end
end

return Core
