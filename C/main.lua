local QBCore = exports['qb-core']:GetCoreObject()
local isTracking = false
local trackingThread = nil
local trackingRadius = nil

RegisterNetEvent('amirtrack:client:openTracker', function()
    local myPhone = exports["lb-phone"]:GetEquippedPhoneNumber()
    
    if not myPhone then
        QBCore.Functions.Notify(Config.Messages.NoPhoneEquipped, 'error')
        return
    end

    local input = lib.inputDialog(Config.TrackerDeviceName, {
        {
            type = 'input',
            label = 'Phone Number',
            description = 'Enter target phone number',
            placeholder = '(520)1683069',
            required = true,
            min = 7,
            max = 15
        }
    })

    if not input then return end
    
    local phoneNumber = input[1]
    
    if not phoneNumber or phoneNumber == "" then
        QBCore.Functions.Notify(Config.Messages.InvalidPhone, 'error')
        return
    end
    
    QBCore.Functions.TriggerCallback('amirtrack:server:getPlayerByPhone', function(playerData)
        if not playerData then
            QBCore.Functions.Notify(Config.Messages.PlayerNotFound, 'error')
            return
        end
        
        if playerData.error == "self" then
            QBCore.Functions.Notify(Config.Messages.CannotTrackSelf, 'error')
            return
        end
        
        if playerData.error == "cooldown" then
            QBCore.Functions.Notify(Config.Messages.OnCooldown, 'error')
            return
        end
        
        QBCore.Functions.Notify(Config.Messages.TrackingStarted, 'primary')
        TriggerServerEvent('amirtrack:server:requestTracking', playerData.serverId)
    end, phoneNumber)
end)

RegisterNetEvent('amirtrack:client:defendAgainstTracking', function(trackerId)
    QBCore.Functions.Notify(Config.Messages.BeingTracked, 'error')
    
    exports.minigames:startAlphabetGame(Config.MiniGame.Time, Config.MiniGame.Letters, function(success)
        if success then
            QBCore.Functions.Notify("You successfully defended against tracking!", 'success')
            TriggerServerEvent('amirtrack:server:trackingDefended', trackerId)
        else
            QBCore.Functions.Notify("You failed to defend! You are being tracked!", 'error')
            TriggerServerEvent('amirtrack:server:trackingSucceeded', trackerId)
        end
    end)
end)

RegisterNetEvent('amirtrack:client:startTracking', function(targetId)
    if isTracking then return end
    
    isTracking = true
    local trackingEndTime = GetGameTimer() + Config.TrackingDuration
    
    trackingThread = CreateThread(function()
        while isTracking and GetGameTimer() < trackingEndTime do
            QBCore.Functions.TriggerCallback('amirtrack:server:getPlayerCoords', function(coords)
                if coords then
                    if DoesBlipExist(trackingRadius) then
                        RemoveBlip(trackingRadius)
                    end
                    trackingRadius = AddBlipForRadius(coords.x, coords.y, coords.z, Config.CircleSettings.Radius)
                    SetBlipColour(trackingRadius, 1)
                    SetBlipAlpha(trackingRadius, 128)
                else
                    stopTracking()
                end
            end, targetId)
            
            Wait(Config.UpdateInterval)
        end
        
        stopTracking()
        QBCore.Functions.Notify(Config.Messages.TrackingEnded, 'primary')
    end)
end)

RegisterNetEvent('amirtrack:client:trackingFailed', function()
    QBCore.Functions.Notify(Config.Messages.TrackingFailed, 'error')
end)

RegisterNetEvent('amirtrack:client:showMyLocation', function()
    local playerPed = PlayerPedId()
    local trackingEndTime = GetGameTimer() + Config.TrackingDuration
    
    CreateThread(function()
        local myRadius = nil
        while GetGameTimer() < trackingEndTime do
            local coords = GetEntityCoords(playerPed)
            
            if DoesBlipExist(myRadius) then
                RemoveBlip(myRadius)
            end
            
            myRadius = AddBlipForRadius(coords.x, coords.y, coords.z, Config.CircleSettings.Radius)
            SetBlipColour(myRadius, 1)
            SetBlipAlpha(myRadius, 128)
            
            Wait(Config.UpdateInterval)
        end
        
        if DoesBlipExist(myRadius) then
            RemoveBlip(myRadius)
        end
    end)
end)

function stopTracking()
    isTracking = false
    
    if DoesBlipExist(trackingRadius) then
        RemoveBlip(trackingRadius)
        trackingRadius = nil
    end
    
    if trackingThread then
        trackingThread = nil
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        stopTracking()
    end
end)