# Controles — ts_gemertmap 1.0.9

De GitHub Actions-workflow `.github/workflows/checks.yml` controleert het manifest, alle vernieuwde paden, versieconsistentie, postcodegegevens (946), ingebakken kaartnaamrecords (46), de noodzakelijke `stream/`-bestanden (78) en Lua 5.4-syntax. Hij bouwt daarna het volledige ZIP-installatiepakket.

De streamingbestanden zijn in deze refactor alleen als bestaande Git-blobs behouden; er is geen textuurbewerking of compressie uitgevoerd. De originele hashwaarden blijven identiek bij verplaatsen van overige bestanden.

## Gamecontrole op testserver

1. Herstart de FiveM-server met `ensure ox_lib` vóór `ensure ts_gemertmap`.
2. Sluit FiveM op de client af, verbind opnieuw en bekijk minimap en grote ESC-kaart.
3. Test `/postcode`, `/postcode 001`, `/postcode 1` en `/postcode uit`.
4. Controleer `/gemertmapreset` en de ingestelde `Config.RadarZoom`.
5. Controleer de exports `GetLocation` en `GetNearestPostcode` met incidentcoördinaten via `ts_bridge`.
6. Controleer op dubbele minimapstreamers en radar-HUD-conflicten wanneer de kaart niet verschijnt.

Eerdere visuele en gesimuleerde testverslagen staan in `docs/historie/`. Een succesvolle GitHub-test is **geen** bewijs dat de kaart visueel op iedere FiveM-client goed verschijnt.
