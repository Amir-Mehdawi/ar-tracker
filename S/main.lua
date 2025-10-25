local QBCore = exports['qb-core']:GetCoreObject()
local trackingCooldowns = {}

QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    local src = source
    TriggerClientEvent('amirtrack:client:openTracker', src)
end)

QBCore.Functions.CreateCallback('amirtrack:server:getPlayerByPhone', function(source, cb, phoneNumber)
    local src = source
    
    if not phoneNumber or phoneNumber == "" then
        cb(nil)
        return
    end
    
    local targetSource = exports["lb-phone"]:GetSourceFromNumber(phoneNumber)
    
    if not targetSource then
        cb(nil)
        return
    end
    
    if not Config.CanTrackSelf then
        local srcPhone = exports["lb-phone"]:GetEquippedPhoneNumber(src)
        if srcPhone == phoneNumber then
            cb({error = "self"})
            return
        end
    end
    
    local identifier = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    if trackingCooldowns[identifier] and (os.time() * 1000) < trackingCooldowns[identifier] then
        cb({error = "cooldown"})
        return
    end
    
    local targetPlayer = QBCore.Functions.GetPlayer(targetSource)
    
    if targetPlayer then
        cb({
            serverId = targetSource,
            citizenid = targetPlayer.PlayerData.citizenid,
            name = targetPlayer.PlayerData.charinfo.firstname .. ' ' .. targetPlayer.PlayerData.charinfo.lastname,
            phoneNumber = phoneNumber
        })
    else
        cb(nil)
    end
end)

RegisterNetEvent('amirtrack:server:requestTracking', function(targetId)
    local src = source
    local targetPlayer = QBCore.Functions.GetPlayer(targetId)
    
    if not targetPlayer then
        TriggerClientEvent('QBCore:Notify', src, Config.Messages.PlayerNotFound, 'error')
        return
    end
    
    local hasPhone = exports["lb-phone"]:HasPhoneItem(targetId)
    
    if not hasPhone then
        TriggerClientEvent('QBCore:Notify', src, Config.Messages.TargetNoPhone, 'error')
        return
    end
    
    TriggerClientEvent('amirtrack:client:defendAgainstTracking', targetId, src)
end)

RegisterNetEvent('amirtrack:server:trackingDefended', function(trackerId)
    TriggerClientEvent('amirtrack:client:trackingFailed', trackerId)
end)

RegisterNetEvent('amirtrack:server:trackingSucceeded', function(trackerId)
    local src = source
    local targetId = src
    
    local trackerPlayer = QBCore.Functions.GetPlayer(trackerId)
    if not trackerPlayer then return end
    
    local identifier = trackerPlayer.PlayerData.citizenid
    trackingCooldowns[identifier] = (os.time() * 1000) + Config.CooldownTime
    
    TriggerClientEvent('amirtrack:client:startTracking', trackerId, targetId)
    TriggerClientEvent('QBCore:Notify', trackerId, Config.Messages.TrackingSuccess, 'success')
    TriggerClientEvent('amirtrack:client:showMyLocation', targetId)
end)

QBCore.Functions.CreateCallback('amirtrack:server:getPlayerCoords', function(source, cb, targetId)
    local targetPed = GetPlayerPed(targetId)
    if targetPed and targetPed > 0 then
        local coords = GetEntityCoords(targetPed)
        cb({x = coords.x, y = coords.y, z = coords.z})
    else
        cb(nil)
    end
end)