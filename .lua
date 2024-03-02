local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - Created by Asya")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Egg")
local T3 = wndw:Tab("Pet Training")

local vendors = {}
local td = {
         arg = {
             str1 = "1",
             str2 = "1"
  }
}

lib:AddTable(workspace["EggVendors"],vendors)

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

T1:Button("Claim all battlepass [ Bypass Requirement ]",function()
    for array = 1,20 do
      game:GetService("ReplicatedStorage")["Events"]["UpdateSeasonPass"]:FireServer(array,"Free")
    end
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

lib:HookFunction(function(method,self,args)
    if self == "PetTraining" and method == "FireServer" then
      td.arg.str1 = tostring(args[1])
      td.arg.str2 = tostring(args[2])
    end
end)
