local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - null")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Egg")
local T3 = wndw:Tab("Pet Training")
local T4 = wndw:Tab("Arcane Chest")
local T5 = wndw:Tab("Quest")
local T6 = wndw:Tab("ESP & Chest")

local user = game:GetService("Players").LocalPlayer
local vendors = {}
local workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local normg = workspace.Gravity
local npc = {}
local esp = {
	tracer = false,
	hitbox = false
}

local td = {
         arg = {
             str1 = "1",
             str2 = "1",
	     am = 0
  }
}

lib:AddTable(workspace["EggVendors"],vendors)
lib:AddTable(workspace["QuestNPCs"],npc)

local function NewLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.Name = "Chest Line"
    line.From = Vector2.new(0,0)
    line.To = Vector2.new(1,1)
    line.Color = Color3.fromRGB(0,255,50)
    line.Thickness = 1.4
    line.Transparency = 0
    return line
end

local function hitboxESP(str)
if esp.hitbox == true then
	local espHITBOX = Instance.new("Highlight")
	espHITBOX.Name = "Hitbox ESP"
	espHITBOX.FillColor = Color3.new(0,1,0)
	espHITBOX.OutlineColor = Color3.new(1,1,1)
	espHITBOX.FillTransparency = 0
	espHITBOX.OutlineTransparency = 0
	espHITBOX.Adornee = str
	espHITBOX.Parent = str
	espHITBOX.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end
end

local empt = nil
for i,v in pairs(workspace["HiddenChests"]:GetDescendants()) do
	if v.Name == "Sparkle" then
		if empt then
			empt:Disconnect()
		end

		local lines = {
			trace = NewLine()
		}

		local function REPLIT()
			local Scale = v.Size.Y/2
			local Size = Vector3.new(2,3,1.5) * (Scale * 2)
		    if esp.tracer == true then
                        local trace = camera:WorldToViewportPoint((v.CFrame * CFrame.new(0,-Size.Y,0)).p)

                        lines.trace.From = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y)
                        lines.trace.To = Vector2.new(trace.X,trace.Y)
                    end
		end
		empt = RunService.RenderStepped:Connect(REPLIT)
		hitboxESP(v)
	end
end

workspace["HiddenChests"].DescendantAdded:Connect(function(v)
    if v.Name == "Sparkle" then
	if empt then
		empt:Disconnect()
	end

	local lines = {
		trace = NewLine()
	}

	local function REPLIT()
		local Scale = v.Size.Y/2
		local Size = Vector3.new(2,3,1.5) * (Scale * 2)
		if esp.tracer == true then
			local trace = camera:WorldToViewportPoint((v.CFrame * CFrame.new(0,-Size.Y,0)).p)
                        lines.trace.From = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y)
                        lines.trace.To = Vector2.new(trace.X,trace.Y)
                end
	end
		empt = RunService.RenderStepped:Connect(REPLIT)
		hitboxESP(v)
    end
end)

local function Bring(part)
	TweenService:Create(part,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = user.Character.HumanoidRootPart.CFrame}):Play()
end

local function tween(array)
	TweenService:Create(user.Character.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = array}):Play()
end

local function getChild(str,funct)
         for i,v in pairs(str:GetChildren()) do
                  funct(v)
         end
end

local function UserWarning(str,params)
	lib:WarnUser(str,{
		AutoClose = params[1],
		CanClick = params[2],
		Duration = params[3]
	})
end -- UserWarning("Turtle AI are looking for stray or lost pets",{true,false,10})

local function AI(str)
task.spawn(function()
	if td.arg.am == 0 then
		if workspace["QuestNPCs"]:FindFirstChild(str) then
			UserWarning("Turtle AI was reading the dialogue of the quest given by the npc\nStart in 5s",{true,false,5})
	                wait(5)
	                game:GetService("ReplicatedStorage")["Events"]["SendNPCQuestData"]:FireServer(str,"yes")
		        wait(0.5)
	                UserWarning("Turtle AI are looking for stray or lost pets",{true,false,10})
	                wait(10)
	                game:GetService("ReplicatedStorage")["Events"]["PlayerCollectedLostPet"]:FireServer(str)
		        wait(0.5)
	                UserWarning("Turtle AI was reading the dialogue given by the npc again\nComplete in 3s",{true,false,3})
	                wait(3)
		        game:GetService("ReplicatedStorage")["Events"]["SendNPCQuestData"]:FireServer(str,"yes")
	                UserWarning("AI Turtle has completed the quest given by the npc\n" .. lib:ColorFonts("Enjoy!","Yellow"),{false,true,10})
		else
			UserWarning(lib:ColorFonts("Error","Red") .. "\ncannot find that npc, enter a valid name",{false,true,10})
		end
	else
		UserWarning("The quest is already " .. lib:ColorFonts("COMPLETED","Green"),{false,true,10})
	end
end)
wait(0.1)
td.arg.am = 1
end

local function triggerProximity(str)
	for i,v in pairs(str:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			fireproximityprompt(v)
		end
	end
end

T1:Toggle("Auto click",false,function(value)
    _G.click = value
    while wait() do
      if _G.click == false then break end
      game:GetService("ReplicatedStorage")["Events"]["DamageIncreaseOnClickEvent"]:FireServer()
    end
end)

T1:Toggle("Auto claim hourly rewards",false,function(value)
    _G.hrew = value
    while wait() do
      if _G.hrew == false then break end
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("1")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("2")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("3")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("4")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("5")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("6")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("7")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("8")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("9")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("10")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("11")
      game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer("12")
    end
end)

T1:Toggle("Auto end fight",false,function(value)
    _G.endf = value
    while wait() do
      if _G.endf == false then break end
      game:GetService("ReplicatedStorage")["Events"]["EndBattle"]:FireServer(user)
    end
end)

T1:Toggle("Auto spin",false,function(value)
    _G.spinwheel = value
    while wait() do
      if _G.spinwheel == false then break end
      game:GetService("ReplicatedStorage")["Events"]["SpinWheelEvent"]:FireServer("Spin")
      game:GetService("ReplicatedStorage")["Events"]["SpinWheelEvent"]:FireServer("SpinComplete")
    end
end)

T1:Button("Claim all battlepass [ Bypass Requirement ]",function()
    for array = 1,20 do
      game:GetService("ReplicatedStorage")["Events"]["UpdateSeasonPass"]:FireServer(array,"Free")
    end
end)

T1:Button("Join obby",function()
         game:GetService("ReplicatedStorage")["Events"]["PetTraining"]:FireServer("1","Obby")
end)

T2:Dropdown("Select eggs",vendors,function(value)
    _G.eggvendorsvfp = value
end)

T2:Toggle("Hatch egg",false,function(value)
    _G.heg = value
    while wait() do
      if _G.heg == false then break end
      game:GetService("ReplicatedStorage")["Events"]["PlayerPressedKeyOnEgg"]:FireServer(_G.eggvendorsvfp)
    end
end)

T3:Toggle("Instant kill training dumny",false,function(value)
    _G.iktd = value
    while wait() do
      if _G.iktd == false then break end
      game:GetService("ReplicatedStorage")["Events"]["PlayerDefeatedTrainingDummy"]:FireServer(td.arg.str1,td.arg.str2)
    end
end)

T3:Toggle("Auto collect XP",false,function(value)
    _G.cXP = value
    while wait() do
      if _G.cXP == false then break end
      game:GetService("ReplicatedStorage")["CollectedCurrency"]:FireServer("XP",9e9)
    end
end)

T3:Toggle("Auto click mana",false,function(value)
    _G.clickmana = value
    while wait() do
      if _G.clickmana == false then break end
      game:GetService("ReplicatedStorage")["Events"]["PetBattleCLIENTtoBACKENDRemoteEvent"]:FireServer("playerClickedForMana")
    end
end)

lib:HookFunction(function(method,self,args)
    if self == "PetTraining" and method == "FireServer" then
      td.arg.str1 = tostring(args[1])
      td.arg.str2 = tostring(args[2])
    end
end)

T1:Toggle("Auto collect XP from obby",false,function(value)
         _G.XPpt = value
         while wait() do
                  if _G.XPpt == false then break end
                           getChild(workspace["XPParts"],function(v)
                                    Bring(v)
                           end)
         end
end)

T1:Toggle("Auto collect XP from pet training",false,function(value)
         _G.CoinsCol = value
end)

local lab = {
	["Chest Name"] = "StarterCrate",
	["Chest Price"] = 5,
	["Chest Open Amount"] = 1
}

local indc = T4:Label("Chest indicators\n\nChest name : {%s}\nChest price : {%s} Arcane Starts")
indc:EditLabel("Chest indicators\n\nChest name : " .. lab["Chest Name"] .. "\nChest price : " .. lab["Chest Price"] .. " Arcane Stars")

T4:Dropdown("Select chest",{"StarterCrate","BlueCrate","GreenCrate","RobuxCrate"},function(value)
	lab["Chest Name"] = value
	indc:EditLabel("Chest indicators\n\nChest name : " .. lab["Chest Name"] .. "\nChest price : " .. lab["Chest Price"] .. " Arcane Stars")
	if lab["Chest Name"] == "StarterCrate" then
		lab["Chest Price"] = 5
	elseif lab["Chest Name"] == "BlueCrate" then
		lab["Chest Price"] = 50
	elseif lab["Chest Name"] == "GreenCrate" then
		lab["Chest Price"] = 250
	else
		indc:EditLabel("Chest indicators\n\nAI: failed to calculate the price, try again later.")
	end
end)

T4:Slider("Open amount",0,50,1,function(value)
	lab["Chest Open Amount"] = value
	if lab["Chest Name"] == "StarterCrate" then
		lab["Chest Price"] = 5 * tonumber(value)
		indc:EditLabel("Chest indicators\n\nChest name : " .. lab["Chest Name"] .. "\nChest price : " .. lab["Chest Price"] .. " Arcane Stars")
	elseif lab["Chest Name"] == "BlueCrate" then
		lab["Chest Price"] = 50 * tonumber(value)
		indc:EditLabel("Chest indicators\n\nChest name : " .. lab["Chest Name"] .. "\nChest price : " .. lab["Chest Price"] .. " Arcane Stars")
	elseif lab["Chest Name"] == "GreenCrate" then
		lab["Chest Price"] = 250 * tonumber(value)
		indc:EditLabel("Chest indicators\n\nChest name : " .. lab["Chest Name"] .. "\nChest price : " .. lab["Chest Price"] .. " Arcane Stars")
	else
		indc:EditLabel("Chest indicators\n\nAI: failed to calculate the price, try again later.")
	end
end)

T4:Toggle("Open chest",false,function(value)
         _G.och = value
	while wait() do
		if _G.och == false then break end
			game:GetService("ReplicatedStorage")["Events"]["PlayerOpenEnchantmentCrate"]:FireServer(lab["Chest Name"],lab["Chest Open Amount"])
	end
end)

T5:Dropdown("Select NPC",npc,function(value)
	_G.QNPC = value
end)

T5:Button("AI NPC Quest Completed",function()
	AI(_G.QNPC)
end)

T6:Toggle("ESP hidden chest",false,function(value)
	esp.tracer = value
	esp.hitbox = value
	for i,v in pairs(workspace["HiddenChests"]:GetDescendants()) do
		if v:IsA("Line") or v.Name == "Chest Line" then
			v.Visible = value
			hitboxESP(v)
		end
	end
end)

local world = {
	["1"] = CFrame.new(-1177,67,3391),
	["2"] = CFrame.new(-1552,97,2622),
	["3"] = CFrame.new(-760,101,2688),
	["4"] = CFrame.new(-594,105,1723),
	["Middle"] = CFrame.new(-1168,100,2693)
}

T6:Button("Tween collect all hidden chest",function()
	workspace.Gravity = 0
	tween(world["1"])
	triggerProximity(workspace["HiddenChests"]["1"])
	wait(1.5)
	tween(world["Middle"])
	wait(2)
	tween(world["2"])
	triggerProximity(workspace["HiddenChests"]["2"])
	wait(1.5)
	tween(world["Middle"])
	wait(2)
	tween(world["3"])
	triggerProximity(workspace["HiddenChests"]["3"])
	wait(1.5)
	tween(world["Middle"])
	wait(2)
	tween(world["4"])
	triggerProximity(workspace["HiddenChests"]["4"])
	wait(1.5)
	workspace.Gravity = normg
end)

workspace["ClientCoinsGems"].ChildAdded:Connect(function(itm)
         if _G.CoinsCol == true then
                  Bring(itm)
         end
end)

user["Character"]["HumanoidRootPart"]:GetPropertyChangedSignal("Position"):Connect(function()
	getChild(workspace["ClientCoinsGems"],function(v)
                Bring(v)
        end)
end)
