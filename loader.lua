--// Loader GUI Key System - SuttannHub V3
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Ambil HWID (agar 1x per device)
local HWID = gethwid and tostring(gethwid()) or tostring(LocalPlayer.UserId)
local VerifiedHWID = {}

-- 🔑 Ambil key dari Pastebin
local ValidKey = game:HttpGet("https://pastebin.com/raw/a74Lfr6w")

-- Fungsi cek key (support multi key di pastebin)
local function CheckKey(inputKey)
    for key in string.gmatch(ValidKey, "[^\r\n]+") do
        if inputKey == key then
            if VerifiedHWID[HWID] then
                return true
            else
                VerifiedHWID[HWID] = true
                return true
            end
        end
    end
    return false
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")
local UICornerBtn = Instance.new("UICorner")
local Notif = Instance.new("TextLabel")

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.1

UICorner.Parent = Frame
UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 200, 255)

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🔑 Masukkan Key"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

KeyBox.Parent = Frame
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0.2, 0)
KeyBox.PlaceholderText = "Masukkan Key..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 18
KeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

SubmitButton.Parent = Frame
SubmitButton.Position = UDim2.new(0.3, 0, 0.65, 0)
SubmitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 18
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

UICornerBtn.Parent = SubmitButton

Notif.Parent = Frame
Notif.Size = UDim2.new(1, 0, 0, 30)
Notif.Position = UDim2.new(0, 0, 0.85, 0)
Notif.Text = ""
Notif.TextColor3 = Color3.fromRGB(255, 80, 80)
Notif.BackgroundTransparency = 1
Notif.Font = Enum.Font.Gotham
Notif.TextSize = 16

-- Event tombol submit
SubmitButton.MouseButton1Click:Connect(function()
    local InputKey = KeyBox.Text
    if CheckKey(InputKey) then
        Notif.Text = "✅ Key benar!"
        Notif.TextColor3 = Color3.fromRGB(80, 255, 80)
        wait(1)
        ScreenGui:Destroy()
        -- Jalankan script utama
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mereeeecuf/Scriptbro/refs/heads/main/SuttannHubV3"))()
    else
        Notif.Text = "❌ Key salah!"
        Notif.TextColor3 = Color3.fromRGB(255, 80, 80)
        wait(1.5)
        LocalPlayer:Kick("Key salah!")
    end
end)

-- Skip kalau device sudah pernah verif
if VerifiedHWID[HWID] then
    ScreenGui:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Mereeeecuf/Scriptbro/refs/heads/main/SuttannHubV3"))()
end
