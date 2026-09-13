-- ==========================================================
-- ⚔️ PvP TAB CONFIGURATION (Rayfield UI)
-- ==========================================================
local PvpTab = Window:CreateTab("⚔️ PvP", 4483345998) -- Creates the Tab
PvpTab:CreateSection("Combat & Targeting")

-- Global Variables for tracking states
local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.AimbotEnabled = false
_G.HitboxSize = 2

-- 1. CAMERA AIMBOT TOGGLE
PvpTab:CreateToggle({
   Name = "Camera Aimbot (Closest Target)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AimbotEnabled = Value
       
       -- Background loop that snaps camera to the nearest living player
       task.spawn(function()
           while _G.AimbotEnabled do
               local closestPlayer = nil
               local shortestDistance = math.huge
               
               for _, player in ipairs(Players:GetPlayers()) do
                   if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                       local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                       if distance < shortestDistance then
                           shortestDistance = distance
                           closestPlayer = player
                       end
                   end
               end
               
               -- Lock camera onto the target's head if found
               if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
                   Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
               end
               
               task.wait(0.01) -- Fast loop for smooth locking
           end
       end)
   end,
})

-- 2. HITBOX EXPANDER SLIDER
PvpTab:CreateSlider({
   Name = "Hitbox Expander (Head Size)",
   Range = {2, 35}, -- 2 is normal Roblox size, 35 is giant
   Increment = 1,
   CurrentValue = 2,
   Callback = function(Value)
       _G.HitboxSize = Value
       
       -- Updates enemy head sizes instantly whenever you move the slider
       for _, player in ipairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
               player.Character.Head.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
               player.Character.Head.CanCollide = true
               
               -- Make the head semi-transparent when giant so it doesn't block your view
               if _G.HitboxSize > 2 then
                   player.Character.Head.Transparency = 0.5
               else
                   player.Character.Head.Transparency = 0
               end
           end
       end
   end,
})
