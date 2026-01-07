local activeMessages = {} -- messages per player

-----------------------------------------------------------
--[[ Commands  ]]--
-----------------------------------------------------------

Citizen.CreateThread(function()
    TriggerEvent("chat:addSuggestion", "/" .. Config.Command, Config.CommandSuggestion, { { name = 'text', help = Config.CommandActionText } } )
end)

-- /me command
RegisterCommand(Config.Command, function(source, args)

    local text = table.concat(args, ' ')

    if text ~= '' then
        TriggerServerEvent('tpz_3dme:server:display', text)
    end

end)

-----------------------------------------------------------
--[[ Events  ]]--
-----------------------------------------------------------

-- Receive message from server
RegisterNetEvent('tpz_3dme:client:display')
AddEventHandler('tpz_3dme:client:display', function(data)
    local serverId = data[2]
    local text = data[1]

    if activeMessages[data.source] == nil then
        activeMessages[data.source] = {}
    end

	table.insert(activeMessages[data.source], {
		source  = data.source,
		time    = tostring(data.time),
		text    = data.text,
    })

end)

RegisterNetEvent('tpz_3dme:client:remove')
AddEventHandler('tpz_3dme:client:remove', function(data)

    if activeMessages[data.source] == nil then
        return
    end


	for index, message in pairs (activeMessages[data.source]) do 

		if tostring(data.time) == tostring(message.time) then 
			table.remove(activeMessages[data.source], index)
        end

    end

end)

-----------------------------------------------------------
--[[ Threads  ]]--
-----------------------------------------------------------

-- MAIN DRAW THREAD
Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerPed = PlayerPedId()
        local myCoords = GetEntityCoords(playerPed)

        for serverId, messages in pairs(activeMessages) do
            local player = GetPlayerFromServerId(serverId)

            if player ~= -1 then
                local ped = GetPlayerPed(player)
                local pedCoords = GetEntityCoords(ped)
                local dist = #(myCoords - pedCoords)

                if dist < Config.DisplayDistance then
                    for i = #messages, 1, -1 do
                        local msg = messages[i]

                        local zOffset = 0.3 + ((i - 1) * 0.15)

                        if not Citizen.InvokeNative(0xD5FE956C70FF370B, playerPed) then
                            zOffset = zOffset + 0.7
                        end

                        DrawText3D(
                            pedCoords.x,
                            pedCoords.y,
                            pedCoords.z + zOffset,
                            msg.text
                        )
       
                    end
                end

                -- Clean empty message tables
                if #messages == 0 then
                    activeMessages[serverId] = nil
                end
            end
        end
    end
    
end)

