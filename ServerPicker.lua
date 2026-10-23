-- Umbra Server Picker  (standalone - manual)
-- A small window with the servers of the game you are in. Pick one and press Join. Nothing hops by itself.
--   Refresh = new list from Roblox   |   Sort = lowest ping first / fewest players first   |   More = next page   |   X = close
-- Run it again any time to open a fresh window (the old one is removed).

-- ===== SETTINGS =====
local LIMIT = 100                  -- servers to fetch per page (10, 25, 50, 100)
local MIN_PING, MAX_PING = 0, 9999 -- only servers inside this ping range are shown (if none fit, all are shown)
local HIDE_NEARLY_FULL = true      -- hide servers with no room left (they fill up before the teleport lands)
local START_SORT = "ping"          -- "ping" = lowest ping first, "players" = fewest players first
local UI_SCALE = 1                 -- make the window bigger / smaller
-- ====================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId
local httpRequest = (syn and syn.request) or http_request or request or (fluxus and fluxus.request) or (http and http.request)
local env = (getgenv and getgenv()) or _G

-- ===== replace a previous run =====
env.__ServerPickerRun = (env.__ServerPickerRun or 0) + 1
local RUN_ID = env.__ServerPickerRun
if env.__ServerPickerConns then
	for _, c in ipairs(env.__ServerPickerConns) do pcall(function() c:Disconnect() end) end
end
env.__ServerPickerConns = {}
if env.__ServerPickerGui then pcall(function() env.__ServerPickerGui:Destroy() end) end
local function track(c) table.insert(env.__ServerPickerConns, c) return c end
local function isCurrent() return env.__ServerPickerRun == RUN_ID end

-- ===== window =====
local gui = Instance.new("ScreenGui")
gui.Name = "UmbraServerPicker"
gui.ResetOnSpawn = false
gui.DisplayOrder = 2147483647
local parent
pcall(function() parent = gethui and gethui() end)
if not parent then pcall(function() parent = game:GetService("CoreGui") end) end
gui.Parent = parent or player:WaitForChild("PlayerGui")
env.__ServerPickerGui = gui

local frame = Instance.new("Frame")
frame.Name = "Picker"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.fromOffset(280, 340)
frame.BackgroundColor3 = Color3.fromRGB(8, 18, 44)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
do
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(60, 190, 255)
	s.Transparency = 0.35
	s.Thickness = 1.2
	s.Parent = frame
	local sc = Instance.new("UIScale")
	sc.Scale = UI_SCALE
	sc.Parent = frame
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -16, 0, 24)
title.Position = UDim2.fromOffset(10, 2)
title.BackgroundTransparency = 1
title.Text = "Server Picker"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local function makeButton(text, x, w, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(w, 20)
	b.Position = UDim2.fromOffset(x, 28)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.BorderSizePixel = 0
	b.Parent = frame
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end
local refreshBtn = makeButton("Refresh", 8, 58, Color3.fromRGB(40, 100, 220))
local sortBtn = makeButton("Sort: ping", 70, 76, Color3.fromRGB(40, 100, 220))
local moreBtn = makeButton("More", 150, 46, Color3.fromRGB(40, 100, 220))
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(20, 20)
closeBtn.Position = UDim2.new(1, -26, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 10
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 16)
status.Position = UDim2.fromOffset(8, 52)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(170, 190, 220)
status.Font = Enum.Font.Gotham
status.TextSize = 10
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextTruncate = Enum.TextTruncate.AtEnd
status.Parent = frame
local function setStatus(t) status.Text = t end

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -12, 1, -76)
scroll.Position = UDim2.fromOffset(6, 70)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new()
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame
do
	local l = Instance.new("UIListLayout")
	l.Padding = UDim.new(0, 4)
	l.Parent = scroll
end

-- drag the window by its title
do
	local dragging, dragStart, startPos
	title.Active = true
	track(title.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging, dragStart, startPos = true, input.Position, frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end))
	track(UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end))
end

-- ===== servers =====
local sortMode = (START_SORT == "players") and "players" or "ping"
local rowsById = {}
local pendingJob = nil
local loading = false
local cursorStack, currentCursor, nextCursor = {}, nil, nil

local function fetchPage(cursor)
	if not httpRequest then return nil, "No HTTP request function in this executor." end
	local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=%d&excludeFullGames=true"):format(PLACE_ID, LIMIT)
	if cursor then url = url .. "&cursor=" .. cursor end
	for attempt = 1, 5 do
		local ok, res = pcall(function() return httpRequest({ Url = url, Method = "GET" }) end)
		if ok and res and res.Body and res.StatusCode ~= 429 then
			local ok2, parsed = pcall(HttpService.JSONDecode, HttpService, res.Body)
			if ok2 and type(parsed) == "table" and parsed.data then
				local list = {}
				for _, sv in ipairs(parsed.data) do
					table.insert(list, { id = sv.id, playing = sv.playing, maxPlayers = sv.maxPlayers, ping = sv.ping })
				end
				return list, nil, parsed.nextPageCursor
			end
		end
		if attempt < 5 then
			setStatus(("Rate limited, retrying in 2s (attempt %d)..."):format(attempt))
			task.wait(2)
		end
	end
	return nil, "Rate limited. Try Refresh in a few seconds."
end

local function sortList(list)
	table.sort(list, function(a, b)
		if sortMode == "players" then
			local pa, pb = a.playing or 0, b.playing or 0
			if pa ~= pb then return pa < pb end
			return (a.ping or math.huge) < (b.ping or math.huge)
		end
		local pa, pb = a.ping or math.huge, b.ping or math.huge
		if pa ~= pb then return pa < pb end
		return (a.playing or 0) < (b.playing or 0)
	end)
end

local function clearList()
	for _, c in ipairs(scroll:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end
	rowsById = {}
end

local function addRow(server)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -6, 0, 32)
	row.BackgroundColor3 = Color3.fromRGB(18, 38, 84)
	row.BorderSizePixel = 0
	row.Parent = scroll
	rowsById[server.id] = row
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

	local info = Instance.new("TextLabel")
	info.Size = UDim2.new(1, -56, 1, 0)
	info.Position = UDim2.fromOffset(8, 0)
	info.BackgroundTransparency = 1
	info.TextXAlignment = Enum.TextXAlignment.Left
	info.TextColor3 = Color3.new(1, 1, 1)
	info.Font = Enum.Font.Gotham
	info.TextSize = 10
	info.Text = ("%d / %d players  |  %s ms\n%s"):format(
		server.playing or 0, server.maxPlayers or 0,
		server.ping and tostring(server.ping) or "?",
		(server.id or ""):sub(1, 14) .. "...")
	info.Parent = row

	local join = Instance.new("TextButton")
	join.Size = UDim2.fromOffset(42, 22)
	join.Position = UDim2.new(1, -48, 0.5, -11)
	join.BackgroundColor3 = Color3.fromRGB(40, 130, 255)
	join.Text = "Join"
	join.TextColor3 = Color3.new(1, 1, 1)
	join.Font = Enum.Font.GothamBold
	join.TextSize = 11
	join.BorderSizePixel = 0
	join.Parent = row
	Instance.new("UICorner", join).CornerRadius = UDim.new(0, 6)
	join.MouseButton1Click:Connect(function()
		setStatus("Joining server...")
		pendingJob = server.id
		local ok, err = pcall(function() TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, player) end)
		if not ok then setStatus("Teleport failed: " .. tostring(err)) end
	end)
end

local lastList = nil
local function show(list)
	clearList()
	local shown = {}
	for _, sv in ipairs(list) do
		local roomy = not (HIDE_NEARLY_FULL and sv.maxPlayers and sv.playing and sv.playing >= sv.maxPlayers - 1)
		if sv.id ~= game.JobId and roomy then table.insert(shown, sv) end
	end
	local inRange = {}
	for _, sv in ipairs(shown) do
		if sv.ping and sv.ping >= MIN_PING and sv.ping <= MAX_PING then table.insert(inRange, sv) end
	end
	if #inRange > 0 then
		shown = inRange
		setStatus(("%d servers, ping %d-%d (%s first)"):format(#shown, MIN_PING, MAX_PING, sortMode == "ping" and "lowest ping" or "fewest players"))
	elseif #shown > 0 then
		setStatus(("None inside ping %d-%d, showing all %d"):format(MIN_PING, MAX_PING, #shown))
	else
		setStatus("No servers found.")
	end
	sortList(shown)
	for _, sv in ipairs(shown) do addRow(sv) end
end

local function load(cursor)
	if loading then return end
	loading = true
	setStatus("Loading servers...")
	clearList()
	local list, err, nxt = fetchPage(cursor)
	if not isCurrent() then loading = false return end
	if not list then
		setStatus(err or "Error")
	else
		lastList, currentCursor, nextCursor = list, cursor, nxt
		show(list)
		moreBtn.Text = nxt and "More" or "First"
	end
	loading = false
end

refreshBtn.MouseButton1Click:Connect(function() task.spawn(load, nil) end)
moreBtn.MouseButton1Click:Connect(function() task.spawn(load, nextCursor) end)   -- last page -> back to the first one
sortBtn.MouseButton1Click:Connect(function()
	sortMode = (sortMode == "ping") and "players" or "ping"
	sortBtn.Text = "Sort: " .. sortMode
	if lastList then show(lastList) end
end)
closeBtn.MouseButton1Click:Connect(function()
	env.__ServerPickerRun = (env.__ServerPickerRun or 0) + 1
	gui:Destroy()
end)
sortBtn.Text = "Sort: " .. sortMode

-- a failed teleport (server full / unavailable): drop that row and say so
track(TeleportService.TeleportInitFailed:Connect(function(plr)
	if plr ~= player or not pendingJob then return end
	for _ = 1, 5 do
		pcall(function()
			local cg = game:GetService("CoreGui")
			local overlay = cg:FindFirstChild("RobloxPromptGui") and cg.RobloxPromptGui:FindFirstChild("promptOverlay")
			if overlay then
				for _, c in ipairs(overlay:GetChildren()) do
					if c.Name == "ErrorPrompt" then c:Destroy() end
				end
			end
		end)
		task.wait(0.1)
	end
	local row = rowsById[pendingJob]
	if row then row:Destroy() end
	pendingJob = nil
	setStatus("Server full or unavailable. Pick another one.")
end))

task.spawn(load, nil)
print("[ServerPicker] open")
