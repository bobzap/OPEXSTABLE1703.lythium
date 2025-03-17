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
	 - Tip: if you want to increase the probability of usage of a specific item, list it several times (example: OPEX_exampleArray = ["myCustomData1", "myCustomData1", "myCustomData1", ""myCustomData2"] means that "myCustomData1" has 3 times more chances to be used than "myCustomData2")
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

	if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Mod"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Characters"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Weapons"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "qin_titus"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "vehicules"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "Uniforme"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "AMF_Uniforms"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "AMF_vests"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "OFrP + FAF + AMF"; // mod name (example: "myCustomMod")
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
	OPEX_friendly_army = localize "STR_friendly_army_france";

	// FLAGS
	OPEX_friendly_flag_marker = "flag_France";
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // e.g.: NATO
	OPEX_friendly_flag_country = "pictures\flag_france.paa"; // e.g.: USA
	OPEX_friendly_flag_army = "pictures\flag_army_france.paa"; // e.g.: Camp Liberty
	OPEX_friendly_insigna = "NATO";

	// CAMP
	OPEX_friendly_camp = "Camp Lugdunum";
	OPEX_sign_camp = "pictures\sign_camp_fr.paa";

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

	// AI SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["french_01", "french_02", "french_03", "french_04", "french_05", "french_06", "french_07", "french_08", "french_09", "french_10", "french_11", "french_12", "french_13", "french_14", "french_15", "french_16", "french_17", "french_18", "french_19", "french_20", "french_21", "french_22", "french_23", "french_24", "french_25", "french_26", "french_27", "french_28", "french_29", "french_30", "french_31", "french_32", "french_33", "french_34", "french_35", "french_36", "french_37", "french_38", "french_39", "french_40", "french_41", "french_42", "french_43", "french_44", "french_45", "french_46", "french_47", "french_48", "french_49", "french_50", "french_51", "french_52", "french_53", "french_54", "french_55", "french_56", "french_57", "french_58", "french_59", "french_60", "french_61", "french_62", "french_63", "french_64", "french_65", "french_66", "french_67", "french_68", "french_69", "french_70"];

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["ML_Truck_01_Transport"];
	OPEX_friendly_transportTrucksOpened_desert = ["ML_Truck_01_Transport"];
	OPEX_friendly_transportTrucksOpened_snow = ["ML_Truck_01_Transport"];
	OPEX_friendly_transportTrucksCovered_woodland = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_transportTrucksCovered_desert = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_transportTrucksCovered_snow = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_fuelTrucks_woodland = ["ML_Truck_01_Fuel"];
	OPEX_friendly_fuelTrucks_desert = ["ML_Truck_01_Fuel"];
	OPEX_friendly_fuelTrucks_snow = ["ML_Truck_01_Fuel"];
	OPEX_friendly_logisticTrucks_woodland = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_logisticTrucks_desert = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_logisticTrucks_snow = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_medicalTrucks_woodland = ["ML_Truck_01_Transport_medic_F"];
	OPEX_friendly_medicalTrucks_desert = ["ML_Truck_01_Transport_medic_F"];
	OPEX_friendly_medicalTrucks_snow = ["ML_Truck_01_Transport_medic_F"];
	OPEX_friendly_repairTrucks_woodland = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_desert = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_snow = ["ML_Truck_01_Repair_F"];
	OPEX_friendly_ammoTrucks_woodland = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_ammoTrucks_desert = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_ammoTrucks_snow = ["ML_Truck_01_Covered_F"];
	OPEX_friendly_transportCars_woodland = ["ML_MRAP_01_F", "ML_Offroad_01", "ML_Offroad_01_comms"];
	OPEX_friendly_transportCars_desert = ["ML_MRAP_01_F", "ML_Offroad_01", "ML_Offroad_01_comms"];
	OPEX_friendly_transportCars_snow = ["ML_MRAP_01_F", "ML_Offroad_01", "ML_Offroad_01_comms"];
	OPEX_friendly_combatCarsMG_woodland = ["ML_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsMG_desert = ["ML_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsMG_snow = ["ML_MRAP_01_hmg_F"];
	OPEX_friendly_combatCarsGL_woodland = ["ML_MRAP_01_gmg_F"];
	OPEX_friendly_combatCarsGL_desert = ["ML_MRAP_01_gmg_F"];
	OPEX_friendly_combatCarsGL_snow = ["ML_MRAP_01_gmg_F"];
	OPEX_friendly_vtt_woodland = ["B_AMF_VAB_ULTIMA_X8_F","B_AMF_VAB_ULTIMA_TOP_X8_F", "ML_Titus_armed"];
	OPEX_friendly_vtt_desert = ["B_AMF_VAB_ULTIMA_X8_F","B_AMF_VAB_ULTIMA_TOP_X8_F", "ML_Titus_armed"];
	OPEX_friendly_vtt_snow = ["B_AMF_VAB_ULTIMA_X8_F","B_AMF_VAB_ULTIMA_TOP_X8_F", "ML_Titus_armed"];
	OPEX_friendly_tanks_woodland = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
	OPEX_friendly_tanks_desert = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
	OPEX_friendly_tanks_snow = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
	OPEX_friendly_quads_woodland = ["ML_Quadbike_01_F"];
	OPEX_friendly_quads_desert = ["ML_Quadbike_01_F"];
	OPEX_friendly_quads_snow = ["ML_Quadbike_01_F"];
	OPEX_friendly_zodiacs = ["ML_Boat_Transport_01", "ML_Boat_Transport_01_F"];
	OPEX_friendly_ships = ["ML_Boat_03_marine", "ML_rhib_marine", "ML_Boat_Armed_01_minigun_F"];
	OPEX_friendly_aircrafts = ["B_AMF_PLANE_FIGHTER_01_F","B_AMF_PLANE_FIGHTER_02_F", "ML_Gryphon_air", "ML_Gryphon_marin"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["ML_Heli_light_03_ALAT"];
	OPEX_friendly_smallCombatHelicopters_desert = ["ML_Heli_light_03_ALAT"];
	OPEX_friendly_smallCombatHelicopters_snow = ["ML_Heli_light_03_ALAT"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["ML_Heli_blackfoot_01"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["ML_Heli_blackfoot_01"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["ML_Heli_blackfoot_01"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["ML_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_desert = ["ML_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_snow = ["ML_Heli_Light_01_F"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_bigTransportHelicopters_desert = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_bigTransportHelicopters_snow = ["B_AMF_Heli_Transport_01_F"];
	OPEX_friendly_UAVs = ["ML_UAV_02_UAS", "ML_UAV_02_CAS"];
	OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_F"];
	OPEX_friendly_portableDrones = ["B_UAV_01_F"];
	OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
	OPEX_friendly_MGstatics = ["OFrP_V_AANF1_Static"];
	OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
	OPEX_friendly_ATstatics = ["B_Static_AT_F"];
	OPEX_friendly_mortarStatics = ["ML_2b14_82", "ML_Mortar"];

// WEAPONS
OPEX_friendly_commonHandguns = ["OFrP_PAMAS"];
OPEX_friendly_specialHandguns = ["OFrP_Glock17_Gen4"];
OPEX_friendly_commonRifles = ["OFrP_FAMAS_F1"];
OPEX_friendly_specialRifles = ["OFrP_FAMAS_FELIN","OFrP_FAMAS_VAL","OFrP_HK416F_C","OFrP_HK416F_S"];
OPEX_friendly_GLrifles = ["OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_VAL_GLM203","OFrP_HK416F_C_HK269","OFrP_HK416F_S_HK269","OFrP_HK417A1_20"];
OPEX_friendly_MGriflesLight = ["OFrP_Minimi_Para_556"];
OPEX_friendly_MGriflesHeavy = ["OFrP_Minimi_Para_762"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
OPEX_friendly_compactRifles = ["AMF_614_short_ag_01_F", "AMF_614_short_vg_01_F"];
OPEX_friendly_precisionRifles = ["OFrP_FRF2"];
OPEX_friendly_sniperRifles = ["OFrP_PGM_Hecate2"];
OPEX_friendly_ATlaunchers = ["OFrP_AT4CS","OFrP_AT4CS","OFrP_ERYX"];
OPEX_friendly_AAlaunchers = ["launch_B_Titan_olive_F"];
OPEX_friendly_shotguns = ["AMF_614_short_vg_01_F"];
//OPEX_friendly_diverRifles = [];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics append ["OFrP_OpticItem_EOTech_552","AMF_Eotech_552","AMF_EOTECH_553","AMF_Aimpoint_Pro_Patrol","AMF_Red_Dot_Sight"];
OPEX_friendly_distantCombatOptics append ["OFrP_OpticItem_AIMPoint_CompM2M68","OFrP_EOTech_Magnifier_UP","OFrP_OpticItem_Scrome_J4_Famas","AMF_Aimpoint_Pro_Patrol"];
OPEX_friendly_sniperOptics append ["OFrP_OpticItem_SwordTD","OFrP_OpticItem_Scrome_J10","OFrP_OpticItem_Scrome_J8"];
OPEX_friendly_flashlights append ["AMF_M952_VBK_black"];
OPEX_friendly_rifleSilencers append ["muzzle_snds_L", "muzzle_snds_H", "muzzle_snds_B", "muzzle_snds_M"];
//OPEX_friendly_handgunSilencers append [];
OPEX_friendly_pointers append ["OFrP_pointer_PIRAT_EL9A","OFrP_pointer_PIRAT_EL9B","AMF_AN_PEQ_15_black","AMF_LASER_PIRATE"];
OPEX_friendly_bipods append ["ofrp_acc_grip1", "bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk"];

// VARIOUS ITEMS
OPEX_friendly_NVGs = ["OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie_Mask","OFrP_OVD"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV","OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_commonUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV"];
OPEX_friendly_commonUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_specialUniforms_woodland = ["OFrP_Uniform_T4S2_UBAS_CE01_FRHV_SDTBV"];
OPEX_friendly_specialUniforms_desert = ["OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_UBAS_DA01_FRHV_SDTBV","OFrP_Uniform_T4S2_UBAS_SE01_FRHV_SDTBV"];
OPEX_friendly_specialUniforms_snow = ["OFrP_Uniform_T4S2_UBAS_CE01_FRHV_SDTBV"];
OPEX_friendly_ghillieUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_ghillieUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_ghillieUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_heliPilotUniforms_woodland = ["ML_Uniform_pilot_marine", "ML_Uniform_pilot_marine_blue", "ML_Uniform_pilot", "ML_Uniform_meca", "ML_Uniform_pilote_alat", "ML_Uniform_meca_alat", "ML_Uniform_pilote_caracal", "ML_Uniform_pilote_caracal_des"];
OPEX_friendly_heliPilotUniforms_desert = ["ML_Uniform_pilot_marine", "ML_Uniform_pilot_marine_blue", "ML_Uniform_pilot", "ML_Uniform_meca", "ML_Uniform_pilote_alat", "ML_Uniform_meca_alat", "ML_Uniform_pilote_caracal", "ML_Uniform_pilote_caracal_des"];
OPEX_friendly_heliPilotUniforms_snow = ["ML_Uniform_pilot_marine", "ML_Uniform_pilot_marine_blue", "ML_Uniform_pilot", "ML_Uniform_meca", "ML_Uniform_pilote_alat", "ML_Uniform_meca_alat", "ML_Uniform_pilote_caracal", "ML_Uniform_pilote_caracal_des"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["ML_Uniform_meca_air", "ML_Uniform_pilote_casa", "ML_Uniform_pilote_casa_des", "ML_Uniform_pilote_chasse", "ML_Uniform_pilote_chasse_des", "ML_Uniform_pilote_chasse_02", "ML_Uniform_pilote_chasse_02_des"];
OPEX_friendly_aircraftPilotUniforms_desert = ["ML_Uniform_meca_air", "ML_Uniform_pilote_casa", "ML_Uniform_pilote_casa_des", "ML_Uniform_pilote_chasse", "ML_Uniform_pilote_chasse_des", "ML_Uniform_pilote_chasse_02", "ML_Uniform_pilote_chasse_02_des"];
OPEX_friendly_aircraftPilotUniforms_snow = ["ML_Uniform_meca_air", "ML_Uniform_pilote_casa", "ML_Uniform_pilote_casa_des", "ML_Uniform_pilote_chasse", "ML_Uniform_pilote_chasse_des", "ML_Uniform_pilote_chasse_02", "ML_Uniform_pilote_chasse_02_des"];
OPEX_friendly_tankPilotUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_tankPilotUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV"];
OPEX_friendly_tankPilotUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_medicUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_medicUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV"];
OPEX_friendly_medicUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_instructorUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_instructorUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV"];
OPEX_friendly_instructorUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_tshirtUniforms_woodland = ["OFrP_Uniform_T4S2_UBAS_CE01_FRHV_SDTBV"];
OPEX_friendly_tshirtUniforms_desert = ["OFrP_Uniform_T4S2_UBAS_DA01_FRHV_SDTBV"];
OPEX_friendly_tshirtUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_diverUniforms = ["ML_Uniform_pull","ML_Uniform_combat_02_lg","ML_Uniform_combat_02", "ML_Uniform_combat_FR", "ML_Uniform_repos_alat_sergentchef", "ML_Uniform_repos_adjudantchef"];

// VESTS
OPEX_friendly_commonVests_woodland = ["OFrP_Vest_CIRAS_Rifleman_MJK","OFrP_Vest_CIRAS_Rifleman_OD","OFrP_Vest_S3_CE","OFrP_Vest_SMB_Kaki"];
OPEX_friendly_commonVests_desert = ["OFrP_Vest_CIRAS_Rifleman_CB","OFrP_Vest_S3_DA","OFrP_Vest_SMB_CB","OFrP_Vest_SMB_Rifleman_CB","OFrP_Vest_SMB_Rifleman_Kaki"];
OPEX_friendly_commonVests_snow = ["OFrP_Vest_CIRAS_Rifleman_MJK","OFrP_Vest_CIRAS_Rifleman_OD","OFrP_Vest_S3_CE","OFrP_Vest_SMB_Kaki"];
OPEX_friendly_specialVests_woodland = ["OFrP_Vest_CIRAS_TeamLeader_MJK","OFrP_Vest_CIRAS_TeamLeader_OD","OFrP_Vest_CIRAS_Marksman1_MJK","OFrP_Vest_CIRAS_Marksman1_OD","OFrP_Vest_CIRAS_MachineGunner_MJK","OFrP_Vest_CIRAS_MachineGunner_OD","OFrP_Vest_SMB_MachineGunner_Kaki","OFrP_Vest_SMB_Marksman1_Kaki"];
OPEX_friendly_specialVests_desert = ["OFrP_Vest_CIRAS_TeamLeader_CB","OFrP_Vest_CIRAS_Marksman1_CB","OFrP_Vest_CIRAS_MachineGunner_CB","OFrP_Vest_SMB_Teamleader_CB","OFrP_Vest_SMB_MachineGunner_CB","OFrP_Vest_SMB_Marksman1_CB"];
OPEX_friendly_specialVests_snow = ["OFrP_Vest_CIRAS_TeamLeader_MJK","OFrP_Vest_CIRAS_TeamLeader_OD","OFrP_Vest_CIRAS_Marksman1_MJK","OFrP_Vest_CIRAS_Marksman1_OD","OFrP_Vest_CIRAS_MachineGunner_MJK","OFrP_Vest_CIRAS_MachineGunner_OD","OFrP_Vest_SMB_MachineGunner_Kaki","OFrP_Vest_SMB_Marksman1_Kaki"];
OPEX_friendly_medicVests_woodland = ["OFrP_Vest_CIRAS_Medic_MJK","OFrP_Vest_CIRAS_Medic_OD","OFrP_Vest_SMB_Medic_Kaki"];
OPEX_friendly_medicVests_desert = ["OFrP_Vest_CIRAS_Medic_CB","OFrP_Vest_SMB_Medic_CB"];
OPEX_friendly_medicVests_snow = ["OFrP_Vest_CIRAS_Medic_MJK","OFrP_Vest_CIRAS_Medic_OD","OFrP_Vest_SMB_Medic_Kaki"];
OPEX_friendly_shoulderVests_woodland = ["OFrP_Vest_CIRAS_Marksman2_MJK","OFrP_Vest_CIRAS_Marksman2_OD","OFrP_Vest_SMB_Marksman2_Kaki"];
OPEX_friendly_shoulderVests_desert = ["OFrP_Vest_CIRAS_Marksman2_CB","OFrP_Vest_SMB_Marksman2_CB"];
OPEX_friendly_shoulderVests_snow = ["OFrP_Vest_CIRAS_Marksman2_MJK","OFrP_Vest_CIRAS_Marksman2_OD","OFrP_Vest_SMB_Marksman2_Kaki"];
OPEX_friendly_lightVests_woodland = ["OFrP_Vest_CIRAS_MJK","OFrP_Vest_CIRAS_OD","OFrP_Vest_S3_CE"];
OPEX_friendly_lightVests_desert = ["OFrP_Vest_CIRAS_CB","OFrP_Vest_S3_DA","OFrP_Vest_SMB_CB","OFrP_Vest_SMB_Kaki"];
OPEX_friendly_lightVests_snow = ["OFrP_Vest_CIRAS_MJK","OFrP_Vest_CIRAS_OD","OFrP_Vest_S3_CE"];
OPEX_friendly_grenadierVests_woodland = ["OFrP_Vest_CIRAS_Grenadier_MJK","OFrP_Vest_CIRAS_Grenadier_OD","OFrP_Vest_SMB_Grenadier_Kaki"];
OPEX_friendly_grenadierVests_desert = ["OFrP_Vest_CIRAS_Grenadier_CB","OFrP_Vest_SMB_Grenadier_CB"];
OPEX_friendly_grenadierVests_snow = ["OFrP_Vest_CIRAS_Grenadier_MJK","OFrP_Vest_CIRAS_Grenadier_OD","OFrP_Vest_SMB_Grenadier_Kaki"];
OPEX_friendly_EODvests_woodland = ["OFrP_Vest_S3_Full_CE"];
OPEX_friendly_EODvests_desert = ["OFrP_Vest_S3_Full_DA"];
OPEX_friendly_EODvests_snow = ["OFrP_Vest_S3_Full_CE"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["OFrP_Helmet_Spectra_01_CE","OFrP_Helmet_Spectra_02_CE","OFrP_Helmet_Spectra_01_ESSCOVER_CE","OFrP_Helmet_Spectra_02_ESSCOVER_CE"];
OPEX_friendly_commonHelmets_desert = ["OFrP_Helmet_Spectra_01_DA","OFrP_Helmet_Spectra_02_DA","OFrP_Helmet_Spectra_01_ESSCOVER_DA","OFrP_Helmet_Spectra_02_ESSCOVER_DA"];
OPEX_friendly_commonHelmets_snow = ["OFrP_Helmet_Spectra_01_CE","OFrP_Helmet_Spectra_02_CE","OFrP_Helmet_Spectra_01_ESSCOVER_CE","OFrP_Helmet_Spectra_02_ESSCOVER_CE"];
OPEX_friendly_specialHelmets_woodland = ["OFrP_Helmet_FELIN_CE","OFrP_Helmet_FELIN_ESSCOVER_CE","OFrP_Helmet_TC3000_cover_CE","OFrP_Helmet_TC3000_OD","OFrP_Helmet_TC3000_cover_ESSCOVER_CE","OFrP_Helmet_TC3000_ESSCOVER_OD","H_HelmetSpecB"];
OPEX_friendly_specialHelmets_desert = ["OFrP_Helmet_FELIN_TAN","OFrP_Helmet_FELIN_ESSCOVER_TAN","OFrP_Helmet_TC3000_cover_DA","OFrP_Helmet_TC3000_TAN","OFrP_Helmet_TC3000_cover_ESSCOVER_DA","OFrP_Helmet_TC3000_ESSCOVER_TAN","H_HelmetSpecB_sand"];
OPEX_friendly_specialHelmets_snow = ["OFrP_Helmet_FELIN_CE","OFrP_Helmet_FELIN_ESSCOVER_CE","OFrP_Helmet_TC3000_cover_CE","OFrP_Helmet_TC3000_OD","OFrP_Helmet_TC3000_cover_ESSCOVER_CE","OFrP_Helmet_TC3000_ESSCOVER_OD","H_HelmetSpecB"];
OPEX_friendly_heliPilotHelmets = ["ML_cap_pilot_caracal_ops", "ML_cap_pilot_caracal_ops_des", "ML_Casque_Pilote_Heli_marine", "ML_Pilot_Helmet_Heli", "ML_Pilot_Helmet_Heli_02"];
OPEX_friendly_aircraftPilotHelmets = ["ML_cap_pilot_casa_ops", "ML_cap_meca_ops", "ML_Pilot_helmet"];
OPEX_friendly_tankCrewHelmets = ["ML_casque_equipage_des", "ML_casque_equipage_cav", "ML_casque_equipage"];
OPEX_friendly_hats_woodland = ["OFrP_Hat_Bob_CE","ML_booniehat"];
OPEX_friendly_hats_desert = ["OFrP_Hat_Bob_DA","ML_booniehat"];
OPEX_friendly_hats_snow = ["OFrP_Hat_Bob_CE","ML_booniehat"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_berets = ["OFrP_Hat_Beret_TDM","OFrP_Hat_Beret_Train","OFrP_Hat_Beret_1RHC","OFrP_Hat_Beret_3RHC","OFrP_Hat_Beret_5RHC","OFrP_Hat_Beret_4CCT","OFrP_Hat_Beret_1RA","OFrP_Hat_Beret_68RAA","OFrP_Hat_Beret_11RAMA","OFrP_Hat_Beret_1RC","OFrP_Hat_Beret_3RG","OFrP_Hat_Beret_6RG","OFrP_Hat_Beret_5RD","OFrP_Hat_Beret_7CCT","OFrP_Hat_Beret_9CCTMA","OFrP_Hat_Beret_1RI","OFrP_Hat_Beret_24RI","OFrP_Hat_Beret_35RI","OFrP_Hat_Beret_92RI","OFrP_Hat_Beret_126RI","OFrP_Hat_Beret_152RI","OFrP_Hat_Beret_1RCP","OFrP_Hat_Beret_16BC","OFrP_Hat_Beret_1RPIMA","OFrP_Hat_Beret_2RPIMA","OFrP_Hat_Beret_3RPIMA","OFrP_Hat_Beret_6RPIMA","OFrP_Hat_Beret_8RPIMA","OFrP_Hat_Beret_1RHP","OFrP_Hat_Beret_2RH","OFrP_Hat_Beret_3RH","OFrP_Hat_Beret_CM","OFrP_Hat_Beret_Legion","OFrP_Hat_Beret_CPA"];
OPEX_friendly_caps = ["ML_kepi","ML_fieldcap","ML_fieldcap_02", "ML_fieldcap_03", "ML_cap_marine", "ML_cap_coma", "ML_cap", "ML_cap_green", "ML_cap_des"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets append ["H_Cap_oli_hs", "ML_cap_ops"];
OPEX_friendly_leaderHeadgear_woodland = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_woodland;
OPEX_friendly_leaderHeadgear_desert = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_desert;
OPEX_friendly_leaderHeadgear_snow = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_snow;

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli", "G_Balaclava_oli", "G_Balaclava_oli", "ML_balaclava_camo", "ML_balaclava_des", "ML_balaclava_marine", "ML_balaclava_od"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Squares", "G_Combat"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];
if (isClass (configFile >> "CfgPatches" >> "rhsusf_main")) then {OPEX_friendly_glasses append ["rhsusf_oakley_goggles_blk","rhsusf_oakley_goggles_clr","rhsusf_oakley_goggles_ylw","rhsusf_oakley_goggles_blk","rhsusf_oakley_goggles_clr","rhsusf_oakley_goggles_ylw"]; OPEX_friendly_sunglasses append ["rhs_googles_black","rhs_googles_black","rhs_googles_black","rhs_googles_black","rhs_googles_black"]};

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_rgr","B_AssaultPack_blk","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_mediumBackpacks_desert = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_cbr","B_Kitbag_cbr","B_Kitbag_tan","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN"];
OPEX_friendly_mediumBackpacks_snow = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_rgr","B_AssaultPack_blk","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_bigBackpacks_woodland = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_oli"];
OPEX_friendly_bigBackpacks_desert = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_cbr"];
OPEX_friendly_bigBackpacks_snow = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_oli"];
OPEX_friendly_medicBackpacks_woodland = OPEX_friendly_mediumBackpacks_woodland;
OPEX_friendly_medicBackpacks_desert = OPEX_friendly_mediumBackpacks_desert;
OPEX_friendly_medicBackpacks_snow = OPEX_friendly_mediumBackpacks_snow;
OPEX_friendly_radioBackpacks_woodland = ["OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","ML_LR_Radio","ML_B_Radiobag_01","ML_B_Radiobag_03"];
OPEX_friendly_radioBackpacks_desert = ["OFrP_Bag_Felin_45L_Radio","ML_B_Radiobag_02"];
OPEX_friendly_radioBackpacks_snow = ["OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","ML_LR_Radio","ML_B_Radiobag_01","ML_B_Radiobag_03"];