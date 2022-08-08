local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-shoplifting:server:RewardItem', function(itemToGive)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(itemToGive, Config.RandomItemAmount)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[itemToGive], 'add')

end)

RegisterNetEvent('qb-shoplifting:server:sendAlert', function(alertData, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, streetLabel)

end)
