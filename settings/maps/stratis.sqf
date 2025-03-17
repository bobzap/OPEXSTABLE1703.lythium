if (worldName != "stratis") exitWith {};

OPEX_mapRadius = worldSize / 2;
OPEX_mapCenter = [OPEX_mapRadius, OPEX_mapRadius, 0];
OPEX_mapRegion = "europe";
OPEX_mapCountry = "STR_greece";
OPEX_mapLocality = "str_stratis";
OPEX_mapLocalityInside = "str_stratisIn";
OPEX_mapClimate = "mediterranean"; if (isClass (configFile >> "CfgPatches" >> "winter_2035")) then {OPEX_mapClimate = "polar"};
OPEX_mapEnemy = "ULTRA";
OPEX_mapNationalities = ["STR_greece"];
OPEX_mapLanguage = "greek";
OPEX_mapWater = true;
OPEX_locations_safe = [];
OPEX_locations_isolated = [];
OPEX_locations_villages = [];
OPEX_locations_cities = [];
OPEX_locations_industrial = [];
OPEX_locations_military = [];