local postcodes, lookup, routeBlip = {}, {}, nil

local function notify(message, notifyType)
    lib.notify({
        title = 'Gemert Map',
        description = message,
        type = notifyType or 'inform',
        duration = 4000
    })
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
        local key = type(postal) == 'table' and normalize(postal.code)
        if key and key ~= '' and type(postal.x) == 'number' and type(postal.y) == 'number'
            and postal.x == postal.x and postal.y == postal.y
            and math.abs(postal.x) ~= math.huge and math.abs(postal.y) ~= math.huge then
            lookup[key] = postal
            postcodes[#postcodes + 1] = postal
        end
    end
else
    print('[ts_gemertmap] postcodes.json ontbreekt of bevat ongeldige JSON.')
end

-- Clientexports gebruiken de incidentpositie, nooit impliciet de eigen speler.
local function finite(n)
    return type(n) == 'number' and n == n and math.abs(n) ~= math.huge
end
local function nearestAt(coords)
    if (type(coords) ~= 'table' and type(coords) ~= 'vector3')
        or not finite(coords.x) or not finite(coords.y) then return nil end
    local nearest, best
    for _, postal in ipairs(postcodes) do
        local distance = (coords.x - postal.x)^2 + (coords.y - postal.y)^2
        if not best or distance < best then nearest, best = postal, distance end
    end
    if not nearest then return nil end
    return { code = tostring(nearest.code), x = nearest.x, y = nearest.y, distance = math.sqrt(best) }
end
exports('GetNearestPostcode', nearestAt)
exports('GetLocation', function(coords)
    if (type(coords) ~= 'table' and type(coords) ~= 'vector3')
        or not finite(coords.x) or not finite(coords.y) or not finite(coords.z) then return nil end
    local zone = GetNameOfZone(coords.x, coords.y, coords.z)
    local name = type(Config.ZoneNames) == 'table' and Config.ZoneNames[zone] or nil
    if type(name) ~= 'string' or name == '' then
        name = zone and GetLabelText(zone) or nil
        if name == 'NULL' or name == '' then name = zone end
    end
    return { area = name, zone = zone, postcode = nearestAt(coords) }
end)

RegisterCommand('postcode', function(_, args)
    local input = args[1]
    if input and input:lower() == 'uit' then
        clearRoute()
        notify('Postcoderoute verwijderd.', 'success')
        return
    end
    if #postcodes == 0 then
        notify('Postcodes zijn niet beschikbaar. Controleer postcodes.json.', 'error')
        return
    end
    if not input then
        local coords = GetEntityCoords(PlayerPedId())
        local nearest = nearestAt(coords)
        notify(('Dichtstbijzijnde postcode: %s. Gebruik /postcode [nummer] voor een route.'):format(nearest.code))
        return
    end
    local key = normalize(input)
    local postal = key and lookup[key]
    if not postal or #args > 1 then
        notify('Onbekende postcode. Gebruik /postcode [nummer] of /postcode uit.', 'error')
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
    notify(('GPS-route ingesteld naar postcode %s.'):format(postal.code), 'success')
end, false)

AddEventHandler('onClientResourceStop', function(name)
    if name == GetCurrentResourceName() then clearRoute() end
end)
