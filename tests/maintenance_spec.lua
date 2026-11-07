-- Controleer: standaard geen periodieke radarloop, respawn/reset, optionele oude modus.
local threads, commands, events, zoom = {}, {}, {}, {}
Config = { RadarZoom=1100, ZoomRefreshMs=0, DutchZoneNames=false, Points={},
    Version='1.0.9', UpdateCheck={Enabled=true, Repository='troyscripts/ts_gemertmap', Branch='main'} }
function CreateThread(fn) threads[#threads+1]=fn end
function RegisterCommand(name, fn) commands[name]=fn end
function AddEventHandler(name, fn) events[name]=fn end
function SetRadarZoom(value) zoom[#zoom+1]=value end
function GetCurrentResourceName() return 'ts_gemertmap' end
function print() end
dofile('client/main.lua')
assert(#threads==1)
threads[1]()
assert(#zoom==1 and zoom[1]==1100, 'should set zoom once at start')
assert(type(events.playerSpawned)=='function')
events.playerSpawned()
commands.gemertmapreset()
assert(#zoom==3, 'respawn and reset must restore zoom')
-- Oude configuraties met 10000 ms blijven compatibel.
Config.ZoomRefreshMs = 10000
threads, zoom = {}, {}
dofile('client/main.lua')
local co = coroutine.create(threads[1])
local nextWait
function Wait(ms) nextWait=ms; coroutine.yield() end
assert(coroutine.resume(co))
assert(nextWait==10000 and #zoom==1, 'legacy period is supported')
assert(coroutine.resume(co))
assert(#zoom==2 and nextWait==10000)
-- Serverupdatecheck gebruikt de juiste repository, zonder browser of GitHub afhankelijkheid.
threads={}
local log, requests={}, {}
function print(message) log[#log+1]=tostring(message) end
function GetResourceMetadata() return '1.1.0' end
function SetTimeout() end
function PerformHttpRequest(url, callback, method)
    requests[#requests+1]={url=url,method=method}
    callback(200, '1.1.0\n')
end
function Wait() end
dofile('server/update_check.lua')
assert(#threads==1)
threads[1]()
assert(#requests==1 and requests[1].url:find('troyscripts/ts_gemertmap/contents/version.txt',1,true), 'repository URL incorrect')
assert(table.concat(log):find('nieuwste versie',1,true), 'expected up-to-date result')
Config.UpdateCheck.Enabled=false
threads={}; requests={}
dofile('server/update_check.lua')
threads[1]()
assert(#requests==0, 'disabled check must not call GitHub')
print('PASS radar event/legacy polling and update checker')
