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
    SubTitle="Tổng Hợp Script",
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
    Main3=Window:AddTab({Title="Free gamepass"})
    Main4=Window:AddTab({Title="Auto jump"})
    Main5=Window:AddTab({Title="Evade"})
    Main6=Window:AddTab({Title="Infinite yield"})
    Main7=Window:AddTab({Title="Speed Hub"})
    Main8=Window:AddTab({Title="Granny Multiplayer"})
    Main9=Window:AddTab({Title="volleyball Legend"})
    Main10=Window:AddTab({Title="TSB"})
}

-- Tab 0: Thông Tin
Tabs.Main0:AddButton({
    Title="Youtuber",
    Description="Cat",
    Callback=function()
        setclipboard("https://www.youtube.com/@Danh-RobloxVNG")
    end
})

-- Tab 1: Blox Fruits
Tabs.Main1:AddButton({
    Title="Those who remain",
    Callback=function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/vothanhdanhwibu-bot/Script/refs/heads/main/Script-THOSE-WHO-REMAIN"))()
    end
})
Tabs.Main2:AddButton({
    Title="Forsaken",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ImDevsVeux/VeuxS/refs/heads/main/obfuscated_script-1763256367184.lua.txt"))()
    end
})
Tabs.Main3:AddButton({
    Title="Free gamepass",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()
    end
})
Tabs.Main4:AddButton({
    Title="Auto jump   Không chạm đất",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/catwljzy/catwljz/refs/heads/main/aotojump.txt"))()
    end
})
Tabs.Main4:AddButton({
    Title="Auto jump   chạm đất",
    Callback=function()
        https://pastefy.app/D7XFp8bZ/raw
    end
})
Tabs.Main5:AddButton({
    Title="Evade",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scv8contact-cpu/Whakizashi-hub-x/refs/heads/main/WhakizashiHubX-Evade"))()
    end
})
Tabs.Main6:AddButton({
    Title="Infinite yield",
    Callback=function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
Tabs.Main7:AddButton({
    Title="Speed Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})
Tabs.Main8:AddButton({
    Title="Granny Multiplayer",
    Callback=function()
        loadstring(game:HttpGet("https://pastebin.com/raw/yYQMZUb6"))()
    end
})
Tabs.Main9:AddButton({
    Title="volleyball Legend",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))()
    end
})
Tabs.Main10:AddButton({
    Title="TSB",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))()
    end
})local ScreenGui = Instance.new("ScreenGui")
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vothanhdanhwibu-bot/Script/refs/heads/main/Script-THOSE-WHO-REMAIN"))()
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
