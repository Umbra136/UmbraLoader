# UmbraLoader

Loader for the Umbra script (Roblox). The script file in this repo holds no keys.

## Use

This repo is private. Put this in the executor (or its autoexec folder). Fill in your own keys:

```lua
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
```

- `GITHUB_TOKEN` is a fine-grained token with read-only access to this repo (Contents: Read-only).
- `script_key` is passed on to the 2nd script (BFLoader) when an account is alone in its server.
- `UmbraKey` is the tracker key. Instead of the second line you can save it alone in a file named `UmbraKey.txt` in the executor workspace folder.

`loader.example.lua` is the same thing as a file.

## Files

- `UmbraScript.lua` the script (no keys inside)
- `loader.example.lua` the two-line loader with placeholders
