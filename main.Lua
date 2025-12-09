local Workspace, RunService, Players, CoreGui, Lighting = cloneref(game:GetService("Workspace")), cloneref(game:GetService("RunService")), cloneref(game:GetService("Players")), game:GetService("CoreGui"), cloneref(game:GetService("Lighting"))

local ESP = {
    Enabled = false,
    TeamCheck = false,
    MaxDistance = 200,
    FontSize = 11,
    FadeOut = {
        OnDistance = false,
        OnDeath = false,
        OnLeave = false,
    },
    Options = { 
        Teamcheck = false, TeamcheckRGB = Color3.fromRGB(0, 255, 0),
        Friendcheck = false, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false, HighlightRGB = Color3.fromRGB(255, 0, 0),
    },
    Drawing = {
        Chams = {
            Enabled  = false,
            Thermal = false,
            FillRGB = Color3.fromRGB(119, 120, 255),
            Fill_Transparency = 100,
            OutlineRGB = Color3.fromRGB(119, 120, 255),
            Outline_Transparency = 100,
            VisibleCheck = false,
        },
        Names = {
            Enabled = false,
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Flags = {
            Enabled = false,
        },
        Distances = {
            Enabled = false, 
            Position = "Text",
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Weapons = {
            Enabled = true,
            WeaponTextRGB = Color3.fromRGB(119, 120, 255),
            Outlined = false,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(255, 255, 255),
            GradientRGB2 = Color3.fromRGB(119, 120, 255),
        },
        Healthbar = {
            Enabled = false,
            HealthText = true, 
            Lerp = false,
            HealthTextRGB = Color3.fromRGB(119, 120, 255),
            Width = 2.5,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(200, 0, 0),
            GradientRGB2 = Color3.fromRGB(60, 60, 125),
            GradientRGB3 = Color3.fromRGB(119, 120, 255),
        },
        Boxes = {
            Animate = false,
            RotationSpeed = 300,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(119, 120, 255),
            GradientRGB2 = Color3.fromRGB(0, 0, 0),
            GradientFill = false,
            GradientFillRGB1 = Color3.fromRGB(119, 120, 255),
            GradientFillRGB2 = Color3.fromRGB(0, 0, 0),
            Filled = {
                Enabled = false,
                Transparency = 0.75,
                RGB = Color3.fromRGB(0, 0, 0),
            },
            Full = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Corner = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
        };
    };
    Connections = {
        RunService = RunService;
    };
    Fonts = {};
}

-- Def & Vars
local Euphoria = ESP.Connections;
local lplayer = Players.LocalPlayer;
local camera = game.Workspace.CurrentCamera;
local Cam = Workspace.CurrentCamera;
local RotationAngle, Tick = -45, tick();

-- Utility Functions
local Functions = {}
do
    function Functions:Create(Class, Properties)
        local obj = typeof(Class) == "string" and Instance.new(Class) or Class
        for k,v in pairs(Properties) do
            obj[k] = v
        end
        return obj
    end

    function Functions:FadeOutOnDist(element, distance)
        local transparency = math.max(0.1, 1 - (distance / ESP.MaxDistance))
        if element:IsA("TextLabel") then
            element.TextTransparency = 1 - transparency
        elseif element:IsA("ImageLabel") then
            element.ImageTransparency = 1 - transparency
        elseif element:IsA("UIStroke") then
            element.Transparency = 1 - transparency
        elseif element:IsA("Frame") then
            element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Highlight") then
            element.FillTransparency = 1 - transparency
            element.OutlineTransparency = 1 - transparency
        end
    end
end

----------------------------------------------------------------
-- ESP Initialize
----------------------------------------------------------------
do
    local ScreenGui = Functions:Create("ScreenGui", {
        Parent = CoreGui,
        Name = "ESPHolder",
        ResetOnSpawn = false
    })

    local function RemoveExisting(plr)
        local old = ScreenGui:FindFirstChild(plr.Name)
        if old then old:Destroy() end
    end

    local function CreateESP(plr)
        RemoveExisting(plr)

        --> Create UI Elements
        local Name = Functions:Create("TextLabel", {
            Parent = ScreenGui, BackgroundTransparency = 1,
            TextColor3 = Color3.new(1,1,1), Font = Enum.Font.Code,
            TextSize = ESP.FontSize, TextStrokeTransparency = 0
        })

        local Distance = Functions:Create("TextLabel", {
            Parent = ScreenGui, BackgroundTransparency = 1,
            TextColor3 = Color3.new(1,1,1), Font = Enum.Font.Code,
            TextSize = ESP.FontSize, TextStrokeTransparency = 0
        })

        local Weapon = Functions:Create("TextLabel", {
            Parent = ScreenGui, BackgroundTransparency = 1,
            TextColor3 = ESP.Drawing.Weapons.WeaponTextRGB, Font = Enum.Font.Code,
            TextSize = ESP.FontSize, TextStrokeTransparency = 0
        })

        local WeaponIcon = Functions:Create("ImageLabel", {
            Parent = ScreenGui, BackgroundTransparency = 1,
            Size = UDim2.new(0,40,0,40)
        })

        local Box = Functions:Create("Frame", {
            Parent = ScreenGui, BackgroundTransparency = 1,
            BorderSizePixel = 0
        })

        local Healthbar = Functions:Create("Frame", {
            Parent = ScreenGui, BackgroundColor3 = Color3.new(1,1,1)
        })

        local BehindHealthbar = Functions:Create("Frame", {
            Parent = ScreenGui, BackgroundColor3 = Color3.new(0,0,0)
        })

        local Chams = Functions:Create("Highlight", {
            Parent = ScreenGui,
            FillTransparency = 1,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        })

        --------------------------------------------------------------------------------
        -- ESP LOOP
        --------------------------------------------------------------------------------
        local function UpdateESP()
            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not ESP.Enabled then
                    Name.Visible = false
                    Distance.Visible = false
                    Weapon.Visible = false
                    WeaponIcon.Visible = false
                    Box.Visible = false
                    Healthbar.Visible = false
                    BehindHealthbar.Visible = false
                    Chams.Enabled = false
                    return
                end

                if not plr.Character then return end
                local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = plr.Character:FindFirstChild("Humanoid")
                if not HRP or not Humanoid then return end

                local vector, onScreen = Cam:WorldToScreenPoint(HRP.Position)
                local dist = (Cam.CFrame.Position - HRP.Position).Magnitude

                if (not onScreen) or dist > ESP.MaxDistance then
                    Name.Visible = false
                    Distance.Visible = false
                    Weapon.Visible = false
                    WeaponIcon.Visible = false
                    Box.Visible = false
                    Healthbar.Visible = false
                    BehindHealthbar.Visible = false
                    Chams.Enabled = false
                    return
                end

                ----------------------------------------------
                -- POSITIONING
                ----------------------------------------------
                local h = 40 * (200 / math.max(dist, 1))
                local w = 25 * (200 / math.max(dist, 1))

                ----------------------------------------------------------
                -- NAME ESP
                ----------------------------------------------------------
                Name.Visible = ESP.Drawing.Names.Enabled
                if ESP.Drawing.Names.Enabled then
                    Name.Text = plr.Name
                    Name.Position = UDim2.new(0, vector.X, 0, vector.Y - h - 10)
                end

                ----------------------------------------------------------
                -- DISTANCE ESP
                ----------------------------------------------------------
                Distance.Visible = ESP.Drawing.Distances.Enabled
                if ESP.Drawing.Distances.Enabled then
                    Distance.Text = tostring(math.floor(dist)) .. "m"
                    Distance.Position = UDim2.new(0, vector.X, 0, vector.Y + h + 5)
                end

                ----------------------------------------------------------
                -- BOX ESP
                ----------------------------------------------------------
                Box.Visible = ESP.Drawing.Boxes.Full.Enabled
                if ESP.Drawing.Boxes.Full.Enabled then
                    Box.Position = UDim2.new(0, vector.X - w/2, 0, vector.Y - h)
                    Box.Size = UDim2.new(0, w, 0, h*2)
                    Box.BackgroundColor3 = ESP.Drawing.Boxes.Full.RGB
                end

                ----------------------------------------------------------
                -- HEALTHBAR ESP
                ----------------------------------------------------------
                local hpRatio = Humanoid.Health / math.max(Humanoid.MaxHealth,1)

                Healthbar.Visible = ESP.Drawing.Healthbar.Enabled
                BehindHealthbar.Visible = ESP.Drawing.Healthbar.Enabled

                if ESP.Drawing.Healthbar.Enabled then
                    BehindHealthbar.Position = UDim2.new(0, vector.X - w/2 - 6, 0, vector.Y - h)
                    BehindHealthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, h*2)

                    Healthbar.Position = UDim2.new(0, vector.X - w/2 - 6, 0, vector.Y - h + (h*2)*(1 - hpRatio))
                    Healthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, (h*2)*hpRatio)
                end

                ----------------------------------------------------------
                -- **WEAPON ESP (FIXED & FULLY IMPLEMENTED)**
                ----------------------------------------------------------
                Weapon.Visible = ESP.Drawing.Weapons.Enabled
                WeaponIcon.Visible = ESP.Drawing.Weapons.Enabled

                if ESP.Drawing.Weapons.Enabled then
                    local toolName = "none"
                    local iconId = nil

                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        toolName = tool.Name

                        -- 自动检测 tool.Image.Data.Value 作为图标 ID（根据你之前的结构）
                        local imgFolder = tool:FindFirstChild("Image")
                        if imgFolder and imgFolder:FindFirstChild("Data") then
                            local val = imgFolder.Data:FindFirstChild("Value")
                            if val and tonumber(val.Value) then
                                iconId = "rbxassetid://" .. val.Value
                            end
                        end
                    end

                    Weapon.Text = toolName
                    Weapon.Position = UDim2.new(0, vector.X, 0, vector.Y + h + 20)

                    if iconId then
                        WeaponIcon.Image = iconId
                        WeaponIcon.Position = UDim2.new(0, vector.X - 20, 0, vector.Y + h + 5)
                        WeaponIcon.Visible = true
                    else
                        WeaponIcon.Visible = false
                    end
                end

                ----------------------------------------------------------
                -- CHAMS ESP
                ----------------------------------------------------------
                Chams.Enabled = ESP.Drawing.Chams.Enabled
                if ESP.Drawing.Chams.Enabled then
                    Chams.Adornee = plr.Character
                    Chams.FillColor = ESP.Drawing.Chams.FillRGB
                    Chams.OutlineColor = ESP.Drawing.Chams.OutlineRGB
                end
            end)
        end

        coroutine.wrap(UpdateESP)()
    end

    ----------------------------------------------------------------
    -- Apply ESP to existing players
    ----------------------------------------------------------------
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lplayer then
            CreateESP(p)
        end
    end

    ----------------------------------------------------------------
    -- PlayerAdded event
    ----------------------------------------------------------------
    Players.PlayerAdded:Connect(function(plr)
        if plr ~= lplayer then
            CreateESP(plr)
        end
    end)
end

-------------------------------------------------------------
-- RETURN ESP TABLE (IMPORTANT FOR LOADSTRING LIBRARY)
-------------------------------------------------------------
return ESP