-- https://dev-cloud.pl --

local PlayersData, scriptReady = {}, false
MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM perspectives')
	for k,v in pairs(result) do
		PlayersData[v.identifier] = {mode = v.perspective, changed = false}
	end
	scriptReady = true
end)

RegisterServerEvent('DevCloud_Perspective:RequestMyMode')
AddEventHandler('DevCloud_Perspective:RequestMyMode', function()
	while not scriptReady do
		Citizen.Wait(10)
	end
	local identifier = GetIdentifier(source)
	if PlayersData[identifier] == nil then
		PlayersData[identifier] = {mode = Config.DefaultShootingMode, changed = true}
		CreateThisClient(identifier)
	end
	TriggerClientEvent("DevCloud_Perspective:SendModeToClient", source, PlayersData[identifier].mode)
end)

RegisterNetEvent("DevCloud_Perspective:UpdateMyMode")
AddEventHandler("DevCloud_Perspective:UpdateMyMode", function(mode)
	local identifier = GetIdentifier(source)
	PlayersData[identifier].mode = mode
	PlayersData[identifier].changed = true
end)

function CreateThisClient(identifier)
	local ShootingMode = PlayersData[identifier].mode
	MySQL.Async.execute('INSERT INTO perspectives (identifier, perspective) VALUES (@id, @mode)', {
		['@id'] = identifier,
		['@mode'] = ShootingMode
	})
end

AddEventHandler("playerDropped", function()
	local source = 1 
	local identifier = GetIdentifier(source)
	print(identifier, PlayersData[identifier].changed)
	if PlayersData[identifier].changed then
		PlayersData[identifier].changed = false
		MySQL.Async.execute('UPDATE Perspectives SET perspective = @mode WHERE identifier = @id', {
			['@id'] = identifier,
			['@mode'] = PlayersData[identifier].mode
		})
	end
end)
  
function GetIdentifier(source)
    local identifier
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v, Config.UsingIdentifier) then
            identifier = v
            break
        end
    end
    return identifier
end

-- https://dev-cloud.pl --
