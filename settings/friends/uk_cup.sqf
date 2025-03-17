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
	OPEX_friendly_transportTrucksOpened_woodland = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_transportTrucksOpened_desert = ["CUP_B_LR_Transport_GB_D"];
	OPEX_friendly_transportTrucksOpened_snow = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_transportTrucksCovered_woodland = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_transportTrucksCovered_desert = ["CUP_B_LR_Transport_GB_D"];
	OPEX_friendly_transportTrucksCovered_snow = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_medicalTrucks_woodland = ["CUP_B_LR_Ambulance_GB_W","CUP_B_FV432_GB_Ambulance"];
	OPEX_friendly_medicalTrucks_desert = ["CUP_B_LR_Ambulance_GB_D","CUP_B_FV432_GB_Ambulance"];
	OPEX_friendly_medicalTrucks_snow = ["CUP_B_LR_Ambulance_GB_W","CUP_B_FV432_GB_Ambulance"];
	OPEX_friendly_transportCars_woodland = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_transportCars_desert = ["CUP_B_LR_Transport_GB_D"];
	OPEX_friendly_transportCars_snow = ["CUP_B_LR_Transport_GB_W"];
	OPEX_friendly_combatCarsMG_woodland = ["CUP_B_LR_Special_M2_GB_W","CUP_B_LR_MG_GB_W"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_B_LR_MG_GB_D","CUP_B_LR_Special_M2_GB_D"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_B_LR_Special_M2_GB_W","CUP_B_LR_MG_GB_W"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_B_LR_Special_GMG_GB_W"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_B_LR_Special_GMG_GB_D"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_B_LR_Special_GMG_GB_W"];
	OPEX_friendly_vtt_woodland = ["CUP_B_BAF_Coyote_GMG_W","CUP_B_BAF_Coyote_L2A1_W","CUP_B_Jackal2_GMG_GB_W","CUP_B_Jackal2_L2A1_GB_W","CUP_B_Mastiff_GMG_GB_W","CUP_B_Mastiff_HMG_GB_W","CUP_B_Mastiff_LMG_GB_W","CUP_B_Ridgback_GMG_GB_W","CUP_B_Ridgback_HMG_GB_W","CUP_B_Ridgback_LMG_GB_W","CUP_B_Wolfhound_GMG_GB_W","CUP_B_Wolfhound_HMG_GB_W","CUP_B_Wolfhound_LMG_GB_W"];
	OPEX_friendly_vtt_desert = ["CUP_B_BAF_Coyote_GMG_D","CUP_B_BAF_Coyote_L2A1_D","CUP_B_Jackal2_GMG_GB_D","CUP_B_Jackal2_L2A1_GB_D","CUP_B_Mastiff_GMG_GB_D","CUP_B_Mastiff_HMG_GB_D","CUP_B_Mastiff_LMG_GB_D","CUP_B_Ridgback_GMG_GB_D","CUP_B_Ridgback_HMG_GB_D","CUP_B_Ridgback_LMG_GB_D","CUP_B_Wolfhound_GMG_GB_D","CUP_B_Wolfhound_HMG_GB_D","CUP_B_Wolfhound_LMG_GB_D"];
	OPEX_friendly_vtt_snow = ["CUP_B_BAF_Coyote_GMG_W","CUP_B_BAF_Coyote_L2A1_W","CUP_B_Jackal2_GMG_GB_W","CUP_B_Jackal2_L2A1_GB_W","CUP_B_Mastiff_GMG_GB_W","CUP_B_Mastiff_HMG_GB_W","CUP_B_Mastiff_LMG_GB_W","CUP_B_Ridgback_GMG_GB_W","CUP_B_Ridgback_HMG_GB_W","CUP_B_Ridgback_LMG_GB_W","CUP_B_Wolfhound_GMG_GB_W","CUP_B_Wolfhound_HMG_GB_W","CUP_B_Wolfhound_LMG_GB_W"];
	OPEX_friendly_tanks_woodland = ["CUP_B_Challenger2_Woodland_BAF","CUP_B_FV432_Bulldog_GB_W_RWS","CUP_B_FV432_Bulldog_GB_W","CUP_B_FV510_GB_W","CUP_B_MCV80_GB_W_SLAT","CUP_B_MCV80_GB_W","CUP_B_Challenger2_2CW_BAF"];
	OPEX_friendly_tanks_desert = ["CUP_B_FV432_Bulldog_GB_D_RWS","CUP_B_FV432_Bulldog_GB_D","CUP_B_FV510_GB_D","CUP_B_FV510_GB_D_SLAT","CUP_B_MCV80_GB_D","CUP_B_MCV80_GB_D_SLAT","CUP_B_Challenger2_Desert_BAF"];
	OPEX_friendly_tanks_snow = ["CUP_B_Challenger2_Snow_BAF","CUP_B_Challenger2_2CS_BAF","CUP_B_FV432_Bulldog_GB_W_RWS","CUP_B_FV432_Bulldog_GB_W","CUP_B_FV510_GB_W","CUP_B_MCV80_GB_W_SLAT","CUP_B_MCV80_GB_W"];
	OPEX_friendly_ships = ["CUP_B_MK10_GB"];
	OPEX_friendly_aircrafts = ["CUP_B_F35B_BAF","CUP_B_F35B_Stealth_BAF","CUP_B_GR9_DYN_GB"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_B_AH1_DL_BAF"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_B_AH1_DL_BAF"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_B_AH1_DL_BAF"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_B_AW159_GB"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_B_AW159_GB"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_B_AW159_GB"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_B_SA330_Puma_HC1_BAF","CUP_B_SA330_Puma_HC2_BAF","CUP_B_AW159_Unarmed_GB"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_B_Merlin_HC4_GB","CUP_B_Merlin_HC3A_Armed_GB","CUP_B_Merlin_HC3_Armed_GB","CUP_B_Merlin_HC3_GB","CUP_B_MH47E_GB","CUP_B_CH47F_GB"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_B_Merlin_HC4_GB","CUP_B_Merlin_HC3A_Armed_GB","CUP_B_Merlin_HC3_Armed_GB","CUP_B_Merlin_HC3_GB","CUP_B_MH47E_GB","CUP_B_CH47F_GB"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_B_Merlin_HC4_GB","CUP_B_Merlin_HC3A_Armed_GB","CUP_B_Merlin_HC3_Armed_GB","CUP_B_Merlin_HC3_GB","CUP_B_MH47E_GB","CUP_B_CH47F_GB"];
	OPEX_friendly_MGstatics = ["CUP_B_L111A1_BAF_DDPM"];
	OPEX_friendly_mortarStatics = ["CUP_B_L16A2_BAF_DDPM"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Glock17_blk"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Glock17_blk","CUP_hgun_Mk23","CUP_hgun_M9"];
	OPEX_friendly_commonRifles = ["CUP_arifle_L85A2","CUP_arifle_L85A2_NG"];
	OPEX_friendly_specialRifles = ["CUP_arifle_L85A2_G","CUP_arifle_L86A2"];
	OPEX_friendly_GLrifles = ["CUP_arifle_L85A2_GL"];
	OPEX_friendly_MGriflesLight = ["CUP_lmg_minimipara"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_L7A2"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_MP5SD6"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_L129A1","CUP_srifle_L129A1_HG"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_AWM_wdl","CUP_srifle_AWM_des","CUP_srifle_AS50"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_M136","CUP_launch_M136","CUP_launch_NLAW","CUP_launch_Javelin"];
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
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONG","CUP_U_B_BAF_MTP_UBACSLONGKNEE"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONG","CUP_U_B_BAF_DDPM_UBACSLONGKNEE"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONG","CUP_U_B_BAF_MTP_UBACSLONGKNEE"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSROLLED","CUP_U_B_BAF_MTP_UBACSROLLEDKNEE"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSROLLED","CUP_U_B_BAF_DDPM_UBACSROLLEDKNEE"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSROLLED","CUP_U_B_BAF_MTP_UBACSROLLEDKNEE"];
	OPEX_friendly_ghillieUniforms_woodland = ["CUP_U_B_BAF_MTP_GHILLIE"];
	OPEX_friendly_ghillieUniforms_desert = ["CUP_U_B_BAF_DDPM_GHILLIE"];
	OPEX_friendly_ghillieUniforms_snow = ["CUP_U_B_BAF_MTP_GHILLIE"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONG"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONG"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONG"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONGKNEE"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONGKNEE"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONGKNEE"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSLONG"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSLONG"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_B_BAF_MTP_UBACSTSHIRT","CUP_U_B_BAF_MTP_UBACSTSHIRTKNEE"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_BAF_DDPM_UBACSTSHIRT","CUP_U_B_BAF_DDPM_UBACSTSHIRTKNEE"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_B_BAF_MTP_UBACSROLLED","CUP_U_B_BAF_MTP_UBACSROLLEDKNEE"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Empty","CUP_V_B_BAF_MTP_Osprey_Mk4_Rifleman"];
	OPEX_friendly_commonVests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","CUP_V_B_BAF_DDPM_Osprey_Mk3_Rifleman"];
	OPEX_friendly_commonVests_snow = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","CUP_V_B_BAF_DDPM_Osprey_Mk3_Rifleman"];
	OPEX_friendly_specialVests_woodland = ["V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","CUP_V_B_BAF_MTP_Osprey_Mk4_AutomaticRifleman","CUP_V_B_BAF_MTP_Osprey_Mk4_Crewman","CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer","CUP_V_B_BAF_MTP_Osprey_Mk4_Scout"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_AutomaticRifleman","CUP_V_B_BAF_DDPM_Osprey_Mk3_Crewman","CUP_V_B_BAF_DDPM_Osprey_Mk3_Engineer","CUP_V_B_BAF_DDPM_Osprey_Mk3_Officer","CUP_V_B_BAF_DDPM_Osprey_Mk3_Scout"];
	OPEX_friendly_specialVests_snow = ["V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","CUP_V_B_BAF_MTP_Osprey_Mk4_AutomaticRifleman","CUP_V_B_BAF_MTP_Osprey_Mk4_Crewman","CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer","CUP_V_B_BAF_MTP_Osprey_Mk4_Scout"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Medic","CUP_V_B_BAF_MTP_Osprey_Mk4_Medic","CUP_V_B_Ciras_Khaki"];
	OPEX_friendly_medicVests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Medic"];
	OPEX_friendly_medicVests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Medic","CUP_V_B_BAF_MTP_Osprey_Mk4_Medic","CUP_V_B_Ciras_Khaki"];
	OPEX_friendly_beltVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Belt"];
	OPEX_friendly_beltVests_desert = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Belt"];
	OPEX_friendly_beltVests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Belt"];
	OPEX_friendly_shoulderVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing"];
	OPEX_friendly_shoulderVests_desert = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing"];
	OPEX_friendly_shoulderVests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Empty"];
	OPEX_friendly_lightVests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","CUP_V_B_BAF_DDPM_Osprey_Mk3_Pilot"];
	OPEX_friendly_lightVests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Empty"];
	OPEX_friendly_grenadierVests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Grenadier","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer"];
	OPEX_friendly_grenadierVests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Grenadier"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Grenadier","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Engineer"];
	OPEX_friendly_EODvests_snow = ["CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_BAF_MTP_Mk7","CUP_H_BAF_MTP_Mk7_PRR","CUP_H_BAF_MTP_Mk6_CREW_PRR","CUP_H_BAF_MTP_Mk6_GLASS_PRR","CUP_H_BAF_MTP_Mk6_GOGGLES_PRR","CUP_H_BAF_MTP_Mk6_NETTING_PRR"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_BAF_DDPM_Mk6_EMPTY","CUP_H_BAF_DDPM_Mk6_EMPTY_PRR","CUP_H_BAF_DDPM_Mk6_CREW_PRR","CUP_H_BAF_DDPM_Mk6_GLASS_PRR","CUP_H_BAF_DDPM_Mk6_GOGGLES_PRR","CUP_H_BAF_DDPM_Mk6_NETTING_PRR"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_BAF_MTP_Mk7","CUP_H_BAF_MTP_Mk7_PRR","CUP_H_BAF_MTP_Mk6_CREW_PRR","CUP_H_BAF_MTP_Mk6_GLASS_PRR","CUP_H_BAF_MTP_Mk6_GOGGLES_PRR","CUP_H_BAF_MTP_Mk6_NETTING_PRR"];
	OPEX_friendly_specialHelmets_woodland append ["CUP_H_BAF_MTP_Mk7_PRR_SCRIM_A","CUP_H_BAF_MTP_Mk7_PRR_SCRIM_B","CUP_H_OpsCore_Black","CUP_H_OpsCore_Grey","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Tan","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Grey_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Tan_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_specialHelmets_desert append ["CUP_H_BAF_MTP_Mk7_PRR_SCRIM_A","CUP_H_BAF_MTP_Mk7_PRR_SCRIM_B","CUP_H_OpsCore_Black","CUP_H_OpsCore_Grey","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Tan","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Grey_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Tan_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_specialHelmets_snow append ["CUP_H_BAF_MTP_Mk7_PRR_SCRIM_A","CUP_H_BAF_MTP_Mk7_PRR_SCRIM_B","CUP_H_OpsCore_Black","CUP_H_OpsCore_Grey","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Spray","CUP_H_OpsCore_Tan","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_NoHS","CUP_H_OpsCore_Grey_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Tan_NoHS","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_Altyn_Shield_Up_khaki"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_Altyn_Shield_Up_black"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_Altyn_Shield_Up_khaki"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_BAF_PILOT"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_BAF_PILOT"];
	OPEX_friendly_cameraHelmets_woodland append ["CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Green_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_cameraHelmets_desert append ["CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Green_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_cameraHelmets_snow append ["CUP_H_OpsCore_Covered_MCAM_SF","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Green_SF","CUP_H_OpsCore_Grey_SF","CUP_H_OpsCore_Spray_SF","CUP_H_OpsCore_Tan_SF"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["H_Booniehat_mcamo"];
	OPEX_friendly_hats_desert = ["H_Booniehat_khk","H_Booniehat_tan"];
	OPEX_friendly_hats_snow = ["H_Booniehat_mcamo"];
	OPEX_friendly_beanies_woodland = ["CUP_H_SLA_BeanieGreen","CUP_H_PMC_Beanie_Khaki","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_FR_BeanieGreen"];
	OPEX_friendly_beanies_desert = ["CUP_H_CZ_Pakol_headset_f_brown","CUP_H_CZ_Pakol_headset_b_grey"];
	OPEX_friendly_beanies_snow = ["CUP_H_PMC_Beanie_Winter","CUP_H_PMC_Beanie_Headphones_Winter","CUP_H_FR_BeanieGreen"];
	OPEX_friendly_leaderHeadgear_woodland = ["CUP_H_BAF_PARA_BERET","CUP_H_BAF_PARA_PRROVER_BERET","CUP_H_BAF_PARA_PRRUNDER_BERET"];
	OPEX_friendly_leaderHeadgear_desert = ["CUP_H_BAF_PARA_BERET","CUP_H_BAF_PARA_PRROVER_BERET","CUP_H_BAF_PARA_PRRUNDER_BERET"];
	OPEX_friendly_leaderHeadgear_snow = ["CUP_H_BAF_PARA_BERET","CUP_H_BAF_PARA_PRROVER_BERET","CUP_H_BAF_PARA_PRRUNDER_BERET"];
	OPEX_friendly_berets = ["CUP_H_BAF_PARA_BERET"];
	OPEX_friendly_caps = ["H_Cap_khaki_specops_UK","H_Cap_khaki_specops_UK","H_Cap_khaki_specops_UK","CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_CZ_Hat04","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_PMC_Cap_Back_PRR_Grey","CUP_H_PMC_Cap_Back_PRR_Tan","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_bandanas = ["CUP_H_FR_BandanaGreen","CUP_H_RUS_Bandana_HS"];
	OPEX_friendly_shemags = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
	OPEX_friendly_headsets append ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset","CUP_H_PMC_PRR_Headset"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland append ["CUP_B_Kombat_Olive","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Bergen_BAF","CUP_B_AssaultPack_Coyote","CUP_B_USPack_Coyote"];
	OPEX_friendly_mediumBackpacks_desert append ["CUP_B_Kombat_Olive","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Bergen_BAF","CUP_B_AssaultPack_Coyote","CUP_B_USPack_Coyote"];
	OPEX_friendly_mediumBackpacks_snow append ["CUP_B_Kombat_Olive","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Motherlode_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Predator_MTP","CUP_B_Bergen_BAF","CUP_B_AssaultPack_Coyote","CUP_B_USPack_Coyote"];
	OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_cbr","B_Carryall_khk"];
	OPEX_friendly_bigBackpacks_desert = ["B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_cbr","B_Carryall_khk"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_Predator_MTP"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_GER_Medic_Desert"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_Predator_MTP"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP","CUP_B_Predator_Radio_MTP"];