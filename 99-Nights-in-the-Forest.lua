// yes this is open sourced, yes the key is EndOverdosing

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local Options = Library.Options

local CORRECT_KEY = "EndOverdosing"

local keyValidated = false

local function saveKeyToFile(key)
    local success, err = pcall(function()
        writefile("99nights_key_validation.txt", key)
    end)
    if not success then
        warn("Failed to save key: " .. tostring(err))
    end
    return success
end

local function loadKeyFromFile()
    local success, content = pcall(function()
        return readfile("99nights_key_validation.txt")
    end)
    if success and content then
        return content:gsub("%s+", "")
    else
        return nil
    end
end

local function checkKeyFile()
    local savedKey = loadKeyFromFile()
    return savedKey and savedKey == CORRECT_KEY
end

local function loadMainScript()
    task.wait(0.5)
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EndOverdosing/Soluna-API/refs/heads/main/99-Nights-in-the-Forest/source.lua",true))()
end

if checkKeyFile() then
    print("Key already validated, loading main script...")
    keyValidated = true
    task.spawn(function()
        loadMainScript()
    end)
    return
end

local MarketplaceService = game:GetService("MarketplaceService")
local PLACE_ID = 79546208627805

local success, info = pcall(function()
	return MarketplaceService:GetProductInfo(PLACE_ID)
end)

local gameTitle = info and info.Name or "99 Nights In The Forest"

local Window = Library:CreateWindow({
	Title = "Key System for: " .. gameTitle,
	SubTitle = "by Soluna Development",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.Q,
})

local ReadMeTab = Window:Tab{
    Title = "Read Me",
    Icon = "book-open"
}

local KeyTab = Window:Tab{
    Title = "Authentication",
    Icon = "key"
}

Window:SelectTab(1)

ReadMeTab:Paragraph("Announcement", {
    Title = "Important Notice",
    Content = "I've been seeing a huge wave of people using 99 Nights in the Forest, and it's honestly been overwhelming in the best way. The amount of posts and shares is more than I ever expected. I appreciate every one of you who's been part of that.",
    TitleAlignment = "Middle",
    ContentAlignment = Enum.TextXAlignment.Left
})

ReadMeTab:Paragraph("NoAds", {
    Title = "No Ads or Linkvertise",
    Content = "There won't be any ads, no Linkvertise, nothing shady. Just join my server and you'll find the key in its own channel. Run the script, grab the key, and you're good to go. The key will change from time to time, so make sure to check the channel when needed.",
    TitleAlignment = "Middle",
    ContentAlignment = Enum.TextXAlignment.Left
})

ReadMeTab:Paragraph("Community", {
    Title = "About the Community",
    Content = "This isn't about locking people out. It's about keeping things clean and giving back to the ones who actually support what I do. I care a lot about this community. You're the reason I keep doing this. Thank you for everything.",
    TitleAlignment = "Middle",
    ContentAlignment = Enum.TextXAlignment.Left
})

ReadMeTab:Paragraph("GetKey", {
    Title = "How to Get the Key",
    Content = "You don't need to verify or go through any hoops. Simply join the Discord server using the button below and look for the dedicated key channel. The key is posted there and updated when needed.",
    TitleAlignment = "Middle",
    ContentAlignment = Enum.TextXAlignment.Left
})

ReadMeTab:Button({
    Title = "Join Discord Server",
    Description = "Click to join and get your key",
    Callback = function()
        setclipboard("https://discord.gg/2hxKqA3b7b")
        Library:Notify({
            Title = "Discord Link Copied!",
            Content = "The Discord server link has been copied to your clipboard. Paste it in your browser to join!",
            Duration = 5,
            Sound = {
                SoundId = "rbxassetid://8486683243"
            }
        })
    end
})

KeyTab:Paragraph("Instructions", {
    Title = "Key Required",
    Content = "Please enter your access key below and click Submit Key to continue.",
    TitleAlignment = "Middle",
    ContentAlignment = Enum.TextXAlignment.Center
})

local KeyInput = KeyTab:Input("KeyInput", {
    Title = "Access Key",
    Default = "",
    Numeric = false,
    Finished = false,
    Placeholder = "Enter your key here...",
    ClearOnFocusLost = false
})

KeyTab:Button({
    Title = "Submit Key",
    Description = "Click to validate your key",
    Callback = function()
        local enteredKey = Options.KeyInput.Value or KeyInput.Value
        
        if enteredKey then
            enteredKey = string.gsub(tostring(enteredKey), "%s+", "")
        end
        
        if enteredKey and enteredKey == CORRECT_KEY then
            local saveSuccess = saveKeyToFile(enteredKey)
            
            Library:Notify({
                Title = "Success!",
                Content = "Key validated successfully. Loading main script...",
                Duration = 3,
                Sound = {
                    SoundId = "rbxassetid://8486683243"
                }
            })
            
            task.wait(1)
            Window:Destroy()
            keyValidated = true
            
            loadMainScript()
            
        else
            Library:Notify({
                Title = "Access Denied",
                Content = "Invalid key. Please try again.",
                Duration = 4,
                Sound = {
                    SoundId = "rbxassetid://8486683243"
                }
            })
            
            if KeyInput.SetValue then
                KeyInput:SetValue("")
            end
        end
    end
})

KeyTab:Button({
    Title = "Join Discord Server",
    Description = "Need the key? Join our Discord!",
    Callback = function()
        setclipboard("https://discord.gg/2hxKqA3b7b")
        Library:Notify({
            Title = "Discord Link Copied!",
            Content = "The Discord server link has been copied to your clipboard. Paste it in your browser to join and get the key!",
            Duration = 5,
            Sound = {
                SoundId = "rbxassetid://8486683243"
            }
        })
    end
})
