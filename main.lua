--Load the UI Library from the internet
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- 2. Create the main popup window interface
local Window = OrionLib:MakeWindow({
    Name = "My Mobile Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MobileHubConfig"
})

-- 3. Add a navigation tab inside the window
local MainTab = Window:MakeTab({
    Name = "Automation",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- 4. Add a functioning toggle button to the tab
MainTab:AddToggle({
    Name = "Auto Farm Test",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        -- The logic loop that runs when the toggle is flipped ON
        if _G.AutoFarm then
            print("Auto farm activated!")
            -- Add your continuous loop game mechanics here
        else
            print("Auto farm deactivated!")
        end
    end    
})

-- Initialize the visual library interface
OrionLib:Init()
