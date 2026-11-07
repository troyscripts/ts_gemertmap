-- Statisch ASCII-logo; geen extra dependency nodig.
local banner = [=[
  ______                 _____           _       __      
 /_  __/________  __  __/ ___/__________(_)___  / /______
  / / / ___/ __ \/ / / /\__ \/ ___/ ___/ / __ \/ __/ ___/
 / / / /  / /_/ / /_/ /___/ / /__/ /  / / /_/ / /_(__  ) 
/_/ /_/   \____/\__, //____/\___/_/  /_/ .___/\__/____/  
               /____/                 /_/                
]=]

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    local mode = Config and Config.StartupMessage or 'full'
    if mode ~= 'full' and mode ~= 'compact' and mode ~= 'off' then
        print('^3[TroyScripts]^7 Ongeldige Config.StartupMessage; gebruik full, compact of off. Uitgebreide melding wordt gebruikt.')
        mode = 'full'
    end
    if mode == 'off' then return end
    local version = GetResourceMetadata(resourceName, 'version', 0) or 'onbekend'
    if mode == 'full' then print('^5' .. banner .. '^7') end
    print('^5[TroyScripts]^7 ' .. resourceName .. ' | versie ' .. version .. ' | gestart')
    if mode == 'compact' then return end
    print('^5[TroyScripts]^7 Gemert RP satellietkaart met Nederlandse kaartnamen')
    print('^5[TroyScripts]^7 Commands: /postcode [nummer] | /postcode | /postcode uit')
end)
