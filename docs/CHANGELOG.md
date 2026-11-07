# Changelog

## 1.1.0 — 2026-11-07 — Radar en GitHub in één onderhoudsupdate

- Radarzoom wordt standaard ingesteld bij start, respawn en `/gemertmapreset`, zonder onnodige tiensecondenloop.
- `Config.ZoomRefreshMs = 0` is de nieuwe standaard; waarden van 1000–300000 behouden optioneel de periodieke compatibiliteitsmodus voor HUDs die zoom overschrijven.
- Updatechecker gebruikt standaard `troyscripts/ts_gemertmap`; een bewust lege repository toont een duidelijke melding zonder HTTP-aanvraag.
- Configschema naar `1.0.9` vanwege de nieuwe standaardinstellingen; scriptversie naar `1.1.0`.
- Kaarttextures, postcodegegevens, exports en commando's ongewijzigd.
- Automatische regressietest voor radarreset en GitHub-check.

## 1.0.9 — 2026-11-07 — Volledig pakket en mappenstructuur

- Volledige resource ingedeeld in `config/`, `client/`, `server/`, `data/` en `docs/`.
- `fxmanifest.lua` bijgewerkt voor `data/postcodes.json`, nieuwe Lua-paden en ongewijzigde laadvolgorde.
- Postcode-loader, foutmeldingen en kaartlabelbouwscript bijgewerkt voor de nieuwe datapaden.
- Alle 78 FiveM-kaartbestanden blijven ongewijzigd in de automatische `stream/`-map; oorspronkelijke licentie en credits behouden.
- README, installatiehandleiding, GitHub-instructies en controlehandleiding bijgewerkt; oude update- en testbestanden gearchiveerd.
- CI-controles en complete ZIP-distributie toegevoegd.
- Scriptversie verhoogd van `1.0.8` naar `1.0.9`; configschema `1.0.8` blijft behouden.
- Geen wijziging aan postcodegegevens, ingebakken labels, gameplay, commands, exports of streamingassets.

## 1.0.8

- Config.StartupMessage kiest full (logo en informatie), compact (alleen versieregel) of off.
- Standaard blijft de uitgebreide opstartmelding actief.
- Ontbrekende instelling gebruikt full; ongeldige waarden geven een waarschuwing en gebruiken full.
- Configschema verhoogd naar 1.0.8 vanwege de nieuwe instelling.
- Updatecontrole blijft afzonderlijk instelbaar via Config.UpdateCheck.

## 1.0.7

- Alle postcodeberichten lopen nu via ox_lib-notificaties.
- Het postcodecommando is overal gelijkgetrokken naar /postcode.
- /postcode [nummer] stelt een route in, /postcode toont de dichtstbijzijnde postcode en /postcode uit verwijdert de route.
- ox_lib is als vereiste dependency aan het manifest toegevoegd.

## 1.0.6

- Clientexports GetNearestPostcode en GetLocation voor expliciete incidentcoördinaten.
- Bestaande ZoneNames en 946 postcodes hergebruikt; geen wijzigingen aan kaarttextures.
- Postcodes blijven strings met voorloopnullen; exportresultaten zijn kopieën.
- /postcode gebruikt dezelfde nearest-search; bestaande routebediening blijft behouden.
- Zelfstandige GitHub-versiechecker en version.txt; repository later invullen.
- Lege repository doet geen netwerkverzoeken; geen automatische downloads/installatie.
- Configschema 1.0.6 toegevoegd vanwege nieuwe UpdateCheck-instellingen.
- Manifest/configload, GitHub-instructies en updatehandleiding bijgewerkt.


## 1.0.5
- Groot lichtblauw TroyScripts ASCII-logo in de serverconsole, met resourcenaam en actuele versie.
- 46 Nederlandse plaats- en wijknamen zichtbaar in de satellietkaart ingebakken.
- Zowel normale als sea-kaarttexturen bijgewerkt voor minimap en grote kaart.
- Configuratie van vaste kaartnamen en optioneel bouwscript toegevoegd.
- Wegen en postcodeposities behouden; /postcode blijft beschikbaar.
- Versie in fxmanifest.lua en documentatie op 1.0.5 gezet.

## 1.0.0
- Standalone satellietkaart met Nederlandse dynamische gebiedsteksten.
- Postcodecommand /postcode toegevoegd aan de oorspronkelijke levering.
