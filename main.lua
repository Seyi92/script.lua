-- 0. Safety Check: Wait until the game loads fully
if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. DELTA COMPATIBLE LOADSTRING (Direct Raw GitHub Link)
local Rayfield = loadstring(game:HttpGet('https://githubusercontent.com'))()

-- 2. Create the Main Menu Window
local Window = Rayfield:CreateWindow({
   Name = "Oceanic Script Hub (Delta Fixed)",
   LoadingTitle = "Initializing UI...",
   LoadingSubtitle = "Delta Executor Version",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- 3. Create the 3 Tabs at the Top
local PvpTab = Window:CreateTab("⚔️ PvP", nil)
local FarmTab = Window:CreateTab("🚜 Farming", nil)
local SeaTab = Window:CreateTab("🌊 Sea Events", nil)

-- ==========================================================
-- ⚔️ PvP TAB SCRIPTS
-- ==========================================================
PvpTab:CreateSection("Target Lock & Hitboxes")

local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
_G.AimbotEnabled = false
_G.HitboxSize = 2

PvpTab:CreateToggle({
   Name = "Camera Aimbot (Closest Player)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AimbotEnabled = Value
       
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
               
               if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
                   Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
               end
               
               task.wait(0.03) -- Delta Mobile adjustment: Slightly slower loop to prevent crashing mobile CPUs
           end
       end)
   end,
})

PvpTab:CreateSlider({
   Name = "Hitbox Expander (Head Size)",
   Range = {2, 30},
   Increment = 1,
   CurrentValue = 2,
   Callback = function(Value)
       _G.HitboxSize = Value
       
       for _, player in ipairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
               player.Character.Head.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
               player.Character.Head.CanCollide = true
               
               if _G.HitboxSize > 2 then
                   player.Character.Head.Transparency = 0.5
               else
                   player.Character.Head.Transparency = 0
               end
           end
       end
   end,
})
