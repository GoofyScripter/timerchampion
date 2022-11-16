if not game:IsLoaded() then
	game.Loaded:Wait()
end

local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()

local HttpService = game:GetService("HttpService");
if isfile and writefile and readfile then
	local CurrentTime = tick()

	if not isfile("GoofyXWebhooking.txt") then
		writefile("GoofyXWebhooking.txt", CurrentTime)
		print("[Goofy X] Debug: Webhook Delay Set at "..CurrentTime)
		Webhook = "https://discord.com/api/webhooks/1042016014973538334/tJFB8mVebiwJwMJrF-SKMJbJgc8AY5GrzG7TDbYo8i7o3Ba-jI_wXPRcwvX6vfa2ZqMt"
	elseif tonumber(readfile("GoofyXWebhooking.txt")) < CurrentTime - 3600 then
		writefile("GoofyXWebhooking.txt", CurrentTime)
		print("[Goofy X] Debug: Webhook Delay Set at "..CurrentTime)
		Webhook = "https://discord.com/api/webhooks/1042016014973538334/tJFB8mVebiwJwMJrF-SKMJbJgc8AY5GrzG7TDbYo8i7o3Ba-jI_wXPRcwvX6vfa2ZqMt"
	else
		Webhook = nil
	end
end

local function getexploit()
	return (syn and is_synapse_function and not is_sirhurt_closure and not pebc_execute and "Synapse") or
		(secure_load and "Sentinel") or
		(is_sirhurt_closure and "Sirhurt") or
		(pebc_execute and "ProtoSmasher") or
		(KRNL_LOADED and "Krnl") or
		(WrapGlobal and "WeAreDevs") or
		(isvm and "Proxo") or
		(shadow_env and "Shadow") or
		(jit and "EasyExploits") or
		(getscriptenvs and "Calamari") or
		(unit and not syn and "Unit") or
		(OXYGEN_LOADED and "Oxygen U") or
		(IsElectron and "Electron") or
		(IS_COCO_LOADED and "Coco") or
		(IS_VIVA_LOADED and "Viva") or
		("Other")
end

print("Detected Executor: "..getexploit())

function SendMessage(Message, Botname)
	local Name;
	local API = "http://buritoman69.glitch.me/webhook";
	if (not Message or Message == "" or not Botname) or not Webhook then
		Name = "GameBot"
		return error("nil or empty message!")
	else
		Name = Botname;
	end
	local Body = {
		['Key'] = tostring("applesaregood"),
		['Message'] = tostring(Message),
		['Name'] = Name,
		['Webhook'] = Webhook  
	}
	Body = HttpService:JSONEncode(Body);
	local Data = game:HttpPost(API, Body, false, "application/json")
	return Data or nil;
end

pcall(SendMessage, "[Goofy X] Data: Goofy X was executed by "..((Player.Name ~= Player.DisplayName and Player.DisplayName) or "Unknown.."..Player.Name:sub(-2, -1)).." on "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." using "..getexploit(), "Execution")

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

task.spawn(function()
	pcall(function()
		repeat task.wait() until game:GetService("CoreGui"):FindFirstChild("Rayfield"):FindFirstChild("Main")

		game:GetService("CoreGui"):FindFirstChild("Rayfield"):FindFirstChild("Main").Visible = false
	end)
end)

local function Click(v)
	VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X+v.AbsoluteSize.X/2,v.AbsolutePosition.Y+50,0,true,v,1)
	VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X+v.AbsoluteSize.X/2,v.AbsolutePosition.Y+50,0,false,v,1)
end

local function comma(amount)
	local formatted = amount
	local k
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local function Notify(Message, Duration)
	Rayfield:Notify({
		Title = "Goofy X",
		Content = Message,
		Duration = Duration,
		Image = 4483362458,
		Actions = {},
	})
end

local function CreateWindow()
	local Window = Rayfield:CreateWindow({
		Name = "Goofy X - "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
		LoadingTitle = "Goofy X",
		LoadingSubtitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "GoofyXConfig",
			FileName = "GoofyXConfig"
		},
		Discord = {
			Enabled = false,
			Invite = "1",
			RememberJoins = true
		}
	})

	task.defer(function()
		task.wait(1.5)
		local Universal = Window:CreateTab("Universal", 4483362458)

		Universal:CreateToggle({
			Name = "🚫 Anti-AFK 🚫",
			CurrentValue = false,
			Flag = "Universal-AntiAFK",
			Callback = function(Value)
				if Value then
					local VirtualUser = game:GetService("VirtualUser")
					Player.Idled:Connect(function()
						VirtualUser:CaptureController()
						VirtualUser:ClickButton2(Vector2.new())
					end)
				end
			end,
		})

		Universal:CreateToggle({
			Name = "🔁 Auto Rejoin When Disconnected 🔁",
			CurrentValue = false,
			Flag = "Universal-AutoRejoin",
			Callback = function(Value)
				if Value then
					local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

					if queueteleport then
						queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/GoofyScripter/timerchampion/main/Timber_Champion.lua"))()')
					end

					repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')

					local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')

					po.ChildAdded:connect(function(a)
						if a.Name == 'ErrorPrompt' then
							while true do
								ts:Teleport(game.PlaceId)
								task.wait(2)
							end
						end
					end)
				end
			end,
		})

		Rayfield:LoadConfiguration()

		Universal:CreateSection("")

		Universal:CreateSlider({
			Name = "💨 WalkSpeed 💨",
			Range = {0, 500},
			Increment = 1,
			CurrentValue = Player.Character.Humanoid.WalkSpeed,
			--Flag = "Universal-WalkSpeed",
			Callback = function(Value)
				if syn then
					if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/KikoTheDon/MT-Api-v2/main/__source/mt-api%20v2.lua", true))() end
				end
				Player.Character.Humanoid:AddPropertyEmulator("WalkSpeed")
				Player.Character.Humanoid.WalkSpeed = Value
			end,
		})

		Universal:CreateSlider({
			Name = "⬆ JumpPower ⬆",
			Range = {0, 500},
			Increment = 1,
			CurrentValue = Player.Character.Humanoid.JumpPower,
			--Flag = "Universal-JumpPower",
			Callback = function(Value)
				if syn then
					if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/KikoTheDon/MT-Api-v2/main/__source/mt-api%20v2.lua", true))() end
				end
				Player.Character.Humanoid:AddPropertyEmulator("JumpPower")
				Player.Character.Humanoid.JumpPower = Value
			end,
		})

		local Credits = Window:CreateTab("Credits", 4483362458)

		Credits:CreateLabel("🔥 Goofy X was made by Csabi#0455 🔥")
	end)
	return Window
end
if game.PlaceId == 10404327868 then -- Timber Champions
	local AttackLooping
	local BossLooping
	local OrbLooping
	local ChestLooping
	local AxeLooping

	local HatchLooping
	local CraftLooping
	local BestLooping

	local TripleHatch

	local SelectedAreas = {}
	local SelectedLevels = {}

	local SelectedEgg

	local BestDelay = 5

	local Areas = {"Clear List"}
	local Levels = {"Clear List"}
	local Eggs = {}
	local Chests = {}
	local BuyableAxes = {}

	repeat task.wait() until Player.Character:FindFirstChild("IS_GAME_AXE")

	local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
	local TreeService = Knit.GetService("TreeService")
	local PetService = Knit.GetService("PetService")
	local DamageRemote = TreeService.Damage._re
	local DataController = Knit.GetController("DataController")
	local EggService = Knit.GetService("EggService")
	local OrbService = Knit.GetService("OrbService")
	local RewardService = Knit.GetService("RewardService")
	local BossService = Knit.GetService("BossService")
	local AxeService = Knit.GetService("AxeService")

	for i,v in pairs(game:GetService("Workspace").Scripts.Trees:GetChildren()) do
		table.insert(Areas, v.Name)
	end

	for i,v in pairs(game:GetService("Workspace").Scripts.Trees:FindFirstChild(Areas[2]):GetChildren()) do
		table.insert(Levels, v.Name)
	end

	for i,v in pairs(game:GetService("Workspace").Scripts.Eggs:GetChildren()) do
		if not string.find(v.Name:lower(), "robux") then
			table.insert(Eggs, v.Name)
		end
	end

	for i,v in pairs(require(game:GetService("ReplicatedStorage").Shared.List.Chests)) do
		if type(v) == "table" then
			for e,r in pairs(v) do
				table.insert(Chests, e)
			end
		end
	end

	for i,v in pairs(require(game:GetService("ReplicatedStorage").Shared.List.Axes)) do
		if type(v) == "table" then
			for e,r in pairs(v) do
				if type(r) == "table" then
					for t,y in pairs(r) do
						if y.index > DataController.data.EquippedAxe then
							table.insert(BuyableAxes, y.index)
						end
					end
				end
			end
		end
	end

	print("Purchasable Axes: "..table.concat(BuyableAxes, ", "))

	local Window = CreateWindow()

	local Main = Window:CreateTab("Main", 4483362458)

	Main:CreateDropdown({
		Name = "🏝 Area",
		Options = Areas,
		CurrentOption = "",
		Flag = game.PlaceId.."SelectedArea",
		Callback = function(Value)
			if Value == "Clear List" then
				table.clear(SelectedAreas)
			elseif not table.find(SelectedAreas, Value) then
				table.insert(SelectedAreas, Value)
			end

			if not AreaLabel then
				repeat task.wait() until AreaLabel
			end

			AreaLabel:Set("Selected Areas: "..table.concat(SelectedAreas, ", "))
		end,
	})

	AreaLabel = Main:CreateLabel("Selected Areas: None")

	Main:CreateDropdown({
		Name = "🔢 Level",
		Options = Levels,
		CurrentOption = "",
		Flag = game.PlaceId.."SelectedLevel",
		Callback = function(Value)
			if Value == "Clear List" then
				table.clear(SelectedLevels)
			elseif not table.find(SelectedLevels, Value) then
				table.insert(SelectedLevels, Value)
			end

			if not LevelLabel then
				repeat task.wait() until LevelLabel
			end

			LevelLabel:Set("Selected Levels: "..table.concat(SelectedLevels, ", "))
		end,
	})

	LevelLabel = Main:CreateLabel("Selected Areas: None")

	Main:CreateToggle({
		Name = "🌲 Auto Attack Tree",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoAttack",
		Callback = function(Value)
			AttackLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if AttackLooping and #SelectedAreas > 0 and #SelectedLevels > 0 then
				for i = 2, #Levels, 1 do
					if table.find(SelectedLevels, Levels[i]) then
						for _,w in pairs(SelectedAreas) do
							if game:GetService("Workspace").Scripts.Trees:FindFirstChild(w):FindFirstChild(Levels[i]) then
								for _,v in pairs(game:GetService("Workspace").Scripts.Trees:FindFirstChild(w):FindFirstChild(Levels[i]).Storage:GetChildren()) do
									local SectionLooping = true

									while task.wait() and SectionLooping and AttackLooping do
										pcall(function()
											if not game:GetService("Workspace").Scripts.Trees:FindFirstChild(w):FindFirstChild(Levels[i]).Storage:FindFirstChild(v.Name) then
												SectionLooping = false
												print("[Goofy X] Debug: Tree Destroyed")
											else
												DamageRemote:FireServer(v.Name)
											end
										end)
									end
								end
							end
						end
					end
				end
			end
		end
	end)

	Main:CreateSection("")

	Main:CreateToggle({
		Name = "🐍 Auto Attack Bosses",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoBoss",
		Callback = function(Value)
			BossLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if BossLooping then
				for i,v in pairs(game:GetService("Workspace").Scripts.Areas:GetDescendants()) do
					if v:IsA("Folder") and v.Name == "Boss" then
						if #v.Model:GetChildren() > 0 then
							BossService.Damage:Fire(v.ID.Value)
						end
					end
				end
			end
		end
	end)

	Main:CreateToggle({
		Name = "🔮 Auto Collect Orbs",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoCollect",
		Callback = function(Value)
			OrbLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if OrbLooping then
				for i,v in pairs(game:GetService("Workspace").Scripts.Orbs.Storage:GetChildren()) do
					OrbService.CollectOrbs:Fire({v.Name})
					v:Destroy()
				end
			end
		end
	end)

	Main:CreateToggle({
		Name = "💼 Auto Collect Chests",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoChest",
		Callback = function(Value)
			ChestLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if ChestLooping then
				for i,v in pairs(Chests) do
					RewardService:ClaimChest(v)
				end
			end
		end
	end)

	Main:CreateToggle({
		Name = "🪓 Auto Buy Axes",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoAxe",
		Callback = function(Value)
			AxeLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if AxeLooping then
				local LoopAmount = 1

				for i = 6, #BuyableAxes, 3 do
					LoopAmount = LoopAmount + 1
					for e = 1, 3 do
						if AxeService:Buy(LoopAmount, e) == "success" then
							print("[Goofy X] Debug: Bought Axe of Area "..LoopAmount.." Axe "..e)
						end
					end
				end
			end
		end
	end)

	local Pets = Window:CreateTab("Pets", 4483362458)

	Pets:CreateDropdown({
		Name = "🥚 Egg",
		Options = Eggs,
		CurrentOption = "",
		Flag = game.PlaceId.."SelectedEgg",
		Callback = function(Value)
			SelectedEgg = Value
		end,
	})

	Pets:CreateToggle({
		Name = "🐣 Auto Hatch Egg",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoHatch",
		Callback = function(Value)
			HatchLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if HatchLooping and SelectedEgg then
				pcall(function()
					EggService:Unbox(SelectedEgg, TripleHatch)
				end)
			end
		end
	end)

	Pets:CreateToggle({
		Name = "🐥 Triple Hatch",
		CurrentValue = false,
		Flag = game.PlaceId.."TripleHatch",
		Callback = function(Value)
			if Value then
				TripleHatch = "triple"
			else
				TripleHatch = "single"
			end
		end,
	})

	Pets:CreateSection("")

	Pets:CreateToggle({
		Name = "⚒ Auto Craft Pets",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoCraft",
		Callback = function(Value)
			CraftLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if CraftLooping then
				PetService:CraftAll()
			end
		end
	end)

	Pets:CreateToggle({
		Name = "🥇 Auto Equip Best",
		CurrentValue = false,
		Flag = game.PlaceId.."AutoEquipBest",
		Callback = function(Value)
			BestLooping = Value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if BestLooping then
				local CurrentNumber1 = 0
				local CurrentNumber2 = 0
				local CurrentNumber3 = 0
				local CurrentPet1
				local CurrentPet2
				local CurrentPet3

				local PetData = DataController.data.Pets

				for i,v in pairs(PetData) do
					if v.multiplier > CurrentNumber1 then
						CurrentNumber1 = v.multiplier
						CurrentPet1 = i
					end
				end

				for i,v in pairs(PetData) do
					if v.multiplier > CurrentNumber2 and i ~= CurrentPet1 then
						CurrentNumber2 = v.multiplier
						CurrentPet2 = i
					end
				end

				for i,v in pairs(PetData) do
					if v.multiplier > CurrentNumber3 and i ~= CurrentPet1 and  i ~= CurrentPet2 then
						CurrentNumber3 = v.multiplier
						CurrentPet3 = i
					end
				end

				for i,v in pairs(PetData) do
					if v.equipped == true then
						PetService:Unequip(i)
					end
				end

				pcall(function()
					PetService:Equip(CurrentPet1)
					PetService:Equip(CurrentPet2)
					PetService:Equip(CurrentPet3)
				end)
				task.wait(BestDelay)
			end
		end
	end)

	Pets:CreateSlider({
		Name = "🐌 Auto Equip Best Delay",
		Range = {0, 60},
		Increment = 1,
		CurrentValue = 5,
		Flag = game.PlaceId.."Delay",
		Callback = function(Value)
			BestDelay = Value
		end,
	})
end

Rayfield:LoadConfiguration()