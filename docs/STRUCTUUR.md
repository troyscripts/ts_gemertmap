# Mappenstructuur — ts_gemertmap 1.0.9

```text
ts_gemertmap/
├── fxmanifest.lua
├── version.txt
├── README.md
├── LICENSE-Oulsen.txt
├── config/
│   └── config.lua
├── client/
│   ├── main.lua
│   └── postcodes.lua
├── server/
│   ├── main.lua
│   └── update_check.lua
├── data/
│   ├── postcodes.json
│   └── kaartnamen.json
├── stream/                    # 78 FiveM-kaartassets, paden ONGEWIJZIGD
│   └── minimap*.ytd / minimap*.ydd
├── tools/
│   └── build_map.py
├── docs/
│   ├── CHANGELOG.md
│   ├── INSTALLATIE.md
│   ├── STRUCTUUR.md
│   ├── CONTROLE.md
│   ├── GITHUB.md
│   ├── CREDITS.md
│   ├── controle/
│   │   └── texture-checks.json
│   ├── voorbeelden/
│   │   └── gemert_satelliet_overzicht.jpg
│   └── historie/
│       └── eerdere handleidingen / testverslagen
└── .github/workflows/
    └── checks.yml
```

## Gewijzigde paden

| Oud | Nieuw |
| --- | --- |
| `config.lua` | `config/config.lua` |
| `client.lua` | `client/main.lua` |
| `postcodes.lua` | `client/postcodes.lua` |
| `server.lua` | `server/main.lua` |
| `update_check.lua` | `server/update_check.lua` |
| `postcodes.json` | `data/postcodes.json` |
| `kaartnamen.json` | `data/kaartnamen.json` |
| `texture-checks.json` | `docs/controle/texture-checks.json` |
| `voorbeelden/` | `docs/voorbeelden/` |
| `CHANGELOG.md`, `GITHUB.md`, `CREDITS.md` | `docs/` |
| Oude update-/testbestanden | `docs/historie/` |

## Niet wijzigen

- `stream/` blijft direct in de FiveM-resourcehoofdmap, zodat de automaatstreaming van `.ytd` en `.ydd` intact blijft.
- De bestandnamen, textuurinhoud, 946 postcodes en 46 vaste kaartlabels blijven gelijk.
- `GetNearestPostcode`, `GetLocation`, `/postcode` en `/gemertmapreset` behouden hun namen en gedrag.
- `Config.Version = '1.0.8'` blijft geldig; **alleen de scriptversie gaat naar 1.0.9**.
- De originele Oulsen-licentie staat in de hoofddirectory, de bronvermelding in `docs/CREDITS.md`.

## Controle

GitHub Actions draait de manifest-/pad-/datasetcheck en Lua 5.4-syntax en bouwt een complete ZIP met een bovenste map `ts_gemertmap/`. Na installatie blijft een test op de FiveM-testserver vereist, inclusief opnieuw verbinden om nieuwe kaarten betrouwbaar te laden.
