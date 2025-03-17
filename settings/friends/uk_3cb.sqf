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
	 - Tip: if you want to increase the probability of usaage of a specific item, list it several times (example: OPEX_exampleArray = ["myCustomData1", "myCustomData1", "myCustomData1", ""myCustomData2"] means that "myCustomData1" has 3 times more chances to be used than "myCustomData2")
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

	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_BAF_Equipment"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_BAF_Vehicles"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_BAF_Units_Common"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_BAF_Weapons"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "RKSL_Attachments_core"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "3CB"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_UK"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_uk"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_UK"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_uk.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_uk.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Majesty"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_uk.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

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
	OPEX_briefingBoard = "pictures\briefingboard_uk.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_uk.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_uk.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_uk.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_uk.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_uk.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_uk.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_uk.paa";
	OPEX_tv = "pictures\tv_uk.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_uk.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["british_01", "british_02", "british_03", "british_04", "british_05", "british_06", "british_07", "british_08", "british_09", "british_10", "british_11", "british_12", "british_13", "british_14", "british_15", "british_16", "british_17", "british_18", "british_19", "british_20", "british_21", "british_22", "british_23", "british_24", "british_25", "british_26", "british_27", "british_28", "british_29", "british_30", "british_31", "british_32", "british_33", "british_34", "british_35", "british_36", "british_37", "british_38", "british_39", "british_40", "british_41", "british_42", "british_43", "british_44", "british_45", "british_46", "british_47", "british_48", "british_49", "british_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["UK3CB_BAF_MAN_HX60_Transport_Green_MTP","UK3CB_BAF_MAN_HX58_Transport_Green_MTP"];
	OPEX_friendly_transportTrucksOpened_desert = ["UK3CB_BAF_MAN_HX58_Transport_Sand_DDPM","UK3CB_BAF_MAN_HX60_Transport_Sand_DDPM"];
	OPEX_friendly_transportTrucksOpened_snow = ["UK3CB_BAF_MAN_HX58_Transport_Green_Arctic","UK3CB_BAF_MAN_HX60_Transport_Green_Arctic"];
	OPEX_friendly_transportTrucksCovered_woodland = ["UK3CB_BAF_MAN_HX60_Transport_Green_MTP","UK3CB_BAF_MAN_HX58_Transport_Green_MTP"];
	OPEX_friendly_transportTrucksCovered_desert = ["UK3CB_BAF_MAN_HX58_Transport_Sand_DDPM","UK3CB_BAF_MAN_HX60_Transport_Sand_DDPM"];
	OPEX_friendly_transportTrucksCovered_snow = ["UK3CB_BAF_MAN_HX58_Transport_Green_Arctic","UK3CB_BAF_MAN_HX60_Transport_Green_Arctic"];
	OPEX_friendly_fuelTrucks_woodland = ["UK3CB_BAF_MAN_HX60_Fuel_Green_MTP","UK3CB_BAF_MAN_HX58_Fuel_Green_MTP"];
	OPEX_friendly_fuelTrucks_desert = ["UK3CB_BAF_MAN_HX60_Fuel_Sand_DDPM","UK3CB_BAF_MAN_HX58_Fuel_Sand_DDPM"];
	OPEX_friendly_fuelTrucks_snow = ["UK3CB_BAF_MAN_HX60_Fuel_Green_Arctic","UK3CB_BAF_MAN_HX58_Fuel_Green_Arctic"];
	OPEX_friendly_logisticTrucks_woodland = ["UK3CB_BAF_MAN_HX58_Cargo_Green_B_MTP"];
	OPEX_friendly_logisticTrucks_desert = ["UK3CB_BAF_MAN_HX58_Cargo_Sand_B_DDPM"];
	OPEX_friendly_logisticTrucks_snow = ["UK3CB_BAF_MAN_HX58_Cargo_Green_B_Arctic"];
	OPEX_friendly_medicalTrucks_woodland = ["UK3CB_BAF_LandRover_Amb_FFR_Green_A_MTP"];
	OPEX_friendly_medicalTrucks_desert = ["UK3CB_BAF_LandRover_Amb_FFR_Sand_A_DDPM"];
	OPEX_friendly_medicalTrucks_snow = ["UK3CB_BAF_LandRover_Amb_FFR_Green_A_MTP"];
	OPEX_friendly_repairTrucks_woodland = ["UK3CB_BAF_MAN_HX60_Repair_Green_MTP","UK3CB_BAF_MAN_HX58_Repair_Green_MTP"];
	OPEX_friendly_repairTrucks_desert = ["UK3CB_BAF_MAN_HX60_Repair_Sand_DDPM","UK3CB_BAF_MAN_HX58_Repair_Sand_DDPM"];
	OPEX_friendly_repairTrucks_snow = ["UK3CB_BAF_MAN_HX58_Repair_Green_Arctic","UK3CB_BAF_MAN_HX60_Repair_Green_Arctic"];
	OPEX_friendly_ammoTrucks_woodland = ["UK3CB_BAF_MAN_HX60_Cargo_Green_B_MTP"];
	OPEX_friendly_ammoTrucks_desert = ["UK3CB_BAF_MAN_HX60_Cargo_Sand_B_DDPM"];
	OPEX_friendly_ammoTrucks_snow = ["UK3CB_BAF_MAN_HX60_Cargo_Green_B_Arctic"];
	OPEX_friendly_transportCars_woodland = ["UK3CB_BAF_LandRover_Hard_FFR_Green_A_MTP","UK3CB_BAF_LandRover_Snatch_FFR_Green_A_MTP","UK3CB_BAF_LandRover_Soft_FFR_Green_A_MTP"];
	OPEX_friendly_transportCars_desert = ["UK3CB_BAF_LandRover_Hard_FFR_Sand_A_DDPM","UK3CB_BAF_LandRover_Snatch_FFR_Sand_A_DDPM","UK3CB_BAF_LandRover_Soft_FFR_Sand_A_DDPM"];
	OPEX_friendly_transportCars_snow = ["UK3CB_BAF_LandRover_Hard_FFR_Arctic_A_Arctic","UK3CB_BAF_LandRover_Soft_FFR_Arctic_A_Arctic"];
	OPEX_friendly_combatCarsMG_woodland = ["UK3CB_BAF_Panther_GPMG_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_HMG_FFR_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_GPMG_FFR_Green_A_MTP"];
	OPEX_friendly_combatCarsMG_desert = ["UK3CB_BAF_Panther_GPMG_Sand_A_DDPM","UK3CB_BAF_LandRover_WMIK_HMG_FFR_Sand_A_DDPM","UK3CB_BAF_LandRover_WMIK_GPMG_FFR_Sand_A_DDPM"];
	OPEX_friendly_combatCarsMG_snow = ["UK3CB_BAF_Panther_GPMG_Green_A_Arctic","UK3CB_BAF_LandRover_WMIK_HMG_FFR_Sand_A_DDPM","UK3CB_BAF_LandRover_WMIK_GPMG_FFR_Sand_A_DDPM"];
	OPEX_friendly_combatCarsGL_woodland = ["UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_Milan_FFR_Green_A_MTP"];
	OPEX_friendly_combatCarsGL_desert = ["UK3CB_BAF_LandRover_WMIK_GMG_FFR_Sand_A_MTP","UK3CB_BAF_LandRover_WMIK_GMG_FFR_Sand_A_MTP","UK3CB_BAF_LandRover_WMIK_Milan_FFR_Sand_A_MTP"];
	OPEX_friendly_combatCarsGL_snow = ["UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_A_MTP","UK3CB_BAF_LandRover_WMIK_Milan_FFR_Green_A_MTP"];
	OPEX_friendly_vtt_woodland = ["UK3CB_BAF_Coyote_Logistics_L134A1_W_MTP","UK3CB_BAF_Coyote_Logistics_L111A1_W_MTP","UK3CB_BAF_Coyote_Passenger_L134A1_W_MTP","UK3CB_BAF_Coyote_Passenger_L111A1_W_MTP","UK3CB_BAF_Jackal2_GMG_W_MTP","UK3CB_BAF_Jackal2_L2A1_W_MTP"];
	OPEX_friendly_vtt_desert = ["UK3CB_BAF_Coyote_Logistics_L134A1_D_DDPM","UK3CB_BAF_Coyote_Logistics_L111A1_D_DDPM","UK3CB_BAF_Coyote_Passenger_L134A1_D_DDPM","UK3CB_BAF_Coyote_Passenger_L111A1_D_DDPM","UK3CB_BAF_Jackal2_GMG_D_DDPM","UK3CB_BAF_Jackal2_L2A1_D_DDPM"];
	OPEX_friendly_vtt_snow = ["UK3CB_BAF_Coyote_Logistics_L134A1_W_Arctic","UK3CB_BAF_Coyote_Logistics_L111A1_W_Arctic","UK3CB_BAF_Coyote_Passenger_L134A1_W_Arctic","UK3CB_BAF_Coyote_Passenger_L111A1_W_Arctic","UK3CB_BAF_Jackal2_GMG_W_Arctic","UK3CB_BAF_Jackal2_L2A1_W_Arctic"];
	OPEX_friendly_tanks_woodland = ["UK3CB_BAF_FV432_Mk3_GPMG_Green_MTP","UK3CB_BAF_FV432_Mk3_RWS_Green_MTP"];
	OPEX_friendly_tanks_desert = ["UK3CB_BAF_FV432_Mk3_GPMG_Sand_DDPM","UK3CB_BAF_FV432_Mk3_RWS_Sand_DDPM"];
	OPEX_friendly_tanks_snow = ["UK3CB_BAF_FV432_Mk3_GPMG_Green_MTP","UK3CB_BAF_FV432_Mk3_RWS_Green_MTP"];
	OPEX_friendly_ships = ["UK3CB_BAF_RHIB_HMG_MTP","UK3CB_BAF_RHIB_GPMG_MTP"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["UK3CB_BAF_Apache_AH1_AT_MTP","UK3CB_BAF_Apache_AH1_CAS_MTP","UK3CB_BAF_Apache_AH1_MTP","UK3CB_BAF_Apache_AH1_JS_MTP"];
	OPEX_friendly_smallCombatHelicopters_desert = ["UK3CB_BAF_Apache_AH1_AT_DDPM","UK3CB_BAF_Apache_AH1_CAS_DDPM","UK3CB_BAF_Apache_AH1_DDPM","UK3CB_BAF_Apache_AH1_JS_DDPM"];
	OPEX_friendly_smallCombatHelicopters_snow = ["UK3CB_BAF_Apache_AH1_AT_Arctic","UK3CB_BAF_Apache_AH1_CAS_Arctic","UK3CB_BAF_Apache_AH1_Arctic","UK3CB_BAF_Apache_AH1_JS_Arctic"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["UK3CB_BAF_Wildcat_AH1_CAS_6A_MTP","UK3CB_BAF_Wildcat_AH1_CAS_6B_MTP","UK3CB_BAF_Wildcat_AH1_CAS_6C_MTP","UK3CB_BAF_Wildcat_AH1_CAS_6D_MTP","UK3CB_BAF_Wildcat_AH1_HEL_6A_MTP"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["UK3CB_BAF_Wildcat_AH1_CAS_6A_DDPM","UK3CB_BAF_Wildcat_AH1_CAS_6B_DDPM","UK3CB_BAF_Wildcat_AH1_CAS_6C_DDPM","UK3CB_BAF_Wildcat_AH1_CAS_6D_DDPM","UK3CB_BAF_Wildcat_AH1_HEL_6A_DDPM"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["UK3CB_BAF_Wildcat_AH1_CAS_6A_Arctic","UK3CB_BAF_Wildcat_AH1_CAS_6B_Arctic","UK3CB_BAF_Wildcat_AH1_CAS_6C_Arctic","UK3CB_BAF_Wildcat_AH1_CAS_8D_Arctic","UK3CB_BAF_Wildcat_AH1_HEL_8A_Arctic"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_MTP","UK3CB_BAF_Wildcat_HMA2_TRN_8A_MTP"];
	OPEX_friendly_smallTransportHelicopters_desert = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_DDPM","UK3CB_BAF_Wildcat_HMA2_TRN_8A_DDPM"];
	OPEX_friendly_smallTransportHelicopters_snow = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_Arctic","UK3CB_BAF_Wildcat_HMA2_TRN_8A_Arctic"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_MTP","UK3CB_BAF_Wildcat_HMA2_TRN_8A_MTP"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_DDPM","UK3CB_BAF_Wildcat_HMA2_TRN_8A_DDPM"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["UK3CB_BAF_Wildcat_AH1_TRN_8A_Arctic","UK3CB_BAF_Wildcat_HMA2_TRN_8A_Arctic"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["UK3CB_BAF_Merlin_HC3_18_MTP","UK3CB_BAF_Merlin_HC3_18_GPMG_MTP","UK3CB_BAF_Merlin_HC3_24_MTP","UK3CB_BAF_Merlin_HC3_32_MTP","UK3CB_BAF_Merlin_HC3_Cargo_MTP","UK3CB_BAF_Merlin_HC3_CSAR_MTP","UK3CB_BAF_Merlin_HC4_18_MTP","UK3CB_BAF_Merlin_HC4_18_GPMG_MTP","UK3CB_BAF_Merlin_HC4_24_MTP","UK3CB_BAF_Merlin_HC4_32_MTP","UK3CB_BAF_Merlin_HC4_Cargo_MTP","UK3CB_BAF_Merlin_HC4_CSAR_MTP","UK3CB_BAF_Merlin_HM2_18_MTP"];
	OPEX_friendly_bigTransportHelicopters_desert = ["UK3CB_BAF_Merlin_HC3_18_DDPM","UK3CB_BAF_Merlin_HC3_18_GPMG_DDPM","UK3CB_BAF_Merlin_HC3_24_DDPM","UK3CB_BAF_Merlin_HC3_32_DDPM","UK3CB_BAF_Merlin_HC3_Cargo_DDPM","UK3CB_BAF_Merlin_HC3_CSAR_DDPM","UK3CB_BAF_Merlin_HC4_18_DDPM","UK3CB_BAF_Merlin_HC4_18_GPMG_DDPM","UK3CB_BAF_Merlin_HC4_24_DDPM","UK3CB_BAF_Merlin_HC4_32_DDPM","UK3CB_BAF_Merlin_HC4_Cargo_DDPM","UK3CB_BAF_Merlin_HC4_CSAR_DDPM","UK3CB_BAF_Merlin_HM2_18_DDPM"];
	OPEX_friendly_bigTransportHelicopters_snow = ["UK3CB_BAF_Merlin_HC3_18_Arctic","UK3CB_BAF_Merlin_HC3_18_GPMG_Arctic","UK3CB_BAF_Merlin_HC3_Cargo_Arctic","UK3CB_BAF_Merlin_HC3_CSAR_Arctic","UK3CB_BAF_Merlin_HC4_18_Arctic","UK3CB_BAF_Merlin_HC4_18_GPMG_Arctic","UK3CB_BAF_Merlin_HC4_24_Arctic","UK3CB_BAF_Merlin_HC4_32_Arctic","UK3CB_BAF_Merlin_HC4_Cargo_Arctic","UK3CB_BAF_Merlin_HC4_CSAR_Arctic","UK3CB_BAF_Merlin_HM2_18_Arctic"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["UK3CB_BAF_Static_L111A1_Deployed_High_MTP","UK3CB_BAF_Static_L111A1_Deployed_Low_MTP","UK3CB_BAF_Static_L111A1_Deployed_Mid_MTP","UK3CB_BAF_Static_L7A2_Deployed_High_MTP","UK3CB_BAF_Static_L7A2_Deployed_Low_MTP","UK3CB_BAF_Static_L7A2_Deployed_Mid_MTP"];
	OPEX_friendly_GLstatics = ["UK3CB_BAF_Static_L134A1_Deployed_High_MTP","UK3CB_BAF_Static_L134A1_Deployed_Low_MTP","UK3CB_BAF_Static_L134A1_Deployed_Mid_MTP"];
	OPEX_friendly_mortarStatics = ["UK3CB_BAF_Static_L16_Deployed_MTP","UK3CB_BAF_Static_M6_Deployed_MTP"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["UK3CB_BAF_L9A1","UK3CB_BAF_L105A1","UK3CB_BAF_L105A2"];
	OPEX_friendly_specialHandguns = ["UK3CB_BAF_L107A1","UK3CB_BAF_L117A2","UK3CB_BAF_L131A1"];
	OPEX_friendly_commonRifles = ["UK3CB_BAF_L85A2","UK3CB_BAF_L85A2","UK3CB_BAF_L85A2","UK3CB_BAF_L85A2_RIS_AFG"];
	OPEX_friendly_specialRifles = ["UK3CB_BAF_L85A2_RIS","UK3CB_BAF_L86A2","UK3CB_BAF_L86A3","UK3CB_BAF_L119A1","UK3CB_BAF_L119A1_FG"];
	OPEX_friendly_GLrifles = ["UK3CB_BAF_L85A2_UGL","UK3CB_BAF_L85A2_UGL","UK3CB_BAF_L85A2_UGL_HWS","UK3CB_BAF_L119A1_UKUGL"];
	OPEX_friendly_MGriflesLight = ["UK3CB_BAF_L110A1","UK3CB_BAF_L110A2","UK3CB_BAF_L110A2RIS","UK3CB_BAF_L110A3"];
	OPEX_friendly_MGriflesHeavy = ["UK3CB_BAF_L110_762","UK3CB_BAF_L7A2"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["UK3CB_BAF_L91A1","UK3CB_BAF_L92A1","UK3CB_BAF_L119A1_CQB","UK3CB_BAF_L22A2"];
	OPEX_friendly_precisionRifles = ["UK3CB_BAF_L115A3_BL"];
	OPEX_friendly_sniperRifles = ["UK3CB_BAF_L115A3_BL_Ghillie","UK3CB_BAF_L118A1_Covert_BL","UK3CB_BAF_L135A1"];
	OPEX_friendly_ATlaunchers = ["UK3CB_BAF_AT4_CS_AP_Launcher","UK3CB_BAF_AT4_CS_AT_Launcher","UK3CB_BAF_NLAW_Launcher"];
	OPEX_friendly_shotguns = ["UK3CB_BAF_L128A1"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["RKSL_optic_EOT552","RKSL_optic_EOT552X","RKSL_optic_RMR_MS19","RKSL_optic_RMR_RM33"];
	OPEX_friendly_distantCombatOptics append ["UK3CB_BAF_SpecterLDS","UK3CB_BAF_SUIT","UK3CB_BAF_SUSAT","UK3CB_BAF_TA31F","UK3CB_BAF_TA31F_Hornbill","UK3CB_BAF_TA648","UK3CB_BAF_TA648_308","RKSL_optic_LDS"];
	OPEX_friendly_sniperOptics append ["UK3CB_BAF_Kite","UK3CB_BAF_MaxiKite","RKSL_optic_PMII_312","RKSL_optic_PMII_312_sunshade","RKSL_optic_PMII_525"];
	OPEX_friendly_flashlights append ["UK3CB_BAF_LLM_Flashlight_Black","UK3CB_BAF_Flashlight_L131A1"];
	OPEX_friendly_rifleSilencers append ["UK3CB_BAF_Silencer_L85","UK3CB_BAF_SFFH","UK3CB_BAF_Silencer_L91A1","UK3CB_BAF_Silencer_L115A3"];
	OPEX_friendly_handgunSilencers append ["UK3CB_BAF_Silencer_L105A1"];
	OPEX_friendly_pointers append ["UK3CB_BAF_LLM_IR_Black","UK3CB_BAF_Laser_L131A1"];
	OPEX_friendly_bipods append ["UK3CB_underbarrel_acc_afg","UK3CB_underbarrel_acc_fgrip","UK3CB_underbarrel_acc_fgrip_bipod","UK3CB_underbarrel_acc_grippod","UK3CB_underbarrel_acc_bipod"];

	// VARIOUS ITEMS
	OPEX_friendly_NVGs append ["UK3CB_BAF_HMNVS"];
	OPEX_friendly_laserDesignators = ["UK3CB_BAF_Soflam_Laserdesignator"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve"];
	OPEX_friendly_commonUniforms_desert = ["UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve"];
	OPEX_friendly_commonUniforms_snow = ["UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic"];
	OPEX_friendly_specialUniforms_woodland = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve"];
	OPEX_friendly_specialUniforms_desert = ["UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve"];
	OPEX_friendly_specialUniforms_snow = ["UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic"];
	OPEX_friendly_ghillieUniforms_woodland = ["UK3CB_BAF_U_CombatUniform_MTP_Ghillie_RM"];
	OPEX_friendly_ghillieUniforms_desert = ["UK3CB_BAF_U_CombatUniform_DDPM_Ghillie_RM"];
	OPEX_friendly_ghillieUniforms_snow = ["UK3CB_BAF_U_CombatUniform_Arctic_Ghillie_RM"];
	OPEX_friendly_heliPilotUniforms_woodland = ["UK3CB_BAF_U_HeliPilotCoveralls_Army"];
	OPEX_friendly_heliPilotUniforms_desert = ["UK3CB_BAF_U_HeliPilotCoveralls_Army"];
	OPEX_friendly_heliPilotUniforms_snow = ["UK3CB_BAF_U_HeliPilotCoveralls_Army"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["UK3CB_BAF_U_HeliPilotCoveralls_RAF"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["UK3CB_BAF_U_HeliPilotCoveralls_RAF"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["UK3CB_BAF_U_HeliPilotCoveralls_RAF"];
	OPEX_friendly_tankPilotUniforms_woodland = ["UK3CB_BAF_U_CrewmanCoveralls_RTR"];
	OPEX_friendly_tankPilotUniforms_desert = ["UK3CB_BAF_U_CrewmanCoveralls_RTR"];
	OPEX_friendly_tankPilotUniforms_snow = ["UK3CB_BAF_U_CrewmanCoveralls_RTR"];
	OPEX_friendly_medicUniforms_woodland = ["UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve"];
	OPEX_friendly_medicUniforms_desert = ["UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve"];
	OPEX_friendly_medicUniforms_snow = ["UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_Arctic","UK3CB_BAF_U_Smock_DPMW_Arctic"];
	OPEX_friendly_instructorUniforms_woodland = ["UK3CB_BAF_U_JumperUniform_MTP","UK3CB_BAF_U_RolledUniform_MTP"];
	OPEX_friendly_instructorUniforms_desert = ["UK3CB_BAF_U_RolledUniform_MTP"];
	OPEX_friendly_instructorUniforms_snow = ["UK3CB_BAF_U_JumperUniform_Plain"];
	OPEX_friendly_tshirtUniforms_woodland = ["UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_RolledUniform_MTP"];
	OPEX_friendly_tshirtUniforms_desert = ["UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve"];
	OPEX_friendly_tshirtUniforms_snow = ["UK3CB_BAF_U_JumperUniform_Plain"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["UK3CB_BAF_V_Osprey_Lite","UK3CB_BAF_V_Osprey","UK3CB_BAF_V_Osprey_Belt_A","UK3CB_BAF_V_Osprey_Rifleman_A","UK3CB_BAF_V_Osprey_Rifleman_B","UK3CB_BAF_V_Osprey_Rifleman_C","UK3CB_BAF_V_Osprey_Rifleman_D","UK3CB_BAF_V_Osprey_Rifleman_E","UK3CB_BAF_V_Osprey_Rifleman_F","UK3CB_BAF_V_Pilot_A"];
	OPEX_friendly_commonVests_desert = ["UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Pilot_DDPM"];
	OPEX_friendly_commonVests_snow = ["UK3CB_BAF_V_Osprey_Winter"];
	OPEX_friendly_specialVests_woodland = ["UK3CB_BAF_V_Osprey_Holster","UK3CB_BAF_V_Osprey_Marksman_A","UK3CB_BAF_V_Osprey_MG_A","UK3CB_BAF_V_Osprey_MG_B","UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"];
	OPEX_friendly_specialVests_desert = ["UK3CB_BAF_V_Osprey_DDPM2","UK3CB_BAF_V_Osprey_DDPM4","UK3CB_BAF_V_Osprey_DDPM6","UK3CB_BAF_V_Osprey_DDPM7","UK3CB_BAF_V_Osprey_DDPM8","UK3CB_BAF_V_Osprey_DDPM9"];
	OPEX_friendly_specialVests_snow = ["UK3CB_BAF_V_Osprey_Holster","UK3CB_BAF_V_Osprey_Marksman_A","UK3CB_BAF_V_Osprey_MG_A","UK3CB_BAF_V_Osprey_MG_B","UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"];
	OPEX_friendly_medicVests_woodland = ["UK3CB_BAF_V_Osprey_Medic_A","UK3CB_BAF_V_Osprey_Medic_B","UK3CB_BAF_V_Osprey_Medic_C","UK3CB_BAF_V_Osprey_Medic_D"];
	OPEX_friendly_medicVests_desert = ["UK3CB_BAF_V_Osprey_DDPM3","UK3CB_BAF_V_Osprey_DDPM5"];
	OPEX_friendly_medicVests_snow = ["UK3CB_BAF_V_Osprey_Medic_A","UK3CB_BAF_V_Osprey_Medic_B","UK3CB_BAF_V_Osprey_Medic_C","UK3CB_BAF_V_Osprey_Medic_D"];
	OPEX_friendly_beltVests_woodland append ["UK3CB_BAF_V_PLCE_Webbing_MTP","UK3CB_BAF_V_PLCE_Webbing_OLI"];
	OPEX_friendly_beltVests_desert append ["UK3CB_BAF_V_PLCE_Webbing_DDPM"];
	OPEX_friendly_beltVests_snow append ["UK3CB_BAF_V_PLCE_Webbing_Winter"];
	OPEX_friendly_lightVests_woodland append ["UK3CB_BAF_V_Osprey_Lite","UK3CB_BAF_V_Osprey","UK3CB_BAF_V_Osprey_Belt_A",""];
	OPEX_friendly_lightVests_desert append ["UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Pilot_DDPM"];
	OPEX_friendly_lightVests_snow append ["UK3CB_BAF_V_Osprey_Winter"];
	OPEX_friendly_grenadierVests_woodland append ["UK3CB_BAF_V_Osprey_Grenadier_A","UK3CB_BAF_V_Osprey_Grenadier_B"];
	OPEX_friendly_grenadierVests_desert append ["UK3CB_BAF_V_Osprey_Grenadier_A","UK3CB_BAF_V_Osprey_Grenadier_B"];
	OPEX_friendly_grenadierVests_snow append ["UK3CB_BAF_V_Osprey_Grenadier_A","UK3CB_BAF_V_Osprey_Grenadier_B"];
	OPEX_friendly_EODvests_woodland = ["UK3CB_BAF_V_Osprey_MG_A"];
	OPEX_friendly_EODvests_desert = ["UK3CB_BAF_V_Osprey_MG_A"];
	OPEX_friendly_EODvests_snow = ["UK3CB_BAF_V_Osprey_MG_A"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["UK3CB_BAF_H_Mk6_DPMT_C","UK3CB_BAF_H_Mk6_DPMT_C","UK3CB_BAF_H_Mk6_DPMT_F","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F"];
	OPEX_friendly_commonHelmets_desert = ["UK3CB_BAF_H_Mk6_DDPM_A","UK3CB_BAF_H_Mk6_DDPM_B","UK3CB_BAF_H_Mk6_DDPM_C","UK3CB_BAF_H_Mk6_DDPM_F"];
	OPEX_friendly_commonHelmets_snow = ["UK3CB_BAF_H_Mk7_Win_A","UK3CB_BAF_H_Mk7_Win_A","UK3CB_BAF_H_Mk7_Win_ESS_A"];
	OPEX_friendly_specialHelmets_woodland append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_CESS_B","UK3CB_BAF_H_Mk7_Camo_CESS_C","UK3CB_BAF_H_Mk7_Camo_CESS_D","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_B","UK3CB_BAF_H_Mk7_Camo_ESS_C","UK3CB_BAF_H_Mk7_Camo_ESS_D","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_CESS_B","UK3CB_BAF_H_Mk7_Net_CESS_C","UK3CB_BAF_H_Mk7_Net_CESS_D","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Net_ESS_B","UK3CB_BAF_H_Mk7_Net_ESS_C","UK3CB_BAF_H_Mk7_Net_ESS_D","UK3CB_BAF_H_Mk7_Scrim_B","UK3CB_BAF_H_Mk7_Scrim_C"];
	OPEX_friendly_specialHelmets_desert append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_CESS_B","UK3CB_BAF_H_Mk7_Camo_CESS_C","UK3CB_BAF_H_Mk7_Camo_CESS_D","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_B","UK3CB_BAF_H_Mk7_Camo_ESS_C","UK3CB_BAF_H_Mk7_Camo_ESS_D","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_CESS_B","UK3CB_BAF_H_Mk7_Net_CESS_C","UK3CB_BAF_H_Mk7_Net_CESS_D","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Net_ESS_B","UK3CB_BAF_H_Mk7_Net_ESS_C","UK3CB_BAF_H_Mk7_Net_ESS_D","UK3CB_BAF_H_Mk7_Scrim_B","UK3CB_BAF_H_Mk7_Scrim_C"];
	OPEX_friendly_specialHelmets_snow append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_CESS_B","UK3CB_BAF_H_Mk7_Camo_CESS_C","UK3CB_BAF_H_Mk7_Camo_CESS_D","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_B","UK3CB_BAF_H_Mk7_Camo_ESS_C","UK3CB_BAF_H_Mk7_Camo_ESS_D","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_CESS_B","UK3CB_BAF_H_Mk7_Net_CESS_C","UK3CB_BAF_H_Mk7_Net_CESS_D","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Net_ESS_B","UK3CB_BAF_H_Mk7_Net_ESS_C","UK3CB_BAF_H_Mk7_Net_ESS_D","UK3CB_BAF_H_Mk7_Scrim_B","UK3CB_BAF_H_Mk7_Scrim_C"];
	OPEX_friendly_EODhelmets_woodland = ["UK3CB_BAF_H_Mk7_Camo_D"];
	OPEX_friendly_EODhelmets_desert = ["UK3CB_BAF_H_Mk7_Camo_D"];
	OPEX_friendly_EODhelmets_snow = ["UK3CB_BAF_H_Mk7_Camo_D"];
	OPEX_friendly_heliPilotHelmets = ["UK3CB_BAF_H_PilotHelmetHeli_A"];
	OPEX_friendly_aircraftPilotHelmets = ["UK3CB_BAF_H_PilotHelmetHeli_A"];
	OPEX_friendly_tankCrewHelmets = ["UK3CB_BAF_H_CrewHelmet_B"];
	OPEX_friendly_cameraHelmets_woodland append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Scrim_C"];
	OPEX_friendly_cameraHelmets_desert append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Scrim_C"];
	OPEX_friendly_cameraHelmets_snow append ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Scrim_C"];;
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland append ["UK3CB_BAF_H_Boonie_MTP","UK3CB_BAF_H_Boonie_MTP","UK3CB_BAF_V_Osprey"];
	OPEX_friendly_hats_desert append ["UK3CB_BAF_H_Boonie_DDPM","UK3CB_BAF_H_Boonie_DDPM","UK3CB_BAF_H_Boonie_DDPM_PRR"];
	OPEX_friendly_hats_snow append ["UK3CB_BAF_H_Boonie_MTP","UK3CB_BAF_H_Boonie_MTP","UK3CB_BAF_V_Osprey"];;
	OPEX_friendly_beanies_woodland append ["UK3CB_BAF_H_Wool_Hat"];
	OPEX_friendly_beanies_desert append ["UK3CB_BAF_H_Wool_Hat"];
	OPEX_friendly_beanies_snow append ["UK3CB_BAF_H_Wool_Hat"];
	OPEX_friendly_leaderHeadgear_woodland append ["UK3CB_BAF_H_Beret_SAS","UK3CB_BAF_H_Beret_SAS_PRR","UK3CB_BAF_H_Headset_PRR"];
	OPEX_friendly_leaderHeadgear_desert append ["UK3CB_BAF_H_Beret_SAS","UK3CB_BAF_H_Beret_SAS_PRR","UK3CB_BAF_H_Headset_PRR"];
	OPEX_friendly_leaderHeadgear_snow append ["UK3CB_BAF_H_Beret_SAS","UK3CB_BAF_H_Beret_SAS_PRR","UK3CB_BAF_H_Headset_PRR"];
	OPEX_friendly_berets append ["UK3CB_BAF_H_Beret_SAS","UK3CB_BAF_H_Beret_SAS_PRR"];
	OPEX_friendly_headsets append ["UK3CB_BAF_H_Earphone"];

	// FACEGEAR
	OPEX_friendly_glasses append ["UK3CB_BAF_G_Tactical_Clear"];
	OPEX_friendly_sunglasses append ["UK3CB_BAF_G_Tactical_Black","UK3CB_BAF_G_Tactical_Grey","UK3CB_BAF_G_Tactical_Orange","UK3CB_BAF_G_Tactical_Yellow"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["UK3CB_BAF_B_Bergen_MTP_Engineer_H_A","UK3CB_BAF_B_Bergen_MTP_Engineer_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D","UK3CB_BAF_B_Bergen_OLI_Rifleman_A","UK3CB_BAF_B_Bergen_OLI_Rifleman_B","UK3CB_BAF_B_Kitbag_MTP","UK3CB_BAF_B_Kitbag_OLI"];
	OPEX_friendly_mediumBackpacks_desert = ["UK3CB_BAF_B_Bergen_DDPM_Rifleman_A","UK3CB_BAF_B_Bergen_DDPM_Rifleman_B","UK3CB_BAF_B_Bergen_TAN_Rifleman_A","UK3CB_BAF_B_Bergen_TAN_Rifleman_B","UK3CB_BAF_B_Kitbag_DDPM","UK3CB_BAF_B_Kitbag_TAN"];
	OPEX_friendly_mediumBackpacks_snow = ["UK3CB_BAF_B_Bergen_Arctic_Rifleman_A","UK3CB_BAF_B_Bergen_Arctic_Rifleman_B","UK3CB_BAF_B_Kitbag_Arctic"];
	OPEX_friendly_bigBackpacks_woodland append ["UK3CB_BAF_B_Carryall_MTP","UK3CB_BAF_B_Bergen_MTP_Rifleman_XL_A","UK3CB_BAF_B_Carryall_OLI"];
	OPEX_friendly_bigBackpacks_desert append ["UK3CB_BAF_B_Carryall_DDPM","UK3CB_BAF_B_Carryall_DDPM","UK3CB_BAF_B_Carryall_DDPM","UK3CB_BAF_B_Carryall_TAN","UK3CB_BAF_B_Carryall_TAN"];
	OPEX_friendly_bigBackpacks_snow append ["UK3CB_BAF_B_Carryall_Arctic","UK3CB_BAF_B_Carryall_Arctic","UK3CB_BAF_B_Carryall_Arctic","UK3CB_BAF_B_Carryall_Arctic","UK3CB_BAF_B_Carryall_Arctic"];
	OPEX_friendly_medicBackpacks_woodland = ["UK3CB_BAF_B_Bergen_MTP_Medic_H_A","UK3CB_BAF_B_Bergen_MTP_Medic_H_B","UK3CB_BAF_B_Bergen_MTP_Medic_L_A","UK3CB_BAF_B_Bergen_MTP_Medic_L_B"];
	OPEX_friendly_medicBackpacks_desert = ["UK3CB_BAF_B_Bergen_MTP_Medic_H_A","UK3CB_BAF_B_Bergen_MTP_Medic_H_B","UK3CB_BAF_B_Bergen_MTP_Medic_L_A","UK3CB_BAF_B_Bergen_MTP_Medic_L_B"];
	OPEX_friendly_medicBackpacks_snow = ["UK3CB_BAF_B_Bergen_MTP_Medic_H_A","UK3CB_BAF_B_Bergen_MTP_Medic_H_B","UK3CB_BAF_B_Bergen_MTP_Medic_L_A","UK3CB_BAF_B_Bergen_MTP_Medic_L_B"];
	OPEX_friendly_radioBackpacks_woodland append ["UK3CB_BAF_B_Bergen_MTP_JTAC_H_A","UK3CB_BAF_B_Bergen_MTP_JTAC_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B","UK3CB_BAF_B_Bergen_MTP_Radio_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_L_B","UK3CB_BAF_B_Bergen_MTP_SL_H_A","UK3CB_BAF_B_Bergen_MTP_SL_L_A","UK3CB_BAF_B_Bergen_OLI_JTAC_H_A"];
	OPEX_friendly_radioBackpacks_desert append ["UK3CB_BAF_B_Bergen_DDPM_JTAC_H_A","UK3CB_BAF_B_Bergen_TAN_JTAC_H_A"];
	OPEX_friendly_radioBackpacks_snow append ["UK3CB_BAF_B_Bergen_Arctic_JTAC_H_A"];