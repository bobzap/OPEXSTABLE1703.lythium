// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "r3f_armes"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_Retex"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_Uniformes"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_PVP"))) exitWith {};

// DEFINING FACTION NAMES
_OPEX_friendly_modName = "R3F"; // e.g.: "RHS"
_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // e.g.: "NATO"
_OPEX_friendly_subFaction = "STR_friendly_subFaction_France"; // e.g.; "USA"

// ===============================================================================
// do not edit or delete section below
// ===============================================================================

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

// ===============================================================================
// ===============================================================================

// ARMY NAME
OPEX_friendly_army = localize "STR_friendly_army_france";

// FLAGS
OPEX_friendly_flag_marker = "flag_France";
OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // e.g.: NATO
OPEX_friendly_flag_country = "pictures\flag_france.paa"; // e.g.: USA
OPEX_friendly_flag_army = "pictures\flag_army_france.paa"; // e.g.: Camp Liberty
OPEX_friendly_insigna = "France";

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
OPEX_friendly_transportTrucksOpened_woodland = ["R3F_KAMAZ_CE_trans"];
OPEX_friendly_transportTrucksOpened_desert = ["R3F_KAMAZ_DA_trans"];
OPEX_friendly_transportTrucksOpened_snow = ["R3F_KAMAZ_CE_trans"];
OPEX_friendly_transportTrucksCovered_woodland = ["R3F_KAMAZ_CE_trans"];
OPEX_friendly_transportTrucksCovered_desert = ["R3F_KAMAZ_DA_trans"];
OPEX_friendly_transportTrucksCovered_snow = ["R3F_KAMAZ_CE_trans"];
OPEX_friendly_fuelTrucks_woodland = ["R3F_KAMAZ_CE_fuel"];
OPEX_friendly_fuelTrucks_desert = ["R3F_KAMAZ_DA_fuel"];
OPEX_friendly_fuelTrucks_snow = ["R3F_KAMAZ_CE_fuel"];
OPEX_friendly_logisticTrucks_woodland = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_desert = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_snow = ["B_T_Truck_01_box_F"];
OPEX_friendly_medicalTrucks_woodland = ["R3F_KAMAZ_CE_medevac"];
OPEX_friendly_medicalTrucks_desert = ["R3F_KAMAZ_DA_medevac"];
OPEX_friendly_medicalTrucks_snow = ["R3F_KAMAZ_CE_medevac"];
OPEX_friendly_repairTrucks_woodland = ["B_T_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_desert = ["B_T_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_snow = ["B_T_Truck_01_Repair_F"];
OPEX_friendly_ammoTrucks_woodland = ["B_T_Truck_01_ammo_F"];
OPEX_friendly_ammoTrucks_desert = ["B_T_Truck_01_ammo_F"];
OPEX_friendly_ammoTrucks_snow = ["B_T_Truck_01_ammo_F"];
OPEX_friendly_transportCars_woodland = ["R3F_MATV_CE", "R3F_PVP_CE"];
OPEX_friendly_transportCars_desert = ["R3F_MATV_DA", "R3F_PVP_DA"];
OPEX_friendly_transportCars_snow = ["R3F_MATV_CE", "R3F_PVP_CE"];
OPEX_friendly_combatCarsMG_woodland = ["R3F_MATV_CE_HMG", "R3F_PVP_CE_WASP", "R3F_PVP_CE_WASP_COMMANDEMENT", "R3F_PVP_CE_WASP_EOD"];
OPEX_friendly_combatCarsMG_desert = ["R3F_MATV_DA_HMG", "R3F_PVP_DA_WASP", "R3F_PVP_DA_WASP_COMMANDEMENT", "R3F_PVP_DA_WASP_EOD"];
OPEX_friendly_combatCarsMG_snow = ["R3F_MATV_CE_HMG", "R3F_PVP_CE_WASP", "R3F_PVP_CE_WASP_COMMANDEMENT", "R3F_PVP_CE_WASP_EOD"];
OPEX_friendly_combatCarsGL_woodland = ["R3F_MATV_CE_GMG"];
OPEX_friendly_combatCarsGL_desert = ["R3F_MATV_DA_GMG"];
OPEX_friendly_combatCarsGL_snow = ["R3F_MATV_CE_GMG"];
OPEX_friendly_vtt_woodland = ["R3F_PANDUR_CE"];
OPEX_friendly_vtt_desert = ["R3F_PANDUR_DA"];
OPEX_friendly_vtt_snow = ["R3F_PANDUR_CE"];
OPEX_friendly_tanks_woodland = ["R3F_MBT52_CE"];
OPEX_friendly_tanks_desert = ["R3F_MBT52_DA"];
OPEX_friendly_tanks_snow = ["R3F_MBT52_CE"];
OPEX_friendly_quads_woodland = ["B_Quadbike_01_F"];
OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
OPEX_friendly_quads_snow = ["B_Quadbike_01_F"];
OPEX_friendly_zodiacs = ["B_Boat_Transport_01_F"];
OPEX_friendly_ships = ["B_Boat_Armed_01_minigun_F"];
OPEX_friendly_aircrafts = ["R3F_GRIPEN","R3F_ALCA_ADLA"];
OPEX_friendly_smallCombatHelicopters_woodland = ["R3F_AH6_CE_ARMED"];
OPEX_friendly_smallCombatHelicopters_desert = ["R3F_AH6_DA_ARMED"];
OPEX_friendly_smallCombatHelicopters_snow = ["R3F_AH6_MA_ARMED"];
OPEX_friendly_mediumCombatHelicopters_woodland = ["R3F_LYNX_CE_ARMED"];
OPEX_friendly_mediumCombatHelicopters_desert = ["R3F_LYNX_DA_ARMED"];
OPEX_friendly_mediumCombatHelicopters_snow = ["R3F_LYNX_MA_ARMED"];
OPEX_friendly_smallTransportHelicopters_woodland = ["R3F_AH6_CE"];
OPEX_friendly_smallTransportHelicopters_desert = ["R3F_AH6_DA"];
OPEX_friendly_smallTransportHelicopters_snow = ["R3F_AH6_MA"];
OPEX_friendly_mediumTransportHelicopters_woodland = ["R3F_LYNX_CE"];
OPEX_friendly_mediumTransportHelicopters_desert = ["R3F_LYNX_DA"];
OPEX_friendly_mediumTransportHelicopters_snow = ["R3F_LYNX_MA"];
OPEX_friendly_bigTransportHelicopters_woodland = ["R3F_MERLIN_CE"];
OPEX_friendly_bigTransportHelicopters_desert = ["R3F_MERLIN_DA"];
OPEX_friendly_bigTransportHelicopters_snow = ["R3F_MERLIN_MA"];
OPEX_friendly_UAVs = ["B_UAV_02_dynamicLoadout_F"];
OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_F"];
OPEX_friendly_portableDrones = ["R3F_DLO"];
OPEX_friendly_portableDronesBackpack = ["R3F_DLO_backpack"];
OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
OPEX_friendly_MGstatics = ["B_HMG_01_high_F"];
OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
OPEX_friendly_ATstatics = ["R3F_MMP_STATIC"];
OPEX_friendly_mortarStatics = ["R3F_LGI"];

// WEAPONS
OPEX_friendly_commonHandguns = ["R3F_PAMAS"];
OPEX_friendly_specialHandguns = ["R3F_HKUSP", "R3F_G17"];
OPEX_friendly_commonRifles = ["R3F_Famas_F1"];
OPEX_friendly_specialRifles = ["R3F_Famas_F1_HG", "R3F_Famas_felin", "R3F_Famas_surb", "R3F_Famas_surb_HG", "R3F_Famas_G2", "R3F_Famas_G2_HG", "R3F_HK416S_HG", "R3F_HK416M", "R3F_HK416M_HG", "R3F_HK417S_HG", "R3F_HK417M", "R3F_HK417M_HG", "R3F_HK417L"];
OPEX_friendly_GLrifles = ["R3F_Famas_F1_M203", "R3F_Famas_G2_M203", "R3F_HK416M_M203"];
OPEX_friendly_MGriflesLight = ["R3F_Minimi", "R3F_Minimi_HG"];
OPEX_friendly_MGriflesHeavy = ["R3F_Minimi_762", "R3F_Minimi_762_HG"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["R3F_MP5A5", "R3F_MP5SD", "R3F_SIG551", "R3F_SIG551_CE"];
OPEX_friendly_precisionRifles = ["R3F_FRF2"];
OPEX_friendly_sniperRifles = ["R3F_M107", "R3F_TAC50", "R3F_PGM_Hecate_II", "R3F_PGM_Hecate_II_DES", "R3F_PGM_Hecate_II_POLY"];
OPEX_friendly_ATlaunchers = ["R3F_AT4CS", "R3F_AT4CS", "R3F_ERYX"];
OPEX_friendly_AAlaunchers = ["R3F_STINGER"];
OPEX_friendly_shotguns = ["R3F_M4S90"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["optic_aco", "R3F_EOTECH", "R3F_EOTECH"];
OPEX_friendly_distantCombatOptics = ["optic_MRCO", "optic_hamr", "R3F_AIMPOINT", "R3F_J4", "R3F_AIMPOINT", "R3F_J4"];
OPEX_friendly_sniperOptics = ["optic_DMS", "optic_LRPS", "optic_SOS", "optic_Nightstalker", "optic_tws", "R3F_FELIN", "R3F_FELIN_FRF2", "R3F_NF", "R3F_NF42", "R3F_OB50", "R3F_J8", "R3F_J8_MILDOT", "R3F_J10", "R3F_J10_MILDOT", "R3F_ZEISS"];
OPEX_friendly_flashlights = ["acc_flashlight", "R3F_LAMPE_SURB"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_L", "muzzle_snds_H", "muzzle_snds_B", "R3F_SILENCIEUX_HK416", "R3F_SILENCIEUX_HK417", "R3F_SILENCIEUX_FRF2"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L", "muzzle_snds_acp"];
OPEX_friendly_pointers = ["acc_pointer_IR", "R3F_POINTEUR_SURB"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk", "R3F_BIPIED_HK417"];

// VARIOUS ITEMS
OPEX_friendly_handGrenades = ["HandGrenade"];
OPEX_friendly_smokeGrenades_white = ["SmokeShell"];
OPEX_friendly_smokeGrenades_colors = ["SmokeShellBlue", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed", "SmokeShellGreen", "SmokeShellPurple"];
OPEX_friendly_chemlights = ["Chemlight_blue", "Chemlight_yellow", "Chemlight_red", "Chemlight_green"];
OPEX_friendly_IRs = ["B_IR_Grenade"];
OPEX_friendly_explosives = ["ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", "APERSTripMine_Wire_Mag", "ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"];
OPEX_friendly_NVGs = ["NVGoggles_OPFOR"];
OPEX_friendly_commonBinoculars = ["Binocular"];
OPEX_friendly_spotterBinoculars = ["Rangefinder", "R3F_JIM_LR"];
OPEX_friendly_laserDesignators = ["laserdesignator"];
OPEX_friendly_toolKits = ["ToolKit"];
OPEX_friendly_medikits = ["Medikit"];
OPEX_friendly_mineDetectors = ["MineDetector"];
OPEX_friendly_droneTerminals = ["B_UavTerminal"];
OPEX_friendly_tablets = ["item_R3F_SIT_COMDE"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["R3F_uniform_F1", "R3F_uniform_F1", "R3F_uniform_F1", "R3F_uniform_apso"];
OPEX_friendly_commonUniforms_desert = ["R3F_uniform_F1_DA", "R3F_uniform_F1_DA", "R3F_uniform_F1_DA", "R3F_uniform_apso_DA"];
OPEX_friendly_commonUniforms_snow = ["R3F_uniform_F1_SNOW"];
OPEX_friendly_specialUniforms_woodland = ["R3F_uniform_apso", "R3F_uniform_apso", "R3F_uniform_urr"];
OPEX_friendly_specialUniforms_desert = ["R3F_uniform_apso_DA", "R3F_uniform_apso_DA", "R3F_uniform_urr_DA"];
OPEX_friendly_specialUniforms_snow = ["R3F_uniform_urr_SNOW"];
OPEX_friendly_ghillieUniforms_woodland = ["R3F_uniform_Ghillie", "R3F_uniform_GhillieFULL", "R3F_uniform_Ghillie_MFO", "R3F_uniform_GhillieFULL_MFO"];
OPEX_friendly_ghillieUniforms_desert = ["R3F_uniform_Ghillie_DA", "R3F_uniform_GhillieFULL_DA"];
OPEX_friendly_ghillieUniforms_snow = ["R3F_uniform_Ghillie_SNOW", "R3F_uniform_GhillieFULL_SNOW"];
OPEX_friendly_heliPilotUniforms_woodland = ["R3F_uniform_piheli"];
OPEX_friendly_heliPilotUniforms_desert = ["R3F_uniform_piheli_DA"];
OPEX_friendly_heliPilotUniforms_snow = ["R3F_uniform_piheli"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["R3F_uniform_pilot"];
OPEX_friendly_aircraftPilotUniforms_desert = ["R3F_uniform_pilot"];
OPEX_friendly_aircraftPilotUniforms_snow = ["R3F_uniform_pilot"];
OPEX_friendly_tankPilotUniforms_woodland = ["R3F_uniform_pilot"];
OPEX_friendly_tankPilotUniforms_desert = ["R3F_uniform_pilot"];
OPEX_friendly_tankPilotUniforms_snow = ["R3F_uniform_pilot"];
OPEX_friendly_medicUniforms_woodland = ["R3F_uniform_f1_medic", "R3F_uniform_f1_medic", "R3F_uniform_f1_medic", "R3F_uniform_urr_medic"];
OPEX_friendly_medicUniforms_desert = ["R3F_uniform_f1_medic_DA", "R3F_uniform_f1_medic_DA", "R3F_uniform_f1_medic_DA", "R3F_uniform_urr_medic_DA"];
OPEX_friendly_medicUniforms_snow = ["R3F_uniform_F1_medic_SNOW", "R3F_uniform_F1_medic_SNOW", "R3F_uniform_F1_medic_SNOW", "R3F_uniform_urr_medic_SNOW"];
OPEX_friendly_instructorUniforms_woodland = ["R3F_uniform_off"];
OPEX_friendly_instructorUniforms_desert = ["R3F_uniform_off_DA"];
OPEX_friendly_instructorUniforms_snow = ["R3F_uniform_F1_SNOW"];
OPEX_friendly_tshirtUniforms_woodland = ["R3F_uniform_apso"];
OPEX_friendly_tshirtUniforms_desert = ["R3F_uniform_apso_DA", "R3F_uniform_urr_DA"];
OPEX_friendly_tshirtUniforms_snow = ["R3F_uniform_F1_SNOW"];
OPEX_friendly_diverUniforms = ["R3F_uniform_diver"];

// VESTS
OPEX_friendly_commonVests_woodland = ["R3F_veste_APSO_CE", "R3F_veste_APSO", "R3F_veste_ce300"];
OPEX_friendly_commonVests_desert = ["R3F_veste_APSO_TAN", "R3F_veste_APSO", "R3F_veste_TAN"];
OPEX_friendly_commonVests_snow = ["R3F_veste_SNOW"];
OPEX_friendly_specialVests = ["R3F_veste_ce300", "R3F_veste_ce600", "R3F_veste_ce600", "R3F_veste_noire", "R3F_vestetactique_noire"];
OPEX_friendly_beltVests = ["V_Rangemaster_belt"];
OPEX_friendly_shoulderVests = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests = ["V_HarnessO_brn", "V_HarnessO_gry"];
OPEX_friendly_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_gry"];
OPEX_friendly_EODvests = ["R3F_veste_APSO_EOD"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

/*
OPEX_friendly_commonVests_woodland = [];
OPEX_friendly_commonVests_desert = [];
OPEX_friendly_commonVests_snow = [];
OPEX_friendly_specialVests_woodland = [];
OPEX_friendly_specialVests_desert = [];
OPEX_friendly_specialVests_snow = [];
OPEX_friendly_medicVests_woodland = [];
OPEX_friendly_medicVests_desert = [];
OPEX_friendly_medicVests_snow = [];
OPEX_friendly_beltVests_woodland = [];
OPEX_friendly_beltVests_desert = [];
OPEX_friendly_beltVests_snow = [];
OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_snow = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests_woodland = [];
OPEX_friendly_lightVests_desert = [];
OPEX_friendly_lightVests_snow = [];
OPEX_friendly_grenadierVests_woodland = [];
OPEX_friendly_grenadierVests_desert = [];
OPEX_friendly_grenadierVests_snow =[];
OPEX_friendly_EODvests_woodland = [];
OPEX_friendly_EODvests_desert = [];
OPEX_friendly_EODvests_snow = [];
OPEX_friendly_diverVests = ["V_RebreatherB"];
*/

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["R3F_casque_spectra", "R3F_casque_spectra_bleu", "R3F_casque_spectra_jaune", "R3F_casque_spectra_orange", "R3F_casque_spectra_vert", "R3F_casque_spectra_violet"];
OPEX_friendly_commonHelmets_desert = ["R3F_casque_spectra_DA", "R3F_casque_spectra_DA_bleu", "R3F_casque_spectra_DA_jaune", "R3F_casque_spectra_DA_orange", "R3F_casque_spectra_DA_vert", "R3F_casque_spectra_DA_violet"];
OPEX_friendly_commonHelmets_snow = ["R3F_casque_spectra_SNOW"];
OPEX_friendly_specialHelmets_woodland = ["R3F_casqueFS_noir", "R3F_casqueFS_olive", "R3F_casqueFS_MFO"];
OPEX_friendly_specialHelmets_desert = ["R3F_casqueFS_noir", "R3F_casqueFS_olive", "R3F_casqueFS_tan", "R3F_casqueFS_tan"];
OPEX_friendly_specialHelmets_snow = ["R3F_casqueFS_SNOW"];
OPEX_friendly_EODhelmets_woodland = ["R3F_casque_spectra_EOD"];
OPEX_friendly_EODhelmets_desert = ["R3F_casque_spectra_EOD_DA"];
OPEX_friendly_EODhelmets_snow = ["R3F_casque_spectra_EOD"];
OPEX_friendly_heliPilotHelmets = ["R3F_casque_pilote_heli"];
OPEX_friendly_aircraftPilotHelmets = ["R3F_casque_pilote"];
OPEX_friendly_tankCrewHelmets = ["R3F_casque_equipage"];
OPEX_friendly_cameraHelmets_woodland = ["R3F_casqueFS_noir", "R3F_casqueFS_olive", "R3F_casqueFS_MFO"];
OPEX_friendly_cameraHelmets_desert = ["R3F_casqueFS_noir", "R3F_casqueFS_olive", "R3F_casqueFS_tan", "R3F_casqueFS_tan", "R3F_casqueFS_tan"];
OPEX_friendly_cameraHelmets_snow = ["R3F_casqueFS_SNOW"];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
OPEX_friendly_hats_woodland = ["H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "R3F_chapeaubrousse_CE", "R3F_chapeaubrousse_CE", "R3F_chapeaubrousse_CE", "R3F_chapeaubrousse_MFO"];
OPEX_friendly_hats_desert = ["H_Booniehat_tan", "R3F_chapeaubrousse_TAN"];
OPEX_friendly_hats_snow = ["H_Booniehat_khk", "H_Booniehat_oli", "R3F_chapeaubrousse_CE"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk", "R3F_Bonnet", "R3F_Bonnet_vert"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk", "R3F_Bonnet", "R3F_Bonnet_vert"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk", "R3F_bonnet_SNOW", "R3F_bonnet_SNOW", "R3F_bonnet_SNOW", "R3F_bonnet_SNOW", "R3F_bonnet_SNOW"];
OPEX_friendly_berets = ["R3F_beret", "R3F_beret", "R3F_beret", "R3F_beret_para", "R3F_beret_commando", "R3F_beret_alat"];
OPEX_friendly_caps = ["H_Cap_tan", "H_Cap_blk", "H_Cap_blk", "H_Cap_blk", "H_Cap_oli", "H_Cap_oli", "H_Cap_grn"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F"];
OPEX_friendly_leaderHeadgear_woodland = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_woodland;
OPEX_friendly_leaderHeadgear_desert = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_desert;
OPEX_friendly_leaderHeadgear_snow = OPEX_friendly_berets + OPEX_friendly_caps + OPEX_friendly_specialHelmets_snow;

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli", "R3F_cagoule_noire", "R3F_cagoule_olive", "R3F_cagoule_tan"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Squares", "G_Combat", "R3F_lunettes_X800", "R3F_lunettes_ESS"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];
if (isClass (configFile >> "CfgPatches" >> "rhsusf_main")) then {OPEX_friendly_glasses append ["R3F_lunettes_X800", "R3F_lunettes_ESS", "rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw"]; OPEX_friendly_sunglasses append ["rhs_googles_black"]};

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr", "R3F_sac_moyen_CE", "R3F_sac_moyen_CE", "R3F_sac_moyen_CE", "R3F_sac_moyen_CE", "R3F_sac_moyen_CE", "R3F_sac_moyen_CE", "R3F_sac_moyen_noir", "R3F_sac_petit_CE", "R3F_sac_petit_CE", "R3F_sac_petit_CE", "R3F_sac_petit_noir"];
OPEX_friendly_mediumBackpacks_desert = ["B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_AssaultPack_ocamo", "B_TacticalPack_ocamo", "R3F_sac_moyen_TAN", "R3F_sac_moyen_TAN", "R3F_sac_moyen_TAN", "R3F_sac_moyen_TAN", "R3F_sac_moyen_TAN", "R3F_sac_moyen_TAN", "R3F_sac_moyen_noir", "R3F_sac_petit_TAN", "R3F_sac_petit_TAN", "R3F_sac_petit_TAN", "R3F_sac_petit_noir"];
OPEX_friendly_mediumBackpacks_snow = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_SNOW", "R3F_sac_moyen_noir", "R3F_sac_petit_SNOW", "R3F_sac_petit_SNOW", "R3F_sac_petit_SNOW", "R3F_sac_petit_noir"];
OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_cbr", "B_Carryall_khk", "R3F_sac_lourd_noir", "R3F_sac_lourd_CE", "R3F_sac_lourd_CE", "R3F_sac_lourd_CE", "R3F_sac_vie_OD"];
OPEX_friendly_bigBackpacks_desert = ["B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_cbr", "B_Carryall_cbr", "B_Carryall_khk", "R3F_sac_lourd_noir", "R3F_sac_lourd_TAN", "R3F_sac_lourd_TAN", "R3F_sac_lourd_TAN", "R3F_sac_lourd_TAN", "R3F_sac_vie_TAN"];
OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo", "B_Carryall_oucamo", "R3F_sac_lourd_noir", "R3F_sac_lourd_SNOW", "R3F_sac_lourd_SNOW", "R3F_sac_lourd_SNOW", "R3F_sac_vie_SNOW"];
OPEX_friendly_medicBackpacks_woodland = ["R3F_sac_moyen_medic_noir", "R3F_sac_moyen_medic_CE", "R3F_sac_moyen_medic_CE", "R3F_sac_moyen_medic_CE"];
OPEX_friendly_medicBackpacks_desert = ["R3F_sac_moyen_medic_noir", "R3F_sac_moyen_medic_TAN", "R3F_sac_moyen_medic_TAN", "R3F_sac_moyen_medic_TAN"];
OPEX_friendly_medicBackpacks_snow = ["R3F_sac_moyen_medic_noir", "R3F_sac_moyen_medic_noir", "R3F_sac_moyen_medic_noir", "R3F_sac_moyen_medic_CE"];
OPEX_friendly_radioBackpacks_woodland = ["R3F_sac_radio_TFR_Lourd_CE"];
OPEX_friendly_radioBackpacks_desert = ["R3F_sac_radio_TFR_Lourd_TAN"];
OPEX_friendly_radioBackpacks_snow = ["R3F_sac_radio_TFR_Lourd_SNOW"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];