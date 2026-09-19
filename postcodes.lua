local postcodes, lookup, routeBlip = {}, {}, nil

local function notify(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

local function normalize(value)
    local text = tostring(value)
    if not text:match('^%d+$') then return nil end
    return text:gsub('^0+', '') .. ''
end

local function clearRoute()
    if routeBlip then
        RemoveBlip(routeBlip)
        routeBlip = nil
    end
end

local raw = LoadResourceFile(GetCurrentResourceName(), 'postcodes.json')
local ok, data = pcall(json.decode, raw or '')
if ok and type(data) == 'table' then
    for _, postal in ipairs(data) do
        local key = normalize(postal.code)
        if key and type(postal.x) == 'number' and type(postal.y) == 'number' then
            lookup[key] = postal
            postcodes[#postcodes + 1] = postal
        end
    end
else
    print('[ts_gemertmap] postcodes.json ontbreekt of bevat ongeldige JSON.')
end

RegisterCommand('poscode', function(_, args)
    local input = args[1]
    if input and input:lower() == 'uit' then
        clearRoute()
        notify('Postcoderoute verwijderd.')
        return
    end
    if #postcodes == 0 then
        notify('Postcodes zijn niet beschikbaar. Controleer postcodes.json.')
        return
    end
    if not input then
        local coords = GetEntityCoords(PlayerPedId())
        local nearest, bestDistance
        for _, postal in ipairs(postcodes) do
            local distance = (coords.x - postal.x)^2 + (coords.y - postal.y)^2
            if not bestDistance or distance < bestDistance then
                nearest, bestDistance = postal, distance
            end
        end
        notify(('Dichtstbijzijnde postcode: %s. Gebruik /poscode [nummer] voor een route.'):format(nearest.code))
        return
    end
    local key = normalize(input)
    local postal = key and lookup[key]
    if not postal or #args > 1 then
        notify('Onbekende postcode. Gebruik /poscode [nummer] of /poscode uit.')
        return
    end
    clearRoute()
    routeBlip = AddBlipForCoord(postal.x, postal.y, 0.0)
    SetBlipSprite(routeBlip, 8)
    SetBlipColour(routeBlip, 5)
    SetBlipScale(routeBlip, 0.8)
    SetBlipAsShortRange(routeBlip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Postcode ' .. postal.code)
    EndTextCommandSetBlipName(routeBlip)
    SetBlipRoute(routeBlip, true)
    SetBlipRouteColour(routeBlip, 5)
    notify(('GPS-route ingesteld naar postcode %s.'):format(postal.code))
end, false)

AddEventHandler('onClientResourceStop', function(name)
    if name == GetCurrentResourceName() then clearRoute() end
end)
