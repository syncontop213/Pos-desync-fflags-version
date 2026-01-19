local networkFlags = {
    PhysicsSenderMaxBandwidthBps = "20000",
    S2PhysicsSenderRate = "15000",
    ServerMaxBandwith = "20",
    MaxTimestepMultiplierAcceleration = "2147483647",
    InterpolationFrameVelocityThresholdMillionth = "5",
    GameNetDontSendRedundantNumTimes = "1",
    MaxFrameSendMultiplierAcceleration = "2147483647",
    InterpolationFrameTimeMaxAcceleration = "1",
    InterpolationFrameTimeWindow = "2147483647",
    InterpolationFrameTimeWindowMultiplier = "2147483647",
    InterpolationWindowDelayMillis = "2000",
    InterpolationWindowMinDelay = "2147483647",
    InterpolationWindowServerPosAdjPercent = "0",
    InterpolationWindowServerVelAdjPercent = "0",
    InterpolationWindowVelocityMultiplier = "0",
    NetworkMaxReceiveKBps = "0",
    NextGenReplicatorEnabledWrite4 = "true",
    MaxPhysicsSpeedSq = "9999999999",
    MinorTimeCorrectionsEnabled = "false"
}

-- apply flags
local function applyFlags()
    for name, value in pairs(networkFlags) do
        pcall(setfflag, name, value)
    end
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- reset
local function respawn()
    local char = player.Character
    local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local oldPos = root and root.CFrame
    local oldCam = Workspace.CurrentCamera.CFrame

    if humanoid then
        humanoid.Health = 0
    end

    task.wait(0.05)
    player:LoadCharacter()

    task.spawn(function()
        local newChar = player.CharacterAdded:Wait()
        local newRoot = newChar:WaitForChild("HumanoidRootPart", 5)
        if newRoot and oldPos then
            newRoot.CFrame = oldPos
        end
        Workspace.CurrentCamera.CFrame = oldCam
    end)
end

applyFlags()
task.wait(0.2)
respawn()
