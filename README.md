# Roblox ESP Library  
A lightweight, customizable, and high-performance ESP (Extra Sensory Perception) system for Roblox.  
Designed for developers, debugging tools, visual debugging, and UI visualization enhancements.

This library is fully client-side and does **not modify game data**.  
It works by rendering UI elements in `CoreGui` and is safe to use in development environments.

Esp demo:

![ESP Banner](https://raw.githubusercontent.com/Zhoufuz/RobloxEsplib/main/assets/EspDemo.png)

---

## 📦 Load the Library

```lua
local ESP = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Zhoufuz/RobloxEsplib/main/main.lua",
    true
))()
```
---

🚀 Quick Start

ESP.Enabled = true
ESP.TeamCheck = false
ESP.MaxDistance = 300

ESP.Drawing.Names.Enabled = true
ESP.Drawing.Boxes.Full.Enabled = true
ESP.Drawing.Healthbar.Enabled = true
ESP.Drawing.Distances.Enabled = true


---

✨ Features

Core Features

Player Name ESP

Distance Display

Weapon Text & Icon ESP

Health Bar (supports gradients, custom width, and optional text)

2D Full Box & Corner ESP

Chams (Highlight ESP)

Fade-out based on distance

Team Check

Auto-update using RenderStepped

Configurable colors & transparency


Rendering

Optimized for low performance impact

Dynamic scaling based on distance

Works with R6 and R15 characters


UI Support

Built-in support for GUI control panels (e.g., WindUI).


---

📂 Example Usage

A complete example is included in:

examples/basic_usage.lua

Basic usage:
```
local ESP = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Zhoufuz/RobloxEsplib/main/main.lua"
))()

ESP.Enabled = true
ESP.Drawing.Names.Enabled = true
ESP.Drawing.Boxes.Full.Enabled = true
ESP.Drawing.Healthbar.Enabled = true
```

---

🧩 ESP Configuration

Top-level fields:

ESP.Enabled                  -- Master toggle
ESP.TeamCheck                -- Ignore teammates
ESP.MaxDistance              -- Max render distance
ESP.FontSize                 -- Text size

Drawing categories:

ESP.Drawing.Names.Enabled
ESP.Drawing.Distances.Enabled
ESP.Drawing.Weapons.Enabled
ESP.Drawing.Chams.Enabled
ESP.Drawing.Healthbar.Enabled
ESP.Drawing.Boxes.Full.Enabled
ESP.Drawing.Boxes.Corner.Enabled

Healthbar customization:

ESP.Drawing.Healthbar.Width
ESP.Drawing.Healthbar.HealthText
ESP.Drawing.Healthbar.Gradient = true

Chams customization:

ESP.Drawing.Chams.FillRGB
ESP.Drawing.Chams.OutlineRGB
ESP.Drawing.Chams.VisibleCheck


---
*** This ESP Library is not actually mine. I found it on GitHub. I just noticed that it was very simple and had no tutorials. Now I have added tutorials and want everyone to know that this is a very nice ESP ***

btw him lib: ```https://github.com/beampacker/BP-Esp-Library/blob/main/main.lua```
