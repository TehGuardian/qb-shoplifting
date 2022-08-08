local QBCore = exports['qb-core']:GetCoreObject()

local GlobalTimer = 0
local completedJob = false
local firstComplete = false
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-shoplifting:doStuff', function(coords)
    local pos = GetEntityCoords(PlayerPedId())
    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then
    streetLabel = streetLabel .. " " .. street2
    end
    local ped = PlayerPedId()

    if CurrentCops >= Config.MinimumShopliftRobberyPolice then
    if GlobalTimer == 0 then
           TriggerServerEvent('police:server:policeAlert', "Someone Is Trying To Shoplift At "..streetLabel)
           exports['qb-ui']:Thermite(function(success)
            if success then
            QBCore.Functions.Progressbar('shopliftbar', 'Shoplifting...', 7000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'mp_take_money_mg',
                anim = 'put_cash_into_bag_loop',
                flags = 16,
            }, {}, {}, function() -- Play When Done
                completedJob = true
                firstComplete = true
                itemToGive = Config.items[math.random(1, #Config.items)]
                TriggerServerEvent('qb-shoplifting:server:RewardItem', itemToGive.item)
                QBCore.Functions.Notify('You Stole ' .. itemToGive.label .. '!', 'success', 5000)
        end, function()
            end)
        else
            QBCore.Functions.Notify("You Failed")
        end
    end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
    else
        QBCore.Functions.Notify('You Already Shoplifted From This Shelf, Wait ' .. GlobalTimer .. ' Seconds Before You Try Again', 'error', 5000)
    end
    else
        QBCore.Functions.Notify('You Need At Least ' .. Config.MinimumShopliftRobberyPolice .. ' Police To Shoplift', 'error', 5000)
    end
end)

CreateThread(function()
    while true do
        if GlobalTimer ~= 0 and GlobalTimer > -1 and firstComplete then 
            Wait(900)
            GlobalTimer = GlobalTimer - 1
        elseif completedJob then
            GlobalTimer = Config.CoolDownTimer
            completedJob = false
        end
        Wait(100)
    end
end)

CreateThread(function()



exports['qb-target']:AddCircleZone("shoplift1", vector3(2734.0, 3492.94, 55.67), 1.2, { 
  name = "shoplift1",
  debugPoly = false,
}, {
  options = {
    {
      type = "client",
      event = "qb-shoplifting:doStuff",
      icon = 'fas fa-eye',
      label = 'What is this?',
    }
  },
  distance = 2.5,
})




exports['qb-target']:AddCircleZone("shoplift2", vector3(2733.17, 3497.46, 55.67), 1.0, {
    name="shoplift2",
    debugPoly=false,
}, {
    options = {
        {
            type = "client",
            event = "qb-shoplifting:doStuff",
            icon = "fas fa-eye",
            label = "What is this?",
        },
    },
    distance = 2.5
})
end)