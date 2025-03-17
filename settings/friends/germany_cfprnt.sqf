/*
	Thanks to DoppelhopperWhopper for this data.

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

	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Vehicles_Core"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Weapons_WeaponsCore"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Creatures_Extra"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_main"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_uniforms"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_cup_b_ger"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "Redd_Vehicles_Main"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "rnt_t_base"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "CFP + RnT"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Germany"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_ger"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Germany"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_germany.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_germany.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = ""; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Wagner"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_ger.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

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
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_de.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_de.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_de.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_de.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_de.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_de.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_de.paa";
	OPEX_tv = "pictures\tv_generic.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_ge.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["german_01", "german_02", "german_03", "german_04", "german_05", "german_06", "german_07", "german_08", "german_09", "german_10", "german_11", "german_12", "german_13", "german_14", "german_15", "german_16", "german_17", "german_18", "german_19", "german_20", "german_21", "german_22", "german_23", "german_24", "german_25", "german_26", "german_27", "german_28", "german_29", "german_30", "german_31", "german_32", "german_33", "german_34", "german_35", "german_36", "german_37", "german_38", "german_39", "german_40", "german_41", "german_42", "german_43", "german_44", "german_45", "german_46", "german_47", "german_48", "german_49", "german_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_transportTrucksOpened_desert = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksOpened_snow = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_transportTrucksCovered_woodland = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_transportTrucksCovered_desert = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksCovered_snow = ["CUP_rnt_lkw_5t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_fuelTrucks_woodland = ["CUP_rnt_lkw_5t_mil_gl_kat_i_fuel_fleck"];
	OPEX_friendly_fuelTrucks_desert = ["CUP_rnt_lkw_5t_mil_gl_kat_i_fuel_trope"];
	OPEX_friendly_fuelTrucks_snow = ["CUP_rnt_lkw_5t_mil_gl_kat_i_fuel_fleck"];
	OPEX_friendly_logisticTrucks_woodland = ["CUP_rnt_lkw_7t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_logisticTrucks_desert = ["CUP_rnt_lkw_7t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_logisticTrucks_snow = ["CUP_rnt_lkw_7t_mil_gl_kat_i_transport_fleck"];
	OPEX_friendly_medicalTrucks_woodland = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_San"];
	OPEX_friendly_medicalTrucks_desert = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_San"];
	OPEX_friendly_medicalTrucks_snow = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_San"];
	OPEX_friendly_repairTrucks_woodland = ["CUP_rnt_lkw_10t_mil_gl_kat_i_repair_fleck"];
	OPEX_friendly_repairTrucks_desert = ["CUP_rnt_lkw_10t_mil_gl_kat_i_repair_trope"];
	OPEX_friendly_repairTrucks_snow = ["CUP_rnt_lkw_10t_mil_gl_kat_i_repair_fleck"];
	OPEX_friendly_ammoTrucks_woodland = ["CUP_rnt_lkw_7t_mil_gl_kat_i_mun_fleck"];
	OPEX_friendly_ammoTrucks_desert = ["CUP_rnt_lkw_7t_mil_gl_kat_i_mun_trope"];
	OPEX_friendly_ammoTrucks_snow = ["CUP_rnt_lkw_7t_mil_gl_kat_i_mun_fleck"];
	OPEX_friendly_transportCars_woodland = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_FueFu"];
	OPEX_friendly_transportCars_desert = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FueFu"];
	OPEX_friendly_transportCars_snow = ["CUP_Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_FueFu"];
	OPEX_friendly_combatCarsMG_woodland = ["CUP_B_Dingo_GER_Wdl"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_B_Dingo_GER_Des"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_B_Dingo_GER_Wdl"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_B_Dingo_GL_GER_Wdl"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_B_Dingo_GL_GER_Des"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_B_Dingo_GL_GER_Wdl"];
	OPEX_friendly_vtt_woodland = ["CUP_Redd_Marder_1A5_Flecktarn"];
	OPEX_friendly_vtt_desert = ["CUP_Redd_Marder_1A5_Tropentarn"];
	OPEX_friendly_vtt_snow = ["CUP_Redd_Marder_1A5_Flecktarn"];
	OPEX_friendly_tanks_woodland = ["CUP_B_Leopard2A6_GER"];
	OPEX_friendly_tanks_desert = ["CUP_B_Leopard2A6DST_GER"];
	OPEX_friendly_tanks_snow = ["CUP_B_Leopard2A6_GER"];
	OPEX_friendly_quads_woodland = ["B_T_Quadbike_01_F"];
	OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
	OPEX_friendly_quads_snow = ["B_T_Quadbike_01_F"];
	OPEX_friendly_zodiacs = ["B_T_Boat_Transport_01_F"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_B_UH1D_GER_KSK"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_B_UH1D_GER_KSK"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_B_UH1D_GER_KSK"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_B_CH53E_GER"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_B_CH53E_GER"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_B_CH53E_GER"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_B_CH53E_GER"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_B_CH53E_GER"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_B_CH53E_GER"];
	OPEX_friendly_UAVs = ["B_T_UAV_03_dynamicLoadout_F"];
	OPEX_friendly_UGVs = ["B_T_UGV_01_rcws_olive_F"];
	OPEX_friendly_portableDrones = ["B_UAV_01_F"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["CUP_B_GER_Fleck_rnt_mg3_static_ai"];
	OPEX_friendly_GLstatics = ["CUP_B_GER_Fleck_rnt_gmw_static_ai"];
	OPEX_friendly_ATstatics = ["CUP_B_GER_Fleck_Redd_Milan_Static"];
	OPEX_friendly_AAstatics = ["CUP_B_GER_Fleck_rnt_mantis_base"];
	OPEX_friendly_mortarStatics = ["CUP_B_GER_Fleck_Redd_Tank_M120_Tampella"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Glock17"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Glock17"];
	OPEX_friendly_commonRifles = ["CUP_arifle_G36A"];
	OPEX_friendly_specialRifles = ["CUP_arifle_G36K_KSK_VFG_hex","CUP_arifle_G36K_KSK_VFG_hex","CUP_arifle_G36K_KSK_VFG_hex","CUP_arifle_G36K_KSK_VFG_hex","CUP_arifle_G36K_KSK_VFG_hex","CUP_arifle_G36K_KSK_VFG_camo","CUP_arifle_HK416_CQB_Desert"];
	OPEX_friendly_GLrifles = ["CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36_camo"];
	OPEX_friendly_MGriflesLight = ["CUP_arifle_MG36"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_MG3"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_arifle_G36C"];
	OPEX_friendly_precisionRifles = ["CUP_arifle_HK417_20"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_G22_wdl"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_MAAWS"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_FIM92Stinger"];
	OPEX_friendly_shotguns = ["CUP_arifle_G36C"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["CUP_optic_G36DualOptics_desert","CUP_optic_G36DualOptics_PIP","CUP_optic_HoloBlack","CUP_optic_ZeissZPoint","CUP_optic_G36DualOptics"];
	OPEX_friendly_distantCombatOptics append ["CUP_optic_G33_HWS_TAN","CUP_optic_G36DualOptics_PIP","CUP_optic_SB_11_4x20_PM","CUP_optic_MAAWS_Scope","CUP_optic_HensoldtZO_low_RDS_hex","CUP_optic_G36DualOptics"];
	OPEX_friendly_sniperOptics append ["CUP_optic_SB_3_12x50_PMII"];
	OPEX_friendly_flashlights append ["CUP_acc_Glock17_Flashlight"];
	OPEX_friendly_rifleSilencers append ["CUP_muzzle_snds_M16_coyote"];
	OPEX_friendly_handgunSilencers append [];
	OPEX_friendly_pointers append ["CUP_acc_LLM01_hex_L","CUP_acc_LLM01_desert_L"];
	OPEX_friendly_bipods append ["CUP_bipod_Harris_1A2_L"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_GER_Tropentarn_2","CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_6","CUP_U_B_GER_Tropentarn_3","CUP_U_B_GER_Tropentarn_4"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_B_GER_Fleck_Crye2","CUP_U_B_GER_Fleck_Crye"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_GER_Crye2","CUP_U_B_GER_Crye"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_B_GER_Fleck_Crye2","CUP_U_B_GER_Fleck_Crye"];
	OPEX_friendly_ghillieUniforms_woodland = ["CUP_U_B_GER_Fleck_Ghillie"];
	OPEX_friendly_ghillieUniforms_desert = ["CUP_U_B_GER_Ghillie"];
	OPEX_friendly_ghillieUniforms_snow = ["CUP_U_B_GER_Fleck_Ghillie"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Tank"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_GER_Overalls_Tank"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Tank"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_GER_Tropentarn_2","CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_6","CUP_U_B_GER_Tropentarn_3","CUP_U_B_GER_Tropentarn_4"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_GER_Tropentarn_2","CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_6","CUP_U_B_GER_Tropentarn_3","CUP_U_B_GER_Tropentarn_4"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_GER_Tropentarn_2","CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_6","CUP_U_B_GER_Tropentarn_3","CUP_U_B_GER_Tropentarn_4"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_3","CUP_U_B_GER_Flecktarn_4"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_B_GER_PVest_Fleck_RFL","CUP_V_B_GER_PVest_Fleck_MG","CUP_V_B_GER_PVest_Fleck_TL"];
	OPEX_friendly_commonVests_desert = ["CUP_V_B_GER_PVest_Trop_RFL","CUP_V_B_GER_PVest_Trop_MG","CUP_V_B_GER_PVest_Trop_TL"];
	OPEX_friendly_commonVests_snow = ["CUP_V_B_GER_PVest_Fleck_RFL","CUP_V_B_GER_PVest_Fleck_MG","CUP_V_B_GER_PVest_Fleck_TL"];
	OPEX_friendly_specialVests_woodland = ["CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Armatus_Fleck"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_GER_Carrier_Vest_2","CUP_V_B_GER_Armatus_Trop"];
	OPEX_friendly_specialVests_snow = ["CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Armatus_Fleck"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_B_GER_PVest_Fleck_Med_LT","CUP_V_B_GER_PVest_Fleck_Med"];
	OPEX_friendly_medicVests_desert = ["CUP_V_B_GER_PVest_Trop_Med_LT","CUP_V_B_GER_PVest_Trop_Med"];
	OPEX_friendly_medicVests_snow = ["CUP_V_B_GER_PVest_Fleck_Med_LT","CUP_V_B_GER_PVest_Fleck_Med"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_PVest_Fleck_MG_LT","CUP_V_B_GER_PVest_Fleck_TL_LT"];
	OPEX_friendly_lightVests_desert = ["CUP_V_B_GER_PVest_Trop_RFL_LT","CUP_V_B_GER_PVest_Trop_MG_LT","CUP_V_B_GER_PVest_Trop_TL_LT"];
	OPEX_friendly_lightVests_snow = ["CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_PVest_Fleck_MG_LT","CUP_V_B_GER_PVest_Fleck_TL_LT"];
	OPEX_friendly_grenadierVests_woodland = ["CUP_V_B_GER_PVest_Fleck_Gren","CUP_V_B_GER_PVest_Fleck_Gren_LT"];
	OPEX_friendly_grenadierVests_desert = ["CUP_V_B_GER_PVest_Trop_Gren","CUP_V_B_GER_PVest_Trop_Gren_LT"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_B_GER_PVest_Fleck_Gren","CUP_V_B_GER_PVest_Fleck_Gren_LT"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Armatus_Fleck"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_GER_Carrier_Vest_2","CUP_V_B_GER_Armatus_Trop"];
	OPEX_friendly_EODvests_snow = ["CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Armatus_Fleck"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CF"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop_GG_CB","CUP_H_Ger_M92_Cover_Trop_GG","CUP_H_Ger_M92_Cover_Trop_GG_CF"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CF"];
	//OPEX_friendly_specialHelmets_woodland append [];
	OPEX_friendly_specialHelmets_desert append ["CUP_H_OpsCore_Covered_Tropen_SF"];
	//OPEX_friendly_specialHelmets_snow append [];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CF"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop_GG_CB","CUP_H_Ger_M92_Cover_Trop_GG","CUP_H_Ger_M92_Cover_Trop_GG_CF"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CF"];
	OPEX_friendly_heliPilotHelmets = ["H_PilotHelmetHeli_B"];
	//OPEX_friendly_aircraftPilotHelmets = [];
	OPEX_friendly_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["CUP_H_Ger_Boonie_Flecktarn","CUP_H_Ger_Boonie2_Flecktarn"];
	OPEX_friendly_hats_desert = ["CUP_H_Ger_Boonie_desert","CUP_H_Ger_Boonie2_desert"];
	OPEX_friendly_hats_snow = ["CUP_H_Ger_Boonie_Flecktarn","CUP_H_Ger_Boonie2_Flecktarn"];
	OPEX_friendly_leaderHeadgear_woodland = ["CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_ARM_Blk"];
	OPEX_friendly_leaderHeadgear_desert = ["CUP_H_Ger_Beret_ARM_Blk"];
	OPEX_friendly_leaderHeadgear_snow = ["CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_ARM_Blk"];
	OPEX_friendly_berets = ["CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_ARM_Blk"];
	OPEX_friendly_caps = ["CUP_H_Ger_Cap_EP_Tan2","CUP_H_Ger_Cap_EP_Grn1","CUP_H_Ger_Cap_Tan2","CUP_H_Ger_Cap_Tan1","CUP_H_Ger_Cap_Grn1","CUP_H_Ger_Cap_Grn2"];

	// FACEGEAR
	OPEX_friendly_scarfs append ["CUP_G_ESS_KHK_Scarf_Face_Tan","CUP_FR_NeckScarf2","CUP_FR_NeckScarf","CUP_G_Grn_Scarf_Shades","CUP_G_Tan_Scarf_Shades"];
	OPEX_friendly_glasses append ["CUP_G_Oakleys_Clr","CUP_G_Oakleys_Embr","CUP_G_Oakleys_Clr","CUP_G_Oakleys_Embr","CUP_G_Oakleys_Clr","CUP_G_Oakleys_Embr"];
	OPEX_friendly_sunglasses append ["CUP_G_Oakleys_Drk","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Drk"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["CUP_B_GER_Backpack_GL_Fleck","CUP_B_GER_Backpack_MG3_Fleck"];
	OPEX_friendly_mediumBackpacks_desert = ["CUP_B_Backpack_SpecOps","CUP_B_GER_Backpack_GL"];
	OPEX_friendly_mediumBackpacks_snow = ["CUP_B_GER_Backpack_GL_Fleck","CUP_B_GER_Backpack_MG3_Fleck"];
	OPEX_friendly_bigBackpacks_woodland = ["CFP_Kitbag_Flecktarn"];
	OPEX_friendly_bigBackpacks_desert = ["CFP_Kitbag_Tropentarn"];
	OPEX_friendly_bigBackpacks_snow = ["CFP_Kitbag_Flecktarn"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_GER_Backpack_Medic_Fleck"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_GER_Backpack_Medic"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_GER_Backpack_Medic_Fleck"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];