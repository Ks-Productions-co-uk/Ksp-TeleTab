QBCore = exports['qb-core']:GetCoreObject()
local lastLocation = nil
local lastTeleportTime = 0
local teleportCooldown = 5000 -- Cooldown time in milliseconds (5000ms = 5 seconds) until player can next teleport.

-- Function to save the current location
function SaveCurrentLocation()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    lastLocation = {
        x = playerCoords.x, y = playerCoords.y, z = playerCoords.z, w = GetEntityHeading(playerPed), name = "Last Location"
    }
    --print("Saving location:", lastLocation.x, lastLocation.y, lastLocation.z, lastLocation.w)
end

-- Function to check if the player can teleport
function CanTeleport()
    local currentTime = GetGameTimer()
    return (currentTime - lastTeleportTime) >= teleportCooldown
end

-- Function for cinematic teleport
function CinematicTeleport(coords, cost)
    local playerPed = PlayerPedId()
    local playerId = QBCore.Functions.GetPlayerData().citizenid

    TriggerServerEvent('Ksp-TeleTab:deductMoney', playerId, cost)

    DoScreenFadeOut(1000)
    Wait(1000)

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetEntityCoords(vehicle, coords.x, coords.y, coords.z)
        SetEntityHeading(vehicle, coords.w)
    else
        SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
        SetEntityHeading(playerPed, coords.w)
    end

    Wait(500)
    DoScreenFadeIn(1000)
    QBCore.Functions.Notify("Teleported successfully! Cost: $" .. cost, "success")
end

-- Function for menu item selection
function OpenTeleportMenu()
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", false)
    local menuItems = {
        {
            header = "Teleport Locations",
            icon = "fa-solid fa-list",
            isMenuHeader = true,
        },
        {
            header = "Return to Last Location",
            txt = lastLocation and "Go back to your last saved location - Cost: $100" or "No saved location.",
            params = {
                event = lastLocation and "Ksp-TeleTab:teleportToLastLocation" or "",
                args = {
                    cost = 100 -- Fixed cost for teleport return, Adjust this to change the cost for returning to last location
                }
            }
        },
    }

    for categoryName, categoryData in pairs(Config.TeleportCategories) do
        table.insert(menuItems, {
            header = categoryName,
            txt = "Select to view locations.",
            icon = "fas fa-location-arrow",
            params = {
                event = "Ksp-TeleTab:openCategoryMenu",
                args = {
                    category = categoryName,
                    points = categoryData
                }
            }
        })
    end

    exports['qb-menu']:openMenu(menuItems)
end

-- Function for menu category selection
RegisterNetEvent('Ksp-TeleTab:openCategoryMenu')
AddEventHandler('Ksp-TeleTab:openCategoryMenu', function(data)
    local menuItems = {
        {
            isMenuHeader = true,
            header = data.category,
            icon = "fas fa-list",
        },
        {
            header = "< Return to main menu",
            txt = "Go back to the main menu.",
            params = {
                event = "Ksp-TeleTab:openTeleportMenu",
            },
            icon = "fas fa-arrow-left",
        }
    }

    for _, point in ipairs(data.points) do
        table.insert(menuItems, {
            header = point.name,
            txt = point.description .. " | Cost: $-" .. point.cost,
            params = {
                event = "Ksp-TeleTab:teleportToPoint",
                args = {
                    coords = point.coords,
                    cost = point.cost
                }
            },
            icon = point.icon,
        })
    end

    exports['qb-menu']:openMenu(menuItems)
end)

-- Event handlers to pass cost
RegisterNetEvent('Ksp-TeleTab:teleportToLastLocation')
AddEventHandler('Ksp-TeleTab:teleportToLastLocation', function(data)
    if lastLocation then
        local cost = data.cost -- Extract cost from passed data
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", false)
        CinematicTeleport(lastLocation, cost)
    else
        QBCore.Functions.Notify("No saved location.", "error")
    end
end)

RegisterNetEvent('Ksp-TeleTab:openTeleportMenu')
AddEventHandler('Ksp-TeleTab:openTeleportMenu', function()
    OpenTeleportMenu()
end)

RegisterNetEvent('Ksp-TeleTab:teleportToPoint')
AddEventHandler('Ksp-TeleTab:teleportToPoint', function(data)
    if CanTeleport() then
        local coords = data.coords
        local cost = data.cost
        SaveCurrentLocation()
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", false)
        CinematicTeleport(coords, cost)
        lastTeleportTime = GetGameTimer()
    else
        QBCore.Functions.Notify("You must wait before teleporting again.", "error")
    end
end)
