// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "rhs_main"))) exitWith {};

// NAMES
_OPEX_friendly_modName = "RHS"; // e.g.: "RHS"
_OPEX_friendly_factionName = "STR_friendly_mainFaction_RU"; // e.g.: "NATO"
_OPEX_friendly_subFaction = "STR_friendly_subFaction_Russia"; // e.g.; "USA"

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
OPEX_friendly_army = localize "STR_friendly_army_ru";

// FLAGS
OPEX_friendly_flag_marker = "flag_Russia";
OPEX_friendly_flag_faction = "pictures\flag_russia.paa"; // e.g.: NATO
OPEX_friendly_flag_country = "pictures\flag_russia.paa"; // e.g.: USA
OPEX_friendly_flag_army = "pictures\flag_army_russia.paa"; // e.g.: Camp Liberty
OPEX_friendly_insigna = "Russia";

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

// AI SKILL
OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

OPEX_friendly_identities = ["russian_01", "russian_02", "russian_03", "russian_04", "russian_05", "russian_06", "russian_07", "russian_08", "russian_09", "russian_10", "russian_11", "russian_12", "russian_13", "russian_14", "russian_15", "russian_16", "russian_17", "russian_18", "russian_19", "russian_20", "russian_21", "russian_22", "russian_23", "russian_24", "russian_25", "russian_26", "russian_27", "russian_28", "russian_29", "russian_30", "russian_31", "russian_32", "russian_33", "russian_34", "russian_35", "russian_36", "russian_37", "russian_38", "russian_39", "russian_40", "russian_41", "russian_42", "russian_43", "russian_44", "russian_45", "russian_46", "russian_47", "russian_48", "russian_49", "russian_50"];

// VEHICLES
OPEX_friendly_transportTrucksOpened_woodland = ["rhs_gaz66o_vdv","rhs_kamaz5350_open_vdv","RHS_Ural_Open_VDV_01","rhs_zil131_open_vdv"];
OPEX_friendly_transportTrucksOpened_desert = ["rhs_gaz66o_vdv","rhs_kamaz5350_open_vdv","RHS_Ural_Open_VDV_01","rhs_zil131_open_vdv"];
OPEX_friendly_transportTrucksOpened_snow = ["rhs_gaz66o_vdv","rhs_kamaz5350_open_vdv","RHS_Ural_Open_VDV_01","rhs_zil131_open_vdv"];
OPEX_friendly_transportTrucksCovered_woodland = ["rhs_gaz66_vdv","rhs_kamaz5350_vdv","RHS_Ural_VDV_01","rhs_zil131_vdv"];
OPEX_friendly_transportTrucksCovered_desert = ["rhs_gaz66_vdv","rhs_kamaz5350_vdv","RHS_Ural_VDV_01","rhs_zil131_vdv"];
OPEX_friendly_transportTrucksCovered_snow = ["rhs_gaz66_vdv","rhs_kamaz5350_vdv","RHS_Ural_VDV_01","rhs_zil131_vdv"];
OPEX_friendly_fuelTrucks_woodland = ["RHS_Ural_Fuel_VDV_01"];
OPEX_friendly_fuelTrucks_desert = ["RHS_Ural_Fuel_VDV_01"];
OPEX_friendly_fuelTrucks_snow = ["RHS_Ural_Fuel_VDV_01"];
OPEX_friendly_logisticTrucks_woodland = ["rhs_gaz66_r142_vdv"];
OPEX_friendly_logisticTrucks_desert = ["rhs_gaz66_r142_vdv"];
OPEX_friendly_logisticTrucks_snow = ["rhs_gaz66_r142_vdv"];
OPEX_friendly_medicalTrucks_woodland = ["rhs_gaz66_ap2_vdv"];
OPEX_friendly_medicalTrucks_desert = ["rhs_gaz66_ap2_vdv"];
OPEX_friendly_medicalTrucks_snow = ["rhs_gaz66_ap2_vdv"];
OPEX_friendly_repairTrucks_woodland = ["RHS_Ural_Repair_VDV_01"];
OPEX_friendly_repairTrucks_desert = ["RHS_Ural_Repair_VDV_01"];
OPEX_friendly_repairTrucks_snow = ["RHS_Ural_Repair_VDV_01"];
OPEX_friendly_ammoTrucks_woodland = ["rhs_gaz66_ammo_vdv"];
OPEX_friendly_ammoTrucks_desert = ["rhs_gaz66_ammo_vdv"];
OPEX_friendly_ammoTrucks_snow = ["rhs_gaz66_ammo_vdv"];
OPEX_friendly_transportCars_woodland = ["rhs_tigr_vdv","rhs_tigr_m_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"];
OPEX_friendly_transportCars_desert = ["rhs_tigr_vdv","rhs_tigr_m_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"];
OPEX_friendly_transportCars_snow = ["rhs_tigr_vdv","rhs_tigr_m_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"];
OPEX_friendly_combatCarsMG_woodland = ["rhs_tigr_sts_vdv"];
OPEX_friendly_combatCarsMG_desert = ["rhs_tigr_sts_vdv"];
OPEX_friendly_combatCarsMG_snow = ["rhs_tigr_sts_vdv"];
OPEX_friendly_combatCarsGL_woodland = ["rhs_tigr_sts_vdv"];
OPEX_friendly_combatCarsGL_desert = ["rhs_tigr_sts_vdv"];
OPEX_friendly_combatCarsGL_snow = ["rhs_tigr_sts_vdv"];
OPEX_friendly_vtt_woodland = ["rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"];
OPEX_friendly_vtt_desert = ["rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"];
OPEX_friendly_vtt_snow = ["rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"];
OPEX_friendly_tanks_woodland = ["rhs_sprut_vdv","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2k","rhs_bmd2m","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_bmp1_vdv","rhs_bmp1d_vdv","rhs_bmp1k_vdv","rhs_bmp1p_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_brm1k_vdv","rhs_prp3_vdv", "rhs_t14_tv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t72be_tv","rhs_t80","rhs_t80a","rhs_t80bk","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_t90am_tv","rhs_t90saa_tv","rhs_t90sab_tv","rhs_t90sm_tv"];
OPEX_friendly_tanks_desert = ["rhs_sprut_vdv","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2k","rhs_bmd2m","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_bmp1_vdv","rhs_bmp1d_vdv","rhs_bmp1k_vdv","rhs_bmp1p_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_brm1k_vdv","rhs_prp3_vdv", "rhs_t14_tv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t72be_tv","rhs_t80","rhs_t80a","rhs_t80bk","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_t90am_tv","rhs_t90saa_tv","rhs_t90sab_tv","rhs_t90sm_tv"];
OPEX_friendly_tanks_snow = ["rhs_sprut_vdv","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2k","rhs_bmd2m","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_bmp1_vdv","rhs_bmp1d_vdv","rhs_bmp1k_vdv","rhs_bmp1p_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_brm1k_vdv","rhs_prp3_vdv", "rhs_t14_tv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t72be_tv","rhs_t80","rhs_t80a","rhs_t80bk","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_t90am_tv","rhs_t90saa_tv","rhs_t90sab_tv","rhs_t90sm_tv"];
OPEX_friendly_quads_woodland = ["B_Quadbike_01_F"];
OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
OPEX_friendly_quads_snow = ["B_Quadbike_01_F"];
OPEX_friendly_zodiacs = ["B_T_Boat_Transport_01_F"];
OPEX_friendly_ships = ["B_T_Boat_Armed_01_minigun_F"];
OPEX_friendly_aircrafts = ["rhs_mig29s_vmf","rhs_mig29sm_vmf", "rhs_mig29s_vvsc","rhs_mig29sm_vvsc","RHS_Su25SM_vvsc", "rhs_mig29s_vvs","rhs_mig29sm_vvs","RHS_Su25SM_vvs","RHS_T50_vvs_generic","RHS_T50_vvs_051","RHS_T50_vvs_052","RHS_T50_vvs_053","RHS_T50_vvs_generic_ext","RHS_T50_vvs_054","RHS_T50_vvs_blueonblue"];
OPEX_friendly_smallCombatHelicopters_woodland = ["RHS_Mi24P_vdv","RHS_Mi24V_vdv", "RHS_Ka52_vvsc","RHS_Mi24P_vvsc","RHS_Mi24V_vvsc","RHS_Mi24Vt_vvsc","RHS_Mi24Vt_vvsc","rhs_mi28n_vvsc"];
OPEX_friendly_smallCombatHelicopters_desert = ["RHS_Mi24P_vdv","RHS_Mi24V_vdv", "RHS_Ka52_vvsc","RHS_Mi24P_vvsc","RHS_Mi24V_vvsc","RHS_Mi24Vt_vvsc","RHS_Mi24Vt_vvsc","rhs_mi28n_vvsc"];
OPEX_friendly_smallCombatHelicopters_snow = ["RHS_Mi24P_vdv","RHS_Mi24V_vdv", "RHS_Ka52_vvsc","RHS_Mi24P_vvsc","RHS_Mi24V_vvsc","RHS_Mi24Vt_vvsc","RHS_Mi24Vt_vvsc","rhs_mi28n_vvsc"];
OPEX_friendly_mediumCombatHelicopters_woodland = ["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_vdv"];
OPEX_friendly_mediumCombatHelicopters_desert = ["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_vdv"];
OPEX_friendly_mediumCombatHelicopters_snow = ["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_vdv"];
OPEX_friendly_smallTransportHelicopters_woodland = ["rhs_ka60_c"];
OPEX_friendly_smallTransportHelicopters_desert = ["rhs_ka60_c"];
OPEX_friendly_smallTransportHelicopters_snow = ["rhs_ka60_c"];
OPEX_friendly_mediumTransportHelicopters_woodland = ["RHS_Mi8AMT_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8T_vdv"];
OPEX_friendly_mediumTransportHelicopters_desert = ["RHS_Mi8AMT_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8T_vdv"];
OPEX_friendly_mediumTransportHelicopters_snow = ["RHS_Mi8AMT_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8T_vdv"];
OPEX_friendly_bigTransportHelicopters_woodland = ["RHS_Mi8MTV3_vdv","RHS_Mi8mtv3_Cargo_vdv","RHS_Mi8MTV3_heavy_vdv"];
OPEX_friendly_bigTransportHelicopters_desert = ["RHS_Mi8MTV3_vdv","RHS_Mi8mtv3_Cargo_vdv","RHS_Mi8MTV3_heavy_vdv"];
OPEX_friendly_bigTransportHelicopters_snow = ["RHS_Mi8MTV3_vdv","RHS_Mi8mtv3_Cargo_vdv","RHS_Mi8MTV3_heavy_vdv"];
OPEX_friendly_UAVs = ["rhs_pchela1t_vvsc"];
OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_F"];
OPEX_friendly_portableDrones = ["B_UAV_01_F"];
OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
OPEX_friendly_MGstatics = ["rhs_KORD_high_VDV"];
OPEX_friendly_GLstatics = ["RHS_AGS30_TriPod_VDV"];
OPEX_friendly_ATstatics = ["rhs_Kornet_9M133_2_vdv","rhs_SPG9M_VDV"];
OPEX_friendly_AAstatics = ["rhs_Igla_AA_pod_vdv"];
OPEX_friendly_mortarStatics = ["rhs_2b14_82mm_vdv"];

// WEAPONS
OPEX_friendly_commonHandguns = ["rhs_weap_pya"];
OPEX_friendly_specialHandguns = ["rhs_weap_6p53", "rhs_weap_makarov_pm"];
OPEX_friendly_commonRifles = ["rhs_weap_ak74m", "rhs_weap_ak74m", "rhs_weap_ak74m", "rhs_weap_ak74", "rhs_weap_ak74m_npz", "rhs_weap_aks74"];
OPEX_friendly_specialRifles = ["rhs_weap_ak74m_zenitco01_b33", "rhs_weap_ak74mr", "rhs_weap_ak74n", "rhs_weap_ak74n_npz", "rhs_weap_akms", "rhs_weap_aks74n", "rhs_weap_aks74n_npz", "rhs_weap_ak103", "rhs_weap_ak103_2_npz", "rhs_weap_ak103_zenitco01_b33", "rhs_weap_ak104_npz", "rhs_weap_ak104_zenitco01", "rhs_weap_ak104_zenitco01_b33", "rhs_weap_ak105_npz", "rhs_weap_ak105_zenitco01", "rhs_weap_ak105_zenitco01_b33"];
OPEX_friendly_GLrifles = ["rhs_weap_ak74m_gp25", "rhs_weap_ak74m_gp25", "rhs_weap_ak74m_gp25", "rhs_weap_ak74_gp25", "rhs_weap_ak74m_gp25_npz", "rhs_weap_ak74mr_gp25", "rhs_weap_ak74n_gp25_npz", "rhs_weap_aks74n_gp25_npz", "rhs_weap_ak103_gp25_npz"];
OPEX_friendly_MGriflesLight = ["rhs_weap_pkm"];
OPEX_friendly_MGriflesHeavy = ["rhs_weap_pkm", "rhs_weap_pkp"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["rhs_weap_aks74u", "rhs_weap_aks74un", "rhs_weap_asval", "rhs_weap_asval_npz", "rhs_weap_pp2000"];
OPEX_friendly_precisionRifles = ["rhs_weap_svds", "rhs_weap_svds_npz", "rhs_weap_vss_grip", "rhs_weap_vss_grip_npz"];
OPEX_friendly_sniperRifles = ["rhs_weap_svdp", "rhs_weap_svdp_npz", "rhs_weap_t5000"];
OPEX_friendly_ATlaunchers = ["rhs_weap_rpg26", "rhs_weap_rpg7", "rhs_weap_rshg2"];
OPEX_friendly_AAlaunchers = ["rhs_weap_igla"];
OPEX_friendly_shotguns = ["rhs_weap_aks74u", "rhs_weap_fgm148"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["optic_aco", "optic_ACO_grn", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_Yorris", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_ekp8_02"];
OPEX_friendly_distantCombatOptics = ["optic_MRCO", "optic_hamr", "rhs_acc_rakursPM", "rhs_acc_nita", "rhs_acc_pkas"];
OPEX_friendly_sniperOptics = ["optic_DMS", "optic_DMS", "optic_LRPS", "optic_SOS", "optic_Nightstalker", "optic_tws", "rhs_acc_dh520x56", "rhs_acc_1p29", "rhs_acc_1p78", "rhs_acc_1pn93_1", "rhs_acc_1pn93_2", "rhs_acc_pgo7v", "rhs_acc_pgo7v2", "rhs_acc_pgo7v3", "rhs_acc_pso1m2", "rhs_acc_pso1m21"];
OPEX_friendly_flashlights = ["acc_flashlight", "rhs_acc_2dpZenit", "rhs_acc_2dpZenit_ris", "rhs_acc_perst3_2dp_light_h"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_L", "muzzle_snds_H", "muzzle_snds_B", "rhs_acc_uuk", "rhs_acc_ak5", "rhs_acc_dtk", "rhs_acc_dtk1", "rhs_acc_dtk2", "rhs_acc_dtk3", "rhs_acc_dtk4short", "rhs_acc_tgpa", "rhs_acc_dtkakm", "rhs_acc_dtk1l", "rhs_acc_pbs1", "rhs_acc_pgs64_74u", "rhs_acc_pgs64_74un", "rhs_acc_tgpv", "rhs_acc_tgpv2"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L", "muzzle_snds_acp"];
OPEX_friendly_pointers = ["acc_pointer_IR", "rhs_acc_perst1ik", "rhs_acc_perst1ik_ris", "rhs_acc_perst3", "rhs_acc_perst3_top", "rhs_acc_perst3_2dp_h"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk", "rhs_acc_grip_ffg2", "rhs_acc_grip_rk2", "rhs_acc_grip_rk6", "rhs_acc_harris_swivel"];

// VARIOUS ITEMS
OPEX_friendly_handGrenades = ["HandGrenade"];
OPEX_friendly_smokeGrenades_white = ["SmokeShell"];
OPEX_friendly_smokeGrenades_colors = ["SmokeShellBlue", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed", "SmokeShellGreen", "SmokeShellPurple"];
OPEX_friendly_chemlights = ["Chemlight_blue", "Chemlight_yellow", "Chemlight_red", "Chemlight_green"];
OPEX_friendly_IRs = ["B_IR_Grenade"];
OPEX_friendly_explosives = ["ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", "APERSTripMine_Wire_Mag", "ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"];
OPEX_friendly_NVGs = ["rhs_1PN138", "NVGoggles_INDEP"];
OPEX_friendly_commonBinoculars = ["Binocular"];
OPEX_friendly_spotterBinoculars = ["rhs_pdu4"];
OPEX_friendly_laserDesignators = ["laserdesignator"];
OPEX_friendly_toolKits = ["ToolKit"];
OPEX_friendly_medikits = ["Medikit"];
OPEX_friendly_mineDetectors = ["MineDetector"];
OPEX_friendly_droneTerminals = ["B_UavTerminal"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["rhs_uniform_emr_patchless"];
OPEX_friendly_commonUniforms_desert = ["rhs_uniform_emr_des_patchless"];
OPEX_friendly_commonUniforms_snow = ["rhs_uniform_flora_patchless"];
OPEX_friendly_specialUniforms_woodland = ["rhs_uniform_emr_patchless"];
OPEX_friendly_specialUniforms_desert = ["rhs_uniform_emr_des_patchless"];
OPEX_friendly_specialUniforms_snow = ["rhs_uniform_flora_patchless"];
OPEX_friendly_ghillieUniforms_woodland = ["U_B_T_FullGhillie_tna_F", "U_B_T_Sniper_F", "U_B_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
OPEX_friendly_ghillieUniforms_desert = ["U_B_FullGhillie_ard"];
OPEX_friendly_ghillieUniforms_snow = ["U_B_FullGhillie_ard", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
OPEX_friendly_heliPilotUniforms_woodland = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_heliPilotUniforms_desert = ["rhs_uniform_gorka_r_y"];
OPEX_friendly_heliPilotUniforms_snow = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_aircraftPilotUniforms_desert = ["rhs_uniform_gorka_r_y"];
OPEX_friendly_aircraftPilotUniforms_snow = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_tankPilotUniforms_woodland = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_tankPilotUniforms_desert = ["rhs_uniform_gorka_r_y"];
OPEX_friendly_tankPilotUniforms_snow = ["rhs_uniform_gorka_r_g"];
OPEX_friendly_medicUniforms_woodland = ["rhs_uniform_emr_patchless"];
OPEX_friendly_medicUniforms_desert = ["rhs_uniform_emr_des_patchless"];
OPEX_friendly_medicUniforms_snow = ["rhs_uniform_flora_patchless"];
OPEX_friendly_instructorUniforms_woodland = ["rhs_uniform_emr_patchless"];
OPEX_friendly_instructorUniforms_desert = ["rhs_uniform_emr_des_patchless"];
OPEX_friendly_instructorUniforms_snow = ["rhs_uniform_flora_patchless"];
OPEX_friendly_tshirtUniforms_woodland = ["rhs_uniform_emr_patchless"];
OPEX_friendly_tshirtUniforms_desert = ["rhs_uniform_emr_des_patchless"];
OPEX_friendly_tshirtUniforms_snow = ["rhs_uniform_flora_patchless"];
OPEX_friendly_diverUniforms = ["U_B_Wetsuit"];

// VESTS
OPEX_friendly_commonVests_woodland = ["rhs_6b13_EMR", "rhs_6b13_EMR_6sh92", "rhs_6b23_digi", "rhs_6b23_6sh116", "rhs_6b23_digi_rifleman", "rhs_6b23_digi_sniper", "rhs_6b43", "rhs_6b23_digi_6sh92"];
OPEX_friendly_commonVests_desert = ["rhs_6b13_EMR", "rhs_6b13_EMR_6sh92", "rhs_6b23_digi", "rhs_6b23_6sh116", "rhs_6b23_digi_rifleman", "rhs_6b23_digi_sniper", "rhs_6b43", "rhs_6b23_digi_6sh92"];
OPEX_friendly_commonVests_snow = ["rhs_6b13_Flora", "rhs_6b13_Flora_6sh92"];
OPEX_friendly_specialVests_woodland = ["rhs_6b13_EMR_6sh92_headset_mapcase", "rhs_6b13_EMR_6sh92_radio", "rhs_6sh92_digi_headset", "rhs_6b23_digi_6sh92_radio", "rhs_6b23_digi_6sh92_headset", "rhs_6b23_digi_6sh92_headset_mapcase"];
OPEX_friendly_specialVests_desert = ["rhs_6b13_EMR_6sh92_headset_mapcase", "rhs_6b13_EMR_6sh92_radio", "rhs_6sh92_digi_headset", "rhs_6b23_digi_6sh92_radio", "rhs_6b23_digi_6sh92_headset", "rhs_6b23_digi_6sh92_headset_mapcase"];
OPEX_friendly_specialVests_snow = ["rhs_6b13_Flora_6sh92_headset_mapcase", "rhs_6b13_Flora_6sh92_radio", "rhs_6b13_Flora_crewofficer"];
OPEX_friendly_medicVests_woodland = ["rhs_6b13_EMR"];
OPEX_friendly_medicVests_desert = ["rhs_6b13_EMR"];
OPEX_friendly_medicVests_snow = ["rhs_6b13_Flora"];
OPEX_friendly_beltVests_woodland = ["rhs_vest_pistol_holster", "rhs_6sh46"];
OPEX_friendly_beltVests_desert = ["rhs_vest_pistol_holster", "rhs_6sh46"];
OPEX_friendly_beltVests_snow = ["rhs_vest_pistol_holster"];
OPEX_friendly_shoulderVests_woodland = ["rhs_vest_commander", "rhs_vest_commander", "rhs_vest_commander", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_desert = ["rhs_vest_commander", "rhs_vest_commander", "rhs_vest_commander", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_snow = ["rhs_vest_commander", "rhs_vest_commander", "rhs_vest_commander", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests_woodland = ["rhs_6b13_EMR", "rhs_6b23_digi", "rhs_6b23_digi_rifleman", "rhs_6b23_digi_sniper"];
OPEX_friendly_lightVests_desert = ["rhs_6b13_EMR", "rhs_6b23_digi", "rhs_6b23_digi_rifleman", "rhs_6b23_digi_sniper"];
OPEX_friendly_lightVests_snow = ["rhs_6b13_Flora"];
OPEX_friendly_grenadierVests_woodland = ["rhs_6b23_6sh116_vog", "rhs_6b13_EMR_6sh92_vog", "rhs_6b23_digi_6sh92_vog", "rhs_6b23_digi_vydra_3m"];
OPEX_friendly_grenadierVests_desert = ["rhs_6b23_6sh116_vog", "rhs_6b13_EMR_6sh92_vog", "rhs_6b23_digi_6sh92_vog", "rhs_6b23_digi_vydra_3m"];
OPEX_friendly_grenadierVests_snow = ["rhs_6b13_Flora_6sh92_vog"];
OPEX_friendly_EODvests_woodland = ["rhs_6b23_6sh116_od"];
OPEX_friendly_EODvests_desert = ["rhs_6b23_6sh116_od"];
OPEX_friendly_EODvests_snow = ["rhs_6b23_6sh116_od"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["rhs_6b27m_digi", "rhs_6b27m_digi_ess"];
OPEX_friendly_commonHelmets_desert = ["rhs_6b27m_digi", "rhs_6b27m_digi_ess"];
OPEX_friendly_commonHelmets_snow = ["rhs_6b26", "rhs_6b26_ess", "rhs_6b26_bala", "rhs_6b26_ess_bala"];
OPEX_friendly_specialHelmets_woodland = ["H_HelmetSpecB", "rhs_6b47", "rhs_6b47_ess", "rhs_6b7_1m_emr", "rhs_6b7_1m_emr_ess"];
OPEX_friendly_specialHelmets_desert = ["H_HelmetSpecB", "rhs_6b47", "rhs_6b47_ess", "rhs_6b7_1m_emr", "rhs_6b7_1m_emr_ess"];
OPEX_friendly_specialHelmets_snow = ["H_HelmetSpecB", "rhs_6b26_green", "rhs_6b26_bala_green", "rhs_6b26_ess_green", "rhs_6b26_ess_bala_green", "rhs_6b27m_green", "rhs_6b27m_green_bala", "rhs_6b27m_green_ess", "rhs_6b27m_green_ess_bala"];
OPEX_friendly_EODhelmets_woodland = ["rhs_altyn_visordown", "rhs_altyn"];
OPEX_friendly_EODhelmets_desert = ["rhs_altyn"];
OPEX_friendly_EODhelmets_snow = ["rhs_altyn_visordown", "rhs_altyn", "rhs_altyn_bala"];
OPEX_friendly_heliPilotHelmets = ["rhs_zsh7a_mike_green", "rhs_zsh7a_mike_green", "rhs_zsh7a_mike_green_alt"];
OPEX_friendly_aircraftPilotHelmets = ["rhs_zsh7a", "rhs_zsh7a_alt"];
OPEX_friendly_tankCrewHelmets = ["rhs_tsh4", "rhs_tsh4", "rhs_tsh4", "rhs_tsh4_ess"];
OPEX_friendly_cameraHelmets_woodland = ["H_HelmetSpecB", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_snakeskin", "H_HelmetB_light", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_snakeskin", "H_HelmetSpecB_wdl", "H_HelmetB_light_wdl"];
OPEX_friendly_cameraHelmets_desert = ["H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets_snow = ["H_HelmetSpecB_blk", "H_HelmetB_light_black"];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
OPEX_friendly_hats_woodland = ["rhs_Booniehat_digi", "H_Booniehat_khk", "H_Booniehat_oli"];
OPEX_friendly_hats_desert = ["H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_tan"];
OPEX_friendly_hats_snow = ["rhs_Booniehat_flora", "H_Booniehat_khk", "H_Booniehat_oli"];
OPEX_friendly_beanies_woodland = ["rhs_beanie_green", "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["rhs_beanie_green", "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["rhs_beanie_green", "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_leaderHeadgear_woodland = ["rhs_fieldcap_helm_digi", "rhs_fieldcap_digi", "rhs_beret_vdv1", "rhs_beret_vdv2", "rhs_beret_vdv3", "rhs_beret_mp1", "rhs_beret_mp2", "rhs_beret_milp"];
OPEX_friendly_leaderHeadgear_desert = ["rhs_fieldcap_khk", "rhs_beret_vdv1", "rhs_beret_vdv2", "rhs_beret_vdv3", "rhs_beret_mp1", "rhs_beret_mp2", "rhs_beret_milp"];
OPEX_friendly_leaderHeadgear_snow = ["rhs_fieldcap_vsr", "rhs_fieldcap_digi", "rhs_beret_vdv1", "rhs_beret_vdv2", "rhs_beret_vdv3", "rhs_beret_mp1", "rhs_beret_mp2", "rhs_beret_milp"];
OPEX_friendly_berets = ["rhs_beret_vdv1", "rhs_beret_vdv2", "rhs_beret_vdv3", "rhs_beret_mp1", "rhs_beret_mp2", "rhs_beret_milp"];
OPEX_friendly_caps = ["H_Cap_tan", "H_Cap_tan_specops_US", "H_Cap_usblack", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F", "rhs_gssh18"];

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli", "rhsusf_shemagh_od", "rhsusf_shemagh_tan", "rhsusf_shemagh_gogg_od", "rhsusf_shemagh2_gogg_od", "rhsusf_shemagh_gogg_tan", "rhsusf_shemagh2_gogg_tan"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Squares", "G_Combat", "R3F_lunettes_X800", "R3F_lunettes_ESS", "rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator", "rhs_googles_black"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts_engineer_empty", "rhs_sidor", "rhs_sidor", "rhs_sidor", "B_AssaultPack_khk", "B_AssaultPack_wdl_F", "B_AssaultPack_eaf_F", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Carryall_wdl_F", "B_Carryall_green_F", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];
OPEX_friendly_mediumBackpacks_desert = ["rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts_engineer_empty", "rhs_sidor", "rhs_sidor", "rhs_sidor", "B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_AssaultPack_ocamo", "B_TacticalPack_ocamo"];
OPEX_friendly_mediumBackpacks_snow = ["rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts", "rhs_assault_umbts_engineer_empty", "rhs_sidor", "rhs_sidor", "rhs_sidor", "B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk"];
OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_wdl_F", "B_Carryall_green_F", "B_Carryall_oli", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_desert = ["B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_cbr", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_oucamo"];
OPEX_friendly_medicBackpacks_woodland = ["rhs_medic_bag"];
OPEX_friendly_medicBackpacks_desert = ["rhs_medic_bag"];
OPEX_friendly_medicBackpacks_snow = ["rhs_medic_bag"];
OPEX_friendly_radioBackpacks_woodland = ["B_RadioBag_01_wdl_F", "B_RadioBag_01_wdl_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_desert = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_snow = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];