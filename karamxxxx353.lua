-- KARAM CHEATS | MM2 STABLE EDITION | karamxxxx353
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local LocalPlayer = Players.LocalPlayer

-- 1. الواجهة والزر العائم
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KaramUI"

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.Text = "K"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 420)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 0, 80)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(150, 50, 255)
Stroke.Thickness = 2

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- نظام السحب المخصص للـ MainFrame
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        update(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- 2. الحقوق
local function createCredit(yPos)
    local Label = Instance.new("TextLabel", MainFrame)
    Label.Size = UDim2.new(0.9, 0, 0, 30)
    Label.Text = "Karam Cheats | karamxxxx353"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextTransparency = 0.3
    Label.Font = Enum.Font.GothamBold
    Label.Position = UDim2.new(0.05, 0, yPos, 0)
    return Label
end

local TopCredit = createCredit(0.05)
local BottomCredit = createCredit(0.9)

RunService.RenderStepped:Connect(function()
    local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
    TopCredit.TextColor3 = color
    BottomCredit.TextColor3 = color
    
    local speed = 1.5
    local range = 0.08
    local xPos = math.abs(math.sin(tick() * speed)) * range
    
    TopCredit.Position = UDim2.new(0.05 + xPos, 0, 0.05, 0)
    BottomCredit.Position = UDim2.new(0.05 + xPos, 0, 0.9, 0)
end)

-- 3. دالة الأزرار
local function createIOSSwitch(text, yPos, callback)
    local label = Instance.new("TextLabel", MainFrame)
    label.Size = UDim2.new(0.6, 0, 0, 40)
    label.Position = UDim2.new(0.05, 0, 0, yPos)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamSemibold
    
    local bg = Instance.new("Frame", MainFrame)
    bg.Size = UDim2.new(0, 50, 0, 28)
    bg.Position = UDim2.new(0.75, 0, 0, yPos + 6)
    bg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame", bg)
    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = UDim2.new(0.08, 0, 0.08, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        TweenService:Create(knob, TweenInfo.new(0.3), {Position = state and UDim2.new(0.5, 0, 0.08, 0) or UDim2.new(0.08, 0, 0.08, 0)}):Play()
        bg.BackgroundColor3 = state and Color3.fromHSV(tick() % 5 / 5, 0.8, 1) or Color3.fromRGB(60, 60, 60)
    end)
end

-- 4. الميزات الأساسية
createIOSSwitch("ESP Roles", 60, function(s)
    if s then
        _G.ESPConn = RunService.RenderStepped:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local isMurderer = p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife")
                    local isSheriff = p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun")
                    if not p.Character:FindFirstChild("RoleHighlight") then
                        local h = Instance.new("Highlight", p.Character)
                        h.Name = "RoleHighlight"
                    end
                    p.Character.RoleHighlight.FillColor = isMurderer and Color3.fromRGB(255, 0, 0) or (isSheriff and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(0, 255, 0))
                end
            end
        end)
    else
        if _G.ESPConn then _G.ESPConn:Disconnect() end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("RoleHighlight") then p.Character.RoleHighlight:Destroy() end
        end
    end
end)

createIOSSwitch("Noclip", 120, function(s)
    _G.Noclip = s
    if s then
        _G.NC = RunService.Stepped:Connect(function()
            if _G.Noclip and LocalPlayer.Character then
                for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
            end
        end)
    else
        if _G.NC then _G.NC:Disconnect() end
    end
end)

createIOSSwitch("Click TP", 180, function(s)
    _G.ClickTP = s
    if s then
        _G.TPConn = Mouse.Button1Down:Connect(function()
            if _G.ClickTP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end)
    else
        if _G.TPConn then _G.TPConn:Disconnect() end
    end
end)

-- 5. أزرار التليبورت
local function TeleportToRole(role)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hasKnife = p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife")
            local hasGun = p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun")
            
            if (role == "Murderer" and hasKnife) or (role == "Sheriff" and hasGun) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                break
            end
        end
    end
end

local function createTeleportButton(text, yPos, role)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function() TeleportToRole(role) end)
end

createTeleportButton("TP to Murderer", 240, "Murderer")
createTeleportButton("TP to Sheriff", 290, "Sheriff")

-- إضافة التأثيرات في النهاية
local function addEffect(parent)
    -- تأثير النار
    local fire = Instance.new("Fire", parent)
    fire.Color = Color3.fromRGB(255, 100, 50)
    fire.SecondaryColor = Color3.fromRGB(255, 0, 0)
    fire.Heat = 10
    fire.Size = 5
    
    -- تأثير الشرار
    local sparkles = Instance.new("Sparkles", parent)
    sparkles.SparkleColor = Color3.fromRGB(255, 255, 255)
    
    -- تأثير النبض للزر
    spawn(function()
        while true do
            TweenService:Create(parent, TweenInfo.new(0.5), {Size = UDim2.new(0, 65, 0, 65)}):Play()
            wait(0.5)
            TweenService:Create(parent, TweenInfo.new(0.5), {Size = UDim2.new(0, 60, 0, 60)}):Play()
            wait(0.5)
        end
    end)
end

addEffect(ToggleBtn)
