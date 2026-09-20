# Changelog

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
