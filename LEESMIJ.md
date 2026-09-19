# Actuele update: ts_gemertmap 1.0.6

Lees UPDATE-INSTALLATIE.md voor deze update en GITHUB.md voor het publiceren en
later invullen van je echte repository. Script- en configversie zijn 1.0.6.
Nieuwe clientexports geven de kaartgebiedsnaam en dichtstbijzijnde postcode aan
politiemeldingen in ts_bridge 0.0.6. De kaart blijft standalone.

Dit pakket bevat alleen wijzigingen; bestaande kaarttextures en postcodegegevens
blijven staan. Hieronder staat de oorspronkelijke kaartdocumentatie van 1.0.5.

# ts_gemertmap — Gemert RP — 1.0.5

Zelfstandige FiveM-resource met satellietkaart voor minimap en grote pauzemap.
46 Nederlandse plaats- en wijknamen zijn nu daadwerkelijk in de kaarttexturen
verwerkt. Geen ESX, QBCore, SQL, nc-minimap of internetaanroepen tijdens het spelen.

## Bijwerken naar 1.0.5
1. Bewaar je huidige resource als backup buiten de actieve resources-map.
2. Vervang de bestanden van ts_gemertmap door deze versie, inclusief stream.
   Eigen aanpassingen in config.lua kun je behouden.
3. Herstart de server en sluit FiveM volledig af voordat je opnieuw verbindt.
   Een resource-restart alleen is geen betrouwbare test voor vervangen texturen.
4. Open de grote ESC-kaart en zoom bijvoorbeeld op de stad of Bakel in.
   Dezelfde kaartopschriften verschijnen op de minimap wanneer dat gebied in beeld is.

## Eerste installatie
1. Zet de map ts_gemertmap in resources/[standalone].
2. Gebruik slechts één pakket dat dezelfde GTA-minimapassets streamt.
   Controleer op dubbele minimap*.ytd, minimap*.ydd en minimap.gfx.
   Laat nc-minimap staan als een telefoonapp daarvan afhankelijk is en het
   geen conflicterende GTA-kaartassets levert.
3. Voeg na je HUD-startregel aan server.cfg toe:

   ensure ts_gemertmap

4. Herstart de server en verbind opnieuw.

## Nederlandse kaartnamen
Voorbeelden: Gemert Centrum, Gemert Binnenstad, Bakel, Boekel, De Mortel,
Elsendorp, Grachtenwijk, Gemert Airport en Haventerminal.
Deze namen zijn vaste opschriften IN de kaart, geen jobblips of HUD-tekstlaag.
Je hoeft ze niet via een menu in te schakelen. De grootte hangt af van je zoom.
Nederlandse namen zijn toegevoegd; de kleine Engelse straatnamen en overige
opschriften uit de oorspronkelijke satellietkaart zijn niet allemaal verwijderd
of vertaald. Het is de GTA-wereld met RP-namen, geen echte kaart van Nederland.

config.lua bevat daarnaast de dynamische Nederlandse GTA-gebiedsteksten.
Een HUD met een eigen namenlijst kan deze negeren. Config.ZoneNames wijzigen
of Config.DutchZoneNames uitschakelen verandert NIET de ingebakken kaartnamen.
Die vaste namen en hun plaatsing zijn vastgelegd in kaartnamen.json.

## Eigen kaartnamen bouwen (optioneel, voor ontwikkelaars)
Het script tools/build_map.py is niet nodig om deze resource te gebruiken.
Het bouwt de vaste opschriften opnieuw uit kaartnamen.json en de oorspronkelijke
Oulsen nogrid YTD-bestanden. Gebruik daarvoor Python 3, Pillow 12 of nieuwer,
numpy en matplotlib. Bewaar een originele bronmap; voer nooit reeds gelabelde
textures in, anders worden labels dubbel ingebakken.

python tools/build_map.py --source PAD_NAAR_ORIGINELE_NOGRID --output stream --preview voorbeelden

De builder ondersteunt uitsluitend het gecontroleerde 4096x4096 DXT5-formaat
van deze bron en weigert afwijkende bestanden. De resource zelf heeft geen
Python-afhankelijkheid. Publiceer nooit losse tools als serverdependencies.

## Postcodes
- /poscode 001: gele GPS-route naar postcode 001. /poscode 1 werkt ook.
- /poscode: toont de dichtstbijzijnde postcode.
- /poscode uit: verwijdert alleen de routeblip van dit command.
946 unieke postcodes uit de bijbehorende kaartdataset zijn inbegrepen.
De route blijft actief tot je een andere postcode kiest, /poscode uit gebruikt
of de resource stopt. Een eventuele eigen waypoint wordt niet gewist.

## HUD en probleemoplossing
De HUD blijft verantwoordelijk voor positie, vorm, schaal en zichtbaarheid.
Dit pakket levert satellietkaartassets en de bijbehorende radarzoom.
Bij flikkeren of een ontbrekende kaart: controleer andere resources op
SetRadarZoom, SetMapZoomDataLevel, SetRadarAsInteriorThisFrame en dubbele
minimap.gfx-bestanden. Schakel alleen de conflicterende kaartfunctie uit.
/gemertmapreset stelt de radarzoom opnieuw in; het wist geen cache of data.
Cayo Perico en andere extra eilandkaarten zijn niet toegevoegd of getest.

## Terugzetten
Verwijder de ensure-regel, herstel je eerdere kaartpakket en herstart de server.
Laat spelers opnieuw verbinden. Bij live stoppen worden onbekende zoomwaarden
van andere HUDs niet automatisch hersteld.

## Validatie
Zie CONTROLE.txt en texture-checks.json. De gewijzigde YTD-bestanden zijn opnieuw
uitgelezen; structuur en compressieblokken buiten de labels zijn gecontroleerd.
Voorbeelden zijn gemaakt uit de daadwerkelijk verpakte textuurdata.
Er is hier geen FiveM-client: controleer deze texture-update nog in het spel.

## Opstartmelding
Bij het starten van deze resource verschijnt een groot lichtblauw TroyScripts
ASCII-logo, gevolgd door de resourcegegevens, in de
serverconsole met de resourcenaam en versie uit fxmanifest.lua. Deze melding
bevestigt dat de resource start; het is geen controle van de kaart op clients.
