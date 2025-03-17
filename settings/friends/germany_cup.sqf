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

	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Vehicles_Core"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Weapons_WeaponsCore"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Creatures_Extra"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "CUP"; // mod name (example: "myCustomMod")
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
	OPEX_friendly_transportCars_woodland = ["CUP_B_FENNEK_GER_Wdl"];
	OPEX_friendly_transportCars_desert = ["CUP_B_FENNEK_GER_Des"];
	OPEX_friendly_transportCars_snow = ["CUP_B_FENNEK_GER_Wdl"];
	OPEX_friendly_combatCarsMG_woodland = ["CUP_B_Dingo_GER_Wdl"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_B_Dingo_GER_Des"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_B_Dingo_GER_Wdl"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_B_Dingo_GL_GER_Wdl"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_B_Dingo_GL_GER_Des"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_B_Dingo_GL_GER_Wdl"];
	OPEX_friendly_tanks_woodland = ["CUP_B_Leopard2A6_GER"];
	OPEX_friendly_tanks_desert = ["CUP_B_Leopard2A6DST_GER"];
	OPEX_friendly_tanks_snow = ["CUP_B_Leopard2A6_GER"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_B_UH1D_armed_GER_KSK","CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_B_UH1D_armed_GER_KSK_Des","CUP_B_UH1D_gunship_GER_KSK_Des"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_B_UH1D_armed_GER_KSK","CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_B_UH1D_armed_GER_KSK","CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_B_UH1D_armed_GER_KSK_Des","CUP_B_UH1D_gunship_GER_KSK_Des"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_B_UH1D_armed_GER_KSK","CUP_B_UH1D_gunship_GER_KSK"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_B_UH1D_GER_KSK","CUP_B_UH1D_slick_GER_KSK"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_B_UH1D_slick_GER_KSK_Des","CUP_B_UH1D_GER_KSK_Des"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_B_UH1D_GER_KSK","CUP_B_UH1D_slick_GER_KSK"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_B_UH1D_GER_KSK","CUP_B_UH1D_slick_GER_KSK"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_B_UH1D_slick_GER_KSK_Des","CUP_B_UH1D_GER_KSK_Des"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_B_UH1D_GER_KSK","CUP_B_UH1D_slick_GER_KSK"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_B_CH53E_GER"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_B_CH53E_GER"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_B_CH53E_GER"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["CUP_B_M2StaticMG_GER_Fleck"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Glock17_blk"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Glock17_blk","CUP_hgun_M9"];
	OPEX_friendly_commonRifles = ["CUP_arifle_G36A"];
	OPEX_friendly_specialRifles = ["CUP_arifle_G36A_RIS","CUP_arifle_G36K","CUP_arifle_G36K_KSK","CUP_arifle_G36K_KSK_VFG","CUP_arifle_G36K_VFG","CUP_arifle_G36K_RIS","CUP_arifle_G3A3_ris_black","CUP_arifle_G3A3_ris_vfg_black","CUP_arifle_G3A3_modern_ris_black","CUP_arifle_HK416_Black"];
	OPEX_friendly_GLrifles = ["CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_AG36","CUP_arifle_G36A_AG36_RIS","CUP_arifle_G36A_AG36_RIS","CUP_arifle_G36K_AG36","CUP_arifle_G36K_RIS_AG36","CUP_arifle_HK416_CQB_M203_Black","CUP_arifle_HK416_CQB_AG36","CUP_arifle_HK416_M203_Black","CUP_arifle_HK416_AGL_Black"];
	OPEX_friendly_MGriflesLight = ["CUP_arifle_MG36"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_MG3","CUP_lmg_MG3_rail"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_arifle_G36C","CUP_arifle_G36C_VFG_Carry","CUP_arifle_G36C_VFG","CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_MP5SD6","CUP_arifle_HK416_CQB_Black","CUP_smg_MP7"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_G22_wdl","CUP_srifle_G22_des"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_M107_Pristine"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_MAAWS"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_FIM92Stinger"];
	OPEX_friendly_shotguns = ["CUP_sgun_M1014","CUP_sgun_M1014_solidstock","CUP_sgun_M1014_Entry"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["CUP_optic_CompM4","CUP_optic_MicroT1","CUP_optic_MicroT1_low","CUP_optic_HoloBlack","CUP_optic_Eotech553_Black","CUP_optic_MARS","CUP_optic_MRad"];
	OPEX_friendly_distantCombatOptics append ["CUP_optic_AIMM_COMPM4_BLK","CUP_optic_AIMM_MICROT1_BLK","CUP_optic_Elcan_SpecterDR_black","CUP_optic_Elcan_SpecterDR_RMR_black","CUP_optic_Elcan","CUP_optic_Elcan_reflex","CUP_optic_G33_HWS_BLK","CUP_optic_HensoldtZO","CUP_optic_HensoldtZO_low","CUP_optic_HensoldtZO_low_RDS","CUP_optic_HensoldtZO_RDS","CUP_optic_LeupoldMk4_CQ_T","CUP_optic_CompM2_low","CUP_optic_AIMM_M68_BLK","CUP_optic_AIMM_COMPM2_BLK","CUP_optic_CompM2_Black","CUP_optic_AIMM_MARS_BLK","CUP_optic_ZDDot","CUP_optic_AIMM_ZDDOT_BLK","CUP_optic_ACOG_TA01B_Black","CUP_optic_ACOG_TA01B_RMR_Black","CUP_optic_RCO","CUP_optic_ACOG_TA01NSN_RMR_Black","CUP_optic_ACOG2","CUP_optic_ACOG_TA31_KF","CUP_optic_ACOG"];
	OPEX_friendly_sniperOptics append ["CUP_optic_AN_PAS_13c1","CUP_optic_AN_PVS_10_black","CUP_optic_CWS","CUP_optic_ElcanM145","CUP_optic_GOSHAWK_RIS","CUP_optic_LeupoldMk4","CUP_optic_LeupoldM3LR","CUP_optic_LeupoldMk4_20x40_LRT","CUP_optic_LeupoldMk4_25x50_LRT","CUP_optic_Leupold_VX3","CUP_optic_SB_11_4x20_PM","CUP_optic_SB_3_12x50_PMII"];
	OPEX_friendly_flashlights append ["CUP_acc_Flashlight","CUP_acc_Flashlight","CUP_acc_Flashlight","CUP_acc_LLM01_L","CUP_acc_XM8_light_module","CUP_acc_Glock17_Flashlight","CUP_acc_CZ_M3X"];
	OPEX_friendly_rifleSilencers append ["CUP_muzzle_mfsup_Flashhider_556x45_Black","CUP_muzzle_mfsup_SCAR_L","CUP_muzzle_snds_G36_black","CUP_muzzle_snds_M16","CUP_muzzle_snds_XM8","CUP_muzzle_snds_SCAR_L","CUP_muzzle_mfsup_Suppressor_M107_Black","CUP_muzzle_snds_M110_black","muzzle_snds_58_blk_F"];
	OPEX_friendly_handgunSilencers append ["CUP_muzzle_snds_M9","CUP_muzzle_snds_mk23"];
	OPEX_friendly_pointers append ["CUP_acc_ANPEQ_15_Black","CUP_acc_ANPEQ_15_Black_Top","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_acc_ANPEQ_15_Top_Flashlight_Black_L","CUP_acc_ANPEQ_2_grey","CUP_acc_ANPEQ_2_Black_Top","CUP_acc_ANPEQ_2_Flashlight_Black_L","CUP_acc_LLM_black","CUP_acc_mk23_lam_f","CUP_acc_MLPLS_Laser"];
	OPEX_friendly_bipods append ["CUP_bipod_VLTOR_Modpod_black"];

	// VARIOUS ITEMS
	OPEX_friendly_NVGs append ["CUP_NVG_PVS14","CUP_NVG_PVS15_black","CUP_NVG_PVS7","CUP_NVG_HMNVS"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_5","CUP_U_B_GER_Tropentarn_8"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_B_GER_Flecktarn_5","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_6","CUP_U_B_GER_Flecktarn_6"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_B_GER_Flecktarn_1","CUP_U_B_GER_Flecktarn_8","CUP_U_B_GER_Flecktarn_7","CUP_U_B_GER_Flecktarn_4","CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_3"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_GER_Tropentarn_1","CUP_U_B_GER_Tropentarn_8","CUP_U_B_GER_Tropentarn_6","CUP_U_B_GER_Tropentarn_7","CUP_U_B_GER_Tropentarn_4","CUP_U_B_GER_Tropentarn_2","CUP_U_B_GER_Tropentarn_3"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_B_GER_Flecktarn_1","CUP_U_B_GER_Flecktarn_8","CUP_U_B_GER_Flecktarn_7","CUP_U_B_GER_Flecktarn_4","CUP_U_B_GER_Flecktarn_2","CUP_U_B_GER_Flecktarn_3"];
	OPEX_friendly_ghillieUniforms_woodland append ["CUP_U_B_BAF_MTP_GHILLIE"];
	OPEX_friendly_ghillieUniforms_desert append ["CUP_U_B_BAF_DDPM_GHILLIE"];
	OPEX_friendly_ghillieUniforms_snow append ["CUP_U_B_BAF_MTP_GHILLIE"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Pilot"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_B_GER_Fleck_Overalls_Tank"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_GER_Overalls_Tank"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_B_GER_Fleck_Overalls_Tank"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_B_GER_Flecktarn_1"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_GER_Tropentarn_1","CUP_U_B_GER_Tropentarn_4"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_B_GER_Flecktarn_1"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_B_GER_Flecktarn_5"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_GER_Tropentarn_5"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_B_GER_Flecktarn_5"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_B_GER_Fleck_Crye2"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_GER_Crye2"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_B_GER_Fleck_Crye"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_1","CUP_V_B_GER_Vest_1"];
	OPEX_friendly_commonVests_desert = ["CUP_V_B_GER_PVest_Trop_RFL_LT","CUP_V_B_Eagle_SPC_Empty","CUP_V_B_Eagle_SPC_Empty"];
	OPEX_friendly_commonVests_snow = ["CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_2"];
	OPEX_friendly_specialVests_woodland = ["CUP_V_B_GER_PVest_Fleck_RFL","CUP_V_B_GER_PVest_Fleck_OFC","CUP_V_B_GER_PVest_Fleck_TL","CUP_V_B_GER_PVest_Fleck_TL_LT","CUP_V_B_GER_PVest_Fleck_TL_LT","CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Tactical_Fleck","CUP_V_B_GER_Armatus_Fleck","CUP_V_B_GER_Armatus_Fleck","CUP_V_B_GER_Armatus_BB_Fleck","CUP_V_B_GER_Carrier_Vest_3"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_GER_PVest_Trop_RFL","CUP_V_B_GER_PVest_Trop_OFC","CUP_V_B_GER_PVest_Trop_TL","CUP_V_B_GER_PVest_Trop_TL_LT","CUP_V_B_GER_PVest_Trop_TL_LT","CUP_V_B_GER_Carrier_Vest_2","CUP_V_B_GER_Carrier_Vest_2","CUP_V_B_GER_Tactical_Trop","CUP_V_B_GER_Armatus_Trop","CUP_V_B_GER_Armatus_Trop","CUP_V_B_GER_Armatus_BB_Trop","CUP_V_I_RACS_Carrier_Vest_2","CUP_V_I_RACS_Carrier_Vest"];
	OPEX_friendly_specialVests_snow = ["CUP_V_B_GER_PVest_Fleck_RFL","CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_PVest_Fleck_OFC","CUP_V_B_GER_PVest_Fleck_TL","CUP_V_B_GER_PVest_Fleck_TL_LT","CUP_V_B_GER_PVest_Fleck_TL_LT","CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Tactical_Fleck","CUP_V_B_GER_Armatus_Fleck","CUP_V_B_GER_Armatus_Fleck","CUP_V_B_GER_Armatus_BB_Fleck","CUP_V_B_GER_Carrier_Vest_3"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_B_GER_PVest_Fleck_Med","CUP_V_B_GER_PVest_Fleck_Med_LT","CUP_V_B_GER_PVest_Fleck_Med_LT"];
	OPEX_friendly_medicVests_desert = ["CUP_V_B_GER_PVest_Trop_Med","CUP_V_B_GER_PVest_Trop_Med_LT","CUP_V_B_GER_PVest_Trop_Med_LT"];
	OPEX_friendly_medicVests_snow = ["CUP_V_B_GER_PVest_Fleck_Med","CUP_V_B_GER_PVest_Fleck_Med_LT","CUP_V_B_GER_PVest_Fleck_Med_LT"];
	OPEX_friendly_beltVests_woodland = ["V_Rangemaster_belt"];
	OPEX_friendly_beltVests_desert = ["V_Rangemaster_belt"];
	OPEX_friendly_beltVests_snow = ["V_Rangemaster_belt"];
	OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_oli","","CUP_V_B_GER_Carrier_Rig"];
	OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr","V_HarnessO_gryCUP_V_B_GER_Carrier_Rig_2","CUP_V_I_RACS_Carrier_Rig_2","CUP_V_I_RACS_Carrier_Rig_3"];
	OPEX_friendly_shoulderVests_snow = ["V_BandollierB_oli","CUP_V_B_GER_Carrier_Rig_2","CUP_V_B_GER_Carrier_Rig"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_JPC_Fleck_Light","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_1"];
	OPEX_friendly_lightVests_desert = ["CUP_V_B_JPC_Trop_Light","CUP_V_B_Eagle_SPC_Empty"];
	OPEX_friendly_lightVests_snow = ["CUP_V_B_JPC_Fleck_Light","CUP_V_B_GER_Vest_2","CUP_V_B_GER_Vest_1"];
	OPEX_friendly_grenadierVests_woodland = ["CUP_V_B_GER_PVest_Fleck_Gren","CUP_V_B_GER_PVest_Fleck_Gren_LT","CUP_V_B_GER_PVest_Fleck_Gren_LT"];
	OPEX_friendly_grenadierVests_desert = ["V_HarnessOGL_gry","CUP_V_B_GER_PVest_Trop_Gren","CUP_V_B_GER_PVest_Trop_Gren_LT","CUP_V_B_GER_PVest_Trop_Gren_LT"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_B_GER_PVest_Fleck_Gren","CUP_V_B_GER_PVest_Fleck_Gren_LT","CUP_V_B_GER_PVest_Fleck_Gren_LT"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_B_GER_PVest_Fleck_MG","CUP_V_B_GER_PVest_Fleck_MG_LT","CUP_V_B_GER_PVest_Fleck_MG_LT"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_GER_PVest_Trop_MG","CUP_V_B_GER_PVest_Trop_MG_LT","CUP_V_B_GER_PVest_Trop_MG_LT"];
	OPEX_friendly_EODvests_snow = ["CUP_V_B_GER_PVest_Fleck_MG","CUP_V_B_GER_PVest_Fleck_MG_LT","CUP_V_B_GER_PVest_Fleck_MG_LT"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG_CF"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop","CUP_H_Ger_M92_Cover_Trop_GG","CUP_H_Ger_M92_Cover_Trop_GG_CB","CUP_H_Ger_M92_Cover_Trop_GG_CF"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover","CUP_H_Ger_M92_Cover_GG","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_Ger_M92_Cover_GG_CF"];
	OPEX_friendly_specialHelmets_woodland = ["H_HelmetB_light_black","CUP_H_Ger_M92_Black","CUP_H_Ger_M92_Black_GG","CUP_H_Ger_M92","CUP_H_Ger_M92_GG_CB","CUP_H_Ger_M92_GG_CF","CUP_H_GER_LWH_Flecktarn","CUP_H_OpsCore_Black","CUP_H_OpsCore_Covered_Fleck","CUP_H_OpsCore_Covered_Fleck_NoHS","CUP_H_OpsCore_Covered_Fleck_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_specialHelmets_desert = ["H_HelmetB_light_snakeskin","CUP_H_Ger_M92_Black","CUP_H_Ger_M92_Black_GG","CUP_H_Ger_M92","CUP_H_Ger_M92_GG_CB","CUP_H_Ger_M92_GG_CF","CUP_H_GER_LWH_Tropentarn","CUP_H_OpsCore_Black","CUP_H_OpsCore_Covered_Tropen","CUP_H_OpsCore_Covered_Tropen_NoHS","CUP_H_OpsCore_Covered_Tropen_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_specialHelmets_snow = ["H_HelmetB_light_black","CUP_H_Ger_M92_Black","CUP_H_Ger_M92_Black_GG","CUP_H_Ger_M92","CUP_H_Ger_M92_GG_CB","CUP_H_Ger_M92_GG_CF","CUP_H_GER_LWH_Flecktarn","CUP_H_OpsCore_Black","CUP_H_OpsCore_Covered_Fleck","CUP_H_OpsCore_Covered_Fleck_NoHS","CUP_H_OpsCore_Covered_Fleck_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_K6_3_Shield_Up_khaki","CUP_H_RUS_K6_3_Shield_Up_black"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_K6_3_Shield_Up_khaki","CUP_H_RUS_K6_3_Shield_Up_black"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_K6_3_Shield_Up_khaki","CUP_H_RUS_K6_3_Shield_Up_black"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_BAF_PILOT"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_USMC_ACVC_WDL"];
	OPEX_friendly_cameraHelmets_woodland append ["CUP_H_OpsCore_Covered_Fleck_SF","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_cameraHelmets_desert append ["CUP_H_OpsCore_Covered_Tropen_SF","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_cameraHelmets_snow append ["CUP_H_OpsCore_Covered_Fleck_SF","CUP_H_OpsCore_Black_SF"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["CUP_H_Ger_Boonie2_Flecktarn","CUP_H_Ger_Boonie2_Flecktarn","CUP_H_Ger_Boonie_Flecktarn"];
	OPEX_friendly_hats_desert = ["CUP_H_Ger_Boonie2_desert","CUP_H_Ger_Boonie2_desert","CUP_H_Ger_Boonie_desert"];
	OPEX_friendly_hats_snow = ["CUP_H_Ger_Boonie2_Flecktarn","CUP_H_Ger_Boonie2_Flecktarn","CUP_H_Ger_Boonie_Flecktarn"];
	OPEX_friendly_beanies_woodland = ["H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","CUP_H_PMC_Beanie_Black","CUP_H_SLA_BeanieGreen","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Khaki"];
	OPEX_friendly_beanies_desert = ["H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","CUP_H_C_Beanie_02","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Khaki"];
	OPEX_friendly_beanies_snow = ["H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","CUP_H_PMC_Beanie_Black","CUP_H_SLA_BeanieGreen","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Khaki"];
	OPEX_friendly_leaderHeadgear_woodland = ["CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_TankCommander_Blk","CUP_H_Ger_Beret_ARM_Grn","CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_TankCommander_Grn","CUP_H_Ger_Beret_KSK_Red","CUP_H_Ger_Beret_KSK_Red"];
	OPEX_friendly_leaderHeadgear_desert = ["CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_TankCommander_Blk","CUP_H_Ger_Beret_ARM_Grn","CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_TankCommander_Grn","CUP_H_Ger_Beret_KSK_Red","CUP_H_Ger_Beret_KSK_Red"];
	OPEX_friendly_leaderHeadgear_snow = ["CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_TankCommander_Blk","CUP_H_Ger_Beret_ARM_Grn","CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_TankCommander_Grn","CUP_H_Ger_Beret_KSK_Red","CUP_H_Ger_Beret_KSK_Red"];
	OPEX_friendly_berets = ["CUP_H_Ger_Beret_ARM_Blk","CUP_H_Ger_Beret_ARM_Grn","CUP_H_Ger_Beret_INF_Grn","CUP_H_Ger_Beret_KSK_Red"];
	OPEX_friendly_caps = ["CUP_H_PMC_Cap_Grey","CUP_H_Ger_Cap_Grn2","CUP_H_Ger_Cap_Grn2","CUP_H_Ger_Cap_Grn2","CUP_H_Ger_Cap_Grn1","CUP_H_Ger_Cap_Grn1","CUP_H_Ger_Cap_Grn1","CUP_H_Ger_Cap_Tan2","CUP_H_Ger_Cap_Tan2","CUP_H_Ger_Cap_Tan1","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_PMC_Cap_Back_PRR_Grey","CUP_H_PMC_Cap_Back_PRR_Tan","CUP_H_PMC_Cap_EP_Grey","CUP_H_Ger_Cap_EP_Grn2","CUP_H_Ger_Cap_EP_Grn1","CUP_H_Ger_Cap_EP_Tan2","CUP_H_Ger_Cap_EP_Tan1","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_bandanas = ["H_Bandanna_cbr","H_Bandanna_khk","H_Bandanna_gry","H_Bandanna_sand","H_Bandanna_khk_hs"];
	OPEX_friendly_shemags = ["H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive"];
	OPEX_friendly_headsets append ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset","CUP_H_PMC_PRR_Headset"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_blk","B_Kitbag_rgr","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_mediumBackpacks_desert = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_GER_Medic_Tropentarn","CUP_B_GER_Medic_Tropentarn","CUP_B_GER_Medic_Tropentarn","CUP_B_GER_Medic_Tropentarn","CUP_B_GER_Medic_Tropentarn","B_AssaultPack_cbr","B_AssaultPack_cbr","B_AssaultPack_blk","B_Kitbag_tan","B_Kitbag_tan","B_TacticalPack_blk"];
	OPEX_friendly_mediumBackpacks_snow = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","CUP_B_GER_Medic_FLecktarn","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_blk","B_Kitbag_rgr","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_bigBackpacks_woodland = ["CUP_B_USPack_Black","B_Carryall_oli"];
	OPEX_friendly_bigBackpacks_desert = ["CUP_B_USPack_Coyote","CUP_B_GER_Pack_Tropentarn","CUP_B_GER_Pack_Tropentarn","CUP_B_GER_Pack_Tropentarn","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow = ["CUP_B_USPack_Black","B_Carryall_oli"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_GER_Medic_FLecktarn"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_GER_Medic_Tropentarn"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_GER_Medic_FLecktarn"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];