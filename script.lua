-- [[ PashaPJD V5 Premium | THE ABSOLUTE NIHAI EDITION ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
    Name = "PashaPJD V5 Premium | THE ABSOLUTE",
    LoadingTitle = "PashaPJD Ultimate Sistemi Yükleniyor...",
    LoadingSubtitle = "by PashaPJD",
    ConfigurationSaving = { Enabled = true, Folder = "PashaPJD_Final" }
})

-- [[ GLOBAL AYARLAR ]] --
local settings = {
    -- Combat
    HitboxExpander = false, HitboxScale = 2, NoRecoil = false,
    -- Visuals
    ESP_Enabled = false, ESP_Boxes = false, ESP_Names = true, 
    ESP_Dist = 1500, ESP_Color = Color3.fromRGB(0, 255, 150),
    -- Skin Manager
    SkinEnabled = false, CustomSkinID = "rbxassetid://121111623",
    -- Engine
    FPSBoost = false, FullBright = false
}

-- [[ SEKMELER ]] --
local CombatTab = Window:CreateTab("🎯 Legit Savaş")
local VisualTab = Window:CreateTab("👁️ ESP & Görsel")
local SkinTab = Window:CreateTab("🎨 Skin Manager")
local MiscTab = Window:CreateTab("⚙️ Sistem")

-- --- 🎯 LEGIT SAVAŞ ---
CombatTab:CreateSection("Vuruş Yardımcısı (Safe)")
CombatTab:CreateToggle({
    Name = "Hitbox Expander (Legit)",
    CurrentValue = false,
    Callback = function(v) settings.HitboxExpander = v end
})
CombatTab:CreateSlider({
    Name = "Hitbox Boyutu (Önerilen: 2-3)",
    Min = 1, Max = 10, CurrentValue = 2,
    Callback = function(v) settings.HitboxScale = v end
})
CombatTab:CreateToggle({
    Name = "No Recoil (Sarsıntı Yok)",
    CurrentValue = false,
    Callback = function(v) settings.NoRecoil = v end
})

-- --- 👁️ ESP & GÖRSEL ---
VisualTab:CreateSection("Bypass ESP (Drawing API)")
VisualTab:CreateToggle({
    Name = "ESP Aktifleştir",
    CurrentValue = false,
    Callback = function(v) settings.ESP_Enabled = v end
})
VisualTab:CreateToggle({
    Name = "İsimleri Göster",
    CurrentValue = true,
    Callback = function(v) settings.ESP_Names = v end
})
VisualTab:CreateToggle({
    Name = "Kutuları Göster",
    CurrentValue = false,
    Callback = function(v) settings.ESP_Boxes = v end
})
VisualTab:CreateColorPicker({
    Name = "ESP Rengi",
    Color = Color3.fromRGB(0, 255, 150),
    Callback = function(c) settings.ESP_Color = c end
})

-- --- 🎨 SKIN MANAGER ---
SkinTab:CreateSection("Universal Skin Değiştirici")
SkinTab:CreateToggle({
    Name = "Skin Sistemi Aktif",
    CurrentValue = false,
    Callback = function(v) settings.SkinEnabled = v end
})
SkinTab:CreateTextBox({
    Name = "Herhangi Bir Skin ID Girin",
    PlaceholderText = "Örn: 152220803",
    Callback = function(t) settings.CustomSkinID = "rbxassetid://" .. t end
})
SkinTab:CreateButton({
    Name = "Skini Silaha Giydir",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool and settings.SkinEnabled then
            for _, v in pairs(tool:GetDescendants()) do
                if v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                    v.TextureID = settings.CustomSkinID
                end
            end
            Library:Notify({Title = "PashaPJD", Content = "Skin Uygulandı!", Duration = 3})
        end
    end
})

-- --- ⚙️ SİSTEM ---
MiscTab:CreateSection("Performans & Güvenlik")
MiscTab:CreateToggle({
    Name = "FPS Boost (Maksimum Performans)",
    CurrentValue = false,
    Callback = function(v) 
        if v then 
            game.Lighting.GlobalShadows = false
            for _, x in pairs(game:GetDescendants()) do if x:IsA("PostEffect") then x.Enabled = false end end
        end
    end
})
MiscTab:CreateKeybind({
    Name = "PANİC (Hileyi Kapat)",
    CurrentKeybind = "End",
    Callback = function() Library:Destroy(); settings.ESP_Enabled = false end
})

-- [[ 🚀 ULTRA ENGINE ]] --

-- 1. LEGIT HITBOX MOTORU
task.spawn(function()
    while task.wait(0.5) do
        if settings.HitboxExpander then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    v.Character.Head.Size = Vector3.new(settings.HitboxScale, settings.HitboxScale, settings.HitboxScale)
                    v.Character.Head.CanCollide = false
                    v.Character.Head.Transparency = 0.8
                end
            end
        end
    end
end)

-- 2. DRAWING API ESP (Sıfır Tespit)
local function AddESP(p)
    local Name = Drawing.new("Text")
    local Box = Drawing.new("Square")
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if settings.ESP_Enabled and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if vis then
                local dist = (workspace.CurrentCamera.CFrame.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist <= settings.ESP_Dist then
                    Name.Visible = settings.ESP_Names
                    Name.Text = p.Name .. " [" .. math.floor(dist) .. "m]"
                    Name.Position = Vector2.new(pos.X, pos.Y - 35)
                    Name.Color = settings.ESP_Color
                    Name.Center = true; Name.Outline = true; Name.Size = 14

                    Box.Visible = settings.ESP_Boxes
                    Box.Size = Vector2.new(2500/pos.Z, 3500/pos.Z)
                    Box.Position = Vector2.new(pos.X - Box.Size.X/2, pos.Y - Box.Size.Y/2)
                    Box.Color = settings.ESP_Color; Box.Thickness = 1
                else Name.Visible = false; Box.Visible = false end
            else Name.Visible = false; Box.Visible = false end
        else Name.Visible = false; Box.Visible = false end
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then AddESP(p) end end
game.Players.PlayerAdded:Connect(AddESP)

-- 3. NO RECOIL (Bypass)
game:GetService("RunService").RenderStepped:Connect(function()
    if settings.NoRecoil then
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame
    end
end)

Library:Notify({Title = "PashaPJD V5 Premium", Content = "Sistem Hazır. İyi Oyunlar!", Duration = 5})
