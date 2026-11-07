# Troy Scripts — ts_gemertmap 1.0.9

Satellietkaart voor **Gemert Roleplay** met Nederlandse gebiedsnamen, kaartlabels, GPS-postcodes en clientexports voor incidentlocaties. Deze repository bevat de **volledige FiveM-resource**, inclusief alle originele kaarttextures in `stream/`.

**Scriptversie:** `1.0.9` · **Configschema:** `1.0.8` (ongewijzigd) · **Dependency:** `ox_lib`. De resource is zelfstandig; `ts_bridge` kan de locatieexports optioneel gebruiken.

## Download en installatie

Gebruik het complete ZIP-pakket dat door GitHub Actions wordt gebouwd, of download na samenvoegen de hele repository. Pak het pakket uit zodat de resourcemap precies **`ts_gemertmap`** heet. Maak eerst een back-up van je eigen configuratie.

De instellingen staan vanaf 1.0.9 in `config/config.lua`. Neem je bestaande `Config.ZoneNames`, `Config.Points`, zoominstellingen en updatecontrole-instellingen over. **Laat `Config.Version = '1.0.8'` staan**: de configstructuur is niet veranderd.

```cfg
ensure ox_lib
ensure ts_gemertmap
```

Zie [INSTALLATIE.md](docs/INSTALLATIE.md) en [STRUCTUUR.md](docs/STRUCTUUR.md). Bij het vervangen van kaarttextures is een volledige serverherstart en opnieuw verbinden in FiveM aanbevolen; een losse resource-restart toont niet noodzakelijk de nieuwe textures.

## Kaart en originele assets

De `stream/`-map blijft in de resourcehoofdmap. FiveM streamt de `.ytd`- en `.ydd`-bestanden zonder extra manifestentries. **Deze onderhoudsrelease wijzigt geen enkel streambestand.** De oorspronkelijke satellietkaart is afkomstig van Oulsen; zie [CREDITS.md](docs/CREDITS.md) en [LICENSE-Oulsen.txt](LICENSE-Oulsen.txt). De labels in de gebakken kaarttexture zijn onafhankelijk van `Config.ZoneNames` in de GTA-UI.

Postcodecoördinaten staan in `data/postcodes.json` (946 posten). Vast ingebakken kaartnamen worden voor ontwikkelaars beheerd in `data/kaartnamen.json` (46 labels). `tools/build_map.py` is een optionele buildtool; hij is **niet** nodig bij normaal gebruik.

## Commando's

| Commando | Gedrag |
| --- | --- |
| `/postcode` | Dichtstbijzijnde postcode van je huidige positie |
| `/postcode 001` | Gele GPS-route naar postcode 001; `/postcode 1` werkt ook |
| `/postcode uit` | Verwijdert uitsluitend de door het postcodecommando gemaakte route |
| `/gemertmapreset` | Past de ingestelde radarzoom opnieuw toe; wist geen cache |

Meldingen van `/postcode` gebruiken `ox_lib`. Eigen waypointinstellingen worden niet ongevraagd verwijderd.

## Exports voor andere resources

De clientexports blijven **ongewijzigd**:

```lua
local postcode = exports.ts_gemertmap:GetNearestPostcode(coords)
local locatie = exports.ts_gemertmap:GetLocation(coords)
```

Beide gebruiken de **meegegeven coördinaten** (bijvoorbeeld de incidentpositie), niet automatisch die van de speler. De tweede export geeft `area`, `zone` en `postcode` terug. De optionele koppeling met `ts_bridge` voor incidentmeldingen blijft bestaan.

## Installatiebestanden en documentatie

De hoofdmap bevat `fxmanifest.lua`, `version.txt`, deze README en de originele licentie. De code staat in `client/`, `server/`, instellingen in `config/`, postcode- en kaartnaamdata in `data/`, kaartassets in `stream/` en documentatie in `docs/`. Historische updatebestanden staan in `docs/historie/`.

Meer informatie: [CHANGELOG.md](docs/CHANGELOG.md), [GITHUB.md](docs/GITHUB.md) en [CONTROLE.md](docs/CONTROLE.md).

## Verificatie

GitHub Actions controleert de laadpaden, versies, Lua-syntax, JSON-data en de **aanwezigheid** van alle 78 gestreamde kaartbestanden. Ook wordt een volledig installatie-ZIP gemaakt. De binaire kaartbestanden zijn bij deze herindeling op GitHub met hun oorspronkelijke blob-SHA behouden. Deze checks vervangen geen visuele FiveM-test. Controleer na installatie minimap, ESC-kaart, alle postcodecommando's en de `ts_bridge`-locatieexports op een testserver.
