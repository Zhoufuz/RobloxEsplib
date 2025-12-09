# Roblox ESP Library – API Documentation

This document provides a full overview of the ESP Library API, including  
configuration fields, rendering properties, and all modifiable options.

The ESP system is fully table-driven, meaning all behavior can be controlled by  
editing values inside the main ESP table returned from:

```lua
local ESP = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Zhoufuz/RobloxEsplib/main/main.lua"
))()
```

---

1. Core ESP Fields

ESP.Enabled : boolean

Master toggle for the entire ESP system.
If false, all ESP rendering stops immediately.

ESP.TeamCheck : boolean

If true, ESP will ignore players on the same team.

ESP.MaxDistance : number

Maximum allowed distance (in studs) for ESP rendering.
Default: 200

ESP.FontSize : number

Font size used for Name, Distance, Weapon, etc.
Default: 11


---

2. FadeOut Options
```Lua
ESP.FadeOut = {
    OnDistance = false,
    OnDeath = false,
    OnLeave = false,
}
```
OnDistance

Gradually reduces transparency based on distance.

OnDeath

Fade out ESP when the target dies.

OnLeave

Fade out ESP when the player leaves the game.


---

3. ESP.Options
```Lua
ESP.Options = {
    Teamcheck = false,
    TeamcheckRGB = Color3.fromRGB(0, 255, 0),

    Friendcheck = false,
    FriendcheckRGB = Color3.fromRGB(0, 255, 0),

    Highlight = false,
    HighlightRGB = Color3.fromRGB(255, 0, 0),
}
```
Field Descriptions

Field	Description

Teamcheck	Enables team-based color changes
TeamcheckRGB	Color for teammate indicators
Friendcheck	Highlights Roblox friends
FriendcheckRGB	Color for friend indicators
Highlight	Enables special highlight coloring
HighlightRGB	Color for highlight mode



---

4. ESP.Drawing (Visual Elements)

The Drawing table contains all ESP visual modules.
Each module can be toggled individually.


---

4.1 Chams
```Lua
ESP.Drawing.Chams = {
    Enabled = false,
    Thermal = false,

    FillRGB = Color3.fromRGB(119,120,255),
    Fill_Transparency = 100,

    OutlineRGB = Color3.fromRGB(119,120,255),
    Outline_Transparency = 100,

    VisibleCheck = false,
}
```
Field Descriptions

Field	Description

Enabled	Enables Highlight-based Chams ESP
Thermal	Pulsing transparency effect
FillRGB	Body fill color
OutlineRGB	Cham outline color
VisibleCheck	If true, uses "Occluded" mode



---

4.2 Name ESP
```Lua
ESP.Drawing.Names = {
    Enabled = false,
    RGB = Color3.fromRGB(255,255,255),
}

```
---

4.3 Distance ESP
```Lua
ESP.Drawing.Distances = {
    Enabled = false,
    Position = "Text", -- "Text" or "Bottom"
    RGB = Color3.fromRGB(255,255,255),
}
```

---

4.4 Weapon ESP
```Lua
ESP.Drawing.Weapons = {
    Enabled = false,
    WeaponTextRGB = Color3.fromRGB(119,120,255),

    Outlined = false,

    Gradient = false,
    GradientRGB1 = Color3.fromRGB(255,255,255),
    GradientRGB2 = Color3.fromRGB(119,120,255),
}
```

---

4.5 Health Bar ESP
```Lua
ESP.Drawing.Healthbar = {
    Enabled = false,
    HealthText = true,
    Lerp = false,

    HealthTextRGB = Color3.fromRGB(119,120,255),

    Width = 2.5,

    Gradient = false,
    GradientRGB1 = Color3.fromRGB(200, 0, 0),
    GradientRGB2 = Color3.fromRGB(60, 60, 125),
    GradientRGB3 = Color3.fromRGB(119, 120, 255),
}
```
Field Descriptions

Field	Description

Enabled	Enables health bar
HealthText	Displays HP percentage
Lerp	Smooth color interpolation based on HP
Width	Width in pixels
Gradient	Enables 3-point gradient fill



---

4.6 Box ESP
```Lua
ESP.Drawing.Boxes = {
    Animate = false,
    RotationSpeed = 300,

    Gradient = false,
    GradientRGB1 = Color3.fromRGB(119,120,255),
    GradientRGB2 = Color3.fromRGB(0,0,0),

    GradientFill = false,
    GradientFillRGB1 = Color3.fromRGB(119,120,255),
    GradientFillRGB2 = Color3.fromRGB(0,0,0),

    Filled = {
        Enabled = false,
        Transparency = 0.75,
        RGB = Color3.fromRGB(0,0,0),
    },

    Full = {
        Enabled = false,
        RGB = Color3.fromRGB(255,255,255),
    },

    Corner = {
        Enabled = false,
        RGB = Color3.fromRGB(255,255,255),
    },
}
```
Box ESP Types

Mode	Description

Full.Enabled	Full 2D box
Corner.Enabled	Four corner lines
Filled.Enabled	Semi-transparent fill
Animate	Rotating gradient box
GradientFill	Gradient inside the box



---

5. Internal Connections
```Lua
ESP.Connections = {
    RunService = RunService
}
```
Not intended for user modification.
Used to store RenderStepped connection handles.


---

6. Fonts
```Lua
ESP.Fonts = {}
```
Reserved for future use (custom font assignments).


---

7. Player ESP Lifecycle

ESP creates a UI set inside CoreGui for each player:

NameLabel

DistanceLabel

WeaponLabel

Box Frame

Corner Frames

HealthBar

Background HealthBar

Chams Highlight

Weapon Icon


When a player joins, PlayerAdded triggers a new ESP instance.
When a player leaves or dies, fade-out (if enabled) is applied.


---

8. Return Value

The library returns the full ESP configuration table:
```Lua
return ESP
```
This allows external scripts or GUI libraries such as WindUI to directly modify all fields.


---

9. Example Integration (GUI)
```Lua
Section:Toggle({
    Title = "Enable ESP",
    Value = ESP.Enabled,
    Callback = function(v)
        ESP.Enabled = v
    end
})
```

---

10. Notes

The ESP runs entirely inside RenderStepped.

All fields are hot-reload safe — changes apply instantly.

Works on ***R6*** and ***R15*** character rigs.

Designed for extensibility and UI integration.



---

End of API Documentation

---
