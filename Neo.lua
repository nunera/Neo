local V = "0.0.1"

if Neo then
	return
end

local game = game
local loadstring, typeof, select, next, pcall = loadstring, typeof, select, next, pcall
local tablefind, tablesort = table.find, table.sort
local mathfloor = math.floor
local stringgsub = string.gsub
local wait, delay, spawn = task.wait, task.delay, task.spawn
local osdate = os.date

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/UI/Library.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/UI/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/UI/ThemeManager.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/Libraries/Aimbot/Aimbot.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/Libraries/ESP/ESP.lua"))()

local ESP_DeveloperSettings = ESP.DeveloperSettings
local ESP_Settings = ESP.Settings
local ESP_Properties = ESP.Properties

local Aimbot_DeveloperSettings = Aimbot.DeveloperSettings
local Aimbot_Settings = Aimbot.Settings
local Aimbot_FOV = Aimbot.FOVSettings

ESP_Settings.LoadConfigOnLaunch = false
ESP_Settings.Enabled = false
Aimbot_Settings.Enabled = false

local Fonts = {"UI", "System", "Plex", "Monospace"}
local TracerPositions = {"Bottom", "Center", "Mouse"}
local HealthBarPositions = {"Top", "Bottom", "Left", "Right"}
local Window = UI:CreateWindow({
    Title = "Neo - V"..V,
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    ['General'] = Window:AddTab('General'),
    ['AimbotTab'] = Window:AddTab('Aimbot'),
    ['ESP'] = Window:AddTab('ESP'),
    ['Crosshair'] = Window:AddTab('Crosshair'),
    ['Settings'] = Window:AddTab('Settings')
}

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 144

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end

    Library:SetWatermark(('Neo V%s| %s fps | %s ms'):format(
        V,
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    getgenv().Neo = nil
    Library.Unloaded = true
end)
local MenuGroup = Tabs['Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })
MenuGroup:AddToggle('Keybinds', {
    Text = 'Keybinds',
    Default = false,

    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

Library.ToggleKeybind = Options.MenuKeybind 

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Neo')
SaveManager:SetFolder('Neo/Saves/'..game.GameId)

SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])

SaveManager:LoadAutoloadConfig()
getgenv().Neo = true
