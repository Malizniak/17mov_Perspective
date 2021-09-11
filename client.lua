-- https://dev-cloud.pl --

ShootingMode = 3
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

RegisterKeyMapping("aiming", "Zmiana Perspektywy Podczas Celowania", "MOUSE_BUTTON", "MOUSE_RIGHT")

local table = {[1] = 3, [3] = 1}
RegisterCommand(Config.CommandString, function()
    print(table[ShootingMode])
    ShootingMode = table[ShootingMode]
    SetNotificationTextEntry('STRING')
	AddTextComponentString("Zmieniono Perspektywe Celowania")
	DrawNotification(0,1)
    TriggerServerEvent("DevCloud_Perspective:UpdateMyMode", ShootingMode)
end)

RegisterNetEvent("DevCloud_Perspective:SendModeToClient")
AddEventHandler("DevCloud_Perspective:SendModeToClient", function(mode)
    ShootingMode = mode
end)

TriggerServerEvent("DevCloud_Perspective:RequestMyMode")

-- https://dev-cloud.pl --
