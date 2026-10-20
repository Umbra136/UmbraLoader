if not game:IsLoaded() then game.Loaded:Wait() end
getgenv().script_key = "YOUR_2ND_SCRIPT_KEY" ; script_key = "YOUR_2ND_SCRIPT_KEY" ;
getgenv().UmbraKey = "YOUR_TRACKER_KEY" ;
loadstring(request({Url="https://raw.githubusercontent.com/Umbra136/UmbraLoader/main/UmbraScript.lua",Headers={Authorization="Bearer YOUR_GITHUB_TOKEN"}}).Body)()
