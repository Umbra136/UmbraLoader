script_key = "YOUR_2ND_SCRIPT_KEY" ;
getgenv().UmbraKey = "YOUR_TRACKER_KEY"
local GITHUB_TOKEN = "PASTE_YOUR_GITHUB_TOKEN_HERE"
local req = (syn and syn.request) or http_request or request
local res = req({
	Url = "https://raw.githubusercontent.com/Umbra136/UmbraLoader/main/UmbraScript.lua",
	Method = "GET",
	Headers = { Authorization = "Bearer " .. GITHUB_TOKEN },
})
if res and res.StatusCode == 200 and res.Body then
	loadstring(res.Body)()
else
	warn("[Umbra loader] could not download the script: " .. tostring(res and res.StatusCode))
end
