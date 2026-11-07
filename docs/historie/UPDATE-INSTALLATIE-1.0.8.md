# ts_gemertmap 1.0.8 — update vanaf 1.0.7

Dit pakket bevat alleen gewijzigde bestanden. Het is geen volledige installatie.

1. Maak een backup van je bestaande ts_gemertmap buiten de actieve resources-map.
2. Plaats de bestanden uit deze ZIP in je bestaande ts_gemertmap-map.
   Heb je eigen instellingen, kaartnamen, POI's of een GitHub-repository ingesteld?
   Behoud dan je huidige config.lua en neem alleen onderstaande twee regels over.
   Vervang de bestaande Config.Version-regel en voeg Config.StartupMessage toe
   NA de regel Config = {}.

```lua
Config.Version = '1.0.8'
Config.StartupMessage = 'full'
```

3. Kies full (eerste foto), compact (tweede foto) of off.
4. Voer in de serverconsole uit: restart ts_gemertmap

Het meegeleverde config.lua bevat de laatst geleverde standaardinstellingen.
Bij vervangen moet je eigen aanpassingen overnemen, waaronder Config.UpdateCheck.Repository.
De updatechecker blijft los van de opstartmelding werken.
Deze update bevat geen kaarttextures of postcodebestanden; versie 1.0.7 moet al aanwezig zijn.

Controle: de Lua-logica is getest met nagebootste FiveM-functies voor full, compact,
off, ontbrekende/ongeldige instelling en het starten van een andere resource.
Nog niet getest op een draaiende FiveM-server.
