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
	OPEX_friendly_camp = "Camp Liberty"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_us.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

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
	OPEX_briefingBoard = "pictures\briefingboard_us.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_us.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_us.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_us.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_us.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_us.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_us.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_us.paa";
	OPEX_tv = "pictures\tv_us.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_us.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["CUP_B_MTVR_USMC"];
	OPEX_friendly_transportTrucksOpened_desert = ["CUP_B_MTVR_USA"];
	OPEX_friendly_transportTrucksOpened_snow = ["CUP_B_MTVR_USMC"];
	OPEX_friendly_transportTrucksCovered_woodland = ["CUP_B_MTVR_USMC"];
	OPEX_friendly_transportTrucksCovered_desert = ["CUP_B_MTVR_USA"];
	OPEX_friendly_transportTrucksCovered_snow = ["CUP_B_MTVR_USMC"];
	OPEX_friendly_fuelTrucks_woodland = ["CUP_B_MTVR_Refuel_USMC"];
	OPEX_friendly_fuelTrucks_desert = ["CUP_B_MTVR_Refuel_USA"];
	OPEX_friendly_fuelTrucks_snow = ["CUP_B_MTVR_Refuel_USMC"];
	OPEX_friendly_logisticTrucks_woodland = ["CUP_B_M1152_USMC"];
	OPEX_friendly_logisticTrucks_desert = ["CUP_B_M1152_USA"];
	OPEX_friendly_logisticTrucks_snow = ["CUP_B_M1152_USMC"];
	OPEX_friendly_medicalTrucks_woodland = ["CUP_B_HMMWV_Ambulance_USMC","CUP_B_M1133_MEV_Woodland","CUP_B_M1133_MEV_Woodland_Slat"];
	OPEX_friendly_medicalTrucks_desert = ["CUP_B_HMMWV_Ambulance_USA","CUP_B_M1133_MEV_Desert","CUP_B_M1133_MEV_Desert_Slat"];
	OPEX_friendly_medicalTrucks_snow = ["CUP_B_HMMWV_Ambulance_USMC","CUP_B_M1133_MEV_Woodland","CUP_B_M1133_MEV_Woodland_Slat"];
	OPEX_friendly_repairTrucks_woodland = ["CUP_B_MTVR_Repair_USMC"];
	OPEX_friendly_repairTrucks_desert = ["CUP_B_MTVR_Repair_USA"];
	OPEX_friendly_repairTrucks_snow = ["CUP_B_MTVR_Repair_USMC"];
	OPEX_friendly_ammoTrucks_woodland = ["CUP_B_MTVR_Ammo_USMC"];
	OPEX_friendly_ammoTrucks_desert = ["CUP_B_MTVR_Ammo_USA"];
	OPEX_friendly_ammoTrucks_snow = ["CUP_B_MTVR_Ammo_USMC"];
	OPEX_friendly_transportCars_woodland = ["CUP_B_HMMWV_Unarmed_USMC","CUP_B_M1151_USMC"];
	OPEX_friendly_transportCars_desert = ["CUP_B_HMMWV_Unarmed_USA","CUP_B_M1151_USA"];
	OPEX_friendly_transportCars_snow = ["CUP_B_HMMWV_Unarmed_USMC","CUP_B_M1151_USMC"];
	OPEX_friendly_combatCarsMG_woodland = ["CUP_B_HMMWV_M1114_USMC","CUP_B_HMMWV_M2_USMC","CUP_B_M1151_M2_USMC","CUP_B_M1151_Deploy_USMC","CUP_B_M1165_GMV_USMC","CUP_B_RG31E_M2_OD_USMC","CUP_B_RG31_M2_OD_USMC","CUP_B_RG31_M2_OD_GC_USMC"];
	OPEX_friendly_combatCarsMG_desert = ["CUP_B_HMMWV_Crows_M2_USA","CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_M2_USA","CUP_B_HMMWV_SOV_M2_USA","CUP_B_M1151_M2_USA","CUP_B_M1151_Deploy_USA","CUP_B_M1165_GMV_USA","CUP_B_RG31E_M2_USA","CUP_B_RG31_M2_USA","CUP_B_RG31_M2_GC_USA"];
	OPEX_friendly_combatCarsMG_snow = ["CUP_B_HMMWV_M1114_USMC","CUP_B_HMMWV_M2_USMC","CUP_B_M1151_M2_USMC","CUP_B_M1151_Deploy_USMC","CUP_B_M1165_GMV_USMC","CUP_B_RG31E_M2_OD_USMC","CUP_B_RG31_M2_OD_USMC","CUP_B_RG31_M2_OD_GC_USMC"];
	OPEX_friendly_combatCarsGL_woodland = ["CUP_B_HMMWV_MK19_USMC","CUP_B_HMMWV_TOW_USMC","CUP_B_M1151_Mk19_USMC","CUP_B_M1165_GMV_USMC","CUP_B_M1167_USMC","CUP_B_RG31_Mk19_OD_USMC"];
	OPEX_friendly_combatCarsGL_desert = ["CUP_B_HMMWV_MK19_USA","CUP_B_HMMWV_TOW_USA","CUP_B_HMMWV_Crows_MK19_USA","CUP_B_HMMWV_SOV_USA","CUP_B_M1151_Mk19_USA","CUP_B_M1165_GMV_USA","CUP_B_M1167_USA","CUP_B_RG31_Mk19_USA"];
	OPEX_friendly_combatCarsGL_snow = ["CUP_B_HMMWV_MK19_USMC","CUP_B_HMMWV_TOW_USMC","CUP_B_M1151_Mk19_USMC","CUP_B_M1165_GMV_USMC","CUP_B_M1167_USMC","CUP_B_RG31_Mk19_OD_USMC"];
	OPEX_friendly_vtt_woodland = ["CUP_B_M1126_ICV_M2_Woodland_Slat","CUP_B_M1126_ICV_M2_Woodland","CUP_B_M1126_ICV_MK19_Woodland_Slat","CUP_B_M1126_ICV_MK19_Woodland","CUP_B_M1128_MGS_Woodland_Slat","CUP_B_M1128_MGS_Woodland","CUP_B_M113_USA","CUP_B_M1130_CV_M2_Woodland_Slat","CUP_B_M1130_CV_M2_Woodland","CUP_B_M1135_ATGMV_Woodland_Slat","CUP_B_M1135_ATGMV_Woodland","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M7Bradley_USA_W"];
	OPEX_friendly_vtt_desert = ["CUP_B_M1126_ICV_M2_Desert_Slat","CUP_B_M1126_ICV_M2_Desert","CUP_B_M1126_ICV_MK19_Desert_Slat","CUP_B_M1126_ICV_MK19_Desert","CUP_B_M1128_MGS_Desert_Slat","CUP_B_M1128_MGS_Desert","CUP_B_M1130_CV_M2_Desert_Slat","CUP_B_M1130_CV_M2_Desert","CUP_B_M1135_ATGMV_Desert_Slat","CUP_B_M1135_ATGMV_Desert","CUP_B_M113_desert_USA","CUP_B_M2Bradley_USA_D","CUP_B_M2A3Bradley_USA_D","CUP_B_M7Bradley_USA_D"];
	OPEX_friendly_vtt_snow = ["CUP_B_M1126_ICV_M2_Woodland_Slat","CUP_B_M1126_ICV_M2_Woodland","CUP_B_M1126_ICV_MK19_Woodland_Slat","CUP_B_M1126_ICV_MK19_Woodland","CUP_B_M1128_MGS_Woodland_Slat","CUP_B_M1128_MGS_Woodland","CUP_B_M113_USA","CUP_B_M1130_CV_M2_Woodland_Slat","CUP_B_M1130_CV_M2_Woodland","CUP_B_M1135_ATGMV_Woodland_Slat","CUP_B_M1135_ATGMV_Woodland","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M7Bradley_USA_W"];
	OPEX_friendly_tanks_woodland = ["CUP_B_M1A1_Woodland_US_Army","CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M1A1_Woodland_USMC","CUP_B_M1A2_TUSK_MG_USMC"];
	OPEX_friendly_tanks_desert = ["CUP_B_M1A1_DES_US_Army","CUP_B_M1A2_TUSK_MG_DES_US_Army","CUP_B_M1A1_DES_USMC","CUP_B_M1A2_TUSK_MG_DES_USMC"];
	OPEX_friendly_tanks_snow = ["CUP_B_M1A1_Woodland_US_Army","CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M1A1_Woodland_USMC","CUP_B_M1A2_TUSK_MG_USMC"];
	OPEX_friendly_zodiacs = ["CUP_B_Zodiac_USMC"];
	OPEX_friendly_ships = ["CUP_B_RHIB2Turret_USMC","CUP_B_RHIB_USMC"];
	OPEX_friendly_quads_woodland append ["CUP_B_M1030_USMC"];
	OPEX_friendly_quads_desert append ["CUP_B_M1030_USMC"];
	OPEX_friendly_quads_snow append ["CUP_B_M1030_USMC"];
	OPEX_friendly_aircrafts = ["CUP_B_AV8B_DYN_USMC","CUP_B_F35B_USMC","CUP_B_F35B_Stealth_USMC","CUP_B_A10_DYN_USA"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["CUP_B_AH6J_USA","CUP_B_AH6M_USA"];
	OPEX_friendly_smallCombatHelicopters_desert = ["CUP_B_AH6J_USA","CUP_B_AH6M_USA"];
	OPEX_friendly_smallCombatHelicopters_snow = ["CUP_B_AH6J_USA","CUP_B_AH6M_USA"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["CUP_B_AH64_DL_USA","CUP_B_AH64D_DL_USA","CUP_B_MH60L_DAP_4x_US","CUP_B_MH60L_DAP_2x_US"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["CUP_B_AH64_DL_USA","CUP_B_AH64D_DL_USA","CUP_B_MH60L_DAP_4x_US","CUP_B_MH60L_DAP_2x_US"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["CUP_B_AH64_DL_USA","CUP_B_AH64D_DL_USA","CUP_B_MH60L_DAP_4x_US","CUP_B_MH60L_DAP_2x_US"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["CUP_B_MH6J_USA","CUP_B_MH6J_OBS_USA","CUP_B_MH6M_USA","CUP_B_MH6M_OBS_USA"];
	OPEX_friendly_smallTransportHelicopters_desert = ["CUP_B_MH6J_USA","CUP_B_MH6J_OBS_USA","CUP_B_MH6M_USA","CUP_B_MH6M_OBS_USA"];
	OPEX_friendly_smallTransportHelicopters_snow = ["CUP_B_MH6J_USA","CUP_B_MH6J_OBS_USA","CUP_B_MH6M_USA","CUP_B_MH6M_OBS_USA"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["CUP_B_MH60L_DAP_2x_US","CUP_B_MH60L_DAP_4x_US","CUP_B_UH60M_US","CUP_B_UH60M_FFV_US","CUP_B_UH60M_Unarmed_US","CUP_B_UH60M_Unarmed_FFV_US"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["CUP_B_MH60L_DAP_2x_US","CUP_B_MH60L_DAP_4x_US","CUP_B_UH60M_US","CUP_B_UH60M_FFV_US","CUP_B_UH60M_Unarmed_US","CUP_B_UH60M_Unarmed_FFV_US"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["CUP_B_MH60L_DAP_2x_US","CUP_B_MH60L_DAP_4x_US","CUP_B_UH60M_US","CUP_B_UH60M_FFV_US","CUP_B_UH60M_Unarmed_US","CUP_B_UH60M_Unarmed_FFV_US"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["CUP_B_CH47F_USA"];
	OPEX_friendly_bigTransportHelicopters_desert = ["CUP_B_CH47F_USA"];
	OPEX_friendly_bigTransportHelicopters_snow = ["CUP_B_CH47F_USA"];
	OPEX_friendly_UAVs = ["CUP_B_USMC_DYN_MQ9"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["CUP_B_M2StaticMG_US"];
	OPEX_friendly_ATstatics = ["CUP_B_TOW_TriPod_USMC"];
	OPEX_friendly_mortarStatics = ["CUP_B_M252_USMC"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["CUP_hgun_Colt1911"];
	OPEX_friendly_specialHandguns = ["CUP_hgun_Glock17_blk","CUP_hgun_Deagle","CUP_hgun_M9","CUP_hgun_Mk23"];
	OPEX_friendly_commonRifles = ["CUP_arifle_M4A1_black","CUP_arifle_M4A1"];
	OPEX_friendly_specialRifles = ["CUP_arifle_M4A3_black","CUP_arifle_M4A3_black","CUP_arifle_M4A3_black","CUP_arifle_mk18_black","CUP_arifle_mk18_black","CUP_arifle_mk18_black","CUP_arifle_mk18_black","CUP_arifle_mk18_black","CUP_arifle_Mk16_STD_black","CUP_arifle_Mk16_STD_SFG_black","CUP_arifle_Mk17_STD_black","CUP_arifle_Mk17_STD_SFG_black"];
	OPEX_friendly_GLrifles = ["CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_GL_carryhandle","CUP_arifle_mk18_m203_black","CUP_arifle_Mk16_STD_EGLM_black"];
	OPEX_friendly_MGriflesLight = ["CUP_lmg_M60E4_norail","CUP_lmg_M60E4","CUP_lmg_Mk48","CUP_lmg_Mk48_nohg"];
	OPEX_friendly_MGriflesHeavy = ["CUP_lmg_M60","CUP_lmg_FNMAG","CUP_lmg_FNMAG_RIS"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_MP5SD6"];
	OPEX_friendly_precisionRifles = ["CUP_srifle_M110_black","CUP_srifle_M24_blk"];
	OPEX_friendly_sniperRifles = ["CUP_srifle_M107_Base"];
	OPEX_friendly_ATlaunchers = ["CUP_launch_Javelin","CUP_launch_M136_Loaded","CUP_launch_M136_Loaded","CUP_launch_M136_Loaded","CUP_launch_NLAW_Loaded","CUP_launch_MAAWS","CUP_launch_MAAWS"];
	OPEX_friendly_AAlaunchers = ["CUP_launch_FIM92Stinger_Loaded"];
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
	OPEX_friendly_commonUniforms_woodland = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_commonUniforms_desert = ["CUP_U_B_USArmy_Base"];
	OPEX_friendly_commonUniforms_snow = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_specialUniforms_woodland = ["CUP_U_CRYE_V1_Roll"];
	OPEX_friendly_specialUniforms_desert = ["CUP_U_B_USArmy_TwoKnee"];
	OPEX_friendly_specialUniforms_snow = ["CUP_U_CRYE_V1_Roll"];
	OPEX_friendly_ghillieUniforms_woodland = ["CUP_U_B_BAF_MTP_GHILLIE","CUP_U_B_BAF_DPM_GHILLIE","U_I_FullGhillie_lsh"];
	OPEX_friendly_ghillieUniforms_desert = ["CUP_U_B_BAF_DDPM_GHILLIE","CUP_U_B_CZ_DST_Ghillie","U_B_FullGhillie_ard"];
	OPEX_friendly_ghillieUniforms_snow = ["CUP_U_B_BAF_DDPM_GHILLIE"];
	OPEX_friendly_heliPilotUniforms_woodland = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_heliPilotUniforms_desert = ["CUP_U_B_USArmy_Base"];
	OPEX_friendly_heliPilotUniforms_snow = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["CUP_U_B_USArmy_PilotOverall"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["CUP_U_B_USArmy_PilotOverall"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["CUP_U_B_USArmy_PilotOverall"];
	OPEX_friendly_tankPilotUniforms_woodland = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_tankPilotUniforms_desert = ["CUP_U_B_USArmy_Base"];
	OPEX_friendly_tankPilotUniforms_snow = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_medicUniforms_woodland = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_medicUniforms_desert = ["CUP_U_B_USArmy_Base"];
	OPEX_friendly_medicUniforms_snow = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_instructorUniforms_woodland = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_instructorUniforms_desert = ["CUP_U_B_USArmy_Base"];
	OPEX_friendly_instructorUniforms_snow = ["CUP_U_CRYE_V1_Full"];
	OPEX_friendly_tshirtUniforms_woodland = ["U_B_CombatUniform_mcam_tshirt"];
	OPEX_friendly_tshirtUniforms_desert = ["CUP_U_B_USArmy_Soft"];
	OPEX_friendly_tshirtUniforms_snow = ["U_B_CombatUniform_mcam_tshirt"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["CUP_V_B_JPC_MCam_Light","CUP_V_B_LBT_LBV_US_MCam"];
	OPEX_friendly_commonVests_desert = ["CUP_V_B_IOTV_Rifleman"];
	OPEX_friendly_commonVests_snow = ["CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_specialVests_woodland = ["V_PlateCarrier1_rgr","CUP_V_B_Armatus_US_MCam","CUP_V_B_Armatus_MCam","CUP_V_B_Ciras_Mcam3","CUP_V_B_Ciras_Mcam4","CUP_V_B_JPC_MCam","CUP_V_B_Armatus_BB_US_MCam"];
	OPEX_friendly_specialVests_desert = ["CUP_V_B_IOTV_AT","CUP_V_B_IOTV_saw","CUP_V_B_IOTV_SL","CUP_V_B_IOTV_tl"];
	OPEX_friendly_specialVests_snow = ["CUP_V_PMC_CIRAS_Winter_Veh","CUP_V_PMC_CIRAS_Winter_Patrol","CUP_V_PMC_CIRAS_Winter_TL"];
	OPEX_friendly_medicVests_woodland = ["CUP_V_B_Ciras_MCam"];
	OPEX_friendly_medicVests_desert = ["CUP_V_B_IOTV_Medic"];
	OPEX_friendly_medicVests_snow = ["CUP_V_B_Ciras_MCam"];
	OPEX_friendly_lightVests_woodland = ["CUP_V_B_JPC_MCam_Light"];
	OPEX_friendly_lightVests_desert = ["CUP_V_B_IOTV_Rifleman"];
	OPEX_friendly_lightVests_snow = ["CUP_V_PMC_CIRAS_Winter_Empty"];
	OPEX_friendly_grenadierVests_woodland = ["V_HarnessOGL_gry"];
	OPEX_friendly_grenadierVests_desert = ["CUP_V_B_IOTV_gl"];
	OPEX_friendly_grenadierVests_snow = ["CUP_V_PMC_CIRAS_Winter_Grenadier"];
	OPEX_friendly_EODvests_woodland = ["V_PlateCarrierGL_rgr"];
	OPEX_friendly_EODvests_desert = ["CUP_V_B_IOTV_MG"];
	OPEX_friendly_EODvests_snow = ["V_PlateCarrierGL_rgr"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["CUP_H_Ger_M92","CUP_H_Ger_M92_GG","CUP_H_Ger_M92_GG_CB","CUP_H_Ger_M92_GG_CF"];
	OPEX_friendly_commonHelmets_desert = ["CUP_H_USArmy_HelmetMICH_earpro_ess","CUP_H_USArmy_HelmetMICH_earpro","CUP_H_USArmy_HelmetMICH_ESS","CUP_H_USArmy_HelmetMICH_headset_ess","CUP_H_USArmy_HelmetMICH_headset","CUP_H_USArmy_HelmetMICH"];
	OPEX_friendly_commonHelmets_snow = ["CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Spray_NoHS","CUP_H_OpsCore_Covered_MCAM_NoHS","CUP_H_OpsCore_Spray_NoHS"];
	OPEX_friendly_specialHelmets_woodland = ["CUP_H_OpsCore_Spray_US","CUP_H_OpsCore_Covered_MCAM_US","CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_H_OpsCore_Spray_US_SF"];
	OPEX_friendly_specialHelmets_desert = ["CUP_H_OpsCore_Grey","CUP_H_OpsCore_Grey_NoHS","CUP_H_OpsCore_Grey_SF"];
	OPEX_friendly_specialHelmets_snow = ["CUP_H_OpsCore_Spray_US","CUP_H_OpsCore_Covered_MCAM_US","CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_H_OpsCore_Spray_US_SF"];
	OPEX_friendly_EODhelmets_woodland = ["CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_EODhelmets_desert = ["CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_EODhelmets_snow = ["CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Up_khaki","CUP_H_RUS_Altyn_Shield_Down_khaki"];
	OPEX_friendly_heliPilotHelmets = ["CUP_H_PMC_EP_Headset","CUP_H_USMC_Crew_Helmet"];
	OPEX_friendly_tankCrewHelmets = ["CUP_H_USMC_Crew_Helmet"];
	OPEX_friendly_cameraHelmets_woodland = ["CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_H_OpsCore_Spray_US_SF","H_HelmetSpecB_blk","H_HelmetSpecB_snakeskin"];
	OPEX_friendly_cameraHelmets_desert = ["CUP_H_OpsCore_Grey_SF"];
	OPEX_friendly_cameraHelmets_snow = ["CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_H_OpsCore_Spray_US_SF","H_HelmetSpecB_blk","H_HelmetSpecB_snakeskin"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["H_Booniehat_mcamo","H_Booniehat_mcamo","H_Booniehat_mcamo","H_Booniehat_khk","H_Booniehat_tan"];
	OPEX_friendly_hats_desert = ["CUP_H_USArmy_Boonie"];
	OPEX_friendly_hats_snow = ["H_Booniehat_mcamo","H_Booniehat_mcamo","H_Booniehat_mcamo","H_Booniehat_khk","H_Booniehat_tan"];
	OPEX_friendly_beanies_woodland = ["CUP_H_PMC_Beanie_Khaki","CUP_H_FR_BeanieGreen","CUP_H_PMC_Beanie_Headphones_Khaki","CUP_H_PMC_Beanie_Headphones_Black","CUP_H_PMC_Beanie_Black","CUP_H_SLA_BeanieGreen"];
	OPEX_friendly_beanies_desert = ["CUP_H_PMC_Beanie_Headphones_Black"];
	OPEX_friendly_beanies_snow = ["CUP_H_PMC_Beanie_Winter","CUP_H_PMC_Beanie_Headphones_Winter"];
	OPEX_friendly_leaderHeadgear_woodland = ["H_Cap_tan_specops_US","H_Beret_blk","H_Beret_02","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_EP_Tan","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_leaderHeadgear_desert = ["H_Beret_blk","H_Beret_02","CUP_H_USA_Cap","CUP_H_USA_Cap"];
	OPEX_friendly_leaderHeadgear_snow = ["H_Cap_tan_specops_US","H_Beret_blk","H_Beret_02","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_EP_Tan","CUP_H_PMC_Cap_PRR_Tan"];
	OPEX_friendly_caps = ["H_Cap_tan_specops_US","CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_PMC_Cap_Back_PRR_Grey","CUP_H_PMC_Cap_Back_PRR_Tan","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_PMC_Cap_PRR_Grey","CUP_H_PMC_Cap_PRR_Tan","H_Cap_usblack"];
	OPEX_friendly_bandanas = ["H_Bandanna_mcamo","H_Bandanna_sand","CUP_H_FR_BandanaGreen","CUP_H_RUS_Bandana_HS"];
	OPEX_friendly_shemags = ["H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive"];
	OPEX_friendly_headsets append ["CUP_H_PMC_EP_Headset","CUP_H_FR_Headset"];

	// FACEGEAR
	OPEX_friendly_balaclavas append ["CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_blk","CUP_RUS_Balaclava_grn"];
	OPEX_friendly_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf3","CUP_FR_NeckScarf","CUP_FR_NeckScarf2"];
	OPEX_friendly_glasses append ["CUP_G_Grn_Scarf_Shades_GPS","CUP_G_Tan_Scarf_Shades_GPS","CUP_G_White_Scarf_Shades_GPS","CUP_G_PMC_RadioHeadset_Glasses","CUP_G_Oakleys_Clr","CUP_G_ESS_BLK"];
	OPEX_friendly_sunglasses append ["CUP_G_ESS_BLK_Dark","CUP_G_ESS_BLK_Ember","CUP_G_Oakleys_Drk","CUP_G_Oakleys_Embr","CUP_G_PMC_RadioHeadset_Glasses_Dark","CUP_G_PMC_RadioHeadset_Glasses_Ember"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland append ["B_AssaultPack_mcamo","B_AssaultPack_mcamo","B_AssaultPack_mcamo","B_AssaultPack_khk","B_AssaultPack_rgr","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_mcamo","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_mcamo","B_TacticalPack_blk","CUP_B_AssaultPack_Coyote","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_mediumBackpacks_desert append ["CUP_B_AssaultPack_ACU","CUP_B_AssaultPack_ACU","CUP_B_AssaultPack_ACU","CUP_B_USMC_AssaultPack","B_AssaultPack_cbr","B_Kitbag_cbr","B_TacticalPack_blk","B_AssaultPack_blk"];
	OPEX_friendly_mediumBackpacks_snow append ["B_AssaultPack_mcamo","B_AssaultPack_mcamo","B_AssaultPack_mcamo","B_AssaultPack_khk","B_AssaultPack_rgr","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_mcamo","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_mcamo","B_TacticalPack_blk","CUP_B_AssaultPack_Coyote","CUP_B_USMC_AssaultPack","CUP_B_USMC_MOLLE_WDL"];
	OPEX_friendly_bigBackpacks_woodland append ["CUP_B_USPack_Coyote","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_desert append ["CUP_B_USPack_Coyote","B_Carryall_cbr"];
	OPEX_friendly_bigBackpacks_snow append ["CUP_B_USPack_Coyote","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_mcamo","B_Carryall_cbr"];
	OPEX_friendly_medicBackpacks_woodland = ["CUP_B_AssaultPack_Coyote","CUP_B_USMC_AssaultPack"];
	OPEX_friendly_medicBackpacks_desert = ["CUP_B_MedicPack_ACU","CUP_B_MedicPack_ACU","CUP_B_MedicPack_ACU","CUP_B_USMC_AssaultPack"];
	OPEX_friendly_medicBackpacks_snow = ["CUP_B_AssaultPack_Coyote","CUP_B_USMC_AssaultPack"];
	OPEX_friendly_radioBackpacks_woodland append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_desert append ["CUP_B_Kombat_Radio_Olive"];
	OPEX_friendly_radioBackpacks_snow append ["CUP_B_Kombat_Radio_Olive"];