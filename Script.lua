loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
         Hub = {
         Title = "DanhROBLOX",
         Animation = "TỔNG HỢP"
         },
        Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
        Notifications = true,
        CorrectKey = "Running the Script...",
       Incorrectkey = "The key is incorrect",
       CopyKeyLink = "Copied to Clipboard"
      }
    }
  })

       MinimizeButton({
       Image = "http://www.roblox.com/asset/?id=114648469367997",
       Size = {60, 60},
       Color = Color3.fromRGB(10, 10, 10),
       Corner = true,
       Stroke = false,
       StrokeColor = Color3.fromRGB(255, 0, 0)
      })
      
------ Tab
     local Tab1o = MakeTab({Name = "Tab: Prison life"})
     local Tab2o = MakeTab({Name = "Tab: infiniteyield"})
     local Tab3o = MakeTab({Name = "Tab: Forsaken"})
     local Tab4o = MakeTab({Name = "Tab: Free gamepass"})
     local Tab5o = MakeTab({Name = "Tab: Those who remain"})


     
------- BUTTON
    
    AddButton(Tab1o, {
     Name = "Prison life (NoKey)",
    Callback = function()
	   loadstring(game:HttpGet("https://raw.githubusercontent.com/Luxxorh/Roblox-Scripts/refs/heads/main/Prison%20Life",true))()
  end
  })
  
  AddButton(Tab2o, {
     Name = "infiniteyield",
    Callback = function()
	   loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
  end
  })
  
  AddButton(Tab3o, {
     Name = "Forsaken (NoKey)",
    Callback = function()
	   loadstring(game:HttpGet("https://rawscripts.net/raw/G666-Forsaken-Guesting-Hub-AutoBlock-Esp-aimbot-and-more-63558"))()
  end
  })

AddButton(Tab5o, {
     Name = "Those who remain (NoKey)",
    Callback = function()
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
        Radius = 25
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


AddButton(Tab4o, {
     Name = "Free gamepass (NoKey)",
    Callback = function()
	   loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()
  end
  })
