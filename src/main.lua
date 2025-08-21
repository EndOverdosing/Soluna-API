local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local DefaultSettings = {
	AutoLoadEnabled = false,
	TeleportLoadEnabled = false,
	DisableScriptLoader = false,
	SelectedVersion = nil,
	SelectedTab = "Rivals",
	ThemeColor = "Darker",
	ScriptToggles = {
		Rivals_Classic = false,
		Rivals_Modern = false,
		Rivals_SkinChanger = false,
		Arsenal = false,
		Universal = false,
		BigPaintball2 = false,
		AimbotFFA = false,
		Bladeball = false,
		GunGroundsFFA = false,
		CombatWarriors = false,
		Fisch = false,
		MurderMystery2 = false,
		FleeTheFacility = false,
		Forsaken = false,
		BlueLock_Rivals = false,
		GrowAGarden = false,
		Brookhaven = false,
		MurderersVsSheriffsDuels = false,
        NightsInTheForest = false,
        Fling2Climb = false,
	}
}

local Settings = table.clone(DefaultSettings)

local function loadSettings()
	local success, savedSettings = pcall(function()
		return HttpService:JSONDecode(readfile("SolunaLoaderSettings.json"))
	end)
	if success and savedSettings then
		for key, value in pairs(DefaultSettings) do
			if savedSettings[key] == nil then
				savedSettings[key] = value
			end
		end
		if not savedSettings.ScriptToggles then
			savedSettings.ScriptToggles = DefaultSettings.ScriptToggles
		else
			for key, value in pairs(DefaultSettings.ScriptToggles) do
				if savedSettings.ScriptToggles[key] == nil then
					savedSettings.ScriptToggles[key] = value
				end
			end
			if savedSettings.ScriptToggles.Soluna_Classic ~= nil then
				savedSettings.ScriptToggles.Soluna_Classic = nil
			end
			if savedSettings.ScriptToggles.Soluna_Modern ~= nil then
				savedSettings.ScriptToggles.Soluna_Modern = nil
			end
		end
		Settings = savedSettings
	end
end

local function saveSettings()
	writefile("SolunaLoaderSettings.json", HttpService:JSONEncode(Settings))
end

pcall(loadSettings)

if Settings.DisableScriptLoader then
	return
end

if Settings.AutoLoadEnabled then
	local function autoLoadSelectedScripts()
		if Settings.ScriptToggles.Rivals_Classic then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/rivals-classic.lua"))()
		end
		if Settings.ScriptToggles.Rivals_Modern then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/rivals-modern.lua"))()
		end
		if Settings.ScriptToggles.Rivals_SkinChanger then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/skin-changer.lua", true))()
		end
		if Settings.ScriptToggles.Arsenal then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua", true))()
		end
		if Settings.ScriptToggles.Universal then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/universal.lua", true))()
		end
		if Settings.ScriptToggles.BigPaintball2 then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/big-paintball-2.lua", true))()
		end
		if Settings.ScriptToggles.AimbotFFA then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/Aimbot-FFA.lua", true))()
		end
		if Settings.ScriptToggles.Bladeball then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/bladeball.lua", true))()
		end
		if Settings.ScriptToggles.GunGroundsFFA then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/gun-grounds-ffa.lua", true))()
		end
		if Settings.ScriptToggles.CombatWarriors then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/combat-warriors.lua", true))()
		end
		if Settings.ScriptToggles.Fisch then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/fisch.lua", true))()
		end
		if Settings.ScriptToggles.MurderMystery2 then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/murder-mystery-2.lua", true))()
		end
		if Settings.ScriptToggles.FleeTheFacility then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/flee-the-facility.lua", true))()
		end
		if Settings.ScriptToggles.Forsaken then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/forsaken", true))()
		end
		if Settings.ScriptToggles.BlueLock_Rivals then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/blue-lock-rivals.lua", true))()
		end
		if Settings.ScriptToggles.GrowAGarden then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/grow-a-garden.lua", true))()
		end
		if Settings.ScriptToggles.Brookhaven then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/brookhaven.lua", true))()
		end
		if Settings.ScriptToggles.MurderersVsSheriffsDuels then
			loadstring(game:HttpGet("https://soluna-script.vercel.app/murderers-vs-sheriffs-duels.lua", true))()
		end
        if Settings.ScriptToggles.NightsInTheForest then
            loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()
        end
        if Settings.ScriptToggles.Fling2Climb then
            loadstring(game:HttpGet("https://soluna-script.vercel.app/fling-2-climb.lua",true))()
        end
	end
	autoLoadSelectedScripts()
	local anyScriptEnabled = false
	for _, enabled in pairs(Settings.ScriptToggles) do
		if enabled then
			anyScriptEnabled = true
			break
		end
	end
	if anyScriptEnabled then
		return
	end
end

if Settings.TeleportLoadEnabled then
	queue_on_teleport([[
        spawn(function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer

            local function isGameLoaded()
                return game:IsLoaded() and LocalPlayer and LocalPlayer.Character and
                       LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                       workspace.CurrentCamera
            end

            if not LocalPlayer then
                LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                LocalPlayer = Players.LocalPlayer
            end

            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.CharacterAdded:Wait()

                while not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
                    task.wait(0.1)
                end
            end

            if not isGameLoaded() then
                repeat task.wait(0.1) until isGameLoaded()
            end

            task.wait(1)

            pcall(function()
                loadstring(game:HttpGet("https://soluna-script.vercel.app/main.lua", true))()
            end)
        end)
    ]])
end

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow({
	Title = "Soluna",
	SubTitle = "Script Loader",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = Settings.ThemeColor or "Darker",
	MinSize = Vector2.new(470, 380),
	MinimizeKey = Enum.KeyCode.RightControl
})

Window:Dialog({
	Title = "Script Updated",
	Content = "Added Fling to Climb and 99 Nights in the Forest!",
	Buttons = {
		{
			Title = "Okay",
			Callback = function()
				print("Pressed 'Okay'")
			end
		}
	}
})

local Tabs = {
	Info = Window:CreateTab({
		Title = "Info",
		Icon = "info"
	}),
	Rivals = Window:CreateTab({
		Title = "Rivals",
		Icon = "swords"
	}),
	Universal = Window:CreateTab({
		Title = "Universal",
		Icon = "globe"
	}),
	FPS = Window:CreateTab({
		Title = "FPS Games",
		Icon = "target"
	}),
	Fighting = Window:CreateTab({
		Title = "Fighting",
		Icon = "swords"
	}),
	Misc = Window:CreateTab({
		Title = "Misc Games",
		Icon = "layout-grid"
	}),
	Theme = Window:CreateTab({
		Title = "Theme",
		Icon = "palette"
	}),
	Settings = Window:CreateTab({
		Title = "Settings",
		Icon = "settings"
	})
}

local selectedTabName = Settings.SelectedTab or "Rivals"
local selectedTabIndex = 1
local tabOrder = {
	"Rivals",
	"Universal",
	"FPS",
	"Fighting",
	"Misc",
	"Theme",
	"Settings",
	"Info"
}
for i, tabName in pairs(tabOrder) do
	if tabName == selectedTabName then
		selectedTabIndex = i
		break
	end
end
Window:SelectTab(selectedTabIndex)

Tabs.Rivals:CreateParagraph("Rivals Scripts", {
	Title = "Rivals",
	Content = "Select from different Rivals scripts including the new Skin Changer."
})

local rivalsClassicToggle = Tabs.Rivals:CreateToggle("RivalsClassicToggle", {
	Title = "Rivals Classic",
	Default = Settings.ScriptToggles.Rivals_Classic,
	Callback = function(Value)
		Settings.ScriptToggles.Rivals_Classic = Value
		saveSettings()
	end
})

local rivalsModernToggle = Tabs.Rivals:CreateToggle("RivalsModernToggle", {
	Title = "Rivals Modern",
	Default = Settings.ScriptToggles.Rivals_Modern,
	Callback = function(Value)
		Settings.ScriptToggles.Rivals_Modern = Value
		saveSettings()
	end
})

local rivalsSkinChangerToggle = Tabs.Rivals:CreateToggle("RivalsSkinChangerToggle", {
	Title = "Rivals Skin Changer",
	Default = Settings.ScriptToggles.Rivals_SkinChanger,
	Callback = function(Value)
		Settings.ScriptToggles.Rivals_SkinChanger = Value
		saveSettings()
	end
})

Tabs.Rivals:CreateButton({
	Title = "Load Selected Rivals Scripts",
	Description = "Load all toggled Rivals scripts",
	Callback = function()
		local scriptsLoaded = false
		if Settings.ScriptToggles.Rivals_Classic then
			Library:Notify({
				Title = "Rivals",
				Content = "Loading Rivals Classic...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/rivals-classic.lua"))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.Rivals_Modern then
			Library:Notify({
				Title = "Rivals",
				Content = "Loading Rivals Modern...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/rivals-modern.lua"))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.Rivals_SkinChanger then
			Library:Notify({
				Title = "Rivals",
				Content = "Loading Skin Changer...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/skin-changer.lua", true))()
			scriptsLoaded = true
		end
		if not scriptsLoaded then
			Library:Notify({
				Title = "Rivals",
				Content = "No scripts selected to load",
				Duration = 3
			})
		end
	end
})

local universalToggle = Tabs.Universal:CreateToggle("UniversalToggle", {
	Title = "Universal Script",
	Default = Settings.ScriptToggles.Universal,
	Callback = function(Value)
		Settings.ScriptToggles.Universal = Value
		saveSettings()
	end
})

Tabs.Universal:CreateButton({
	Title = "Load Universal Script",
	Description = "Load Universal script that works across many games",
	Callback = function()
		if Settings.ScriptToggles.Universal then
			Library:Notify({
				Title = "Universal",
				Content = "Loading Universal script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/universal.lua", true))()
		else
			Library:Notify({
				Title = "Universal",
				Content = "Universal script is not toggled on",
				Duration = 3
			})
		end
	end
})

Tabs.FPS:CreateParagraph("FPS Game Scripts", {
	Title = "FPS Games",
	Content = "Select from various FPS game scripts below."
})

local arsenalToggle = Tabs.FPS:CreateToggle("ArsenalToggle", {
	Title = "Arsenal",
	Default = Settings.ScriptToggles.Arsenal,
	Callback = function(Value)
		Settings.ScriptToggles.Arsenal = Value
		saveSettings()
	end
})

local bigPaintball2Toggle = Tabs.FPS:CreateToggle("BigPaintball2Toggle", {
	Title = "Big Paintball 2",
	Default = Settings.ScriptToggles.BigPaintball2,
	Callback = function(Value)
		Settings.ScriptToggles.BigPaintball2 = Value
		saveSettings()
	end
})

local aimbotFFAToggle = Tabs.FPS:CreateToggle("AimbotFFAToggle", {
	Title = "[🐰] Aimbot FFA 🎯",
	Default = Settings.ScriptToggles.AimbotFFA,
	Callback = function(Value)
		Settings.ScriptToggles.AimbotFFA = Value
		saveSettings()
	end
})

local gunGroundsFFAToggle = Tabs.FPS:CreateToggle("GunGroundsFFAToggle", {
	Title = "Gun Grounds FFA",
	Default = Settings.ScriptToggles.GunGroundsFFA,
	Callback = function(Value)
		Settings.ScriptToggles.GunGroundsFFA = Value
		saveSettings()
	end
})

local forsakenToggle = Tabs.FPS:CreateToggle("ForsakenToggle", {
	Title = "Forsaken",
	Default = Settings.ScriptToggles.Forsaken,
	Callback = function(Value)
		Settings.ScriptToggles.Forsaken = Value
		saveSettings()
	end
})

local murderersVsSheriffsDuelsToggle = Tabs.FPS:CreateToggle("MurderersVsSheriffsDuelsToggle", {
	Title = "Murderers vs Sheriffs Duels",
	Default = Settings.ScriptToggles.MurderersVsSheriffsDuels,
	Callback = function(Value)
		Settings.ScriptToggles.MurderersVsSheriffsDuels = Value
		saveSettings()
	end
})

Tabs.FPS:CreateButton({
	Title = "Load Selected FPS Scripts",
	Description = "Load all toggled FPS game scripts",
	Callback = function()
		local scriptsLoaded = false
		if Settings.ScriptToggles.Arsenal then
			Library:Notify({
				Title = "Arsenal",
				Content = "Loading Arsenal script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/arsenal.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.BigPaintball2 then
			Library:Notify({
				Title = "Big Paintball 2",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/big-paintball-2.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.AimbotFFA then
			Library:Notify({
				Title = "Aimbot FFA",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/Aimbot-FFA.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.GunGroundsFFA then
			Library:Notify({
				Title = "Gun Grounds FFA",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/gun-grounds-ffa.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.Forsaken then
			Library:Notify({
				Title = "Forsaken",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/forsaken", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.MurderersVsSheriffsDuels then
			Library:Notify({
				Title = "Murderers vs Sheriffs Duels",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/murderers-vs-sheriffs-duels.lua", true))()
			scriptsLoaded = true
		end
		if not scriptsLoaded then
			Library:Notify({
				Title = "FPS Scripts",
				Content = "No scripts selected to load",
				Duration = 3
			})
		end
	end
})

Tabs.Fighting:CreateParagraph("Fighting Game Scripts", {
	Title = "Fighting Games",
	Content = "Select from various fighting game scripts below."
})

local bladeballToggle = Tabs.Fighting:CreateToggle("BladeballToggle", {
	Title = "Bladeball",
	Default = Settings.ScriptToggles.Bladeball,
	Callback = function(Value)
		Settings.ScriptToggles.Bladeball = Value
		saveSettings()
	end
})

local combatWarriorsToggle = Tabs.Fighting:CreateToggle("CombatWarriorsToggle", {
	Title = "Combat Warriors",
	Default = Settings.ScriptToggles.CombatWarriors,
	Callback = function(Value)
		Settings.ScriptToggles.CombatWarriors = Value
		saveSettings()
	end
})

Tabs.Fighting:CreateButton({
	Title = "Load Selected Fighting Scripts",
	Description = "Load all toggled fighting game scripts",
	Callback = function()
		local scriptsLoaded = false
		if Settings.ScriptToggles.Bladeball then
			Library:Notify({
				Title = "Bladeball",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/bladeball.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.CombatWarriors then
			Library:Notify({
				Title = "Combat Warriors",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/combat-warriors.lua", true))()
			scriptsLoaded = true
		end
		if not scriptsLoaded then
			Library:Notify({
				Title = "Fighting Scripts",
				Content = "No scripts selected to load",
				Duration = 3
			})
		end
	end
})

Tabs.Misc:CreateParagraph("Miscellaneous Game Scripts", {
	Title = "Misc Games",
	Content = "Other game scripts that don't fit into the main categories."
})

local fischToggle = Tabs.Misc:CreateToggle("FischToggle", {
	Title = "Fisch",
	Default = Settings.ScriptToggles.Fisch,
	Callback = function(Value)
		Settings.ScriptToggles.Fisch = Value
		saveSettings()
	end
})

local murderMystery2Toggle = Tabs.Misc:CreateToggle("MurderMystery2Toggle", {
	Title = "Murder Mystery 2",
	Default = Settings.ScriptToggles.MurderMystery2,
	Callback = function(Value)
		Settings.ScriptToggles.MurderMystery2 = Value
		saveSettings()
	end
})

local fleeTheFacilityToggle = Tabs.Misc:CreateToggle("FleeTheFacilityToggle", {
	Title = "Flee the Facility",
	Default = Settings.ScriptToggles.FleeTheFacility,
	Callback = function(Value)
		Settings.ScriptToggles.FleeTheFacility = Value
		saveSettings()
	end
})

local blueLockRivalsToggle = Tabs.Misc:CreateToggle("BlueLockRivalsToggle", {
	Title = "Blue Lock Rivals",
	Default = Settings.ScriptToggles.BlueLock_Rivals,
	Callback = function(Value)
		Settings.ScriptToggles.BlueLock_Rivals = Value
		saveSettings()
	end
})

local growAGardenToggle = Tabs.Misc:CreateToggle("GrowAGardenToggle", {
	Title = "Grow a Garden",
	Default = Settings.ScriptToggles.GrowAGarden,
	Callback = function(Value)
		Settings.ScriptToggles.GrowAGarden = Value
		saveSettings()
	end
})

local brookhavenToggle = Tabs.Misc:CreateToggle("BrookhavenToggle", {
	Title = "Brookhaven",
	Default = Settings.ScriptToggles.Brookhaven,
	Callback = function(Value)
		Settings.ScriptToggles.Brookhaven = Value
		saveSettings()
	end
})

local nightsInTheForestToggle = Tabs.Misc:CreateToggle("NightsInTheForestToggle", {
	Title = "99 Nights in the Forest 🔦",
	Default = Settings.ScriptToggles.NightsInTheForest,
	Callback = function(Value)
		Settings.ScriptToggles.NightsInTheForest = Value
		saveSettings()
	end
})

local fling2ClimbToggle = Tabs.Misc:CreateToggle("Fling2ClimbToggle", {
	Title = "Fling 2 Climb",
	Default = Settings.ScriptToggles.Fling2Climb,
	Callback = function(Value)
		Settings.ScriptToggles.Fling2Climb = Value
		saveSettings()
	end
})

Tabs.Misc:CreateButton({
	Title = "Load Selected Misc Scripts",
	Description = "Load all toggled miscellaneous game scripts",
	Callback = function()
		local scriptsLoaded = false
		if Settings.ScriptToggles.Fisch then
			Library:Notify({
				Title = "Fisch",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/fisch.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.MurderMystery2 then
			Library:Notify({
				Title = "Murder Mystery 2",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/murder-mystery-2.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.FleeTheFacility then
			Library:Notify({
				Title = "Flee the Facility",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/flee-the-facility.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.BlueLock_Rivals then
			Library:Notify({
				Title = "Blue Lock Rivals",
				Content = "Loading Blue Lock Rivals script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/blue-lock-rivals.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.GrowAGarden then
			Library:Notify({
				Title = "Grow a Garden",
				Content = "Loading script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/grow-a-garden.lua", true))()
			scriptsLoaded = true
		end
		if Settings.ScriptToggles.Brookhaven then
			Library:Notify({
				Title = "Brookhaven",
				Content = "Loading Brookhaven script...",
				Duration = 3
			})
			loadstring(game:HttpGet("https://soluna-script.vercel.app/brookhaven.lua", true))()
			scriptsLoaded = true
		end
        if Settings.ScriptToggles.NightsInTheForest then
            Library:Notify({
                Title = "99 Nights in the Forest",
                Content = "Loading script...",
                Duration = 3
            })
            loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()
            scriptsLoaded = true
        end
        if Settings.ScriptToggles.Fling2Climb then
            Library:Notify({
                Title = "Fling 2 Climb",
                Content = "Loading script...",
                Duration = 3
            })
            loadstring(game:HttpGet("https://soluna-script.vercel.app/fling-2-climb.lua",true))()
            scriptsLoaded = true
        end
		if not scriptsLoaded then
			Library:Notify({
				Title = "Misc Scripts",
				Content = "No scripts selected to load",
				Duration = 3
			})
		end
	end
})

Tabs.Theme:CreateParagraph("UI Customization", {
	Title = "Theme Settings",
	Content = "Customize the look and feel of the Soluna Script Loader."
})

local ThemeDropdown = Tabs.Theme:CreateDropdown("ThemeDropdown", {
	Title = "UI Theme",
	Values = {
		"Darker",
		"Dark",
		"Light",
		"Ocean",
		"Aqua",
		"Rose",
		"Violet",
		"Cyan"
	},
	Multi = false,
	Default = Settings.ThemeColor or "Darker",
	Callback = function(Value)
		Settings.ThemeColor = Value
		Library:SetTheme(Value)
		saveSettings()
	end
})

Tabs.Info:CreateParagraph("Development Team", {
	Title = "Script Information",
	Content = "This script was made by the Soluna Development Team.\n\nOwner: @endoverdosing\n\nContributing Team Members:\n@aidanqm\n@rvd1\n\nSpecial thanks to @nervigemuecke for helping with the Rivals script.\n\nThank you for your contributions!"
})

Tabs.Info:CreateButton({
	Title = "Copy Discord Link",
	Description = "Click to copy the Soluna Discord server link to your clipboard.",
	Callback = function()
		local discordLink = "https://discord.gg/2hxKqA3b7b"
		pcall(function()
			setclipboard(discordLink)
			Library:Notify({
				Title = "Discord Link",
				Content = "Discord link copied to clipboard!",
				Duration = 3
			})
		end)
	end
})

local autoLoadToggle = Tabs.Settings:CreateToggle("AutoLoadToggle", {
	Title = "Auto-Load Selected Scripts",
	Default = Settings.AutoLoadEnabled,
	Callback = function(Value)
		Settings.AutoLoadEnabled = Value
		saveSettings()
	end
})

local teleportLoadToggle = Tabs.Settings:CreateToggle("TeleportLoadToggle", {
	Title = "Load on Teleport",
	Default = Settings.TeleportLoadEnabled,
	Callback = function(Value)
		Settings.TeleportLoadEnabled = Value
		saveSettings()
	end
})

local disableScriptLoaderToggle = Tabs.Settings:CreateToggle("DisableScriptLoaderToggle", {
	Title = "Disable Script Loader",
	Description = "Completely disables the script loader on next execution",
	Default = Settings.DisableScriptLoader,
	Callback = function(Value)
		Settings.DisableScriptLoader = Value
		saveSettings()
		if Value then
			Library:Notify({
				Title = "Script Loader",
				Content = "Script Loader will be disabled on next execution",
				Duration = 5
			})
		else
			Library:Notify({
				Title = "Script Loader",
				Content = "Script Loader will be enabled on next execution",
				Duration = 5
			})
		end
	end
})

Tabs.Settings:CreateButton({
	Title = "Reload Script Loader",
	Description = "Reloads the script loader with the latest settings",
	Callback = function()
		Library:Notify({
			Title = "Script Loader",
			Content = "Reloading Script Loader...",
			Duration = 3
		})
		task.wait(1)
		loadstring(game:HttpGet("https://soluna-script.vercel.app/main.lua", true))()
	end
})

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Library:Notify({
	Title = "Soluna",
	Content = "Script Loaded Successfully!",
	Duration = 5
})