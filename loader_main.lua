-- Loader.lua - Main Entry Point (FIXED)
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/UNIVERSAL-SUN-HUB/TEST-FRUIT/refs/heads/main/Core.lua"))()

-- Initialize Core
Core:Init()

-- Create UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Venice",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Main Farm Tab
local MainTab = Window:CreateTab("Main Farm", "sword")

local AutoFarmToggle = MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        Core:SetAutoFarm(Value)
    end
})

local AutoQuestToggle = MainTab:CreateToggle({
    Name = "Auto Take Quest",
    CurrentValue = true,
    Flag = "AutoQuest",
    Callback = function(Value)
        Core:SetAutoQuest(Value)
    end
})

local FastAttackToggle = MainTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = false,
    Flag = "FastAttack",
    Callback = function(Value)
        Core:SetFastAttack(Value)
    end
})

local BringMobToggle = MainTab:CreateToggle({
    Name = "Bring Mob",
    CurrentValue = true,
    Flag = "BringMob",
    Callback = function(Value)
        Core:SetBringMob(Value)
    end
})

local AutoHakiToggle = MainTab:CreateToggle({
    Name = "Auto Haki",
    CurrentValue = false,
    Flag = "AutoHaki",
    Callback = function(Value)
        Core:SetAutoHaki(Value)
    end
})

local WeaponDropdown = MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Gun", "Blox Fruit"},
    CurrentOption = "Melee",
    Flag = "Weapon",
    Callback = function(Option)
        Core:SetWeapon(Option)
    end
})

-- Teleport Tab
local TeleportTab = Window:CreateTab("Teleport", "plane")

local IslandDropdown = TeleportTab:CreateDropdown({
    Name = "Select Island",
    Options = {"Starter Island", "Marine Start", "Middle Town", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress", "Skylands", "Prison", "Colosseum", "Magma Village", "Fishman Island", "Sky Castle", "Fountain City"},
    CurrentOption = "Starter Island",
    Flag = "SelectedIsland",
    Callback = function(Option)
        Core:SetSelectedIsland(Option)
    end
})

local TweenToggle = TeleportTab:CreateToggle({
    Name = "Use Tween",
    CurrentValue = true,
    Flag = "TweenToIsland",
    Callback = function(Value)
        Core:TweenToIsland(Value)
    end
})

-- ADD THIS MISSING BUTTON
local TeleportButton = TeleportTab:CreateButton({
    Name = "Teleport To Island",
    Callback = function()
        local selectedIsland = Core:GetSelectedIsland()
        if selectedIsland then
            if Core:IsTweenEnabled() then
                Core:TweenToPosition(selectedIsland)
            else
                Core:InstantTeleport(selectedIsland)
            end
        end
    end
})

-- Stats Tab (FIXED ICON - was "chart", now "user")
local StatsTab = Window:CreateTab("Auto Stats", "user")

local AutoStatsToggle = StatsTab:CreateToggle({
    Name = "Auto Stats",
    CurrentValue = false,
    Flag = "AutoStats",
    Callback = function(Value)
        Core:SetAutoStats(Value)
    end
})

local StatDropdown = StatsTab:CreateDropdown({
    Name = "Stat Type",
    Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"},
    CurrentOption = "Melee",
    Flag = "StatType",
    Callback = function(Option)
        Core:SetStatType(Option)
    end
})

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", "settings")

local NoClipToggle = MiscTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(Value)
        Core:SetNoClip(Value)
    end
})

local FPSBoostButton = MiscTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
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
        for i, v in pairs(g:GetDescendants()) do
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
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end
})
