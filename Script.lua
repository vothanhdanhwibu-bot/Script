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
     local Tab6o = MakeTab({Name = "Tab: Fling T and P"})


     
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


AddButton(Tab4o, {
     Name = "Free gamepass (NoKey)",
    Callback = function()
	   loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()
  end
  })

AddButton(Tab6o, {
     Name = "Fling Things and People (NoKey)",
    Callback = function()
	   MoonSec_StringsHiddenAttr = true;
if _wURGUJXwOJhV == "This file was protected with MoonSec V3" then
    local l_Players_0 = game:GetService("Players");
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    local l_RunService_0 = game:GetService("RunService");
    local l_HttpService_0 = game:GetService("HttpService");
    local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
    local _ = game:GetService("Debris");
    local l_GrabEvents_0 = l_ReplicatedStorage_0:WaitForChild("GrabEvents");
    local _ = l_ReplicatedStorage_0:WaitForChild("CharacterEvents");
    local _ = l_ReplicatedStorage_0:WaitForChild("MenuToys");
    local l_SetNetworkOwner_0 = l_GrabEvents_0:WaitForChild("SetNetworkOwner");
    local _ = game:GetService("StarterGui");
    local l_TextChatService_0 = game:GetService("TextChatService");
    if not l_Players_0.LocalPlayer and not l_Players_0:GetPropertyChangedSignal("LocalPlayer"):Wait() then
        local _ = l_Players_0.LocalPlayer;
    end;
    local l_RagdollRemote_0 = l_ReplicatedStorage_0:WaitForChild("CharacterEvents"):FindFirstChild("RagdollRemote");
    local v14 = false;
    local _ = nil;
    local _ = 40;
    local _ = nil;
    local _ = nil;
    local _ = nil;
    local _ = nil;
    if not l_LocalPlayer_0.Character then
        local _ = l_LocalPlayer_0.CharacterAdded:Wait();
    end;
    local _ = workspace:FindFirstChild(l_LocalPlayer_0.Name .. "SpawnedInToys");
    local l_LocalPlayer_2 = l_Players_0.LocalPlayer;
    local l_Workspace_0 = game:GetService("Workspace");
    (_G or {}).BlobmanDelay = 5.0E-8;
    local v25 = 1;
    local _ = {};
    local v27 = nil;
    local v28 = {};
    local _ = nil;
    local function v33()
        -- upvalues: l_Players_0 (ref)
        local v30 = {};
        for _, v32 in ipairs(l_Players_0:GetPlayers()) do
            table.insert(v30, v32.Name);
        end;
        return v30;
    end;
    local function v37()
        -- upvalues: v33 (ref), v28 (ref)
        local v34 = v33();
        for _, v36 in ipairs(v28) do
            v36:Refresh(v34, true);
        end;
    end;
    l_Players_0.PlayerAdded:Connect(v37);
    l_Players_0.PlayerRemoving:Connect(v37);
    local function v39(v38)
        -- upvalues: v28 (ref), v33 (ref)
        table.insert(v28, v38);
        v38:Refresh(v33(), true);
    end;
    local v40 = nil;
    l_Players_0.PlayerAdded:Connect(function()
        -- upvalues: v40 (ref), v33 (ref)
        if v40 then
            v40:Refresh(v33(), true);
        end;
    end);
    l_Players_0.PlayerRemoving:Connect(function()
        -- upvalues: v40 (ref), v33 (ref)
        if v40 then
            v40:Refresh(v33(), true);
        end;
    end);
    local function v42(v41)
        -- upvalues: l_TextChatService_0 (ref), l_ReplicatedStorage_0 (ref)
        if l_TextChatService_0.ChatVersion == Enum.ChatVersion.TextChatService then
            l_TextChatService_0.TextChannels.RBXGeneral:SendAsync(v41);
        else
            l_ReplicatedStorage_0.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v41, "All");
        end;
    end;
    task.spawn(function()
        -- upvalues: v42 (ref)
        v42("-`C\194\180-");
    end);
    local v43 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jeffepicy/OrionGod/refs/heads/main/CosmicOrion", true))();
    v43:MakeNotification({
        Name = "Welcome to Cosmic Hub!", 
        Content = "You\226\128\153re Whitelisted! wink wink", 
        Image = "rbxassetid://4483345998", 
        Time = 20
    });
    local v44 = v43:MakeWindow({
        Name = "Cosmic Hub FTAP", 
        HidePremium = false, 
        SaveConfig = true, 
        ConfigFolder = "CosmicHubFTAPConfig"
    });
    local v45 = v44:MakeTab({
        Name = "Player", 
        Icon = "rbxassetid://6031075927", 
        PremiumOnly = false
    });
    local _ = v45:AddSection({
        Name = "Movement"
    });
    local v47 = {
        Walkspeed = false, 
        WalkspeedValue = 5, 
        InfiniteJump = false, 
        InfiniteJumpPower = 100, 
        Noclip = false, 
        Connections = {}
    };
    local l_UserInputService_0 = game:GetService("UserInputService");
    v47.WalkspeedFunc = function()
        -- upvalues: v47 (ref), l_RunService_0 (ref), l_Players_0 (ref)
        if v47.Connections.WS then
            v47.Connections.WS:Disconnect();
        end;
        if v47.Walkspeed then
            v47.Connections.WS = l_RunService_0.Stepped:Connect(function()
                -- upvalues: l_Players_0 (ref), v47 (ref)
                p = l_Players_0.LocalPlayer;
                if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and typeof(v47.WalkspeedValue) == "number" then
                    h = p.Character.HumanoidRootPart;
                    u = p.Character:FindFirstChildOfClass("Humanoid");
                    h.CFrame = h.CFrame + u.MoveDirection * (16 * v47.WalkspeedValue / 10);
                end;
            end);
        end;
    end;
    v47.InfiniteJumpFunc = function()
        -- upvalues: v47 (ref), l_UserInputService_0 (ref), l_Players_0 (ref)
        if v47.Connections.JP then
            v47.Connections.JP:Disconnect();
        end;
        if v47.InfiniteJump then
            v47.Connections.JP = l_UserInputService_0.JumpRequest:Connect(function()
                -- upvalues: l_Players_0 (ref), v47 (ref)
                local l_LocalPlayer_3 = l_Players_0.LocalPlayer;
                if l_LocalPlayer_3 and l_LocalPlayer_3.Character and l_LocalPlayer_3.Character:FindFirstChildOfClass("Humanoid") then
                    local l_Humanoid_0 = l_LocalPlayer_3.Character:FindFirstChildOfClass("Humanoid");
                    l_Humanoid_0:ChangeState(Enum.HumanoidStateType.Freefall);
                    task.wait();
                    l_Humanoid_0:ChangeState(Enum.HumanoidStateType.Jumping);
                    if l_Humanoid_0.UseJumpPower == false then
                        l_Humanoid_0.JumpHeight = math.clamp(v47.InfiniteJumpPower / 10, 7.2, 50);
                    else
                        l_Humanoid_0.JumpPower = v47.InfiniteJumpPower;
                    end;
                end;
            end);
        end;
    end;
    v47.NoclipFunc = function()
        -- upvalues: v47 (ref), l_RunService_0 (ref), l_Players_0 (ref)
        if v47.Connections.NC then
            v47.Connections.NC:Disconnect();
        end;
        if v47.Noclip then
            v47.Connections.NC = l_RunService_0.Stepped:Connect(function()
                -- upvalues: l_Players_0 (ref)
                p = l_Players_0.LocalPlayer;
                if p and p.Character then
                    for _, v52 in ipairs(p.Character:GetDescendants()) do
                        if v52:IsA("BasePart") then
                            v52.CanCollide = false;
                        end;
                    end;
                end;
            end);
        end;
    end;
    v45:AddToggle({
        Name = "Walkspeed", 
        Default = false, 
        Callback = function(v53)
            -- upvalues: v47 (ref)
            v47.Walkspeed = v53;
            v47.WalkspeedFunc();
        end
    });
    v45:AddSlider({
        Name = "Speed Multiplier", 
        Min = 1, 
        Max = 5, 
        Default = 0.1, 
        Increment = 0.1, 
        Callback = function(v54)
            -- upvalues: v47 (ref)
            v47.WalkspeedValue = v54;
        end
    });
    v45:AddToggle({
        Name = "Infinite Jump", 
        Default = false, 
        Callback = function(v55)
            -- upvalues: v47 (ref)
            v47.InfiniteJump = v55;
            v47.InfiniteJumpFunc();
        end
    });
    v45:AddSlider({
        Name = "Jump Power", 
        Min = 16, 
        Max = 500, 
        Default = 16, 
        Increment = 1, 
        Callback = function(v56)
            -- upvalues: v47 (ref)
            v47.InfiniteJumpPower = v56;
        end
    });
    v45:AddToggle({
        Name = "Noclip", 
        Default = false, 
        Callback = function(v57)
            -- upvalues: v47 (ref)
            v47.Noclip = v57;
            v47.NoclipFunc();
        end
    });
    local v58 = v44:MakeTab({
        Name = "Invincibility", 
        Icon = "rbxassetid://4483362458", 
        PremiumOnly = false
    });
    local _ = v58:AddSection({
        Name = "Anti"
    });
    local function v63()
        -- upvalues: l_RagdollRemote_0 (ref), v43 (ref), l_Players_0 (ref)
        if l_RagdollRemote_0 then
            for _, v61 in pairs(l_Players_0:GetPlayers()) do
                if v61.Character and v61.Character:FindFirstChild("HumanoidRootPart") then
                    for _ = 1, 150 do
                        l_RagdollRemote_0:FireServer(v61.Character.HumanoidRootPart, 9999999);
                        wait();
                    end;
                end;
            end;
            return;
        else
            v43:MakeNotification({
                Name = "Error", 
                Content = "error", 
                Image = "rbxassetid://4483345998", 
                Time = 3
            });
            return;
        end;
    end;
    v58:AddButton({
        Name = "Anti Ragdoll/Snowball", 
        Callback = function()
            -- upvalues: v63 (ref)
            v63();
        end
    });
    v58:AddButton({
        Name = "Destroy Void", 
        Callback = function()
            -- upvalues: l_Workspace_0 (ref)
            l_Workspace_0.FallenPartsDestroyHeight = -1.0E95;
        end
    });
    local v64 = {
        Players = game:GetService("Players"), 
        ReplicatedStorage = game:GetService("ReplicatedStorage"), 
        RunService = game:GetService("RunService"), 
        LP = game.Players.LocalPlayer
    };
    v64.spawnGucci = function()
        -- upvalues: v64 (ref)
        return v64.ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer("CreatureBlobman", CFrame.new(0, 50000, 0) * CFrame.Angles(-0.7351, 0.9028, 0.6173), Vector3.new(0, 59.667, 0));
    end;
    v64.setup = function()
        -- upvalues: v64 (ref), l_Workspace_0 (ref)
        v64.spawnGucci();
        local l_Name_0 = v64.LP.Name;
        local l_l_Workspace_0_0 = l_Workspace_0;
        local v67 = v64.LP.Character or v64.LP.CharacterAdded:Wait();
        local l_l_l_Workspace_0_0_FirstChild_0 = l_l_Workspace_0_0:FindFirstChild(l_Name_0 .. "SpawnedInToys");
        local v69 = nil;
        local v70 = nil;
        if l_l_l_Workspace_0_0_FirstChild_0 then
            v69 = l_l_l_Workspace_0_0_FirstChild_0:FindFirstChild("CreatureBlobman");
        end;
        if v69 then
            v70 = v69.FindFirstChild(v69, "Head");
        end;
        if v70 then
            v70.CFrame = CFrame.new(0, 50000, 0);
            v70.Anchored = true;
        end;
        task.wait(0.1);
        local l_Humanoid_1 = v67:WaitForChild("Humanoid");
        local l_HumanoidRootPart_0 = v67:WaitForChild("HumanoidRootPart");
        local l_Position_0 = l_HumanoidRootPart_0.Position;
        local v74 = false;
        local v75;
        if v69 then
            v75 = v69.FindFirstChild(v69, "VehicleSeat");
        else
            v75 = v69;
        end;
        if v75 and v75.IsA(v75, "VehicleSeat") then
            l_HumanoidRootPart_0.CFrame = v75.CFrame + Vector3.new(0, 2, 0);
            v75.Sit(v75, l_Humanoid_1);
            v74 = true;
        end;
        l_Humanoid_1:GetPropertyChangedSignal("Jump"):Connect(function()
            -- upvalues: v74 (ref), l_Humanoid_1 (ref), l_HumanoidRootPart_0 (ref), l_Position_0 (ref)
            if v74 and l_Humanoid_1.Jump then
                task.wait(0.02);
                l_HumanoidRootPart_0.CFrame = CFrame.new(l_Position_0);
                v74 = false;
            end;
        end);
        v64.ragdollConn = v64.RunService.Heartbeat:Connect(function()
            -- upvalues: v64 (ref), v74 (ref), l_l_Workspace_0_0 (ref), l_Name_0 (ref)
            if v64.enabled and v74 then
                pcall(function()
                    -- upvalues: v64 (ref), l_l_Workspace_0_0 (ref), l_Name_0 (ref)
                    v64.ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(l_l_Workspace_0_0[l_Name_0].HumanoidRootPart, 0);
                end);
            end;
        end);
        v64.posCheckConn = v64.RunService.Heartbeat:Connect(function()
            -- upvalues: v64 (ref), l_HumanoidRootPart_0 (ref), l_Position_0 (ref), v74 (ref)
            if v64.enabled and (l_HumanoidRootPart_0.Position - l_Position_0).Magnitude < 1 then
                v74 = false;
            end;
        end);
    end;
    v58:AddToggle({
        Name = " Gucci Anti", 
        Default = false, 
        Callback = function(v76)
            -- upvalues: v64 (ref)
            v64.enabled = v76;
            if not v76 then
                if v64.ragdollConn then
                    v64.ragdollConn:Disconnect();
                    v64.ragdollConn = "Disconnect";
                end;
                if v64.posCheckConn then
                    v64.posCheckConn:Disconnect();
                    v64.posCheckConn = "posCheckConn";
                end;
            else
                v64.setup();
            end;
        end
    });
    v58:AddButton({
        Name = "Destroy Gucci (All)", 
        Callback = function()
            -- upvalues: l_Workspace_0 (ref)
            for _, v78 in l_Workspace_0:GetDescendants() do
                if v78.Name == "CreatureBlobman" then
                    v78.VehicleSeat:Sit(game.Players.LocalPlayer.Character.Humanoid);
                    wait(0.05);
                    game.Players.LocalPlayer.Character.Humanoid.Jump = true;
                end;
            end;
        end
    });
    local v79 = false;
    local function v82()
        -- upvalues: v79 (ref), l_LocalPlayer_2 (ref), l_ReplicatedStorage_0 (ref)
        while v79 and task.wait() do
            if l_LocalPlayer_2:FindFirstChild("IsHeld") and l_LocalPlayer_2.IsHeld.Value == true then
                local l_Character_0 = l_LocalPlayer_2.Character;
                if l_Character_0 then
                    local l_HumanoidRootPart_1 = l_Character_0:FindFirstChild("HumanoidRootPart");
                    if l_HumanoidRootPart_1 then
                        l_HumanoidRootPart_1.Anchored = true;
                        while l_LocalPlayer_2.IsHeld.Value == true and v79 do
                            l_ReplicatedStorage_0.CharacterEvents.Struggle:FireServer(l_LocalPlayer_2);
                            task.wait(0.001);
                        end;
                        l_HumanoidRootPart_1.Anchored = false;
                    end;
                end;
            end;
        end;
    end;
    v58:AddToggle({
        Name = "Anti Grab", 
        Default = false, 
        Callback = function(v83)
            -- upvalues: v79 (ref), v82 (ref)
            v79 = v83;
            if v79 then
                task.spawn(v82);
            end;
        end
    });
    local v84 = false;
    local function v89()
        -- upvalues: l_Workspace_0 (ref), v84 (ref), l_LocalPlayer_2 (ref)
        l_Workspace_0.ChildAdded:Connect(function(v85)
            -- upvalues: v84 (ref), l_LocalPlayer_2 (ref)
            if v85:IsA("Part") and v85.Name == "Part" and v84 then
                local l_Character_1 = l_LocalPlayer_2.Character;
                if l_Character_1 then
                    local l_HumanoidRootPart_2 = l_Character_1:FindFirstChild("HumanoidRootPart");
                    local l_l_Character_1_FirstChild_0 = l_Character_1:FindFirstChild("Right Arm");
                    if l_HumanoidRootPart_2 and l_l_Character_1_FirstChild_0 and (v85.Position - l_HumanoidRootPart_2.Position).Magnitude <= 20 then
                        l_HumanoidRootPart_2.Anchored = true;
                        task.wait(0.01);
                        while l_l_Character_1_FirstChild_0:FindFirstChild("RagdollLimbPart") and l_l_Character_1_FirstChild_0.RagdollLimbPart.CanCollide == true do
                            task.wait(0.001);
                        end;
                        l_HumanoidRootPart_2.Anchored = false;
                    end;
                end;
            end;
        end);
    end;
    v58:AddToggle({
        Name = "Anti Explode", 
        Default = false, 
        Callback = function(v90)
            -- upvalues: v84 (ref), v89 (ref)
            v84 = v90;
            if v84 then
                task.spawn(v89);
            end;
        end
    });
    v58:AddToggle({
        Name = "Anti Fire", 
        Default = false, 
        Callback = function(v91)
            local v92 = {
                p = game:GetService("Players").LocalPlayer, 
                rs = game:GetService("RunService"), 
                w = game:GetService("Workspace"), 
                mon = false, 
                con = "con"
            };
            v92.ep = v92.w.Map.Hole.PoisonBigHole.ExtinguishPart;
            v92.op = v92.ep.Position;
            local function v96()
                -- upvalues: v92 (ref)
                local l_HumanoidRootPart_3 = (v92.p.Character or v92.p.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart");
                local l_FireLight_0 = l_HumanoidRootPart_3:FindFirstChild("FireLight");
                local l_FireParticleEmitter_0 = l_HumanoidRootPart_3:FindFirstChild("FireParticleEmitter");
                if l_FireLight_0 or l_FireParticleEmitter_0 then
                    v92.ep.CFrame = CFrame.new(l_HumanoidRootPart_3.Position);
                    while l_FireLight_0 or l_FireParticleEmitter_0 do
                        task.wait(0.1);
                        l_FireLight_0 = l_HumanoidRootPart_3:FindFirstChild("FireLight");
                        l_FireParticleEmitter_0 = l_HumanoidRootPart_3:FindFirstChild("FireParticleEmitter");
                        v92.ep.CFrame = CFrame.new(l_HumanoidRootPart_3.Position);
                    end;
                    v92.ep.CFrame = CFrame.new(v92.op);
                end;
            end;
            v92.mon = v91;
            if v91 then
                if not v92.con then
                    v92.con = v92.rs.Heartbeat:Connect(function()
                        -- upvalues: v92 (ref), v96 (ref)
                        if v92.mon then
                            v96();
                        end;
                    end);
                end;
            else
                v92.ep.CFrame = CFrame.new(v92.op);
                if v92.con then
                    v92.con:Disconnect();
                    v92.con = "Disconnect";
                end;
            end;
        end
    });
    local function v101()
        local l_Character_2 = game.Players.LocalPlayer.Character;
        if l_Character_2 then
            local l_HumanoidRootPart_4 = l_Character_2:FindFirstChild("HumanoidRootPart");
            local l_Humanoid_2 = l_Character_2:FindFirstChild("Humanoid");
            local v100 = game.Players.LocalPlayer:FindFirstChild("PlayerScripts") and game.Players.LocalPlayer.PlayerScripts:FindFirstChild("CharacterAndBeamMove");
            if l_HumanoidRootPart_4 and l_Humanoid_2 and v100 then
                v100.Disabled = antiLagT;
            end;
        end;
    end;
    v58:AddToggle({
        Name = "Anti Lag", 
        Default = false, 
        Callback = function(v102)
            -- upvalues: v101 (ref)
            antiLagT = v102;
            v101();
        end
    });
    local function v107()
        -- upvalues: l_LocalPlayer_0 (ref), l_Workspace_0 (ref)
        local l_Character_3 = l_LocalPlayer_0.Character;
        if l_Character_3 then
            local l_HumanoidRootPart_5 = l_Character_3:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_5 then
                for _, v106 in pairs(l_Workspace_0:GetDescendants()) do
                    if v106:IsA("BasePart") and (v106.Name == "LeftDetector" or v106.Name == "RightDetector") an
  end
  })
