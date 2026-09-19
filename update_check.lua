-- Zelfstandige metadata-check; geen bridge vereist en nooit code downloaden/uitvoeren.
local function log(message) print('[ts_gemertmap] ' .. message) end
local function version(value)
    if type(value) ~= 'string' or #value > 64 then return end
    local a,b,c = value:match('^%s*v?(%d+)%.(%d+)%.(%d+)%s*$')
    if not a then return end
    local parts = {tonumber(a),tonumber(b),tonumber(c)}
    for _, n in ipairs(parts) do if n > 9007199254740991 then return end end
    return parts
end
CreateThread(function()
    if Config.Version ~= '1.0.6' then
        log('Configschema 1.0.6 vereist. Neem de nieuwe UpdateCheck-instellingen over; eigen kaartnamen behouden.')
    end
    local settings = Config.UpdateCheck
    if settings == nil then log('Updatecontrole nog niet ingesteld: voeg Config.UpdateCheck toe.'); return end
    if type(settings) ~= 'table' or type(settings.Enabled) ~= 'boolean' then
        log('Ongeldige Config.UpdateCheck; controle overgeslagen.'); return
    end
    if not settings.Enabled then return end
    if settings.Repository == '' then
        log('GitHub nog niet ingesteld. Vul later Config.UpdateCheck.Repository in als eigenaar/repository.'); return
    end
    local owner, repo
    if type(settings.Repository) == 'string' then owner, repo = settings.Repository:match('^([%w][%w-]*)/([%w_.-]+)$') end
    local branch = settings.Branch
    if not owner or repo == '.' or repo == '..' or type(branch) ~= 'string'
        or branch == '' or not branch:match('^[%w_./-]+$') then
        log('Ongeldige Repository of Branch in Config.UpdateCheck.'); return
    end
    local current = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    local installed = version(current)
    if not installed then log('Ongeldige lokale versie in fxmanifest.lua.'); return end
    Wait(3000)
    local completed = false
    SetTimeout(15000, function()
        if completed then return end
        completed = true; log('Updatecontrole: GitHub heeft niet op tijd geantwoord.')
    end)
    local encoded = branch:gsub('([^%w_.~-])', function(c) return ('%%%02X'):format(c:byte()) end)
    local endpoint = ('https://api.github.com/repos/%s/contents/version.txt?ref=%s'):format(settings.Repository, encoded)
    local ok = pcall(PerformHttpRequest, endpoint, function(status, body)
        if completed then return end
        completed = true
        if status ~= 200 then log(('Updatecontrole mislukt (HTTP %s). Controleer repository, branch en version.txt.'):format(tostring(status))); return end
        local latest = version(body)
        if not latest then log('Ongeldige versie op GitHub; verwacht bijvoorbeeld 1.0.6.'); return end
        local comparison = 0
        for i=1,3 do if latest[i] ~= installed[i] then comparison = latest[i] > installed[i] and 1 or -1; break end end
        if comparison > 0 then
            log(('Nieuwe versie beschikbaar: %s (geinstalleerd: %s).'):format(table.concat(latest,'.'),current))
            log('Download: https://github.com/' .. settings.Repository)
        elseif comparison == 0 then log('Je gebruikt de nieuwste versie (' .. current .. ').')
        else log('Lokale versie is nieuwer dan GitHub (' .. table.concat(latest,'.') .. ').') end
    end, 'GET', '', {['Accept']='application/vnd.github.raw+json', ['User-Agent']='TroyScripts-ts_gemertmap'}, {followLocation=false})
    if not ok and not completed then completed=true; log('Updatecontrole kon niet worden gestart.') end
end)
