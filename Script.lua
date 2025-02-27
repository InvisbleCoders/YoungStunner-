-- Load required libraries
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- Function to deal insane damage
local function fuckUpIceAdmiral()
    local iceAdmiral = workspace:FindFirstChild("Ice Admiral")
    if iceAdmiral then
        local humanoid = iceAdmiral:FindFirstChild("Humanoid")
        if humanoid then
            while humanoid.Health > 0 do
                local args = {
                    [1] = "Ice Admiral",
                    [2] = math.huge, -- Insane damage
                    [3] = false
                }
                ReplicatedStorage.Remotes.Damage:FireServer(unpack(args))
                wait(0.1) -- Adjust delay to avoid detection
            end
        end
    end
end

-- Function to hop servers
local function hopServer()
    local serverList = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    for _, server in pairs(serverList.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id)
            break
        end
    end
end

-- Main execution
fuckUpIceAdmiral()
wait(5) -- Wait for the boss to die
hopServer()
