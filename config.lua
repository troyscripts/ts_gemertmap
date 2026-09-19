Config = {}
-- Atlas vereist eigen zoomwaarden. Laat andere resources deze niet overschrijven.
Config.RadarZoom = 1100
Config.ZoomRefreshMs = 10000
Config.DutchZoneNames = true
-- Dit zijn RP-namen, geen geografische reconstructie van Nederland.
-- Werkt in UI die GTA-gebiedsteksten gebruikt; geen wijziging van straatnamen.
Config.ZoneNames = {
    AIRP = 'Gemert Airport', ALAMO = 'De Groote Plas',
    ALTA = 'Gemert-Noord', BURTON = 'Gemert Winkelkwartier',
    CHAMH = 'Gemert-Zuid', CHIL = 'De Heuvels',
    CHU = 'Duinrand', DAVIS = 'Gemert-Zuidwest',
    DELBE = 'Gemert aan Zee', DELPE = 'Strandwijk',
    DOWNT = 'Gemert Centrum', DTVINE = 'Uitgaanskwartier',
    EAST_V = 'Gemert-Oost', EBURO = 'Industrieterrein Oost',
    ELYSIAN = 'Haveneiland', GALFISH = 'Vissersdorp',
    GRAPES = 'Boekel', GREATC = 'Buitengebied',
    HARMO = 'De Mortel', HAWICK = 'Handelskwartier',
    KOREAT = 'Stationskwartier', LACT = 'Stuwmeer',
    LMESA = 'Bedrijvenpark', MIRR = 'Parkwijk',
    MORN = 'Villawijk', MURRI = 'Industriehaven',
    NCHU = 'Noorderduinen', PALETO = 'Elsendorp',
    PALFOR = 'Elsendorpse Bossen', PBOX = 'Gemert Binnenstad',
    RANCHO = 'Spoorwijk', RGLEN = 'Groenendaal',
    RICHM = 'Landgoedwijk', ROCKF = 'Heuvelkwartier',
    SANDY = 'Bakel', SKID = 'Oude Industrie',
    STAD = 'Sportpark', STRAW = 'Gemert Spoorzone',
    TATAMO = 'Natuurgebied', TERMINA = 'Haventerminal',
    TEXTI = 'Textielkwartier', VCANA = 'Grachtenwijk',
    VESP = 'Kustwijk', VINE = 'Gemert Heuvels',
    WINDF = 'Windmolenpark', ZANCUDO = 'Defensieterrein'
}
-- Optioneel eigen POI's. Standaard leeg om bestaande jobblips niet te verdubbelen.
-- { label = 'Gemeentehuis', x = 0.0, y = 0.0, z = 0.0,
--   sprite = 419, colour = 0, scale = 0.75, shortRange = true },
Config.Points = {}
