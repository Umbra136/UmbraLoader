getgenv().GithubToken = "PASTE_YOUR_GITHUB_TOKEN_HERE"
loadstring(request({Url="https://raw.githubusercontent.com/Umbra136/UmbraLoader/main/ServerPicker.lua",Headers={Authorization="Bearer "..getgenv().GithubToken}}).Body)()
