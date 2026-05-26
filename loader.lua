-- Loader.lua - Blox Fruits Hub (WORKING VERSION)
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game:IsLoaded()

-- CONFIGURATION - Using your provided URLs
local UI_SCRIPT_URL = "https://raw.githubusercontent.com/UNIVERSAL-SUN-HUB/TEST-FRUIT/refs/heads/main/UI.lua"
local CORE_SCRIPT_URL = "https://raw.githubusercontent.com/UNIVERSAL-SUN-HUB/TEST-FRUIT/refs/heads/main/Core.lua"

-- Load Modules
local success, UILib = pcall(function()
    return loadstring(game:HttpGet(UI_SCRIPT_URL, true))()
end)

if not success then
    warn("Failed to load UI module")
    return
end

local success2, Core = pcall(function()
    return loadstring(game:HttpGet(CORE_SCRIPT_URL, true))()
end)

if not success2 then
    warn("Failed to load Core module")
    return
end

-- Create Window
local Window = UILib:CreateWindow("BloxFruits Hub")

-- ==================== MAIN FARM TAB ====================
local MainTab = Window:addtab("Main Farm")

MainTab:addToggle("Auto Farm Level", false, function(value)
    Core:SetAutoFarm(value)
end)

MainTab:addToggle("Auto Quest", true, function(value)
    Core:SetAutoQuest(value)
end)

MainTab:addToggle("Fast Attack", false, function(value)
    Core:SetFastAttack(value)
end)

MainTab:addToggle("Auto Haki", false, function(value)
    Core:SetAutoHaki(value)
end)

MainTab:addToggle("Bring Mob", true, function(value)
    Core:SetBringMob(value)
end)

MainTab:addDropdown("Farm Mode", {"Level Farm", "Mastery Farm", "Boss Farm", "Material Farm"}, function(selected)
    Core:SetFarmMode(selected)
end)

MainTab:addDropdown("Weapon Select", {"Melee", "Sword", "Gun", "Demon Fruit"}, function(selected)
    Core:SetWeapon(selected)
end)

-- ==================== ITEM QUEST TAB ====================
local QuestTab = Window:addtab("Item Quest")

QuestTab:addButton("Get Saber", function()
    Core:GetSaber()
end)

QuestTab:addButton("Get Pole (V1)", function()
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
    Core:SetAutoSeaBeast(value)
end)

SeaTab:addToggle("Auto Shark", false, function(value)
    Core:SetAutoShark(value)
end)

SeaTab:addToggle("Auto Piranha", false, function(value)
    Core:SetAutoPiranha(value)
end)

SeaTab:addToggle("Auto Terrorshark", false, function(value)
    Core:SetAutoTerrorshark(value)
end)

SeaTab:addToggle("Auto Ghost Ship", false, function(value)
    Core:SetAutoGhostShip(value)
end)

SeaTab:addButton("Buy Boat", function()
    Core:BuyBoat()
end)

-- ==================== AUTO STATS TAB ====================
local StatsTab = Window:addtab("Auto Stats")

StatsTab:addToggle("Auto Stats", false, function(value)
    Core:SetAutoStats(value)
end)

StatsTab:addDropdown("Stat Type", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, function(selected)
    Core:SetStatType(selected)
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
    "Underwater City", "Fountain City", "Kingdom of Rose", "Mansion",
    "Cafe", "Green Zone", "Graveyard", "Dark Arena", "Snow Mountain",
    "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island", "Port Town",
    "Castle on the Sea", "Hydra Island", "Great Tree", "Floating Turtle", "Haunted Castle",
    "Sea of Treats", "Tiki Outpost"
}, function(selected)
    Core:TeleportToIsland(selected)
end)

TeleportTab:addButton("Teleport to Mirage Island", function()
    Core:TeleportMirage()
end)

-- ==================== PVP TAB ====================
local PvPTab = Window:addtab("PvP")

PvPTab:addToggle("Auto PvP", false, function(value)
    Core:SetAutoPvP(value)
end)

PvPTab:addToggle("Aimbot", false, function(value)
    Core:SetAimbot(value)
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
    Core:SetAutoRaceTrial(value)
end)

-- ==================== DUNGEON RAID TAB ====================
local RaidTab = Window:addtab("Raid")

RaidTab:addToggle("Auto Raid", false, function(value)
    Core:SetAutoRaid(value)
end)

RaidTab:addToggle("Auto Awaken", false, function(value)
    Core:SetAutoAwaken(value)
end)

RaidTab:addDropdown("Select Raid", {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix"}, function(selected)
    Core:SetRaidType(selected)
end)

RaidTab:addButton("Buy Chip", function()
    Core:BuyRaidChip()
end)

-- ==================== FRUIT TAB ====================
local FruitTab = Window:addtab("Fruits")

FruitTab:addToggle("Auto Farm Fruit", false, function(value)
    Core:SetAutoFarmFruit(value)
end)

FruitTab:addToggle("Auto Store Fruit", false, function(value)
    Core:SetAutoStoreFruit(value)
end)

FruitTab:addButton("Teleport to Fruit", function()
    Core:TeleportToFruit()
end)

FruitTab:addButton("Random Surprise", function()
    Core:RandomSurprise()
end)

-- ==================== ESP TAB ====================
local ESPTab = Window:addtab("ESP")

ESPTab:addToggle("ESP Player", false, function(value)
    Core:ToggleESP("Player", value)
end)

ESPTab:addToggle("ESP Fruit", false, function(value)
    Core:ToggleESP("Fruit", value)
end)

ESPTab:addToggle("ESP Chest", false, function(value)
    Core:ToggleESP("Chest", value)
end)

ESPTab:addToggle("ESP Flower", false, function(value)
    Core:ToggleESP("Flower", value)
end)

ESPTab:addToggle("ESP Mob", false, function(value)
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

-- ==================== MISC TAB ====================
local MiscTab = Window:addtab("Misc")

MiscTab:addToggle("Safe Farm Mode", true, function(value)
    Core:SetSafeFarm(value)
end)

MiscTab:addToggle("Anti AFK", true, function(value)
    Core:SetAntiAFK(value)
end)

MiscTab:addToggle("No Clip", false, function(value)
    Core:SetNoClip(value)
end)

MiscTab:addToggle("Infinite Jump", false, function(value)
    Core:SetInfiniteJump(value)
end)

MiscTab:addButton("FPS Boost", function()
    Core:FPSBoost()
end)

MiscTab:addButton("Rejoin Server", function()
    Core:RejoinServer()
end)

MiscTab:addButton("Server Hop", function()
    Core:ServerHop()
end)

MiscTab:addButton("Destroy UI", function()
    Core:DestroyUI()
end)

-- Initialize
Core:Init()
