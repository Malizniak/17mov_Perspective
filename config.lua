-- https://store.17mov.pro/ --

Config = {}

Config.DefaultShootingMode = 1      -- 1 => First Person, 3 => Third Person
Config.CommandString = "perspective"

function ShowNotification()
    SetNotificationTextEntry('STRING')
	AddTextComponentString("Perspective Changed!")
	DrawNotification(0,1)

-- 	TriggerEvent("QBCore:Notify", "Perspective Changed!", "success")
end

-- https://store.17mov.pro/ --

