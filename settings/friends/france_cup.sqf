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
	OPEX_friendly_insigna = "France"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

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
	OPEX_friendly_transportTrucksOpened_woodland = ["B_T_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksOpened_desert = ["B_T_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksOpened_snow = ["B_T_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksCovered_woodland = ["B_T_Truck_01_transport_F"];
	OPEX_friendly_transportTrucksCovered_desert = ["B_T_Truck_01_transport_F"];
	OPEX_friendly_transportTrucksCovered_snow = ["B_T_Truck_01_transport_F"];
	OPEX_friendly_fuelTrucks_woodland = ["B_T_Truck_01_fuel_F"];
	OPEX_friendly_fuelTrucks_desert = ["B_T_Truck_01_fuel_F"];
	OPEX_friendly_fuelTrucks_snow = ["B_T_Truck_01_fuel_F"];
	OPEX_friendly_logisticTrucks_woodland = ["B_T_Truck_01_box_F"];
	OPEX_friendly_logisticTrucks_desert = ["B_T_Truck_01_box_F"];
	OPEX_friendly_logisticTrucks_snow = ["B_T_Truck_01_box_F"];
	OPEX_friendly_medicalTrucks_woodland = ["B_T_Truck_01_medical_F"];
	OPEX_friendly_medicalTrucks_desert = ["B_T_Truck_01_medical_F"];
	OPEX_friendly_medicalTrucks_snow = ["B_T_Truck_01_medical_F"];
	OPEX_friendly_repairTrucks_woodland = ["B_T_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_desert = ["B_T_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_snow = ["B_T_Truck_01_Repair_F"];
	OPEX_friendly_ammoTrucks_woodland = ["B_T_Truck_01_ammo_F"];
	OPEX_friendly_ammoTrucks_desert = ["B_T_Truck_01_ammo_F"];
	OPEX_friendly_ammoTrucks_snow = ["B_T_Truck_01_ammo_F"];
	OPEX_friendly_transportCars_woodland = ["B_T_MRAP_01_F"];
	OPEX_friendly_transportCars_desert = ["B_MRAP_01_F"];
	OPEX_friendly_transportCars_snow = ["B_T_MRAP_01_F"];
	OPEX_friendly_combatCarsMG_woodland = ["B_T_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsMG_desert = ["B_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsMG_snow = ["B_T_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsGL_woodland = ["B_T_MRAP_01_gmg_F"];
	OPEX_friendly_combatCarsGL_desert = ["B_MRAP_01_gmg_F"];
	OPEX_friendly_combatCarsGL_snow = ["B_T_MRAP_01_gmg_F"];
	OPEX_friendly_vtt_woodland = ["B_T_APC_Wheeled_01_cannon_F"];
	OPEX_friendly_vtt_desert = ["B_APC_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F"];
	OPEX_friendly_vtt_snow = ["B_T_APC_Wheeled_01_cannon_F"];
	OPEX_friendly_tanks_woodland = ["B_T_MBT_01_cannon_F", "B_T_MBT_01_TUSK_F"];
	OPEX_friendly_tanks_desert = ["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"];
	OPEX_friendly_tanks_snow = ["B_T_MBT_01_cannon_F", "B_T_MBT_01_TUSK_F"];
	OPEX_friendly_quads_woodland = ["B_T_Quadbike_01_F"];
	OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
	OPEX_friendly_quads_snow = ["B_T_Quadbike_01_F"];
	OPEX_friendly_zodiacs = ["B_T_Boat_Transport_01_F"];
	OPEX_friendly_ships = ["B_T_Boat_Armed_01_minigun_F"];
	OPEX_friendly_aircrafts = ["B_Plane_CAS_01_dynamicLoadout_F", "B_Plane_Fighter_01_F", "B_Plane_Fighter_01_Stealth_F"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["B_Heli_Light_01_dynamicLoadout_F"];
	OPEX_friendly_smallCombatHelicopters_desert = ["B_Heli_Light_01_dynamicLoadout_F"];
	OPEX_friendly_smallCombatHelicopters_snow = ["B_Heli_Light_01_dynamicLoadout_F"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["B_Heli_Attack_01_dynamicLoadout_F"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["B_Heli_Attack_01_dynamicLoadout_F"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["B_Heli_Attack_01_dynamicLoadout_F"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["B_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_desert = ["B_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_snow = ["B_Heli_Light_01_F"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["B_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["B_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["B_Heli_Transport_01_F"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_bigTransportHelicopters_desert = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_bigTransportHelicopters_snow = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_UAVs = ["B_UAV_02_dynamicLoadout_F"];
	OPEX_friendly_UGVs = ["B_T_UGV_01_olive_F", "B_T_UGV_01_rcws_olive_F"];
	OPEX_friendly_portableDrones = ["B_UAV_01_F"];
	OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
	OPEX_friendly_MGstatics = ["B_HMG_01_high_F"];
	OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
	OPEX_friendly_ATstatics = ["B_T_Static_AT_F"];
	OPEX_friendly_AAstatics = ["B_T_Static_AA_F"];
	OPEX_friendly_mortarStatics = ["B_T_Mortar_01_F"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_M9"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Glock17_blk","CUP_hgun_Mk23"];
	OPEX_friendly_commonRifles = ["CUP_Famas_F1","CUP_Famas_F1","CUP_Famas_F1","CUP_Famas_F1_Rail"];
	OPEX_friendly_specialRifles = ["CUP_Famas_F1_Rail","CUP_arifle_HK416_Black","CUP_arifle_HK417_12","CUP_arifle_HK417_20"];
	OPEX_friendly_GLrifles = ["CUP_arifle_HK416_M203_Black","CUP_arifle_HK416_CQB_M203_Black","CUP_arifle_HK416_AGL_Black","CUP_arifle_HK416_CQB_AG36","CUP_arifle_HK417_12_M203","CUP_arifle_HK417_12_AG36"];
	OPEX_friendly_MGriflesLight = ["CUP_lmg_minimipara","CUP_lmg_minimi","CUP_lmg_minimi_railed"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_L7A2"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_arifle_HK416_CQB_Black","CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_MP5SD6"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_M110_black"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_M107_Base"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_Javelin","CUP_launch_M136_Loaded","CUP_launch_M136_Loaded","CUP_launch_M136_Loaded","CUP_launch_NLAW_Loaded"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_FIM92Stinger_Loaded"];
	OPEX_friendly_shotguns = ["CUP_sgun_M1014","CUP_sgun_M1014_solidstock","CUP_sgun_M1014_Entry"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["CUP_optic_CompM4","CUP_optic_MicroT1","CUP_optic_MicroT1_low","CUP_optic_HoloBlack","CUP_optic_Eotech553_Black","CUP_optic_MARS","CUP_optic_MRad"];
	OPEX_friendly_distantCombatOptics append ["CUP_optic_AIMM_COMPM4_BLK","CUP_optic_AIMM_MICROT1_BLK","CUP_optic_Elcan_SpecterDR_black","CUP_optic_Elcan_SpecterDR_RMR_black","CUP_optic_Elcan","CUP_optic_Elcan_reflex","CUP_optic_G33_HWS_BLK","CUP_optic_HensoldtZO","CUP_optic_HensoldtZO_low","CUP_optic_HensoldtZO_low_RDS","CUP_optic_HensoldtZO_RDS","CUP_optic_LeupoldMk4_CQ_T","CUP_optic_CompM2_low","CUP_optic_AIMM_M68_BLK","CUP_optic_AIMM_COMPM2_BLK","CUP_optic_CompM2_Black","CUP_optic_AIMM_MARS_BLK","CUP_optic_ZDDot","CUP_optic_AIMM_ZDDOT_BLK","CUP_optic_ACOG_TA01B_Black","CUP_optic_ACOG_TA01B_RMR_Black","CUP_optic_RCO","CUP_optic_ACOG_TA01NSN_RMR_Black","CUP_optic_ACOG2","CUP_optic_ACOG_TA31_KF","CUP_optic_ACOG"];
	OPEX_friendly_sniperOptics append ["CUP_optic_AN_PAS_13c1","CUP_optic_AN_PVS_10_black","CUP_optic_CWS","CUP_optic_ElcanM145","CUP_optic_GOSHAWK_RIS","CUP_optic_LeupoldMk4","CUP_optic_LeupoldM3LR","CUP_optic_LeupoldMk4_20x40_LRT","CUP_optic_LeupoldMk4_25x50_LRT","CUP_optic_Leupold_VX3","CUP_optic_SB_11_4x20_PM","CUP_optic_SB_3_12x50_PMII"];
	OPEX_friendly_flashlights append ["CUP_acc_Flashlight","CUP_acc_Flashlight","CUP_acc_Flashlight","CUP_acc_XM8_light_module","CUP_acc_Glock17_Flashlight","CUP_acc_CZ_M3X"];
	OPEX_friendly_rifleSilencers append ["CUP_muzzle_mfsup_Flashhider_556x45_Black","CUP_muzzle_mfsup_SCAR_L","CUP_muzzle_snds_G36_black","CUP_muzzle_snds_M16","CUP_muzzle_snds_XM8","CUP_muzzle_snds_SCAR_L","CUP_muzzle_mfsup_Suppressor_M107_Black","CUP_muzzle_snds_M110_black","muzzle_snds_58_blk_F"];
	OPEX_friendly_handgunSilencers append ["CUP_muzzle_snds_M9","CUP_muzzle_snds_mk23"];
	OPEX_friendly_pointers append ["CUP_acc_ANPEQ_15_Black","CUP_acc_ANPEQ_15_Black_Top","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_acc_ANPEQ_15_Top_Flashlight_Black_L","CUP_acc_ANPEQ_2_grey","CUP_acc_ANPEQ_2_Black_Top","CUP_acc_ANPEQ_2_Flashlight_Black_L","CUP_acc_LLM_black","CUP_acc_mk23_lam_f","CUP_acc_MLPLS_Laser","CUP_acc_LLM01_L"];
	OPEX_friendly_bipods append ["CUP_bipod_VLTOR_Modpod_black"];

	// VARIOUS ITEMS
	OPEX_friendly_NVGs append ["CUP_NVG_PVS14","CUP_NVG_PVS15_black","CUP_NVG_PVS7","CUP_NVG_HMNVS"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_B_BDUv2_CEU","CUP_U_B_BDUv2_CEU","CUP_U_B_BDUv2_CEU","CUP_U_B_BDUv2_dirty_CEU","CUP_U_B_BDUv2_roll_CEU","CUP_U_B_BDUv2_roll_CEU","CUP_U_B_BDUv2_roll_dirty_CEU"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_BDUv2_DCU","CUP_U_B_BDUv2_DCU","CUP_U_B_BDUv2_DCU","CUP_U_B_BDUv2_DCU","CUP_U_B_BDUv2_DCU","CUP_U_B_BDUv2_dirty_DCU","CUP_U_B_BDUv2_roll2_DCU","CUP_U_B_BDUv2_roll2_DCU","CUP_U_B_BDUv2_roll2_dirty_DCU","CUP_U_B_BDUv2_roll_DCU","CUP_U_B_BDUv2_roll_DCU","CUP_U_B_BDUv2_roll_DCU","CUP_U_B_BDUv2_roll_dirty_DCU"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_dirty_Winter","CUP_U_B_BDUv2_gloves_dirty_Winter"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_B_BDUv2_roll2_CEU","CUP_U_B_BDUv2_roll2_CEU","CUP_U_B_BDUv2_roll2_CEU","CUP_U_B_BDUv2_roll2_gloves_CEU","CUP_U_B_BDUv2_roll2_gloves_dirty_CEU","CUP_U_B_BDUv2_roll_gloves_CEU","CUP_U_B_BDUv2_roll_gloves_CEU","CUP_U_B_BDUv2_roll_gloves_dirty_CEU"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_BDUv2_gloves_DCU","CUP_U_B_BDUv2_gloves_DCU","CUP_U_B_BDUv2_gloves_dirty_DCU","CUP_U_B_BDUv2_roll2_gloves_DCU","CUP_U_B_BDUv2_roll2_gloves_DCU","CUP_U_B_BDUv2_roll2_gloves_DCU","CUP_U_B_BDUv2_roll2_gloves_dirty_DCU","CUP_U_B_BDUv2_roll_gloves_DCU","CUP_U_B_BDUv2_roll_gloves_DCU","CUP_U_B_BDUv2_roll_gloves_DCU","CUP_U_B_BDUv2_roll_gloves_dirty_DCU"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_gloves_Winter","CUP_U_B_BDUv2_dirty_Winter","CUP_U_B_BDUv2_gloves_dirty_Winter"];
	OPEX_friendly_ghillieUniforms_woodland = ["CUP_U_B_BAF_MTP_GHILLIE","CUP_U_B_BAF_DPM_GHILLIE","CUP_U_B_BAF_DPM_GHILLIE"];
	OPEX_friendly_ghillieUniforms_desert = ["CUP_U_B_BAF_MTP_GHILLIE","CUP_U_B_BAF_DDPM_GHILLIE","CUP_U_B_CZ_DST_Ghillie"];
	OPEX_friendly_ghillieUniforms_snow = ["CUP_U_B_BAF_MTP_GHILLIE","CUP_U_B_BAF_DDPM_GHILLIE","CUP_U_B_CZ_DST_Ghillie"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_BDUv2_OD"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_B_BDUv2_CEU"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_BDUv2_DCU"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_B_BDUv2_Winter"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_B_BDUv2_CEU"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_BDUv2_DCU"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_B_BDUv2_gloves_Winter"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_B_BDUv2_CEU"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_BDUv2_DCU"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_B_BDUv2_Winter"];
	OPEX_friendly_tshirtUniforms_woodland = ["CUP_U_B_BDUv2_roll2_dirty_CEU"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_BDUv2_roll2_DCU"];
	OPEX_friendly_tshirtUniforms_snow = ["CUP_U_B_BDUv2_roll2_dirty_CEU"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["V_I_G_resistanceLeader_F","V_I_G_resistanceLeader_F","V_I_G_resistanceLeader_F","CUP_V_B_Interceptor_Rifleman_M81"];
	OPEX_friendly_commonVests_desert = ["CUP_V_PMC_CIRAS_Coyote_Veh","CUP_V_PMC_CIRAS_Coyote_Empty","CUP_V_MBSS_PACA_CB"];
	OPEX_friendly_commonVests_snow = ["CUP_V_PMC_CIRAS_Winter_Veh","CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_specialVests_woodland = ["CUP_V_B_Armatus_BB_Black","CUP_V_B_Armatus_BB_OD","CUP_V_PMC_CIRAS_Black_Veh","CUP_V_PMC_CIRAS_Black_Patrol","CUP_V_PMC_CIRAS_Black_TL","CUP_V_PMC_IOTV_Black_AR","CUP_V_PMC_IOTV_Black_Patrol","CUP_V_PMC_IOTV_Black_TL"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_Armatus_BB_Black","CUP_V_PMC_CIRAS_Black_Veh","CUP_V_PMC_CIRAS_Coyote_Patrol","CUP_V_PMC_CIRAS_Coyote_TL","CUP_V_PMC_IOTV_Coyote_AR","CUP_V_PMC_IOTV_Coyote_Patrol","CUP_V_PMC_IOTV_Coyote_TL"];
	OPEX_friendly_specialVests_snow = ["CUP_V_B_Armatus_BB_Black","CUP_V_B_Armatus_BB_OD","CUP_V_PMC_CIRAS_Black_Veh","CUP_V_PMC_CIRAS_Winter_Patrol","CUP_V_PMC_CIRAS_Black_Patrol","CUP_V_PMC_CIRAS_Winter_TL","CUP_V_PMC_IOTV_Black_Patrol","CUP_V_PMC_IOTV_Black_TL"];
	OPEX_friendly_medicVests_woodland = ["V_TacVestIR_blk","CUP_V_B_Ciras_Black","CUP_V_B_Ciras_Olive"];
	OPEX_friendly_medicVests_desert = ["V_TacVestIR_blk","CUP_V_B_Ciras_Black"];
	OPEX_friendly_medicVests_snow = ["V_TacVestIR_blk","CUP_V_B_Ciras_Black"];
	OPEX_friendly_beltVests_woodland = ["V_Rangemaster_belt"];
	OPEX_friendly_beltVests_desert = ["V_Rangemaster_belt"];
	OPEX_friendly_beltVests_snow = ["V_Rangemaster_belt"];
	OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_rgr"];
	OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr"];
	OPEX_friendly_shoulderVests_snow = ["V_BandollierB_rgr"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_Interceptor_Base_M81"];
	OPEX_friendly_lightVests_desert = ["CUP_V_PMC_CIRAS_Coyote_Empty","CUP_V_PMC_IOTV_Coyote_Empty"];
	OPEX_friendly_lightVests_snow = ["CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_grenadierVests_woodland = ["CUP_U_B_BDUv2_CEU","CUP_V_B_Interceptor_Grenadier_M81"];
	OPEX_friendly_grenadierVests_desert = ["CUP_U_B_BDUv2_CEU","CUP_V_PMC_CIRAS_Coyote_Grenadier"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_PMC_CIRAS_Winter_Grenadier"];
	OPEX_friendly_EODvests_woodland = ["CUP_V_B_PASGT"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_PASGT_OD"];
	OPEX_friendly_EODvests_snow = ["CUP_V_B_PASGT_winter"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_PASGTv2_WDL","CUP_H_PASGTv2_WDL","CUP_H_PASGTv2_WDL","CUP_H_PASGTv2_WDL","CUP_H_PASGTv2_WDL","CUP_H_PASGTv2_NVG_WDL_CF","CUP_H_PASGTv2_NVG_WDL_GG_CB","CUP_H_PASGTv2_NVG_WDL_GG","CUP_H_PASGTv2_NVG_WDL"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_PASGTv2_DCU","CUP_H_PASGTv2_DCU","CUP_H_PASGTv2_DCU","CUP_H_PASGTv2_DCU","CUP_H_PASGTv2_DCU","CUP_H_PASGTv2_NVG_DCU"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_winter","CUP_H_PASGTv2_NVG_winter"];
	OPEX_friendly_specialHelmets_woodland = ["CUP_H_USArmy_HelmetMICH_headset_wdl","CUP_H_USArmy_HelmetMICH_earpro_wdl","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Black_SF","H_HelmetSpecB"];
	OPEX_friendly_specialHelmets_desert = ["CUP_H_USArmy_HelmetMICH_headset_DCU","CUP_H_USArmy_HelmetMICH_earpro_DCU","CUP_H_OpsCore_Tan_SF","CUP_H_OpsCore_Black_SF","H_HelmetB_black","H_HelmetSpecB_paint2","H_HelmetSpecB_blk"];
	OPEX_friendly_specialHelmets_snow = ["CUP_H_OpsCore_Black_SF","H_HelmetSpecB"];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_PMC_EP_Headset","CUP_H_CZ_Helmet05"];
	OPEX_friendly_aircraftPilotHelmets = ["H_PilotHelmetFighter_B"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_CZ_Helmet05"];
	OPEX_friendly_cameraHelmets_woodland = ["CUP_H_USArmy_HelmetMICH_earpro_wdl","CUP_H_USArmy_HelmetMICH_earpro_ess_wdl","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Spray_NoHS","H_HelmetSpecB"];
	OPEX_friendly_cameraHelmets_desert = ["CUP_H_USArmy_HelmetMICH_earpro_DCU","CUP_H_USArmy_HelmetMICH_earpro_ess_DCU","CUP_H_OpsCore_Black_SF","CUP_H_OpsCore_Tan_SF","H_HelmetSpecB_paint2","H_HelmetSpecB_blk"];
	OPEX_friendly_cameraHelmets_snow = ["CUP_H_OpsCore_Black_SF","H_HelmetSpecB"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["CUP_H_USA_Boonie_wdl","CUP_H_SLA_Boonie_DES","H_Booniehat_oli","H_Booniehat_khk_hs","CUP_H_FR_BoonieWDL"];
	OPEX_friendly_hats_desert = ["H_Booniehat_tan","H_Booniehat_khk_hs"];
	OPEX_friendly_hats_snow = ["H_Booniehat_mcamo"];
	OPEX_friendly_beanies_woodland = ["H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo"];
	OPEX_friendly_beanies_desert = ["H_Watchcap_blk","H_Watchcap_cbr"];
	OPEX_friendly_beanies_snow = ["H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo"];
	OPEX_friendly_leaderHeadgear_woodland = ["H_Beret_02","H_Beret_02","H_Beret_02","CUP_H_US_patrol_cap_WDL"];
	OPEX_friendly_leaderHeadgear_desert = ["H_Beret_02","H_Beret_02","H_Beret_02","CUP_H_US_patrol_cap_DCU"];
	OPEX_friendly_leaderHeadgear_snow = ["H_Beret_02","H_Beret_02","H_Beret_02","CUP_H_US_patrol_cap_winter"];
	OPEX_friendly_berets = ["H_Beret_02"];
	OPEX_friendly_caps = ["CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_PMC_Cap_Back_PRR_Grey","CUP_H_PMC_Cap_Back_PRR_Tan","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan","CUP_H_FR_Headset"];
	OPEX_friendly_bandanas = ["CUP_H_FR_Headband_Headset","H_Bandanna_khk","H_Bandanna_gry","H_Bandanna_sand","H_Bandanna_khk_hs"];
	OPEX_friendly_shemags = ["H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive"];
	OPEX_friendly_headsets = ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","B_AssaultPack_khk","B_AssaultPack_blk","B_AssaultPack_rgr","B_Kitbag_mcamo","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_mediumBackpacks_desert = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","B_AssaultPack_cbr","B_AssaultPack_blk","B_Kitbag_cbr","B_Kitbag_tan"];
	OPEX_friendly_mediumBackpacks_snow = ["CUP_B_Kombat_Olive","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL","B_AssaultPack_khk","B_AssaultPack_blk","B_AssaultPack_rgr","B_Kitbag_mcamo","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
	OPEX_friendly_bigBackpacks_woodland = ["CUP_B_USPack_Black","B_Carryall_oli"];
	OPEX_friendly_bigBackpacks_desert = ["CUP_B_USPack_Coyote","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow = ["CUP_B_USPack_Black","B_Carryall_oli"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_GER_Medic_Desert"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];