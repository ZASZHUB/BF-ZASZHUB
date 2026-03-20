local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ZASZ_HUB"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 260)
frame.Position = UDim2.new(0.5, -130, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "ZASZ HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)

-- Button creator
function createBtn(name, posY)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 230, 0, 40)
    btn.Position = UDim2.new(0,15,0,posY)
    btn.Text = name.." [OFF]"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    return btn
end

-- Buttons
local speedBtn = createBtn("Speed", 50)
local flyBtn = createBtn("Fly", 100)
local hitboxBtn = createBtn("Hitbox", 150)

-- STATES
local speedOn = false
local flyOn = false
local hitboxOn = false

-- SPEED
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    if speedOn then
        char.Humanoid.WalkSpeed = 50
        speedBtn.Text = "Speed [ON]"
    else
        char.Humanoid.WalkSpeed = 16
        speedBtn.Text = "Speed [OFF]"
    end
end)

-- FLY
local bodyVel
flyBtn.MouseButton1Click:Connect(function()
    flyOn = not flyOn
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if flyOn then
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(9999,9999,9999)
        bodyVel.Velocity = Vector3.new(0,0,0)
        bodyVel.Parent = hrp

        flyBtn.Text = "Fly [ON]"

        game:GetService("RunService").RenderStepped:Connect(function()
            if flyOn then
                bodyVel.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
            end
        end)

    else
        if bodyVel then bodyVel:Destroy() end
        flyBtn.Text = "Fly [OFF]"
    end
end)

-- HITBOX EXPANDER
hitboxBtn.MouseButton1Click:Connect(function()
    hitboxOn = not hitboxOn

    for _,v in pairs(game.Players:GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local part = v.Character.HumanoidRootPart

            if hitboxOn then
                part.Size = Vector3.new(10,10,10)
                part.Transparency = 0.5
                part.CanCollide = false
            else
                part.Size = Vector3.new(2,2,1)
                part.Transparency = 1
                part.CanCollide = false
            end
        end
    end

    hitboxBtn.Text = hitboxOn and "Hitbox [ON]" or "Hitbox [OFF]"
end)
