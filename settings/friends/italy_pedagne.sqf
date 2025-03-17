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

	if (!(isClass (configFile >> "CfgPatches" >> "ASZ_Weapons_A3"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "ASZ_Wheel_A3"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "ASZ_Tracked_A3"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "ASZ_Helicopter_A3"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "ASZ_Helicopter_A3"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
		
// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "Pedagne"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Italy"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_it"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Italy"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_italy.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_italy.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Cesare"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_it.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

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
	OPEX_briefingBoard = "pictures\briefingboard_it.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_it.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_it.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_it.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_it.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_it.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_it.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_it.paa";
	OPEX_tv = "pictures\tv_it.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_it.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_it.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["italian_01", "italian_02", "italian_03", "italian_04", "italian_05", "italian_06", "italian_07", "italian_08", "italian_09", "italian_10", "italian_11", "italian_12", "italian_13", "italian_14", "italian_15", "italian_16", "italian_17", "italian_18", "italian_19", "italian_20", "italian_21", "italian_22", "italian_23", "italian_24", "italian_25", "italian_26", "italian_27", "italian_28", "italian_29", "italian_30", "italian_31", "italian_32", "italian_33", "italian_34", "italian_35", "italian_36", "italian_37", "italian_38", "italian_39", "italian_40", "italian_41", "italian_42", "italian_43", "italian_44", "italian_45", "italian_46", "italian_47", "italian_48", "italian_49", "italian_50"];

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_transportTrucksOpened_desert = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_transportTrucksOpened_snow = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_transportTrucksCovered_woodland = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_transportTrucksCovered_desert = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_transportTrucksCovered_snow = ["ASZ_ACM904x4_EI","ASZ_ACTL4x4_EI"];
	OPEX_friendly_fuelTrucks_woodland = ["ASZ_ACM904x4_EI_fuel","ASZ_ACTL6x6_EI_fuel"];
	OPEX_friendly_fuelTrucks_desert = ["ASZ_ACM904x4_EI_fuel","ASZ_ACTL6x6_EI_fuel"];
	OPEX_friendly_fuelTrucks_snow = ["ASZ_ACM904x4_EI_fuel","ASZ_ACTL6x6_EI_fuel"];
	OPEX_friendly_logisticTrucks_woodland = ["ASZ_ACM904x4_EI_logistic","ASZ_ACTL6x6_EI_logistic"];
	OPEX_friendly_logisticTrucks_desert = ["ASZ_ACM904x4_EI_logistic","ASZ_ACTL6x6_EI_logistic"];
	OPEX_friendly_logisticTrucks_snow = ["ASZ_ACM904x4_EI_logistic","ASZ_ACTL6x6_EI_logistic"];
	OPEX_friendly_medicalTrucks_woodland = ["ASZ_VM90_EI_amb","ASZ_VTML_EI_amb"];
	OPEX_friendly_medicalTrucks_desert = ["ASZ_VM90_EI_amb","ASZ_VTML_EI_amb"];
	OPEX_friendly_medicalTrucks_snow = ["ASZ_VM90_EI_amb","ASZ_VTML_EI_amb"];
	OPEX_friendly_repairTrucks_woodland = ["ASZ_ACTL6x6_EI_repair","ASZ_VM90_EI_rep"];
	OPEX_friendly_repairTrucks_desert = ["ASZ_ACTL6x6_EI_repair","ASZ_VM90_EI_rep"];
	OPEX_friendly_repairTrucks_snow = ["ASZ_ACTL6x6_EI_repair","ASZ_VM90_EI_rep"];
	OPEX_friendly_transportCars_woodland = ["ASZ_LR110_CCpara","ASZ_LR90_EI","ASZ_LR90_EIs","ASZ_VM90_EI"];
	OPEX_friendly_transportCars_desert = ["ASZ_LR110_CCpara","ASZ_LR90_EI","ASZ_LR90_EIs","ASZ_VM90_EI"];
	OPEX_friendly_transportCars_snow = ["ASZ_LR110_CCpara","ASZ_LR90_EI","ASZ_LR90_EIs","ASZ_VM90_EI"];
	OPEX_friendly_combatCarsMG_woodland = ["ASZ_LR110_CCpara_MG3","ASZ_LR90_M2","ASZ_VM90_EI_M2","ASZ_VM90_EI_P","ASZ_VM90spop","ASZ_VTML_EI_M2","ASZ_VTML_EI_M2protect","ASZ_VTML_long_range_EI_M2","ASZ_VTML_spop"];
	OPEX_friendly_combatCarsMG_desert = ["ASZ_LR110_CCpara_MG3","ASZ_LR90_M2","ASZ_VM90_EI_M2","ASZ_VM90_EI_P","ASZ_VM90spop","ASZ_VTML_EI_M2","ASZ_VTML_EI_M2protect","ASZ_VTML_long_range_EI_M2","ASZ_VTML_spop","ASZ_VTML_des_EI_M2","ASZ_VTML_des_EI_M2protect","ASZ_VTML_des_long_range_EI_M2"];
	OPEX_friendly_combatCarsMG_snow = ["ASZ_LR110_CCpara_MG3","ASZ_LR90_M2","ASZ_VM90_EI_M2","ASZ_VM90_EI_P","ASZ_VM90spop","ASZ_VTML_EI_M2","ASZ_VTML_EI_M2protect","ASZ_VTML_long_range_EI_M2","ASZ_VTML_spop"];
	OPEX_friendly_combatCarsGL_woodland = ["ASZ_LR90_MK19","ASZ_VTML_EI_MK19","ASZ_LR90_TOW","ASZ_VM90_MM_105","ASZ_VTML_EI_TOW"];
	OPEX_friendly_combatCarsGL_desert = ["ASZ_LR90_MK19","ASZ_VTML_EI_MK19","ASZ_LR90_TOW","ASZ_VM90_MM_105","ASZ_VTML_EI_TOW"];
	OPEX_friendly_combatCarsGL_snow = ["ASZ_LR90_MK19","ASZ_VTML_EI_MK19","ASZ_LR90_TOW","ASZ_VM90_MM_105","ASZ_VTML_EI_TOW"];
	OPEX_friendly_vtt_woodland = ["ASZ_6614_EI","ASZ_6614_EI_30mm","ASZ_6614_EI_camo","ASZ_6614_EI_rocket","ASZ_6614_EI_ibis","ASZ_6614_EI_arm","ASZ_6614_EI_armcamo","ASZ_PUMA4x4_M2","ASZ_PUMA4x4_TOW","ASZ_PUMA4x4CC_MG3","ASZ_PUMA6x6_M2","ASZ_PUMA6x6_AT","ASZ_PUMA6x6_hitrole","ASZ_PUMA6x6CC_MG3","ASZ_Freccia","ASZ_Freccia_AT","ASZ_Centauro_B1","ASZ_SuperAV_EI_Command","ASZ_SuperAV_EI","ASZ_SuperAV_EI_battlefield","ASZ_VCC1_EI","ASZ_VCC1_EI_camo","ASZ_VCC1_EI_camo_plus","ASZ_VCC1_EI_plus","ASZ_VCC2_EI"];
	OPEX_friendly_vtt_desert = ["ASZ_6614_EI","ASZ_6614_EI_30mm","ASZ_6614_EI_camo","ASZ_6614_EI_rocket","ASZ_6614_EI_ibis","ASZ_6614_EI_arm","ASZ_6614_EI_armcamo","ASZ_PUMA4x4_M2","ASZ_PUMA4x4_TOW","ASZ_PUMA4x4CC_MG3","ASZ_PUMA6x6_M2","ASZ_PUMA6x6_AT","ASZ_PUMA6x6_hitrole","ASZ_PUMA6x6CC_MG3","ASZ_Freccia","ASZ_Freccia_AT","ASZ_Centauro_B1","ASZ_SuperAV_EI_Command","ASZ_SuperAV_EI","ASZ_SuperAV_EI_battlefield","ASZ_VCC1_EI","ASZ_VCC1_EI_camo","ASZ_VCC1_EI_camo_plus","ASZ_VCC1_EI_plus","ASZ_VCC2_EI"];
	OPEX_friendly_vtt_snow = ["ASZ_6614_EI","ASZ_6614_EI_30mm","ASZ_6614_EI_camo","ASZ_6614_EI_rocket","ASZ_6614_EI_ibis","ASZ_6614_EI_arm","ASZ_6614_EI_armcamo","ASZ_PUMA4x4_M2","ASZ_PUMA4x4_TOW","ASZ_PUMA4x4CC_MG3","ASZ_PUMA6x6_M2","ASZ_PUMA6x6_AT","ASZ_PUMA6x6_hitrole","ASZ_PUMA6x6CC_MG3","ASZ_Freccia","ASZ_Freccia_AT","ASZ_Centauro_B1","ASZ_SuperAV_EI_Command","ASZ_SuperAV_EI","ASZ_SuperAV_EI_battlefield","ASZ_VCC1_EI","ASZ_VCC1_EI_camo","ASZ_VCC1_EI_camo_plus","ASZ_VCC1_EI_plus","ASZ_VCC2_EI"];
	OPEX_friendly_tanks_woodland = ["ASZ_Ariete","ASZ_Ariete_plus","ASZ_Ariete_camo","ASZ_Ariete_camo_plus","ASZ_Leopard"];
	OPEX_friendly_tanks_desert = ["ASZ_Ariete","ASZ_Ariete_plus","ASZ_Ariete_camo","ASZ_Ariete_camo_plus","ASZ_Leopard"];
	OPEX_friendly_tanks_snow = ["ASZ_Ariete","ASZ_Ariete_plus","ASZ_Ariete_camo","ASZ_Ariete_camo_plus","ASZ_Leopard"];
	OPEX_friendly_quads_woodland = ["ASZ_ATV_CM","ASZ_ATV_GOI"];
	OPEX_friendly_quads_desert = ["ASZ_ATV_SOFDES"];
	OPEX_friendly_quads_snow = ["ASZ_ATV_CM","ASZ_ATV_GOI"];
	OPEX_friendly_aircrafts = ["ASZ_AV8B_MM_AA","ASZ_AV8B_MM_GA","ASZ_AV8B_MM_GBU","ASZ_EFA_AM_AA","ASZ_EFA_AM_GA","ASZ_EFA_AM_GBU"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["ASZ_AH6_EI_ffar","ASZ_A129_AT","ASZ_A129_GA"];
	OPEX_friendly_smallCombatHelicopters_desert = ["ASZ_AH6_EI_ffar","ASZ_A129_AT","ASZ_A129_GA"];
	OPEX_friendly_smallCombatHelicopters_snow = ["ASZ_AH6_EI_ffar","ASZ_A129_AT","ASZ_A129_GA"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["ASZ_AB212_EI_FFAR","ASZ_AB212_EI_M21","ASZ_AB412_EI_ffar","ASZ_AB412_EI_M21"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["ASZ_AB212_EI_FFAR","ASZ_AB212_EI_M21","ASZ_AB412_EI_ffar","ASZ_AB412_EI_M21"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["ASZ_AB212_EI_FFAR","ASZ_AB212_EI_M21","ASZ_AB412_EI_ffar","ASZ_AB412_EI_M21"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["ASZ_AH6_EI_reos"];
	OPEX_friendly_smallTransportHelicopters_desert = ["ASZ_AH6_EI_reos"];
	OPEX_friendly_smallTransportHelicopters_snow = ["ASZ_AH6_EI_reos"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["ASZ_AB212_AM_ico","ASZ_AB212_AM","ASZ_AB412_EI_reos","ASZ_AB412_EI_M21"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["ASZ_AB212_AM_ico","ASZ_AB212_AM","ASZ_AB412_EI_reos","ASZ_AB412_EI_M21"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["ASZ_AB212_AM_ico","ASZ_AB212_AM","ASZ_AB412_EI_reos","ASZ_AB412_EI_M21"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["ASZ_CH47_EI","ASZ_NH90_EI"];
	OPEX_friendly_bigTransportHelicopters_desert = ["ASZ_CH47_EI","ASZ_NH90_EI"];
	OPEX_friendly_bigTransportHelicopters_snow = ["ASZ_CH47_EI","ASZ_NH90_EI"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["ASZ_M92","ASZ_M92","ASZ_M92","ASZ_M84"];
	OPEX_friendly_specialHandguns = ["ASZ_M92","ASZ_glock17"];
	OPEX_friendly_commonRifles = ["ASZ_AR7090"];
	OPEX_friendly_specialRifles = ["ASZ_ARX160","ASZ_ARX160","ASZ_ARX160","ASZ_ARX160_C","ASZ_ARX160_IV_L_CC","APD_ARX200","APD_ARX200_VGrip","ASZ_SC90","ASZ_SCS90","ASZ_M4A1"];
	OPEX_friendly_GLrifles = ["ASZ_AR7090_gl","ASZ_AR7090_gl","ASZ_AR7090_gl","ASZ_AR7090_gl","ASZ_AR7090_gl","ASZ_ARX160_GLS","ASZ_SC90_gl"];
	OPEX_friendly_MGriflesLight = ["ASZ_M249_base","ASZ_M249mk1_base"];
	OPEX_friendly_MGriflesHeavy = ["ASZ_RH_MG3_base"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["ASZ_MP5SD","ASZ_MP5A5","ASZ_PM12"];
	OPEX_friendly_precisionRifles = ["ASZ_SakoTRG42","ASZ_M40A3_Green","ASZ_M40A3_Green_ghillie"];
	OPEX_friendly_sniperRifles = ["ASZ_MCM_tac50_blk","ASZ_M107_Blk"];
	OPEX_friendly_ATlaunchers = ["ASZ_SWM_pzfaust3","ASZ_SWM_pzfaust3","ASZ_SWM_pzfaust3","ASZ_Launch_Spike"];
	OPEX_friendly_AAlaunchers = ["ASZ_Launch_Stinger"];
	OPEX_friendly_shotguns = ["8Rnd_B_Beneli_74Slug_ASZ"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["ASZ_Acog","ASZ_Aimpoint_COMPM4S","ASZ_Aimpoint_PRO_blk"];
	OPEX_friendly_distantCombatOptics append ["ASZ_Acog","ASZ_Eotech_blk","ASZ_Leupold_MK4_CQT"];
	OPEX_friendly_sniperOptics append ["ASZ_AMS","ASZ_Leupold_MK4_LRT_blk","ASZ_Leupold_MK4_MRT_black","ASZ_Leupold_VXR_Patrol","ASZ_Schmidt_Bender_LP","ASZ_Tasco_Pronghorn"];
	OPEX_friendly_flashlights append ["ASZ_flashlight"];
	OPEX_friendly_rifleSilencers append ["ASZ_Silencer_M4A1","ASZ_Silencer_556_blk","ASZ_Silencer_762_blk","ASZ_M_Pistol_sd"];
	OPEX_friendly_handgunSilencers append ["ASZ_Silencer_M9"];
	OPEX_friendly_pointers append ["ASZ_Pointer_blk","ASZ_Pointer_M4"];
	OPEX_friendly_bipods append ["ASZ_Bipod_M107","ASZ_Bipod_AR7090","ASZ_Bipod_ARX_blk","ASZ_Bipod_M249","ASZ_Bipod_M40A3","ASZ_Bipod_tac50","ASZ_Bipod_MG3","ASZ_Bipod_SakoTRG42"];

	// VARIOUS ITEMS
	OPEX_friendly_spotterBinoculars append ["ASZ_Vector"];
	OPEX_friendly_laserDesignators append ["ASZ_Soflam"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["ASZ_Uniforme_CM"];
	OPEX_friendly_commonUniforms_desert = ["ASZ_Uniforme_CM_des"];
	OPEX_friendly_commonUniforms_snow = ["ASZ_Uniforme_ALP"];
	OPEX_friendly_specialUniforms_woodland = ["ASZ_Combat_Uniform_CM"];
	OPEX_friendly_specialUniforms_desert = ["ASZ_Combat_Uniform_CM_des"];
	OPEX_friendly_specialUniforms_snow = ["ASZ_Uniforme_RAP"];
	OPEX_friendly_ghillieUniforms_woodland = ["ASZ_GhillieSuit"];
	OPEX_friendly_ghillieUniforms_desert = ["ASZ_GhillieSuit_des"];
	OPEX_friendly_ghillieUniforms_snow = ["ASZ_GhillieSuit"];
	OPEX_friendly_heliPilotUniforms_woodland = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_heliPilotUniforms_desert = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_heliPilotUniforms_snow = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["ASZ_uniform_Pilot_AM","ASZ_uniform_Pilot_MM"];
	OPEX_friendly_tankPilotUniforms_woodland = ["ASZ_Uniforme_Crew"];
	OPEX_friendly_tankPilotUniforms_desert = ["ASZ_Uniforme_Crew"];
	OPEX_friendly_tankPilotUniforms_snow = ["ASZ_Uniforme_Crew"];
	OPEX_friendly_medicUniforms_woodland = ["ASZ_Uniforme_CM"];
	OPEX_friendly_medicUniforms_desert = ["ASZ_Uniforme_CM_des"];
	OPEX_friendly_medicUniforms_snow = ["ASZ_Uniforme_CM"];
	OPEX_friendly_instructorUniforms_woodland = ["ASZ_Uniforme_CM"];
	OPEX_friendly_instructorUniforms_desert = ["ASZ_Uniforme_CM_des"];
	OPEX_friendly_instructorUniforms_snow = ["ASZ_Uniforme_CM"];
	OPEX_friendly_tshirtUniforms_woodland = ["ASZ_Combat_Uniform_CM"];
	OPEX_friendly_tshirtUniforms_desert = ["ASZ_Combat_Uniform_CM_des"];
	OPEX_friendly_tshirtUniforms_snow = ["ASZ_Combat_Uniform_CM"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["ASZ_SOD_Gear_PC_Green","ASZ_SOD_Gear_PC_Green_MG","ASZ_SOD_Gear_PC_Green_TL"];
	OPEX_friendly_commonVests_desert = ["ASZ_SOD_Gear_PC_Des","ASZ_SOD_Gear_PC_Des_MG"];
	OPEX_friendly_commonVests_snow = ["ASZ_SOD_Gear_PC_Green","ASZ_SOD_Gear_PC_Green_MG","ASZ_SOD_Gear_PC_Green_TL"];
	OPEX_friendly_specialVests_woodland = ["ASZ_SOD_Gear_BA_Vegecam","ASZ_SOD_Gear_BA_GL_Vegecam","ASZ_SOD_Gear_BA_Light_Vegecam","ASZ_SOD_Gear_BA_MG_Vegecam","ASZ_SOD_Gear_BA_TL_Vegecam"];
	OPEX_friendly_specialVests_desert = ["ASZ_SOD_Gear_BA_Desert","ASZ_SOD_Gear_BA_GL_Desert","ASZ_SOD_Gear_BA_Light_Desert","ASZ_SOD_Gear_BA_MG_Desert","ASZ_SOD_Gear_BA_TL_Desert"];
	OPEX_friendly_specialVests_snow = ["ASZ_SOD_Gear_BA_Multiland","ASZ_SOD_Gear_BA_GL_Multiland","ASZ_SOD_Gear_BA_Light_Multiland","ASZ_SOD_Gear_BA_MG_Multiland","ASZ_SOD_Gear_BA_TL_Multiland"];
	OPEX_friendly_medicVests_woodland = ["ASZ_SOD_Gear_BA_Medic_Vegecam"];
	OPEX_friendly_medicVests_desert = ["ASZ_SOD_Gear_BA_Medic_Desert"];
	OPEX_friendly_medicVests_snow = ["ASZ_SOD_Gear_BA_Medic_Multiland"];
	OPEX_friendly_lightVests_woodland = ["ASZ_SOD_Gear_PC_Green"];
	OPEX_friendly_lightVests_desert = ["ASZ_SOD_Gear_PC_Des"];
	OPEX_friendly_lightVests_snow = ["ASZ_SOD_Gear_PC_Green"];
	OPEX_friendly_grenadierVests_woodland = ["ASZ_SOD_Gear_PC_Green_GL"];
	OPEX_friendly_grenadierVests_desert = ["ASZ_SOD_Gear_PC_Des_GL"];
	OPEX_friendly_grenadierVests_snow = ["ASZ_SOD_Gear_PC_Green_GL"];
	OPEX_friendly_EODvests_woodland = ["ASZ_SOD_Gear_BA_MG_Vegecam"];
	OPEX_friendly_EODvests_desert = ["ASZ_SOD_Gear_BA_MG_Desert"];
	OPEX_friendly_EODvests_snow = ["ASZ_SOD_Gear_BA_MG_Multiland"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["ASZ_mich_2000_vegecam"];
	OPEX_friendly_commonHelmets_desert = ["ASZ_mich_2000_desert"];
	OPEX_friendly_commonHelmets_snow = ["ASZ_mich_2000_multiland"];
	OPEX_friendly_specialHelmets_woodland = ["ASZ_mich_2002_green","ASZ_VTG_Stingray_ACH_Helmet_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_base_Vegecam"];
	OPEX_friendly_specialHelmets_desert = ["ASZ_mich_2002_desert","ASZ_VTG_Stingray_ACH_Helmet_Desert","ASZ_VTG_Stingray_ACH_Helmet_base_Desert"];
	OPEX_friendly_specialHelmets_snow = ["ASZ_mich_2002_green","ASZ_VTG_Stingray_ACH_Helmet_Multiland","ASZ_VTG_Stingray_ACH_Helmet_base_Multiland"];
	OPEX_friendly_EODhelmets_woodland = ["ASZ_mich_2000_vegecam"];
	OPEX_friendly_EODhelmets_desert = ["ASZ_mich_2000_desert"];
	OPEX_friendly_EODhelmets_snow = ["ASZ_mich_2000_multiland"];
	OPEX_friendly_heliPilotHelmets = ["ASZ_Helm_HeliPilot_AM","ASZ_Helm_HeliPilot_MM"];
	OPEX_friendly_aircraftPilotHelmets = ["ASZ_Helm_AirPilot","ASZ_Helm_EfaPilot"];
	OPEX_friendly_tankCrewHelmets = ["ASZ_Helmet_Crew_Wheel"];
	OPEX_friendly_cameraHelmets_woodland append ["ASZ_mich_2002_green","ASZ_mich_2002_desert","ASZ_VTG_Stingray_ACH_Helmet_Multiland","ASZ_VTG_Stingray_ACH_Helmet_Desert","ASZ_VTG_Stingray_ACH_Helmet_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_Woodland","ASZ_VTG_Stingray_ACH_Helmet_base_Desert","ASZ_VTG_Stingray_ACH_Helmet_base_Multiland","ASZ_VTG_Stingray_ACH_Helmet_base_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_base_Woodland"];
	OPEX_friendly_cameraHelmets_desert append ["ASZ_mich_2002_green","ASZ_mich_2002_desert","ASZ_VTG_Stingray_ACH_Helmet_Multiland","ASZ_VTG_Stingray_ACH_Helmet_Desert","ASZ_VTG_Stingray_ACH_Helmet_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_Woodland","ASZ_VTG_Stingray_ACH_Helmet_base_Desert","ASZ_VTG_Stingray_ACH_Helmet_base_Multiland","ASZ_VTG_Stingray_ACH_Helmet_base_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_base_Woodland"];
	OPEX_friendly_cameraHelmets_snow append ["ASZ_mich_2002_green","ASZ_mich_2002_desert","ASZ_VTG_Stingray_ACH_Helmet_Multiland","ASZ_VTG_Stingray_ACH_Helmet_Desert","ASZ_VTG_Stingray_ACH_Helmet_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_Woodland","ASZ_VTG_Stingray_ACH_Helmet_base_Desert","ASZ_VTG_Stingray_ACH_Helmet_base_Multiland","ASZ_VTG_Stingray_ACH_Helmet_base_Vegecam","ASZ_VTG_Stingray_ACH_Helmet_base_Woodland"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["ASZ_BoonieHat_vegecam"];
	OPEX_friendly_hats_desert = ["ASZ_BoonieHat_desert"];
	OPEX_friendly_hats_snow = ["ASZ_BoonieHat_multiland"];
	OPEX_friendly_leaderHeadgear_woodland = ["ASZ_Basco_CM","ASZ_Basco_CM","ASZ_Cap_SOF"];
	OPEX_friendly_leaderHeadgear_desert = ["ASZ_Basco_CM","ASZ_Basco_CM","ASZ_Cap_SOFdes"];
	OPEX_friendly_leaderHeadgear_snow = ["ASZ_Basco_CM","ASZ_Basco_CM","ASZ_Cap_Alp"];
	OPEX_friendly_berets = ["ASZ_Basco_CM"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["ASZ_ZainoDGT_Medio","ASZ_ZainoDGT_Special","ASZ_ZainoDGT_SOF","ASZ_ZainoGreen_Medio","ASZ_ZainoGreen_SOF","ASZ_ZainoGreen_Special"];
	OPEX_friendly_mediumBackpacks_desert = ["ASZ_ZainoDGT_DES_SOF","ASZ_ZainoDGT_DES_Medio","ASZ_ZainoDGT_DES_Special","ASZ_ZainoDes_Medio","ASZ_ZainoDes_SOF","ASZ_ZainoDes_Special"];
	OPEX_friendly_mediumBackpacks_snow = ["ASZ_ZainoMulti_Medio","ASZ_ZainoMulti_Special","ASZ_ZainoDGT_Medio","ASZ_ZainoDGT_Special","ASZ_ZainoDGT_SOF","ASZ_ZainoGreen_Medio","ASZ_ZainoGreen_SOF","ASZ_ZainoGreen_Special"];
	OPEX_friendly_bigBackpacks_woodland = ["ASZ_ZainoDGT_Grande","ASZ_ZainoGreen_Grande"];
	OPEX_friendly_bigBackpacks_desert = ["ASZ_ZainoDGT_DES_Grande","ASZ_ZainoDes_Grande"];
	OPEX_friendly_bigBackpacks_snow = ["ASZ_ZainoDGT_Grande","ASZ_ZainoGreen_Grande"];
	OPEX_friendly_medicBackpacks_woodland = ["ASZ_ZainoDGT_Medico_base","ASZ_ZainoGreen_Medico_base"];
	OPEX_friendly_medicBackpacks_desert = ["ASZ_ZainoDes_Medico_base","ASZ_ZainoDGT_Des_Medico_base"];
	OPEX_friendly_medicBackpacks_snow = ["ASZ_ZainoMulti_Medico_base","ASZ_ZainoDGT_Medico_base","ASZ_ZainoGreen_Medico_base"];
	OPEX_friendly_radioBackpacks_woodland = ["ASZ_Radio"];
	OPEX_friendly_radioBackpacks_desert = ["ASZ_Radio"];
	OPEX_friendly_radioBackpacks_snow = ["ASZ_Radio"];