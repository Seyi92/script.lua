-- 1. Load the UI Library from the internet (Fully Corrected Link)
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

-- 4. Add a functioning toggle button with character movement logic
MainTab:AddToggle({
    Name = "Auto Farm Test",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        -- The logic loop that triggers when the toggle is flipped ON
        task.spawn(function()
            while _G.AutoFarm do
                task.wait(0.1) -- Prevents the script from freezing the mobile client
                
                -- Check if a valid target enemy exists in the workspace environment
                local Enemy = workspace.Enemies:FindFirstChild("Bandit")
                if Enemy and Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 then
                    
                    local LocalPlayer = game.Players.LocalPlayer
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        
                        -- Smoothly update character CFrame coordinates above the target vector
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        
                        -- Fire attack input simulation to swing the active weapon tool
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                    end
                end
            end
        end)
    end    
})

-- Initialize the visual library interface
OrionLib:Init()
