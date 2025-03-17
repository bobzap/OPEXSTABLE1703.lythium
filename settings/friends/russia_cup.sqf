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
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_RU"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Russia"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_ru";

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Russia";
	OPEX_friendly_flag_faction = "pictures\flag_russia.paa"; // e.g.: NATO
	OPEX_friendly_flag_country = "pictures\flag_russia.paa"; // e.g.: USA
	OPEX_friendly_flag_army = "pictures\flag_army_russia.paa"; // e.g.: Camp Liberty
	OPEX_friendly_insigna = "";

	// CAMP
	OPEX_friendly_camp = "Camp Spoutnik";
	OPEX_sign_camp = "pictures\sign_camp_ru.paa";

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_ru.paa";
	OPEX_sign_armory = "pictures\sign_armory_ru.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_ru.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_ru.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_ru.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_ru.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_ru.paa";
	OPEX_sign_jail = "pictures\sign_jail_ru.paa";
	OPEX_sign_medical = "pictures\sign_medical_ru.paa";
	OPEX_sign_practice = "pictures\sign_practice_ru.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_ru.paa";
	OPEX_sign_toc = "pictures\sign_toc_ru.paa";
	OPEX_sign_training = "pictures\sign_training_ru.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_ru.paa";
	OPEX_sign_showers = "pictures\sign_showers_ru.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_ru.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_ru.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_ru.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_ru.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_ru.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_ru.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_ru.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_ru.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_ru.paa";
	OPEX_tv = "pictures\tv_ru.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_ru.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_ru.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	OPEX_friendly_identities = ["russian_01", "russian_02", "russian_03", "russian_04", "russian_05", "russian_06", "russian_07", "russian_08", "russian_09", "russian_10", "russian_11", "russian_12", "russian_13", "russian_14", "russian_15", "russian_16", "russian_17", "russian_18", "russian_19", "russian_20", "russian_21", "russian_22", "russian_23", "russian_24", "russian_25", "russian_26", "russian_27", "russian_28", "russian_29", "russian_30", "russian_31", "russian_32", "russian_33", "russian_34", "russian_35", "russian_36", "russian_37", "russian_38", "russian_39", "russian_40", "russian_41", "russian_42", "russian_43", "russian_44", "russian_45", "russian_46", "russian_47", "russian_48", "russian_49", "russian_50"];

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["CUP_O_Ural_Open_RU"];
	OPEX_friendly_transportTrucksOpened_desert = ["CUP_O_Kamaz_Open_RU"];
	OPEX_friendly_transportTrucksOpened_snow = ["CUP_O_Ural_Open_RU"];
	OPEX_friendly_transportTrucksCovered_woodland = ["CUP_O_Ural_RU"];
	OPEX_friendly_transportTrucksCovered_desert = ["CUP_O_Kamaz_RU"];
	OPEX_friendly_transportTrucksCovered_snow = ["CUP_O_Ural_RU"];
	OPEX_friendly_fuelTrucks_woodland = ["CUP_O_Ural_Refuel_RU"];
	OPEX_friendly_fuelTrucks_desert = ["CUP_O_Kamaz_Refuel_RU"];
	OPEX_friendly_fuelTrucks_snow = ["CUP_O_Ural_Refuel_RU"];
	OPEX_friendly_logisticTrucks_woodland = ["CUP_O_BRDM2_HQ_RUS","CUP_O_BTR90_HQ_RU"];
	OPEX_friendly_logisticTrucks_desert = ["CUP_O_BRDM2_HQ_RUS","CUP_O_BTR90_HQ_RU"];
	OPEX_friendly_logisticTrucks_snow = ["CUP_O_BRDM2_HQ_RUS","CUP_O_BTR90_HQ_RU"];
	OPEX_friendly_medicalTrucks_woodland = ["CUP_O_GAZ_Vodnik_MedEvac_RU"];
	OPEX_friendly_medicalTrucks_desert = ["CUP_O_GAZ_Vodnik_MedEvac_RU"];
	OPEX_friendly_medicalTrucks_snow = ["CUP_O_GAZ_Vodnik_MedEvac_RU"];
	OPEX_friendly_repairTrucks_woodland = ["CUP_O_Ural_Repair_RU"];
	OPEX_friendly_repairTrucks_desert = ["CUP_O_Kamaz_Repair_RU"];
	OPEX_friendly_repairTrucks_snow = ["CUP_O_Ural_Repair_RU"];
	OPEX_friendly_ammoTrucks_woodland = ["CUP_O_Ural_Reammo_RU"];
	OPEX_friendly_ammoTrucks_desert = ["CUP_O_Kamaz_Reammo_RU"];
	OPEX_friendly_ammoTrucks_snow = ["CUP_O_Ural_Reammo_RU"];
	OPEX_friendly_transportCars_woodland = ["CUP_O_UAZ_Open_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU"];
	OPEX_friendly_transportCars_desert = ["CUP_O_UAZ_Open_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU"];;
	OPEX_friendly_transportCars_snow = ["CUP_O_UAZ_Open_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU","CUP_O_UAZ_Unarmed_RU"];;
	OPEX_friendly_combatCarsMG_woodland = ["CUP_O_UAZ_MG_RU"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_O_UAZ_MG_RU"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_O_UAZ_MG_RU"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_SPG9_RU"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_SPG9_RU"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_SPG9_RU"];
	OPEX_friendly_vtt_woodland = ["CUP_O_BMP2_RU","CUP_O_BMP_HQ_RU","CUP_O_BMP3_RU","CUP_O_BRDM2_RUS","CUP_O_BRDM2_ATGM_RUS","CUP_O_BTR90_RU","CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_MTLB_pk_WDL_RU","CUP_O_BTR60_RU"];
	OPEX_friendly_vtt_desert = ["CUP_O_BMP2_RU","CUP_O_BMP_HQ_RU","CUP_O_BMP3_RU","CUP_O_BRDM2_RUS","CUP_O_BRDM2_ATGM_RUS","CUP_O_BTR90_RU","CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_MTLB_pk_WDL_RU","CUP_O_BTR60_RU"];
	OPEX_friendly_vtt_snow = ["CUP_O_BMP2_RU","CUP_O_BMP_HQ_RU","CUP_O_BMP3_RU","CUP_O_BRDM2_RUS","CUP_O_BRDM2_ATGM_RUS","CUP_O_BTR90_RU","CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_MTLB_pk_Winter_RU","CUP_O_MTLB_pk_Winter_RU","CUP_O_BTR60_Winter_RU","CUP_O_BTR60_Winter_RU"];
	OPEX_friendly_tanks_woodland = ["CUP_O_T72_RU","CUP_O_T90_RU"];
	OPEX_friendly_tanks_desert = ["CUP_O_T72_RU","CUP_O_T90_RU"];
	OPEX_friendly_tanks_snow = ["CUP_O_T72_RU","CUP_O_T90_RU"];
	OPEX_friendly_zodiacs = ["CUP_O_PBX_RU"];
	OPEX_friendly_aircrafts = ["CUP_O_Su25_Dyn_RU","CUP_O_SU34_RU"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_O_Ka50_DL_RU","CUP_O_Ka52_RU"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_O_Ka50_DL_RU","CUP_O_Ka52_RU"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_O_Ka50_DL_RU","CUP_O_Ka52_RU"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_O_Mi24_P_Dynamic_RU","CUP_O_Mi24_V_Dynamic_RU"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_O_Mi24_P_Dynamic_RU","CUP_O_Mi24_V_Dynamic_RU"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_O_Mi24_P_Dynamic_RU","CUP_O_Mi24_V_Dynamic_RU"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_O_Ka60_Grey_RU"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_O_Ka60_Grey_RU"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_O_Ka60_Grey_RU"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_O_Mi8_RU","CUP_O_Mi8_VIV_RU","CUP_O_Mi8AMT_RU"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_O_Mi8_RU","CUP_O_Mi8_VIV_RU","CUP_O_Mi8AMT_RU"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_O_Mi8_RU","CUP_O_Mi8_VIV_RU","CUP_O_Mi8AMT_RU"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_O_MI6T_RU","CUP_O_MI6T_RU"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_O_MI6T_RU","CUP_O_MI6T_RU"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_O_MI6T_RU","CUP_O_MI6T_RU"];
	OPEX_friendly_UAVs = ["CUP_O_Pchela1T_RU"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["CUP_O_KORD_high_RU"];
	OPEX_friendly_GLstatics = ["CUP_O_AGS_RU"];
	OPEX_friendly_ATstatics = ["CUP_O_Metis_RU"];
	OPEX_friendly_AAstatics = ["CUP_O_Igla_AA_pod_RU"];
	OPEX_friendly_mortarStatics = ["CUP_O_2b14_82mm_RU"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Makarov","CUP_hgun_PMM"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Makarov","CUP_hgun_PMM"];
	OPEX_friendly_commonRifles = ["CUP_arifle_AK74M","CUP_arifle_AK74M_top_rail"];
	OPEX_friendly_specialRifles = ["CUP_arifle_AK74M_railed","CUP_arifle_AK74M_railed","CUP_arifle_AK74M_railed","CUP_arifle_AK74M_railed","CUP_arifle_AK74M_railed","CUP_arifle_OTS14_GROZA_762_Grip","CUP_arifle_OTS14_GROZA_Grip","CUP_arifle_AS_VAL","CUP_arifle_AS_VAL_VFG","CUP_arifle_AS_VAL_top_rail","CUP_arifle_AS_VAL_VFG_top_rail","CUP_arifle_AK101","CUP_arifle_AK101_top_rail","CUP_arifle_AK101_railed","CUP_arifle_AK103","CUP_arifle_AK103_top_rail","CUP_arifle_AK103_railed","CUP_arifle_AK104_railed","CUP_arifle_AK105_railed","CUP_arifle_AK107","CUP_arifle_AK107_top_rail","CUP_arifle_AK107_railed","CUP_arifle_AK108","CUP_arifle_AK108_top_rail","CUP_arifle_AK108_railed","CUP_arifle_AK109","CUP_arifle_AK109_top_rail","CUP_arifle_AK109_railed"];
	OPEX_friendly_GLrifles = ["CUP_arifle_AK74M_GL","CUP_arifle_AK74M_GL","CUP_arifle_AK74M_GL","CUP_arifle_AK74M_GL_top_rail","CUP_arifle_AK74M_GL_top_rail","CUP_arifle_AK74M_GL_top_rail","CUP_arifle_AK74M_GL_railed","CUP_arifle_AK103_GL_top_rail"];
	OPEX_friendly_MGriflesLight = ["CUP_arifle_RPK74M","CUP_arifle_RPK74M_top_rail","CUP_arifle_RPK74M_railed"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_Pecheneg","CUP_lmg_Pecheneg","CUP_lmg_Pecheneg","CUP_lmg_PKM"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_arifle_SR3M_Vikhr","CUP_arifle_SR3M_Vikhr_VFG","CUP_arifle_SR3M_Vikhr_top_rail","CUP_arifle_SR3M_Vikhr_VFG_top_rail","CUP_arifle_AK102_railed","CUP_arifle_AKS74U","CUP_arifle_AKS74U_top_rail","CUP_arifle_AKS74U_railed"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_VSSVintorez","CUP_srifle_VSSVintorez_top_rail","CUP_srifle_SVD","CUP_srifle_SVD_top_rail"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_ksvk"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_RPG7V","CUP_launch_Metis"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_9K32Strela_Loaded"];
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
	OPEX_friendly_handGrenades = ["CUP_HandGrenade_RGO"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_O_RUS_BeigeDigital_MSV","CUP_U_O_RUS_BeigeDigital_MSV","CUP_U_O_RUS_BeigeDigital_MSV","CUP_U_O_RUS_BeigeDigital_MSV_rolled_up"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_O_RUS_EMR_gloves_pads","CUP_U_O_RUS_EMR_gloves_pads","CUP_U_O_RUS_EMR_gloves_pads","CUP_U_O_RUS_EMR_2","CUP_U_O_RUS_EMR_rolled_up_gloves_pads"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_O_RUS_BeigeDigital_MSV_rolled_up","CUP_U_O_RUS_BeigeDigital_MSV_gloves_pads","CUP_U_O_RUS_BeigeDigital_MSV_rolled_up_gloves_pads"];
	OPEX_friendly_specialUniforms_snow = [];
	OPEX_friendly_ghillieUniforms_woodland = ["CUP_U_O_RUS_Ghillie"];
	OPEX_friendly_ghillieUniforms_desert = ["CUP_U_O_RUS_Ghillie"];
	OPEX_friendly_ghillieUniforms_snow = ["CUP_U_O_RUS_Ghillie"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_CRYE_BLK_RUS_Full"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_CRYE_BLK_RUS_Full","CUP_U_CRYE_BLK_RUS_Roll"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_CRYE_BLK_RUS_Full","CUP_U_CRYE_BLK_RUS_Roll"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_CRYE_BLK_RUS_Full","CUP_U_CRYE_BLK_RUS_Roll"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_O_RUS_BeigeDigital_MSV"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_O_RUS_BeigeDigital_MSV"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_O_RUS_EMR_1"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_O_RUS_EMR_2"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_O_RUS_BeigeDigital_MSV_rolled_up"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_O_RUS_EMR_2"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_RUS_6B45_1","CUP_V_RUS_6B45_2","CUP_V_RUS_6B45_3","CUP_V_B_RRV_Light"];
	OPEX_friendly_commonVests_desert = ["CUP_V_RUS_6B45_1_BeigeDigital","CUP_V_RUS_6B45_2_BeigeDigital","CUP_V_RUS_6B45_3_BeigeDigital","CUP_V_PMC_CIRAS_Coyote_Empty"];
	OPEX_friendly_commonVests_snow = ["CUP_V_RUS_6B45_1","CUP_V_RUS_6B45_2","CUP_V_RUS_6B45_3","CUP_V_B_RRV_Light","CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_specialVests_woodland = ["CUP_V_B_Delta_1","CUP_V_B_Delta_2","CUP_V_B_RRV_Officer","CUP_V_B_RRV_Scout","CUP_V_B_RRV_TL"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_RRV_MG","CUP_V_B_RRV_Scout3","CUP_V_CZ_NPP2006_nk_des","CUP_V_PMC_CIRAS_Coyote_Veh","CUP_V_PMC_CIRAS_Coyote_Patrol","CUP_V_PMC_CIRAS_Coyote_TL"];
	OPEX_friendly_specialVests_snow = ["CUP_V_B_Delta_1","CUP_V_B_Delta_2","CUP_V_B_RRV_Officer","CUP_V_B_RRV_Scout","CUP_V_B_RRV_TL","CUP_V_PMC_CIRAS_Winter_Veh","CUP_V_PMC_CIRAS_Winter_Patrol","CUP_V_PMC_CIRAS_Winter_TL"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_B_RRV_Medic","CUP_V_B_Ciras_Olive"];
	OPEX_friendly_medicVests_desert = ["CUP_V_CZ_NPP2006_nk_des","CUP_V_B_Ciras_Khaki","CUP_V_B_Ciras_MCam"];
	OPEX_friendly_medicVests_snow = ["CUP_V_B_RRV_Medic","CUP_V_B_Ciras_Olive"];
	OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_oli"];
	OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr"];
	OPEX_friendly_shoulderVests_snow = ["V_BandollierB_oli"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_RRV_Light"];
	OPEX_friendly_lightVests_desert = ["CUP_V_PMC_CIRAS_Coyote_Empty"];
	OPEX_friendly_lightVests_snow = ["CUP_V_B_RRV_Light","CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_grenadierVests_woodland = ["V_HarnessOGL_brn","CUP_V_B_RRV_Scout2"];
	OPEX_friendly_grenadierVests_desert = ["V_HarnessOGL_brn","CUP_V_PMC_CIRAS_Coyote_Grenadier"];
	OPEX_friendly_grenadierVests_snow = ["V_HarnessOGL_brn","CUP_V_B_RRV_Scout2","CUP_V_PMC_CIRAS_Winter_Grenadier"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_B_PASGT_OD"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_PASGT_OD"];
	OPEX_friendly_EODvests_snow = ["CUP_V_B_PASGT_winter"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_RUS_6B27_cover","CUP_H_RUS_6B27_cover","CUP_H_RUS_6B27_cover","CUP_H_RUS_6B46","CUP_H_RUS_6B46","CUP_H_RUS_6B27_cover_headset_goggles","CUP_H_RUS_6B27_cover_headset"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_RUS_6B27_cover_BeigeDigital","CUP_H_RUS_6B27_cover_BeigeDigital","CUP_H_RUS_6B27_cover_BeigeDigital","CUP_H_RUS_6B27_cover_BeigeDigital_goggles","CUP_H_RUS_6B27_cover_BeigeDigital_goggles","CUP_H_RUS_6B27_cover_BeigeDigital_headset_goggles","CUP_H_RUS_6B27_cover_BeigeDigital_headset"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_NVG_winter"];
	OPEX_friendly_specialHelmets_woodland = ["CUP_H_RUS_6B47_SF_headset_goggles_black","CUP_H_RUS_6B47_SF_headset_black","CUP_H_RUS_6B27","CUP_H_RUS_6B27_goggles","CUP_H_RUS_6B27_headset_goggles","CUP_H_RUS_6B27_headset","CUP_H_RUS_6B27_NVG","CUP_H_RUS_6B47_SF","CUP_H_RUS_6B47_SF_headset","CUP_H_OpsCore_Green","CUP_H_OpsCore_Green_SF","H_HelmetSpecB"];
	OPEX_friendly_specialHelmets_desert = ["CUP_H_RUS_6B47_SF_headset_goggles_black","CUP_H_RUS_6B47_SF_headset_black","CUP_H_RUS_6B47_desert","CUP_H_RUS_6B47_goggles_desert","CUP_H_RUS_6B47_headset_goggles_desert","CUP_H_RUS_6B47_headset_desert","CUP_H_RUS_6B47_SF_headset_goggles_desert","CUP_H_RUS_6B47_SF_headset_desert","CUP_H_OpsCore_Tan","CUP_H_OpsCore_Tan_SF","H_HelmetSpecB_sand"];
	OPEX_friendly_specialHelmets_snow = [];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_K6_3_Shield_Up"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_K6_3_Shield_Up_black"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_K6_3_Shield_Up"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_USMC_ACVC_WDL"];
	OPEX_friendly_aircraftPilotHelmets = ["CUP_H_RUS_ZSH_Shield_Down"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_RUS_TSH_4_Brown"];
	OPEX_friendly_cameraHelmets_woodland append ["CUP_H_RUS_6B47_SF_headset_goggles_black","CUP_H_RUS_6B47_SF_headset_black","CUP_H_RUS_6B47_SF","CUP_H_RUS_6B47_SF_headset","CUP_H_OpsCore_Green_SF","H_HelmetSpecB"];
	OPEX_friendly_cameraHelmets_desert append ["CUP_H_RUS_6B47_SF_headset_goggles_black","CUP_H_RUS_6B47_SF_headset_black","CUP_H_RUS_6B47_SF_headset_goggles_desert","CUP_H_RUS_6B47_SF_headset_desert","CUP_H_OpsCore_Tan_SF","H_HelmetSpecB_sand"];
	OPEX_friendly_cameraHelmets_snow append ["CUP_H_RUS_6B47_SF_headset_goggles_black","CUP_H_RUS_6B47_SF_headset_black","CUP_H_RUS_6B47_SF","CUP_H_RUS_6B47_SF_headset","CUP_H_OpsCore_Green_SF"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["H_Booniehat_oli"];
	OPEX_friendly_hats_desert = ["H_Booniehat_tan"];
	OPEX_friendly_hats_snow = [];
	OPEX_friendly_beanies_woodland = ["H_Watchcap_khk","CUP_H_PMC_Beanie_Black","CUP_H_SLA_BeanieGreen","CUP_H_SLA_BeanieGreen","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Khaki","CUP_H_FR_BeanieGreen"];
	OPEX_friendly_beanies_desert = ["H_Watchcap_cbr","CUP_H_PMC_Beanie_Black","CUP_H_C_Beanie_02","CUP_H_C_Beanie_02","CUP_H_PMC_Beanie_Headphones_Black"];
	OPEX_friendly_beanies_snow = ["CUP_H_PMC_Beanie_Winter","CUP_H_PMC_Beanie_Headphones_Winter"];
	OPEX_friendly_leaderHeadgear_woodland = ["CUP_H_RUS_Beret_Spetsnaz","CUP_H_US_patrol_cap_OD","CUP_H_C_Ushanka_03"];
	OPEX_friendly_leaderHeadgear_desert = ["CUP_H_RUS_Beret_Spetsnaz"];
	OPEX_friendly_leaderHeadgear_snow = ["CUP_H_RUS_Beret_Spetsnaz","CUP_H_US_patrol_cap_winter","CUP_H_C_Ushanka_03"];
	OPEX_friendly_berets = ["CUP_H_RUS_Beret_Spetsnaz","CUP_H_RUS_Beret_VDV"];
	OPEX_friendly_caps append ["CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_bandanas = ["CUP_H_FR_BandanaGreen","CUP_H_RUS_Bandana_HS"];
	OPEX_friendly_shemags = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
	OPEX_friendly_headsets append ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset","CUP_H_PMC_PRR_Headset","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_FR_Cap_Headset_Green"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["B_TacticalPack_blk","B_TacticalPack_oli","B_TacticalPack_oli","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_blk","B_Kitbag_sgg","B_Kitbag_rgr","CUP_B_HikingPack_Civ","CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","CUP_B_RUS_Backpack"];
	OPEX_friendly_mediumBackpacks_desert = ["B_AssaultPack_cbr","B_AssaultPack_cbr","B_AssaultPack_blk","B_Kitbag_tan","CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_RUS_Backpack"];
	OPEX_friendly_mediumBackpacks_snow = ["B_TacticalPack_blk","B_TacticalPack_oli","B_TacticalPack_oli","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_blk","B_Kitbag_sgg","B_Kitbag_rgr","CUP_B_HikingPack_Civ","CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","CUP_B_RUS_Backpack"];
	OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_oli","CUP_B_USPack_Black"];
	OPEX_friendly_bigBackpacks_desert = ["CUP_B_USPack_Coyote","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow = ["B_Carryall_oli","CUP_B_USPack_Black"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];