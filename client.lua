-- https://store.17mov.pro/ --
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
        local sleep = 100
        
        if GetSelectedPedWeapon(PlayerPedId()) == 100416529 then
            sleep = 0
            ShowHudComponentThisFrame(14)
        end
        
        if ShootingMode == 1 then
            if GetSelectedPedWeapon(PlayerPedId()) ~= 100416529 then
                HideHudComponentThisFrame(14)
            end
            SetFollowPedCamViewMode(4)
        else
            if GetSelectedPedWeapon(PlayerPedId()) ~= 100416529 then
                break
            end
        end

        Citizen.Wait(sleep)
    end
    if ShootingMode == 1 then
        SetFollowPedCamViewMode(2)
    end
end)

RegisterKeyMapping("aiming", "Muda a perspectiva de tiro ao mirar", "MOUSE_BUTTON", "MOUSE_RIGHT")

local table = {[1] = 3, [3] = 1} -- Convert first to third, and third to first

RegisterCommand(Config.CommandString, function()
    ShootingMode = table[ShootingMode]
    ShowNotification()
    SetResourceKvpInt("perspective", ShootingMode)
end)

-- https://store.17mov.pro/ --
