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

AddButton(Tab4o, {
     Name = "Free gamepass (NoKey)",
    Callback = function()
	   loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()
  end
  })
