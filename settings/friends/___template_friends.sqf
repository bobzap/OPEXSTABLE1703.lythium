/*
	=======================================================================================================================
	NOTES FOR MISSION EDITORS (please take a few time to read and understand these lines to avoid any issue)
	=======================================================================================================================

	 - Adding custom mods into OPEX is your responsibility, so if you do so, please do it at your own risk and don't complain if something doesn't work as intended.
	 - Adding custom mods into OPEX requires some scripting skills and above all a lot of concentration - a single wrong data can break the whole mission so keep that in mind at any time.
	 - Keep the same variables types : some of them must be strings (""), some others are arrays ([]) etc... so double check before doing anything.
	 - Do NOT delete anything in PART 2.
	 - Do NOT edit or delete anything in PART 3.
	 - Do NOT let any variable undefined or empty in PART 4.
	 - If you want to add something to the vanilla content (if variable is an array), use this command: OPEX_exampleArray append ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - If you want to replace the vanilla content (if variable is an array), use this command: OPEX_exampleArray = ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - So be aware of how the variables are defined (with " = " or " append ") !
	 - If you want to use vanilla content, simply remove the data (for example, if your mod doesn't have any aircraft, simply remove the line that defines OPEX_friendly_aircrafts).
	 - Tip: if you want to increase the probability of usage of a specific item, list it several times (example: OPEX_exampleArray = ["myCustomData1", "myCustomData1", "myCustomData1", ""myCustomData2"] means that "myCustomData1" has 3 times more chances to be used than "myCustomData2")
	 - When your template is ready, don't forget to enable it by editing the "settings\init.sqf" file.
	 - If you want your custom mod to be officially integrated into OPEX, please be sure your template is 100% working and send it to gemini.69@free.fr

	If you need help, please contact me:
	 - on the OPEX public comments on Steam (please do NOT add me to your friend list): https://steamcommunity.com/workshop/filedetails/?id=908003375
	 - on the official OPEX forum: https://forums.bohemia.net/forums/topic/194070-opex/
	 - by email: gemini.69@free.fr

	I will provide as much support as I can but please keep in mind that I'm alone and I'm developping OPEX on my free time.

	- Gemini
*/

// =======================================================================================================================
// PART 1 (you need AT LEAST ONE ENTRY to avoid this custom mod loading on computers that don't have it)
// =======================================================================================================================

	if (!(isClass (configFile >> "CfgPatches" >> "xxxxx"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "myCustomMod"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_USA"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

// =======================================================================================================================
// PART 3 (DO NOT EDIT OR DELETE these lines !)
// =======================================================================================================================

	// ENABLING FACTION
	waitUntil {!isNil "OPEX_friendly_factions"};
	if (isServer) then {OPEX_friendly_factions append [[_OPEX_friendly_subFaction, _OPEX_friendly_modName]]}; publicVariable "OPEX_friendly_factions";

	// WAITING FOR FACTION SELECTION
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};
	if (!(OPEX_param_friendlyFaction isEqualTo [_OPEX_friendly_subFaction, _OPEX_friendly_modName])) exitWith {};

	// CONFIRMING FACTION NAMES
	OPEX_friendly_modName = _OPEX_friendly_modName;
	OPEX_friendly_factionName = _OPEX_friendly_factionName;
	OPEX_friendly_subFaction = _OPEX_friendly_subFaction;

// =======================================================================================================================
// PART 4 (DO NOT LET ANY VARIABLE UNDEFINED OR EMPTY)
//		- if you don't know what a variable is about, please ask
//		- if you don't need to define a variable, simply delete the line (default content will be used instead)
// =======================================================================================================================

	// ARMY NAME
	OPEX_friendly_army = localize "STR_friendly_army_us"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_USA"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_usa.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_usa.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Gemini"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_gemini.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_generic.paa";
	OPEX_sign_armory = "pictures\sign_armory_generic.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_generic.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_generic.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_generic.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_generic.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_generic.paa";
	OPEX_sign_jail = "pictures\sign_jail_generic.paa";
	OPEX_sign_medical = "pictures\sign_medical_generic.paa";
	OPEX_sign_practice = "pictures\sign_practice_generic.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_generic.paa";
	OPEX_sign_toc = "pictures\sign_toc_generic.paa";
	OPEX_sign_training = "pictures\sign_training_generic.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_generic.paa";
	OPEX_sign_showers = "pictures\sign_showers_generic.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_generic.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_generic.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing.paa";
	OPEX_tv = "pictures\tv_generic.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_generic.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = []; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = [];
	OPEX_friendly_transportTrucksOpened_desert = [];
	OPEX_friendly_transportTrucksOpened_snow = [];
	OPEX_friendly_transportTrucksCovered_woodland = [];
	OPEX_friendly_transportTrucksCovered_desert = [];
	OPEX_friendly_transportTrucksCovered_snow = [];
	OPEX_friendly_fuelTrucks_woodland = [];
	OPEX_friendly_fuelTrucks_desert = [];
	OPEX_friendly_fuelTrucks_snow = [];
	OPEX_friendly_logisticTrucks_woodland = [];
	OPEX_friendly_logisticTrucks_desert = [];
	OPEX_friendly_logisticTrucks_snow = [];
	OPEX_friendly_medicalTrucks_woodland = [];
	OPEX_friendly_medicalTrucks_desert = [];
	OPEX_friendly_medicalTrucks_snow = [];
	OPEX_friendly_repairTrucks_woodland = [];
	OPEX_friendly_repairTrucks_desert = [];
	OPEX_friendly_repairTrucks_snow = [];
	OPEX_friendly_ammoTrucks_woodland = [];
	OPEX_friendly_ammoTrucks_desert = [];
	OPEX_friendly_ammoTrucks_snow = [];
	OPEX_friendly_transportCars_woodland = [];
	OPEX_friendly_transportCars_desert = [];
	OPEX_friendly_transportCars_snow = [];
	OPEX_friendly_combatCarsMG_woodland = [];
	OPEX_friendly_combatCarsMG_desert = [];
	OPEX_friendly_combatCarsMG_snow = [];
	OPEX_friendly_combatCarsGL_woodland = [];
	OPEX_friendly_combatCarsGL_desert = [];
	OPEX_friendly_combatCarsGL_snow = [];
	OPEX_friendly_vtt_woodland = [];
	OPEX_friendly_vtt_desert = [];
	OPEX_friendly_vtt_snow = [];
	OPEX_friendly_tanks_woodland = [];
	OPEX_friendly_tanks_desert = [];
	OPEX_friendly_tanks_snow = [];
	OPEX_friendly_quads_woodland = [];
	OPEX_friendly_quads_desert = [];
	OPEX_friendly_quads_snow = [];
	OPEX_friendly_zodiacs = [];
	OPEX_friendly_ships = [];
	OPEX_friendly_aircrafts = [];
	OPEX_friendly_smallCombatHelicopters_woodland = [];
	OPEX_friendly_smallCombatHelicopters_desert = [];
	OPEX_friendly_smallCombatHelicopters_snow = [];
	OPEX_friendly_mediumCombatHelicopters_woodland = [];
	OPEX_friendly_mediumCombatHelicopters_desert = [];
	OPEX_friendly_mediumCombatHelicopters_snow = [];
	OPEX_friendly_smallTransportHelicopters_woodland = [];
	OPEX_friendly_smallTransportHelicopters_desert = [];
	OPEX_friendly_smallTransportHelicopters_snow = [];
	OPEX_friendly_mediumTransportHelicopters_woodland = [];
	OPEX_friendly_mediumTransportHelicopters_desert = [];
	OPEX_friendly_mediumTransportHelicopters_snow = [];
	OPEX_friendly_bigTransportHelicopters_woodland = [];
	OPEX_friendly_bigTransportHelicopters_desert = [];
	OPEX_friendly_bigTransportHelicopters_snow = [];
	OPEX_friendly_UAVs = [];
	OPEX_friendly_UGVs = [];
	OPEX_friendly_portableDrones = [];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = [];
	OPEX_friendly_GLstatics = [];
	OPEX_friendly_ATstatics = [];
	OPEX_friendly_AAstatics = [];
	OPEX_friendly_mortarStatics = [];

	// WEAPONS
	OPEX_friendly_commonHandguns = [];
	OPEX_friendly_specialHandguns = [];
	OPEX_friendly_commonRifles = [];
	OPEX_friendly_specialRifles = [];
	OPEX_friendly_GLrifles = [];
	OPEX_friendly_MGriflesLight = [];
	OPEX_friendly_MGriflesHeavy = [];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = [];
	OPEX_friendly_precisionRifles = [];
	OPEX_friendly_sniperRifles = [];
	OPEX_friendly_ATlaunchers = [];
	OPEX_friendly_AAlaunchers = [];
	OPEX_friendly_shotguns = [];
	OPEX_friendly_diverRifles = [];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append [];
	OPEX_friendly_distantCombatOptics append [];
	OPEX_friendly_sniperOptics append [];
	OPEX_friendly_flashlights append [];
	OPEX_friendly_rifleSilencers append [];
	OPEX_friendly_handgunSilencers append [];
	OPEX_friendly_pointers append [];
	OPEX_friendly_bipods append [];

	// VARIOUS ITEMS
	OPEX_friendly_handGrenades append [];
	OPEX_friendly_stunGrenades append [];
	OPEX_friendly_smokeGrenades_white append [];
	OPEX_friendly_smokeGrenades_colors append [];
	OPEX_friendly_paintSprays append [];
	OPEX_friendly_chemlights append [];
	OPEX_friendly_IRs append [];
	OPEX_friendly_explosives append [];
	OPEX_friendly_NVGs append [];
	OPEX_friendly_commonBinoculars append [];
	OPEX_friendly_spotterBinoculars append [];
	OPEX_friendly_laserDesignators append [];
	OPEX_friendly_toolKits append [];
	OPEX_friendly_medikits append ];
	OPEX_friendly_mineDetectors append [];
	OPEX_friendly_radiosShortDistance append [];
	OPEX_friendly_radiosLongDistance append [];
	OPEX_friendly_droneTerminals append [];
	OPEX_friendly_tablets append [];
	OPEX_friendly_earplugs append [];
	OPEX_friendly_mapTools append [];
	OPEX_friendly_rangeCards append [];
	OPEX_friendly_sniperPDAs append [];
	OPEX_friendly_weatherPDAs append [];
	OPEX_friendly_advancedGPS append [];
	OPEX_friendly_sandbags append [];
	OPEX_friendly_tripods append [];
	OPEX_friendly_HuntIRs append [];
	OPEX_friendly_altimeters append [];
	OPEX_friendly_ladders append [];
	OPEX_medical_medikits append [];
	OPEX_medical_firstAidKit = "";
	OPEX_medical_defibrillator = "";
	OPEX_medical_commonSupplies append [];
	OPEX_medical_advancedSupplies append [];
	OPEX_medical_supplies = OPEX_medical_medikits + [OPEX_medical_firstAidKit] + [OPEX_medical_defibrillator] + OPEX_medical_commonSupplies + OPEX_medical_advancedSupplies; // don't delete this line if you have defined any of these variables
	OPEX_cableTies append [];
	OPEX_bioScans append [];
	OPEX_spyMicros append [];
	OPEX_canteenItems append [];
	OPEX_sleepingBags append [];
	OPEX_entrenchingTools append [];
	OPEX_ConcertinaWireCoils append [];
	OPEX_wireCutters append [];
	OPEX_flashlights append [];
	OPEX_constructions append [];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = [];
	OPEX_friendly_commonUniforms_desert = [];
	OPEX_friendly_commonUniforms_snow = [];
	OPEX_friendly_specialUniforms_woodland = [];
	OPEX_friendly_specialUniforms_desert = [];
	OPEX_friendly_specialUniforms_snow = [];
	OPEX_friendly_ghillieUniforms_woodland = [];
	OPEX_friendly_ghillieUniforms_desert = [];
	OPEX_friendly_ghillieUniforms_snow = [];
	OPEX_friendly_heliPilotUniforms_woodland = [];
	OPEX_friendly_heliPilotUniforms_desert = [];
	OPEX_friendly_heliPilotUniforms_snow = [];
	OPEX_friendly_aircraftPilotUniforms_woodland = [];
	OPEX_friendly_aircraftPilotUniforms_desert = [];
	OPEX_friendly_aircraftPilotUniforms_snow = [];
	OPEX_friendly_tankPilotUniforms_woodland = [];
	OPEX_friendly_tankPilotUniforms_desert = [];
	OPEX_friendly_tankPilotUniforms_snow = [];
	OPEX_friendly_medicUniforms_woodland = [];
	OPEX_friendly_medicUniforms_desert = [];
	OPEX_friendly_medicUniforms_snow = [];
	OPEX_friendly_instructorUniforms_woodland = [];
	OPEX_friendly_instructorUniforms_desert = [];
	OPEX_friendly_instructorUniforms_snow = [];
	OPEX_friendly_tshirtUniforms_woodland = [];
	OPEX_friendly_tshirtUniforms_desert = [];
	OPEX_friendly_tshirtUniforms_snow = [];
	OPEX_friendly_diverUniforms = [];

	// VESTS
	OPEX_friendly_commonVests_woodland append [];
	OPEX_friendly_commonVests_desert append [];
	OPEX_friendly_commonVests_snow append [];
	OPEX_friendly_specialVests_woodland append [];
	OPEX_friendly_specialVests_desert append [];
	OPEX_friendly_specialVests_snow append [];
	OPEX_friendly_medicVests_woodland append [];
	OPEX_friendly_medicVests_desert append [];
	OPEX_friendly_medicVests_snow append [];
	OPEX_friendly_beltVests_woodland append [];
	OPEX_friendly_beltVests_desert append [];
	OPEX_friendly_beltVests_snow append [];
	OPEX_friendly_shoulderVests_woodland append [];
	OPEX_friendly_shoulderVests_desert append [];
	OPEX_friendly_shoulderVests_snow append [];
	OPEX_friendly_lightVests_woodland append [];
	OPEX_friendly_lightVests_desert append [];
	OPEX_friendly_lightVests_snow append [];
	OPEX_friendly_grenadierVests_woodland append [];
	OPEX_friendly_grenadierVests_desert append [];
	OPEX_friendly_grenadierVests_snow append [];
	OPEX_friendly_EODvests_woodland append [];
	OPEX_friendly_EODvests_desert append [];
	OPEX_friendly_EODvests_snow append [];
	OPEX_friendly_diverVests append [];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = [];
	OPEX_friendly_commonHelmets_desert = [];
	OPEX_friendly_commonHelmets_snow = [];
	OPEX_friendly_specialHelmets_woodland append [];
	OPEX_friendly_specialHelmets_desert append [];
	OPEX_friendly_specialHelmets_snow append [];
	OPEX_friendly_EODhelmets_woodland = [];
	OPEX_friendly_EODhelmets_desert = [];
	OPEX_friendly_EODhelmets_snow = [];
	OPEX_friendly_heliPilotHelmets = [];
	OPEX_friendly_aircraftPilotHelmets = [];
	OPEX_friendly_tankCrewHelmets = [];
	OPEX_friendly_cameraHelmets_woodland append [];
	OPEX_friendly_cameraHelmets_desert append [];
	OPEX_friendly_cameraHelmets_snow append [];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland append [];
	OPEX_friendly_hats_desert append [];
	OPEX_friendly_hats_snow append [];
	OPEX_friendly_beanies_woodland append [];
	OPEX_friendly_beanies_desert append [];
	OPEX_friendly_beanies_snow append [];
	OPEX_friendly_leaderHeadgear_woodland append [];
	OPEX_friendly_leaderHeadgear_desert append [];
	OPEX_friendly_leaderHeadgear_snow append [];
	OPEX_friendly_berets append [];
	OPEX_friendly_caps append [];
	OPEX_friendly_bandanas append [];
	OPEX_friendly_shemags append [];
	OPEX_friendly_headsets append [];

	// FACEGEAR
	OPEX_friendly_balaclavas append [];
	OPEX_friendly_scarfs append [];
	OPEX_friendly_glasses append [];
	OPEX_friendly_sunglasses append [];
	OPEX_friendly_tacticalGlasses append [];
	OPEX_friendly_diverGlasses append [];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland append [];
	OPEX_friendly_mediumBackpacks_desert append [];
	OPEX_friendly_mediumBackpacks_snow append [];
	OPEX_friendly_bigBackpacks_woodland append [];
	OPEX_friendly_bigBackpacks_desert append [];
	OPEX_friendly_bigBackpacks_snow append [];
	OPEX_friendly_medicBackpacks_woodland = [];
	OPEX_friendly_medicBackpacks_desert = [];
	OPEX_friendly_medicBackpacks_snow = [];
	OPEX_friendly_radioBackpacks_woodland append [];
	OPEX_friendly_radioBackpacks_desert append [];
	OPEX_friendly_radioBackpacks_snow append [];
	OPEX_friendly_diverBackpacks append [];
	OPEX_friendly_parachutes append [];
	OPEX_friendly_portableDronesBackpack = [];