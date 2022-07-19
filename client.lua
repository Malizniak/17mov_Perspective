-- https://devcloud.tebex.io/ --
local ShootingMode
CreateThread(function()
    local savedInfo = GetResourceKvpInt("perspective")
    if savedInfo == 0 then
        SetResourceKvpInt("perspective", Config.DefaultShootingMode)
        ShootingMode = Config.DefaultShootingMode
    else
        ShootingMode = savedInfo
    end
end)

RegisterCommand("aiming", function()
    Citizen.Wait(0)
    while IsPlayerFreeAiming(PlayerId()) or IsControlPressed(0, 25) do
        Citizen.Wait(0)
        if ShootingMode == 1 then
            HideHudComponentThisFrame(14)
            SetFollowPedCamViewMode(4)
        else
            break
        end
    end
    if ShootingMode == 1 then
        SetFollowPedCamViewMode(2)
    end
end)

RegisterKeyMapping("aiming", "Change Shooting Perspective While Aiming", "MOUSE_BUTTON", "MOUSE_RIGHT")

local table = {[1] = 3, [3] = 1} -- Convert first to third, and third to first

RegisterCommand(Config.CommandString, function()
    ShootingMode = table[ShootingMode]
    ShowNotification()
    SetResourceKvpInt("perspective", ShootingMode)
end)

-- https://devcloud.tebex.io/ --
