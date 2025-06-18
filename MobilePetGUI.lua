-- Mobile-Only Exploit-Style GUI (LocalScript)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PetGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Main window
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title Bar
local titleBar = Instance.new("TextLabel", frame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.Text = "🐾 Pet Manager"
titleBar.TextScaled = true
titleBar.Font = Enum.Font.GothamBold
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)

-- Make it draggable via touch
local dragging, dragStart, startPos = false, nil, nil

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Duplicate Pet Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.55, 0)
button.Text = "➕ Duplicate Pet"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.BorderSizePixel = 0

local buttonCorner = Instance.new("UICorner", button)
buttonCorner.CornerRadius = UDim.new(0, 10)

-- When button is tapped
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("DuplicatePetEvent") -- must exist in your game

button.MouseButton1Click:Connect(function()
	local petName = "BeePet" -- Or dynamic based on selection
	remote:FireServer(petName)
end)
