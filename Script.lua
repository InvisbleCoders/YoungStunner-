-- Configuration
local highChestOnly = true -- Set to true to only target high-value chests
local teleportDelay = 1 -- Delay between teleport attempts (in seconds)

-- Function to find and teleport to chests
local function teleportToChest()
    while true do
        task.wait(teleportDelay) -- Wait for the specified delay

        -- Check if the player's character exists
        if not game.Players.LocalPlayer.Character then
            continue
        end

        -- Find chests in the workspace
        local chests = {}
        if highChestOnly then
            -- Add high-value chest names here
            chests = {
                "HighChest",
                "LegendaryChest",
                "EpicChest"
            }
        else
            -- Add all chest names here
            chests = {
                "Chest",
                "HighChest",
                "LegendaryChest",
                "EpicChest"
            }
        end

        -- Search for chests in the workspace
        local targetChest = nil
        for _, chestName in pairs(chests) do
            targetChest = game.Workspace:FindFirstChild(chestName)
            if targetChest then
                break
            end
        end

        -- Teleport to the chest if found
        if targetChest then
            game.Players.LocalPlayer.Character:PivotTo(targetChest:GetPivot())
            firesignal(targetChest.Touched, game.Players.LocalPlayer.Character.HumanoidRootPart)
        else
            warn("No chest found. Retrying...")
        end
    end
end

-- Start the teleportation process
teleportToChest()
