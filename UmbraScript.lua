print("[ServerHop] 1/2 file started (if you never see 2/2, the file was cut off or crashed)")
local MY_ACCOUNTS = {
"yujiro_0006",
"2tnga",
"pabobot24",
"Evade_Player0077",
"alimohsen457",
"rysenahdriel",
"Whitedragon11239",
"Kaiikai60",
"jessie_albert2",
"jaby2983",
"hcixxx",
"Rainbagalay_13",
"jaby2983",
"Tuvera_09",
"gokunix300",
"zjdjgjgidiwueh",
"adhanszn",
"kurt040603",
"Tuvera_09",
"russelcac",
"VIP_ako7899",
"tanjiro423587",
"FreeTester5",
"oegdvia",
"grabpo1",
"21Flashstep",
"syrius0812",
"ancestors16",
"ivokaloko127",
"eneyosha03212",
"glamberxdd",
"loverruk98",
"rysenahdriel",
"maxschneider026",
"gab471231",
"kazumi3583",
"Arwwxl",
"bastaewanholder0",
"Rip_indira110",
"xbatalion_2011",
"mgxcalalis321",
"aray_ko10695",
"johnraizen12",
"Keint_lester13",
"codynarvaez",
"giGIAN_05",
"andiniccc12",
"udkrkv78",
"WooinAcc017",
"xSpeed005",
"Uchiha101010101",
"davechain15",
"hatdog23059",
"Examinationpaper17",
"Gruisee4",
"xd_richkeds20",
"bric070",
"vyxen12346",
"GUMENASAI96",
"roblox_fun8999",
"slashboy335",
"jampul3333",
"rexrexi6",
"yujiro_0006",
"piwts9",
"blyke_conner",
"sasakalin222",
"hakdogkiel",
"FRANZJEREMY16",
"kylewashere27",
"harvey25810",
"Jay1123005",
"Rayocr11g",
"frix_474",
"Blue_6150",
"Kyle_Ravioli",
"brylgwa1",
"ctxrain0",
"Inofps2",
"bisakol_527",
"bestbiso_forever",
"Jiffre_26",
"gfhiubnko",
"123arviefor3",
"KINGOFLOL89",
"badboy_honest",
"GRSTXQ234",
"hcixxx",
"attackontitanfans71",
"Egg_Stealer01",
}
local STEAL_AN_EGG_PLACE_ID = 107778070777162
local RIDE_A_PET_PLACE_ID = 124216119978534
local RIDE_A_PET_PILOTS = {
"Striker_1273",
"GUMENASAI96",
"maxschneider026",
"BossRhydz",
"Bentley123904",
"Egg_Stealer01",
"Blue_6150",
}
local BREAK_AND_STEAL_PLACE_ID = 114326934417838
local BREAK_AND_STEAL_PILOTS = {
"imsokapoy",
"Ahvery2220",
"drizzscofield",
"11y1283",
"RoanoaWarrior",
"Icedjemmmm",
"DoubleAA351",
"MkyDGarp",
"Footballmaster3759",
"dexterreal42",
}
local AUTO_JOIN = true
local HOP_MODE = "alts"
local START_DELAY = 6
local CHECK_INTERVAL = 5
local SECOND = {
key = "",
delay = 5,
onPilots = true,
}
local LIMIT = 100
local ACCOUNTS_PER_SERVER = 1
local STAY_IF_PLAYERS_MAX = 2
local MIN_PING, MAX_PING = 0, 9999
local CACHE_TTL = 90
local CLAIM_TTL = 120
local HEARTBEAT = 30
local CLAIM_FILE = "LowServerClaims.txt"
local RELOAD_SOURCE = ""
local SCRIPT_FILE = "UmbraScript.lua"
local AUTO_START_TIMER = false
local UI_SCALE = 0.8
local COUNT_BEFORE_CHOICE = false
local AUTO_RESUME_ON_HOP = true
local RESTART_GAP = 4 * 3600
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local okCG, CoreGui = pcall(function()
return game:GetService("CoreGui")
end)
if not okCG then
CoreGui = nil
end
local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId
local myId = tostring(player.UserId)
local httpRequest = (syn and syn.request) or http_request or request
or (fluxus and fluxus.request) or (http and http.request)
local hasFS = (writefile and readfile and isfile) and true or false
local SUPABASE_KEY_TOP = ""
if hasFS and isfile("UmbraKey.txt") then
local okk, kk = pcall(readfile, "UmbraKey.txt")
if okk and type(kk) == "string" then SUPABASE_KEY_TOP = (kk:gsub("%s+", "")) end
end
if SUPABASE_KEY_TOP == "" then
local ge = (getgenv and getgenv()) or _G
if type(ge.UmbraKey) == "string" then
SUPABASE_KEY_TOP = (ge.UmbraKey:gsub("%s+", ""))
if SUPABASE_KEY_TOP ~= "" then RELOAD_SOURCE = 'getgenv().UmbraKey="' .. SUPABASE_KEY_TOP .. '" ' .. RELOAD_SOURCE end
end
end
if not httpRequest then
warn("No HTTP request function available: auto hop and the server list are disabled.")
end
local myAccounts = {}
for _, name in ipairs(MY_ACCOUNTS) do
myAccounts[string.lower(name)] = true
end
local function placeNameHas(txt)
local ok, info = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
return ok and type(info) == "table" and type(info.Name) == "string" and info.Name:lower():find(txt, 1, true) ~= nil
end
local function umbraNote(text)
pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Umbra tracker", Text = tostring(text):sub(1, 120), Duration = 10 })
end)
print("[Umbra tracker] " .. tostring(text))
end
local function beacon(gameLabel, targetPlaceId)
pcall(function()
local url = "https://skgevraocihnyvecmaeq.supabase.co"
local key = SUPABASE_KEY_TOP
local line
if not httpRequest then
line = "beacon not sent: this executor has no http request function"
umbraNote("Not tracked: this executor has no http request function")
elseif key == "" then
line = "beacon not sent: UmbraKey missing (put UmbraKey.txt in the workspace folder, or start with getgenv().UmbraKey=\"...\")"
umbraNote("Not tracked: key missing. Put UmbraKey.txt in the workspace folder.")
else
local enc = HttpService:JSONEncode({
user_id = player.UserId,
username = player.Name,
display_name = player.DisplayName,
is_pilot = true,
place_id = targetPlaceId,
game_name = gameLabel,
updated_at = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()),
})
local ok, res = pcall(httpRequest, {
Url = url .. "/rest/v1/pilots?on_conflict=user_id",
Method = "POST",
Headers = {
["apikey"] = key,
["Authorization"] = "Bearer " .. key,
["Content-Type"] = "application/json",
["Prefer"] = "resolution=merge-duplicates,return=minimal",
},
Body = enc,
})
if not (ok and res and res.StatusCode and res.StatusCode < 300) then umbraNote("Tracker report FAILED (" .. tostring(ok and res and res.StatusCode or res) .. "). Check the key in UmbraKey.txt.") end
line = "beacon before teleport to " .. gameLabel .. ": " .. ((ok and res and res.StatusCode and res.StatusCode < 300) and "SENT OK" or ("FAILED " .. tostring(ok and res and (tostring(res.StatusCode) .. " " .. tostring(res.Body):sub(1, 100)) or res)))
line = line .. " | script file '" .. SCRIPT_FILE .. "' in workspace: " .. tostring(hasFS and isfile(SCRIPT_FILE)) .. " | queue_on_teleport: " .. tostring((queue_on_teleport or (syn and syn.queue_on_teleport)) ~= nil)
end
if hasFS then pcall(writefile, "ReportStatus_" .. player.Name .. ".txt", "[" .. os.date("!%Y-%m-%d %H:%M:%S UTC", os.time()) .. "] " .. line) end
print("[ServerHop] " .. line)
end)
end
do
local pilots = {}
for _, n in ipairs(RIDE_A_PET_PILOTS) do
pilots[string.lower(n)] = true
end
local isPilot = pilots[string.lower(player.Name)]
local rapFile = "RideAPetTeleport_" .. player.UserId .. ".txt"
local justWent = false
if hasFS and isfile(rapFile) then
local t = tonumber(readfile(rapFile))
justWent = (t ~= nil) and (os.time() - t) < 60
end
local inRap = game.PlaceId == RIDE_A_PET_PLACE_ID or (isPilot and placeNameHas("ride a pet"))
if isPilot and (inRap or justWent) then
print("[ServerHop] Ride a Pet pilot: already in Ride a Pet (PlaceId " .. game.PlaceId .. "), staying")
beacon("Ride a Pet", game.PlaceId)
end
if isPilot and not inRap and not justWent then
if hasFS then
pcall(writefile, rapFile, tostring(os.time()))
end
beacon("Ride a Pet", RIDE_A_PET_PLACE_ID)
local ok, err = pcall(function()
TeleportService:Teleport(RIDE_A_PET_PLACE_ID, player)
end)
if ok then
print("[ServerHop] Ride a Pet pilot: teleporting to Ride a Pet...")
return
end
warn("Teleport failed: " .. tostring(err))
end
end
do
local pilots = {}
for _, n in ipairs(BREAK_AND_STEAL_PILOTS) do
pilots[string.lower(n)] = true
end
local isPilot = pilots[string.lower(player.Name)]
local g2File = "Game2Teleport_" .. player.UserId .. ".txt"
local justWent = false
if hasFS and isfile(g2File) then
local t = tonumber(readfile(g2File))
justWent = (t ~= nil) and (os.time() - t) < 60
end
local inG2 = game.PlaceId == BREAK_AND_STEAL_PLACE_ID or (isPilot and placeNameHas("break and steal"))
if isPilot and (inG2 or justWent) then
print("[ServerHop] Break and Steal an Egg pilot: already in Break and Steal an Egg (PlaceId " .. game.PlaceId .. "), staying")
beacon("Break and Steal an Egg", game.PlaceId)
end
if isPilot and not inG2 and not justWent then
if hasFS then
pcall(writefile, g2File, tostring(os.time()))
end
beacon("Break and Steal an Egg", BREAK_AND_STEAL_PLACE_ID)
local ok, err = pcall(function()
TeleportService:Teleport(BREAK_AND_STEAL_PLACE_ID, player)
end)
if ok then
print("[ServerHop] Break and Steal an Egg pilot: teleporting to Break and Steal an Egg...")
return
end
warn("Teleport failed: " .. tostring(err))
end
end
do
local other = {}
for _, n in ipairs(RIDE_A_PET_PILOTS) do other[string.lower(n)] = true end
for _, n in ipairs(BREAK_AND_STEAL_PILOTS) do other[string.lower(n)] = true end
local lname = string.lower(player.Name)
local mine = false
for _, n in ipairs(MY_ACCOUNTS) do
if string.lower(n) == lname then mine = true break end
end
if mine and not other[lname] then
local saeFile = "StealAnEggTeleport_" .. player.UserId .. ".txt"
local justWent = false
if hasFS and isfile(saeFile) then
local t = tonumber(readfile(saeFile))
justWent = (t ~= nil) and (os.time() - t) < 60
end
local inSae = game.PlaceId == STEAL_AN_EGG_PLACE_ID
or (placeNameHas("steal an egg") and not placeNameHas("break and steal"))
if inSae or justWent then
print("[ServerHop] Steal an Egg account: already in Steal an Egg (PlaceId " .. game.PlaceId .. "), staying")
else
if hasFS then pcall(writefile, saeFile, tostring(os.time())) end
beacon("Steal an Egg", STEAL_AN_EGG_PLACE_ID)
local ok, err = pcall(function()
TeleportService:Teleport(STEAL_AN_EGG_PLACE_ID, player)
end)
if ok then
print("[ServerHop] Steal an Egg account: teleporting to Steal an Egg...")
return
end
warn("Teleport failed: " .. tostring(err))
end
end
end
local env = (getgenv and getgenv()) or _G
env.__ServerIdDisplayRun = (env.__ServerIdDisplayRun or 0) + 1
local RUN_ID = env.__ServerIdDisplayRun
if env.__ServerIdDisplayConns then
for _, c in ipairs(env.__ServerIdDisplayConns) do
pcall(function()
c:Disconnect()
end)
end
end
env.__ServerIdDisplayConns = {}
local function track(conn)
table.insert(env.__ServerIdDisplayConns, conn)
return conn
end
local function isCurrent()
return env.__ServerIdDisplayRun == RUN_ID
end
task.spawn(function()
local ENABLED = true
local HEADLESS = false
local FPS_CAP = 30
local BATCH_SIZE = 400
local KEEP_DECALS = false
local STOP_ANIMS = true
local STOP_OWN_ANIMS = false
local HIDE_ACCESSORIES = true
local STOP_SOUNDS = true
if not ENABLED then return end
if not game:IsLoaded() then game.Loaded:Wait() end
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
if setfpscap then
pcall(setfpscap, FPS_CAP)
task.spawn(function()
while isCurrent() do
task.wait(15)
pcall(setfpscap, FPS_CAP)
end
end)
else
warn("[fps_boost] this executor has no setfpscap, the FPS cap can't be applied")
end
pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
pcall(function() UserSettings().GameSettings.MasterVolume = 0 end)
if HEADLESS then
pcall(function() RunService:Set3dRenderingEnabled(false) end)
env.__fpsHeadless = true
elseif env.__fpsHeadless then
pcall(function() RunService:Set3dRenderingEnabled(true) end)
env.__fpsHeadless = false
end
pcall(function()
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.ShadowSoftness = 0
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
end)
for _, v in ipairs(Lighting:GetChildren()) do
if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
pcall(function() v:Destroy() end)
end
end
track(Lighting.ChildAdded:Connect(function(v)
if v:IsA("PostEffect") or v:IsA("Atmosphere") then
task.defer(function() pcall(function() v:Destroy() end) end)
end
end))
if Terrain then
pcall(function()
Terrain.Decoration = false
Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0
end)
local clouds = Terrain:FindFirstChildOfClass("Clouds")
if clouds then pcall(function() clouds:Destroy() end) end
end
local function strip(v)
if v:IsA("BasePart") then
v.Material = Enum.Material.SmoothPlastic
v.Reflectance = 0
v.CastShadow = false
if v:IsA("MeshPart") then
v.RenderFidelity = Enum.RenderFidelity.Performance
if not KEEP_DECALS then v.TextureID = "" end
end
elseif (v:IsA("Decal") or v:IsA("Texture")) and not KEEP_DECALS then
v:Destroy()
elseif (v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic")) and not KEEP_DECALS then
v:Destroy()
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
v.Enabled = false
elseif v:IsA("Light") then
v.Enabled = false
elseif v:IsA("Explosion") then
v.Visible = false
elseif v:IsA("SurfaceAppearance") then
v:Destroy()
end
end
local function safeStrip(v) pcall(strip, v) end
task.spawn(function()
local all = workspace:GetDescendants()
for i, v in ipairs(all) do
if not isCurrent() then return end
safeStrip(v)
if i % BATCH_SIZE == 0 then task.wait() end
end
end)
track(workspace.DescendantAdded:Connect(function(v)
task.defer(safeStrip, v)
end))
local function isOwn(model)
return player and player.Character == model
end
local function hookAnimator(animator, model)
if not STOP_ANIMS then return end
if isOwn(model) and not STOP_OWN_ANIMS then return end
for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
pcall(function() tr:Stop(0) end)
end
track(animator.AnimationPlayed:Connect(function(tr)
pcall(function() tr:Stop(0) end)
end))
end
local function handleCharacter(model)
if not model then return end
local own = isOwn(model)
local function apply(v)
if v:IsA("Animator") then
hookAnimator(v, model)
elseif v:IsA("Accessory") and HIDE_ACCESSORIES and not own then
task.defer(function() pcall(function() v:Destroy() end) end)
end
end
for _, v in ipairs(model:GetDescendants()) do pcall(apply, v) end
track(model.DescendantAdded:Connect(function(v) pcall(apply, v) end))
end
local function hookPlayer(p)
if p.Character then handleCharacter(p.Character) end
track(p.CharacterAdded:Connect(handleCharacter))
end
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
track(Players.PlayerAdded:Connect(hookPlayer))
local function hookNPC(v)
if v:IsA("Animator") then
local model = v:FindFirstAncestorOfClass("Model")
if model and not Players:GetPlayerFromCharacter(model) then
hookAnimator(v, model)
end
end
end
for _, v in ipairs(workspace:GetDescendants()) do pcall(hookNPC, v) end
track(workspace.DescendantAdded:Connect(function(v) pcall(hookNPC, v) end))
if STOP_SOUNDS then
local function killSound(v)
if v:IsA("Sound") then
v.Playing = false
v.Volume = 0
track(v:GetPropertyChangedSignal("Playing"):Connect(function()
if v.Playing then v.Playing = false end
end))
end
end
for _, v in ipairs(game:GetDescendants()) do pcall(killSound, v) end
track(game.DescendantAdded:Connect(function(v) pcall(killSound, v) end))
end
print("[fps_boost] applied | headless =", HEADLESS, "| cap =", FPS_CAP)
end)
local containers = {}
pcall(function()
if gethui then
table.insert(containers, gethui())
end
end)
if CoreGui then
table.insert(containers, CoreGui)
end
do
local oldPlayerGui = player:FindFirstChild("PlayerGui")
if oldPlayerGui then
table.insert(containers, oldPlayerGui)
end
end
for _, container in ipairs(containers) do
pcall(function()
for _, child in ipairs(container:GetChildren()) do
if child.Name == "PlayerUI" or child.Name == "LowServerBrowser" or child.Name == "TimerControls" then
child:Destroy()
end
end
end)
end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 2147483647
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
do
local okParent = pcall(function()
screenGui.Parent = (gethui and gethui()) or CoreGui
end)
if not okParent or not screenGui.Parent then
screenGui.Parent = player:WaitForChild("PlayerGui")
end
end
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Size = UDim2.new(0, 180, 0, 104)
frame.Position = UDim2.new(0.5, 0, 0.5, -40)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 140, 255)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame
local avatar = Instance.new("ImageLabel")
avatar.Name = "Avatar"
avatar.Size = UDim2.new(0, 50, 0, 50)
avatar.Position = UDim2.new(0, 6, 0, 6)
avatar.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
avatar.BackgroundTransparency = 0
avatar.ZIndex = 2
avatar.Parent = frame
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(0, 140, 255)
avatarStroke.Thickness = 2
avatarStroke.Parent = avatar
task.spawn(function()
local ok, content = pcall(function()
return Players:GetUserThumbnailAsync(
player.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size100x100
)
end)
if ok and content then
avatar.Image = content
end
end)
local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "DisplayName"
nameLabel.ZIndex = 2
nameLabel.Size = UDim2.new(1, -84, 0, 26)
nameLabel.Position = UDim2.new(0, 62, 0, 7)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.DisplayName
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextSize = 26
nameLabel.TextScaled = true
nameLabel.TextWrapped = false
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.TextYAlignment = Enum.TextYAlignment.Center
nameLabel.Parent = frame
do
local lim = Instance.new("UITextSizeConstraint")
lim.MaxTextSize = 18
lim.MinTextSize = 8
lim.Parent = nameLabel
end
local toggleBrowser = nil
local listBtn = Instance.new("TextButton")
listBtn.Name = "ServersButton"
listBtn.ZIndex = 3
listBtn.Size = UDim2.new(0, 50, 0, 18)
listBtn.Position = UDim2.new(0, 62, 0, 38)
listBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
listBtn.BorderSizePixel = 0
listBtn.Text = "Srv"
listBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
listBtn.TextSize = 11
listBtn.Font = Enum.Font.GothamBold
listBtn.Parent = frame
Instance.new("UICorner", listBtn).CornerRadius = UDim.new(0, 4)
listBtn.Activated:Connect(function()
if toggleBrowser then
toggleBrowser()
end
end)
print("PlaceId:", game.PlaceId)
local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "Playtime"
timerLabel.ZIndex = 2
timerLabel.Size = UDim2.new(1, -86, 0, 24)
timerLabel.Position = UDim2.new(0, 6, 0, 60)
timerLabel.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
timerLabel.BorderSizePixel = 0
timerLabel.Text = "00:00:00"
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.Font = Enum.Font.Code
timerLabel.TextScaled = true
timerLabel.Parent = frame
Instance.new("UICorner", timerLabel).CornerRadius = UDim.new(0, 6)
local timerStroke = Instance.new("UIStroke")
timerStroke.Color = Color3.fromRGB(0, 140, 255)
timerStroke.Transparency = 0.5
timerStroke.Thickness = 1.5
timerStroke.Parent = timerLabel
do
local lim = Instance.new("UITextSizeConstraint")
lim.MaxTextSize = 18
lim.MinTextSize = 8
lim.Parent = timerLabel
end
local startMainBtn = Instance.new("TextButton")
startMainBtn.Name = "StartButton"
startMainBtn.ZIndex = 3
startMainBtn.Size = timerLabel.Size
startMainBtn.Position = timerLabel.Position
startMainBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
startMainBtn.BorderSizePixel = 0
startMainBtn.Text = "Start"
startMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startMainBtn.TextSize = 13
startMainBtn.TextScaled = true
do
local lim = Instance.new("UITextSizeConstraint")
lim.MaxTextSize = 13
lim.MinTextSize = 8
lim.Parent = startMainBtn
end
startMainBtn.Font = Enum.Font.GothamBold
startMainBtn.Parent = frame
Instance.new("UICorner", startMainBtn).CornerRadius = UDim.new(0, 6)
local timeBtn = Instance.new("TextButton")
timeBtn.Name = "TimeButton"
timeBtn.ZIndex = 3
timeBtn.Size = UDim2.new(0, 50, 0, 18)
timeBtn.Position = UDim2.new(0, 118, 0, 38)
timeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
timeBtn.BorderSizePixel = 0
timeBtn.Text = "Time"
timeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
timeBtn.TextSize = 11
timeBtn.Font = Enum.Font.GothamBold
timeBtn.Parent = frame
Instance.new("UICorner", timeBtn).CornerRadius = UDim.new(0, 4)
local timePanel = Instance.new("Frame")
timePanel.Name = "TimerControls"
timePanel.Size = UDim2.fromOffset(150, 54)
timePanel.Position = UDim2.new(0.5, -75, 0.5, 10)
timePanel.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
timePanel.BorderSizePixel = 0
timePanel.Active = true
timePanel.Draggable = true
timePanel.Visible = false
timePanel.Parent = screenGui
Instance.new("UICorner", timePanel).CornerRadius = UDim.new(0, 8)
local timePanelTitle = Instance.new("TextLabel")
timePanelTitle.Size = UDim2.new(1, -30, 0, 20)
timePanelTitle.Position = UDim2.fromOffset(8, 0)
timePanelTitle.BackgroundTransparency = 1
timePanelTitle.Text = "Timer"
timePanelTitle.TextColor3 = Color3.new(1, 1, 1)
timePanelTitle.Font = Enum.Font.GothamBold
timePanelTitle.TextSize = 11
timePanelTitle.TextXAlignment = Enum.TextXAlignment.Left
timePanelTitle.Parent = timePanel
local timeCloseBtn = Instance.new("TextButton")
timeCloseBtn.Size = UDim2.fromOffset(16, 14)
timeCloseBtn.Position = UDim2.new(1, -20, 0, 3)
timeCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
timeCloseBtn.BorderSizePixel = 0
timeCloseBtn.Text = "X"
timeCloseBtn.TextColor3 = Color3.new(1, 1, 1)
timeCloseBtn.Font = Enum.Font.GothamBold
timeCloseBtn.TextSize = 10
timeCloseBtn.Parent = timePanel
Instance.new("UICorner", timeCloseBtn).CornerRadius = UDim.new(0, 6)
local function makeTimeBtn(name, text, x, w, color)
local b = Instance.new("TextButton")
b.Name = name
b.Size = UDim2.new(0, w, 0, 22)
b.Position = UDim2.new(0, x, 0, 24)
b.BackgroundColor3 = color
b.BorderSizePixel = 0
b.Text = text
b.TextColor3 = Color3.fromRGB(255, 255, 255)
b.TextSize = 11
b.Font = Enum.Font.GothamBold
b.Parent = timePanel
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
return b
end
local startBtn = makeTimeBtn("TimerToggle", "Start", 6, 66, Color3.fromRGB(40, 160, 80))
local resetBtn = makeTimeBtn("TimerReset", "Reset", 78, 66, Color3.fromRGB(200, 70, 70))
local TIMER_FILE = "AccountPlaytime_" .. player.UserId .. ".txt"
local total = 0
local running = false
local lastTick = os.time()
local TARGET_FILE = "AccountTarget_" .. player.UserId .. ".txt"
local TARGET_CHOICES = { 12, 24, 48, 72 }
local targetH = 24
local needPick = true
local chipsExtra = 0
local relayout = function() end
if hasFS then
pcall(function()
for _, f in ipairs({ TARGET_FILE, TARGET_FILE .. ".b" }) do
local v = isfile(f) and tonumber(readfile(f))
if v and v >= 1 and v <= 9999 and v == math.floor(v) then
targetH = v
needPick = false
break
end
end
end)
end
local function fmt(t)
local d = math.floor(t / 86400)
local h = math.floor((t % 86400) / 3600)
local m = math.floor((t % 3600) / 60)
local sec = t % 60
if d > 0 then
return string.format("%dD %02d:%02d:%02d", d, h, m, sec)
end
return string.format("%02d:%02d:%02d", h, m, sec)
end
local saveFlip = false
local lastC = 0
local function save()
if hasFS then
local line = string.format("%d,%d,%d", math.floor(total), os.time(), running and 1 or 0)
if os.time() - lastC >= 30 then
lastC = os.time()
pcall(writefile, TIMER_FILE .. ".c", line)
end
saveFlip = not saveFlip
pcall(writefile, saveFlip and TIMER_FILE or (TIMER_FILE .. ".b"), line)
pcall(writefile, saveFlip and (TIMER_FILE .. ".b") or TIMER_FILE, line)
end
end
local timerFill = Instance.new("Frame")
timerFill.Name = "Progress"
timerFill.BackgroundColor3 = Color3.fromRGB(80, 190, 255)
timerFill.BackgroundTransparency = 0.8
timerFill.BorderSizePixel = 0
timerFill.Size = UDim2.new(0, 0, 1, 0)
timerFill.Parent = timerLabel
Instance.new("UICorner", timerFill).CornerRadius = UDim.new(0, 6)
local endLabel = Instance.new("TextLabel")
endLabel.Name = "EndsAt"
endLabel.ZIndex = 2
endLabel.BackgroundTransparency = 1
endLabel.Size = UDim2.new(1, -12, 0, 14)
endLabel.Position = UDim2.new(0, 6, 0, 86)
endLabel.Font = Enum.Font.GothamBold
endLabel.TextSize = 11
endLabel.TextColor3 = Color3.fromRGB(170, 228, 255)
endLabel.TextXAlignment = Enum.TextXAlignment.Left
endLabel.Parent = frame
local function span(sec)
sec = math.max(0, sec)
local d = math.floor(sec / 86400)
local h = math.floor((sec % 86400) / 3600)
local m = math.floor((sec % 3600) / 60)
if d > 0 then return string.format("%dd %dh", d, h) end
if h > 0 then return string.format("%dh %02dm", h, m) end
return string.format("%dm", m)
end
local hoursBtn = Instance.new("TextButton")
hoursBtn.Name = "HoursBadge"
hoursBtn.ZIndex = 4
hoursBtn.AnchorPoint = Vector2.new(1, 0)
hoursBtn.Size = UDim2.new(0, 72, 0, 28)
hoursBtn.Position = UDim2.new(1, -6, 0, 58)
hoursBtn.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
hoursBtn.BorderSizePixel = 0
hoursBtn.Text = targetH .. "H"
hoursBtn.TextColor3 = Color3.new(1, 1, 1)
hoursBtn.TextSize = 19
hoursBtn.Font = Enum.Font.GothamBold
hoursBtn.Parent = frame
Instance.new("UICorner", hoursBtn).CornerRadius = UDim.new(0, 6)
local hoursStroke = Instance.new("UIStroke")
hoursStroke.Color = Color3.fromRGB(190, 238, 255)
hoursStroke.Thickness = 1.2
hoursStroke.Transparency = 0.25
hoursStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
hoursStroke.Parent = hoursBtn
local hoursTextStroke = Instance.new("UIStroke")
hoursTextStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
hoursTextStroke.Color = Color3.new(0, 0, 0)
hoursTextStroke.Thickness = 1.5
hoursTextStroke.Transparency = 0
hoursTextStroke.Parent = hoursBtn
local function updateTimerText()
local goal = targetH * 3600
timerLabel.Text = fmt(total)
hoursBtn.Text = needPick and "--" or (targetH .. "H")
hoursBtn.TextSize = (not needPick and targetH >= 100) and 15 or 19
if total >= goal then
timerLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
else
timerLabel.TextColor3 = running and Color3.fromRGB(120, 228, 255) or Color3.fromRGB(205, 228, 255)
end
timerFill.Size = UDim2.new(math.clamp(total / goal, 0, 1), 0, 1, 0)
local remain = goal - total
if needPick then
endLabel.Text = running and "Counting...  choose the hours below" or "Choose the hours below"
endLabel.TextColor3 = Color3.fromRGB(170, 228, 255)
timerFill.Size = UDim2.new(0, 0, 1, 0)
timerLabel.TextColor3 = Color3.fromRGB(205, 228, 255)
elseif remain <= 0 then
endLabel.Text = "TIME'S UP  +" .. span(-remain)
endLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
elseif running then
endLabel.Text = span(remain) .. " left"
endLabel.TextColor3 = Color3.fromRGB(170, 228, 255)
else
endLabel.Text = "Paused  (" .. span(remain) .. " left)"
endLabel.TextColor3 = Color3.fromRGB(150, 170, 200)
end
end
local chipRow = Instance.new("Frame")
chipRow.Name = "DurationChoices"
chipRow.ZIndex = 3
chipRow.BackgroundTransparency = 1
chipRow.Size = UDim2.new(1, -12, 0, 46)
chipRow.Position = UDim2.new(0, 6, 0, 104)
chipRow.Visible = false
chipRow.Parent = frame
do
local line = Instance.new("Frame")
line.Name = "Line"
line.BackgroundTransparency = 1
line.Size = UDim2.new(1, 0, 0, 20)
line.Parent = chipRow
local lay = Instance.new("UIListLayout")
lay.FillDirection = Enum.FillDirection.Horizontal
lay.Padding = UDim.new(0, 4)
lay.Parent = line
end
local chips = {}
local function paintChips()
local m = env.__themeMix or 0
for h, b in pairs(chips) do
if h < 2000 or h >= 3000 then
local on = (not needPick) and (h % 1000 == targetH)
b.BackgroundColor3 = on and Color3.fromRGB(40, 130, 255):Lerp(Color3.fromRGB(225, 50, 60), m)
or Color3.fromRGB(24, 48, 100):Lerp(Color3.fromRGB(80, 24, 36), m)
b.TextColor3 = on and Color3.new(1, 1, 1) or Color3.fromRGB(150, 190, 240):Lerp(Color3.fromRGB(240, 170, 170), m)
end
end
end
local pickPanel = Instance.new("Frame")
pickPanel.Name = "PickHours"
pickPanel.ZIndex = 6
pickPanel.Position = UDim2.new(0, 6, 0, 104)
pickPanel.Size = UDim2.new(1, -12, 0, 70)
pickPanel.BackgroundColor3 = Color3.fromRGB(7, 17, 42)
pickPanel.BorderSizePixel = 0
pickPanel.Visible = false
pickPanel.Parent = frame
Instance.new("UICorner", pickPanel).CornerRadius = UDim.new(0, 8)
local pickStroke = Instance.new("UIStroke")
pickStroke.Color = Color3.fromRGB(60, 205, 255)
pickStroke.Thickness = 1.5
pickStroke.Transparency = 0.2
pickStroke.Parent = pickPanel
local function setTarget(h)
if type(h) ~= "number" or h < 1 or h > 9999 then return end
h = math.floor(h + 0.5)
local wasPicking = needPick
targetH = h
needPick = false
pickPanel.Visible = false
if hasFS then
pcall(writefile, TARGET_FILE, tostring(h))
pcall(writefile, TARGET_FILE .. ".b", tostring(h))
end
paintChips()
updateTimerText()
chipRow.Visible = false
if env.__menuClose then env.__menuClose() end
chipsExtra = 0
relayout()
if env.__renderT then env.__renderT() end
if wasPicking and env.__afterPick then
env.__afterPick()
end
end
for _, h in ipairs(TARGET_CHOICES) do
local b = Instance.new("TextButton")
b.Name = "Choice" .. h
b.ZIndex = 3
b.Size = UDim2.new(0.25, -3, 1, 0)
b.BorderSizePixel = 0
b.Text = h .. "H"
b.TextSize = 12
b.Font = Enum.Font.GothamBold
b.Parent = chipRow.Line
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
b.Activated:Connect(function()
setTarget(h)
end)
chips[h] = b
end
paintChips()
local function makeCustom(parent, z, x, y)
local box = Instance.new("TextBox")
box.ZIndex = z
box.Position = UDim2.new(0, x, 0, y)
box.Size = UDim2.new(1, -(2 * x + 52), 0, 20)
box.BackgroundColor3 = Color3.fromRGB(10, 24, 58)
box.BorderSizePixel = 0
box.Text = ""
box.PlaceholderText = "custom hours (e.g. 96)"
box.PlaceholderColor3 = Color3.fromRGB(110, 140, 190)
box.TextColor3 = Color3.new(1, 1, 1)
box.TextSize = 11
box.Font = Enum.Font.GothamBold
box.ClearTextOnFocus = true
box.Parent = parent
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
local st = Instance.new("UIStroke")
st.Color = Color3.fromRGB(60, 150, 255)
st.Transparency = 0.4
st.Parent = box
local go = Instance.new("TextButton")
go.ZIndex = z
go.Position = UDim2.new(1, -(x + 48), 0, y)
go.Size = UDim2.new(0, 48, 0, 20)
go.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
go.BorderSizePixel = 0
go.Text = "SET"
go.TextColor3 = Color3.new(1, 1, 1)
go.TextSize = 11
go.Font = Enum.Font.GothamBold
go.Parent = parent
Instance.new("UICorner", go).CornerRadius = UDim.new(0, 5)
local function apply()
local n = tonumber((box.Text:gsub("[^%d%.]", "")))
box.Text = ""
if n and n >= 1 and n <= 9999 then
setTarget(n)
else
box.PlaceholderText = "type hours, 1-9999"
end
end
go.Activated:Connect(apply)
box.FocusLost:Connect(function(enter)
if enter then apply() end
end)
end
makeCustom(chipRow, 4, 0, 26)
do
local head = Instance.new("TextLabel")
head.ZIndex = 7
head.BackgroundTransparency = 1
head.Position = UDim2.new(0, 8, 0, 3)
head.Size = UDim2.new(1, -16, 0, 12)
head.Text = "HOW MANY HOURS FOR THIS ACCOUNT?"
head.TextColor3 = Color3.fromRGB(170, 228, 255)
head.TextSize = 9
head.Font = Enum.Font.GothamBold
head.TextXAlignment = Enum.TextXAlignment.Left
head.Parent = pickPanel
local row = Instance.new("Frame")
row.ZIndex = 7
row.BackgroundTransparency = 1
row.Position = UDim2.new(0, 5, 0, 17)
row.Size = UDim2.new(1, -10, 0, 24)
row.Parent = pickPanel
local lay = Instance.new("UIListLayout")
lay.FillDirection = Enum.FillDirection.Horizontal
lay.Padding = UDim.new(0, 4)
lay.Parent = row
for _, h in ipairs(TARGET_CHOICES) do
local bg = Instance.new("Frame")
bg.Name = "PickBg" .. h
bg.ZIndex = 7
bg.Size = UDim2.new(0.25, -3, 1, 0)
bg.BackgroundColor3 = Color3.new(1, 1, 1)
bg.BorderSizePixel = 0
bg.Parent = row
Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
local g = Instance.new("UIGradient")
g.Color = ColorSequence.new(Color3.fromRGB(60, 205, 255), Color3.fromRGB(30, 90, 235))
g.Rotation = 90
g.Parent = bg
local b = Instance.new("TextButton")
b.Name = "Pick" .. h
b.ZIndex = 8
b.Size = UDim2.new(1, 0, 1, 0)
b.BackgroundTransparency = 1
b.Text = h .. "H"
b.TextColor3 = Color3.new(1, 1, 1)
b.TextStrokeColor3 = Color3.fromRGB(0, 30, 90)
b.TextStrokeTransparency = 0.5
b.TextSize = 14
b.Font = Enum.Font.GothamBold
b.Parent = bg
b.Activated:Connect(function()
setTarget(h)
end)
chips[2000 + h] = b
end
makeCustom(pickPanel, 8, 5, 45)
end
hoursBtn.Activated:Connect(function()
if env.__menuToggle then env.__menuToggle("hours") end
end)
local function render()
updateTimerText()
startBtn.Text = running and "Pause" or "Start"
startBtn.BackgroundColor3 = running and Color3.fromRGB(30, 150, 230) or Color3.fromRGB(40, 110, 235)
startMainBtn.Visible = (not running) and not pickPanel.Visible
timerLabel.Visible = not startMainBtn.Visible
startMainBtn.Text = needPick and "Set hours" or (total > 0 and ("Start   " .. fmt(total)) or "Start")
if needPick then
chipRow.Visible = false
chipsExtra = pickPanel.Visible and 76 or (env.__menuH or 0)
end
relayout()
end
env.__renderT = render
local function startTimer()
if running or (needPick and not COUNT_BEFORE_CHOICE) then return end
running = true
lastTick = os.time()
render()
save()
end
local function pauseTimer()
if not running then return end
total = total + math.min(5, math.max(0, os.time() - lastTick))
running = false
render()
save()
end
local function resetTimer()
total = 0
if not COUNT_BEFORE_CHOICE then
running = false
end
lastTick = os.time()
needPick = true
pickPanel.Visible = false
if hasFS then
pcall(writefile, TARGET_FILE, "")
pcall(writefile, TARGET_FILE .. ".b", "")
end
paintChips()
render()
save()
end
do
local BLUE, GREY, DARK = Color3.fromRGB(40, 130, 255), Color3.fromRGB(16, 32, 70), Color3.fromRGB(8, 18, 44)
local menu = Instance.new("Frame")
menu.Name = "TimeMenu"
menu.Size = UDim2.new(1, 0, 1, -60)
env.__menuMin = nil
env.__srvMin = nil
menu.Position = UDim2.new(0, 0, 0, 60)
menu.BackgroundColor3 = DARK
menu.BorderSizePixel = 0
menu.ZIndex = 5
menu.Visible = false
menu.Parent = frame
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 9)
local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(60, 190, 255)
ms.Transparency = 0.35
ms.Thickness = 1.2
ms.Parent = menu
local function lbl(parent, text, size, col, font, xa)
local l = Instance.new("TextLabel")
l.BackgroundTransparency = 1
l.Text = text
l.TextSize = size
l.TextColor3 = col
l.Font = font or Enum.Font.GothamBold
l.TextXAlignment = xa or Enum.TextXAlignment.Center
l.Parent = parent
return l
end
local function btn(parent, text, size, col)
local b = Instance.new("TextButton")
b.BackgroundColor3 = col
b.BorderSizePixel = 0
b.AutoButtonColor = true
b.Text = text
b.TextColor3 = Color3.new(1, 1, 1)
b.TextSize = size
b.Font = Enum.Font.GothamBold
b.Parent = parent
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
return b
end
local head = lbl(menu, "TIME", 10, Color3.fromRGB(170, 228, 255), nil, Enum.TextXAlignment.Left)
head.Position = UDim2.fromOffset(10, 3)
head.Size = UDim2.new(1, -40, 0, 14)
local x = btn(menu, "X", 10, Color3.fromRGB(200, 70, 85))
x.Position = UDim2.new(1, -24, 0, 3)
x.Size = UDim2.fromOffset(18, 14)
local tabs = Instance.new("Frame")
tabs.BackgroundColor3 = GREY
tabs.BorderSizePixel = 0
tabs.Position = UDim2.new(0, 6, 0, 4)
tabs.Size = UDim2.new(1, -34, 0, 24)
tabs.Parent = menu
Instance.new("UICorner", tabs).CornerRadius = UDim.new(0, 7)
local setB = btn(tabs, "Set", 12, GREY)
setB.Position = UDim2.fromOffset(2, 2)
setB.Size = UDim2.new(1 / 3, -3, 1, -4)
setB.Visible = false
local editB = btn(tabs, "Edit", 12, GREY)
editB.Position = UDim2.fromOffset(2, 2)
editB.Size = UDim2.new(0.5, -3, 1, -4)
local resB = btn(tabs, "Reset", 12, GREY)
resB.Position = UDim2.new(0.5, 1, 0, 2)
resB.Size = UDim2.new(0.5, -3, 1, -4)
local setPg = Instance.new("Frame")
setPg.BackgroundTransparency = 1
setPg.Position = UDim2.new(0, 6, 0, 22)
setPg.Size = UDim2.new(1, -12, 0, 86)
setPg.Visible = false
setPg.Parent = menu
local sl = lbl(setPg, "SELECT HOURS", 9, Color3.fromRGB(120, 170, 230), nil, Enum.TextXAlignment.Left)
sl.Size = UDim2.new(1, 0, 0, 10)
local row = Instance.new("Frame")
row.BackgroundTransparency = 1
row.Position = UDim2.fromOffset(0, 14)
row.Size = UDim2.new(1, 0, 0, 30)
row.Parent = setPg
local lay = Instance.new("UIListLayout")
lay.FillDirection = Enum.FillDirection.Horizontal
lay.Padding = UDim.new(0, 4)
lay.Parent = row
for _, h in ipairs(TARGET_CHOICES) do
local b = btn(row, h .. "H", 15, BLUE)
b.Size = UDim2.new(0.25, -3, 1, 0)
local bs = Instance.new("UIStroke")
bs.Color = Color3.fromRGB(120, 200, 255)
bs.Transparency = 0.6
bs.Parent = b
b.Activated:Connect(function()
setTarget(h)
end)
chips[3000 + h] = b
end
local cl = lbl(setPg, "or type a custom number of hours", 9, Color3.fromRGB(120, 170, 230), nil, Enum.TextXAlignment.Left)
cl.Position = UDim2.fromOffset(0, 50)
cl.Size = UDim2.new(1, 0, 0, 10)
makeCustom(setPg, 4, 0, 62)
paintChips()
local edPg = Instance.new("Frame")
edPg.BackgroundTransparency = 1
edPg.Position = UDim2.new(0, 6, 0, 32)
edPg.Size = UDim2.new(1, -12, 0, 80)
edPg.Visible = false
edPg.Parent = menu
local box = Instance.new("Frame")
box.BackgroundColor3 = GREY
box.BorderSizePixel = 0
box.Size = UDim2.new(1, 0, 0, 24)
box.Parent = edPg
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 7)
local cur = lbl(box, "00:00:00", 18, Color3.new(1, 1, 1), Enum.Font.Code)
cur.Size = UDim2.new(1, 0, 1, 0)
cur.TextScaled = true
local lim = Instance.new("UITextSizeConstraint")
lim.MaxTextSize = 18
lim.Parent = cur
local minusB = btn(edPg, "- 1 hr", 12, Color3.fromRGB(190, 55, 80))
minusB.Position = UDim2.fromOffset(0, 28)
minusB.Size = UDim2.new(0.5, -2, 0, 24)
local plusB = btn(edPg, "+ 1 hr", 12, Color3.fromRGB(40, 160, 90))
plusB.Position = UDim2.new(0.5, 2, 0, 28)
plusB.Size = UDim2.new(0.5, -2, 0, 24)
local cbox = Instance.new("TextBox")
cbox.Position = UDim2.fromOffset(0, 56)
cbox.Size = UDim2.new(1, -52, 0, 22)
cbox.BackgroundColor3 = Color3.fromRGB(10, 24, 58)
cbox.BorderSizePixel = 0
cbox.Text = ""
cbox.PlaceholderText = "custom + hrs (5 or -2)"
cbox.PlaceholderColor3 = Color3.fromRGB(110, 140, 190)
cbox.TextColor3 = Color3.new(1, 1, 1)
cbox.TextSize = 11
cbox.Font = Enum.Font.GothamBold
cbox.ClearTextOnFocus = true
cbox.Parent = edPg
Instance.new("UICorner", cbox).CornerRadius = UDim.new(0, 6)
local cst = Instance.new("UIStroke")
cst.Color = Color3.fromRGB(60, 150, 255)
cst.Transparency = 0.4
cst.Parent = cbox
local cadd = btn(edPg, "ADD", 11, BLUE)
cadd.Position = UDim2.new(1, -48, 0, 56)
cadd.Size = UDim2.fromOffset(48, 22)
local resPg = Instance.new("Frame")
resPg.BackgroundTransparency = 1
resPg.Position = UDim2.new(0, 6, 0, 32)
resPg.Size = UDim2.new(1, -12, 0, 56)
resPg.Visible = false
resPg.Parent = menu
local rq = lbl(resPg, "Reset the time to 0 and ask the hours again?", 10, Color3.fromRGB(200, 220, 255), nil)
rq.Size = UDim2.new(1, 0, 0, 24)
rq.TextWrapped = true
local rYes = btn(resPg, "Reset", 12, Color3.fromRGB(200, 60, 80))
rYes.Position = UDim2.fromOffset(0, 28)
rYes.Size = UDim2.new(0.5, -2, 0, 24)
local rNo = btn(resPg, "Cancel", 12, GREY)
rNo.Position = UDim2.new(0.5, 2, 0, 28)
rNo.Size = UDim2.new(0.5, -2, 0, 24)
local mode = "time"
local function page(which)
local withTabs = mode == "time"
tabs.Visible = withTabs
head.Text = "HOURS"
head.Visible = not withTabs
x.Position = withTabs and UDim2.new(1, -24, 0, 7) or UDim2.new(1, -24, 0, 3)
local base = withTabs and 32 or 22
for _, pg in ipairs({ setPg, edPg, resPg }) do
pg.Position = UDim2.new(0, 6, 0, base)
end
setPg.Visible = which == "set"
edPg.Visible = which == "edit"
resPg.Visible = which == "reset"
if which == "reset" then
rq.Text = "Reset " .. fmt(running and (total + math.min(5, math.max(0, os.time() - lastTick))) or total) .. " back to 0 and ask the hours again?"
end
setB.BackgroundColor3 = which == "set" and BLUE or GREY
editB.BackgroundColor3 = which == "edit" and BLUE or GREY
resB.BackgroundColor3 = which == "reset" and Color3.fromRGB(200, 60, 80) or GREY
local h = base + (which == "set" and 90 or (which == "edit" and 80 or (which == "reset" and 56 or 0)))
if not which then h = 32 end
env.__menuH = 0
env.__menuMin = menu.Visible and (60 + h + 6) or nil
chipsExtra = 0
relayout()
end
local function shown()
return running and (total + math.min(5, math.max(0, os.time() - lastTick))) or total
end
local function refreshEd()
cur.Text = fmt(shown())
end
local function bump(d)
if running then
total = total + math.min(5, math.max(0, os.time() - lastTick))
lastTick = os.time()
end
total = math.max(0, total + d)
refreshEd()
render()
save()
end
plusB.Activated:Connect(function() bump(3600) end)
minusB.Activated:Connect(function() bump(-3600) end)
local function addCustom()
local n = tonumber((cbox.Text:gsub("[^%d%.%-]", "")))
cbox.Text = ""
if n and n ~= 0 and math.abs(n) <= 9999 then
bump(math.floor(n * 3600 + 0.5))
else
cbox.PlaceholderText = "type hours, e.g. 5 or -2"
end
end
cadd.Activated:Connect(addCustom)
cbox.FocusLost:Connect(function(enter)
if enter then addCustom() end
end)
rYes.Activated:Connect(function()
resetTimer()
if env.__menuClose then env.__menuClose() end
chipsExtra = 0
relayout()
end)
rNo.Activated:Connect(function() page(nil) end)
resB.Activated:Connect(function() page("reset") end)
setB.Activated:Connect(function() page("set") end)
editB.Activated:Connect(function()
refreshEd()
page("edit")
end)
local function closeMenu()
menu.Visible = false
env.__menuH = 0
env.__menuMin = nil
end
env.__menuClose = closeMenu
x.Activated:Connect(function()
closeMenu()
chipsExtra = 0
relayout()
end)
task.spawn(function()
while menu.Parent do
if menu.Visible and edPg.Visible then
refreshEd()
end
task.wait(0.5)
end
end)
local function toggle(m)
m = m or "time"
if menu.Visible and mode == m then
closeMenu()
chipsExtra = 0
relayout()
else
mode = m
if env.__srvClose then env.__srvClose() end
pickPanel.Visible = false
menu.Visible = true
if m == "hours" then
page("set")
else
refreshEd()
page("edit")
end
render()
end
end
env.__menuToggle = toggle
env.__menuReset = function()
mode = "time"
if env.__srvClose then env.__srvClose() end
pickPanel.Visible = false
menu.Visible = true
page("reset")
render()
end
menu.ZIndex = 30
for _, d in ipairs(menu:GetDescendants()) do
if d:IsA("GuiObject") then d.ZIndex = 31 end
end
end
local resumeNow = false
if hasFS then
pcall(function()
local bt, bseen, brun
for _, f in ipairs({ TIMER_FILE, TIMER_FILE .. ".b", TIMER_FILE .. ".c" }) do
local okr, data = pcall(function() return isfile(f) and readfile(f) or "" end)
local t, seen, run = string.match(okr and data or "", "(%d+),(%d+),(%d)")
if t and seen and (not bseen or tonumber(seen) > bseen) then
bt, bseen, brun = tonumber(t), tonumber(seen), run
end
end
if bt then
total = bt
if AUTO_RESUME_ON_HOP and brun == "1" and (os.time() - bseen) <= RESTART_GAP then
resumeNow = true
end
end
end)
end
if (resumeNow or AUTO_START_TIMER) and (COUNT_BEFORE_CHOICE or not needPick) then
startTimer()
else
render()
save()
end
env.__afterPick = function()
if AUTO_START_TIMER then
startTimer()
end
end
startBtn.Activated:Connect(function()
if running then pauseTimer() else startTimer() end
end)
resetBtn.Activated:Connect(function()
if env.__menuReset then env.__menuReset() else resetTimer() end
end)
startMainBtn.Activated:Connect(function()
if needPick then
pickPanel.Visible = true
render()
else
startTimer()
end
end)
timeBtn.Activated:Connect(function()
if env.__menuToggle then env.__menuToggle("time") end
end)
timeCloseBtn.Activated:Connect(function()
timePanel.Visible = false
end)
env.StartTimer = function()
env.TimerStartRequested = true
end
env.PauseTimer = function()
env.TimerPauseRequested = true
end
env.SetTarget = function(h)
setTarget(h)
end
env.ResetTimer = function()
env.TimerResetRequested = true
end
task.spawn(function()
local lastSave = 0
while isCurrent() do
if env.TimerStartRequested and (COUNT_BEFORE_CHOICE or not needPick) then
env.TimerStartRequested = false
startTimer()
end
if env.TimerPauseRequested then
env.TimerPauseRequested = false
pauseTimer()
end
if env.TimerResetRequested then
env.TimerResetRequested = false
resetTimer()
end
local now = os.time()
local okm, emsg = pcall(function() return game:GetService("GuiService"):GetErrorMessage() end)
local offline = okm and type(emsg) == "string" and emsg ~= ""
if running and offline then
lastTick = now
if now - lastSave >= 2 then
lastSave = now
save()
end
elseif running then
local d = now - lastTick
if d > 5 then d = 1 end
total = total + math.max(0, d)
updateTimerText()
if now - lastSave >= 2 then
lastSave = now
save()
end
end
lastTick = now
task.wait(1)
end
end)
task.spawn(function()
local SUPABASE_URL = "https://skgevraocihnyvecmaeq.supabase.co"
local SUPABASE_KEY = SUPABASE_KEY_TOP
local REPORT_EVERY = 20
local lastNoteKind
local function writeStatus(msg)
local kind = tostring(msg):match("^SENT OK") and "ok" or (tostring(msg):match("^FAILED") and "fail" or nil)
if kind and kind ~= lastNoteKind then
lastNoteKind = kind
if kind == "ok" then umbraNote("Tracker connected: this account is reporting (" .. tostring(game.PlaceId) .. ")") else umbraNote("Tracker report FAILED: " .. tostring(msg):sub(1, 90)) end
end
if not hasFS then return end
pcall(writefile, "ReportStatus_" .. player.Name .. ".txt", ("[%s] PlaceId %s | %s"):format(os.date("!%Y-%m-%d %H:%M:%S UTC", os.time()), tostring(game.PlaceId), tostring(msg)))
end
if SUPABASE_URL == "" or SUPABASE_KEY == "" or not httpRequest then
umbraNote(SUPABASE_KEY == "" and "Not tracked: key missing. Put UmbraKey.txt in the workspace folder." or "Not tracked: no http request function")
pcall(function() if hasFS then writefile("ReportStatus_" .. player.Name .. ".txt", SUPABASE_KEY == "" and "reporter off: UmbraKey.txt is missing or empty in the workspace folder" or "reporter off: this executor has no http request function (httpRequest)") end end)
return
end
SUPABASE_URL = SUPABASE_URL:gsub("/+$", "")
local function iso(t)
return os.date("!%Y-%m-%dT%H:%M:%SZ", t or os.time())
end
local avatar = nil
local function fetchAvatar()
local ok, res = pcall(httpRequest, {
Url = ("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png&isCircular=false"):format(player.UserId),
Method = "GET",
})
if ok and res and res.Body then
local ok2, d = pcall(HttpService.JSONDecode, HttpService, res.Body)
if ok2 and type(d) == "table" and d.data and d.data[1] and d.data[1].imageUrl then
avatar = d.data[1].imageUrl
end
end
end
local gameIcon = nil
local function fetchGameIcon()
local ok, res = pcall(httpRequest, {
Url = ("https://thumbnails.roblox.com/v1/places/gameicons?placeIds=%d&returnPolicy=PlaceHolder&size=150x150&format=Png&isCircular=false"):format(game.PlaceId),
Method = "GET",
})
if ok and res and res.Body then
local ok2, d = pcall(HttpService.JSONDecode, HttpService, res.Body)
if ok2 and type(d) == "table" and d.data and d.data[1] and type(d.data[1].imageUrl) == "string" and d.data[1].imageUrl ~= "" then
gameIcon = d.data[1].imageUrl
end
end
end
local isPilot = false
for _, n in ipairs(RIDE_A_PET_PILOTS) do
if string.lower(n) == string.lower(player.Name) then isPilot = true end
end
for _, n in ipairs(BREAK_AND_STEAL_PILOTS) do
if string.lower(n) == string.lower(player.Name) then isPilot = true end
end
local DETAILS_EVERY = 60
local lastDetails = 0
local gameName = nil
local OTHER_GAME = (game.PlaceId == RIDE_A_PET_PLACE_ID)
local FIXED_NAME = (game.PlaceId == RIDE_A_PET_PLACE_ID and "Ride a Pet") or (game.PlaceId == BREAK_AND_STEAL_PLACE_ID and "Break and Steal an Egg") or nil
local SKIP = { Backpack = true, PlayerGui = true, PlayerScripts = true, StarterGear = true, leaderstats = true }
local function prim(v)
local t = typeof(v)
if t == "number" or t == "string" or t == "boolean" then return v end
return nil
end
local ICON_FILE = "ItemIcons2.json"
local icons, lastIconTry = {}, 0
local lastDeliv, delivTried = 0, {}
local function loadIcons()
if hasFS and isfile(ICON_FILE) then
local ok, d = pcall(function() return HttpService:JSONDecode(readfile(ICON_FILE)) end)
if ok and type(d) == "table" then for k, v in pairs(d) do icons[k] = v end end
end
end
local LISTS = { "pets", "eggs", "items", "equipped" }
local function resolveIcons(inv)
loadIcons()
local need, seen = {}, {}
for _, ln in ipairs(LISTS) do
for _, it in ipairs(inv[ln] or {}) do
if it.ic and not icons[it.ic] and not seen[it.ic] and #need < 50 then
seen[it.ic] = true
need[#need + 1] = it.ic
end
end
end
if #need > 0 and os.time() - lastIconTry >= 60 then
lastIconTry = os.time()
local ask = {}
for _, id in ipairs(need) do
ask[#ask + 1] = id
ask[#ask + 1] = string.format("%d", (tonumber(id) or 0) + 1)
end
local ok, res = pcall(httpRequest, {
Url = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. table.concat(ask, ",") .. "&returnPolicy=AutoGenerated&size=150x150&format=Png",
Method = "GET",
})
if ok and res and res.StatusCode == 200 and res.Body then
local ok2, d = pcall(HttpService.JSONDecode, HttpService, res.Body)
if ok2 and type(d) == "table" and type(d.data) == "table" then
local got = {}
for _, e in ipairs(d.data) do
if e.state == "Completed" and e.imageUrl then got[tostring(e.targetId)] = e.imageUrl end
end
for _, id in ipairs(need) do
local u = got[id] or got[string.format("%d", (tonumber(id) or 0) + 1)]
if u then icons[id] = u end
end
if hasFS then pcall(writefile, ICON_FILE, HttpService:JSONEncode(icons)) end
end
end
end
if os.time() - lastDeliv >= 30 then
local tries = 0
for _, ln in ipairs(LISTS) do
for _, it in ipairs(inv[ln] or {}) do
local id = it.ic
if id and not icons[id] and not delivTried[id] and tries < 12 then
delivTried[id] = true
tries += 1
local okd, rd = pcall(httpRequest, { Url = "https://assetdelivery.roblox.com/v2/assetId/" .. id, Method = "GET" })
if okd and rd and rd.StatusCode == 200 and rd.Body then
local oj, dj = pcall(HttpService.JSONDecode, HttpService, rd.Body)
local loc = oj and type(dj) == "table" and type(dj.locations) == "table" and dj.locations[1] and dj.locations[1].location
if type(loc) == "string" and loc:find("^https://") then icons[id] = loc end
end
task.wait(0.15)
end
end
end
lastDeliv = os.time()
if tries > 0 and hasFS then pcall(writefile, ICON_FILE, HttpService:JSONEncode(icons)) end
end
local used = {}
for _, ln in ipairs(LISTS) do
for _, it in ipairs(inv[ln] or {}) do
if it.ic and icons[it.ic] then used[it.ic] = icons[it.ic] end
end
end
inv.icons = used
end
local function clean(t)
t = tostring(t or "")
t = t:gsub("<[^>]+>", "")
t = t:gsub("[\r\n]+", " ")
t = t:gsub("%s+", " ")
t = t:gsub("^ ", "")
t = t:gsub(" $", "")
return t
end
local function iconFor(obj)
local function look(root)
local bestId, bestA = nil, 0
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("ImageLabel") or d:IsA("ImageButton") then
local id = tostring(d.Image or ""):match("(%d%d%d%d%d+)")
local w, h = d.AbsoluteSize.X, d.AbsoluteSize.Y
if id and w >= 20 and h >= 20 and w <= 220 and h <= 220 and w * h > bestA then bestId, bestA = id, w * h end
end
end
if bestId then return bestId end
end
local p = obj.Parent
if not p then return nil end
local r = look(p)
if r then return r end
local pp = p.Parent
if pp and #pp:GetChildren() <= 4 then return look(pp) end
return nil
end
local function nameHint(d, pat)
local a = d
for _ = 1, 4 do
if not a then break end
if tostring(a.Name):lower():find(pat) then return true end
a = a.Parent
end
return false
end
local RARWORDS = { common = 1, uncommon = 1, rare = 1, epic = 1, legendary = 1, mythic = 1, mythical = 1, divine = 1, secret = 1, exclusive = 1, event = 1, godly = 1, celestial = 1, transcendent = 1, cosmic = 1, omega = 1, ultra = 1, supreme = 1, limited = 1 }
local function findInc(t)
local a, b, v = t:find("%(?%s*%$?%s*(%d[%d%.,]*%s?%a*)%s*/%s*[sS]%f[%A]%s*%)?")
if a then
local u = v:match("^[%d%.,]+%s?(%a*)$")
if u and #u <= 3 then return a, b, v end
end
local a2, b2, v2 = t:find("%(?%s*%$?%s*(%d[%d%.,]*%s?%a*)%s+[pP]er%s+[sS]ec%a*%s*%)?")
if a2 then return a2, b2, v2 end
end
local function fmtNum(n)
local U = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }
local i = 1
while n >= 1000 and i < #U do n /= 1000; i += 1 end
local s = (n >= 100 and "%.0f" or n >= 10 and "%.1f" or "%.2f"):format(n)
if s:find("%.") then s = s:gsub("0+$", ""):gsub("%.$", "") end
return s .. U[i]
end
local dbgAt, dbgText = 0, nil
local function badName(nm)
local l = nm:lower()
if nm == "" or #nm < 2 then return true end
if nm:match("^%(?[%d%.,]+%s?[Kk][Gg]%)?$") or nm:match("^[%$%d%.,%s/xX%%]+%a?%a?$") or nm:match("^%$") then return true end
if l:match("name$") or l:match("^pet$") or l:match("^egg$") or l:match("^item$") or l:match("^label$") or l:match("^text") or l:match("^title") then return true end
for _, w in ipairs({ "sell", "apply", "star", "equip", "lock", "favorite", "delete", "close", "confirm", "cancel", "inventory", "upgrade", "fuse", "evolve", "?" }) do
if l:find(w, 1, true) then return true end
end
return false
end
local tabDbgText, tabDbgAt = "", 0
local function scanTabs()
if os.time() - tabDbgAt < 300 then return end
tabDbgAt = os.time()
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then return end
local L, n = {}, 0
for _, d in ipairs(pg:GetDescendants()) do
n += 1
if n % 500 == 0 then task.wait() end
if #L < 60 and (d:IsA("TextButton") or d:IsA("ImageButton")) then
local txt = d:IsA("TextButton") and clean(d.Text) or ""
local nm = d.Name:lower()
local tl = txt:lower()
local hit = nm:find("egg") or nm:find("pet") or nm:find("item") or nm:find("inventory") or nm:find("backpack") or nm:find("tab") or nm:find("categor")
or tl:find("egg") or tl:find("pets") or tl:find("items") or tl:find("inventory")
if hit and not nm:match("^%d+$") and not nm:find("^pet_") then
local vis = true
local a = d
while a and a ~= pg do
if a:IsA("GuiObject") and not a.Visible then vis = false break end
if a:IsA("ScreenGui") and not a.Enabled then vis = false break end
a = a.Parent
end
local path = d:GetFullName():gsub("^.-PlayerGui%.", "")
local parts = path:split(".")
L[#L + 1] = ("%s | %s | vis=%s | %dx%d @%d,%d"):format(table.concat(parts, ".", math.max(1, #parts - 4)), txt, tostring(vis), d.AbsoluteSize.X, d.AbsoluteSize.Y, d.AbsolutePosition.X, d.AbsolutePosition.Y)
end
end
end
tabDbgText = "inventory buttons (names only):\n" .. table.concat(L, "\n") .. "\n----\n"
end
local function inTemplate(d)
local a = d
while a and a.Parent do
if a.Name:lower():find("template") then return true end
a = a.Parent
end
return false
end
local function scanGui()
local out = { pets = {}, eggs = {}, equipped = {}, counts = {} }
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then return out end
local petL, incL, moneyC, speedC, activeLbl = {}, {}, {}, {}, nil
local dbgLines = (os.time() - dbgAt > 300) and {} or nil
local n = 0
for _, d in ipairs(pg:GetDescendants()) do
n += 1
if n % 400 == 0 then task.wait() end
if d:IsA("TextLabel") or d:IsA("TextButton") then
local t = clean(d.Text)
if d.Name == "TextLabel_Value" and t ~= "" then
local a = d.Parent
local mine = "Player_" .. tostring(player.UserId)
while a and a ~= pg do
if a.Name == mine then out.mps = t break end
a = a.Parent
end
end
if dbgLines and t ~= "" and #t < 60 and #dbgLines < 70 then
local vis = true
local a = d
while a and a ~= pg do
if a:IsA("GuiObject") and not a.Visible then vis = false break end
a = a.Parent
end
if vis then
local path = d:GetFullName():gsub("^.-PlayerGui%.", "")
local parts = path:split(".")
local short = table.concat(parts, ".", math.max(1, #parts - 3))
dbgLines[#dbgLines + 1] = ("%s | %s | %d,%d"):format(short, t, d.AbsolutePosition.X, d.AbsolutePosition.Y)
end
end
if t ~= "" and #t < 120 then
local ec, ecm = t:match("^[Ee]ggs:?%s*(%d+)%s*/%s*(%d+)$")
if ec then out.counts.Eggs = ec .. "/" .. ecm end
if #t < 80 and t:lower():find("egg") and not t:find("%$") and not t:match("^(.-[Ee]gg)%s*%(([%d%.,]+%s?[Kk][Gg])%)$") then
out.eggOther = out.eggOther or {}
if #out.eggOther < 14 then
local pth = d:GetFullName():gsub("^.-PlayerGui%.", "")
local pp = pth:split(".")
out.eggOther[#out.eggOther + 1] = ("%s | %s"):format(table.concat(pp, ".", math.max(1, #pp - 3)), t)
end
end
local ia, ib, iv = findInc(t)
if ia then
local nm = (t:sub(1, ia - 1) .. " " .. t:sub(ib + 1)):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
if nm ~= "" and not nm:match("^[%$%d%.,%s/]+$") then
if not badName(nm) and not inTemplate(d) then petL[#petL + 1] = { l = d, name = nm, inc = iv } end
else
incL[#incL + 1] = { l = d, inc = iv }
end
else
local en, kg = t:match("^(.-[Ee]gg)%s*%(([%d%.,]+%s?[Kk][Gg])%)$")
if en and #out.eggs < 300 and not inTemplate(d) then
local ev, einc, erar
local card = d.Parent
for lvl = 1, 2 do
if not card or card == pg then break end
local tc = 0
for _, x in ipairs(card:GetDescendants()) do
if x:IsA("TextLabel") or x:IsA("TextButton") then tc += 1 end
end
if lvl == 2 and tc > 6 then break end
for _, x in ipairs(card:GetDescendants()) do
if x ~= d and (x:IsA("TextLabel") or x:IsA("TextButton")) then
local xt = clean(x.Text)
if not erar and RARWORDS[xt:lower()] then erar = xt end
if not einc then
local fa, fb, fv = findInc(xt)
if fa then einc = fv end
end
if not ev then
ev = xt:match("^%$%s?([%d%.,]+%s?%a*)$") or xt:match("^[Vv]alue:?%s*%$?([%d%.,]+%s?%a*)$") or xt:match("^[Ss]ell:?%s*%$?([%d%.,]+%s?%a*)$")
end
end
end
if ev or einc then break end
card = card.Parent
end
out.eggs[#out.eggs + 1] = { name = en, kg = kg, ic = iconFor(d), val = ev, inc = einc, rar = erar }
do
local function hx(c) return string.format("#%02x%02x%02x", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5)) end
local ent = out.eggs[#out.eggs]
local parts = {}
pcall(function()
ent.col = hx(d.TextColor3)
parts[#parts + 1] = "text=" .. ent.col
local st = d:FindFirstChildOfClass("UIStroke")
if st then parts[#parts + 1] = "stroke=" .. hx(st.Color) end
local gr = d:FindFirstChildOfClass("UIGradient")
if gr then
parts[#parts + 1] = "nameGrad=" .. hx(gr.Color.Keypoints[1].Value)
parts[#parts + 1] = "nameGradEnd=" .. hx(gr.Color.Keypoints[#gr.Color.Keypoints].Value)
end
local cardC = d.Parent
if cardC then
local function al(s2) return (tostring(s2):gsub("[^%a]", "")) end
local seen, nb = {}, 0
for _, x in ipairs(cardC:GetDescendants()) do
if nb < 24 then
local k2, h
if x:IsA("UIGradient") then
k2 = "g" .. al(x.Name) .. "In" .. al(x.Parent and x.Parent.Name or ""); h = hx(x.Color.Keypoints[1].Value)
elseif x:IsA("UIStroke") then
k2 = "sIn" .. al(x.Parent and x.Parent.Name or ""); h = hx(x.Color)
elseif (x:IsA("Frame") or x:IsA("ImageLabel")) and x.BackgroundTransparency < 0.95 then
k2 = "b" .. al(x.Name); h = hx(x.BackgroundColor3)
elseif x:IsA("ImageLabel") and x.ImageTransparency < 0.95 then
k2 = "i" .. al(x.Name); h = hx(x.ImageColor3)
end
if k2 and not seen[k2 .. h] then seen[k2 .. h] = true; nb += 1; parts[#parts + 1] = k2 .. "=" .. h end
end
end
end
end)
ent.cols = table.concat(parts, " ")
ent.cl = {}
for _, ptx in ipairs(parts) do
local kk, hh = ptx:match("^(%a+)=(#%x%x%x%x%x%x)$")
if kk then ent.cl[#ent.cl + 1] = kk .. ":" .. hh end
end
do
ent.imgs = {}
local seenI, lst = {}, {}
pcall(function()
for _, x in ipairs(d.Parent:GetDescendants()) do
if x:IsA("ImageLabel") or x:IsA("ImageButton") then
local im = tostring(x.Image)
local id = im:match("(%d%d%d%d%d+)")
if #lst < 14 then lst[#lst + 1] = x.Name .. "=" .. (id or (im == "" and "-" or im:sub(1, 18))) end
if id and id ~= "115988933043114" and not seenI[id] and #ent.imgs < 10 then seenI[id] = true; ent.imgs[#ent.imgs + 1] = id end
if id and id ~= "115988933043114" and not ent.art then
local ln = x.Name:lower()
if (ln:find("egg") or ln:find("icon") or ln:find("image") or ln:find("art") or ln:find("thumb") or ln:find("picture")) and not (ln:find("rar") or ln:find("star") or ln:find("back") or ln:find("bg") or ln:find("glow") or ln:find("frame") or ln:find("lock") or ln:find("coin") or ln:find("cash") or ln:find("money")) then ent.art = id end
end
elseif x:IsA("ViewportFrame") then
lst[#lst + 1] = x.Name .. "=viewport"
end
end
end)
if #out.eggs <= 4 then out.eggDbg = (out.eggDbg or "") .. ("egg images %s %s: %s\n"):format(en, tostring(kg), table.concat(lst, " | ")) end
end
do
local ng
for _, cc in ipairs(ent.cl) do local v = cc:match("^nameGrad:(#%x+)$") if v then ng = v end end
if ng and not ent.rar then
local R, G, B = tonumber(ng:sub(2, 3), 16), tonumber(ng:sub(4, 5), 16), tonumber(ng:sub(6, 7), 16)
local function near(r2, g2, b2) return math.abs(R - r2) + math.abs(G - g2) + math.abs(B - b2) < 40 end
if near(0x80, 0x00, 0x9a) then ent.rar = "Cosmic"
elseif near(0x10, 0x49, 0x7c) then ent.rar = "Eternal"
elseif near(255, 255, 255) then ent.rar = "Secret"
elseif R > 200 and G > 180 and B < 120 then ent.rar = "Divine" end
end
end
local nodes, ap, seenN = {}, {}, {}
local x = d
for _ = 1, 4 do
if x and x ~= pg then nodes[#nodes + 1] = x; x = x.Parent end
end
for _, nd in ipairs(nodes) do
for k, v in pairs(nd:GetAttributes()) do
if type(v) ~= "userdata" then
ap[#ap + 1] = nd.Name .. "." .. k .. "=" .. tostring(v):sub(1, 24)
local lk = k:lower()
if lk:find("rarity") and type(v) == "string" and v ~= "" and not ent.rar then ent.rar = v end
end
end
if nd.Name:lower():find("rarity") and not ent.rar then
for w in nd.Name:gmatch("%a+") do if RARWORDS[w:lower()] then ent.rar = w end end
end
end
local cardN = nodes[2] or nodes[#nodes]
local names = {}
if cardN then
for _, c in ipairs(cardN:GetDescendants()) do
if #names < 30 then
local nmx = c.Name
if c:IsA("StringValue") or c:IsA("IntValue") or c:IsA("NumberValue") then nmx = nmx .. "=" .. tostring(c.Value) end
names[#names + 1] = nmx
if c:IsA("StringValue") and c.Name:lower():find("rarity") and not ent.rar then ent.rar = c.Value end
end
end
end
out.eggDbg = (out.eggDbg or "") .. ("egg card %s attrs: %s | names: %s | chain: %s\n"):format(en, table.concat(ap, "; "):sub(1, 400), table.concat(names, ","):sub(1, 400), (function() local t = {} for _, nd in ipairs(nodes) do t[#t + 1] = nd.Name end return table.concat(t, ">") end)())
out.eggDbg = (out.eggDbg or "") .. ("egg colours %s %s inc=%s: %s\n"):format(en, tostring(kg), tostring(einc), ent.cols)
end
if #out.eggs <= 3 then
local cardX = d.Parent and d.Parent.Parent or d.Parent
if cardX then
local cls, imgs = {}, {}
for _, x in ipairs(cardX:GetDescendants()) do
cls[x.ClassName] = (cls[x.ClassName] or 0) + 1
if (x:IsA("ImageLabel") or x:IsA("ImageButton")) and #imgs < 4 then
imgs[#imgs + 1] = ("%s img=%s size=%dx%d"):format(x.Name, tostring(x.Image):sub(1, 40), x.AbsoluteSize.X, x.AbsoluteSize.Y)
end
end
local cs = {}
for k, v in pairs(cls) do cs[#cs + 1] = k .. "=" .. v end
table.sort(cs)
out.eggDbg = (out.eggDbg or "") .. ("egg card %s: %s\n  %s\n"):format(en, table.concat(cs, ","), table.concat(imgs, " | "))
end
end
else
local a, b = t:match("^(%d+)%s*/%s*(%d+)%s+[Aa]ctive")
if a then
activeLbl = d
out.counts.Active = a .. "/" .. b
else
local cn, ca, cb = t:match("^(%a[%a ]*):%s*(%d+)%s*/%s*(%d+)$")
local ln = d.Name:lower()
if cn then
out.counts[cn] = ca .. "/" .. cb
elseif t:match("^%$%s?[%d%.,]+%s?%a*$") then
moneyC[#moneyC + 1] = { t = t, d = d }
elseif t:match("^[%d%.,]+%s?%a*$") and (ln:find("money") or ln:find("cash") or ln:find("coin")) then
moneyC[#moneyC + 1] = { t = "$" .. t, d = d, named = true }
elseif t:match("^[%d%.,]+%s?%a*$") and nameHint(d, "speed") then
speedC[#speedC + 1] = { t = t, d = d }
else
local sv = t:match("^[Ss]peed:?%s*([%d%.,]+%a*)$") or t:match("^([%d%.,]+%a*)%s*[Ss]peed$")
if sv then speedC[#speedC + 1] = { t = sv, d = d } end
end
end
end
end
end
end
end
if dbgLines then
dbgAt = os.time()
dbgText = table.concat(dbgLines, "\n")
if #dbgText > 9000 then dbgText = dbgText:sub(1, 9000) end
end
for _, il in ipairs(incL) do
local card = il.l.Parent
do
local up = card and card.Parent
if up and up ~= pg then
local tc = 0
for _, d in ipairs(up:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") then tc += 1 end
end
if tc <= 5 then card = up end
end
end
local name, rar
if card then
for _, d in ipairs(card:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d ~= il.l then
local t = clean(d.Text)
if t ~= "" and #t < 40 then
if RARWORDS[t:lower()] then rar = rar or t
else
local lt = t:lower()
local junk = t:match("^%$") or t:match("^[%d%.,%s/xX%%]+%a?%a?$") or t:find("%?") or findInc(t)
for _, w in ipairs({ "sell", "apply", "star", "equip", "lock", "favorite", "delete", "close", "confirm", "cancel", "inventory", "pets", "eggs", "items", "active", "level", "upgrade", "fuse", "evolve", "mutation", "weight" }) do
if lt:find(w, 1, true) then junk = true break end
end
if not junk and not name and not badName(t) then name = t end
end
end
end
end
end
if name then petL[#petL + 1] = { l = il.l, name = name, inc = il.inc, rar = rar } end
end
local SUF = { K = 1, M = 2, B = 3, T = 4, Qa = 5, Qi = 6, Sx = 7, Sp = 8, Oc = 9, No = 10, Dc = 11 }
local function val(t)
local num, u = t:gsub("[%$,%s]", ""):match("^([%d%.]+)(%a*)$")
local v = tonumber(num)
if not v then return 0 end
return v * 1000 ^ (SUF[u] or 0)
end
local function shown(d)
local a = d
while a and a ~= pg do
if a:IsA("GuiObject") and not a.Visible then return false end
if a:IsA("ScreenGui") and not a.Enabled then return false end
a = a.Parent
end
return true
end
local function inButton(d)
local a = d.Parent
while a and a ~= pg do
if a:IsA("GuiButton") then return true end
local ln = a.Name:lower()
if ln:find("shop") or ln:find("store") or ln:find("price") or ln:find("cost") or ln:find("buy") or ln:find("robux") then return true end
a = a.Parent
end
return false
end
local function hasIcon(d)
local p = d.Parent
if not p then return false end
for _, c in ipairs(p:GetChildren()) do
if c:IsA("ImageLabel") or c:IsA("ImageButton") then return true end
end
return false
end
local best
for _, c in ipairs(moneyC) do
c.v = val(c.t)
c.ok = shown(c.d) and not inButton(c.d)
c.score = (c.ok and 4 or 0) + (hasIcon(c.d) and 2 or 0) + ((c.named or nameHint(c.d, "money") or nameHint(c.d, "cash")) and 1 or 0)
if not best or c.score > best.score or (c.score == best.score and c.v > best.v) then best = c end
end
if best then out.money = best.t end
local sp
if best then
local my, mx, mh = best.d.AbsolutePosition.Y, best.d.AbsolutePosition.X, math.max(best.d.AbsoluteSize.Y, 10)
local bd = 1e9
for _, d in ipairs(pg:GetDescendants()) do
if d:IsA("TextLabel") and d ~= best.d and shown(d) and not inButton(d) then
local t = clean(d.Text)
if t:match("^%d[%d%.,]*%s?%a?%a?$") and not t:match("[xX]$") then
local dy = my - d.AbsolutePosition.Y
local dx = math.abs(mx - d.AbsolutePosition.X)
if dy > -mh * 0.5 and dy < mh * 2.5 and dx < mh * 6 and (dy ~= 0 or dx > 0) then
local dist = math.abs(dy) + dx * 0.3
if dist < bd then bd = dist; sp = t end
end
end
end
end
end
if not sp then
for _, c in ipairs(speedC) do
if shown(c.d) and not c.t:match("[xX]$") then sp = c.t break end
end
end
if sp then out.speed = sp end
if out.eggOther then out.eggDbg = (out.eggDbg or "") .. "other egg-like labels (not read as eggs):\n" .. table.concat(out.eggOther, "\n") .. "\n" end
local panel
if activeLbl then
local a = activeLbl.Parent
for _ = 1, 4 do
if not a then break end
for _, pl in ipairs(petL) do
if pl.l:IsDescendantOf(a) then panel = a break end
end
if panel then break end
a = a.Parent
end
end
for _, pl in ipairs(petL) do
local e = { name = pl.name, inc = pl.inc, rar = pl.rar, ic = iconFor(pl.l) }
if panel and pl.l:IsDescendantOf(panel) then
if #out.equipped < 100 then out.equipped[#out.equipped + 1] = e end
elseif #out.pets < 300 then
out.pets[#out.pets + 1] = e
end
end
return out
end
local rarIndex
local function buildRarity()
if rarIndex then return rarIndex end
rarIndex = {}
local rs = game:GetService("ReplicatedStorage")
local n = 0
for _, d in ipairs(rs:GetDescendants()) do
n += 1
if n % 500 == 0 then task.wait() end
if n > 30000 then break end
local r = d:GetAttribute("Rarity")
if r == nil then
local rv = d:FindFirstChild("Rarity")
if rv and rv:IsA("ValueBase") then r = rv.Value end
end
if type(r) == "string" or type(r) == "number" then
local nm = d:GetAttribute("DisplayName")
if type(nm) ~= "string" then nm = d.Name end
rarIndex[nm:lower()] = tostring(r)
end
end
return rarIndex
end
local function tagRarity(list, idx)
for _, e in ipairs(list) do
local r = idx[tostring(e.name):lower()]
if r then e.rar = r end
end
end
local dumped = false
local function dumpGui()
if dumped or not hasFS then return end
dumped = true
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then return end
local lines, n = {}, 0
for _, d in ipairs(pg:GetDescendants()) do
n += 1
if n % 400 == 0 then task.wait() end
if (d:IsA("TextLabel") or d:IsA("TextButton")) and #lines < 700 then
local t = clean(d.Text)
if t ~= "" and #t < 120 then
lines[#lines + 1] = ("%s | %s | vis=%s | pos=%d,%d size=%d,%d"):format((d:GetFullName():gsub("^.-PlayerGui%.", "")), t, tostring(d.Visible), d.AbsolutePosition.X, d.AbsolutePosition.Y, d.AbsoluteSize.X, d.AbsoluteSize.Y)
end
end
end
pcall(writefile, "GuiDump_" .. player.Name .. ".txt", table.concat(lines, "\n"))
local rl = {}
for _, c in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do
rl[#rl + 1] = "RS: " .. c.Name .. " (" .. c.ClassName .. ", " .. #c:GetDescendants() .. " inside)"
end
local cnt = 0
for k, v in pairs(buildRarity()) do
cnt += 1
if cnt <= 40 then rl[#rl + 1] = "rarity: " .. k .. " = " .. v end
end
rl[#rl + 1] = "rarity entries found: " .. cnt
local ic2 = 0
for k, v in pairs(buildIconIdx()) do
ic2 += 1
if ic2 <= 25 then rl[#rl + 1] = "icon: " .. k .. " = " .. v end
end
rl[#rl + 1] = "icon entries found: " .. ic2
local nm = 0
for _, d in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
local ln = d.Name:lower()
if (ln:find("pet") or ln:find("egg") or ln:find("rarit") or ln:find("income") or ln:find("money")) and nm < 150 then
nm += 1
rl[#rl + 1] = "path: " .. d:GetFullName():gsub("^ReplicatedStorage%.", "") .. " (" .. d.ClassName .. ")"
end
end
local bp = player:FindFirstChildOfClass("Backpack")
if bp then
local k = 0
for _, t in ipairs(bp:GetChildren()) do
if t:IsA("Tool") and k < 6 then
k += 1
local parts = {}
for an, av in pairs(t:GetAttributes()) do parts[#parts + 1] = an .. "=" .. tostring(av) end
for _, c in ipairs(t:GetDescendants()) do
if c:IsA("ValueBase") then parts[#parts + 1] = "child:" .. c.Name .. "=" .. tostring(c.Value) end
end
rl[#rl + 1] = "tool: " .. t.Name .. " | " .. table.concat(parts, "; ")
end
end
end
pcall(writefile, "GameDump_" .. player.Name .. ".txt", table.concat(rl, "\n"))
end
local iconIdx
local function buildIconIdx()
if iconIdx then return iconIdx end
iconIdx = {}
local n = 0
local KEYS = { "Icon", "Image", "Thumbnail", "ImageId", "IconId", "Texture", "Decal" }
for _, d in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
n += 1
if n % 500 == 0 then task.wait() end
if n > 30000 then break end
local id
for _, k in ipairs(KEYS) do
local v = d:GetAttribute(k)
if type(v) == "string" or type(v) == "number" then
id = tostring(v):match("(%d%d%d%d%d+)")
if id then break end
end
end
if not id and (d:IsA("StringValue") or d:IsA("ImageLabel") or d:IsA("Decal") or d:IsA("Texture")) then
local ln = d.Name:lower()
if ln == "icon" or ln == "image" or ln == "thumbnail" or d:IsA("ImageLabel") or d:IsA("Decal") then
local raw = d:IsA("StringValue") and d.Value or (d:IsA("ImageLabel") and d.Image) or d.Texture
id = tostring(raw or ""):match("(%d%d%d%d%d+)")
if id then d = d.Parent end
end
end
if id and d then
local nm = d:GetAttribute("DisplayName")
if type(nm) ~= "string" then nm = d.Name end
if not iconIdx[nm:lower()] then iconIdx[nm:lower()] = id end
end
end
return iconIdx
end
local function fillIcons(lists)
local byName = {}
for _, l in ipairs(lists) do
for _, e in ipairs(l) do
if e.ic then byName[tostring(e.name):lower()] = e.ic end
end
end
local idx = {}
local ok, r = pcall(buildIconIdx)
if ok and type(r) == "table" then idx = r end
for _, l in ipairs(lists) do
for _, e in ipairs(l) do
if not e.ic then
local k = tostring(e.name):lower()
e.ic = byName[k] or idx[k] or idx[k:gsub(" egg$", "")] or nil
end
end
end
end
local modIdx, modDbg, modBuilt = {}, "", false
local modPal = {}
local function buildModIdx()
if modBuilt then return end
modBuilt = true
local mods = {}
for _, d in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
if d:IsA("ModuleScript") and #mods < 140 and not d.Name:find("Controller$") and not d.Name:find("Handler$") then
local ln = d.Name:lower()
if ln:find("pet") or ln:find("egg") or ln:find("rarit") or ln:find("config") or ln:find("data") or ln:find("stat") or ln:find("info") or ln:find("animal") or ln:find("creature") or ln:find("asset") or ln:find("mutation") or ln:find("catalog") or ln:find("registry") or ln:find("definition") or ln:find("economy") or ln:find("balance") or ln:find("income") or ln:find("color") or ln:find("theme") or ln:find("style") or ln:find("palette") or ln:find("ui") then
mods[#mods + 1] = d
end
end
end
local res, done = {}, 0
for i, m in ipairs(mods) do
task.spawn(function()
local ok, r = pcall(require, m)
if ok and type(r) == "table" then res[i] = r end
done += 1
end)
end
local t0 = os.clock()
while done < #mods and os.clock() - t0 < 4 do task.wait(0.1) end
local dbg, samples, nodes = {}, 0, 0
local function prim2(v)
local tv = type(v)
if tv == "number" or tv == "string" or tv == "boolean" then return tostring(v) end
end
local function examine(k, v, mname)
local name
for _, f in ipairs({ "DisplayName", "Name", "name", "displayName" }) do
if type(v[f]) == "string" then name = v[f] break end
end
if not name and type(k) == "string" then name = k end
if not name then return end
local rar, inc, val, mic
for fk, fv in pairs(v) do
if type(fk) == "string" then
local lk = fk:lower()
if not mic and (lk == "icon" or lk == "image" or lk == "thumbnail" or lk == "imageid" or lk == "iconid" or lk == "textureid" or lk == "texture") and (type(fv) == "string" or type(fv) == "number") then
mic = tostring(fv):match("(%d%d%d%d%d+)")
end
if lk == "rarity" or lk == "tier" or lk == "rank" then
if type(fv) == "string" then rar = fv end
elseif type(fv) == "number" then
if not inc and (lk:find("income") or lk:find("persec") or lk:find("mps") or lk:find("earn") or lk:find("moneypers") or lk == "rate" or lk == "cash" or lk == "money") then inc = fv
elseif not val and (lk == "value" or lk == "price" or lk == "sellprice" or lk == "sellvalue" or lk == "worth") then val = fv end
end
end
end
do
local pc = 0
for fk, fv in pairs(v) do
if type(fk) == "string" and RARWORDS[fk:lower()] and typeof(fv) == "Color3" then
modPal[fk:sub(1, 1):upper() .. fk:sub(2):lower()] = string.format("#%02x%02x%02x", math.floor(fv.R * 255 + 0.5), math.floor(fv.G * 255 + 0.5), math.floor(fv.B * 255 + 0.5))
pc += 1
end
end
local cc = v.Color or v.color or v.RarityColor or v.TextColor
if typeof(cc) == "Color3" and RARWORDS[name:lower()] then
modPal[name:sub(1, 1):upper() .. name:sub(2):lower()] = string.format("#%02x%02x%02x", math.floor(cc.R * 255 + 0.5), math.floor(cc.G * 255 + 0.5), math.floor(cc.B * 255 + 0.5))
end
end
if rar or inc or val or mic then
modIdx[name:lower()] = { rar = rar, inc = inc, val = val, ic = mic, dn = name }
if samples < 8 then
samples += 1
local parts = {}
for fk, fv in pairs(v) do
local pv = prim2(fv)
if pv and #parts < 14 then parts[#parts + 1] = tostring(fk) .. "=" .. pv:sub(1, 24) end
end
dbg[#dbg + 1] = ("[%s] %s: %s"):format(mname, name, table.concat(parts, ", "))
end
end
end
local function walk(t, depth, seen, mname)
for k, v in pairs(t) do
nodes += 1
if nodes % 300 == 0 then task.wait() end
if nodes > 40000 then return end
if type(v) == "table" and not seen[v] then
seen[v] = true
examine(k, v, mname)
if depth < 5 then walk(v, depth + 1, seen, mname) end
end
end
end
local names = {}
for i, m in ipairs(mods) do
if res[i] then
names[#names + 1] = m.Name
local before = nodes
pcall(walk, res[i], 1, { [res[i]] = true }, m.Name)
end
end
local cnt = 0
for _ in pairs(modIdx) do cnt += 1 end
do
local pl = {}
for k, v in pairs(modPal) do pl[#pl + 1] = k .. "=" .. v end
table.sort(pl)
dbg[#dbg + 1] = "rarity colours found in game data: " .. ((#pl > 0) and table.concat(pl, ", ") or "none")
end
modDbg = ("config: %d modules read, %d named entries with rarity/income\nmodules: %s\n%s"):format(#names, cnt, table.concat(names, ","), table.concat(dbg, "\n"))
if #modDbg > 3500 then modDbg = modDbg:sub(1, 3500) end
end
local function applyMods(list)
for _, e in ipairs(list) do
local m = modIdx[tostring(e.name):lower()]
if m then
if not e.rar and m.rar then e.rar = m.rar end
if not e.inc and m.inc then e.inc = fmtNum(m.inc) end
if not e.val and m.val then e.val = fmtNum(m.val) end
if not e.ic and m.ic then e.ic = m.ic end
end
end
end
local deepDbg, deepBuilt = "", false
local function buildDeep()
if deepBuilt then return end
deepBuilt = true
local L = {}
local function add(x) if #L < 160 then L[#L + 1] = x end end
local function shortPath(d)
local parts = d:GetFullName():split(".")
return table.concat(parts, ".", math.max(1, #parts - 4))
end
for _, c in ipairs(player:GetChildren()) do
local extra = ""
if c:IsA("Folder") or c:IsA("Configuration") then extra = " (" .. #c:GetChildren() .. " inside)" end
add("player." .. c.Name .. " [" .. c.ClassName .. "]" .. extra)
end
for k, v in pairs(player:GetAttributes()) do add("player attr " .. k .. "=" .. tostring(v):sub(1, 40)) end
local uids = {}
local bp = player:FindFirstChildOfClass("Backpack")
if bp then
for _, t in ipairs(bp:GetChildren()) do
local u = t:GetAttribute("UID")
if type(u) == "string" and t:GetAttribute("ItemType") == "Asset" then uids[u] = true end
end
end
local attrNames, found, n = {}, 0, 0
local roots = { workspace, game:GetService("ReplicatedStorage") }
for _, root in ipairs(roots) do
for _, d in ipairs(root:GetDescendants()) do
n += 1
if n % 400 == 0 then task.wait() end
if n > 90000 then break end
local at = d:GetAttributes()
if next(at) then
local u = at.UID
if type(u) == "string" and uids[u] and not d:IsA("Tool") and found < 4 then
found += 1
local parts = {}
for k, v in pairs(at) do parts[#parts + 1] = k .. "=" .. tostring(v):sub(1, 30) end
add("UID-match " .. shortPath(d) .. " [" .. d.ClassName .. "]: " .. table.concat(parts, "; "))
end
for k, v in pairs(at) do
local lk = k:lower()
if (lk:find("income") or lk:find("rarity") or lk:find("persec") or lk:find("mps") or lk:find("earn") or lk:find("moneyper")) and not attrNames[k] then
attrNames[k] = true
add("attr " .. k .. "=" .. tostring(v):sub(1, 30) .. " on " .. shortPath(d))
end
end
end
end
end
add("world scan: " .. n .. " instances, UID matches " .. found)
local cnt = 0
for _, d in ipairs(workspace:GetDescendants()) do
if (d:IsA("TextLabel")) and cnt < 40 then
local t = clean(d.Text)
if t ~= "" and #t < 60 and (findInc(t) or RARWORDS[t:lower()] or t:find("%$")) then
cnt += 1
add("world text: " .. t .. " | " .. shortPath(d))
end
end
end
local pg = player:FindFirstChildOfClass("PlayerGui")
cnt = 0
if pg then
for _, d in ipairs(pg:GetDescendants()) do
if d:IsA("TextLabel") and cnt < 50 then
local t = clean(d.Text)
if t ~= "" and #t < 60 and (findInc(t) or RARWORDS[t:lower()] or t:lower():find("rarity")) then
cnt += 1
add("gui text: " .. t .. " | " .. shortPath(d) .. " | vis=" .. tostring(d.Visible))
end
end
end
end
local rs = game:GetService("ReplicatedStorage")
local names = {}
for _, c in ipairs(rs:GetChildren()) do
names[#names + 1] = c.Name .. "[" .. c.ClassName:sub(1, 3) .. ":" .. #c:GetChildren() .. "]"
if #c:GetChildren() > 0 and #c:GetChildren() <= 40 then
local sub = {}
for _, c2 in ipairs(c:GetChildren()) do sub[#sub + 1] = c2.Name end
add("RS." .. c.Name .. ": " .. table.concat(sub, ","))
end
end
add("RS top: " .. table.concat(names, ","))
deepDbg = table.concat(L, "\n")
if #deepDbg > 9000 then deepDbg = deepDbg:sub(1, 9000) end
end
local eggMap, eggMapAt, eggDbg = {}, 0, ""
local function kgNum(s)
local n = tostring(s or ""):gsub(",", ""):match("^([%d%.]+)")
return tonumber(n)
end
local eggIdDbg = ""
local hotbarDbg = ""
local function scanHotbar(inv)
hotbarDbg = ""
local pg2 = player:FindFirstChildOfClass("PlayerGui")
if not pg2 or not inv then return end
inv.items = inv.items or {}
local rev, revE = {}, {}
for nm, m in pairs(modIdx) do
if m.ic and nm:sub(-4) ~= " egg" then
rev[m.ic] = rev[m.ic] or {}
rev[m.ic][#rev[m.ic] + 1] = m.dn or nm
elseif m.ic then
revE[m.ic] = m.dn or nm
end
end
inv.eggs = inv.eggs or {}
local function addRev(id, nm)
if id and nm and nm ~= "" then
rev[id] = rev[id] or {}
rev[id][#rev[id] + 1] = nm
end
end
local nameBy = {}
for _, it in ipairs(inv.items or {}) do
local base = (tostring(it.name):gsub("%s*%[[xX]?%d+%]%s*$", ""))
nameBy[base:lower()] = base
if it.ic then addRev(tostring(it.ic), base) end
end
pcall(function()
local function fromTool(t)
if not t:IsA("Tool") then return end
local gn = t:GetAttribute("GearName")
local nm = (type(gn) == "string" and gn ~= "") and gn or (tostring(t.Name):gsub("%s*%[[xX]?%d+%]%s*$", ""))
nameBy[nm:lower()] = nm
addRev(tostring(t.TextureId):match("(%d%d%d%d%d+)"), nm)
for _, k in ipairs({ "Icon", "OldId", "Image", "Thumbnail", "ImageId", "IconId" }) do
local v = t:GetAttribute(k)
if v ~= nil then addRev(tostring(v):match("(%d%d%d%d%d+)"), nm) end
end
end
local bpk = player:FindFirstChildOfClass("Backpack")
if bpk then for _, t in ipairs(bpk:GetChildren()) do fromTool(t) end end
if player.Character then for _, t in ipairs(player.Character:GetChildren()) do fromTool(t) end end
end)
pcall(function()
for nm, id in pairs(buildIconIdx()) do
if not (#nm > 3 and nm:sub(-4) == " egg") then addRev(tostring(id), (nm:gsub("^%l", string.upper))) end
end
end)
local function hasImg(x)
for _, y in ipairs(x:GetDescendants()) do
if (y:IsA("ImageLabel") or y:IsA("ImageButton")) and tostring(y.Image):match("%d%d%d%d%d+") then return true end
end
return false
end
local groups, order, n = {}, {}, 0
for _, d in ipairs(pg2:GetDescendants()) do
n += 1
if n % 800 == 0 then task.wait() end
if d:IsA("TextLabel") then
local dg = tostring(d.Text):match("^%s*(%d)%s*$")
if dg and d.Parent then
local slot = d.Parent
for _ = 1, 2 do
if slot and slot.Parent and not hasImg(slot) then slot = slot.Parent end
end
if slot and slot.Parent and slot ~= pg2 and hasImg(slot) then
local gp = slot.Parent
if not groups[gp] then groups[gp] = {}; order[#order + 1] = gp end
groups[gp][#groups[gp] + 1] = { slot = slot, digit = dg, lbl = d }
end
end
end
end
local best
for _, gp in ipairs(order) do
if #groups[gp] >= 5 and (not best or #groups[gp] > #groups[best]) then best = gp end
end
if not best then hotbarDbg = "hotbar: no group of numbered slots found on screen"; return end
local lines, added = { "hotbar: " .. best:GetFullName():gsub("^.-PlayerGui%.", "") .. " (" .. #groups[best] .. " slots)" }, 0
local have = {}
for _, it in ipairs(inv.items or {}) do have[(tostring(it.name):gsub("%s*%[[xX]?%d+%]%s*$", "")):lower()] = it end
for _, g in ipairs(groups[best]) do
local ids, cnt, nameAttr = {}, nil, nil
pcall(function()
for _, y in ipairs(g.slot:GetDescendants()) do
if y:IsA("ImageLabel") or y:IsA("ImageButton") then
local id = tostring(y.Image):match("(%d%d%d%d%d+)")
if id and id ~= "115988933043114" then ids[#ids + 1] = id end
elseif (y:IsA("TextLabel") or y:IsA("TextButton")) and y ~= g.lbl then
local c = tostring(y.Text):match("^%s*[xX]%s*(%d+)%s*$")
if c then cnt = tonumber(c) end
end
end
for k, v in pairs(g.slot:GetAttributes()) do
if type(v) == "string" and v ~= "" and (k:lower():find("name") or k:lower():find("gear") or k:lower():find("item")) then nameAttr = v end
end
end)
local nm
for _, id in ipairs(ids) do
local l = rev[id]
if l and #l >= 1 then nm = l[1]; break end
end
local eggNm, kgTxt
for _, id in ipairs(ids) do
if revE[id] then eggNm = revE[id]; break end
end
pcall(function()
for _, y in ipairs(g.slot:GetDescendants()) do
if (y:IsA("TextLabel") or y:IsA("TextButton")) and y ~= g.lbl then
local k = tostring(y.Text):match("([%d%.,]+%s?[Kk][Gg])")
if k then kgTxt = k end
end
end
end)
local isEggSlot = eggNm ~= nil or kgTxt ~= nil or (nm and nm:lower():find("egg") ~= nil) or (nameAttr and nameAttr:lower():find("egg") ~= nil) or (tostring(g.slot.Name):lower():find("egg") ~= nil)
if isEggSlot then
local en = eggNm or nm or nameAttr or "Egg"
local dup = false
for _, e in ipairs(inv.eggs) do
if tostring(e.kg) == tostring(kgTxt) and (kgTxt ~= nil or tostring(e.name):lower() == en:lower()) then e.eq = true; e.slot = tonumber(g.digit); dup = true; break end
end
if not dup then
local pet = modIdx[en:lower():gsub(" egg$", "")]
inv.eggs[#inv.eggs + 1] = { name = en, kg = kgTxt, ic = ids[1], eq = true, slot = tonumber(g.digit), rar = pet and pet.rar or nil, resolved = eggNm ~= nil or nil }
added += 1
end
lines[#lines + 1] = ("slot %s: EGG %s %s | picture ids %s"):format(g.digit, en, tostring(kgTxt), (#ids > 0) and table.concat(ids, ",") or "none")
else
nm = nm or nameAttr
if not nm then
local sn = tostring(g.slot.Name):gsub("%s*%[[xX]?%d+%]%s*$", "")
if nameBy[sn:lower()] then nm = nameBy[sn:lower()] end
end
local attrTxt = {}
pcall(function()
for k, v in pairs(g.slot:GetAttributes()) do attrTxt[#attrTxt + 1] = k .. "=" .. tostring(v):sub(1, 20) end
for _, y in ipairs(g.slot:GetDescendants()) do
if (y:IsA("TextLabel") or y:IsA("TextButton")) and y ~= g.lbl and #attrTxt < 12 then attrTxt[#attrTxt + 1] = y.Name .. "=\"" .. tostring(y.Text):sub(1, 18) .. "\"" end
end
end)
if #ids > 0 or nm then
local base = nm or ("Hotbar item " .. g.digit)
local ex = have[base:lower()]
if ex then
ex.eq = true; ex.slot = tonumber(g.digit)
else
local it = { name = (cnt and cnt > 1) and (base .. " [x" .. cnt .. "]") or base, eq = true, slot = tonumber(g.digit), ic = ids[1] }
inv.items[#inv.items + 1] = it
added += 1
end
end
lines[#lines + 1] = ("slot %s: %s | picture ids %s | count %s | slot name %s | %s"):format(g.digit, nm or "NOT matched", (#ids > 0) and table.concat(ids, ",") or "none", tostring(cnt), g.slot.Name, table.concat(attrTxt, "; "))
end
end
hotbarDbg = table.concat(lines, "\n")
end
local function identifyEggs(eggs)
local byIc, amb, ne = {}, {}, 0
local anyIc = {}
for nm, m in pairs(modIdx) do
if m.ic then
anyIc[m.ic] = anyIc[m.ic] or {}
anyIc[m.ic][#anyIc[m.ic] + 1] = nm
if nm:sub(-4) == " egg" then
ne += 1
if byIc[m.ic] and byIc[m.ic] ~= nm then amb[m.ic] = true end
byIc[m.ic] = nm
end
end
end
local hit, lines = 0, {}
for _, e in ipairs(eggs) do
if e.imgs and not e.resolved then
for _, id in ipairs(e.imgs) do
local nm = byIc[id]
if nm and not amb[id] then
local m = modIdx[nm]
local pet = modIdx[nm:sub(1, -5)]
e.biome = e.biome or e.name
e.name = m.dn or e.name
if pet and pet.rar then e.rar = pet.rar end
e.resolved = true
if m.ic then e.ic = m.ic end
hit += 1
break
end
end
if not e.resolved then
for _, id in ipairs(e.imgs) do
local l = anyIc[id]
if l and #l == 1 and modIdx[l[1]].rar and not RARWORDS[l[1]] and #l[1] > 2 and l[1]:sub(-4) ~= " egg" then
local pm = modIdx[l[1]]
e.biome = e.biome or e.name
e.name = (pm.dn or l[1]) .. " Egg"
e.rar = pm.rar
e.resolved = true
hit += 1
break
end
end
end
end
end
for _, e in ipairs(eggs) do
if not e.resolved and not e.ic then
local pick = e.art or (e.imgs and e.imgs[1])
if pick then e.ic = pick end
end
end
local shown = 0
for _, e in ipairs(eggs) do
if not e.resolved and shown < 8 then
shown += 1
local cand = {}
for _, id in ipairs(e.imgs or {}) do
local l = anyIc[id]
cand[#cand + 1] = id .. (l and ("=" .. table.concat(l, "/")) or "")
end
lines[#lines + 1] = ("NOT matched: %s %s | card art ids: %s"):format(tostring(e.name), tostring(e.kg), (#cand > 0) and table.concat(cand, ", ") or "none found on the card")
end
end
eggIdDbg = ("egg icons in game data: %d | cards identified by icon: %d of %d\n%s"):format(ne, hit, #eggs, table.concat(lines, "\n"))
end
local function buildEggMap(eggs)
if #eggs == 0 or os.time() - eggMapAt < 300 then return end
eggMapAt = os.time()
local want = {}
for _, e in ipairs(eggs) do
local n = kgNum(e.kg)
if n then want[math.floor(n)] = true; want[math.floor(n + 0.5)] = true end
end
local found, lines, n = {}, {}, 0
for _, d in ipairs(workspace:GetDescendants()) do
n += 1
if n % 400 == 0 then task.wait() end
if n > 120000 then break end
local at = d:GetAttributes()
if next(at) then
for k, v in pairs(at) do
if type(v) == "number" and v >= 1 then
local f = math.floor(v)
local hit = (want[f] and f) or (want[math.floor(v + 0.5)] and math.floor(v + 0.5))
if hit and not found[hit] then
local hasStr = false
for _, v2 in pairs(at) do if type(v2) == "string" then hasStr = true end end
if hasStr then
local wr
local root = d:IsA("Model") and d or (d.Parent or d)
for _, x in ipairs(root:GetDescendants()) do
if x:IsA("TextLabel") then
local xt = clean(x.Text)
if RARWORDS[xt:lower()] then wr = xt break end
end
end
found[hit] = { at = at, rar = wr, path = d:GetFullName():gsub("^Workspace%.", ""), cls = d.ClassName }
end
end
end
end
end
end
eggMap = found
local c = 0
for w, m in pairs(found) do
c += 1
if c <= 5 then
local parts = {}
for k, v in pairs(m.at) do parts[#parts + 1] = k .. "=" .. tostring(v):sub(1, 28) end
lines[#lines + 1] = ("egg match %d: %s [%s]: %s"):format(w, m.path:sub(-70), m.cls, table.concat(parts, "; "))
end
end
lines[#lines + 1] = ("egg matches: %d of %d egg weights (scanned %d)"):format(c, #eggs, n)
eggDbg = table.concat(lines, "\n")
if #eggDbg > 3000 then eggDbg = eggDbg:sub(1, 3000) end
end
local function applyEggMap(eggs)
for _, e in ipairs(eggs) do
local num = kgNum(e.kg)
local m = num and (eggMap[math.floor(num)] or eggMap[math.floor(num + 0.5)])
if m then
for _, k in ipairs({ "EggName", "EggType", "Egg", "PetName", "Pet", "Hatches", "HatchPet", "PetType", "DisplayName", "Name" }) do
local v = m.at[k]
if type(v) == "string" and #v > 2 and v:lower() ~= "egg" and v:lower() ~= tostring(e.name):lower() then
e.biome = e.biome or e.name
e.name = v:lower():find("egg") and v or (v .. " Egg")
break
end
end
local r = m.at.Rarity
if type(r) ~= "string" then r = m.at.EggRarity end
if type(r) ~= "string" then r = m.rar end
if type(r) == "string" and not e.rar then e.rar = r end
end
end
end
local eggCache = nil
local eggRarW, tipDbg = {}, ""
local function readTooltip()
local tipLines = {}
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then return end
for _, x in ipairs(pg:GetDescendants()) do
if x:IsA("TextLabel") and #tipLines < 10 then
local t0 = clean(x.Text)
if t0 ~= "" and #t0 < 14 and RARWORDS[t0:lower()] then
local pth = x:GetFullName():gsub("^.-PlayerGui%.", "")
tipLines[#tipLines + 1] = ("%s | %s | vis=%s"):format(pth:sub(-80), t0, tostring(x.Visible))
end
end
if x:IsA("TextLabel") and x.Visible then
local t = clean(x.Text)
if t ~= "" and #t < 14 and RARWORDS[t:lower()] then
local card = x.Parent
for _ = 1, 3 do
if not card or card == pg then break end
for _, y in ipairs(card:GetDescendants()) do
if y:IsA("TextLabel") and y ~= x then
local w = clean(y.Text):match("%(([%d%.,]+)%s?[Kk][Gg]%)")
if w and clean(y.Text):lower():find("egg") then
local n = tonumber((w:gsub(",", "")))
if n then eggRarW[math.floor(n + 0.5)] = t end
end
end
end
card = card.Parent
end
end
end
end
tipDbg = (#tipLines > 0) and ("rarity labels on screen (any visibility):\n" .. table.concat(tipLines, "\n")) or "rarity labels on screen: none"
end
local toolDbg, nodeDbg = "", ""
local function collect()
local stats, ns, ni = {}, 0, 0
local inv = { pets = {}, eggs = {}, items = {}, equipped = {}, counts = {} }
local toolEggs, toolPets = {}, {}
local function addStat(k, v)
if v ~= nil and ns < 250 then ns += 1; stats[k] = v end
end
local ls = player:FindFirstChild("leaderstats")
if ls then
for _, v in ipairs(ls:GetChildren()) do
if v:IsA("ValueBase") then addStat(v.Name, prim(v.Value)) end
end
end
local KEEP = { Weight = true, BaseMutation = true, Mutation = true }
local seenUID = {}
local function addTool(t, equipped)
local uid = t:GetAttribute("UID")
if type(uid) == "string" then
if seenUID[uid] then return end
seenUID[uid] = true
end
local name, count = t.Name, 1
local dn = t:GetAttribute("DisplayName")
if type(dn) == "string" and dn ~= "" then name = dn end
for _, an in ipairs({ "Count", "Amount", "Quantity", "Stack" }) do
local a = t:GetAttribute(an)
if type(a) == "number" then count = a break end
end
local base, x = name:match("^(.-)%s*[xX](%d+)$")
if base and base ~= "" then name, count = base, tonumber(x) end
local a2, c2 = {}, 0
for k, v in pairs(t:GetAttributes()) do
local pv = prim(v)
if pv ~= nil and KEEP[k] then a2[k] = pv; c2 += 1 end
end
local ic = t:IsA("Tool") and tostring(t.TextureId or ""):match("(%d+)") or nil
if not ic then
for k, v in pairs(t:GetAttributes()) do
local lk = k:lower()
if (lk == "oldid" or lk == "icon" or lk == "iconid" or lk == "image" or lk == "imageid" or lk == "texture" or lk == "textureid" or lk == "thumbnail") and (type(v) == "string" or type(v) == "number") then
local idn = tostring(v):match("(%d%d%d%d%d+)")
if idn then ic = idn break end
end
end
end
local tinc, trar
local tval
for k, v in pairs(t:GetAttributes()) do
local lk = k:lower()
if (lk == "value" or lk == "price" or lk == "sellprice" or lk == "sellvalue" or lk == "worth") and not tval then
if type(v) == "number" then tval = fmtNum(v) elseif type(v) == "string" and v ~= "" then tval = v end
end
end
for k, v in pairs(t:GetAttributes()) do
local lk = k:lower()
if (lk:find("income") or lk:find("persec") or lk:find("mps") or lk:find("earn") or lk == "rate" or lk == "money" or lk == "cash") and not tinc then
if type(v) == "number" then tinc = fmtNum(v) elseif type(v) == "string" and v ~= "" then tinc = v end
elseif lk:find("rarity") and (type(v) == "string" or type(v) == "number") then
trar = tostring(v)
end
end
do
local fa, fb, fv = findInc(t.Name)
if fa then
tinc = tinc or fv
if dn == nil or dn == "" then
name = (t.Name:sub(1, fa - 1) .. " " .. t.Name:sub(fb + 1)):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
end
end
end
local isEgg = name:lower():find("egg") ~= nil or tostring(t:GetAttribute("ItemType")):lower() == "egg" or t:GetAttribute("EggType") ~= nil or t:GetAttribute("EggName") ~= nil
if isEgg then
for _, k in ipairs({ "EggName", "EggType", "PetName", "Pet", "Hatches", "HatchPet", "PetType" }) do
local v = t:GetAttribute(k)
if type(v) == "string" and v ~= "" then name = v; break end
end
if not name:lower():find("egg") then name = name .. " Egg" end
end
local isPet = not isEgg and (tinc ~= nil or t:GetAttribute("ColorIndex") ~= nil or t:GetAttribute("BaseMutation") ~= nil or t:GetAttribute("EyeColor") ~= nil)
if isPet and t.Name ~= name and t.Name:lower():find(name:lower(), 1, true) then name = t.Name end
for _ = 1, math.max(1, math.min(math.floor(count), 40)) do
if ni >= 450 then return end
ni += 1
local e = { name = name, eq = equipped and true or nil, a = (c2 > 0) and a2 or nil, ic = ic, inc = tinc, rar = trar, val = tval, kg = (type(a2.Weight) == "number") and ((isEgg and (string.format("%d", math.floor(a2.Weight + 0.5)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")) or fmtNum(a2.Weight)) .. "Kg") or nil, wt = (type(a2.Weight) == "number") and a2.Weight or nil }
if isEgg then toolEggs[#toolEggs + 1] = e
elseif isPet then toolPets[#toolPets + 1] = e
else inv.items[#inv.items + 1] = e end
end
end
local bp = player:FindFirstChildOfClass("Backpack")
if bp then
for _, t in ipairs(bp:GetChildren()) do
if t:IsA("Tool") then addTool(t, false) end
end
end
local ch = player.Character
if ch then
for _, t in ipairs(ch:GetChildren()) do
if t:IsA("Tool") then addTool(t, true) end
end
end
nodeDbg = ""
do
local roots = {}
for _, c in ipairs(player:GetChildren()) do
if c.Name ~= "PlayerGui" and c.Name ~= "Backpack" and c.Name ~= "PlayerScripts" and c.Name ~= "StarterGear" then roots[#roots + 1] = c end
end
local rs = game:GetService("ReplicatedStorage")
for _, c in ipairs(rs:GetDescendants()) do
if (c.Name == tostring(player.UserId) or c.Name == player.Name) and (c:IsA("Folder") or c:IsA("Configuration")) then roots[#roots + 1] = c end
end
local cnt, got, n = 0, 0, 0
local samples = {}
for _, root in ipairs(roots) do
for _, d in ipairs(root:GetDescendants()) do
n += 1
if n % 500 == 0 then task.wait() end
if n > 20000 then break end
if not d:IsA("Tool") and typeof(d:GetAttribute("Weight")) == "number" then
cnt += 1
if #samples < 3 then
local parts = {}
for k, v in pairs(d:GetAttributes()) do parts[#parts + 1] = k .. "=" .. tostring(v):sub(1, 24) end
samples[#samples + 1] = d:GetFullName():sub(-60) .. ": " .. table.concat(parts, "; ")
end
local b = #toolEggs + #toolPets
addTool(d, false)
if #toolEggs + #toolPets > b then got += 1 end
end
end
end
if cnt > 0 or #roots > 0 then
nodeDbg = ("data folders: %d roots, %d weight-nodes, %d added\n%s"):format(#roots, cnt, got, table.concat(samples, "\n"))
end
end
local okg, g = pcall(scanGui)
if okg and type(g) == "table" and OTHER_GAME then
g.pets, g.eggs, g.equipped, g.counts = {}, {}, {}, {}
end
if okg and type(g) == "table" then
if not OTHER_GAME then pcall(readTooltip) end
for _, ge in ipairs(g.eggs) do
local n = kgNum(ge.kg)
local r = n and eggRarW[math.floor(n + 0.5)]
if r and not ge.rar then ge.rar = r end
end
if #g.eggs > 0 then eggCache = { list = g.eggs, at = os.time() }
elseif eggCache and os.time() - eggCache.at < 900 then g.eggs = eggCache.list end
inv.equipped, inv.counts = g.equipped, g.counts
local guiInc = {}
for _, l in ipairs({ g.pets, g.equipped }) do
for _, e in ipairs(l) do
if e.inc and not guiInc[e.name:lower()] then guiInc[e.name:lower()] = e end
end
end
if #toolPets > 0 then
for _, e in ipairs(toolPets) do
local m = guiInc[tostring(e.name):lower()]
if m then e.inc = e.inc or m.inc; e.rar = e.rar or m.rar end
end
inv.pets = toolPets
else
inv.pets = g.pets
end
if #inv.pets == 0 and #inv.equipped == 0 then inv.pets = toolPets end
pcall(scanTabs)
inv.dbg = tabDbgText .. (g.eggDbg and (g.eggDbg .. "----\n") or "") .. (dbgText or "")
local function wkey(x) return x and math.floor(x + 0.5) end
for _, e in ipairs(toolEggs) do
local r = e.wt and eggRarW[math.floor(e.wt + 0.5)]
if r and not e.rar then e.rar = r end
end
if #g.eggs > 0 and #g.eggs >= #toolEggs then
local used = {}
for _, e in ipairs(toolEggs) do
local done = false
for i, ge in ipairs(g.eggs) do
local n = kgNum(ge.kg)
if not used[i] and n and e.wt and wkey(n) == wkey(e.wt) then
used[i] = true; done = true
if ge.name ~= e.name then ge.biome = ge.biome or ge.name; ge.name = e.name end
ge.a = e.a or ge.a
break
end
end
if not done then g.eggs[#g.eggs + 1] = e end
end
inv.eggs = g.eggs
elseif #toolEggs > 0 then
local byW = {}
for _, ge in ipairs(g.eggs) do
local n = kgNum(ge.kg)
if n then byW[wkey(n)] = byW[wkey(n)] or ge end
end
for _, e in ipairs(toolEggs) do
local ge = e.wt and byW[wkey(e.wt)]
if ge then
e.inc = e.inc or ge.inc; e.val = e.val or ge.val; e.rar = e.rar or ge.rar
if ge.name ~= e.name then e.biome = ge.name end
end
end
inv.eggs = toolEggs
else
inv.eggs = g.eggs
end
if g.money then stats.Money = g.money end
if g.mps then stats["Money/s"] = g.mps end
if g.speed then stats.Speed = g.speed end
else
inv.eggs, inv.pets = toolEggs, toolPets
end
local okr, idx = pcall(buildRarity)
if okr and type(idx) == "table" then
tagRarity(inv.pets, idx)
tagRarity(inv.equipped, idx)
tagRarity(inv.eggs, idx)
end
do
local lines, seenT = {}, {}
local bp2 = player:FindFirstChildOfClass("Backpack")
if bp2 then
local cntT = {}
for _, t in ipairs(bp2:GetChildren()) do
if t:IsA("Tool") then
local ty = tostring(t:GetAttribute("ItemType") or "?")
cntT[ty] = (cntT[ty] or 0) + 1
seenT[ty] = (seenT[ty] or 0) + 1
if seenT[ty] <= 3 then
local parts = { "name=" .. t.Name }
for an, av in pairs(t:GetAttributes()) do
if type(av) ~= "table" and typeof(av) ~= "table" then parts[#parts + 1] = an .. "=" .. tostring(av):sub(1, 30) end
end
lines[#lines + 1] = "tool[" .. ty .. "]: " .. table.concat(parts, "; ")
end
end
end
local cs = {}
for ty, c in pairs(cntT) do cs[#cs + 1] = ty .. "=" .. c end
table.insert(lines, 1, "backpack tools by ItemType: " .. table.concat(cs, ", "))
end
toolDbg = table.concat(lines, "\n")
if #toolDbg > 3500 then toolDbg = toolDbg:sub(1, 3500) end
end
pcall(buildEggMap, inv.eggs)
pcall(applyEggMap, inv.eggs)
pcall(buildDeep)
pcall(buildModIdx)
if next(modPal) then inv.pal = modPal end
pcall(applyMods, inv.pets); pcall(applyMods, inv.equipped); pcall(applyMods, inv.eggs)
pcall(function()
for _, it in ipairs(inv.items or {}) do
if not it.ic then
local gn = type(it.a) == "table" and it.a.GearName or nil
local base = tostring(it.name):gsub("%s*%[[xX]?%d+%]%s*$", "")
local m = modIdx[tostring(gn or ""):lower()] or modIdx[base:lower()]
if m and m.ic then it.ic = m.ic end
end
end
end)
pcall(identifyEggs, inv.eggs)
if not OTHER_GAME then pcall(scanHotbar, inv) end
if hotbarDbg ~= "" then inv.dbg = hotbarDbg .. "\n----\n" .. (inv.dbg or "") end
if eggDbg ~= "" then inv.dbg = eggDbg .. "\n----\n" .. (inv.dbg or "") end
if deepDbg ~= "" then inv.dbg = deepDbg .. "\n----\n" .. (inv.dbg or "") end
if tipDbg ~= "" then inv.dbg = tipDbg .. "\n----\n" .. (inv.dbg or "") end
if nodeDbg ~= "" then inv.dbg = nodeDbg .. "\n----\n" .. (inv.dbg or "") end
if toolDbg ~= "" then inv.dbg = (inv.dbg and (inv.dbg .. "\n----\n") or "") .. toolDbg end
if eggIdDbg ~= "" then inv.dbg = eggIdDbg .. "\n----\n" .. (inv.dbg or "") end
if modDbg ~= "" then inv.dbg = (inv.dbg and (inv.dbg .. "\n----\n") or "") .. modDbg end
pcall(fillIcons, { inv.pets, inv.equipped, inv.eggs, inv.items })
task.spawn(dumpGui)
return stats, inv
end
pcall(function()
local okq, res = pcall(httpRequest, {
Url = SUPABASE_URL .. "/rest/v1/pilots?select=total_seconds,target_hours&user_id=eq." .. player.UserId,
Method = "GET",
Headers = { ["apikey"] = SUPABASE_KEY, ["Authorization"] = "Bearer " .. SUPABASE_KEY },
})
if not (okq and res and res.Body) then return end
local okj, rows = pcall(HttpService.JSONDecode, HttpService, res.Body)
local row = okj and type(rows) == "table" and rows[1]
if type(row) ~= "table" then return end
local rt = tonumber(row.total_seconds)
if rt and rt > total + 10 and rt < 86400 * 400 then
total = math.floor(rt)
lastTick = os.time()
save()
local rh = tonumber(row.target_hours)
if needPick and rh and rh >= 1 and rh <= 9999 then pcall(setTarget, rh) end
render()
end
end)
local lastSig, lastSent, fails = "", 0, 0
writeStatus("reporter started, waiting to send the first report")
task.wait(3 + math.random() * 7)
local loopWarned = false
while isCurrent() do
local okLoop, errLoop = pcall(function()
local okm, emsg = pcall(function() return game:GetService("GuiService"):GetErrorMessage() end)
local offline = okm and type(emsg) == "string" and emsg ~= ""
if not offline then
if not avatar then fetchAvatar() end
local now = os.time()
local cur = total
if running then cur = total + math.min(5, math.max(0, now - lastTick)) end
local sig = table.concat({ tostring(running), tostring(targetH), tostring(needPick) }, "|")
if sig ~= lastSig or now - lastSent >= REPORT_EVERY then
local body = {
user_id = player.UserId,
username = player.Name,
display_name = player.DisplayName,
avatar_url = avatar,
total_seconds = math.floor(cur),
target_hours = (not needPick) and targetH or nil,
running = running and true or false,
is_pilot = isPilot,
place_id = game.PlaceId,
updated_at = iso(now),
}
local withDetails = (now - lastDetails >= DETAILS_EVERY)
if withDetails then
if not gameName then
local okp, info = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
if okp and type(info) == "table" and info.Name then
local cn = tostring(info.Name):gsub("%b[]", ""):gsub("%b()", ""):gsub("[^%w%s%-':&!%.]", ""):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
gameName = (cn ~= "" and cn) or tostring(info.Name)
end
do
local ln = tostring(info and info.Name or ""):lower()
if ln:find("ride a pet", 1, true) then FIXED_NAME = "Ride a Pet"; OTHER_GAME = true
elseif ln:find("break and steal", 1, true) then FIXED_NAME = "Break and Steal an Egg" end
end
if FIXED_NAME then gameName = FIXED_NAME end
end
local oks, st, inv = pcall(collect)
if oks then
pcall(resolveIcons, inv)
if not gameIcon then pcall(fetchGameIcon) end
if type(inv) == "table" and gameIcon then inv.game_icon = gameIcon end
body.game_name = gameName
body.stats = st
body.inventory = inv
body.details_at = iso(now)
else
withDetails = false
end
end
local function post(b)
local oke, enc = pcall(HttpService.JSONEncode, HttpService, b)
if not oke then return false, "encode: " .. tostring(enc) end
return pcall(httpRequest, {
Url = SUPABASE_URL .. "/rest/v1/pilots?on_conflict=user_id",
Method = "POST",
Headers = {
["apikey"] = SUPABASE_KEY,
["Authorization"] = "Bearer " .. SUPABASE_KEY,
["Content-Type"] = "application/json",
["Prefer"] = "resolution=merge-duplicates,return=minimal",
},
Body = enc,
})
end
local ok, res = post(body)
if not (ok and res and res.StatusCode and res.StatusCode < 300) and withDetails then
warn("[dashboard] report with details failed, sending without them: " .. tostring(ok and res and (tostring(res.StatusCode) .. " " .. tostring(res.Body):sub(1, 120)) or res))
body.stats, body.inventory, body.details_at = nil, nil, nil
withDetails = false
ok, res = post(body)
end
writeStatus(("%s | game: %s | details: %s | server answer: %s"):format((ok and res and res.StatusCode and res.StatusCode < 300) and "SENT OK" or "FAILED", tostring(gameName), tostring(withDetails), tostring(ok and res and (tostring(res.StatusCode) .. " " .. tostring(res.Body):sub(1, 100)) or res)))
if ok and res and res.StatusCode and res.StatusCode < 300 then
lastSig, lastSent, fails = sig, now, 0
if withDetails then lastDetails = now end
else
fails += 1
lastSent = now
if fails == 1 then
warn("[dashboard] report failed: " .. tostring(ok and res and (res.StatusCode .. " " .. tostring(res.Body)) or res))
end
end
end
end
end)
if not okLoop and not loopWarned then
loopWarned = true
warn("[dashboard] reporter error (it keeps running): " .. tostring(errLoop))
end
task.wait(2)
end
end)
do
local gs = game:GetService("GuiService")
local lastMsg = ""
local function logIt()
local ok, msg = pcall(function() return gs:GetErrorMessage() end)
msg = ok and type(msg) == "string" and msg or ""
if msg ~= "" and msg ~= lastMsg and hasFS then
local line = ("[%s PH] %s | %s\n"):format(os.date("!%a %H:%M:%S", os.time() + 8 * 3600), player.Name, (msg:gsub("[\r\n]+", " ")))
pcall(function()
if appendfile then
appendfile("Disconnects.txt", line)
else
writefile("Disconnects.txt", (isfile("Disconnects.txt") and readfile("Disconnects.txt") or "") .. line)
end
end)
end
lastMsg = msg
end
pcall(function() track(gs.ErrorMessageChanged:Connect(logIt)) end)
task.spawn(function()
while isCurrent() do
logIt()
task.wait(2)
end
end)
end
local altsLabel = Instance.new("TextLabel")
altsLabel.Name = "AltsHere"
altsLabel.ZIndex = 2
altsLabel.Size = UDim2.new(1, -12, 0, 28)
altsLabel.Position = UDim2.new(0, 6, 0, 90)
altsLabel.BackgroundTransparency = 1
altsLabel.TextColor3 = Color3.new(1, 1, 1)
altsLabel.TextSize = 11
altsLabel.TextScaled = true
altsLabel.TextWrapped = true
altsLabel.Font = Enum.Font.GothamBold
altsLabel.TextXAlignment = Enum.TextXAlignment.Left
altsLabel.TextYAlignment = Enum.TextYAlignment.Top
altsLabel.Parent = frame
do
local lim = Instance.new("UITextSizeConstraint")
lim.MaxTextSize = 11
lim.MinTextSize = 6
lim.Parent = altsLabel
end
local hopRowOn = false
local hopBtn = Instance.new("TextButton")
hopBtn.Name = "HopButton"
hopBtn.ZIndex = 4
hopBtn.Size = UDim2.new(1, -12, 0, 22)
hopBtn.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
hopBtn.BorderSizePixel = 0
hopBtn.Text = "HOP"
hopBtn.TextColor3 = Color3.new(1, 1, 1)
hopBtn.TextSize = 13
hopBtn.Font = Enum.Font.GothamBold
hopBtn.Visible = false
hopBtn.Parent = frame
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 6)
do
local st = Instance.new("UIStroke")
st.Color = Color3.fromRGB(190, 238, 255)
st.Thickness = 1.5
st.Parent = hopBtn
end
local function setAlts(text)
altsLabel.Text = text
local base = 104 + chipsExtra
altsLabel.Position = UDim2.new(0, 6, 0, base)
local h = (text == "") and base or base + 30
if hopRowOn then
hopBtn.Position = UDim2.new(0, 6, 0, h + 2)
h = h + 28
end
hopBtn.Visible = hopRowOn
if env.__menuMin and h < env.__menuMin then h = env.__menuMin end
if env.__srvMin and h < env.__srvMin then h = env.__srvMin end
frame.Size = UDim2.new(0, 250, 0, h)
end
relayout = function()
setAlts(altsLabel.Text)
end
local joining = false
local hopNote = ""
local lastStatus = ""
local function getAlts()
local found = {}
local claimed = nil
for _, p in ipairs(Players:GetPlayers()) do
if p ~= player then
local isAlt = myAccounts[string.lower(p.Name)] and true or false
if not isAlt and env.__claimedUids then
if not claimed then
local ok, c = pcall(env.__claimedUids)
claimed = (ok and c) or {}
end
isAlt = claimed[tostring(p.UserId)] and true or false
end
if isAlt then
table.insert(found, p)
end
end
end
return found
end
local function refresh()
local alts = getAlts()
local text = ""
if #alts > 0 then
local names = {}
for _, p in ipairs(alts) do
table.insert(names, p.DisplayName)
end
text = "Alts here: " .. #alts .. " (" .. table.concat(names, ", ") .. ")"
end
if not httpRequest then
text = (text ~= "") and (text .. "\nNO HTTP FUNCTION - cannot hop") or "NO HTTP FUNCTION - cannot hop"
elseif not hasFS then
text = (text ~= "") and (text .. "\nNO FILE ACCESS - accounts can't coordinate") or "NO FILE ACCESS - accounts can't coordinate"
end
if joining then
local extra = (lastStatus ~= "") and lastStatus or "Hopping..."
text = (text ~= "") and (text .. "\n" .. extra) or extra
elseif hopNote ~= "" and text ~= "" then
text = text .. "\n" .. hopNote
end
hopRowOn = (HOP_MODE == "manual") and #alts > 0
hopBtn.Text = joining and "Hopping..." or "HOP"
setAlts(text)
end
refresh()
track(Players.PlayerAdded:Connect(refresh))
track(Players.PlayerRemoving:Connect(function()
task.defer(refresh)
end))
task.spawn(function()
while isCurrent() do
refresh()
task.wait(1)
end
end)
local function inRange(s)
return s.ping ~= nil and s.ping >= MIN_PING and s.ping <= MAX_PING
end
local function apiFetch(onRetry, cursor)
if not httpRequest then
return nil, "No HTTP request function in this executor."
end
local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=%d&excludeFullGames=true")
:format(PLACE_ID, LIMIT)
if cursor then url = url .. "&cursor=" .. cursor end
local MAX_ATTEMPTS = 4
local decoded
local function waitAlive(sec)
local e, lastTouch = os.clock() + sec, 0
while os.clock() < e do
task.wait(math.min(1, math.max(0.05, e - os.clock())))
if hasFS and os.clock() - lastTouch >= 5 then
lastTouch = os.clock()
pcall(function()
if isfile("LowServerLock.txt") and readfile("LowServerLock.txt"):match("^(%d+)|") == myId then
writefile("LowServerLock.txt", myId .. "|" .. os.time())
end
end)
end
end
end
for attempt = 1, MAX_ATTEMPTS do
local ok, res = pcall(function()
return httpRequest({ Url = url, Method = "GET" })
end)
if ok and res and res.Body and res.StatusCode ~= 429 then
local parsed
ok, parsed = pcall(HttpService.JSONDecode, HttpService, res.Body)
if ok and type(parsed) == "table" and parsed.data then
decoded = parsed
break
end
end
if attempt == MAX_ATTEMPTS then
return nil, "Rate limited."
end
local wait = 1.5
if onRetry then onRetry(attempt, wait) end
waitAlive(wait)
end
local list = {}
for _, sv in ipairs(decoded.data) do
table.insert(list, { id = sv.id, playing = sv.playing, maxPlayers = sv.maxPlayers, ping = sv.ping })
end
return list, nil, decoded.nextPageCursor
end
local function appendLine(line)
if not hasFS then return end
pcall(function()
if appendfile then
appendfile(CLAIM_FILE, line .. "\n")
else
local cur = isfile(CLAIM_FILE) and readfile(CLAIM_FILE) or ""
writefile(CLAIM_FILE, cur .. line .. "\n")
end
end)
end
local function writeClaim(job, state)
appendLine(("%s|%s|%d|%s"):format(job, myId, os.time(), state))
end
local function readClaims()
if not hasFS or not isfile(CLAIM_FILE) then return {} end
local ok, data = pcall(readfile, CLAIM_FILE)
if not ok or type(data) ~= "string" then return {} end
local now, lines = os.time(), 0
local releases, raw = {}, {}
for line in data:gmatch("[^\n]+") do
lines += 1
local job, uid, t, st = line:match("^([^|]+)|([^|]+)|(%d+)|(%a)$")
t = tonumber(t)
if job and t and now - t <= CLAIM_TTL then
if st == "r" then
local key = job .. "|" .. uid
releases[key] = math.max(releases[key] or 0, t)
else
table.insert(raw, { job = job, uid = uid, t = t })
end
end
end
local claims = {}
for _, c in ipairs(raw) do
local rel = releases[c.job .. "|" .. c.uid]
if not rel or c.t > rel then table.insert(claims, c) end
end
if lines > 80 then
local out = {}
for _, c in ipairs(claims) do
out[#out + 1] = ("%s|%s|%d|c"):format(c.job, c.uid, c.t)
end
pcall(writefile, CLAIM_FILE, table.concat(out, "\n") .. (#out > 0 and "\n" or ""))
end
return claims
end
local function ranking(claims, job)
local best = {}
for _, c in ipairs(claims) do
if c.job == job and (not best[c.uid] or c.t < best[c.uid]) then
best[c.uid] = c.t
end
end
local arr = {}
for uid, t in pairs(best) do table.insert(arr, { uid = uid, t = t }) end
table.sort(arr, function(a, b)
if a.t ~= b.t then return a.t < b.t end
return a.uid < b.uid
end)
return arr
end
local function takenByOthers(claims, job)
local n = 0
for _, e in ipairs(ranking(claims, job)) do
if e.uid ~= myId then n += 1 end
end
return n >= ACCOUNTS_PER_SERVER
end
do
local cache, cacheT = {}, 0
env.__claimedUids = function()
if os.time() - cacheT >= 3 then
cacheT = os.time()
cache = {}
for _, e in ipairs(ranking(readClaims(), game.JobId)) do
cache[e.uid] = true
end
end
return cache
end
end
local function tryClaim(job)
if not hasFS then return true end
if takenByOthers(readClaims(), job) then return false end
writeClaim(job, "c")
task.wait(0.2 + math.random() * 0.2)
for i, e in ipairs(ranking(readClaims(), job)) do
if e.uid == myId then
if i <= ACCOUNTS_PER_SERVER then return true end
break
end
end
writeClaim(job, "r")
return false
end
task.spawn(function()
while isCurrent() do
writeClaim(game.JobId, "c")
task.wait(HEARTBEAT)
end
end)
local JOIN_FILE_PREFIX = "AccountJoin_"
local myJoinTime = os.time()
if hasFS then
pcall(function()
local f = JOIN_FILE_PREFIX .. player.UserId .. ".txt"
if isfile(f) then
local job, t = string.match(readfile(f), "^([^,]+),(%d+)$")
if job == game.JobId and t then
myJoinTime = tonumber(t)
end
end
writefile(f, game.JobId .. "," .. myJoinTime)
end)
end
local function joinTimeOf(p)
if hasFS then
local ok, t = pcall(function()
local f = JOIN_FILE_PREFIX .. p.UserId .. ".txt"
if not isfile(f) then
return nil
end
local job, ts = string.match(readfile(f), "^([^,]+),(%d+)$")
if job == game.JobId and ts then
return tonumber(ts)
end
return nil
end)
if ok and t then
return t
end
local uid = tostring(p.UserId)
for _, e in ipairs(ranking(readClaims(), game.JobId)) do
if e.uid == uid then
return e.t
end
end
end
return nil
end
do
local ACTIVE_FILE_PREFIX = "AccountStart_"
local ACTIVE_FRESH = 20
local runStart = os.time()
local function readActive(uid)
if not hasFS then
return nil
end
local ok, t, seen, job = pcall(function()
local f = ACTIVE_FILE_PREFIX .. uid .. ".txt"
if not isfile(f) then
return nil
end
local tt, ss, jj = string.match(readfile(f), "^(%d+),(%d+),(.+)$")
if tt then
return tonumber(tt), tonumber(ss), jj
end
return nil
end)
if ok then
return t, seen, job
end
return nil
end
local function saveActive()
if hasFS then
pcall(writefile, ACTIVE_FILE_PREFIX .. player.UserId .. ".txt",
string.format("%d,%d,%s", runStart, os.time(), game.JobId))
end
end
saveActive()
task.spawn(function()
local last = os.time()
local lastSave = 0
while isCurrent() do
task.wait(1)
local now = os.time()
last = now
if now - lastSave >= 3 then
lastSave = now
saveActive()
end
end
end)
local function activeOf(p)
local t, seen, job = readActive(p.UserId)
if t and job == game.JobId and (os.time() - seen) <= ACTIVE_FRESH then
return t
end
return nil
end
local function fmtHM(sec)
if sec >= 3600 then
return string.format("%dh%02dm", math.floor(sec / 3600), math.floor((sec % 3600) / 60))
end
return string.format("%dm%02ds", math.floor(sec / 60), sec % 60)
end
local INFO_GRACE = 30
local firstSeenNoInfo = {}
end
local SECOND_FILE_PREFIX = "Account2nd_"
local SECOND_FRESH = 30
local function has2nd()
local ok, res = pcall(function()
local g = getgenv and getgenv()
local st = g and g.BigFrootLoaderState
if type(st) == "table" and type(st.loaded) == "table" then
for _, v in pairs(st.loaded) do
if v then return true end
end
end
return false
end)
return ok and res == true
end
local function other2nd(p)
if not hasFS then return false end
local ok, res = pcall(function()
local f = SECOND_FILE_PREFIX .. p.UserId .. ".txt"
if not isfile(f) then return false end
local t, v = string.match(readfile(f), "^(%d+),(%d)$")
return t ~= nil and v == "1" and os.time() - tonumber(t) <= SECOND_FRESH
end)
return ok and res == true
end
if hasFS then
task.spawn(function()
while isCurrent() do
pcall(writefile, SECOND_FILE_PREFIX .. player.UserId .. ".txt", os.time() .. "," .. (has2nd() and "1" or "0"))
task.wait(5)
end
end)
end
do
local function launchLog(msg, note)
if hasFS then
pcall(writefile, "Launch2nd_" .. player.Name .. ".txt", "[" .. os.date("!%H:%M:%S UTC", os.time()) .. "] " .. tostring(msg))
end
if note then umbraNote("2nd script: " .. tostring(msg)) else print("[Umbra 2nd script] " .. tostring(msg)) end
end
local isPilot = false
local lname = string.lower(player.Name)
for _, n in ipairs(RIDE_A_PET_PILOTS) do if string.lower(n) == lname then isPilot = true end end
for _, n in ipairs(BREAK_AND_STEAL_PILOTS) do if string.lower(n) == lname then isPilot = true end end
local secondKey = SECOND.key
if secondKey == "" then
pcall(function()
local g = (getgenv and getgenv()) or _G
local k = g.script_key or g.SCRIPT_KEY or _G.script_key or _G.SCRIPT_KEY or (shared and (shared.script_key or shared.SCRIPT_KEY))
if type(k) ~= "string" and getfenv then
for lvl = 1, 3 do
local okf, fe = pcall(getfenv, lvl)
if okf and type(fe) == "table" and type(fe.script_key) == "string" then k = fe.script_key break end
end
end
if type(k) == "string" then secondKey = (k:gsub("%s+", "")) end
end)
end
if secondKey == "" then
launchLog("OFF: no script_key found. Put getgenv().script_key = \"...\" in your loader line", true)
elseif isPilot and not SECOND.onPilots then
launchLog("OFF: this account is a pilot")
else
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
launchLog("watching, starts after " .. SECOND.delay .. "s alone")
local soloSince, lastState, tries = nil, "", 0
local function state(t) if t ~= lastState then lastState = t; launchLog(t) end end
while isCurrent() do
if has2nd() then
state("already loaded on this account, nothing to do")
return
end
local okA, alts = pcall(getAlts)
if okA and type(alts) == "table" and #alts == 0 then
soloSince = soloSince or os.time()
state("alone, counting " .. SECOND.delay .. "s")
if os.time() - soloSince >= SECOND.delay then
tries += 1
launchLog("starting the 2nd script (try " .. tries .. ")", true)
pcall(function()
local g = getgenv and getgenv()
if g then g.script_key, g.SCRIPT_KEY = secondKey, secondKey end
end)
local code = 'script_key = "' .. secondKey .. '" ;\nloadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()'
local fn, errC = loadstring(code)
if not fn then
launchLog("FAILED: could not compile the loader line (" .. tostring(errC):sub(1, 80) .. ")", true)
return
end
local okR, errR = pcall(fn)
if not okR then
launchLog("FAILED: " .. tostring(errR):sub(1, 100), true)
else
local t0 = os.time()
while not has2nd() and os.time() - t0 < 15 do task.wait(1) end
if has2nd() then
launchLog("STARTED: the 2nd script is loading", true)
return
end
launchLog("loader ran but registered nothing (this game may not be in its list, or the download failed)", true)
end
if tries >= 3 then return end
soloSince = nil
task.wait(30)
end
else
soloSince = nil
state("not alone: " .. (okA and tostring(#alts) or "?") .. " of my accounts here, waiting")
end
task.wait(1)
end
end)
end
end
local function shouldHop()
local alts = getAlts()
if #alts == 0 then
hopNote = ""
return false
end
if not has2nd() then
hopNote = "Leaving: " .. alts[1].DisplayName .. " is in this server"
return true
end
for _, p in ipairs(alts) do
if other2nd(p) then
local theirs = joinTimeOf(p)
if theirs then
if theirs < myJoinTime or (theirs == myJoinTime and p.UserId < player.UserId) then
hopNote = "Leaving: " .. p.DisplayName .. " also has the 2nd script and was here first"
return true
end
elseif p.UserId < player.UserId then
hopNote = "Leaving: " .. p.DisplayName .. " also has the 2nd script (lower ID stays)"
return true
end
end
end
hopNote = "Staying: 2nd script is loaded on this account"
return false
end
local CACHE_FILE = "LowServerCache.json"
local LOCK_FILE = "LowServerLock.txt"
local function readCache()
if not isfile(CACHE_FILE) then return {} end
local ok, data = pcall(readfile, CACHE_FILE)
if not ok then return {} end
local ok2, t = pcall(HttpService.JSONDecode, HttpService, data)
if ok2 and type(t) == "table" then return t end
return {}
end
local function writeCacheEntry(key, servers, nxt)
local cache = readCache()
local now = os.time()
for k, v in pairs(cache) do
if type(v) ~= "table" or now - (v.t or 0) > 900 then cache[k] = nil end
end
cache[key] = { t = now, servers = servers, next = nxt }
pcall(writefile, CACHE_FILE, HttpService:JSONEncode(cache))
end
local function cacheFresh(entry, maxAge)
return entry and type(entry.servers) == "table" and os.time() - (entry.t or 0) <= (maxAge or CACHE_TTL)
end
local function tryLock()
if isfile(LOCK_FILE) then
local ok, data = pcall(readfile, LOCK_FILE)
local t = tostring(data):match("^%d+|(%d+)$")
if ok and t and os.time() - tonumber(t) < 15 then return false end
end
pcall(writefile, LOCK_FILE, myId .. "|" .. os.time())
task.wait(0.2 + math.random() * 0.15)
local ok, data = pcall(readfile, LOCK_FILE)
return ok and tostring(data):match("^(%d+)|") == myId
end
local function unlock()
pcall(writefile, LOCK_FILE, "")
end
do
local BAD_FILE = "LowServerBad.txt"
env.__markBad = function(id)
if not hasFS or not id then return end
pcall(function()
local line = id .. "|" .. os.time() .. "\n"
if appendfile then appendfile(BAD_FILE, line) else writefile(BAD_FILE, (isfile(BAD_FILE) and readfile(BAD_FILE) or "") .. line) end
end)
end
env.__badSet = function()
local set = {}
if not hasFS or not isfile(BAD_FILE) then return set end
local ok, data = pcall(readfile, BAD_FILE)
if not ok or type(data) ~= "string" then return set end
local now, keep, n = os.time(), {}, 0
for id, t in data:gmatch("([^|\n]+)|(%d+)") do
n += 1
if now - tonumber(t) <= 600 then set[id] = true; keep[#keep + 1] = id .. "|" .. t end
end
if n > 60 then pcall(writefile, BAD_FILE, table.concat(keep, "\n") .. (#keep > 0 and "\n" or "")) end
return set
end
end
local function build(list)
local out = {}
local bad = env.__badSet()
for _, sv in ipairs(list) do
local roomy = not (sv.maxPlayers and sv.playing and sv.playing >= sv.maxPlayers - 1)
if sv.id ~= game.JobId and not bad[sv.id] then table.insert(out, sv) end
end
table.sort(out, function(a, b)
local pa, pb = a.ping or math.huge, b.ping or math.huge
if pa ~= pb then return pa < pb end
return (a.playing or 0) < (b.playing or 0)
end)
return out
end
local function fetchServers(onRetry, cursor, maxAge)
if not hasFS then
local l, e, n = apiFetch(onRetry, cursor)
if not l then return nil, e end
return build(l), nil, n
end
local key = (cursor or "first") .. "|Asc"
if maxAge == -1 then
local l, e, n = apiFetch(onRetry, cursor)
if l then
writeCacheEntry(key, l, n)
return build(l), nil, n
end
local old = readCache()[key]
if old and type(old.servers) == "table" then return build(old.servers), nil, old.next end
return nil, e
end
local deadline = os.clock() + 90
while os.clock() < deadline do
local entry = readCache()[key]
if cacheFresh(entry, maxAge) then
return build(entry.servers), nil, entry.next
end
if entry and type(entry.servers) == "table" then
local okc, cd = pcall(function() return isfile("LowServerCooldown.txt") and tonumber(readfile("LowServerCooldown.txt")) or 0 end)
if okc and cd and cd > os.time() then
return build(entry.servers), nil, entry.next
end
end
if tryLock() then
local again = readCache()[key]
if cacheFresh(again, maxAge) then
unlock()
return build(again.servers), nil, again.next
end
local l, e, n = apiFetch(onRetry, cursor)
if l then writeCacheEntry(key, l, n) end
unlock()
if not l then
local old = readCache()[key]
if old and type(old.servers) == "table" then return build(old.servers), nil, old.next end
return nil, e
end
return build(l), nil, n
end
if entry and type(entry.servers) == "table" then
return build(entry.servers), nil, entry.next
end
task.wait(0.15)
end
local l, e, n = apiFetch(onRetry, cursor)
if not l then return nil, e end
return build(l), nil, n
end
local status = nil
local function setStatus(text)
if joining and hasFS then
text = ("[%ds] %s"):format(os.time() - (env.__joinStarted or os.time()), text)
pcall(appendfile or writefile, "HopLog.txt", ("%s %s\n"):format(player.Name, text))
end
lastStatus = text
if status then
status.Text = text
end
end
local main = Instance.new("Frame")
main.Name = "LowServerBrowser"
main.Size = UDim2.new(1, 0, 1, -60)
main.Position = UDim2.new(0, 0, 0, 60)
main.BackgroundColor3 = Color3.fromRGB(8, 18, 44)
main.BorderSizePixel = 0
main.ZIndex = 30
main.Visible = false
main.Parent = frame
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 9)
do
local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(60, 190, 255)
ms.Transparency = 0.35
ms.Thickness = 1.2
ms.Parent = main
end
local function closeSrv()
main.Visible = false
env.__srvMin = nil
if not env.__menuMin then
relayout()
end
end
env.__srvClose = closeSrv
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -136, 0, 22)
title.Position = UDim2.fromOffset(8, 0)
title.BackgroundTransparency = 1
title.Text = "v7 " .. HOP_MODE
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main
local function makeButton(text, x, w, color)
local b = Instance.new("TextButton")
b.Size = UDim2.fromOffset(w, 16)
b.Position = UDim2.new(1, x, 0, 3)
b.BackgroundColor3 = color
b.Text = text
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBold
b.TextSize = 9
b.BorderSizePixel = 0
b.Parent = main
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
return b
end
local autoBtn = makeButton("Auto: OFF", -128, 56, Color3.fromRGB(110, 110, 120))
local refreshBtn = makeButton("Refresh", -68, 44, Color3.fromRGB(40, 100, 220))
local closeBtn = makeButton("X", -22, 16, Color3.fromRGB(200, 70, 70))
status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 14)
status.Position = UDim2.fromOffset(6, 22)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(170, 170, 180)
status.Font = Enum.Font.Gotham
status.TextSize = 9
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -12, 1, -40)
scroll.Position = UDim2.fromOffset(6, 36)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new()
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = main
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)
local rowsById = {}
local function clearList()
for _, c in ipairs(scroll:GetChildren()) do
if c:IsA("Frame") then c:Destroy() end
end
rowsById = {}
end
local pendingJob = nil
local autoOn = AUTO_JOIN
local lastLeave = true
local function dismissErrorPrompt()
pcall(function()
local promptGui = CoreGui:FindFirstChild("RobloxPromptGui")
local overlay = promptGui and promptGui:FindFirstChild("promptOverlay")
if overlay then
for _, c in ipairs(overlay:GetChildren()) do
if c.Name == "ErrorPrompt" then c:Destroy() end
end
end
end)
end
local function addRow(server)
local row = Instance.new("Frame")
row.Size = UDim2.new(1, -6, 0, 30)
row.BackgroundColor3 = Color3.fromRGB(18, 38, 84)
row.BorderSizePixel = 0
row.Parent = scroll
rowsById[server.id] = row
Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -50, 1, 0)
info.Position = UDim2.fromOffset(6, 0)
info.BackgroundTransparency = 1
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextColor3 = Color3.new(1, 1, 1)
info.Font = Enum.Font.Gotham
info.TextSize = 9
info.Text = ("%d / %d players  |  %s ms\n%s"):format(
server.playing or 0, server.maxPlayers or 0,
server.ping and tostring(server.ping) or "?",
(server.id or ""):sub(1, 12) .. "..."
)
info.Parent = row
local join = Instance.new("TextButton")
join.Size = UDim2.fromOffset(38, 20)
join.Position = UDim2.new(1, -44, 0.5, -10)
join.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
join.Text = "Join"
join.TextColor3 = Color3.new(1, 1, 1)
join.Font = Enum.Font.GothamBold
join.TextSize = 10
join.BorderSizePixel = 0
join.Parent = row
Instance.new("UICorner", join).CornerRadius = UDim.new(0, 6)
join.MouseButton1Click:Connect(function()
setStatus("Joining server...")
pendingJob = server.id
writeClaim(server.id, "c")
local ok, err = pcall(function()
TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, player)
end)
if not ok then
setStatus("Teleport failed: " .. tostring(err))
end
end)
end
local busy = false
local lastServers = nil
local lastCursor = nil
local function refreshList()
if busy then return end
busy = true
setStatus("Loading servers...")
clearList()
local servers, err, nextCursor = fetchServers(function(attempt, wait)
setStatus(("Rate limited, retrying in %ds (attempt %d)..."):format(math.ceil(wait), attempt))
end)
if not servers then
setStatus(err or "Error")
elseif #servers == 0 then
lastServers, lastCursor = servers, nextCursor
setStatus("No servers found.")
else
lastServers, lastCursor = servers, nextCursor
local shown = {}
for _, sv in ipairs(servers) do
if inRange(sv) then shown[#shown + 1] = sv end
end
if #shown > 0 then
setStatus(("Showing %d servers, ping %d-%d (lowest first)"):format(#shown, MIN_PING, MAX_PING))
else
shown = servers
setStatus(("None with 1-4 players and ping %d-%d, showing all %d"):format(MIN_PING, MAX_PING, #servers))
end
for _, s in ipairs(shown) do addRow(s) end
end
busy = false
return servers
end
local listLoaded = false
toggleBrowser = function()
if main.Visible then
closeSrv()
return
end
if env.__menuClose then env.__menuClose() end
chipsExtra = 0
pickPanel.Visible = false
main.Visible = true
env.__srvMin = 215
relayout()
if main.Visible and not listLoaded then
listLoaded = true
task.spawn(refreshList)
end
end
local badServers = {}
local joinToken = 0
local function autoJoin(force, preloaded, alwaysLeave)
if joining then return end
if not force and #Players:GetPlayers() <= STAY_IF_PLAYERS_MAX then
setStatus("Auto: already in a low server, staying.")
return
end
local leave = (alwaysLeave ~= false)
lastLeave = leave
joining = true
env.__joinStarted = os.time()
joinToken += 1
local myToken = joinToken
task.spawn(function()
local servers = preloaded
local cursor = lastCursor
local forceFresh = false
local freshOnce = env.__hopFresh
env.__hopFresh = nil
if freshOnce then cursor = nil end
while isCurrent() do
if joinToken ~= myToken then
return
end
if not autoOn then
setStatus("Auto: stopped.")
joining = false
return
end
if (#getAlts() == 0) or (not leave and not shouldHop()) then
setStatus("Hop stopped: no alts in this server.")
joining = false
return
end
if not (servers and #servers > 0) then
setStatus("Auto: getting a new list...")
local err, nextCursor
servers, err, nextCursor = fetchServers(function(attempt, wait)
setStatus(("Auto: rate limited, retry in %ds..."):format(math.ceil(wait)))
end, cursor, freshOnce and -1 or (forceFresh and 15 or nil))
forceFresh, freshOnce = false, false
if not servers then
setStatus((err or "Auto: failed to load servers") .. " Retrying in 8s...")
task.wait(8)
cursor = nil
continue
end
cursor = nextCursor
if #servers == 0 then
setStatus("Auto: no servers returned, getting a new list...")
task.wait(0.5 + math.random() * 0.5)
continue
end
end
local cands = {}
for _, s in ipairs(servers) do
if not badServers[s.id] then table.insert(cands, s) end
end
local function tier(c)
return c.ping and 0 or 1
end
table.sort(cands, function(a, b)
local ta, tb = tier(a), tier(b)
if ta ~= tb then return ta < tb end
local pa, pb = a.ping or math.huge, b.ping or math.huge
if pa ~= pb then return pa < pb end
return (a.playing or 0) < (b.playing or 0)
end)
while #cands > 0 do
if hasFS then
local claims = readClaims()
local free = {}
for _, c in ipairs(cands) do
if not takenByOthers(claims, c.id) then free[#free + 1] = c end
end
cands = free
if #cands == 0 then break end
end
local nBest = 0
do
local t0 = tier(cands[1])
for _, c in ipairs(cands) do
if tier(c) == t0 then nBest += 1 else break end
end
end
local idx = math.random(1, math.min(6, nBest))
local s = table.remove(cands, idx)
if tryClaim(s.id) then
if (#getAlts() == 0) or (not leave and not shouldHop()) then
writeClaim(s.id, "r")
setStatus("Hop stopped: no alts in this server.")
joining = false
return
end
setStatus(("Auto: joining %d-player server (%s ms)..."):format(s.playing or 0, tostring(s.ping)))
pendingJob = s.id
writeClaim(game.JobId, "r")
local ok = pcall(function()
TeleportService:TeleportToPlaceInstance(PLACE_ID, s.id, player)
end)
if ok then
task.delay(25, function()
if joinToken == myToken and joining then
joining = false
if autoOn and isCurrent() and (HOP_MODE ~= "manual" or os.time() - (env.__manualHop or 0) <= 90) then
setStatus("Auto: teleport didn't go through, retrying...")
autoJoin(true, nil, leave)
end
end
end)
return
end
badServers[s.id] = true
env.__markBad(s.id)
writeClaim(s.id, "r")
end
end
setStatus("Auto: no free server in this list, getting a new one...")
badServers = {}
servers = nil
forceFresh = true
cursor = nil
task.wait(0.1)
end
end)
end
track(TeleportService.TeleportInitFailed:Connect(function(plr)
if plr ~= player then return end
if not pendingJob then return end
for _ = 1, 5 do
dismissErrorPrompt()
task.wait(0.1)
end
if pendingJob then
badServers[pendingJob] = true
env.__markBad(pendingJob)
writeClaim(pendingJob, "r")
local row = rowsById[pendingJob]
if row then row:Destroy() end
pendingJob = nil
end
joining = false
local requested = (HOP_MODE ~= "manual") or (os.time() - (env.__manualHop or 0) <= 90)
pendingJob = nil
if autoOn and requested then
setStatus("Server full/unavailable. Auto: trying another...")
task.wait(0.02)
autoJoin(true, nil, lastLeave)
else
setStatus("Server full or unavailable. Pick another or hit Refresh.")
end
end))
local function updateAutoBtn()
autoBtn.Text = autoOn and "Auto: ON" or "Auto: OFF"
autoBtn.BackgroundColor3 = autoOn and Color3.fromRGB(40, 130, 255) or Color3.fromRGB(40, 60, 100)
end
autoBtn.MouseButton1Click:Connect(function()
autoOn = not autoOn
updateAutoBtn()
if autoOn and HOP_MODE == "low" then
autoJoin(false, lastServers)
end
end)
refreshBtn.MouseButton1Click:Connect(refreshList)
closeBtn.MouseButton1Click:Connect(closeSrv)
updateAutoBtn()
autoBtn.Visible = (HOP_MODE ~= "manual")
hopBtn.Activated:Connect(function()
if os.clock() - (env.__hopTap or -100) < 5 then
return
end
if joining then
if os.time() - (env.__joinStarted or os.time()) <= 90 then
return
end
joinToken += 1
joining = false
pendingJob = nil
end
env.__hopTap = os.clock()
autoOn = true
updateAutoBtn()
env.__manualHop = os.time()
hopBtn.Text = "Hopping..."
env.__hopFresh = true
autoJoin(true, nil, true)
refresh()
end)
do
local HIDE_FILE = "AccountUIHidden_" .. player.UserId .. ".txt"
local hideBtn = Instance.new("TextButton")
hideBtn.Name = "HideUI"
hideBtn.ZIndex = 5
hideBtn.AnchorPoint = Vector2.new(1, 0)
hideBtn.Size = UDim2.new(0, 22, 0, 16)
hideBtn.Position = UDim2.new(1, -8, 0, 5)
hideBtn.BackgroundColor3 = Color3.fromRGB(24, 58, 130)
hideBtn.BorderSizePixel = 0
hideBtn.Text = "-"
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.TextSize = 14
hideBtn.Font = Enum.Font.GothamBold
hideBtn.Parent = frame
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 4)
local showTab = Instance.new("TextButton")
showTab.Name = "ShowUI"
showTab.ZIndex = 10
showTab.AnchorPoint = Vector2.new(1, 0)
showTab.Size = UDim2.new(0, 30, 0, 20)
showTab.Position = UDim2.new(1, -6, 0, 6)
showTab.BackgroundColor3 = Color3.fromRGB(24, 58, 130)
showTab.BackgroundTransparency = 0.15
showTab.BorderSizePixel = 0
showTab.Text = "UI"
showTab.TextColor3 = Color3.new(1, 1, 1)
showTab.TextSize = 12
showTab.Font = Enum.Font.GothamBold
showTab.Visible = false
showTab.Parent = screenGui
Instance.new("UICorner", showTab).CornerRadius = UDim.new(0, 5)
local function setHidden(h)
frame.Visible = not h
if h then
closeSrv()
timePanel.Visible = false
end
showTab.Visible = h
if hasFS then
pcall(writefile, HIDE_FILE, h and "1" or "0")
end
end
hideBtn.Activated:Connect(function()
setHidden(true)
end)
showTab.Activated:Connect(function()
setHidden(false)
end)
if hasFS then
local ok, v = pcall(function()
return isfile(HIDE_FILE) and readfile(HIDE_FILE) or "0"
end)
if ok and v == "1" then
setHidden(true)
end
end
local START_HIDDEN = false
if START_HIDDEN then setHidden(true) end
end
if httpRequest then
if HOP_MODE == "alts" then
task.spawn(function()
task.wait(START_DELAY)
local altStreak = 0
while isCurrent() do
if joining and os.time() - (env.__joinStarted or os.time()) > 75 then
joining = false
joinToken += 1
end
if autoOn and not joining and shouldHop() then
altStreak += 1
if altStreak >= 2 then
altStreak = 0
autoJoin(true, nil, false)
else
hopNote = hopNote .. " (confirming...)"
end
else
altStreak = 0
if not autoOn then
hopNote = "Auto is OFF (turn it on in the Srv panel)"
end
end
task.wait(CHECK_INTERVAL)
end
end)
elseif HOP_MODE == "low" then
task.spawn(function()
task.wait(math.random() * 1.5)
if autoOn and isCurrent() then
autoJoin(false)
end
end)
end
end
print("Full JobId:", game.JobId, "| PlaceId:", game.PlaceId)
local dragging = false
local dragInput
local dragStart
local startPos
local function update(input)
local delta = input.Position - dragStart
frame.Position = UDim2.new(
startPos.X.Scale, startPos.X.Offset + delta.X,
startPos.Y.Scale, startPos.Y.Offset + delta.Y
)
end
frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
frame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)
track(UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
update(input)
end
end))
do
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local PINK = Color3.fromRGB(60, 205, 255)
local PURPLE = Color3.fromRGB(40, 110, 255)
local WHITE = Color3.new(1, 1, 1)
env.__themeMix = 0
local T = {
mix = 0, last = -1, lastRun = nil,
c1 = PINK, acc = Color3.fromRGB(40, 130, 255), acc2 = Color3.fromRGB(70, 215, 255), idle = Color3.fromRGB(80, 112, 155),
B = {
c1 = PINK, c2 = PURPLE,
bg1 = Color3.fromRGB(14, 32, 74), bg2 = Color3.fromRGB(5, 12, 30),
pbg1 = Color3.fromRGB(12, 28, 64), pbg2 = Color3.fromRGB(5, 11, 26),
avatarBg = Color3.fromRGB(16, 36, 78), timerBg = Color3.fromRGB(5, 12, 30),
nameFade = Color3.fromRGB(150, 220, 255), titleC = Color3.fromRGB(170, 228, 255),
btn = Color3.fromRGB(24, 58, 130), btn2 = Color3.fromRGB(40, 100, 220),
accent = Color3.fromRGB(40, 130, 255), accent2 = Color3.fromRGB(70, 215, 255), hstroke = Color3.fromRGB(190, 238, 255),
star1 = Color3.fromRGB(190, 238, 255), star2 = Color3.fromRGB(150, 205, 255),
bubble = Color3.fromRGB(170, 225, 255), shoot = Color3.fromRGB(210, 240, 255),
fill = Color3.fromRGB(80, 190, 255), idle = Color3.fromRGB(80, 112, 155),
startRun = Color3.fromRGB(30, 150, 230), startIdle = Color3.fromRGB(40, 110, 235),
},
R = {
c1 = Color3.fromRGB(255, 110, 100), c2 = Color3.fromRGB(215, 35, 55),
bg1 = Color3.fromRGB(78, 16, 24), bg2 = Color3.fromRGB(30, 6, 10),
pbg1 = Color3.fromRGB(66, 14, 22), pbg2 = Color3.fromRGB(26, 5, 9),
avatarBg = Color3.fromRGB(78, 22, 32), timerBg = Color3.fromRGB(30, 6, 10),
nameFade = Color3.fromRGB(255, 170, 170), titleC = Color3.fromRGB(255, 190, 190),
btn = Color3.fromRGB(130, 28, 44), btn2 = Color3.fromRGB(200, 45, 55),
accent = Color3.fromRGB(225, 50, 60), accent2 = Color3.fromRGB(255, 110, 100), hstroke = Color3.fromRGB(255, 200, 200),
star1 = Color3.fromRGB(255, 205, 200), star2 = Color3.fromRGB(255, 150, 150),
bubble = Color3.fromRGB(255, 170, 160), shoot = Color3.fromRGB(255, 220, 215),
fill = Color3.fromRGB(255, 90, 90), idle = Color3.fromRGB(160, 95, 100),
startRun = Color3.fromRGB(215, 60, 70), startIdle = Color3.fromRGB(225, 50, 60),
},
}
local function grad(parent, a, b, rot)
local g = Instance.new("UIGradient")
g.Color = ColorSequence.new(a, b)
g.Rotation = rot or 0
g.Parent = parent
return g
end
local function outline(parent, color, thickness, transparency)
local st = Instance.new("UIStroke")
st.Color = color
st.Thickness = thickness
st.Transparency = transparency or 0
st.Parent = parent
return st
end
frame.BackgroundColor3 = WHITE
T.frameG = grad(frame, Color3.fromRGB(14, 32, 74), Color3.fromRGB(5, 12, 30), 90)
main.BackgroundColor3 = WHITE
T.mainG = grad(main, Color3.fromRGB(12, 28, 64), Color3.fromRGB(5, 11, 26), 90)
timePanel.BackgroundColor3 = WHITE
T.panelG = grad(timePanel, Color3.fromRGB(12, 28, 64), Color3.fromRGB(5, 11, 26), 90)
T.mainSt = outline(main, PURPLE, 1.5, 0.3)
T.panelSt = outline(timePanel, PURPLE, 1.5, 0.3)
stroke.Color = WHITE
local strokeG = grad(stroke, PINK, PURPLE, 0)
avatarStroke.Color = WHITE
avatarStroke.Thickness = 2.5
local avatarG = grad(avatarStroke, PINK, PURPLE, 0)
avatar.BackgroundColor3 = Color3.fromRGB(16, 36, 78)
timerStroke.Color = WHITE
timerStroke.Transparency = 0.3
local timerG = grad(timerStroke, PINK, PURPLE, 0)
timerLabel.BackgroundColor3 = Color3.fromRGB(5, 12, 30)
local nameG = grad(nameLabel, WHITE, Color3.fromRGB(150, 220, 255), 0)
title.TextColor3 = Color3.fromRGB(170, 228, 255)
timePanelTitle.TextColor3 = Color3.fromRGB(170, 228, 255)
status.TextColor3 = Color3.fromRGB(160, 198, 240)
for _, b in ipairs({ listBtn, timeBtn }) do
b.BackgroundColor3 = Color3.fromRGB(24, 58, 130)
outline(b, PURPLE, 1, 0.45)
end
resetBtn.BackgroundColor3 = Color3.fromRGB(190, 55, 80)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 85)
timeCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 85)
local startBg = Instance.new("Frame")
startBg.Name = "StartBg"
startBg.ZIndex = 2
startBg.Size = startMainBtn.Size
startBg.Position = startMainBtn.Position
startBg.BackgroundColor3 = WHITE
startBg.BorderSizePixel = 0
startBg.Parent = frame
Instance.new("UICorner", startBg).CornerRadius = UDim.new(0, 6)
grad(startBg, PINK, PURPLE, 0)
startMainBtn.BackgroundTransparency = 1
startBg.Visible = startMainBtn.Visible
startMainBtn:GetPropertyChangedSignal("Visible"):Connect(function()
startBg.Visible = startMainBtn.Visible
end)
local rng = Random.new()
local stars = {}
for i = 1, 30 do
local sz = (i % 4 == 0) and 3 or 2
local st = Instance.new("Frame")
st.Size = UDim2.fromOffset(sz, sz)
st.Position = UDim2.new(rng:NextNumber(), 0, 0, rng:NextInteger(2, 120))
st.BackgroundTransparency = 0.2 + 0.7 * rng:NextNumber()
st.BackgroundColor3 = (i % 2 == 0) and Color3.fromRGB(190, 238, 255) or Color3.fromRGB(150, 205, 255)
st.BorderSizePixel = 0
st.ZIndex = 1
st.Parent = frame
Instance.new("UICorner", st).CornerRadius = UDim.new(1, 0)
stars[i] = { obj = st, phase = rng:NextNumber() * 6.28, speed = 1 + rng:NextNumber() * 2,
x = rng:NextNumber(), y = rng:NextInteger(3, 84), vx = 0.02 + rng:NextNumber() * 0.05, bob = 2 + rng:NextNumber() * 3 }
end
frame.ClipsDescendants = true
local waveBars = {}
local WAVE_N = 0
for i = 1, WAVE_N do
local bar = Instance.new("Frame")
bar.ZIndex = 1
bar.AnchorPoint = Vector2.new(0, 1)
bar.Size = UDim2.new(1 / WAVE_N, -1, 0, 3)
bar.Position = UDim2.new((i - 1) / WAVE_N, 0, 1, -3)
bar.BackgroundColor3 = (i % 2 == 0) and PINK or PURPLE
bar.BackgroundTransparency = 0.35
bar.BorderSizePixel = 0
bar.Parent = frame
waveBars[i] = bar
end
local bubbles = {}
for i = 1, 0 do
local bsz = 3 + (i % 3)
local bb = Instance.new("Frame")
bb.ZIndex = 1
bb.Size = UDim2.fromOffset(bsz, bsz)
bb.BackgroundColor3 = Color3.fromRGB(170, 225, 255)
bb.BorderSizePixel = 0
bb.Parent = frame
Instance.new("UICorner", bb).CornerRadius = UDim.new(1, 0)
bubbles[i] = { obj = bb, x = rng:NextNumber(), sp = 0.12 + rng:NextNumber() * 0.2, ph = rng:NextNumber(), sway = 0.01 + rng:NextNumber() * 0.02 }
end
local shoot = Instance.new("Frame")
shoot.ZIndex = 2
shoot.Size = UDim2.fromOffset(26, 2)
shoot.Rotation = 22
shoot.BackgroundColor3 = Color3.fromRGB(210, 240, 255)
shoot.BorderSizePixel = 0
shoot.Visible = false
shoot.Parent = frame
local shootG = Instance.new("UIGradient")
shootG.Transparency = NumberSequence.new(1, 0)
shootG.Parent = shoot
local dot = Instance.new("Frame")
dot.Name = "StatusDot"
dot.ZIndex = 3
dot.Size = UDim2.fromOffset(8, 8)
dot.Position = UDim2.new(1, -38, 0, 9)
dot.BackgroundColor3 = Color3.fromRGB(80, 112, 155)
dot.BorderSizePixel = 0
dot.Parent = frame
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
T.apply = function(m)
local B, R = T.B, T.R
local function mx(k)
return B[k]:Lerp(R[k], m)
end
local c1, c2 = mx("c1"), mx("c2")
T.c1, T.acc, T.acc2, T.idle = c1, mx("accent"), mx("accent2"), mx("idle")
T.frameG.Color = ColorSequence.new(mx("bg1"), mx("bg2"))
T.mainG.Color = ColorSequence.new(mx("pbg1"), mx("pbg2"))
T.panelG.Color = ColorSequence.new(mx("pbg1"), mx("pbg2"))
T.mainSt.Color = c2
T.panelSt.Color = c2
strokeG.Color = ColorSequence.new(c1, c2)
avatarG.Color = ColorSequence.new(c1, c2)
timerG.Color = ColorSequence.new(c1, c2)
nameG.Color = ColorSequence.new(WHITE, mx("nameFade"))
avatar.BackgroundColor3 = mx("avatarBg")
timerLabel.BackgroundColor3 = mx("timerBg")
timerFill.BackgroundColor3 = mx("fill")
title.TextColor3 = mx("titleC")
timePanelTitle.TextColor3 = mx("titleC")
listBtn.BackgroundColor3 = mx("btn")
timeBtn.BackgroundColor3 = mx("btn")
refreshBtn.BackgroundColor3 = mx("btn2")
hoursBtn.BackgroundColor3 = T.acc
hoursStroke.Color = mx("hstroke")
startBtn.BackgroundColor3 = running and mx("startRun") or mx("startIdle")
for i, bar in ipairs(waveBars) do
bar.BackgroundColor3 = (i % 2 == 0) and c1 or c2
end
local s1, s2 = mx("star1"), mx("star2")
for i, st in ipairs(stars) do
st.obj.BackgroundColor3 = (i % 2 == 0) and s1 or s2
end
local bc = mx("bubble")
for _, b in ipairs(bubbles) do
b.obj.BackgroundColor3 = bc
end
shoot.BackgroundColor3 = mx("shoot")
paintChips()
end
local t = 0
T.fxAcc = 0
track(RunService.RenderStepped:Connect(function(dt)
T.fxAcc += dt
if T.fxAcc < 0.05 then return end
dt = T.fxAcc
T.fxAcc = 0
t += dt
local want = ((not needPick) and total >= targetH * 3600) and 1 or 0
local m = T.mix
if m ~= want then
m = want
if math.abs(want - m) < 0.01 then m = want end
T.mix = m
end
env.__themeMix = m
if pickPanel.Visible then
pickStroke.Transparency = 0.3
end
if m ~= T.last or running ~= T.lastRun then
T.last, T.lastRun = m, running
T.apply(m)
end
if m > 0 then
local base = T.B.bg1:Lerp(T.R.bg1, m)
local glow = base:Lerp(Color3.fromRGB(140, 30, 42), 0.4 * m * 0.5)
T.frameG.Color = ColorSequence.new(glow, T.B.bg2:Lerp(T.R.bg2, m))
end
if hopBtn.Visible then
hopBtn.BackgroundColor3 = T.acc
end
if running then
dot.BackgroundColor3 = T.c1
dot.BackgroundTransparency = 0.2
else
dot.BackgroundColor3 = T.idle
dot.BackgroundTransparency = 0.25
end
end))
for _, f in ipairs({ frame, main, timePanel }) do
local u = Instance.new("UIScale")
u.Scale = UI_SCALE
u.Parent = f
end
render()
end
print("[ServerHop] 2/2 whole file loaded")
