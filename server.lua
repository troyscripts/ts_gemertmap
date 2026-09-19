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
    local version = GetResourceMetadata(resourceName, 'version', 0) or 'onbekend'
    print('^5' .. banner .. '^7')
    print('^5[TroyScripts]^7 ' .. resourceName .. ' | versie ' .. version .. ' | gestart')
    print('^5[TroyScripts]^7 Gemert RP satellietkaart met Nederlandse kaartnamen')
    print('^5[TroyScripts]^7 Commands: /poscode [nummer] | /poscode | /poscode uit')
end)
