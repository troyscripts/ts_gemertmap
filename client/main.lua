local originalLabels, ownedBlips = {}, {}

local function applyAtlasZoom()
    SetRadarZoom(Config.RadarZoom)
end

CreateThread(function()
    applyAtlasZoom()
    if Config.DutchZoneNames then
        for key, label in pairs(Config.ZoneNames) do
            originalLabels[key] = GetLabelText(key)
            AddTextEntry(key, label)
        end
    end
    for _, point in ipairs(Config.Points) do
        local blip = AddBlipForCoord(point.x, point.y, point.z)
        ownedBlips[#ownedBlips + 1] = blip
        SetBlipSprite(blip, point.sprite or 1)
        SetBlipColour(blip, point.colour or 0)
        SetBlipScale(blip, point.scale or 0.75)
        SetBlipAsShortRange(blip, point.shortRange ~= false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(point.label)
        EndTextCommandSetBlipName(blip)
    end
    -- Alleen in expliciet ingestelde compatibiliteitsmodus blijven herhalen.
    -- Normaal niet meer elke tien seconden met HUD/radarresources concurreren.
    local refresh = tonumber(Config.ZoomRefreshMs) or 0
    if refresh >= 1000 and refresh <= 300000 then
        while true do
            Wait(refresh)
            applyAtlasZoom()
        end
    end
end)

-- Na een respawn kan een HUD of spawnresource de radar opnieuw instellen.
AddEventHandler('playerSpawned', function()
    applyAtlasZoom()
end)

-- Handmatig opnieuw instellen; geen claim dat dit ieder ontbrekend-kaartprobleem oplost.
RegisterCommand('gemertmapreset', function()
    applyAtlasZoom()
    print('[ts_gemertmap] Atlaszoom opnieuw ingesteld. Bij flikkering: controleer andere radarresources.')
end, false)

AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    for _, blip in ipairs(ownedBlips) do RemoveBlip(blip) end
    for key, label in pairs(originalLabels) do
        if label ~= 'NULL' then AddTextEntry(key, label) end
    end
    -- Na stoppen van gestreamde kaartassets is opnieuw verbinden noodzakelijk.
end)
