local game = game
local select, pcall, loadstring , warn = select, pcall, loadstring, warn

local Success, ESP = pcall(select(2, pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/Libraries/ESP/Modules/Original.lua"))))

if not Success then
    Success, ESP = pcall(select(2, pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/nunera/Neo/main/Libraries/ESP/Modules/UWP.lua"))))

    if not Success then
        return warn("EXUNYS_ESP > Loader - Your script execution software does not support this module.")
    end
end

return ESP
