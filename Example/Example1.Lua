--========================================================--
--  Roblox ESP Library Example Usage
--  Author: Zhoufuz
--  This script demonstrates how to load and configure
--  the ESP library from the GitHub repository.
--========================================================--

-- 1. Load the ESP definition table
local ESP = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Zhoufuz/RobloxEsplib/main/main.lua",
    true
))()

print("[ESP Library] Loaded successfully!")

--========================================================--
-- 2. Basic Configuration
--========================================================--

-- Enable the ESP system
ESP.Enabled = true

-- Optionally enable team checking
ESP.TeamCheck = false   -- only show enemies if true

-- Maximum ESP rendering distance
ESP.MaxDistance = 300

--========================================================--
-- 3. Visual Elements Configuration
--========================================================--

-- Enable player name display
ESP.Drawing.Names.Enabled = true

-- Enable distance display
ESP.Drawing.Distances.Enabled = true

-- Enable full ESP box around players
ESP.Drawing.Boxes.Full.Enabled = true

-- Enable health bar
ESP.Drawing.Healthbar.Enabled = true
ESP.Drawing.Healthbar.HealthText = true

-- Enable weapon display
ESP.Drawing.Weapons.Enabled = true

-- Enable Chams (Highlight ESP)
ESP.Drawing.Chams.Enabled = false   -- set true if desired

print("[ESP Library] Basic ESP functions enabled.")

--========================================================--
-- 4. Optional: WindUI Control Panel
--========================================================--

-- To give users a GUI controller for ESP settings,
-- you can load WindUI and bind toggles/sliders to ESP fields.

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "ESP Controller",
    Icon = "lucide:scan-eye",
    Author = "ESP Library Example",
    Theme = "Dark",
})

local Tab = Window:Tab({
    Title = "Main ESP",
    Icon = "lucide:radar",
})

local Section = Tab:Section({
    Title = "ESP Settings",
    Opened = true,
})

-- Toggle: Enable ESP
Section:Toggle({
    Title = "Enable ESP",
    Value = ESP.Enabled,
    Callback = function(v)
        ESP.Enabled = v
    end
})

-- Toggle: Team Check
Section:Toggle({
    Title = "Team Check",
    Value = ESP.TeamCheck,
    Callback = function(v)
        ESP.TeamCheck = v
    end
})

-- Slider: Max Distance
Section:Slider({
    Title = "Max Distance",
    Desc = "ESP render distance",
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = ESP.MaxDistance,
    },
    Callback = function(v)
        ESP.MaxDistance = v
    end
})

-- Toggle: Names
Section:Toggle({
    Title = "Name ESP",
    Value = ESP.Drawing.Names.Enabled,
    Callback = function(v)
        ESP.Drawing.Names.Enabled = v
    end
})

-- Toggle: Boxes
Section:Toggle({
    Title = "Box ESP",
    Value = ESP.Drawing.Boxes.Full.Enabled,
    Callback = function(v)
        ESP.Drawing.Boxes.Full.Enabled = v
    end
})

-- Toggle: Health Bar
Section:Toggle({
    Title = "Health Bar",
    Value = ESP.Drawing.Healthbar.Enabled,
    Callback = function(v)
        ESP.Drawing.Healthbar.Enabled = v
    end
})

-- Toggle: Chams
Section:Toggle({
    Title = "Chams",
    Value = ESP.Drawing.Chams.Enabled,
    Callback = function(v)
        ESP.Drawing.Chams.Enabled = v
    end
})

print("[ESP Library] GUI controller initialized.")

--========================================================--
-- End of Example
--========================================================--
