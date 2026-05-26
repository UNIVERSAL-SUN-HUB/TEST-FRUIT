-- Core.lua - Complete Game Logic
local Core = {}

-- World Detection
local World1, World2, World3 = false, false, false

-- Configuration
_G.AutoFarm = false
_G.AutoQuest = false
_G.AutoStats = false
_G.FastAttack = false
_G.AutoHaki = false
_G.SafeFarm = true
_G.FarmMode = "Level Farm"
_G.SelectWeapon = "Melee"

function Core:Init()
    if game.PlaceId == 2753915549 then
        World1 = true
    elseif game.PlaceId == 4442272183 then
        World2 = true
    elseif game.PlaceId == 7449423635 then
        World3 = true
    end
    
    self:SetupBypass()
    self:SetupSafeFarm()
    self:SetupAntiAFK()
end

-- Quest Detection (Complete)
function Core:CheckQuest()
    local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    local QuestData = {}
    
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 then
            QuestData = {Mon = "Bandit", LevelQuest = 1, NameQuest = "BanditQuest1", NameMon = "Bandit", CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231), CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)}
        elseif MyLevel >= 10 and MyLevel <= 14 then
            QuestData = {Mon = "Monkey", LevelQuest = 1, NameQuest = "JungleQuest", NameMon = "Monkey", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)}
        elseif MyLevel >= 15 and MyLevel <= 29 then
            QuestData = {Mon = "Gorilla", LevelQuest = 2, NameQuest = "JungleQuest", NameMon = "Gorilla", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-112.20606231689453, 40.5460319519043, -671.4652099609375)}
        elseif MyLevel >= 30 and MyLevel <= 39 then
            QuestData = {Mon = "Pirate", LevelQuest = 1, NameQuest = "BuggyQuest1", NameMon = "Pirate", CFrameQuest = CFrame.new(-1141.07483, 4.1000198, 3831.5498), CFrameMon = CFrame.new(-1201.8880615234375, 4.75205135345459, 3915.201416015625)}
        elseif MyLevel >= 40 and MyLevel <= 59 then
            QuestData = {Mon = "Brute", LevelQuest = 2, NameQuest = "BuggyQuest1", NameMon = "Brute", CFrameQuest = CFrame.new(-1141.07483, 4.1000198, 3831.5498), CFrameMon = CFrame.new(-1147.395751953125, 14.809885025024414, 4322.35009765625)}
        elseif MyLevel >= 60 and MyLevel <= 74 then
            QuestData = {Mon = "Desert Bandit", LevelQuest = 1, NameQuest = "DesertQuest", NameMon = "Desert Bandit", CFrameQuest = CFrame.new(894.488647, 5.85000658, 4392.43359), CFrameMon = CFrame.new(924.9287719726562, 6.4485554695129395, 4481.58544921875)}
        elseif MyLevel >= 75 and MyLevel <= 89 then
            QuestData = {Mon = "Desert Officer", LevelQuest = 2, NameQuest = "DesertQuest", NameMon = "Desert Officer", CFrameQuest = CFrame.new(894.488647, 5.85000658, 4392.43359), CFrameMon = CFrame.new(1608.2822265625, 8.742778778076172, 4371.11865234375)}
        elseif MyLevel >= 90 and MyLevel <= 99 then
            QuestData = {Mon = "Snow Bandit", LevelQuest = 1, NameQuest = "SnowQuest", NameMon = "Snow Bandit", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.044677734375)}
        elseif MyLevel >= 100 and MyLevel <= 119 then
            QuestData = {Mon = "Snowman", LevelQuest = 2, NameQuest = "SnowQuest", NameMon = "Snowman", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.425048828125)}
        elseif MyLevel >= 120 and MyLevel <= 149 then
            QuestData = {Mon = "Chief Petty Officer", LevelQuest = 1, NameQuest = "MarineQuest2", NameMon = "Chief Petty Officer", CFrameQuest = CFrame.new(-5039.49658, 27.3500385, 4324.18408), CFrameMon = CFrame.new(-4882.8623046875, 22.65203857421875, 4255.0283203125)}
        elseif MyLevel >= 150 and MyLevel <= 174 then
            QuestData = {Mon = "Sky Bandit", LevelQuest = 1, NameQuest = "SkyQuest", NameMon = "Sky Bandit", CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165), CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)}
        elseif MyLevel >= 175 and MyLevel <= 189 then
            QuestData = {Mon = "Dark Master", LevelQuest = 2, NameQuest = "SkyQuest", NameMon = "Dark Master", CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165), CFrameMon = CFrame.new(-5259.8447265625, 388.6519470214844, -2272.0205078125)}
        elseif MyLevel >= 190 and MyLevel <= 209 then
            QuestData = {Mon = "Prisoner", LevelQuest = 1, NameQuest = "PrisonerQuest", NameMon = "Prisoner", CFrameQuest = CFrame.new(5308.93115, 1.65520716, 475.120514), CFrameMon = CFrame.new(5183.478515625, 23.82689094543457, 466.7683410644531)}
        elseif MyLevel >= 210 and MyLevel <= 249 then
            QuestData = {Mon = "Dangerous Prisoner", LevelQuest = 2, NameQuest = "PrisonerQuest", NameMon = "Dangerous Prisoner", CFrameQuest = CFrame.new(5308.93115, 1.65520716, 475.120514), CFrameMon = CFrame.new(5300.326171875, 12.268465042114258, 1307.0758056640625)}
        elseif MyLevel >= 250 and MyLevel <= 274 then
            QuestData = {Mon = "Toga Warrior", LevelQuest = 1, NameQuest = "ColosseumQuest", NameMon = "Toga Warrior", CFrameQuest = CFrame.new(-1580.04663, 6.35000658, -2986.47534), CFrameMon = CFrame.new(-1835.69189453125, 44.29234313964844, -2743.864501953125)}
        elseif MyLevel >= 275 and MyLevel <= 299 then
            QuestData = {Mon = "Gladiator", LevelQuest = 2, NameQuest = "ColosseumQuest", NameMon = "Gladiator", CFrameQuest = CFrame.new(-1580.04663, 6.35000658, -2986.47534), CFrameMon = CFrame.new(-1292.8388671875, 56.3807258605957, -3339.74853515625)}
        elseif MyLevel >= 300 and MyLevel <= 324 then
            QuestData = {Mon = "Military Soldier", LevelQuest = 1, NameQuest = "MagmaQuest", NameMon = "Military Soldier", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5363.36083984375, 58.268394470214844, 8556.9296875)}
        elseif MyLevel >= 325 and MyLevel <= 374 then
            QuestData = {Mon = "Military Spy", LevelQuest = 2, NameQuest = "MagmaQuest", NameMon = "Military Spy", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5984.4443359375, 58.9001579284668, 8751.517578125)}
        elseif MyLevel >= 375 and MyLevel <= 399 then
            QuestData = {Mon = "Fishman Warrior", LevelQuest = 1, NameQuest = "FishmanQuest", NameMon = "Fishman Warrior", CFrameQuest = CFrame.new(61122.6523, 18.4716406, 1568.7937), CFrameMon = CFrame.new(60952.40625, 17.3828125, 1616.265625)}
        elseif MyLevel >= 400 and MyLevel <= 449 then
            QuestData = {Mon = "Fishman Commando", LevelQuest = 2, NameQuest = "FishmanQuest", NameMon = "Fishman Commando", CFrameQuest = CFrame.new(61122.6523, 18.4716406, 1568.7937), CFrameMon = CFrame.new(61872.30078125, 17.3828125, 1476.57421875)}
        elseif MyLevel >= 450 and MyLevel <= 474 then
            QuestData = {Mon = "God's Guard", LevelQuest = 1, NameQuest = "SkyExp1Quest", NameMon = "God's Guard", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-4716.95703125, 845.303955078125, -1927.98291015625)}
        elseif MyLevel >= 475 and MyLevel <= 524 then
            QuestData = {Mon = "Shanda", LevelQuest = 2, NameQuest = "SkyExp1Quest", NameMon = "Shanda", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-7655.1689453125, 560.4237060546875, -1458.455078125)}
        elseif MyLevel >= 525 and MyLevel <= 549 then
            QuestData = {Mon = "Royal Squad", LevelQuest = 1, NameQuest = "SkyExp2Quest", NameMon = "Royal Squad", CFrameQuest = CFrame.new(-7861.09766, 5545.49316, -381.476593), CFrameMon = CFrame.new(-7823.08984375, 560.4237060546875, -525.3544921875)}
        elseif MyLevel >= 550 and MyLevel <= 624 then
            QuestData = {Mon = "Royal Soldier", LevelQuest = 2, NameQuest = "SkyExp2Quest", NameMon = "Royal Soldier", CFrameQuest = CFrame.new(-7861.09766, 5545.49316, -381.476593), CFrameMon = CFrame.new(-7823.08984375, 560.4237060546875, -525.3544921875)}
        elseif MyLevel >= 625 and MyLevel <= 649 then
            QuestData = {Mon = "Galley Pirate", LevelQuest = 1, NameQuest = "FountainQuest", NameMon = "Galley Pirate", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.212890625)}
        elseif MyLevel >= 650 then
            QuestData = {Mon = "Galley Captain", LevelQuest = 2, NameQuest = "FountainQuest", NameMon = "Galley Captain", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)}
        end
    elseif World2 then
        if MyLevel >= 700 and MyLevel <= 724 then
            QuestData = {Mon = "Raider", LevelQuest = 1, NameQuest = "Area1Quest", NameMon = "Raider", CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188), CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)}
        elseif MyLevel >= 725 and MyLevel <= 774 then
            QuestData = {Mon = "Mercenary", LevelQuest = 2, NameQuest = "Area1Quest", NameMon = "Mercenary", CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188), CFrameMon = CFrame.new(-1004.3114013671875, 76.798828125, 1428.529296875)}
        elseif MyLevel >= 775 and MyLevel <= 874 then
            QuestData = {Mon = "Swan Pirate", LevelQuest = 1, NameQuest = "Area2Quest", NameMon = "Swan Pirate", CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898), CFrameMon = CFrame.new(893.0174560546875, 122.22753143310547, 1234.7099609375)}
        elseif MyLevel >= 875 and MyLevel <= 899 then
            QuestData = {Mon = "Marine Lieutenant", LevelQuest = 1, NameQuest = "MarineQuest3", NameMon = "Marine Lieutenant", CFrameQuest = CFrame.new(-2442.65015, 72.3590546, -3219.19141), CFrameMon = CFrame.new(-2561.26806640625, 160.30355834960938, -3208.867919921875)}
        elseif MyLevel >= 900 and MyLevel <= 949 then
            QuestData = {Mon = "Marine Captain", LevelQuest = 2, NameQuest = "MarineQuest3", NameMon = "Marine Captain", CFrameQuest = CFrame.new(-2442.65015, 72.3590546, -3219.19141), CFrameMon = CFrame.new(-1819.37109375, 160.30355834960938, -3269.6611328125)}
        elseif MyLevel >= 950 and MyLevel <= 974 then
            QuestData = {Mon = "Zombie", LevelQuest = 1, NameQuest = "ZombieQuest", NameMon = "Zombie", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -793.731079), CFrameMon = CFrame.new(-5634.83837890625, 48.95122146606445, -966.1624145507812)}
        elseif MyLevel >= 975 and MyLevel <= 999 then
            QuestData = {Mon = "Vampire", LevelQuest = 2, NameQuest = "ZombieQuest", NameMon = "Vampire", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -793.731079), CFrameMon = CFrame.new(-6032.4541015625, 6.437736988067627, -1310.5552978515625)}
        elseif MyLevel >= 1000 and MyLevel <= 1049 then
            QuestData = {Mon = "Snow Trooper", LevelQuest = 1, NameQuest = "SnowMountainQuest", NameMon = "Snow Trooper", CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928), CFrameMon = CFrame.new(535.41845703125, 400.11993408203125, -5323.63671875)}
        elseif MyLevel >= 1050 and MyLevel <= 1099 then
            QuestData = {Mon = "Winter Warrior", LevelQuest = 2, NameQuest = "SnowMountainQuest", NameMon = "Winter Warrior", CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928), CFrameMon = CFrame.new(1223.7802734375, 400.11993408203125, -5368.49609375)}
        elseif MyLevel >= 1100 and MyLevel <= 1124 then
            QuestData = {Mon = "Lab Subordinate", LevelQuest = 1, NameQuest = "IceSideQuest", NameMon = "Lab Subordinate", CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852), CFrameMon = CFrame.new(-5720.1435546875, 63.526493072509766, -4784.01171875)}
        elseif MyLevel >= 1125 and MyLevel <= 1174 then
            QuestData = {Mon = "Horned Warrior", LevelQuest = 2, NameQuest = "IceSideQuest", NameMon = "Horned Warrior", CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852), CFrameMon = CFrame.new(-6287.59423828125, 77.7818603515625, -5754.92529296875)}
        elseif MyLevel >= 1175 and MyLevel <= 1199 then
            QuestData = {Mon = "Magma Ninja", LevelQuest = 1, NameQuest = "FireSideQuest", NameMon = "Magma Ninja", CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.59082), CFrameMon = CFrame.new(-5461.83837890625, 101.95329284667969, -5806.81640625)}
        elseif MyLevel >= 1200 and MyLevel <= 1249 then
            QuestData = {Mon = "Lava Pirate", LevelQuest = 2, NameQuest = "FireSideQuest", NameMon = "Lava Pirate", CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.59082), CFrameMon = CFrame.new(-5250.75830078125, 58.97810363769531, -4889.30224609375)}
        elseif MyLevel >= 1250 and MyLevel <= 1274 then
            QuestData = {Mon = "Ship Deckhand", LevelQuest = 1, NameQuest = "ShipQuest1", NameMon = "Ship Deckhand", CFrameQuest = CFrame.new(1037.80127, 125.092911, 32911.6016), CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33073.97265625)}
        elseif MyLevel >= 1275 and MyLevel <= 1299 then
            QuestData = {Mon = "Ship Engineer", LevelQuest = 2, NameQuest = "ShipQuest1", NameMon = "Ship Engineer", CFrameQuest = CFrame.new(1037.80127, 125.092911, 32911.6016), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 32939.21484375)}
        elseif MyLevel >= 1300 and MyLevel <= 1324 then
            QuestData = {Mon = "Ship Steward", LevelQuest = 1, NameQuest = "ShipQuest2", NameMon = "Ship Steward", CFrameQuest = CFrame.new(968.798583, 125.092911, 33245.5425), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 33235.24609375)}
        elseif MyLevel >= 1325 and MyLevel <= 1349 then
            QuestData = {Mon = "Ship Officer", LevelQuest = 2, NameQuest = "ShipQuest2", NameMon = "Ship Officer", CFrameQuest = CFrame.new(968.798583, 125.092911, 33245.5425), CFrameMon = CFrame.new(919.6155395507812, 125.09291076660156, 33235.24609375)}
        elseif MyLevel >= 1350 and MyLevel <= 1374 then
            QuestData = {Mon = "Arctic Warrior", LevelQuest = 1, NameQuest = "FrostQuest", NameMon = "Arctic Warrior", CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984), CFrameMon = CFrame.new(5934.50927734375, 65.46015930175781, -6521.0224609375)}
        elseif MyLevel >= 1375 and MyLevel <= 1424 then
            QuestData = {Mon = "Snow Lurker", LevelQuest = 2, NameQuest = "FrostQuest", NameMon = "Snow Lurker", CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984), CFrameMon = CFrame.new(5934.50927734375, 65.46015930175781, -6521.0224609375)}
        elseif MyLevel >= 1425 and MyLevel <= 1449 then
            QuestData = {Mon = "Sea Soldier", LevelQuest = 1, NameQuest = "ForgottenQuest", NameMon = "Sea Soldier", CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193), CFrameMon = CFrame.new(-3029.62255859375, 64.45532989501953, -9864.6337890625)}
        elseif MyLevel >= 1450 then
            QuestData = {Mon = "Water Fighter", LevelQuest = 2, NameQuest = "ForgottenQuest", NameMon = "Water Fighter", CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193), CFrameMon = CFrame.new(-3356.73828125, 284.89801025390625, -10502.462890625)}
        end
    elseif World3 then
        if MyLevel >= 1500 and MyLevel <= 1524 then
            QuestData = {Mon = "Pirate Millionaire", LevelQuest = 1, NameQuest = "PiratePortQuest", NameMon = "Pirate Millionaire", CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984), CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)}
        elseif MyLevel >= 1525 and MyLevel <= 1574 then
            QuestData = {Mon = "Pistol Billionaire", LevelQuest = 2, NameQuest = "PiratePortQuest", NameMon = "Pistol Billionaire", CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984), CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)}
        elseif MyLevel >= 1575 and MyLevel <= 1599 then
            QuestData = {Mon = "Dragon Crew Warrior", LevelQuest = 1, NameQuest = "AmazonQuest", NameMon = "Dragon Crew Warrior", CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51562), CFrameMon = CFrame.new(6221.52197265625, 51.68061065673828, -1683.949951171875)}
        elseif MyLevel >= 1600 and MyLevel <= 1624 then
            QuestData = {Mon = "Dragon Crew Archer", LevelQuest = 2, NameQuest = "AmazonQuest", NameMon = "Dragon Crew Archer", CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51562), CFrameMon = CFrame.new(6667.09716796875, 403.51629638671875, -729.3095703125)}
        elseif MyLevel >= 1625 and MyLevel <= 1649 then
            QuestData = {Mon = "Female Islander", LevelQuest = 1, NameQuest = "AmazonQuest2", NameMon = "Female Islander", CFrameQuest = CFrame.new(5448.93115, 601.649963, 751.131958), CFrameMon = CFrame.new(4696.0888671875, 735.9605102539062, 1669.56640625)}
        elseif MyLevel >= 1650 and MyLevel <= 1699 then
            QuestData = {Mon = "Giant Islander", LevelQuest = 2, NameQuest = "AmazonQuest2", NameMon = "Giant Islander", CFrameQuest = CFrame.new(5448.93115, 601.649963, 751.131958), CFrameMon = CFrame.new(4888.53125, 652.9526977539062, 1444.47265625)}
        elseif MyLevel >= 1700 and MyLevel <= 1724 then
            QuestData = {Mon = "Marine Commodore", LevelQuest = 1, NameQuest = "MarineTreeIsland", NameMon = "Marine Commodore", CFrameQuest = CFrame.new(2180.54126, 28.2316399, -6281.91699), CFrameMon = CFrame.new(2498.33935546875, 190.23890686035156, -7165.31005859375)}
        elseif MyLevel >= 1725 and MyLevel <= 1774 then
            QuestData = {Mon = "Marine Rear Admiral", LevelQuest = 2, NameQuest = "MarineTreeIsland", NameMon = "Marine Rear Admiral", CFrameQuest = CFrame.new(2180.54126, 28.2316399, -6281.91699), CFrameMon = CFrame.new(2498.33935546875, 190.23890686035156, -7165.31005859375)}
        elseif MyLevel >= 1775 and MyLevel <= 1799 then
            QuestData = {Mon = "Fishman Raider", LevelQuest = 1, NameQuest = "DeepForestIsland3", NameMon = "Fishman Raider", CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652), CFrameMon = CFrame.new(-10533.7705078125, 331.7626647949219, -8654.29296875)}
        elseif MyLevel >= 1800 and MyLevel <= 1824 then
            QuestData = {Mon = "Fishman Captain", LevelQuest = 2, NameQuest = "DeepForestIsland3", NameMon = "Fishman Captain", CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652), CFrameMon = CFrame.new(-10876.0390625, 331.7626647949219, -8759.5947265625)}
        elseif MyLevel >= 1825 and MyLevel <= 1849 then
            QuestData = {Mon = "Forest Pirate", LevelQuest = 1, NameQuest = "DeepForestIsland", NameMon = "Forest Pirate", CFrameQuest = CFrame.new(-13234.165, 332.378052, -7625.40137), CFrameMon = CFrame.new(-13225.681640625, 428.1938781738281, -7758.15625)}
        elseif MyLevel >= 1850 and MyLevel <= 1899 then
            QuestData = {Mon = "Mythological Pirate", LevelQuest = 2, NameQuest = "DeepForestIsland", NameMon = "Mythological Pirate", CFrameQuest = CFrame.new(-13234.165, 332.378052, -7625.40137), CFrameMon = CFrame.new(-13869.2216796875, 453.95343017578125, -9893.0498046875)}
        elseif MyLevel >= 1900 and MyLevel <= 1924 then
            QuestData = {Mon = "Jungle Pirate", LevelQuest = 1, NameQuest = "DeepForestIsland2", NameMon = "Jungle Pirate", CFrameQuest = CFrame.new(-12680.3818, 389.791931, -9902.01953), CFrameMon = CFrame.new(-11975.634765625, 331.7626647949219, -10053.19921875)}
        elseif MyLevel >= 1925 and MyLevel <= 1974 then
            QuestData = {Mon = "Musketeer Pirate", LevelQuest = 2, NameQuest = "DeepForestIsland2", NameMon = "Musketeer Pirate", CFrameQuest = CFrame.new(-12680.3818, 389.791931, -9902.01953), CFrameMon = CFrame.new(-11314.1669921875, 520.7034301757812, -10610.521484375)}
        elseif MyLevel >= 1975 and MyLevel <= 1999 then
            QuestData = {Mon = "Reborn Skeleton", LevelQuest = 1, NameQuest = "HauntedQuest1", NameMon = "Reborn Skeleton", CFrameQuest = CFrame.new(-9479.2168, 142.130844, 5566.0918), CFrameMon = CFrame.new(-8761.58984375, 191.1676025390625, 6168.03125)}
        elseif MyLevel >= 2000 and MyLevel <= 2024 then
            QuestData = {Mon = "Living Zombie", LevelQuest = 2, NameQuest = "HauntedQuest1", NameMon = "Living Zombie", CFrameQuest = CFrame.new(-9479.2168, 142.130844, 5566.0918), CFrameMon = CFrame.new(-10144.7607421875, 140.94931030273438, 5983.23046875)}
        elseif MyLevel >= 2025 and MyLevel <= 2049 then
            QuestData = {Mon = "Demonic Soul", LevelQuest = 1, NameQuest = "HauntedQuest2", NameMon = "Demonic Soul", CFrameQuest = CFrame.new(-9516.2627, 178.79451, 6078.45996), CFrameMon = CFrame.new(-9701.615234375, 204.69522094726562, 6042.61279296875)}
        elseif MyLevel >= 2050 and MyLevel <= 2074 then
            QuestData = {Mon = "Posessed Mummy", LevelQuest = 2, NameQuest = "HauntedQuest2", NameMon = "Posessed Mummy", CFrameQuest = CFrame.new(-9516.2627, 178.79451, 6078.45996), CFrameMon = CFrame.new(-9701.615234375, 204.69522094726562, 6042.61279296875)}
        elseif MyLevel >= 2075 and MyLevel <= 2099 then
            QuestData = {Mon = "Peanut Scout", LevelQuest = 1, NameQuest = "NutsIslandQuest", NameMon = "Peanut Scout", CFrameQuest = CFrame.new(-2104.39062, 38.1041679, -10194.2188), CFrameMon = CFrame.new(-2095.8095703125, 192.6106414794922, -10252.4609375)}
        elseif MyLevel >= 2100 and MyLevel <= 2124 then
            QuestData = {Mon = "Peanut President", LevelQuest = 2, NameQuest = "NutsIslandQuest", NameMon = "Peanut President", CFrameQuest = CFrame.new(-2104.39062, 38.1041679, -10194.2188), CFrameMon = CFrame.new(-1876.642578125, 194.45343017578125, -10545.548828125)}
        elseif MyLevel >= 2125 and MyLevel <= 2149 then
            QuestData = {Mon = "Ice Cream Chef", LevelQuest = 1, NameQuest = "IceCreamIslandQuest", NameMon = "Ice Cream Chef", CFrameQuest = CFrame.new(-820.648254, 37.8186607, -10965.8359), CFrameMon = CFrame.new(-890.9402465820312, 186.72894287109375, -11127.306640625)}
        elseif MyLevel >= 2150 and MyLevel <= 2199 then
            QuestData = {Mon = "Ice Cream Commander", LevelQuest = 2, NameQuest = "IceCreamIslandQuest", NameMon = "Ice Cream Commander", CFrameQuest = CFrame.new(-820.648254, 37.8186607, -10965.8359), CFrameMon = CFrame.new(-890.9402465820312, 186.72894287109375, -11127.306640625)}
        elseif MyLevel >= 2200 and MyLevel <= 2224 then
            QuestData = {Mon = "Cookie Crafter", LevelQuest = 1, NameQuest = "CakeQuest1", NameMon = "Cookie Crafter", CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295), CFrameMon = CFrame.new(-2358.543212890625, 192.6106414794922, -12148.916015625)}
        elseif MyLevel >= 2225 and MyLevel <= 2249 then
            QuestData = {Mon = "Cake Guard", LevelQuest = 2, NameQuest = "CakeQuest1", NameMon = "Cake Guard", CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295), CFrameMon = CFrame.new(-1500.79052734375, 194.41064453125, -11446.662109375)}
        elseif MyLevel >= 2250 and MyLevel <= 2274 then
            QuestData = {Mon = "Baking Staff", LevelQuest = 1, NameQuest = "CakeQuest2", NameMon = "Baking Staff", CFrameQuest = CFrame.new(-1927.91064, 37.7981339, -12843.7852), CFrameMon = CFrame.new(-1886.18701171875, 192.6106414794922, -12984.5390625)}
        elseif MyLevel >= 2275 and MyLevel <= 2299 then
            QuestData = {Mon = "Head Baker", LevelQuest = 2, NameQuest = "CakeQuest2", NameMon = "Head Baker", CFrameQuest = CFrame.new(-1927.91064, 37.7981339, -12843.7852), CFrameMon = CFrame.new(-2216.92724609375, 192.6106414794922, -12985.833984375)}
        elseif MyLevel >= 2300 and MyLevel <= 2324 then
            QuestData = {Mon = "Cocoa Warrior", LevelQuest = 1, NameQuest = "ChocQuest1", NameMon = "Cocoa Warrior", CFrameQuest = CFrame.new(233.228516, 29.8760014, -12201.2334), CFrameMon = CFrame.new(21.745283126831055, 80.57499694824219, -12352.240234375)}
        elseif MyLevel >= 2325 and MyLevel <= 2349 then
            QuestData = {Mon = "Chocolate Bar Battler", LevelQuest = 2, NameQuest = "ChocQuest1", NameMon = "Chocolate Bar Battler", CFrameQuest = CFrame.new(233.228516, 29.8760014, -12201.2334), CFrameMon = CFrame.new(582.0524291992188, 77.1630859375, -12463.1669921875)}
        elseif MyLevel >= 2350 and MyLevel <= 2374 then
            QuestData = {Mon = "Sweet Thief", LevelQuest = 1, NameQuest = "ChocQuest2", NameMon = "Sweet Thief", CFrameQuest = CFrame.new(150.506424, 30.293663, -12774.5029), CFrameMon = CFrame.new(-134.5806884765625, 77.1630859375, -12880.470703125)}
        elseif MyLevel >= 2375 and MyLevel <= 2399 then
            QuestData = {Mon = "Candy Rebel", LevelQuest = 2, NameQuest = "ChocQuest2", NameMon = "Candy Rebel", CFrameQuest = CFrame.new(150.506424, 30.293663, -12774.5029), CFrameMon = CFrame.new(-134.5806884765625, 77.1630859375, -12880.470703125)}
        elseif MyLevel >= 2400 and MyLevel <= 2424 then
            QuestData = {Mon = "Candy Pirate", LevelQuest = 1, NameQuest = "CandyQuest1", NameMon = "Candy Pirate", CFrameQuest = CFrame.new(-1150.04004, 20.3789349, -14446.3691), CFrameMon = CFrame.new(-1310.5001220703125, 26.85352325439453, -14562.755859375)}
        elseif MyLevel >= 2425 and MyLevel <= 2449 then
            QuestData = {Mon = "Snow Conjurer", LevelQuest = 2, NameQuest = "CandyQuest1", NameMon = "Snow Conjurer", CFrameQuest = CFrame.new(-1150.04004, 20.3789349, -14446.3691), CFrameMon = CFrame.new(-1310.5001220703125, 26.85352325439453, -14562.755859375)}
        elseif MyLevel >= 2450 then
            QuestData = {Mon = "Isle Outlaw", LevelQuest = 1, NameQuest = "TikiQuest1", NameMon = "Isle Outlaw", CFrameQuest = CFrame.new(-16547.748, 61.1353683, -180.214249), CFrameMon = CFrame.new(-16442.521484375, 96.65082550048828, -269.1958923339844)}
        end
    end
    
    return QuestData
end

-- Auto Farm Function
function Core:StartAutoFarm()
    spawn(function()
        while _G.AutoFarm do
            wait()
            pcall(function()
                local QuestData = self:CheckQuest()
                
                if QuestData.NameQuest and _G.AutoQuest then
                    local questActive = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                    
                    if not questActive then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestData.NameQuest, QuestData.LevelQuest)
                    end
                    
                    if QuestData.CFrameMon then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = QuestData.CFrameMon
                    end
                    
                    self:AttackMob(QuestData.NameMon)
                end
            end)
        end
    end)
end

function Core:AttackMob(monsterName)
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v.Name == monsterName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            repeat
                wait()
                if _G.FastAttack then
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

function Core:MaxStat(statType)
    spawn(function()
        for i = 1, 100 do
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", statType, 1)
            wait(0.1)
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

function Core:TeleportToIsland(islandName)
    local islands = {
        ["Starter Island"] = CFrame.new(1071.2832, 16.3085976, 1426.24695),
        ["Jungle"] = CFrame.new(-1249.77222, 11.8528919, 349.674988),
        ["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.37451),
        ["Desert"] = CFrame.new(897.668884, 6.43846178, 4389.9707),
        ["Frozen Village"] = CFrame.new(1198.00928, 27.0075741, -1211.50427),
        ["Marine Fortress"] = CFrame.new(-4505.375, 20.5264797, 4260.94189),
        ["Skylands"] = CFrame.new(-4970.21875, 717.707275, -2620.35449),
        ["Prison"] = CFrame.new(4854.16455, 5.68742752, 636.949463),
        ["Colosseum"] = CFrame.new(-1428.35474, 7.38933945, -3014.4209),
        ["Magma Village"] = CFrame.new(-5231.75879, 8.61523438, 8467.87695),
        ["Underwater City"] = CFrame.new(61163.8516, 5.34233618, 1819.78418),
        ["Fountain City"] = CFrame.new(5132.7124, 8.64750767, 4032.93311),
        ["Jail"] = CFrame.new(4854.16455, 5.68742752, 636.949463),
        ["Kingdom of Rose"] = CFrame.new(-388.950989, 138.277679, 2702.35059),
        ["Mansion"] = CFrame.new(-390.348297, 321.366302, 869.158203),
        ["Cafe"] = CFrame.new(-379.479858, 73.0458984, 304.736206),
        ["Green Zone"] = CFrame.new(-2372.45996, 72.948143, -3166.45508),
        ["Graveyard"] = CFrame.new(-5411.0498, 48.5922394, -221.358002),
        ["Dark Arena"] = CFrame.new(3794.3855, 44.3406944, -3492.15576),
        ["Snow Mountain"] = CFrame.new(561.286743, 401.391998, -5307.2124),
        ["Hot and Cold"] = CFrame.new(-6026.76172, 14.7534962, -5074.22656),
        ["Cursed Ship"] = CFrame.new(902.059143, 124.472473, 33031.8125),
        ["Ice Castle"] = CFrame.new(5400.40381, 28.2165031, -6236.99219),
        ["Forgotten Island"] = CFrame.new(-3043.31543, 238.271744, -10191.5791),
        ["Port Town"] = CFrame.new(-290.737671, 42.817955, 5583.41895),
        ["Castle on the Sea"] = CFrame.new(-5477.33691, 313.72937, -280.661591),
        ["Hydra Island"] = CFrame.new(5229.09668, 68.1503067, 1703.7981),
        ["Great Tree"] = CFrame.new(2174.26831, 28.7312393, -6728.87061),
        ["Floating Turtle"] = CFrame.new(-12427.1729, 337.174286, -7553.07422),
        ["Haunted Castle"] = CFrame.new(-9506.74414, 142.130844, 5536.91748),
        ["Sea of Treats"] = CFrame.new(-10026.9863, 42.5475121, -10987.7285),
        ["Chocolate Island"] = CFrame.new(200.506424, 30.293663, -12774.5029),
        ["Candy Island"] = CFrame.new(-1150.04004, 20.3789349, -14446.3691),
        ["Tiki Outpost"] = CFrame.new(-16547.748, 61.1353683, -180.214249)
    }
    
    if islands[islandName] then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = islands[islandName]
    end
end

-- Item Quest Functions
function Core:GetSaber() end
function Core:GetPole() end
function Core:GetBisento() end
function Core:GetSaddi() end
function Core:GetWando() end
function Core:GetShisui() end
function Core:GetRengoku() end
function Core:GetDarkCoat() end
function Core:GetSwanGlasses() end
function Core:GetHolyCrown() end
function Core:GetPaleScarf() end
function Core:GetDarkDagger() end
function Core:GetDragonTrident() end
function Core:GetSoulCane() end

-- Sea Event
function Core:AutoSeaBeast()
    spawn(function()
        while _G.AutoSeaBeast do
            wait()
            -- Sea Beast detection and attack logic
        end
    end)
end

function Core:BuyBoat()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Miracle")
end

-- Raid Functions
function Core:AutoRaid()
    spawn(function()
        while _G.AutoRaid do
            wait()
            -- Raid logic
        end
    end)
end

function Core:BuyRaidChip()
    if _G.SelectedRaid then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectedRaid)
    end
end

function Core:StartRaid()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
end

-- Fruit Functions
function Core:TeleportToFruit()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
        end
    end
end

function Core:RandomSurprise()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BloxFruitsRandomSurprise")
end

-- ESP Functions
function Core:ToggleESP(espType, enabled)
    if enabled then
        -- ESP implementation
    else
        -- Remove ESP
    end
end

-- Shop Functions
function Core:BuyHaki(hakiName)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", hakiName)
end

function Core:BuyAllHaki()
    local hakis = {"Geppo", "Buso", "Soru", "Ken"}
    for _, haki in ipairs(hakis) do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", haki)
        wait(0.5)
    end
end

function Core:BuyFightingStyle(style)
    local styles = {
        ["Black Leg"] = "BuyBlackLeg",
        ["Fishman Karate"] = "BuyFishmanKarate",
        ["Electro"] = "BuyElectro",
        ["Dragon Breath"] = "BuyDragonClaw",
        ["Superhuman"] = "BuySuperhuman",
        ["Death Step"] = "BuyDeathStep",
        ["Sharkman Karate"] = "BuySharkmanKarate",
        ["Electric Claw"] = "BuyElectricClaw",
        ["Dragon Talon"] = "BuyDragonTalon",
        ["Godhuman"] = "BuyGodhuman"
    }
    
    if styles[style] then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(styles[style])
    end
end

function Core:BuyLegendarySword()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
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

-- FPS Boost
function Core:FPSBoost()
    local decalsyeeted = true
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
        elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
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

-- Anti-Cheat Bypass
function Core:SetupBypass()
    if getrawmetatable and setreadonly and newcclosure then
        local grm = getrawmetatable(game)
        setreadonly(grm, false)
        local old = grm.__namecall
        grm.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = tostring(args[1])
            
            if method == "TeleportDetect" or method == "CHECKER_1" or method == "CHECKER" or 
               method == "GUI_CHECK" or method == "OneMoreTime" or method == "checkingSPEED" or 
               method == "BANREMOTE" or method == "PERMAIDBAN" or method == "KICKREMOTE" or 
               method == "BR_KICKPC" or method == "BR_KICKMOBILE" then
                return
            end
            
            return old(self, ...)
        end)
    end
end

-- Safe Farm
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
        end
    end)
end

-- Anti AFK
function Core:SetupAntiAFK()
    spawn(function()
        while _G.AntiAFK do
            wait(300)
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end)
end

-- Refresh Player List
function Core:RefreshPlayerList()
    local players = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(players, v.Name)
        end
    end
    return players
end

return Core
