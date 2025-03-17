// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "rhsusf_main"))) exitWith {};

// NAMES
_OPEX_friendly_modName = "RHS"; // e.g.: "RHS"
_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // e.g.: "NATO"
_OPEX_friendly_subFaction = "STR_friendly_subFaction_USA"; // e.g.; "USA"

// ===============================================================================
// do not edit or delete section below
// ===============================================================================

// ENABLING FACTION
waitUntil {!isNil "OPEX_friendly_factions"};
if (isServer) then {OPEX_friendly_factions append [[_OPEX_friendly_subFaction, _OPEX_friendly_modName]]}; publicVariable "OPEX_friendly_factions"; // do not edit or delete this line

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
OPEX_friendly_army = localize "STR_friendly_army_us";

// FLAGS
OPEX_friendly_flag_marker = "flag_USA";
OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // e.g.: NATO
OPEX_friendly_flag_country = "pictures\flag_usa.paa"; // e.g.: USA
OPEX_friendly_flag_army = "pictures\flag_army_usa.paa"; // e.g.: Camp Liberty
OPEX_friendly_insigna = "NATO";

// CAMP
OPEX_friendly_camp = "Camp Liberty";
OPEX_sign_camp = "pictures\sign_camp_us.paa";

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

// AI SKILL
OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

// VEHICLES
OPEX_friendly_transportTrucksOpened_woodland = ["rhsusf_M1078A1P2_WD_fmtv_usarmy", "rhsusf_M1078A1P2_B_WD_fmtv_usarmy", "rhsusf_M1083A1P2_WD_fmtv_usarmy", "rhsusf_M1083A1P2_B_WD_fmtv_usarmy"];
OPEX_friendly_transportTrucksOpened_desert = ["rhsusf_M1078A1P2_D_fmtv_usarmy", "rhsusf_M1078A1P2_B_D_fmtv_usarmy", "rhsusf_M1083A1P2_D_fmtv_usarmy", "rhsusf_M1083A1P2_B_D_fmtv_usarmy"];
OPEX_friendly_transportTrucksOpened_snow = ["rhsusf_M1078A1P2_WD_fmtv_usarmy", "rhsusf_M1078A1P2_B_WD_fmtv_usarmy", "rhsusf_M1083A1P2_WD_fmtv_usarmy", "rhsusf_M1083A1P2_B_WD_fmtv_usarmy"];
OPEX_friendly_transportTrucksCovered_woodland = ["rhsusf_M1078A1P2_WD_fmtv_usarmy", "rhsusf_M1078A1P2_B_WD_fmtv_usarmy", "rhsusf_M1083A1P2_WD_fmtv_usarmy", "rhsusf_M1083A1P2_B_WD_fmtv_usarmy"];
OPEX_friendly_transportTrucksCovered_desert = ["rhsusf_M1078A1P2_D_fmtv_usarmy", "rhsusf_M1078A1P2_B_D_fmtv_usarmy", "rhsusf_M1083A1P2_D_fmtv_usarmy", "rhsusf_M1083A1P2_B_D_fmtv_usarmy"];
OPEX_friendly_transportTrucksCovered_snow = ["rhsusf_M1078A1P2_WD_fmtv_usarmy", "rhsusf_M1078A1P2_B_WD_fmtv_usarmy", "rhsusf_M1083A1P2_WD_fmtv_usarmy", "rhsusf_M1083A1P2_B_WD_fmtv_usarmy"];
OPEX_friendly_fuelTrucks_woodland = ["rhsusf_M978A4_usarmy_wd"];
OPEX_friendly_fuelTrucks_desert = ["rhsusf_M978A4_usarmy_d"];
OPEX_friendly_fuelTrucks_snow = ["rhsusf_M978A4_usarmy_wd"];
OPEX_friendly_logisticTrucks_woodland = ["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy"];
OPEX_friendly_logisticTrucks_desert = ["rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy"];
OPEX_friendly_logisticTrucks_snow = ["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy"];
OPEX_friendly_medicalTrucks_woodland = ["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy","rhsusf_M1230a1_usarmy_wd"];
OPEX_friendly_medicalTrucks_desert = ["rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy","rhsusf_M1230a1_usarmy_d"];
OPEX_friendly_medicalTrucks_snow = ["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy","rhsusf_M1230a1_usarmy_wd"];
OPEX_friendly_repairTrucks_woodland = ["rhsusf_M977A4_REPAIR_usarmy_wd"];
OPEX_friendly_repairTrucks_desert = ["rhsusf_M977A4_REPAIR_usarmy_d"];
OPEX_friendly_repairTrucks_snow = ["rhsusf_M977A4_REPAIR_usarmy_wd"];
OPEX_friendly_ammoTrucks_woodland = ["rhsusf_M977A4_AMMO_usarmy_wd"];
OPEX_friendly_ammoTrucks_desert = ["rhsusf_M977A4_AMMO_usarmy_d"];
OPEX_friendly_ammoTrucks_snow = ["rhsusf_M977A4_AMMO_usarmy_wd"];
OPEX_friendly_transportCars_woodland = ["rhsusf_m1025_w_s","rhsusf_m1043_w_s","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_fulltop", "rhsusf_CGRCAT1A2_usmc_wd"];
OPEX_friendly_transportCars_desert = ["rhsusf_m1025_d_s","rhsusf_m1043_d_s","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_fulltop", "rhsusf_CGRCAT1A2_usmc_d","rhsusf_M1238A1_socom_d"];
OPEX_friendly_transportCars_snow = ["rhsusf_m1025_w_s","rhsusf_m1043_w_s","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_fulltop", "rhsusf_CGRCAT1A2_usmc_wd"];
OPEX_friendly_combatCarsMG_woodland = ["rhsusf_m1025_w_s_m2","rhsusf_m1043_w_s_m2", "rhsusf_CGRCAT1A2_M2_usmc_wd"];
OPEX_friendly_combatCarsMG_desert = ["rhsusf_m1025_d_s_m2","rhsusf_m1043_d_s_m2", "rhsusf_CGRCAT1A2_M2_usmc_d","rhsusf_M1238A1_M2_socom_d"];
OPEX_friendly_combatCarsMG_snow = ["rhsusf_m1025_w_s_m2","rhsusf_m1043_w_s_m2", "rhsusf_CGRCAT1A2_M2_usmc_wd"];
OPEX_friendly_combatCarsGL_woodland = ["rhsusf_m1025_w_s_Mk19","rhsusf_m1043_w_s_mk19", "rhsusf_CGRCAT1A2_Mk19_usmc_wd"];
OPEX_friendly_combatCarsGL_desert = ["rhsusf_m1025_d_s_Mk19","rhsusf_m1043_d_s_mk19", "rhsusf_CGRCAT1A2_Mk19_usmc_d","rhsusf_M1238A1_Mk19_socom_d"];
OPEX_friendly_combatCarsGL_snow = ["rhsusf_m1025_w_s_Mk19","rhsusf_m1043_w_s_mk19", "rhsusf_CGRCAT1A2_Mk19_usmc_wd"];
OPEX_friendly_vtt_woodland = ["rhsusf_M1232_MC_M2_usmc_wd","rhsusf_M1232_MC_MK19_usmc_wd","rhsusf_stryker_m1126_m2_wd","rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","rhsusf_m113_usarmy_unarmed","rhsusf_M1117_W","rhsusf_M1220_usarmy_wd","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_M153_MK19_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230_M2_usarmy_wd","rhsusf_M1230_MK19_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd"];
OPEX_friendly_vtt_desert = ["rhsusf_M1232_MC_MK19_usmc_d","rhsusf_M1232_MC_M2_usmc_d","rhsusf_m113d_usarmy_supply","rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_unarmed","rhsusf_M1117_D","rhsusf_M1220_usarmy_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1220_M153_MK19_usarmy_d","rhsusf_M1220_MK19_usarmy_d","rhsusf_M1230_M2_usarmy_d","rhsusf_M1232_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1232_MK19_usarmy_d","rhsusf_M1237_M2_usarmy_d","rhsusf_M1237_MK19_usarmy_d"];
OPEX_friendly_vtt_snow = ["rhsusf_M1232_MC_M2_usmc_wd","rhsusf_M1232_MC_MK19_usmc_wd","rhsusf_stryker_m1126_m2_wd","rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","rhsusf_m113_usarmy_unarmed","rhsusf_M1117_W","rhsusf_M1220_usarmy_wd","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_M153_MK19_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230_M2_usarmy_wd","rhsusf_M1230_MK19_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd"];
OPEX_friendly_tanks_woodland = ["rhsusf_m1a1fep_wd","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"];
OPEX_friendly_tanks_desert = ["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"];
OPEX_friendly_tanks_snow = ["rhsusf_m1a1fep_wd","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"];
OPEX_friendly_quads_woodland = ["B_Quadbike_01_F"];
OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
OPEX_friendly_quads_snow = ["B_Quadbike_01_F"];
OPEX_friendly_zodiacs = ["B_Boat_Transport_01_F"];
OPEX_friendly_ships = ["rhsusf_mkvsoc"];
OPEX_friendly_aircrafts = ["RHS_A10","rhsusf_f22"];
OPEX_friendly_smallCombatHelicopters_woodland = ["RHS_MELB_AH6M"];
OPEX_friendly_smallCombatHelicopters_desert = ["RHS_MELB_AH6M"];
OPEX_friendly_smallCombatHelicopters_snow = ["RHS_MELB_AH6M"];
OPEX_friendly_mediumCombatHelicopters_woodland = ["RHS_AH64D_wd","RHS_AH1Z_wd","RHS_UH1Y"];
OPEX_friendly_mediumCombatHelicopters_desert = ["RHS_AH64D","RHS_AH1Z","RHS_UH1Y_d"];
OPEX_friendly_mediumCombatHelicopters_snow = ["RHS_AH64D_wd","RHS_AH1Z_wd","RHS_UH1Y"];
OPEX_friendly_smallTransportHelicopters_woodland = ["RHS_MELB_MH6M","RHS_MELB_H6M"];
OPEX_friendly_smallTransportHelicopters_desert = ["RHS_MELB_MH6M","RHS_MELB_H6M"];
OPEX_friendly_smallTransportHelicopters_snow = ["RHS_MELB_MH6M","RHS_MELB_H6M"];
OPEX_friendly_mediumTransportHelicopters_woodland = ["RHS_UH60M","RHS_UH60M_ESSS","RHS_UH60M_ESSS2","RHS_UH1Y_FFAR","RHS_UH1Y","RHS_UH1Y_UNARMED"];
OPEX_friendly_mediumTransportHelicopters_desert = ["RHS_UH60M_d","RHS_UH60M_ESSS_d","RHS_UH60M_ESSS2_d","RHS_UH60M2_d","RHS_UH1Y_FFAR_d","RHS_UH1Y_d","RHS_UH1Y_UNARMED_d"];
OPEX_friendly_mediumTransportHelicopters_snow = ["RHS_UH60M","RHS_UH60M_ESSS","RHS_UH60M_ESSS2","RHS_UH1Y_FFAR","RHS_UH1Y","RHS_UH1Y_UNARMED"];
OPEX_friendly_bigTransportHelicopters_woodland = ["rhsusf_CH53E_USMC","rhsusf_CH53E_USMC_GAU21","RHS_CH_47F"];
OPEX_friendly_bigTransportHelicopters_desert = ["rhsusf_CH53E_USMC_D","rhsusf_CH53E_USMC_GAU21_D","RHS_CH_47F_10","RHS_CH_47F_light"];
OPEX_friendly_bigTransportHelicopters_snow = ["rhsusf_CH53E_USMC","rhsusf_CH53E_USMC_GAU21","RHS_CH_47F"];
OPEX_friendly_UAVs = ["B_UAV_02_dynamicLoadout_F"];
OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_F"];
OPEX_friendly_portableDrones = ["B_UAV_01_F"];
OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
OPEX_friendly_MGstatics = ["RHS_M2StaticMG_WD"];
OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
OPEX_friendly_ATstatics = ["RHS_TOW_TriPod_WD"];
OPEX_friendly_mortarStatics = ["RHS_M252_WD"];

// WEAPONS
OPEX_friendly_commonHandguns = ["rhsusf_weap_m9"];
OPEX_friendly_specialHandguns = ["rhsusf_weap_glock17g4", "rhsusf_weap_m1911a1", "rhsusf_weap_m9"];
OPEX_friendly_commonRifles = ["rhs_weap_m4a1_carryhandle"];
OPEX_friendly_specialRifles = ["rhs_weap_m4a1_carryhandle_mstock", "rhs_weap_mk18_bk", "rhs_weap_m27iar", "rhs_weap_m27iar_grip", "rhs_weap_hk416d10", "rhs_weap_hk416d10_LMT", "rhs_weap_hk416d145"];
OPEX_friendly_GLrifles = ["rhs_weap_m4a1_carryhandle_m203", "rhs_weap_m4a1_carryhandle_m203S"];
OPEX_friendly_MGriflesLight = ["rhs_weap_m249", "rhs_weap_m249_pip", "rhs_weap_m249_light_L", "rhs_weap_m249_pip_L_para", "rhs_weap_m249_pip_L", "rhs_weap_m249_pip_ris", "rhs_weap_m249_light_S", "rhs_weap_m249_pip_S_para", "rhs_weap_m249_pip_S"];
OPEX_friendly_MGriflesHeavy = ["rhs_weap_m240B", "rhs_weap_m240G"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["rhs_weap_hk416d10", "rhsusf_weap_MP7A2"];
OPEX_friendly_precisionRifles = ["rhs_weap_m24sws", "rhs_weap_sr25", "rhs_weap_sr25_ec"];
OPEX_friendly_sniperRifles = ["rhs_weap_m14ebrri", "rhs_weap_M107", "rhs_weap_XM2010", "rhs_weap_m40a5"];
OPEX_friendly_ATlaunchers = ["rhs_weap_M136", "rhs_weap_M136_hedp", "rhs_weap_M136_hp", "rhs_weap_maaws", "rhs_weap_fgm148", "rhs_weap_m72a7", "rhs_weap_smaw"];
OPEX_friendly_AAlaunchers = ["rhs_weap_fim92"];
OPEX_friendly_shotguns = ["rhs_weap_M590_8RD", "rhs_weap_M590_5RD"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["optic_aco", "rhsusf_acc_M2A1", "rhsusf_acc_eotech_552", "rhsusf_acc_compm4", "rhsusf_acc_mrds", "rhsusf_acc_RM05", "rhsusf_acc_RX01_NoFilter", "rhsusf_acc_RX01", "rhsusf_acc_eotech_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low"];
OPEX_friendly_distantCombatOptics = ["optic_MRCO", "optic_hamr", "rhsusf_acc_ACOG2_USMC", "rhsusf_acc_ACOG3_USMC", "rhsusf_acc_ACOG_USMC", "rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhsusf_acc_ACOG3", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3"];
OPEX_friendly_sniperOptics = ["optic_DMS", "optic_LRPS", "optic_SOS", "optic_Nightstalker", "optic_tws", "rhsusf_acc_ELCAN", "rhsusf_acc_ELCAN_ard", "rhsusf_acc_premier_mrds", "rhsusf_acc_LEUPOLDMK4_2_mrds", "rhsusf_acc_su230", "rhsusf_acc_su230_mrds", "rhsusf_acc_su230a", "rhsusf_acc_su230a_mrds", "rhsusf_acc_ACOG_MDO"];
OPEX_friendly_flashlights = ["acc_flashlight", "rhsusf_acc_M952V", "rhsusf_acc_wmx_bk"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_L", "muzzle_snds_H", "muzzle_snds_B", "rhsusf_acc_nt4_black", "rhsusf_acc_rotex5_grey", "rhsusf_acc_SF3P556", "rhsusf_acc_SFMB556", "rhsusf_acc_m24_muzzlehider_black", "rhsusf_acc_m24_silencer_black", "rhsusf_acc_M2010S_wd", "rhsusf_acc_ARDEC_M240"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L", "muzzle_snds_acp", "rhsusf_acc_omega9k", "acc_flashlight_pistol"];
OPEX_friendly_pointers = ["acc_pointer_IR", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_anpeq15_bk_top", "rhsusf_acc_anpeq15_bk_light", "rhsusf_acc_anpeq15_bk", "rhsusf_acc_anpeq15A"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk", "rhsusf_acc_grip2", "rhsusf_acc_grip1", "rhsusf_acc_harris_bipod", "rhsusf_acc_harris_swivel", "rhsusf_acc_kac_grip", "rhsusf_acc_rvg_blk", "rhsusf_acc_tdstubby_blk", "rhsusf_acc_grip3", "rhsusf_acc_grip4_bipod", "rhsusf_acc_saw_bipod", "rhsusf_acc_kac_grip_saw_bipod", "rhsusf_acc_saw_lw_bipod"];

// VARIOUS ITEMS
OPEX_friendly_handGrenades = ["HandGrenade"];
OPEX_friendly_smokeGrenades_white = ["SmokeShell"];
OPEX_friendly_smokeGrenades_colors = ["SmokeShellBlue", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed", "SmokeShellGreen", "SmokeShellPurple"];
OPEX_friendly_chemlights = ["Chemlight_blue", "Chemlight_yellow", "Chemlight_red", "Chemlight_green"];
OPEX_friendly_IRs = ["B_IR_Grenade"];
OPEX_friendly_explosives = ["ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", "APERSTripMine_Wire_Mag", "ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"];
OPEX_friendly_NVGs = ["rhsusf_ANPVS_14", "rhsusf_ANPVS_15"];
OPEX_friendly_commonBinoculars = ["rhsusf_bino_m24", "rhsusf_bino_m24_ARD"];
OPEX_friendly_spotterBinoculars = ["rhsusf_bino_leopold_mk4", "rhsusf_bino_lrf_Vector21"];
OPEX_friendly_laserDesignators = ["rhsusf_bino_lerca_1200_black"];
OPEX_friendly_toolKits = ["ToolKit"];
OPEX_friendly_medikits = ["Medikit"];
OPEX_friendly_mineDetectors = ["MineDetector"];
OPEX_friendly_droneTerminals = ["B_UavTerminal"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["rhs_uniform_cu_ocp"];
OPEX_friendly_commonUniforms_desert = ["rhs_uniform_cu_ucp"];
OPEX_friendly_commonUniforms_snow = ["rhs_uniform_cu_ocp"];
OPEX_friendly_specialUniforms_woodland = ["rhs_uniform_cu_ocp"];
OPEX_friendly_specialUniforms_desert = ["rhs_uniform_cu_ucp"];
OPEX_friendly_specialUniforms_snow = ["rhs_uniform_cu_ocp"];
OPEX_friendly_ghillieUniforms_woodland = ["U_B_T_FullGhillie_tna_F", "U_B_T_Sniper_F", "U_B_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
OPEX_friendly_ghillieUniforms_desert = ["U_B_FullGhillie_ard"];
OPEX_friendly_ghillieUniforms_snow = ["U_B_FullGhillie_ard", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
OPEX_friendly_heliPilotUniforms_woodland = ["U_B_HeliPilotCoveralls"];
OPEX_friendly_heliPilotUniforms_desert = ["U_B_HeliPilotCoveralls"];
OPEX_friendly_heliPilotUniforms_snow = ["U_B_HeliPilotCoveralls"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["U_B_PilotCoveralls"];
OPEX_friendly_aircraftPilotUniforms_desert = ["U_B_PilotCoveralls"];
OPEX_friendly_aircraftPilotUniforms_snow = ["U_B_PilotCoveralls"];
OPEX_friendly_tankPilotUniforms_woodland = ["U_B_PilotCoveralls"];
OPEX_friendly_tankPilotUniforms_desert = ["U_B_PilotCoveralls"];
OPEX_friendly_tankPilotUniforms_snow = ["U_B_PilotCoveralls"];
OPEX_friendly_medicUniforms_woodland = ["rhs_uniform_cu_ocp"];
OPEX_friendly_medicUniforms_desert = ["rhs_uniform_cu_ucp"];
OPEX_friendly_medicUniforms_snow = ["rhs_uniform_cu_ocp"];
OPEX_friendly_instructorUniforms_woodland = ["rhs_uniform_cu_ocp"];
OPEX_friendly_instructorUniforms_desert = ["rhs_uniform_cu_ucp"];
OPEX_friendly_instructorUniforms_snow = ["rhs_uniform_cu_ocp"];
OPEX_friendly_tshirtUniforms_woodland = ["U_B_CombatUniform_tshirt_mcam_wdL_f"];
OPEX_friendly_tshirtUniforms_desert = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_tshirtUniforms_snow = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_diverUniforms = ["U_B_Wetsuit"];

// VESTS
OPEX_friendly_commonVests_woodland = ["rhsusf_iotv_ocp", "rhsusf_iotv_ocp_Rifleman", "rhsusf_iotv_ocp_SAW", "rhsusf_spcs_ocp_crewman", "rhsusf_spcs_ocp", "rhsusf_spcs_ocp_rifleman_alt", "rhsusf_spcs_ocp_rifleman"];
OPEX_friendly_commonVests_desert = ["rhsusf_iotv_ucp", "rhsusf_iotv_ucp_Rifleman", "rhsusf_iotv_ucp_SAW", "rhsusf_spcs_ucp_crewman", "rhsusf_spcs_ucp", "rhsusf_spcs_ucp_rifleman_alt", "rhsusf_spcs_ucp_rifleman"];
OPEX_friendly_commonVests_snow = ["rhsusf_iotv_ocp", "rhsusf_iotv_ocp_Rifleman", "rhsusf_iotv_ocp_SAW", "rhsusf_spcs_ocp_crewman", "rhsusf_spcs_ocp", "rhsusf_spcs_ocp_rifleman_alt", "rhsusf_spcs_ocp_rifleman"];
OPEX_friendly_specialVests_woodland = ["rhsusf_iotv_ocp_Squadleader", "rhsusf_iotv_ocp_Teamleader", "rhsusf_spcs_ocp_machinegunner", "rhsusf_spcs_ocp_sniper", "rhsusf_spcs_ocp_squadleader", "rhsusf_spcs_ocp_teamleader_alt", "rhsusf_spcs_ocp_teamleader"];
OPEX_friendly_specialVests_desert = ["rhsusf_iotv_ucp_Squadleader", "rhsusf_iotv_ucp_Teamleader", "rhsusf_spcs_ucp_machinegunner", "rhsusf_spcs_ucp_sniper", "rhsusf_spcs_ucp_squadleader", "rhsusf_spcs_ucp_teamleader_alt", "rhsusf_spcs_ucp_teamleader"];
OPEX_friendly_specialVests_snow = ["rhsusf_iotv_ocp_Squadleader", "rhsusf_iotv_ocp_Teamleader", "rhsusf_spcs_ocp_machinegunner", "rhsusf_spcs_ocp_sniper", "rhsusf_spcs_ocp_squadleader", "rhsusf_spcs_ocp_teamleader_alt", "rhsusf_spcs_ocp_teamleader"];
OPEX_friendly_medicVests_woodland = ["rhsusf_iotv_ocp_Medic", "rhsusf_spcs_ocp_medic"];
OPEX_friendly_medicVests_desert = ["rhsusf_iotv_ucp_Medic", "rhsusf_spcs_ucp_medic"];
OPEX_friendly_medicVests_snow = ["rhsusf_iotv_ocp_Medic", "rhsusf_spcs_ocp_medic"];
OPEX_friendly_beltVests_woodland = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_desert = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_snow = ["V_Rangemaster_belt"];
OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_snow = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests_woodland = ["rhsusf_spcs_ocp_crewman"];
OPEX_friendly_lightVests_desert = ["rhsusf_spcs_ucp_crewman"];
OPEX_friendly_lightVests_snow = ["rhsusf_spcs_ocp_crewman"];
OPEX_friendly_grenadierVests_woodland = ["rhsusf_iotv_ocp_Grenadier", "rhsusf_spcs_ocp_grenadier"];
OPEX_friendly_grenadierVests_desert = ["rhsusf_iotv_ucp_Grenadier", "rhsusf_spcs_ucp_grenadier"];
OPEX_friendly_grenadierVests_snow = ["rhsusf_iotv_ocp_Grenadier", "rhsusf_spcs_ocp_grenadier"];
OPEX_friendly_EODvests_woodland = ["rhsusf_iotv_ocp_Repair"];
OPEX_friendly_EODvests_desert = ["rhsusf_iotv_ucp_Repair"];
OPEX_friendly_EODvests_snow = ["rhsusf_iotv_ocp_Repair"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["rhsusf_ach_helmet_ocp", "rhsusf_ach_helmet_ocp_alt", "rhsusf_ach_helmet_ESS_ocp", "rhsusf_ach_helmet_ESS_ocp_alt"];
OPEX_friendly_commonHelmets_desert = ["rhsusf_ach_helmet_ucp", "rhsusf_ach_helmet_ucp_alt", "rhsusf_ach_helmet_ESS_ucp", "rhsusf_ach_helmet_ESS_ucp_alt"];
OPEX_friendly_commonHelmets_snow = ["rhsusf_ach_helmet_ocp", "rhsusf_ach_helmet_ocp_alt", "rhsusf_ach_helmet_ESS_ocp", "rhsusf_ach_helmet_ESS_ocp_alt"];
OPEX_friendly_specialHelmets_woodland = ["rhsusf_ach_helmet_headset_ocp", "rhsusf_ach_helmet_headset_ocp_alt", "rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_headset_ess_ocp_alt"];
OPEX_friendly_specialHelmets_desert = ["rhsusf_ach_helmet_headset_ucp", "rhsusf_ach_helmet_headset_ucp_alt", "rhsusf_ach_helmet_headset_ess_ucp", "rhsusf_ach_helmet_headset_ess_ucp_alt"];
OPEX_friendly_specialHelmets_snow = ["rhsusf_ach_helmet_headset_ocp", "rhsusf_ach_helmet_headset_ocp_alt", "rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_headset_ess_ocp_alt"];
OPEX_friendly_EODhelmets_woodland = ["H_HelmetB"];
OPEX_friendly_EODhelmets_desert = ["H_HelmetB_sand"];
OPEX_friendly_EODhelmets_snow = ["H_HelmetB_black"];
OPEX_friendly_heliPilotHelmets = ["rhsusf_hgu56p_black", "rhsusf_hgu56p_visor_black", "rhsusf_ihadss"];
OPEX_friendly_aircraftPilotHelmets = ["RHS_jetpilot_usaf"];
OPEX_friendly_tankCrewHelmets = ["H_HelmetCrew_B"];
OPEX_friendly_cameraHelmets_woodland = ["rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_headset_ess_ocp_alt", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets_desert = ["rhsusf_ach_helmet_headset_ess_ucp", "rhsusf_ach_helmet_headset_ess_ucp_alt", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets_snow = ["rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_headset_ess_ocp_alt", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
OPEX_friendly_hats_woodland = ["H_Booniehat_khk", "rhs_Booniehat_ocp", "H_Booniehat_oli"];
OPEX_friendly_hats_desert = ["rhs_Booniehat_ucp", "H_Booniehat_tan"];
OPEX_friendly_hats_snow = ["H_Booniehat_khk", "rhs_Booniehat_ocp", "H_Booniehat_oli"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_leaderHeadgear_woodland = ["H_Beret_02", "rhsusf_patrolcap_ocp", "rhsusf_Bowman"];
OPEX_friendly_leaderHeadgear_desert = ["H_Beret_02", "rhsusf_patrolcap_ucp", "rhsusf_Bowman"];
OPEX_friendly_leaderHeadgear_snow = ["H_Beret_02", "H_MilCap_gry", "rhsusf_Bowman"];
OPEX_friendly_berets = ["H_Beret_02"];
OPEX_friendly_caps = ["H_Cap_tan", "H_Cap_tan_specops_US", "H_Cap_usblack", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F"];

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli", "rhsusf_shemagh_od", "rhsusf_shemagh_tan", "rhsusf_shemagh_gogg_od", "rhsusf_shemagh2_gogg_od", "rhsusf_shemagh_gogg_tan", "rhsusf_shemagh2_gogg_tan"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Squares", "G_Combat", "R3F_lunettes_X800", "R3F_lunettes_ESS", "rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw", "rhs_googles_clear"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator", "rhs_googles_black", "rhs_googles_yellow", "rhs_googles_orange"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "B_AssaultPack_khk", "B_AssaultPack_wdl_F", "B_AssaultPack_eaf_F", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Carryall_wdl_F", "B_Carryall_green_F", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];
OPEX_friendly_mediumBackpacks_desert = ["rhsusf_assault_eagleaiii_ucp", "rhsusf_assault_eagleaiii_ucp", "rhsusf_assault_eagleaiii_ucp", "rhsusf_assault_eagleaiii_ucp", "rhsusf_assault_eagleaiii_ucp", "B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_AssaultPack_ocamo", "B_TacticalPack_ocamo"];
OPEX_friendly_mediumBackpacks_snow = ["rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "rhsusf_assault_eagleaiii_ocp", "B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk"];
OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_wdl_F", "B_Carryall_green_F", "B_Carryall_oli", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_desert = ["B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_cbr", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_oucamo"];
OPEX_friendly_medicBackpacks_woodland = ["B_AssaultPack_khk", "B_AssaultPack_wdl_F", "B_AssaultPack_eaf_F", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_FieldPack_khk", "B_FieldPack_green_F", "B_Kitbag_mcamo", "B_FieldPack_blk", "B_FieldPack_oli", "B_Carryall_wdl_F", "B_Carryall_green_F", "B_Carryall_oli", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];
OPEX_friendly_medicBackpacks_desert = ["B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_FieldPack_cbr", "B_FieldPack_blk", "B_FieldPack_ocamo", "B_AssaultPack_ocamo", "B_Carryall_ocamo", "B_Carryall_cbr", "B_TacticalPack_ocamo"];
OPEX_friendly_medicBackpacks_snow = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_FieldPack_blk", "B_FieldPack_oucamo", "B_Carryall_oucamo", "B_Carryall_mcamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk"];
OPEX_friendly_radioBackpacks_woodland = ["B_RadioBag_01_wdl_F", "B_RadioBag_01_wdl_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_desert = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_snow = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];