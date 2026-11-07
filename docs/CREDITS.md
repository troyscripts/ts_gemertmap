# Bronnen en licentie
Satellietkaart en basis voor radarzoom: https://github.com/Oulsen/oulsen_satmap
Commit: e09e2ca9102f1309ee27e9c100cf252d70fd6fa5
Gebruikte variant: nogrid (zonder rasterlijnen), met oorspronkelijke postcodes en opschriften.
Licentie: LICENSE-Oulsen.txt, ongewijzigd opgenomen.
Oulsen verwijst voor de oorspronkelijke satellietbasis naar:
https://gtaforums.com/topic/595113-high-resolution-maps-satellite-roadmap-atlas/
Streamingbasis volgens Oulsen: https://github.com/ArduousDev/MiniMap
Nederlandse gebiedsconfiguratie en integratie zijn voor deze levering toegevoegd.
De satellietbeelden zijn niet nieuw gemaakt door Troy Scripts.

Postcodegegevens: oulsen_satmap/oulsen_satmap_postals.json uit dezelfde broncommit.
Dubbele vermelding 750 (coordinaten minder dan 1 meter uit elkaar): eerste vermelding behouden.

1.0.5: 46 Nederlandse opschriften toegevoegd aan de nogrid-texturen.
Plaatsing is vastgelegd in kaartnamen.json. Originele satellietbeelden en wegen
blijven afkomstig van de hierboven genoemde makers. YTD-formaat gecontroleerd
aan de hand van CodeWalker: https://github.com/dexyfex/CodeWalker/blob/master/CodeWalker.Core/GameFiles/Resources/Texture.cs
