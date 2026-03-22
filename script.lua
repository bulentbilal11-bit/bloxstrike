-- [[ PashaPJD V5.2 | SOLARA OPTIMIZED ]] --
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shxpang/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "PashaPJD V5 Premium | SOLARA", 
    HidePremium = true, 
    SaveConfig = false, -- Solara çökme riskine karşı kapattım
    IntroText = "Solara için Hazırlanıyor..."
})

local settings = {
    HitboxExpander = false, HitboxScale = 2, NoRecoil = false,
    ESP_Enabled = false, ESP_Boxes = false, ESP_Color = Color3.fromRGB(0, 255, 150),
    SkinEnabled = false, CustomSkinID = "121111623"
}

-- SEKMELER
local CombatTab = Window:MakeTab({ Name = "🎯 Savaş" })
local VisualTab = Window:MakeTab({ Name = "👁️ ESP" })
local SkinTab = Window:MakeTab({ Name = "🎨 Skin Manager" })

-- SAVAŞ
CombatTab:AddToggle({
    Name = "Legit Hitbox",
    Default = false,
    Callback = function(v) settings.HitboxExpander = v end
})

CombatTab:AddSlider({
    Name = "Vuruş Alanı",
    Min = 1, Max = 10, Default = 2,
    Callback = function(v) settings.HitboxScale = v end
})

CombatTab:AddToggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(v) settings.NoRecoil = v end
})

-- ESP
VisualTab:AddToggle({
    Name = "ESP Aktif",
    Default = false,
    Callback = function(v) settings.ESP_Enabled = v end
})

VisualTab:AddColorPicker({
    Name = "ESP Rengi",
    Default = Color3.fromRGB(0, 255, 150),
    Callback = function(v) settings.ESP_Color = v end
})

-- SKIN
SkinTab:AddTextbox({
    Name = "Skin ID",
    Default = "121111623",
    Callback = function(t) settings.CustomSkinID = t end
})

SkinTab:AddButton({
    Name = "Skini Uygula",
    Callback = function()
        local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            for _, v in pairs(tool:GetDescendants()) do
                if v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                    v.TextureID = "rbxassetid://" .. settings.CustomSkinID
                end
            end
        end
    end
})

-- ENGINE (SOLARA SAFE)
task.spawn(function()
    while task.wait(0.5) do
        if settings.HitboxExpander then
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                        v.Character.Head.Size = Vector3.new(settings.HitboxScale, settings.HitboxScale, settings.HitboxScale)
                        v.Character.Head.CanCollide = false
                    end
                end
            end)
        end
    end
end)

OrionLib:Init()
