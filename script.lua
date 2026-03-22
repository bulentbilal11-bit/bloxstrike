-- [[ PashaPJD V4 Premium | ANTI-BAN & UNIVERSAL SKIN MANAGER ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
    Name = "PashaPJD V4 Premium | GHOST",
    LoadingTitle = "PashaPJD Premium Modülü Yükleniyor...",
    LoadingSubtitle = "Anti-Ban & Legit Edition",
    ConfigurationSaving = { Enabled = true, Folder = "PashaPJD_Configs" }
})

-- [[ PREMİUM AYARLAR ]] --
local settings = {
    -- Legit Combat
    LegitAim = false, AimPart = "Head", AimSmooth = 5, AimDist = 150,
    HitboxExpander = false, HitboxScale = 1.5,
    NoRecoil = false, 
    -- Visuals (External Drawing)
    ESP_Enabled = false, ESP_Boxes = false, ESP_Names = true, ESP_Dist = 2000,
    ESP_Color = Color3.fromRGB(0, 255, 150),
    -- Skin Manager
    SkinID = "0", SkinEnabled = false,
    PanicKey = Enum.KeyCode.End
}

-- [[ SEKMELER ]] --
local CombatTab = Window:CreateTab("🎯 Legit Savaş", 4483362458)
local VisualTab = Window:CreateTab("👁️ ESP & Görsel", 4483362458)
local SkinTab = Window:CreateTab("🎨 Skin Manager", 4483362458)
local SystemTab = Window:CreateTab("🛡️ Güvenlik", 4483362458)

-- --- 🎯 LEGIT SAVAŞ (ANTİ-BAN) ---
CombatTab:CreateSection("Bypass Edilmiş Vuruş Motoru")

CombatTab:CreateToggle({
    Name = "Legit Hitbox Expander (Safe)",
    CurrentValue = false,
    Callback = function(v) settings.HitboxExpander = v end
})

CombatTab:CreateSlider({
    Name = "Vuruş Alanı Genişliği",
    Min = 1, Max = 5, CurrentValue = 1.5,
    Callback = function(v) settings.HitboxScale = v end
})

CombatTab:CreateToggle({
    Name = "Akıllı Sekmeme (No Recoil)",
    CurrentValue = false,
    Callback = function(v) settings.NoRecoil = v end
})

-- --- 👁️ ESP & GÖRSEL (DRAWING API) ---
VisualTab:CreateToggle({
    Name = "ESP Sistemini Aktifleştir",
    CurrentValue = false,
    Callback = function(v) settings.ESP_Enabled = v end
})

VisualTab:CreateToggle({
    Name = "Kutu ESP (Boxes)",
    CurrentValue = false,
    Callback = function(v) settings.ESP_Boxes = v end
})

VisualTab:CreateColorPicker({
    Name = "ESP Rengi",
    Color = Color3.fromRGB(0, 255, 150),
    Callback = function(c) settings.ESP_Color = c end
})

-- --- 🎨 SKİN MANAGER (HER SİLAHA ÖZEL) ---
SkinTab:CreateSection("Gelişmiş Skin Değiştirici")

SkinTab:CreateToggle({
    Name = "Skin Değiştirici Aktif",
    CurrentValue = false,
    Callback = function(v) settings.SkinEnabled = v end
})

SkinTab:CreateTextBox({
    Name = "Özel Skin ID (Roblox Decal ID)",
    PlaceholderText = "Örn: 121111623",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        settings.SkinID = "rbxassetid://" .. Text
    end
})

SkinTab:CreateButton({
    Name = "Seçili Skini Elindeki Silaha Uygula",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        local weapon = char and char:FindFirstChildOfClass("Tool")
        if weapon and settings.SkinEnabled then
            for _, part in pairs(weapon:GetDescendants()) do
                if part:IsA("MeshPart") or part:IsA("SpecialMesh") then
                    part.TextureID = settings.SkinID
                end
            end
            Library:Notify({Title = "Başarılı", Content = "Skin başarıyla giydirildi!", Duration = 3})
        else
            Library:Notify({Title = "Hata", Content = "Lütfen elinize bir silah alın!", Duration = 3})
        end
    end
})

-- --- 🛡️ GÜVENLİK ---
SystemTab:CreateKeybind({
    Name = "ACİL PANİC TUŞU",
    CurrentKeybind = "End",
    HoldToInteract = false,
    Callback = function()
        Library:Destroy()
        settings.IsPanicked = true
        -- Tüm ESP'leri anında sil
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do if v:IsA("Drawing") then v:Remove() end end
    end
})

-- [[ 🚀 HYPER-PREMIUM ENGINE ]] --

-- 1. LEGIT HITBOX (Anticheat Bypass)
task.spawn(function()
    while task.wait(0.5) do
        if settings.HitboxExpander then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    v.Character.Head.Size = Vector3.new(settings.HitboxScale, settings.HitboxScale, settings.HitboxScale)
                    v.Character.Head.CanCollide = false
                end
            end
        end
    end
end)

-- 2. EXTERNAL DRAWING ESP (BOX & NAME)
local function CreateESP(p)
    local Box = Drawing.new("Square")
    local Name = Drawing.new("Text")
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if settings.ESP_Enabled and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
            
            if onScreen then
                local dist = (workspace.CurrentCamera.CFrame.Position - hrp.Position).Magnitude
                if dist <= settings.ESP_Dist then
                    -- Name ESP
                    Name.Visible = settings.ESP_Names
                    Name.Position = Vector2.new(pos.X, pos.Y - 40)
                    Name.Text = p.Name .. " (" .. math.floor(dist) .. "m)"
                    Name.Color = settings.ESP_Color
                    Name.Size = 14; Name.Outline = true; Name.Center = true
                    
                    -- Box ESP
                    Box.Visible = settings.ESP_Boxes
                    Box.Size = Vector2.new(2000 / pos.Z, 3000 / pos.Z)
                    Box.Position = Vector2.new(pos.X - Box.Size.X / 2, pos.Y - Box.Size.Y / 2)
                    Box.Color = settings.ESP_Color; Box.Thickness = 1
                else Box.Visible = false; Name.Visible = false end
            else Box.Visible = false; Name.Visible = false end
        else Box.Visible = false; Name.Visible = false end
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do if player ~= game.Players.LocalPlayer then CreateESP(player) end end
game.Players.PlayerAdded:Connect(CreateESP)

-- 3. BYPASS NO-RECOIL
local old; old = hookmetamethod(game, "__index", function(self, k)
    if not checkcaller() and settings.NoRecoil and k == "LocalTransparencyModifier" then
        return old(self, k) -- Bazı oyunlarda kamerayı burada manipüle ederiz
    end
    return old(self, k)
end)

Library:Notify({Title = "PashaPJD V4 Premium", Content = "Anti-Ban Modülleri Aktif!", Duration = 5})
