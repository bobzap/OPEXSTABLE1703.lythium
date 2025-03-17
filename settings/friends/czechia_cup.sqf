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
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Czechia"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_cz"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_CzechRepublic"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_czechia.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_czechia.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Bohemia"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_cz.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

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
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_cz.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_cz.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_cz.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_cz.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_cz.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_cz.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_cz.paa";
	OPEX_tv = "pictures\tv_generic.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_cz.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["czech_01", "czech_02", "czech_03", "czech_04", "czech_05", "czech_06", "czech_07", "czech_08", "czech_09", "czech_10", "czech_11", "czech_12", "czech_13", "czech_14", "czech_15", "czech_16", "czech_17", "czech_18", "czech_19", "czech_20", "czech_21", "czech_22", "czech_23", "czech_24", "czech_25", "czech_26", "czech_27", "czech_28", "czech_29", "czech_30", "czech_31", "czech_32", "czech_33", "czech_34", "czech_35", "czech_36", "czech_37", "czech_38", "czech_39", "czech_40", "czech_41", "czech_42", "czech_43", "czech_44", "czech_45", "czech_46", "czech_47", "czech_48", "czech_49", "czech_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["CUP_B_T810_Unarmed_CZ_WDL"];
	OPEX_friendly_transportTrucksOpened_desert = ["CUP_B_T810_Unarmed_CZ_DES"];
	OPEX_friendly_transportTrucksOpened_snow = ["CUP_B_T810_Unarmed_CZ_WDL"];
	OPEX_friendly_transportTrucksCovered_woodland = ["CUP_B_T810_Armed_CZ_WDL"];
	OPEX_friendly_transportTrucksCovered_desert = ["CUP_B_T810_Armed_CZ_DES"];
	OPEX_friendly_transportTrucksCovered_snow = ["CUP_B_T810_Armed_CZ_WDL"];
	OPEX_friendly_fuelTrucks_woodland = ["CUP_B_T810_Refuel_CZ_WDL"];
	OPEX_friendly_fuelTrucks_desert = ["CUP_B_T810_Refuel_CZ_DES"];
	OPEX_friendly_fuelTrucks_snow = ["CUP_B_T810_Refuel_CZ_WDL"];
	OPEX_friendly_logisticTrucks_woodland = ["CUP_B_BRDM2_HQ_CZ"];
	OPEX_friendly_logisticTrucks_desert = ["CUP_B_BRDM2_HQ_CZ_Des"];
	OPEX_friendly_logisticTrucks_snow = ["CUP_B_BRDM2_HQ_CZ"];
	OPEX_friendly_medicalTrucks_woodland = ["CUP_B_LR_Ambulance_CZ_W"];
	OPEX_friendly_medicalTrucks_desert = ["CUP_B_LR_Ambulance_CZ_D"];
	OPEX_friendly_medicalTrucks_snow = ["CUP_B_LR_Ambulance_CZ_W"];
	OPEX_friendly_repairTrucks_woodland = ["CUP_B_T810_Repair_CZ_WDL"];
	OPEX_friendly_repairTrucks_desert = ["CUP_B_T810_Repair_CZ_DES"];
	OPEX_friendly_repairTrucks_snow = ["CUP_B_T810_Repair_CZ_WDL"];
	OPEX_friendly_ammoTrucks_woodland = ["CUP_B_T810_Reammo_CZ_WDL"];
	OPEX_friendly_ammoTrucks_desert = ["CUP_B_T810_Reammo_CZ_DES"];
	OPEX_friendly_ammoTrucks_snow = ["CUP_B_T810_Reammo_CZ_WDL"];
	OPEX_friendly_transportCars_woodland = ["CUP_B_LR_Transport_CZ_W","CUP_B_UAZ_Unarmed_ACR","CUP_B_UAZ_Open_ACR"];
	OPEX_friendly_transportCars_desert = ["CUP_B_LR_Transport_CZ_D"];
	OPEX_friendly_transportCars_snow = ["CUP_B_LR_Transport_CZ_W","CUP_B_UAZ_Unarmed_ACR","CUP_B_UAZ_Open_ACR"];
	OPEX_friendly_combatCarsMG_woodland = ["CUP_B_Dingo_CZ_Wdl","CUP_B_LR_MG_CZ_W","CUP_B_LR_Special_CZ_W","CUP_B_UAZ_MG_ACR"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_B_Dingo_CZ_Des","CUP_B_HMMWV_DSHKM_GPK_ACR","CUP_B_HMMWV_M2_GPK_ACR","CUP_B_LR_Special_Des_CZ_D"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_B_Dingo_CZ_Wdl","CUP_B_LR_MG_CZ_W","CUP_B_LR_Special_CZ_W","CUP_B_UAZ_MG_ACR"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_B_Dingo_GL_CZ_Wdl","CUP_B_UAZ_AGS30_ACR","CUP_B_UAZ_METIS_ACR","CUP_B_UAZ_SPG9_ACR"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_B_Dingo_GL_CZ_Des","CUP_B_HMMWV_AGS_GPK_ACR"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_B_Dingo_GL_CZ_Wdl","CUP_B_UAZ_AGS30_ACR","CUP_B_UAZ_METIS_ACR","CUP_B_UAZ_SPG9_ACR"];
	OPEX_friendly_vtt_woodland = ["CUP_B_BRDM2_CZ"];
	OPEX_friendly_vtt_desert = ["CUP_B_BRDM2_CZ_Des"];
	OPEX_friendly_vtt_snow = ["CUP_B_BRDM2_CZ"];
	OPEX_friendly_tanks_woodland = ["CUP_B_BMP2_CZ","CUP_B_T72_CZ"];
	OPEX_friendly_tanks_desert = ["CUP_B_BMP2_CZ_Des","CUP_B_T72_CZ"];
	OPEX_friendly_tanks_snow = ["CUP_B_BMP2_CZ","CUP_B_T72_CZ"];
	OPEX_friendly_aircrafts = ["CUP_B_L39_CZ","CUP_B_L39_CZ_GREY"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_B_Mi35_Dynamic_CZ_Ram","CUP_B_Mi35_Dynamic_CZ_Dark"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_B_Mi35_Dynamic_CZ_Des","CUP_B_Mi35_Dynamic_CZ"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_B_Mi35_Dynamic_CZ_Ram","CUP_B_Mi35_Dynamic_CZ_Dark"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_B_Mi35_Dynamic_CZ_Ram","CUP_B_Mi35_Dynamic_CZ_Dark"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_B_Mi35_Dynamic_CZ_Des","CUP_B_Mi35_Dynamic_CZ"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_B_Mi35_Dynamic_CZ_Ram","CUP_B_Mi35_Dynamic_CZ_Dark"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_B_Mi171Sh_Unarmed_ACR","CUP_B_Mi171Sh_ACR"];
	OPEX_friendly_MGstatics =["CUP_B_DSHKM_ACR"];
	OPEX_friendly_GLstatics = ["CUP_B_AGS_ACR"];
	OPEX_friendly_AAstatics = ["CUP_B_RBS70_ACR"];
	OPEX_friendly_mortarStatics = ["CUP_B_2b14_82mm_ACR"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Duty"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Phantom","CUP_hgun_Compact","CUP_hgun_Glock17_blk","CUP_hgun_SA61"];
	OPEX_friendly_commonRifles = ["CUP_arifle_CZ805_A1_blk","CUP_arifle_CZ805_A1","CUP_CZ_BREN2_556_14"];
	OPEX_friendly_specialRifles = ["CUP_arifle_CZ805_A2_blk","CUP_arifle_CZ805_A2","CUP_arifle_M4A3_black","CUP_arifle_HK417_20","CUP_arifle_HK417_12"];
	OPEX_friendly_GLrifles = ["CUP_arifle_CZ805_GL_blk","CUP_CZ_BREN2_556_14_GL"];
	OPEX_friendly_MGriflesLight = ["CUP_lmg_minimipara","CUP_lmg_minimi","CUP_lmg_minimi_railed","CUP_lmg_Mk48","CUP_lmg_Mk48_nohg","CUP_lmg_UK59"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_M60E4_norail","CUP_lmg_M60E4","CUP_lmg_MG3","CUP_lmg_MG3_rail"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_MP5SD6","CUP_smg_EVO"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_SVD","CUP_srifle_SVD_top_rail"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_CZ750"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_Javelin"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_Igla_Loaded"];
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
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_CZ_DST_NoKneepads"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_B_CZ_WDL_Kneepads_Gloves"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_CZ_DST_Kneepads_Sleeve"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_B_CZ_WDL_Kneepads_Gloves"];
	OPEX_friendly_ghillieUniforms_woodland append ["CUP_U_B_CZ_WDL_Ghillie"];
	OPEX_friendly_ghillieUniforms_desert append ["CUP_U_B_CZ_WDL_Ghillie"];
	OPEX_friendly_ghillieUniforms_snow append ["CUP_U_B_CZ_WDL_Ghillie"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_CZ_Pilot_WDL"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_B_CZ_WDL_Kneepads"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_CZ_DST_Kneepads_Gloves"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_B_CZ_WDL_Kneepads"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_CZ_DST_NoKneepads"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_CZ_DST_NoKneepads"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_B_CZ_WDL_NoKneepads"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_B_CZ_WDL_TShirt"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_CZ_DST_TShirt"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_B_CZ_WDL_Kneepads"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15","CUP_V_CZ_vest19","CUP_V_CZ_NPP2006_light_vz95"];
	OPEX_friendly_commonVests_desert = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15","CUP_V_CZ_vest19","CUP_V_CZ_NPP2006_light_vz95"];
	OPEX_friendly_commonVests_snow = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15","CUP_V_CZ_vest19","CUP_V_CZ_NPP2006_light_vz95"];
	OPEX_friendly_specialVests_woodland = ["CUP_V_CZ_vest01","CUP_V_CZ_vest16","CUP_V_CZ_vest18","CUP_V_CZ_vest12","CUP_V_CZ_vest11","CUP_V_CZ_vest04","CUP_V_CZ_vest03","CUP_V_CZ_vest08","CUP_V_CZ_vest07","CUP_V_CZ_NPP2006_nk_black","CUP_V_CZ_NPP2006_vz95_black","CUP_V_CZ_NPP2006_ok_black","CUP_V_CZ_NPP2006_nk_vz95","CUP_V_CZ_NPP2006_vz95","CUP_V_CZ_NPP2006_ok_vz95","CUP_V_CZ_NPP2006_co_black","CUP_V_CZ_NPP2006_co_vz95"];
	OPEX_friendly_specialVests_desert = ["CUP_V_CZ_vest01","CUP_V_CZ_vest16","CUP_V_CZ_vest18","CUP_V_CZ_vest12","CUP_V_CZ_vest11","CUP_V_CZ_vest04","CUP_V_CZ_vest03","CUP_V_CZ_vest08","CUP_V_CZ_vest07","CUP_V_CZ_NPP2006_nk_black","CUP_V_CZ_NPP2006_vz95_black","CUP_V_CZ_NPP2006_ok_black","CUP_V_CZ_NPP2006_nk_vz95","CUP_V_CZ_NPP2006_vz95","CUP_V_CZ_NPP2006_ok_vz95","CUP_V_CZ_NPP2006_co_black","CUP_V_CZ_NPP2006_co_vz95","CUP_V_CZ_NPP2006_des","CUP_V_CZ_NPP2006_nk_des","CUP_V_CZ_NPP2006_ok_des","CUP_V_CZ_NPP2006_co_des"];
	OPEX_friendly_specialVests_snow = ["CUP_V_CZ_vest01","CUP_V_CZ_vest16","CUP_V_CZ_vest18","CUP_V_CZ_vest12","CUP_V_CZ_vest11","CUP_V_CZ_vest04","CUP_V_CZ_vest03","CUP_V_CZ_vest08","CUP_V_CZ_vest07","CUP_V_CZ_NPP2006_nk_black","CUP_V_CZ_NPP2006_vz95_black","CUP_V_CZ_NPP2006_ok_black","CUP_V_CZ_NPP2006_nk_vz95","CUP_V_CZ_NPP2006_vz95","CUP_V_CZ_NPP2006_ok_vz95","CUP_V_CZ_NPP2006_co_black","CUP_V_CZ_NPP2006_co_vz95"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_CZ_vest10","CUP_V_CZ_vest09","CUP_V_CZ_vest13","CUP_V_CZ_vest17","CUP_V_CZ_vest14"];
	OPEX_friendly_medicVests_desert = ["CUP_V_CZ_vest10","CUP_V_CZ_vest09","CUP_V_CZ_vest13","CUP_V_CZ_vest17","CUP_V_CZ_vest14"];
	OPEX_friendly_medicVests_snow = ["CUP_V_CZ_vest10","CUP_V_CZ_vest09","CUP_V_CZ_vest13","CUP_V_CZ_vest17","CUP_V_CZ_vest14"];
	OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_rgr","V_BandollierB_rgr","V_BandollierB_blk"];
	OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr","V_BandollierB_cbr","V_BandollierB_blk"];
	OPEX_friendly_shoulderVests_snow = ["V_BandollierB_rgr","V_BandollierB_rgr","V_BandollierB_blk"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15"];
	OPEX_friendly_lightVests_desert = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15"];
	OPEX_friendly_lightVests_snow = ["CUP_V_CZ_vest02","CUP_V_CZ_vest15"];
	OPEX_friendly_grenadierVests_woodland = ["CUP_V_CZ_vest06","CUP_V_CZ_vest05"];
	OPEX_friendly_grenadierVests_desert = ["CUP_V_CZ_vest06","CUP_V_CZ_vest05"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_CZ_vest06","CUP_V_CZ_vest05"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_CZ_vest18"];
	OPEX_friendly_EODvests_desert = ["CUP_V_CZ_vest18"];
	OPEX_friendly_EODvests_snow = ["CUP_V_CZ_vest18"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_CZ_Helmet03","CUP_H_CZ_Helmet03","CUP_H_CZ_Helmet04"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_CZ_Helmet01","CUP_H_CZ_Helmet01","CUP_H_CZ_Helmet02"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_CZ_Helmet03","CUP_H_CZ_Helmet03","CUP_H_CZ_Helmet04"];
	OPEX_friendly_specialHelmets_woodland = ["CUP_H_CZ_Helmet10","CUP_H_CZ_Helmet09","CUP_H_OpsCore_Black","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Spray_SF","H_HelmetSpecB","H_HelmetSpecB_blk"];
	OPEX_friendly_specialHelmets_desert = ["CUP_H_CZ_Helmet07","CUP_H_CZ_Helmet08","CUP_H_OpsCore_Black","CUP_H_OpsCore_Tan","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Tan_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Tan_SF","H_HelmetSpecB_sand","H_HelmetSpecB_blk"];
	OPEX_friendly_specialHelmets_snow = ["CUP_H_CZ_Helmet10","CUP_H_CZ_Helmet09","CUP_H_OpsCore_Black","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Spray_SF","H_HelmetSpecB","H_HelmetSpecB_blk"];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_Altyn_Shield_Up"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_Altyn_Shield_Up_black"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_Altyn_Shield_Up"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_CZ_Helmet05"];
	OPEX_friendly_aircraftPilotHelmets = ["CUP_H_CZ_Helmet06"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_CZ_Helmet05"];
	OPEX_friendly_cameraHelmets_woodland = ["CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Spray_SF","H_HelmetSpecB","H_HelmetSpecB_blk"];
	OPEX_friendly_cameraHelmets_desert = ["CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Tan_SF","H_HelmetSpecB_sand","H_HelmetSpecB_blk"];
	OPEX_friendly_cameraHelmets_snow = ["CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Spray_SF","H_HelmetSpecB","H_HelmetSpecB_blk"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["H_Booniehat_oli","CUP_H_CZ_Hat02","CUP_H_CZ_Hat03"];
	OPEX_friendly_hats_desert = ["H_Booniehat_tan","CUP_H_CZ_Booniehat_vz95_des","CUP_H_CZ_Booniehat_fold_des"];
	OPEX_friendly_hats_snow = ["H_Booniehat_oli","CUP_H_CZ_Hat02","CUP_H_CZ_Hat03"];
	OPEX_friendly_beanies_woodland = ["H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki"];
	OPEX_friendly_beanies_desert = ["CUP_H_CZ_Pakol_headset_f_brown","CUP_H_CZ_Pakol_headset_b_grey"];
	OPEX_friendly_beanies_snow = ["H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Headphones_Winter"];
	OPEX_friendly_leaderHeadgear_woodland = ["CUP_H_CZ_Hat01","CUP_H_CZ_Patrol_Cap"];
	OPEX_friendly_leaderHeadgear_desert = ["CUP_H_CZ_Hat01"];
	OPEX_friendly_leaderHeadgear_snow = ["CUP_H_CZ_Hat01","CUP_H_CZ_Patrol_Cap"];
	OPEX_friendly_berets = ["CUP_H_CZ_Hat01"];
	OPEX_friendly_caps = ["H_Cap_oli_hs","CUP_H_PMC_Cap_Grey","CUP_H_CZ_Cap_khk","CUP_H_CZ_Cap_Headphones_des","CUP_H_CZ_Cap_flag","CUP_H_CZ_Cap_Headphones","CUP_H_CZ_Cap_rgr","CUP_H_CZ_Hat04","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_PMC_Cap_Back_PRR_Grey","CUP_H_PMC_Cap_Back_PRR_Tan","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_bandanas = ["H_Bandanna_khk","H_Bandanna_sand","H_Bandanna_gry","H_Bandanna_khk_hs"];
	OPEX_friendly_headsets append ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset","CUP_H_PMC_PRR_Headset"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["CUP_B_Kombat_Olive","CUP_B_ACRScout_m95","CUP_B_USPack_Black","B_AssaultPack_khk","B_AssaultPack_blk","B_AssaultPack_rgr","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_mediumBackpacks_desert = ["CUP_B_USPack_Coyote","B_AssaultPack_cbr","B_Kitbag_cbr","B_Kitbag_tan","CUP_B_Kombat_Olive","CUP_B_ACRScout_m95","CUP_B_USPack_Black","B_AssaultPack_blk","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_mediumBackpacks_snow = ["CUP_B_Kombat_Olive","CUP_B_ACRScout_m95","CUP_B_USPack_Black","B_AssaultPack_khk","B_AssaultPack_blk","B_AssaultPack_rgr","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_bigBackpacks_woodland = ["CUP_B_ACRPara_m95","B_Carryall_oli"];
	OPEX_friendly_bigBackpacks_desert = ["CUP_B_ACRPara_m95","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow = ["CUP_B_ACRPara_m95","B_Carryall_oli"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_GER_Medic_Desert"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];