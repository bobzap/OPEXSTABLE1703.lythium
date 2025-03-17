// WAITING FOR MISSION SETUP
waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_mapClimate"};
waitUntil {!isNil "OPEX_mapRegion"};
sleep 1;

// DEFINING POSSIBLE CAMOS
private _woodland = 
	{
		OPEX_friendly_vehicles = OPEX_friendly_transportTrucksOpened_woodland + OPEX_friendly_transportTrucksCovered_woodland + OPEX_friendly_fuelTrucks_woodland + OPEX_friendly_logisticTrucks_woodland + OPEX_friendly_medicalTrucks_woodland + OPEX_friendly_repairTrucks_woodland + OPEX_friendly_ammoTrucks_woodland + OPEX_friendly_transportCars_woodland + OPEX_friendly_combatCarsMG_woodland + OPEX_friendly_combatCarsGL_woodland + OPEX_friendly_vtt_woodland + OPEX_friendly_tanks_woodland + OPEX_friendly_quads_woodland + OPEX_friendly_zodiacs + OPEX_friendly_ships + OPEX_friendly_aircrafts + OPEX_friendly_smallCombatHelicopters_woodland + OPEX_friendly_mediumCombatHelicopters_woodland + OPEX_friendly_smallTransportHelicopters_woodland + OPEX_friendly_mediumTransportHelicopters_woodland + OPEX_friendly_bigTransportHelicopters_woodland + OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones + OPEX_friendly_MGstatics + OPEX_friendly_GLstatics + OPEX_friendly_ATstatics + OPEX_friendly_mortarStatics;
		OPEX_friendly_choppers = OPEX_friendly_smallCombatHelicopters_woodland + OPEX_friendly_mediumCombatHelicopters_woodland + OPEX_friendly_smallTransportHelicopters_woodland + OPEX_friendly_mediumTransportHelicopters_woodland + OPEX_friendly_bigTransportHelicopters_woodland;
		OPEX_friendly_smallTransportHelicopters = OPEX_friendly_smallTransportHelicopters_woodland;
		OPEX_friendly_mediumTransportHelicopters = OPEX_friendly_mediumTransportHelicopters_woodland;
		OPEX_friendly_bigTransportHelicopters = OPEX_friendly_bigTransportHelicopters_woodland;
		OPEX_friendly_smallCombatHelicopters = OPEX_friendly_smallCombatHelicopters_woodland;
		OPEX_friendly_mediumCombatHelicopters = OPEX_friendly_mediumCombatHelicopters_woodland;
		OPEX_friendly_tanks = OPEX_friendly_tanks_woodland;
		OPEX_friendly_vtt = OPEX_friendly_vtt_woodland;
		OPEX_friendly_mechanizedVehicles = OPEX_friendly_transportTrucksOpened_woodland + OPEX_friendly_transportTrucksCovered_woodland + OPEX_friendly_transportCars_woodland + OPEX_friendly_combatCarsMG_woodland + OPEX_friendly_combatCarsGL_woodland + OPEX_friendly_vtt_woodland; OPEX_friendly_armoredVehicles = OPEX_friendly_tanks_woodland;
		OPEX_friendly_transportCars = OPEX_friendly_transportCars_woodland;
		OPEX_friendly_combatCarsMG = OPEX_friendly_combatCarsMG_woodland;
		OPEX_friendly_combatCarsGL = OPEX_friendly_combatCarsGL_woodland;
		OPEX_friendly_transportTrucksOpened = OPEX_friendly_transportTrucksOpened_woodland;
		OPEX_friendly_transportTrucksCovered = OPEX_friendly_transportTrucksCovered_woodland;
		OPEX_friendly_fuelTrucks = OPEX_friendly_fuelTrucks_woodland;
		OPEX_friendly_logisticTrucks = OPEX_friendly_logisticTrucks_woodland;
		OPEX_friendly_medicalTrucks = OPEX_friendly_medicalTrucks_woodland;
		OPEX_friendly_repairTrucks = OPEX_friendly_repairTrucks_woodland;
		OPEX_friendly_ammoTrucks = OPEX_friendly_ammoTrucks_woodland;
		OPEX_friendly_quads = OPEX_friendly_quads_woodland;
		OPEX_friendly_commonUniforms = OPEX_friendly_commonUniforms_woodland;
		OPEX_friendly_specialUniforms = OPEX_friendly_specialUniforms_woodland;
		OPEX_friendly_ghillieUniforms = OPEX_friendly_ghillieUniforms_woodland;
		OPEX_friendly_heliPilotUniforms = OPEX_friendly_heliPilotUniforms_woodland;
		OPEX_friendly_aircraftPilotUniforms = OPEX_friendly_aircraftPilotUniforms_woodland;
		OPEX_friendly_tankPilotUniforms = OPEX_friendly_tankPilotUniforms_woodland;
		OPEX_friendly_medicUniforms = OPEX_friendly_medicUniforms_woodland;
		OPEX_friendly_instructorUniforms = OPEX_friendly_instructorUniforms_woodland;
		OPEX_friendly_tshirtUniforms = OPEX_friendly_tshirtUniforms_woodland;
		OPEX_friendly_commonVests = OPEX_friendly_commonVests_woodland;
		OPEX_friendly_specialVests = OPEX_friendly_specialVests_woodland;
		OPEX_friendly_medicVests = OPEX_friendly_medicVests_woodland;
		OPEX_friendly_beltVests = OPEX_friendly_beltVests_woodland;
		OPEX_friendly_shoulderVests = OPEX_friendly_shoulderVests_woodland;
		OPEX_friendly_lightVests = OPEX_friendly_lightVests_woodland;
		OPEX_friendly_grenadierVests = OPEX_friendly_grenadierVests_woodland;
		OPEX_friendly_EODvests = OPEX_friendly_EODvests_woodland;
		OPEX_friendly_commonHelmets = OPEX_friendly_commonHelmets_woodland;
		OPEX_friendly_specialHelmets = OPEX_friendly_specialHelmets_woodland;
		OPEX_friendly_EODhelmets = OPEX_friendly_EODhelmets_woodland;
		OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland;
		OPEX_friendly_hats = OPEX_friendly_hats_woodland;
		OPEX_friendly_beanies = OPEX_friendly_beanies_woodland;
		OPEX_friendly_leaderHeadgear = OPEX_friendly_leaderHeadgear_woodland;
		OPEX_friendly_mediumBackpacks = OPEX_friendly_mediumBackpacks_woodland;
		OPEX_friendly_bigBackpacks = OPEX_friendly_bigBackpacks_woodland;
		OPEX_friendly_medicBackpacks = OPEX_friendly_medicBackpacks_woodland;
		OPEX_friendly_radioBackpacks = OPEX_friendly_radioBackpacks_woodland;
	};
private _desert = 
	{
		OPEX_friendly_vehicles = OPEX_friendly_transportTrucksOpened_desert + OPEX_friendly_transportTrucksCovered_desert + OPEX_friendly_fuelTrucks_desert + OPEX_friendly_logisticTrucks_desert + OPEX_friendly_medicalTrucks_desert + OPEX_friendly_repairTrucks_desert + OPEX_friendly_ammoTrucks_desert + OPEX_friendly_transportCars_desert + OPEX_friendly_combatCarsMG_desert + OPEX_friendly_combatCarsGL_desert + OPEX_friendly_vtt_desert + OPEX_friendly_tanks_desert + OPEX_friendly_quads_desert + OPEX_friendly_zodiacs + OPEX_friendly_ships + OPEX_friendly_aircrafts + OPEX_friendly_smallCombatHelicopters_desert + OPEX_friendly_mediumCombatHelicopters_desert + OPEX_friendly_smallTransportHelicopters_desert + OPEX_friendly_mediumTransportHelicopters_desert + OPEX_friendly_bigTransportHelicopters_desert + OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones + OPEX_friendly_MGstatics + OPEX_friendly_GLstatics + OPEX_friendly_ATstatics + OPEX_friendly_mortarStatics;
		OPEX_friendly_choppers = OPEX_friendly_smallCombatHelicopters_desert + OPEX_friendly_mediumCombatHelicopters_desert + OPEX_friendly_smallTransportHelicopters_desert + OPEX_friendly_mediumTransportHelicopters_desert + OPEX_friendly_bigTransportHelicopters_desert;
		OPEX_friendly_smallTransportHelicopters = OPEX_friendly_smallTransportHelicopters_desert;
		OPEX_friendly_mediumTransportHelicopters = OPEX_friendly_mediumTransportHelicopters_desert;
		OPEX_friendly_bigTransportHelicopters = OPEX_friendly_bigTransportHelicopters_desert;
		OPEX_friendly_smallCombatHelicopters = OPEX_friendly_smallCombatHelicopters_desert;
		OPEX_friendly_mediumCombatHelicopters = OPEX_friendly_mediumCombatHelicopters_desert;
		OPEX_friendly_tanks = OPEX_friendly_tanks_desert;
		OPEX_friendly_vtt = OPEX_friendly_vtt_desert;
		OPEX_friendly_mechanizedVehicles = OPEX_friendly_transportTrucksOpened_desert + OPEX_friendly_transportTrucksCovered_desert + OPEX_friendly_transportCars_desert + OPEX_friendly_combatCarsMG_desert + OPEX_friendly_combatCarsGL_desert + OPEX_friendly_vtt_desert; OPEX_friendly_armoredVehicles = OPEX_friendly_tanks_desert;
		OPEX_friendly_transportCars = OPEX_friendly_transportCars_desert;
		OPEX_friendly_combatCarsMG = OPEX_friendly_combatCarsMG_desert;
		OPEX_friendly_combatCarsGL = OPEX_friendly_combatCarsGL_desert;
		OPEX_friendly_transportTrucksOpened = OPEX_friendly_transportTrucksOpened_desert;
		OPEX_friendly_transportTrucksCovered = OPEX_friendly_transportTrucksCovered_desert;
		OPEX_friendly_fuelTrucks = OPEX_friendly_fuelTrucks_desert;
		OPEX_friendly_logisticTrucks = OPEX_friendly_logisticTrucks_desert;
		OPEX_friendly_medicalTrucks = OPEX_friendly_medicalTrucks_desert;
		OPEX_friendly_repairTrucks = OPEX_friendly_repairTrucks_desert;
		OPEX_friendly_ammoTrucks = OPEX_friendly_ammoTrucks_desert;
		OPEX_friendly_quads = OPEX_friendly_quads_desert;
		OPEX_friendly_commonUniforms = OPEX_friendly_commonUniforms_desert;
		OPEX_friendly_specialUniforms = OPEX_friendly_specialUniforms_desert;
		OPEX_friendly_ghillieUniforms = OPEX_friendly_ghillieUniforms_desert;
		OPEX_friendly_heliPilotUniforms = OPEX_friendly_heliPilotUniforms_desert;
		OPEX_friendly_aircraftPilotUniforms = OPEX_friendly_aircraftPilotUniforms_desert;
		OPEX_friendly_tankPilotUniforms = OPEX_friendly_tankPilotUniforms_desert;
		OPEX_friendly_medicUniforms = OPEX_friendly_medicUniforms_desert;
		OPEX_friendly_instructorUniforms = OPEX_friendly_instructorUniforms_desert;
		OPEX_friendly_tshirtUniforms = OPEX_friendly_tshirtUniforms_desert;
		OPEX_friendly_commonVests = OPEX_friendly_commonVests_desert;
		OPEX_friendly_specialVests = OPEX_friendly_specialVests_desert;
		OPEX_friendly_medicVests = OPEX_friendly_medicVests_desert;
		OPEX_friendly_beltVests = OPEX_friendly_beltVests_desert;
		OPEX_friendly_shoulderVests = OPEX_friendly_shoulderVests_desert;
		OPEX_friendly_lightVests = OPEX_friendly_lightVests_desert;
		OPEX_friendly_grenadierVests = OPEX_friendly_grenadierVests_desert;
		OPEX_friendly_EODvests = OPEX_friendly_EODvests_desert;
		OPEX_friendly_commonHelmets = OPEX_friendly_commonHelmets_desert;
		OPEX_friendly_specialHelmets = OPEX_friendly_specialHelmets_desert;
		OPEX_friendly_EODhelmets = OPEX_friendly_EODhelmets_desert;
		OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_desert;
		OPEX_friendly_hats = OPEX_friendly_hats_desert;
		OPEX_friendly_beanies = OPEX_friendly_beanies_desert;
		OPEX_friendly_leaderHeadgear = OPEX_friendly_leaderHeadgear_desert;
		OPEX_friendly_mediumBackpacks = OPEX_friendly_mediumBackpacks_desert;
		OPEX_friendly_bigBackpacks = OPEX_friendly_bigBackpacks_desert;
		OPEX_friendly_medicBackpacks = OPEX_friendly_medicBackpacks_desert;
		OPEX_friendly_radioBackpacks = OPEX_friendly_radioBackpacks_desert;
	};

private _snow = 
	{
		OPEX_friendly_vehicles = OPEX_friendly_transportTrucksOpened_snow + OPEX_friendly_transportTrucksCovered_snow + OPEX_friendly_fuelTrucks_snow + OPEX_friendly_logisticTrucks_snow + OPEX_friendly_medicalTrucks_snow + OPEX_friendly_repairTrucks_snow + OPEX_friendly_ammoTrucks_snow + OPEX_friendly_transportCars_snow + OPEX_friendly_combatCarsMG_snow + OPEX_friendly_combatCarsGL_snow + OPEX_friendly_vtt_snow + OPEX_friendly_tanks_snow + OPEX_friendly_quads_snow + OPEX_friendly_zodiacs + OPEX_friendly_ships + OPEX_friendly_aircrafts + OPEX_friendly_smallCombatHelicopters_snow + OPEX_friendly_mediumCombatHelicopters_snow + OPEX_friendly_smallTransportHelicopters_snow + OPEX_friendly_mediumTransportHelicopters_snow + OPEX_friendly_bigTransportHelicopters_snow + OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones + OPEX_friendly_MGstatics + OPEX_friendly_GLstatics + OPEX_friendly_ATstatics + OPEX_friendly_mortarStatics;
		OPEX_friendly_choppers = OPEX_friendly_smallCombatHelicopters_snow + OPEX_friendly_mediumCombatHelicopters_snow + OPEX_friendly_smallTransportHelicopters_snow + OPEX_friendly_mediumTransportHelicopters_snow + OPEX_friendly_bigTransportHelicopters_snow;
		OPEX_friendly_smallTransportHelicopters = OPEX_friendly_smallTransportHelicopters_snow;
		OPEX_friendly_mediumTransportHelicopters = OPEX_friendly_mediumTransportHelicopters_snow;
		OPEX_friendly_bigTransportHelicopters = OPEX_friendly_bigTransportHelicopters_snow;
		OPEX_friendly_smallCombatHelicopters = OPEX_friendly_smallCombatHelicopters_snow;
		OPEX_friendly_mediumCombatHelicopters = OPEX_friendly_mediumCombatHelicopters_snow;
		OPEX_friendly_tanks = OPEX_friendly_tanks_snow;
		OPEX_friendly_vtt = OPEX_friendly_vtt_snow;
		OPEX_friendly_mechanizedVehicles = OPEX_friendly_transportTrucksOpened_snow + OPEX_friendly_transportTrucksCovered_snow + OPEX_friendly_transportCars_snow + OPEX_friendly_combatCarsMG_snow + OPEX_friendly_combatCarsGL_snow + OPEX_friendly_vtt_snow; OPEX_friendly_armoredVehicles = OPEX_friendly_tanks_snow;
		OPEX_friendly_transportCars = OPEX_friendly_transportCars_snow;
		OPEX_friendly_combatCarsMG = OPEX_friendly_combatCarsMG_snow;
		OPEX_friendly_combatCarsGL = OPEX_friendly_combatCarsGL_snow;
		OPEX_friendly_transportTrucksOpened = OPEX_friendly_transportTrucksOpened_snow;
		OPEX_friendly_transportTrucksCovered = OPEX_friendly_transportTrucksCovered_snow;
		OPEX_friendly_fuelTrucks = OPEX_friendly_fuelTrucks_snow;
		OPEX_friendly_logisticTrucks = OPEX_friendly_logisticTrucks_snow;
		OPEX_friendly_medicalTrucks = OPEX_friendly_medicalTrucks_snow;
		OPEX_friendly_repairTrucks = OPEX_friendly_repairTrucks_snow;
		OPEX_friendly_ammoTrucks = OPEX_friendly_ammoTrucks_snow;
		OPEX_friendly_quads = OPEX_friendly_quads_snow;
		OPEX_friendly_commonUniforms = OPEX_friendly_commonUniforms_snow;
		OPEX_friendly_specialUniforms = OPEX_friendly_specialUniforms_snow;
		OPEX_friendly_ghillieUniforms = OPEX_friendly_ghillieUniforms_snow;
		OPEX_friendly_heliPilotUniforms = OPEX_friendly_heliPilotUniforms_snow;
		OPEX_friendly_aircraftPilotUniforms = OPEX_friendly_aircraftPilotUniforms_snow;
		OPEX_friendly_tankPilotUniforms = OPEX_friendly_tankPilotUniforms_snow;
		OPEX_friendly_medicUniforms = OPEX_friendly_medicUniforms_snow;
		OPEX_friendly_instructorUniforms = OPEX_friendly_instructorUniforms_snow;
		OPEX_friendly_tshirtUniforms = OPEX_friendly_tshirtUniforms_snow;
		OPEX_friendly_commonVests = OPEX_friendly_commonVests_snow;
		OPEX_friendly_specialVests = OPEX_friendly_specialVests_snow;
		OPEX_friendly_medicVests = OPEX_friendly_medicVests_snow;
		OPEX_friendly_beltVests = OPEX_friendly_beltVests_snow;
		OPEX_friendly_shoulderVests = OPEX_friendly_shoulderVests_snow;
		OPEX_friendly_lightVests = OPEX_friendly_lightVests_snow;
		OPEX_friendly_grenadierVests = OPEX_friendly_grenadierVests_snow;
		OPEX_friendly_EODvests = OPEX_friendly_EODvests_snow;
		OPEX_friendly_commonHelmets = OPEX_friendly_commonHelmets_snow;
		OPEX_friendly_specialHelmets = OPEX_friendly_specialHelmets_snow;
		OPEX_friendly_EODhelmets = OPEX_friendly_EODhelmets_snow;
		OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_snow;
		OPEX_friendly_hats = OPEX_friendly_hats_snow;
		OPEX_friendly_beanies = OPEX_friendly_beanies_snow;
		OPEX_friendly_leaderHeadgear = OPEX_friendly_leaderHeadgear_snow;
		OPEX_friendly_mediumBackpacks = OPEX_friendly_mediumBackpacks_snow;
		OPEX_friendly_bigBackpacks = OPEX_friendly_bigBackpacks_snow;
		OPEX_friendly_medicBackpacks = OPEX_friendly_medicBackpacks_snow;
		OPEX_friendly_radioBackpacks = OPEX_friendly_radioBackpacks_snow;
	};

// SELECTING PROPER CAMO (DEPENDING ON MAP CLIMATE/REGION)
switch (OPEX_mapClimate) do 
	{
		case "arctic" :	{call _snow};
		default 
				{
					switch (OPEX_mapRegion) do 
						{
							case "europe"		:	{call _woodland};
							case "america"		:	{call _woodland};
							case "pacific"		:	{call _woodland};	
							case "asia"			:	{call _woodland};						
							case "africa"		:	{call _desert};
							case "middleEast" 	: 	{if (OPEX_friendly_flag_marker == "flag_France") then {call _woodland} else {call _desert}}; // France is using woodland camo in Middle-East
							default 				{call _woodland};
						};
				};
	};