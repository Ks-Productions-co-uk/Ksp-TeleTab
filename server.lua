QBCore = exports['qb-core']:GetCoreObject()
--==========================================Creating the usable item==========================================--
QBCore.Functions.CreateUseableItem("teletab", function(source)
    TriggerClientEvent('Ksp-TeleTab:openTeleportMenu', source)
end)

--===============================================Money Handling===============================================--
RegisterNetEvent('Ksp-TeleTab:deductMoney', function(playerId, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        if Player.Functions.RemoveMoney('bank', amount) then
            TriggerClientEvent('QBCore:Notify', src, "Money deducted: $" .. amount, "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Not enough money.", "error")
            -- You could also cancel the teleport here by sending a client event back
        end
    end
end)
