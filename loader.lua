-- Loader.lua - Main Entry Point
repeat wait() until game.Players.LocalPlayer
repeat wait() until game:IsLoaded()

-- CONFIGURATION - Replace these with your actual script URLs/paths
local UI_SCRIPT_URL = "https://example.com/path/to/UI.lua"      -- LINE 6: Replace with your UI.lua URL
local CORE_SCRIPT_URL = "https://example.com/path/to/Core.lua"  -- LINE 7: Replace with your Core.lua URL

-- Load UI Module (LINE 10: loadstring for UI)
local UILib = loadstring(game:HttpGet(UI_SCRIPT_URL, true))()

-- Load Core Module (LINE 13: loadstring for Core)
local Core = loadstring(game:HttpGet(CORE_SCRIPT_URL, true))()

-- Initialize UI
local Window = UILib:CreateWindow("BloxFruits Hub")

-- Create Tabs
local Tabs = {
    Settings = Window:addTab("Settings"),
    Main = Window:addtab("Auto Farm"),
    Quest = Window:addtab("Item Quest"),
    SeaEvent = Window:addtab("Sea Event"),
    Stats = Window:addtab("Auto Stats"),
    Teleport = Window:addtab("World Tele"),
    PvP = Window:addtab("Player PvP"),
    Race = Window:addtab("Race V4"),
    Raid = Window:addtab("Dungeon Raid"),
    Fruits = Window:addtab("Fruit Demon"),
    ESP = Window:addtab("Esp Player"),
    Shop = Window:addtab("Shopee"),
    Misc = Window:addtab("Miscellaneous")
}

-- Connect Core Functions to UI
Core:SetupUI(Tabs, UILib)

-- Initialize Core Logic
Core:Init()
