local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local servers = {}
local req = request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
local body = HttpService:JSONDecode(req.Body)

function GetServers() 
for i, v in next, body.data do
        if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
        table.insert(servers, 1, v.id)
    end
end
end

function Hop()
if #servers > 0 then
TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
end
end 


if #servers <= 0 then 
wait(5)
GetServers()
Hop()
return
end



queue_on_teleport('print("Harvox")')
GetServers()
Hop()
