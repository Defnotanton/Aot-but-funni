function Check(Size, Transparency, Color)
	for i, v in pairs(game.Workspace.map.titans:GetChildren()) do
		pcall(function()
			v.Nape.Size = Vector3.new(Size, Size, Size)
			v.Nape.Transparency = Transparency
			v.Nape.Color = Color
			v.Nape.Material = "Neon"
			v.Nape.CanCollide = false
		end)
	end
end

local UiLib = loadstring(game:HttpGet("https://pastebin.com/raw/njPmqnJQ"))()
local Window = UiLib:CreateWindow("Attack on titans but you're the main character")
local Page1 = Window:CreatePage("Titans")
local Page2 = Window:CreatePage("Player")
local Settings = Window:CreatePage("Settings")
local Size = 10
local Color = Color3.fromRGB(255,255,255)
local Transparency = 0.89
local On = false
local AlwaysHeal = false
local On3

Settings:NewColorPicker("White", "Topbar color", function(Color)
	Window:Theme(Color, "TopBar")
end)

Settings:NewColorPicker("White", "Tabs color", function(Color)
	Window:Theme(Color, "Tabs")
end)

Settings:NewColorPicker("White", "Background color", function(Color)
	Window:Theme(Color, "BackGround")
end)

Settings:NewColorPicker("White", "Shadow color", function(Color)
	Window:Theme(Color, "Shadow")
end)

Settings:NewToggle("Always Heal", function(e)
	AlwaysHeal = e
end)

Settings:NewToggle("Inf Jump", function(e)
	On3 = e
end)

Settings:NewButton("Rejoin", function()
	game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end)

Page1:NewButton("Kill all titans", function()
	for Index, Idiot in pairs(game.Workspace.map.titans:GetChildren()) do
		workspace.GameScript.DamageTitan:FireServer(239, Idiot, 1, "1999")
	end
end)

Page1:NewToggle("Hitbox", function(a)
	On = a
	Check(Size, Transparency, Color)
end)

Page1:NewColorPicker(Color, "Hitbox Color", function(NewColor)
	print(NewColor)
	Color = NewColor
	Check(Size, Transparency, Color)
end)

Page1:NewText("Hitbox Transparency", "Value...", function(NewTransparency)
	Transparency = NewTransparency or 0.89
	Check(Size, Transparency, Color)
end)

Page1:NewSlider("Hitbox Size", 100, 10, function(NewSize)
	Size = NewSize
	Check(Size, Transparency, Color)
end)

Page2:NewButton("Heal", function()
	workspace.GameScript.BandagePerson:FireServer(game:GetService("Players").LocalPlayer.Character)
end)

Page2:NewButton("Get supplies", function()
	workspace.GameScript.SendGas:FireServer(game:GetService("Players").LocalPlayer)
end)

game.Workspace.map.titans.ChildAdded:Connect(function()
	if On then
		Check(Size, Transparency, Color)
	end
end)

while wait(2) do
	if AlwaysHeal then
		workspace.GameScript.BandagePerson:FireServer(game:GetService("Players").LocalPlayer.Character)
	end
end

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(Key)
	if On3 and Key == " " then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
	end
end)