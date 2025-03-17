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

	if (!(isClass (configFile >> "CfgPatches" >> "JackFrench"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "JackFrench_apex"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "JackFrench"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_France"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_france"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_France"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_france.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_france.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "JackFrench_INS"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Lugdunum"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_fr.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_fr.paa";
	OPEX_sign_armory = "pictures\sign_armory_fr.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_fr.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_fr.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_fr.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_fr.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_fr.paa";
	OPEX_sign_jail = "pictures\sign_jail_fr.paa";
	OPEX_sign_medical = "pictures\sign_medical_fr.paa";
	OPEX_sign_practice = "pictures\sign_practice_fr.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_fr.paa";
	OPEX_sign_toc = "pictures\sign_toc_fr.paa";
	OPEX_sign_training = "pictures\sign_training_fr.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_fr.paa";
	OPEX_sign_showers = "pictures\sign_showers_fr.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_fr.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_fr.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_fr.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_fr.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_fr.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_fr.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_fr.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_fr.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_fr.paa";
	OPEX_tv = "pictures\tv_fr.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_fr.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_fr.paa";
	OPEX_keepclear = "pictures\keepclear_fr.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["french_01", "french_02", "french_03", "french_04", "french_05", "french_06", "french_07", "french_08", "french_09", "french_10", "french_11", "french_12", "french_13", "french_14", "french_15", "french_16", "french_17", "french_18", "french_19", "french_20", "french_21", "french_22", "french_23", "french_24", "french_25", "french_26", "french_27", "french_28", "french_29", "french_30", "french_31", "french_32", "french_33", "french_34", "french_35", "french_36", "french_37", "french_38", "french_39", "french_40", "french_41", "french_42", "french_43", "french_44", "french_45", "french_46", "french_47", "french_48", "french_49", "french_50", "french_51", "french_52", "french_53", "french_54", "french_55", "french_56", "french_57", "french_58", "french_59", "french_60", "french_61", "french_62", "french_63", "french_64", "french_65", "french_66", "french_67", "french_68", "french_69", "french_70"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["JF_Camion_01_transport_F"];
	OPEX_friendly_transportTrucksOpened_desert = ["JF_Camion_01_transport_F"];
	OPEX_friendly_transportTrucksOpened_snow = ["JF_Camion_01_transport_F"];
	OPEX_friendly_transportTrucksCovered_woodland = ["JF_Camion_01_Bache_F"];
	OPEX_friendly_transportTrucksCovered_desert = ["JF_Camion_01_Bache_F"];
	OPEX_friendly_transportTrucksCovered_snow = ["JF_Camion_01_Bache_F"];
	OPEX_friendly_fuelTrucks_woodland = ["JF_Camion_01_fuel_F"];
	OPEX_friendly_fuelTrucks_desert = ["JF_Camion_01_fuel_F"];
	OPEX_friendly_fuelTrucks_snow = ["JF_Camion_01_fuel_F"];
	OPEX_friendly_logisticTrucks_woodland = ["B_Truck_01_box_JF"];
	OPEX_friendly_logisticTrucks_desert = ["B_Truck_01_box_JF"];
	OPEX_friendly_logisticTrucks_snow = ["B_Truck_01_box_JF"];
	OPEX_friendly_medicalTrucks_woodland = ["JF_Camion_02_medical_F"];
	OPEX_friendly_medicalTrucks_desert = ["JF_Camion_02_medical_F"];
	OPEX_friendly_medicalTrucks_snow = ["JF_Camion_02_medical_F"];
	OPEX_friendly_repairTrucks_woodland = ["JF_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_desert = ["JF_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_snow = ["JF_Truck_01_Repair_F"];
	OPEX_friendly_ammoTrucks_woodland = ["B_Truck_01_ammo_JF"];
	OPEX_friendly_ammoTrucks_desert = ["B_Truck_01_ammo_JF"];
	OPEX_friendly_ammoTrucks_snow = ["B_Truck_01_ammo_JF"];
	OPEX_friendly_transportCars_woodland = ["JF_MRAPD_01_F","JF_MRAPD_01_F","JF_HUNTER_F","C_Offroad_02_unarmed_JF_M","B_JF_LSV_01_light_F"];
	OPEX_friendly_transportCars_desert = ["JF_MRAPD_01_F","JF_MRAPD_01_F","JF_HUNTER_F","C_Offroad_02_unarmed_JF_M","B_JF_LSV_01_light_F"];
	OPEX_friendly_transportCars_snow = ["JF_MRAPD_01_F","JF_MRAPD_01_F","JF_HUNTER_F","C_Offroad_02_unarmed_JF_M","B_JF_LSV_01_light_F"];
	OPEX_friendly_combatCarsMG_woodland = ["JF_MRAP_01_hmg_F","JF_MRAP_01_hmg_F","JF_HUNTER_HMG_F","O_T_M_LSV_02_armed_JF","B_T_LSV_01_armed_Multi_l_JF"];
	OPEX_friendly_combatCarsMG_desert = ["JF_MRAP_01_hmgD_F","JF_MRAP_01_hmgD_F","JF_HUNTER_HMG_F","O_T_M_LSV_02_armed_JF","B_T_LSV_01_armed_Multi_l_JF"];
	OPEX_friendly_combatCarsMG_snow = ["JF_MRAP_01_hmg_F","JF_MRAP_01_hmg_F","JF_HUNTER_HMG_F","O_T_M_LSV_02_armed_JF","B_T_LSV_01_armed_Multi_l_JF"];
	OPEX_friendly_combatCarsGL_woodland = ["JF_MRAP_01_gmg_F"];
	OPEX_friendly_combatCarsGL_desert = ["JF_MRAP_01_gmgD_F"];
	OPEX_friendly_combatCarsGL_snow = ["JF_MRAP_01_gmgS_F"];
	OPEX_friendly_vtt_woodland = ["JF_IFV_Marid","O_APC_Tracked_02_cannon_JF","B_APC_Tracked_01_CRV_JF","B_AMV_JF"];
	OPEX_friendly_vtt_desert = ["JF_IFV_Marid","O_APC_Tracked_02_cannon_JF","B_APC_Tracked_01_CRV_JF","B_AMV_JF"];
	OPEX_friendly_vtt_snow = ["JF_IFV_Marid","O_APC_Tracked_02_cannon_JF","B_APC_Tracked_01_CRV_JF","B_AMV_JF"];
	OPEX_friendly_tanks_woodland = ["JF_IFV_Warrior","B_MBT_01_TUSK_JF","B_MBT_01_TUSK_JF_B","JF_MBT_Kuma","O_MBT_02_cannon_JF"];
	OPEX_friendly_tanks_desert = ["JF_IFV_Warrior","B_MBT_01_TUSK_JF","B_MBT_01_TUSK_JF_B","JF_MBT_Kuma","O_MBT_02_cannon_JF"];
	OPEX_friendly_tanks_snow = ["JF_IFV_Warrior","B_MBT_01_TUSK_JF","B_MBT_01_TUSK_JF_B","JF_MBT_Kuma","O_MBT_02_cannon_JF"];
	OPEX_friendly_quads_woodland = ["JF_Quadbike_01_F"];
	OPEX_friendly_quads_desert = ["JF_Quadbike_01_F"];
	OPEX_friendly_quads_snow = ["JF_Quadbike_01_F"];
	OPEX_friendly_zodiacs = ["JackFrench_Boat_Transport_01_F"];
	OPEX_friendly_ships = ["JackFrench_Boat_Armed_01_minigun_F","C_Boat_01_JF"];
	OPEX_friendly_aircrafts = ["Plane_Fighter_04_Base_JF","B_Plane_Fighter_01_Stealth_JF","O_Plane_CAS_02_JFcamo","O_Plane_CAS_02_JF"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["JF_Heli_Light_01_armed_F"];
	OPEX_friendly_smallCombatHelicopters_desert = ["JF_Heli_Light_01_armed_F"];
	OPEX_friendly_smallCombatHelicopters_snow = ["JF_Heli_Light_01_armed_F"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["B_Heli_Attack_01_JF","O_Heli_Attack_02_black_JF","JF_Heli_light_03C_F","JF_O_Heli_LightA_02_F"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["B_Heli_Attack_01_JF","O_Heli_Attack_02_black_JF","JF_Heli_light_03C_F","JF_O_Heli_LightA_02_F"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["B_Heli_Attack_01_JF","O_Heli_Attack_02_black_JF","JF_Heli_light_03C_F","JF_O_Heli_LightA_02_F"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["JF_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_desert = ["JF_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_snow = ["JF_Heli_Light_01_F"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["B_Heli_Transport_01_camo_JF","JF_Heli_light_03C_transport_F","JF_O_Heli_Light_02_F"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["B_Heli_Transport_01_camo_JF","JF_Heli_light_03C_transport_F","JF_O_Heli_Light_02_F"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["B_Heli_Transport_01_camo_JF","JF_Heli_light_03C_transport_F","JF_O_Heli_Light_02_F"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["B_Heli_Transport_03_JF","JF_Heli_Transport_02_F","JF_Heli_Transport_02_F"];
	OPEX_friendly_bigTransportHelicopters_desert = ["B_Heli_Transport_03_JF","JF_Heli_Transport_02_F","JF_Heli_Transport_02_F"];
	OPEX_friendly_bigTransportHelicopters_snow = ["B_Heli_Transport_03_JF","JF_Heli_Transport_02_F","JF_Heli_Transport_02_F"];
	OPEX_friendly_UAVs = ["B_UAV_02_JF","B_UAV_02_JF","B_UAV_02_CAS_JF"];
	OPEX_friendly_UGVs = ["JF_UGV_01_F","JF_UGV_01_F","JF_UGV_01_rcws_F"];
	OPEX_friendly_MGstatics = ["JackFrench_HMG_01_high_F"];
	OPEX_friendly_GLstatics = ["JackFrench_GMG_01_high_F"];
	OPEX_friendly_ATstatics = ["JackFrench_static_AT_F"];
	OPEX_friendly_AAstatics = ["JackFrench_static_AA_F"];
	OPEX_friendly_mortarStatics = ["JackFrench_Mortar_01_F"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["hgun_Rook40_F"];
	OPEX_friendly_specialHandguns = ["hgun_Rook40_F"];
	OPEX_friendly_commonRifles = ["arifle_CTAR_blk_F"];
	OPEX_friendly_specialRifles = ["arifle_416F_blk_JF","arifle_417F_blk_JF"];
	OPEX_friendly_GLrifles = ["arifle_416F_GL_blk_JF","arifle_CTAR_GL_blk_F"];
	OPEX_friendly_MGriflesLight = ["srifle_DMR_07_blk_F"];
	OPEX_friendly_MGriflesHeavy = ["MMG_02_black_RCO_BI_F"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["SMG_05_F","SMG_02_F","SMG_03C_TR_black","SMG_03C_black"];
	OPEX_friendly_precisionRifles = ["srifle_GM6_desert_F"];
	OPEX_friendly_sniperRifles = ["srifle_LRR_F"];
	OPEX_friendly_ATlaunchers = ["launch_NLAW_F","launch_B_Titan_short_JF"];
	OPEX_friendly_AAlaunchers = ["launch_B_Titan_JF"];
	OPEX_friendly_shotguns = ["SMG_03C_TR_black"];
	OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

	// WEAPON ACCESSORIES
	// (default ones)

	// VARIOUS ITEMS
	// (default ones)

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["JF_Uniforme","JF_Uniforme","JF_Uniforme_MC"];
	OPEX_friendly_commonUniforms_desert = ["JF_Uniforme_D","JF_Uniforme_D"];
	OPEX_friendly_commonUniforms_snow = ["JF_Uniforme_alpin"];
	OPEX_friendly_specialUniforms_woodland = ["JackFrench_Uniforme_MC","JackFrench_uniformeB_ML"];
	OPEX_friendly_specialUniforms_desert = ["JackFrench_uniformeBD_ML"];
	OPEX_friendly_specialUniforms_snow = ["JF_Uniforme_alpin"];
	OPEX_friendly_ghillieUniforms_woodland = ["JackFrench_Ghillie"];
	OPEX_friendly_ghillieUniforms_desert = ["U_B_FullGhillie_ard"];
	OPEX_friendly_ghillieUniforms_snow = ["U_B_FullGhillie_ard", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
	OPEX_friendly_heliPilotUniforms_woodland = ["JF_Combinaison_Pilote"];
	OPEX_friendly_heliPilotUniforms_desert = ["JF_Combinaison_Pilote"];
	OPEX_friendly_heliPilotUniforms_snow = ["JF_Combinaison_Pilote"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["U_I_pilotCoveralls_JF"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["U_I_pilotCoveralls_JF"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["U_I_pilotCoveralls_JF"];
	OPEX_friendly_tankPilotUniforms_woodland = ["JF_Uniforme"];
	OPEX_friendly_tankPilotUniforms_desert = ["JF_Uniforme"];
	OPEX_friendly_tankPilotUniforms_snow = ["JF_Uniforme"];
	OPEX_friendly_medicUniforms_woodland = ["JF_Uniforme_M"];
	OPEX_friendly_medicUniforms_desert = ["JF_Uniforme_D"];
	OPEX_friendly_medicUniforms_snow = ["JF_Uniforme_alpin"];
	OPEX_friendly_instructorUniforms_woodland = ["JF_Uniform_OF"];
	OPEX_friendly_instructorUniforms_desert = ["JF_Uniform_OF"];
	OPEX_friendly_instructorUniforms_snow = ["JF_Uniform_OF"];
	OPEX_friendly_tshirtUniforms_woodland = ["JackFrench_tshirt","JackFrench_tshirt","JackFrench_tshirt_BLU"];
	OPEX_friendly_tshirtUniforms_desert = ["JackFrench_tshirt","JackFrench_tshirt","JackFrench_tshirt_BLU"];
	OPEX_friendly_tshirtUniforms_snow = ["JackFrench_tshirt","JackFrench_tshirt","JackFrench_tshirt_BLU"];
	OPEX_friendly_diverUniforms = ["JackFrench_Wetsuit"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["JF_veste_legere"];
	OPEX_friendly_commonVests_desert = ["JF_veste_legered"];
	OPEX_friendly_commonVests_snow = ["JF_veste_legere_snow"];
	OPEX_friendly_specialVests_woodland = ["JF_Uniforme_MC","JF_Uniforme_MC","JF_PlateCarrier_BA1","JF_V_PlateCarrierSpec_rgr"];
	OPEX_friendly_specialVests_desert = ["JF_Uniforme_MC","JF_Uniforme_MC","JF_D_PlateCarrier_BA1","JF_V_PlateCarrierSpec_D"];
	OPEX_friendly_specialVests_snow = ["JF_Uniforme_MC","JF_Uniforme_MC","JF_PlateCarrier_BA1","JF_V_PlateCarrierSpec_rgr"];
	OPEX_friendly_medicVests_woodland = ["JF_veste_legere"];
	OPEX_friendly_medicVests_desert = ["JF_veste_legered"];
	OPEX_friendly_medicVests_snow = ["JF_veste_legere_snow"];
	OPEX_friendly_beltVests_woodland append ["JF_rangemaster_belt"];
	OPEX_friendly_beltVests_desert append ["JF_rangemaster_belt"];
	OPEX_friendly_beltVests_snow append ["JF_rangemaster_belt"];
	OPEX_friendly_lightVests_woodland = ["JF_veste_legere"];
	OPEX_friendly_lightVests_desert = ["JF_veste_legered"];
	OPEX_friendly_lightVests_snow = ["JF_veste_legere_snow"];
	OPEX_friendly_EODvests_woodland = ["JF_veste_legere_Mod","JF_V_PlateCarrierGL_rgr","JF_V_PlateCarrierGL_rgr"];
	OPEX_friendly_EODvests_desert = ["JF_V_PlateCarrierGL_D","JF_V_PlateCarrierGL_D"];
	OPEX_friendly_EODvests_snow = ["JF_A_veste_legere_Mod"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["JF_Casque"];
	OPEX_friendly_commonHelmets_desert = ["JF_D_Casque"];
	OPEX_friendly_commonHelmets_snow = ["JF_A_Casque"];
	OPEX_friendly_specialHelmets_woodland append ["JF_H_HelmetB","JF_H_HelmetB","JF_H_HelmetB","JF_H_HelmetB","JF_H_HelmetB","JF_H_HelmetSpecB","JF_H_HelmetSpecB","JF_H_HelmetSpecB","JF_H_HelmetB_light","JF_H_HelmetB_light","JF_H_HelmetB_light"];
	OPEX_friendly_specialHelmets_desert append ["JF_D_Casque","JF_D_Casque","JF_D_Casque"];
	OPEX_friendly_specialHelmets_snow append ["JF_A_Casque","JF_A_Casque","JF_A_Casque"];
	OPEX_friendly_EODhelmets_woodland = ["JF_Casque"];
	OPEX_friendly_EODhelmets_desert = ["JF_D_Casque"];
	OPEX_friendly_EODhelmets_snow = ["JF_A_Casque"];
	OPEX_friendly_heliPilotHelmets = ["JF_Casque_Pilote_Heli"];
	OPEX_friendly_cameraHelmets_woodland append ["JF_H_HelmetSpecB","JF_H_HelmetB_light"];
	OPEX_friendly_cameraHelmets_desert append ["JF_H_HelmetSpecB","JF_H_HelmetB_light"];
	OPEX_friendly_cameraHelmets_snow append ["JF_H_HelmetSpecB","JF_H_HelmetB_light"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland append ["B_AssaultPack_jf","B_AssaultPack_jf","B_AssaultPack_jf","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","Sac_moyen_jf","Sac_moyen_jf"];
	OPEX_friendly_mediumBackpacks_desert append ["B_AssaultPack_jf","B_AssaultPack_jf","B_AssaultPack_jf","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","Sac_moyen_jf","Sac_moyen_jf"];
	OPEX_friendly_mediumBackpacks_snow append ["B_AssaultPack_jf","B_AssaultPack_jf","B_AssaultPack_jf","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","B_Kitbag_JF","Sac_moyen_jf","Sac_moyen_jf"];
	OPEX_friendly_bigBackpacks_woodland append ["B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf"];
	OPEX_friendly_bigBackpacks_desert append ["B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf"];
	OPEX_friendly_bigBackpacks_snow append ["B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf","B_Carryall_jf"];
	OPEX_friendly_medicBackpacks_woodland = ["Sac_Medic_jf"];
	OPEX_friendly_medicBackpacks_desert = ["Sac_Medic_jf"];
	OPEX_friendly_medicBackpacks_snow = ["Sac_Medic_jf"];
	OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_JF"];