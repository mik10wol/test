-- Local Script (should be placed in StarterPlayerScripts or StarterCharacterScripts)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local userInputService = game:GetService("UserInputService")

local flying = false
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(0, 0, 0) -- Initially disable movement

local function toggleFlight()
    flying = not flying

    if flying then
        -- Enable flight
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = character.PrimaryPart
        humanoid.PlatformStand = true -- Disable gravity for the character
    else
        -- Disable flight
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = nil
        humanoid.PlatformStand = false -- Re-enable gravity for the character
    end
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Ignore if the game has already processed the input

    if input.KeyCode == Enum.KeyCode.Q then
        toggleFlight()
    end
end)

-- Cleanup on character reset
character:WaitForChild("Humanoid").Died:Connect(function()
    bodyVelocity:Destroy()
end)
