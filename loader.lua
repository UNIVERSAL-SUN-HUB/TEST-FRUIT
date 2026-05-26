-- Loader.lua - Fixed with ALL Features
repeat wait() until game.Players.LocalPlayer
repeat wait() until game:IsLoaded()

-- CONFIGURATION - Replace these with your actual script URLs
local UI_SCRIPT_URL = "https://raw.githubusercontent.com/UNIVERSAL-SUN-HUB/TEST-FRUIT/refs/heads/main/UI.lua"
local CORE_SCRIPT_URL = "https://raw.githubusercontent.com/UNIVERSAL-SUN-HUB/TEST-FRUIT/refs/heads/main/Core.lua"

-- Load Modules
local UILib = loadstring(game:HttpGet(UI_SCRIPT_URL, true))()
local Core = loadstring(game:HttpGet(CORE_SCRIPT_URL, true))()

-- Create Window
local Window = UILib:CreateWindow("BloxFruits Hub")

-- ==================== MAIN FARM TAB ====================
local MainTab = Window:addtab("Main Farm")

MainTab:addToggle("Auto Farm Level", false, function(value)
    _G.AutoFarm = value
    if value then Core:StartAutoFarm() end
end)

MainTab:addToggle("Auto Quest", true, function(value)
    _G.AutoQuest = value
end)

MainTab:addToggle("Fast Attack", false, function(value)
    _G.FastAttack = value
end)

MainTab:addToggle("Auto Haki", false, function(value)
    _G.AutoHaki = value
end)

MainTab:addDropdown("Farm Mode", {"Level Farm", "Mastery Farm", "Boss Farm", "Material Farm"}, function(selected)
    _G.FarmMode = selected
end)

MainTab:addDropdown("Weapon Select", {"Melee", "Sword", "Gun", "Demon Fruit"}, function(selected)
    _G.SelectWeapon = selected
end)

-- ==================== ITEM QUEST TAB ====================
local QuestTab = Window:addtab("Item Quest")

QuestTab:addButton("Get Saber", function()
    Core:GetSaber()
end)

QuestTab:addButton("Get Pole", function()
    Core:GetPole()
end)

QuestTab:addButton("Get Bisento", function()
    Core:GetBisento()
end)

QuestTab:addButton("Get Saddi", function()
    Core:GetSaddi()
end)

QuestTab:addButton("Get Wando", function()
    Core:GetWando()
end)

QuestTab:addButton("Get Shisui", function()
    Core:GetShisui()
end)

QuestTab:addButton("Get Rengoku", function()
    Core:GetRengoku()
end)

QuestTab:addButton("Get Dark Coat", function()
    Core:GetDarkCoat()
end)

QuestTab:addButton("Get Swan Glasses", function()
    Core:GetSwanGlasses()
end)

QuestTab:addButton("Get Holy Crown", function()
    Core:GetHolyCrown()
end)

QuestTab:addButton("Get Pale Scarf", function()
    Core:GetPaleScarf()
end)

QuestTab:addButton("Get Dark Dagger", function()
    Core:GetDarkDagger()
end)

QuestTab:addButton("Get Dragon Trident", function()
    Core:GetDragonTrident()
end)

QuestTab:addButton("Get Soul Cane", function()
    Core:GetSoulCane()
end)

-- ==================== SEA EVENT TAB ====================
local SeaTab = Window:addtab("Sea Event")

SeaTab:addToggle("Auto Sea Beast", false, function(value)
    _G.AutoSeaBeast = value
    if value then Core:AutoSeaBeast() end
end)

SeaTab:addToggle("Auto Shark", false, function(value)
    _G.AutoShark = value
end)

SeaTab:addToggle("Auto Piranha", false, function(value)
    _G.AutoPiranha = value
end)

SeaTab:addToggle("Auto Terrorshark", false, function(value)
    _G.AutoTerrorshark = value
end)

SeaTab:addToggle("Auto Ghost Ship", false, function(value)
    _G.AutoGhostShip = value
end)

SeaTab:addToggle("Auto Sea Event", false, function(value)
    _G.AutoSeaEvent = value
end)

SeaTab:addButton("Buy Boat", function()
    Core:BuyBoat()
end)

-- ==================== AUTO STATS TAB ====================
local StatsTab = Window:addtab("Auto Stats")

StatsTab:addToggle("Auto Stats", false, function(value)
    _G.AutoStats = value
    if value then Core:AutoStats() end
end)

StatsTab:addDropdown("Stat Type", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, function(selected)
    _G.StatType = selected
end)

StatsTab:addButton("Max Melee", function()
    Core:MaxStat("Melee")
end)

StatsTab:addButton("Max Defense", function()
    Core:MaxStat("Defense")
end)

StatsTab:addButton("Max Sword", function()
    Core:MaxStat("Sword")
end)

StatsTab:addButton("Max Gun", function()
    Core:MaxStat("Gun")
end)

StatsTab:addButton("Max Blox Fruit", function()
    Core:MaxStat("Demon Fruit")
end)

-- ==================== TELEPORT TAB ====================
local TeleportTab = Window:addtab("Teleport")

TeleportTab:addButton("Teleport to Sea 1", function()
    Core:TeleportSea(1)
end)

TeleportTab:addButton("Teleport to Sea 2", function()
    Core:TeleportSea(2)
end)

TeleportTab:addButton("Teleport to Sea 3", function()
    Core:TeleportSea(3)
end)

TeleportTab:addDropdown("Teleport to Island", {
    "Starter Island", "Jungle", "Pirate Village", "Desert", "Frozen Village", 
    "Marine Fortress", "Skylands", "Prison", "Colosseum", "Magma Village",
    "Underwater City", "Fountain City", "Jail", "Kingdom of Rose", "Mansion",
    "Cafe", "Green Zone", "Graveyard", "Dark Arena", "Snow Mountain",
    "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island", "Port Town",
    "Castle on the Sea", "Hydra Island", "Great Tree", "Floating Turtle", "Haunted Castle",
    "Sea of Treats", "Chocolate Island", "Candy Island", "Tiki Outpost"
}, function(selected)
    Core:TeleportToIsland(selected)
end)

TeleportTab:addButton("Teleport to Mirage Island", function()
    Core:TeleportMirage()
end)

TeleportTab:addButton("Teleport to Full Moon", function()
    Core:TeleportFullMoon()
end)

-- ==================== PVP TAB ====================
local PvPTab = Window:addtab("PvP")

PvPTab:addToggle("Auto PvP", false, function(value)
    _G.AutoPvP = value
end)

PvPTab:addToggle("Auto Kill Player", false, function(value)
    _G.AutoKillPlayer = value
end)

PvPTab:addToggle("Auto Farm Bounty", false, function(value)
    _G.AutoFarmBounty = value
end)

PvPTab:addDropdown("Select Player", {"Refresh List"}, function(selected)
    if selected == "Refresh List" then
        Core:RefreshPlayerList()
    else
        _G.SelectedPlayer = selected
    end
end)

PvPTab:addToggle("Aimbot", false, function(value)
    _G.Aimbot = value
end)

PvPTab:addToggle("Silent Aim", false, function(value)
    _G.SilentAim = value
end)

-- ==================== RACE V4 TAB ====================
local RaceTab = Window:addtab("Race V4")

RaceTab:addButton("Teleport to Race Trial", function()
    Core:TeleportRaceTrial()
end)

RaceTab:addButton("Complete Race Trial", function()
    Core:CompleteRaceTrial()
end)

RaceTab:addToggle("Auto Race Trial", false, function(value)
    _G.AutoRaceTrial = value
end)

RaceTab:addToggle("Auto Train Race", false, function(value)
    _G.AutoTrainRace = value
end)

RaceTab:addButton("Get Cyborg Race", function()
    Core:GetCyborg()
end)

RaceTab:addButton("Get Ghoul Race", function()
    Core:GetGhoul()
end)

RaceTab:addButton("Get Human Race V4", function()
    Core:GetRaceV4("Human")
end)

RaceTab:addButton("Get Shark Race V4", function()
    Core:GetRaceV4("Shark")
end)

RaceTab:addButton("Get Angel Race V4", function()
    Core:GetRaceV4("Angel")
end)

RaceTab:addButton("Get Rabbit Race V4", function()
    Core:GetRaceV4("Rabbit")
end)

-- ==================== DUNGEON RAID TAB ====================
local RaidTab = Window:addtab("Raid")

RaidTab:addToggle("Auto Raid", false, function(value)
    _G.AutoRaid = value
    if value then Core:AutoRaid() end
end)

RaidTab:addToggle("Auto Awaken", false, function(value)
    _G.AutoAwaken = value
end)

RaidTab:addDropdown("Select Raid", {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix"}, function(selected)
    _G.SelectedRaid = selected
end)

RaidTab:addButton("Buy Chip", function()
    Core:BuyRaidChip()
end)

RaidTab:addButton("Start Raid", function()
    Core:StartRaid()
end)

-- ==================== FRUIT TAB ====================
local FruitTab = Window:addtab("Fruits")

FruitTab:addToggle("Auto Farm Fruit", false, function(value)
    _G.AutoFarmFruit = value
end)

FruitTab:addToggle("Auto Store Fruit", false, function(value)
    _G.AutoStoreFruit = value
end)

FruitTab:addToggle("Auto Eat Fruit", false, function(value)
    _G.AutoEatFruit = value
end)

FruitTab:addToggle("Auto Drop Fruit", false, function(value)
    _G.AutoDropFruit = value
end)

FruitTab:addButton("Teleport to Fruit", function()
    Core:TeleportToFruit()
end)

FruitTab:addButton("Random Surprise", function()
    Core:RandomSurprise()
end)

FruitTab:addToggle("Auto Sniper Fruit", false, function(value)
    _G.AutoSniperFruit = value
end)

FruitTab:addDropdown("Select Sniper Fruit", {
    "Bomb-Bomb", "Spike-Spike", "Chop-Chop", "Spring-Spring", "Smoke-Smoke",
    "Spin-Spin", "Flame-Flame", "Bird-Bird: Falcon", "Ice-Ice", "Sand-Sand",
    "Dark-Dark", "Revive-Revive", "Diamond-Diamond", "Light-Light", "Love-Love",
    "Rubber-Rubber", "Barrier-Barrier", "Magma-Magma", "Door-Door", "Quake-Quake",
    "Human-Human: Buddha", "String-String", "Bird-Bird: Phoenix", "Rumble-Rumble",
    "Paw-Paw", "Gravity-Gravity", "Dough-Dough", "Shadow-Shadow", "Venom-Venom",
    "Control-Control", "Soul-Soul", "Dragon-Dragon", "Leopard-Leopard"
}, function(selected)
    _G.SniperFruit = selected
end)

-- ==================== ESP TAB ====================
local ESPTab = Window:addtab("ESP")

ESPTab:addToggle("ESP Player", false, function(value)
    _G.ESPPlayer = value
    Core:ToggleESP("Player", value)
end)

ESPTab:addToggle("ESP Fruit", false, function(value)
    _G.ESPFruit = value
    Core:ToggleESP("Fruit", value)
end)

ESPTab:addToggle("ESP Chest", false, function(value)
    _G.ESPChest = value
    Core:ToggleESP("Chest", value)
end)

ESPTab:addToggle("ESP Flower", false, function(value)
    _G.ESPFlower = value
    Core:ToggleESP("Flower", value)
end)

ESPTab:addToggle("ESP Island", false, function(value)
    _G.ESPIsland = value
    Core:ToggleESP("Island", value)
end)

ESPTab:addToggle("ESP Sea Beast", false, function(value)
    _G.ESPSeaBeast = value
    Core:ToggleESP("SeaBeast", value)
end)

ESPTab:addToggle("ESP Mob", false, function(value)
    _G.ESPMob = value
    Core:ToggleESP("Mob", value)
end)

-- ==================== SHOP TAB ====================
local ShopTab = Window:addtab("Shop")

ShopTab:addButton("Buy Geppo", function()
    Core:BuyHaki("Geppo")
end)

ShopTab:addButton("Buy Buso Haki", function()
    Core:BuyHaki("Buso")
end)

ShopTab:addButton("Buy Soru", function()
    Core:BuyHaki("Soru")
end)

ShopTab:addButton("Buy Ken Haki", function()
    Core:BuyHaki("Ken")
end)

ShopTab:addButton("Buy All Haki", function()
    Core:BuyAllHaki()
end)

ShopTab:addDropdown("Buy Fighting Style", {
    "Black Leg", "Fishman Karate", "Electro", "Dragon Breath", "Superhuman", 
    "Death Step", "Sharkman Karate", "Electric Claw", "Dragon Talon", "Godhuman"
}, function(selected)
    Core:BuyFightingStyle(selected)
end)

ShopTab:addButton("Buy Legendary Sword", function()
    Core:BuyLegendarySword()
end)

-- ==================== MISC TAB ====================
local MiscTab = Window:addtab("Misc")

MiscTab:addToggle("Safe Farm Mode", true, function(value)
    _G.SafeFarm = value
    if not value then
        game.Players.LocalPlayer:Kick("Please don't turn off safe farm if you don't want to get banned")
    end
end)

MiscTab:addToggle("Anti AFK", true, function(value)
    _G.AntiAFK = value
end)

MiscTab:addToggle("No Clip", false, function(value)
    _G.NoClip = value
end)

MiscTab:addToggle("Infinite Jump", false, function(value)
    _G.InfiniteJump = value
    if value then
        game:GetService("UserInputService").JumpRequest:connect(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end)
    end
end)

MiscTab:addToggle("Walk on Water", false, function(value)
    _G.WalkOnWater = value
end)

MiscTab:addToggle("Auto Click", false, function(value)
    _G.AutoClick = value
end)

MiscTab:addButton("FPS Boost", function()
    Core:FPSBoost()
end)

MiscTab:addButton("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

MiscTab:addButton("Server Hop", function()
    Core:ServerHop()
end)

MiscTab:addButton("Destroy UI", function()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "BloxFruitsUI" then
            v:Destroy()
        end
    end
end)

-- Initialize Core
Core:Init()
