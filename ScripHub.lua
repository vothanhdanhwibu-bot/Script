local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- 🌌 INTRO GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GraiIntro"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nền tối nhẹ
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0.3
bg.Parent = gui

-- Logo Image
local logo = Instance.new("ImageLabel")
logo.Parent = gui
logo.AnchorPoint = Vector2.new(0.5,0.5)
logo.Position = UDim2.new(0.5,0,0.5,0)
logo.Size = UDim2.new(0,0,0,0) -- bắt đầu nhỏ rồi zoom
logo.BackgroundTransparency = 1
logo.Image = "http://www.roblox.com/asset/?id=114559709340851"
logo.ImageTransparency = 1

-- Hiện logo (zoom + fade in)
TweenService:Create(logo, TweenInfo.new(1.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    Size = UDim2.new(0,200,0,200),
    ImageTransparency = 0
}):Play()

-- Xoay logo
task.spawn(function()
    while logo.Parent do
        logo.Rotation = logo.Rotation + 0.5
        task.wait(0.01)
    end
end)

-- Chữ bên dưới logo
local msg = Instance.new("TextLabel")
msg.Parent = gui
msg.AnchorPoint = Vector2.new(0.5,0)
msg.Position = UDim2.new(0.5,0,0.75,0)
msg.Size = UDim2.new(0,600,0,80)
msg.BackgroundTransparency = 1
msg.Text = "Danh Hub"
msg.TextColor3 = Color3.fromRGB(0,255,255)
msg.Font = Enum.Font.GothamBlack
msg.TextScaled = true
msg.TextStrokeTransparency = 0
msg.TextStrokeColor3 = Color3.fromRGB(0,0,0)
msg.TextTransparency = 1

-- Chữ fade in
TweenService:Create(msg, TweenInfo.new(1.2), {TextTransparency=0}):Play()

-- Giữ intro 4s
task.wait(4)

-- Fade out tất cả
TweenService:Create(logo, TweenInfo.new(1.2), {ImageTransparency=1}):Play()
TweenService:Create(msg, TweenInfo.new(1.2), {TextTransparency=1}):Play()
TweenService:Create(bg, TweenInfo.new(1.2), {BackgroundTransparency=1}):Play()
task.wait(1.5)

gui:Destroy()

------------------------------------------------------------
-- 🎛 MAIN UI BUTTON
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ImageButton = Instance.new("ImageButton")
ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.1,0,0.15,0)
ImageButton.Size = UDim2.new(0,40,0,40)
ImageButton.Draggable = true
ImageButton.Image = "http://www.roblox.com/asset/?id=89879859461943"

local UICorner = Instance.new("UICorner")
UICorner.Parent = ImageButton
UICorner.CornerRadius = UDim.new(1,10)

ImageButton.MouseButton1Down:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.End,false,game)
end)

------------------------------------------------------------
-- 📦 LOAD FLUENT
repeat task.wait() until game:IsLoaded()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title="Danh-RobloxVNG",
    SubTitle="TỔNG HỢP",
    TabWidth=157,
    Size=UDim2.fromOffset(450,300),
    Acrylic=true,
    Theme="Dark",
    MinimizeKey=Enum.KeyCode.End
})

-- Tabs
local Tabs = {
    Main0=Window:AddTab({Title="Thông Tin"}),
    Main1=Window:AddTab({Title="Those who remain"}),
    Main2=Window:AddTab({Title="Forsaken"}),
    Main3=Window:AddTab({Title="Free gamepass"}),
    Main4=Window:AddTab({Title="Auto jump"}),
    Main5=Window:AddTab({Title="Evade"}),
    Main6=Window:AddTab({Title="Infinite-yield"}),
}

-- Tab 0: Thông Tin
Tabs.Main0:AddButton({
    Title="Youtuber",
    Description="Cat",
    Callback=function()
        setclipboard("https://www.youtube.com/@Danh-RobloxVNG")
    end
})

Tabs.Main1:AddButton({
    Title="Those who remain (NoKey)",
    Callback=function()
        local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Interact = require(player.PlayerScripts.Client.Interact)
local OriginalUpdate = Interact.Update

local function EnableInfiniteAmmo()
    Interact.Update = function(...)
        local args = {...}
        local weapon = args[2]
        
        if weapon and weapon.Equipped then
            args[4][weapon.Equipped].Mag = weapon.WeaponModule.Stats.Mag
            args[4][weapon.Equipped].Pool = weapon.WeaponModule.Stats.Pool
        end
        
        return OriginalUpdate(...)
    end
end

local Combat = {
    AimBot = {
        Enabled = false, 
        Radius = 25
    },
    SilentAim = {
        Enabled = false, 
        Radius = 50
    },
    HitBox = {
        Enabled = false, 
        Size = 5
    },
    AlwaysHS = {
        Enabled = false,
        OriginalNamecall = nil
    }
}

local Visuals = {
    FOV = 70,
    ShowFPS = false,
    ShowPing = false,
    ESPZombies = false,
    ESPPlayers = false
}

local circle = Drawing.new("Circle")
circle.Visible = false
circle.Radius = Combat.AimBot.Radius
circle.Color = Color3.new(1, 0, 0)
circle.Thickness = 2
circle.Filled = false
circle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

local silentAimCircle = Drawing.new("Circle")
silentAimCircle.Visible = false
silentAimCircle.Radius = Combat.SilentAim.Radius
silentAimCircle.Color = Color3.fromRGB(0, 255, 0)
silentAimCircle.Thickness = 2
silentAimCircle.Filled = false
silentAimCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

local fpsText = Drawing.new("Text")
fpsText.Visible = false
fpsText.Color = Color3.new(1, 1, 1)
fpsText.Size = 18
fpsText.Position = Vector2.new(10, camera.ViewportSize.Y - 50)
fpsText.Text = "FPS: 0"

local pingText = Drawing.new("Text")
pingText.Visible = false
pingText.Color = Color3.new(1, 1, 1)
pingText.Size = 18
pingText.Position = Vector2.new(10, camera.ViewportSize.Y - 30)
pingText.Text = "Ping: 0ms"

local ESP = {
    Zombies = {
        Active = {},
        Color = Color3.fromRGB(255, 0, 0)
    },
    Players = {
        Active = {},
        Color = Color3.fromRGB(0, 0, 255)
    }
}

local function clearESP(type)
    for _, highlight in pairs(ESP[type].Active) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    ESP[type].Active = {}
end

local function updateESP(type, models)
    if not Visuals["ESP"..type] then return end
    
    for _, model in pairs(models) do
        if model and model.Parent then
            local existingHighlight = model:FindFirstChildOfClass("Highlight")
            if existingHighlight then
                if (type == "Zombies" and existingHighlight.Name == "ZombieHighlight") or
                   (type == "Players" and existingHighlight.Name == "PlayerHighlight") then
                    existingHighlight:Destroy()
                else
                    continue
                end
            end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = type.."Highlight"
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.FillColor = ESP[type].Color
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = model
            table.insert(ESP[type].Active, highlight)
        end
    end
end

local function updateAllESP()
    clearESP("Zombies")
    clearESP("Players")
    
    if Visuals.ESPZombies then
        local zombies = {}
        for _, model in pairs(workspace.Entities.Infected:GetChildren()) do
            if model:IsA("Model") then
                table.insert(zombies, model)
            end
        end
        updateESP("Zombies", zombies)
    end
    
    if Visuals.ESPPlayers then
        local players = {}
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                table.insert(players, plr.Character)
            end
        end
        updateESP("Players", players)
    end
end

local function UpdateAimBot()
    circle.Visible = Combat.AimBot.Enabled
    circle.Radius = Combat.AimBot.Radius
    silentAimCircle.Visible = Combat.SilentAim.Enabled
    silentAimCircle.Radius = Combat.SilentAim.Radius

    if Combat.AimBot.Enabled then
        local closest, dist = nil, math.huge
 
        for _, zombie in pairs(workspace.Entities.Infected:GetChildren()) do
            if zombie:FindFirstChild("Head") then
                local pos = camera:WorldToViewportPoint(zombie.Head.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - circle.Position).Magnitude
 
                if magnitude < Combat.AimBot.Radius and magnitude < dist then
                    closest = zombie.Head
                    dist = magnitude
                end
            end
        end
 
        if closest then
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
        end
    end
end

local hitboxLoop
local function UpdateHitBox()
    if hitboxLoop then hitboxLoop:Disconnect() end

    if Combat.HitBox.Enabled then
        hitboxLoop = RunService.Heartbeat:Connect(function()
            for _, zombie in pairs(workspace.Entities.Infected:GetChildren()) do
                if zombie:FindFirstChild("Head") then
                    zombie.Head.Size = Vector3.new(Combat.HitBox.Size, Combat.HitBox.Size, Combat.HitBox.Size)
                    zombie.Head.CanCollide = false
                    zombie.Head.Transparency = 0.5
                end
            end
        end)
    else
        for _, zombie in pairs(workspace.Entities.Infected:GetChildren()) do
            if zombie:FindFirstChild("Head") then
                zombie.Head.Size = Vector3.new(1, 1, 1)
                zombie.Head.CanCollide = true
                zombie.Head.Transparency = 0
            end
        end
    end
end

local function UpdateFOV()
    camera.FieldOfView = Visuals.FOV
end

local fps = 0
local lastTime = os.clock()
local frameCount = 0

local function UpdateStatsDisplay()
    frameCount = frameCount + 1
    local currentTime = os.clock()
    if currentTime - lastTime >= 1 then
        fps = math.floor(frameCount / (currentTime - lastTime))
        frameCount = 0
        lastTime = currentTime
    end
    
    if Visuals.ShowFPS then
        fpsText.Text = "FPS: "..fps
        fpsText.Visible = true
    else
        fpsText.Visible = false
    end
    
    if Visuals.ShowPing then
        local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        pingText.Text = "Ping: "..ping.."ms"
        pingText.Visible = true
    else
        pingText.Visible = false
    end
end

local function ToggleAlwaysHeadshot(value)
    Combat.AlwaysHS.Enabled = value
    if Combat.AlwaysHS.Enabled then
        local mt = getrawmetatable(game)
        Combat.AlwaysHS.OriginalNamecall = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            if getnamecallmethod() == 'FireServer' and self.Name == 'RE' then
                if args[1] == "aa" then
                    args[2][1] = {
                        ["AI"] = args[2][1]["AI"],
                        ["Velocity"] = args[2][1]["Velocity"],
                        ["Special"] = "H"
                    }
                end
            end
            return Combat.AlwaysHS.OriginalNamecall(self, unpack(args))
        end)
    else
        if Combat.AlwaysHS.OriginalNamecall then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            mt.__namecall = Combat.AlwaysHS.OriginalNamecall
            setreadonly(mt, true)
        end
    end
end

local Window = OrionLib:MakeWindow({
    Name = "🧟‍♂️ Those Who Remain | GUI 🧟‍♂️",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ThoseWhoRemainConfig",
    IntroEnabled = false
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CombatTab = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local VisualTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(value)
        if value then EnableInfiniteAmmo() else Interact.Update = OriginalUpdate end
    end    
})

CombatTab:AddToggle({
    Name = "AimBot",
    Default = false,
    Callback = function(value)
        Combat.AimBot.Enabled = value
    end    
})

CombatTab:AddTextbox({
    Name = "AimBot Radius",
    Default = "25",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num and num >= 10 and num <= 500 then
            Combat.AimBot.Radius = num
        end
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(value)
        Combat.SilentAim.Enabled = value
    end    
})

CombatTab:AddTextbox({
    Name = "Silent Aim Radius",
    Default = "25",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num and num >= 10 and num <= 500 then
            Combat.SilentAim.Radius = num
        end
    end
})

CombatTab:AddToggle({
    Name = "HitBox Expander",
    Default = false,
    Callback = function(value)
        Combat.HitBox.Enabled = value
        UpdateHitBox()
    end    
})

CombatTab:AddTextbox({
    Name = "HitBox Size",
    Default = "5",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num and num >= 1 and num <= 15 then
            Combat.HitBox.Size = num
        end
    end
})

CombatTab:AddToggle({
    Name = "Always Headshot",
    Default = false,
    Callback = function(value)
        ToggleAlwaysHeadshot(value)
    end    
})

VisualTab:AddToggle({
    Name = "Zombie ESP",
    Default = false,
    Callback = function(value)
        Visuals.ESPZombies = value
        updateAllESP()
    end    
})

VisualTab:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(value)
        Visuals.ESPPlayers = value
        updateAllESP()
    end    
})

VisualTab:AddTextbox({
    Name = "Field of View",
    Default = "70",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num and num >= 60 and num <= 120 then
            Visuals.FOV = num
            UpdateFOV()
        end
    end
})

SettingsTab:AddToggle({
    Name = "Show FPS",
    Default = false,
    Callback = function(value)
        Visuals.ShowFPS = value
    end    
})

SettingsTab:AddToggle({
    Name = "Show Ping",
    Default = false,
    Callback = function(value)
        Visuals.ShowPing = value
    end    
})

RunService.RenderStepped:Connect(function()
    UpdateStatsDisplay()
    UpdateAimBot()
end)

RunService.Heartbeat:Connect(function()
    updateAllESP()
end)

Players.PlayerAdded:Connect(function(plr)
    updateAllESP()
end)

Players.PlayerRemoving:Connect(function(plr)
    updateAllESP()
end)

workspace.Entities.Infected.ChildAdded:Connect(function()
    updateAllESP()
end)

workspace.Entities.Infected.ChildRemoved:Connect(function(child)
    updateAllESP()
end)

OrionLib:Init()
  end
})
Tabs.Main2:AddButton({
    Title="Forsaken (NoKey)",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ImDevsVeux/VeuxS/refs/heads/main/obfuscated_script-1763256367184.lua.txt"))()
  end
})
Tabs.Main3:AddButton({
    Title="Free gamepass (NoKey)",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()
    end
})
Tabs.Main4:AddButton({
    Title="Auto jump-Không chạm đất (NoKey)",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/catwljzy/catwljz/refs/heads/main/aotojump.txt"))()
    end
})
Tabs.Main4:AddButton({
    Title="Auto jump-Chạm đất (NoKey)",
    Callback=function()
        loadstring(game:HttpGet('https://pastefy.app/D7XFp8bZ/raw'))()
    end
})
Tabs.Main5:AddButton({
    Title="Evade (Key: whakizashi-key)",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scv8contact-cpu/Whakizashi-hub-x/refs/heads/main/WhakizashiHubX-Evade"))()
    end
})
Tabs.Main6:AddButton({
    Title="Infinite-yield",
    Callback=function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
