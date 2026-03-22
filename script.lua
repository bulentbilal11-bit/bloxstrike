-- [[ PashaPJD V5.3 | 404 FIX & SOLARA SPECIAL ]] --
-- Yedekli kütüphane sistemi (Eğer biri 404 verirse diğeri yüklenir)
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/jannat-dev/Scripts/main/OrionLib.lua'))()
end)

if not success then
    OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shxpang/Orion/main/source'))()
end

local Window = OrionLib:MakeWindow({
    Name = "PashaPJD V5 Premium | FIX", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "PashaPJD Sistemleri Yukleniyor..."
})

-- AYARLAR
_G.Hitbox = false
_G.Scale = 2
_G.NoRecoil = false

-- TABLAR
local MainTab = Window:MakeTab({ Name = "🎯 Savas" })
local SkinTab = Window:MakeTab({ Name = "🎨 Skin Manager" })

MainTab:AddToggle({
    Name = "Hitbox Expander (Legit)",
    Default = false,
    Callback = function(v) _G.Hitbox = v end
})

MainTab:AddSlider({
    Name = "Vurus Alani",
    Min = 1, Max = 10, Default = 2,
    Callback = function(v) _G.Scale = v end
})

MainTab:AddToggle({
    Name = "No Recoil (Safe)",
    Default = false,
    Callback = function(v) _G.NoRecoil = v end
})

SkinTab:AddTextbox({
    Name = "Skin ID",
    Default = "121111623",
    Callback = function(t) _G.SkinID = t end
})

SkinTab:AddButton({
    Name = "Skini Uygula",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool then
            for _, v in pairs(tool:GetDescendants()) do
                if v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                    v.TextureID = "rbxassetid://" .. (_G.SkinID or "121111623")
                end
            end
        end
    end
})

-- ENGINE
task.spawn(function()
    while task.wait(0.5) do
        if _G.Hitbox then
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                        v.Character.Head.Size = Vector3.new(_G.Scale, _G.Scale, _G.Scale)
                        v.Character.Head.CanCollide = false
                    end
                end
            end)
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.NoRecoil then
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame
    end
end)

OrionLib:Init()
