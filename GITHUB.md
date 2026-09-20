# ts_gemertmap op GitHub plaatsen

Deze versie brengt de kaart naar 1.0.7 en bevat een zelfstandige updatechecker.

1. Maak je gewenste openbare GitHub-repository aan.
2. Upload de INHOUD van de volledige, bijgewerkte map ts_gemertmap naar de hoofdmap
   van de repository. Alleen deze update-ZIP uploaden is geen complete installatie.
   Neem ook de bestaande stream-map, postcodes.json, credits en licentiebestanden mee.
3. Zorg dat fxmanifest.lua en version.txt rechtstreeks in die hoofdmap staan.
   Beide bevatten voor deze release versie 1.0.7.
4. Vul lokaal en in je repository Config.UpdateCheck.Repository in met de echte
   eigenaar/repository, zonder https://github.com/ ervoor. Vul de juiste branch in.
5. Herstart ts_gemertmap en controleer de console.

```lua
Config.UpdateCheck = {
    Enabled = true,
    Repository = '', -- vul hier later je werkelijke eigenaar/repository in
    Branch = 'main'
}
```

Zolang Repository leeg is, meldt de checker eenmalig dat GitHub nog niet ingesteld
is en verstuurt hij GEEN HTTP-verzoek. Je hoeft de checker dus later niet opnieuw
te installeren: alleen het echte adres invullen en herstarten. Enabled = false
schakelt de controle volledig uit. Een GitHub-token is niet nodig voor een openbare repo.

De controle leest version.txt via de GitHub API, vergelijkt drie numerieke delen
en meldt een hogere versie met de repositorylink. Time-outs, ongeldige antwoorden
en HTTP-fouten worden gemeld zonder de kaart uit te schakelen. Er wordt nooit
code gedownload/uitgevoerd en niets automatisch geïnstalleerd.

Bij een volgende release: werk de code, CHANGELOG.md, fxmanifest.lua en version.txt
samen bij. Verhoog Config.Version alleen als de configuratie-indeling wijzigt.
Gebruik stabiele versies zoals 1.0.7 in version.txt. Behoud de originele credits
en licentieteksten van de kaartbasis. Deze update voert geen GitHub-publicatie uit.
