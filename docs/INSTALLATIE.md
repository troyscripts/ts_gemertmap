# Installatie — ts_gemertmap 1.1.0

Deze versie is een **volledig pakket** inclusief kaarttextures, niet de eerdere gedeeltelijke update.

## Vereisten

- FiveM met streaming van `.ytd` en `.ydd`-mapbestanden.
- `ox_lib` gestart voor `ts_gemertmap`.
- Geen ESX, QBCore, SQL of verplichte `ts_bridge`-dependency.

## Upgraden

1. Maak een back-up van je huidige `ts_gemertmap`-resource en vooral je eigen `config.lua` of `config/config.lua`.
2. Zet alle andere resources die dezelfde GTA-minimapassets streamen uit om conflicten te vermijden. Controleer vóór installatie welke resources ook `minimap*.ytd`, `minimap*.ydd` of `minimap.gfx` gebruiken. Verwijder niet zomaar resources waarvan andere scripts afhankelijk zijn.
3. Stop `ts_gemertmap`. Verwijder na de back-up de volledige oude resourcemap, zodat verplaatste rootbestanden niet blijven staan.
4. Pak `ts_gemertmap_1.1.0_compleet.zip` uit onder `resources/`; de resourcemap moet `ts_gemertmap` heten. Controleer dat de map direct `fxmanifest.lua` en `stream/` bevat.
5. Neem je persoonlijke instellingen over in **`config/config.lua`**: `Config.ZoneNames`, `Config.Points`, `RadarZoom`, `UpdateCheck` en `StartupMessage`. Het configuratieschema is nu **1.0.9**.
6. Zorg dat `server.cfg` de juiste volgorde gebruikt:
   ```cfg
   ensure ox_lib
   ensure ts_gemertmap
   ```
7. Herstart de volledige FiveM-server en verbind opnieuw. Test de minimap, ESC-kaart, `/postcode`, `/postcode 001`, `/postcode uit`, `/gemertmapreset` en indien gebruikt `ts_bridge`-locatiemeldingen.

## Huidige locaties

- Configuratie: `config/config.lua`
- Postcodedata: `data/postcodes.json`
- Kaartnaamconfiguratie voor de builder: `data/kaartnamen.json`
- Laadscript: `client/postcodes.lua`
- Originele kaartassets: **`stream/`**
- Documentatie: `docs/`

Het `fxmanifest.lua` bevat `this_is_a_map 'yes'` en registreert `data/postcodes.json` als resourcebestand. Het verplaatsen van de streambestanden is bewust vermeden.

## Terugzetten

Stop de resource, verwijder de nieuwe map en herstel de hele oorspronkelijke map vanuit je back-up. Start de server volledig opnieuw en verbind opnieuw.

Lees [STRUCTUUR.md](STRUCTUUR.md) en [CONTROLE.md](CONTROLE.md) voor extra uitleg. Historische instructies uit `docs/historie/` zijn niet geschikt als volledige 1.1.0-installatie.

## Gecombineerde radar- en updatecheckerupdate

Voor scriptversie 1.1.0 neem je in `config/config.lua` over: `Config.ZoomRefreshMs = 0` (geen periodieke zoomoverride) en `Config.UpdateCheck.Repository = 'troyscripts/ts_gemertmap'`. Na het overnemen van deze nieuwe standaarden zet je `Config.Version = '1.0.9'`. Eigen gebiedsnamen/POI's behouden. Oudere configs met een periodieke `ZoomRefreshMs=10000` blijven werken maar zijn bij HUD-zoomproblemen niet aanbevolen.
