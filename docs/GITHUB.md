# GitHub-publicatie en updatechecker — ts_gemertmap 1.0.9

Deze repository is [troyscripts/ts_gemertmap](https://github.com/troyscripts/ts_gemertmap).

De naam van de FiveM-resource blijft **`ts_gemertmap`**. Bewaar bij publicatie `fxmanifest.lua` en `version.txt` in de hoofdmap en **`stream/` direct eronder**. GitHub Actions maakt op de nieuwe branch een volledige ZIP met alle kaartbestanden.

De standalone updatechecker leest `version.txt` in de opgegeven GitHub-repository. De standaardconfig bevat nog bewust een lege `Repository`; de opruiming activeert geen nieuwe netwerkaanroepen. Wie de versiechecker wil gebruiken, zet in `config/config.lua`:

```lua
Config.UpdateCheck = {
    Enabled = true,
    Repository = 'troyscripts/ts_gemertmap',
    Branch = 'main'
}
```

Met `Enabled = false` wordt de controle uitgeschakeld. Een ontbrekende of lege repository veroorzaakt geen geldige netwerkcheck. Bij een nieuwe versie rapporteert het script de downloadlocatie; het installeert niets automatisch.

Bij een nieuwe release moeten het versienummer in `fxmanifest.lua` en `version.txt` identiek zijn. Verhoog `Config.Version` alleen als de configuratievelden wijzigen; in 1.0.9 blijft het schema `1.0.8`.

Er zijn geen geheime tokens of webhooks vereist. Behoud bij verspreiding de originele Oulsen-licentie en de referenties in [CREDITS.md](CREDITS.md). Lees [INSTALLATIE.md](INSTALLATIE.md) voor een volledige upgrade.
