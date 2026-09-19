# ts_gemertmap 1.0.5 → 1.0.6

Dit pakket bevat alleen gewijzigde en nieuwe bestanden. De bestaande kaarttextures,
postcodes.json, kaartnamen.json, credits en overige bestanden blijven staan.
Geen bestanden verwijderen en geen volledige resourcemap vervangen door alleen deze ZIP.

1. Maak een backup van ts_gemertmap en eigen config.lua.
2. Stop ts_gemertmap en kopieer de inhoud van dit pakket over de bestaande map.
3. Neem de nieuwe Config.Version = '1.0.6' en Config.UpdateCheck over. Behoud eigen
   instellingen, Nederlandse ZoneNames en Points. Repository mag nog leeg zijn.
4. Werk de bridge bij naar 0.0.6 en neem de nieuwe meldingsconfig over.
5. Start eerst ts_gemertmap, vervolgens ts_bridge en daarna de afhankelijke scripts.
   Volg bij de bridge-update ook de stop/startvolgorde van de andere Troy Scripts.
6. Verbind na een herstart van de kaartresource opnieuw als de gestreamde kaart niet
   goed wordt weergegeven. De textures zelf worden niet gewijzigd door deze update.

De kaart blijft standalone en krijgt GEEN verplichte bridge-afhankelijkheid.
Postcodemeldingen in ts_bridge gebruiken de nieuwe clientexports:

- exports.ts_gemertmap:GetNearestPostcode({x=..., y=...}) → code/x/y/distance, of nil.
- exports.ts_gemertmap:GetLocation({x=..., y=..., z=...}) → area/zone/postcode, of nil.

Postcodeafstand wordt horizontaal berekend. De locatie moet expliciet worden
meegegeven: voor een politiemelding is dat het incident, niet de agent.
Gebiedslabels komen uit Config.ZoneNames. Onbekende zones vallen terug op GTA-labels.
Exportresultaten zijn kopieën; het interne postcodebestand wordt niet aangepast.
/poscode, /poscode [nummer] en /poscode uit blijven beschikbaar.

Nieuwe scriptversie: 1.0.6. Nieuw configschema: 1.0.6, vanwege de updatechecker.
De volgende versie hoeft het configschema alleen te verhogen bij gewijzigde config.
Zie GITHUB.md om later de echte repository in te vullen; checker is al aanwezig.

Lokaal getest: alle 946 postcodes geladen, nearest-search op een coördinatenraster,
gebiedsnamen, ongeldige coördinaten, behoud van 001, /poscode en GitHub-foutscenario's.
Geen live FiveM-test uitgevoerd. Test politiemeldingen met twee spelers na installatie.
