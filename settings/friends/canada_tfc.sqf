// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "tfc_Data"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "TFC_Weapons"))) exitWith {};

// DEFINING FACTION NAMES
_OPEX_friendly_modName = "TFC"; // e.g.: "RHS"
_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // e.g.: "NATO"
_OPEX_friendly_subFaction = "STR_friendly_subFaction_Canada"; // e.g.; "USA"

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
OPEX_friendly_army = localize "STR_friendly_army_canada";

// FLAGS
OPEX_friendly_flag_marker = "flag_Canada";
OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // e.g.: NATO
OPEX_friendly_flag_country = "pictures\flag_canada.paa"; // e.g.: USA
OPEX_friendly_flag_army = "pictures\flag_army_canada.paa"; // e.g.: Camp Liberty
OPEX_friendly_insigna = "NATO";

// CAMP
OPEX_friendly_camp = "Camp Gretzky";
OPEX_sign_camp = "pictures\sign_camp_ca.paa";

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
OPEX_briefingBoard = "pictures\briefingboard_ca.paa";
OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep.paa";
OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives.paa";
OPEX_briefingScreen_intel = "pictures\briefingscreen_intel.paa";
OPEX_briefingScreen_roe = "pictures\briefingscreen_roe.paa";
OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy.paa";
OPEX_briefingScreen_questions = "pictures\briefingscreen_questions.paa";
OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing.paa";
OPEX_tv = "pictures\tv_generic.paa";
OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
OPEX_laptop_specialization = "pictures\laptop1610_specialization_generic.paa";
OPEX_keepclear = "pictures\keepclear_generic.paa";

// AI SKILL
OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

// IDENTITIES
/*
OPEX_friendly_identities = ["french_01", "french_02", "french_03", "french_04", "french_05", "french_06", "french_07", "french_08", "french_09", "french_10", "french_11", "french_12", "french_13", "french_14", "french_15", "french_16", "french_17", "french_18", "french_19", "french_20", "french_21", "french_22", "french_23", "french_24", "french_25", "french_26", "french_27", "french_28", "french_29", "french_30", "french_31", "french_32", "french_33", "french_34", "french_35", "french_36", "french_37", "french_38", "french_39", "french_40", "french_41", "french_42", "french_43", "french_44", "french_45", "french_46", "french_47", "french_48", "french_49", "french_50", "french_51", "french_52", "french_53", "french_54", "french_55", "french_56", "french_57", "french_58", "french_59", "french_60", "french_61", "french_62", "french_63", "french_64", "french_65", "french_66", "french_67", "french_68", "french_69", "french_70"];
*/

// VEHICLES
OPEX_friendly_transportTrucksOpened_woodland = ["TFC_Truck_MLVW_TT_open","TFC_Truck_MLVW_TT_11A_open","TFC_Truck_MLVW_TT_11B_open","TFC_Truck_MLVW_TT_11C_open","TFC_Truck_MLVW_TT_11D_open","TFC_Truck_MLVW_TT_E11_open"];
OPEX_friendly_transportTrucksOpened_desert = ["TFC_Truck_MLVW_TT_open","TFC_Truck_MLVW_TT_11A_open","TFC_Truck_MLVW_TT_11B_open","TFC_Truck_MLVW_TT_11C_open","TFC_Truck_MLVW_TT_11D_open","TFC_Truck_MLVW_TT_E11_open"];
OPEX_friendly_transportTrucksOpened_snow = ["TFC_Truck_MLVW_TT_open","TFC_Truck_MLVW_TT_11A_open","TFC_Truck_MLVW_TT_11B_open","TFC_Truck_MLVW_TT_11C_open","TFC_Truck_MLVW_TT_11D_open","TFC_Truck_MLVW_TT_E11_open"];
OPEX_friendly_transportTrucksCovered_woodland = ["TFC_Truck_MLVW_TT_covered","TFC_Truck_MLVW_TT_11A_covered","TFC_Truck_MLVW_TT_11B_covered","TFC_Truck_MLVW_TT_11C_covered","TFC_Truck_MLVW_TT_11D_covered","TFC_Truck_MLVW_TT_E11_covered"];
OPEX_friendly_transportTrucksCovered_desert = ["TFC_Truck_MLVW_TT_covered","TFC_Truck_MLVW_TT_11A_covered","TFC_Truck_MLVW_TT_11B_covered","TFC_Truck_MLVW_TT_11C_covered","TFC_Truck_MLVW_TT_11D_covered","TFC_Truck_MLVW_TT_E11_covered"];
OPEX_friendly_transportTrucksCovered_snow = ["TFC_Truck_MLVW_TT_covered","TFC_Truck_MLVW_TT_11A_covered","TFC_Truck_MLVW_TT_11B_covered","TFC_Truck_MLVW_TT_11C_covered","TFC_Truck_MLVW_TT_11D_covered","TFC_Truck_MLVW_TT_E11_covered"];
OPEX_friendly_fuelTrucks_woodland = ["TFC_Truck_MLVW_fuel_58P"];
OPEX_friendly_fuelTrucks_desert = ["TFC_Truck_MLVW_fuel_58P"];
OPEX_friendly_fuelTrucks_snow = ["TFC_Truck_MLVW_fuel_58P"];
OPEX_friendly_logisticTrucks_woodland = ["TFC_Truck_MLVW_CP","TFC_Truck_MLVW_CP2"];
OPEX_friendly_logisticTrucks_desert = ["TFC_Truck_MLVW_CP","TFC_Truck_MLVW_CP2"];
OPEX_friendly_logisticTrucks_snow = ["TFC_Truck_MLVW_CP","TFC_Truck_MLVW_CP2"];
OPEX_friendly_medicalTrucks_woodland = ["TFC_Truck_MLVW_Medical"];
OPEX_friendly_medicalTrucks_desert = ["TFC_Truck_MLVW_Medical"];
OPEX_friendly_medicalTrucks_snow = ["TFC_Truck_MLVW_Medical"];
OPEX_friendly_repairTrucks_woodland = ["TFC_Truck_MLVW_repair_58R"];
OPEX_friendly_repairTrucks_desert = ["TFC_Truck_MLVW_repair_58R"];
OPEX_friendly_repairTrucks_snow = ["TFC_Truck_MLVW_repair_58R"];
OPEX_friendly_ammoTrucks_woodland = ["TFC_Truck_MLVW_Supply_58S"];
OPEX_friendly_ammoTrucks_desert = ["TFC_Truck_MLVW_Supply_58S"];
OPEX_friendly_ammoTrucks_snow = ["TFC_Truck_MLVW_Supply_58S"];
OPEX_friendly_transportCars_woodland = ["B_MRAP_01_F"];
OPEX_friendly_transportCars_desert = ["B_MRAP_01_F"];
OPEX_friendly_transportCars_snow = ["B_MRAP_01_F"];
OPEX_friendly_combatCarsMG_woodland = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsMG_desert = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsMG_snow = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsGL_woodland = ["B_MRAP_01_gmg_F"];
OPEX_friendly_combatCarsGL_desert = ["B_MRAP_01_gmg_F"];
OPEX_friendly_combatCarsGL_snow = ["B_MRAP_01_gmg_F"];
OPEX_friendly_vtt_woodland = ["TFC_Wheeled_LAV6_ISC","TFC_Wheeled_LAV6_ISC_11","TFC_Wheeled_LAV6_ISC_11A","TFC_Wheeled_LAV6_ISC_11B","TFC_Wheeled_LAV6_ISC_11C"];
OPEX_friendly_vtt_desert = ["TFC_Wheeled_LAV6_ISC_AR","TFC_Wheeled_LAV6_ISC_11_AR","TFC_Wheeled_LAV6_ISC_11A_AR","TFC_Wheeled_LAV6_ISC_11B_AR","TFC_Wheeled_LAV6_ISC_11C_AR"];
OPEX_friendly_vtt_snow = ["TFC_Wheeled_LAV6_ISC_UN","TFC_Wheeled_LAV6_ISC_11_UN","TFC_Wheeled_LAV6_ISC_11A_UN","TFC_Wheeled_LAV6_ISC_11B_UN","TFC_Wheeled_LAV6_ISC_11C_UN"];
OPEX_friendly_tanks_woodland = ["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"];
OPEX_friendly_tanks_desert = ["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"];
OPEX_friendly_tanks_snow = ["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"];
OPEX_friendly_quads_woodland = ["B_Quadbike_01_F"];
OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
OPEX_friendly_quads_snow = ["B_Quadbike_01_F"];
OPEX_friendly_zodiacs = ["B_Boat_Transport_01_F"];
OPEX_friendly_ships = ["B_Boat_Armed_01_minigun_F"];
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
OPEX_friendly_mediumTransportHelicopters_woodland = ["tfc_heli_ch146401","tfc_heli_ch146405","tfc_heli_ch146407","tfc_heli_ch146412","tfc_heli_ch146444","tfc_heli_ch146459"];
OPEX_friendly_mediumTransportHelicopters_desert = ["tfc_heli_ch146401","tfc_heli_ch146405","tfc_heli_ch146407","tfc_heli_ch146412","tfc_heli_ch146444","tfc_heli_ch146459"];
OPEX_friendly_mediumTransportHelicopters_snow = ["tfc_heli_ch146401","tfc_heli_ch146405","tfc_heli_ch146407","tfc_heli_ch146412","tfc_heli_ch146444","tfc_heli_ch146459"];
OPEX_friendly_bigTransportHelicopters_woodland = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
OPEX_friendly_bigTransportHelicopters_desert = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
OPEX_friendly_bigTransportHelicopters_snow = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
OPEX_friendly_UAVs = ["B_UAV_02_dynamicLoadout_F"];
OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_olive_F"];
OPEX_friendly_portableDrones = ["B_UAV_01_F"];
OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
OPEX_friendly_MGstatics = ["B_HMG_01_high_F"];
OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
OPEX_friendly_ATstatics = ["B_Static_AT_F"];
OPEX_friendly_AAstatics = ["B_Static_AA_F"];
OPEX_friendly_mortarStatics = ["B_Mortar_01_F"];

// WEAPONS
OPEX_friendly_commonHandguns = ["tfc_bhp"];
OPEX_friendly_specialHandguns = ["tfc_bhp"];
OPEX_friendly_commonRifles = ["tfc_c7a2"];
OPEX_friendly_specialRifles = ["tfc_mrr_carbine_Black"];
OPEX_friendly_GLrifles = ["tfc_c7a2_m203"];
OPEX_friendly_MGriflesLight = ["tfc_c9a2"];
OPEX_friendly_MGriflesHeavy = ["TFC_C6"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["SMG_02_F"];
OPEX_friendly_precisionRifles = ["tfc_mrr_rifle_black"];
OPEX_friendly_sniperRifles = ["tfc_c20_rifle"];
OPEX_friendly_ATlaunchers = ["launch_NLAW_F"];
OPEX_friendly_AAlaunchers = ["launch_B_Titan_olive_F"];
OPEX_friendly_shotguns = ["tfc_mrr_rifle_black"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["tfc_c79_Elcan","tfc_c79_Elcan","tfc_c79_Elcan","optic_aco", "optic_aco_grn", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_Holosight_blk_F", "optic_Holosight_smg_blk_F"];
OPEX_friendly_distantCombatOptics = ["optic_Arco_blk_F", "optic_MRCO", "optic_hamr", "optic_ERCO_blk_F"];
OPEX_friendly_sniperOptics = ["optic_LRPS", "optic_SOS", "optic_DMS", "optic_Nightstalker", "optic_tws"];
OPEX_friendly_flashlights = ["acc_flashlight"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_H", "muzzle_snds_I", "muzzle_snds_M", "muzzle_snds_B"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L"];
OPEX_friendly_pointers = ["acc_pointer_IR"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["TFC_U_CombatUniform_OTW_CADPAT_TW"];
OPEX_friendly_commonUniforms_desert = ["TFC_U_CombatUniform_OTW_CADPAT_AR"];
OPEX_friendly_commonUniforms_snow = ["TFC_U_CombatUniform_OTW_CADPAT_WI"];
OPEX_friendly_specialUniforms_woodland = ["TFC_U_CombatUniform_OTW_CADPAT_TW"];
OPEX_friendly_specialUniforms_desert = ["TFC_U_CombatUniform_OTW_CADPAT_AR"];
OPEX_friendly_specialUniforms_snow = ["TFC_U_CombatUniform_OTW_CADPAT_WI"];
OPEX_friendly_ghillieUniforms_woodland = ["U_B_FullGhillie_sard","U_B_FullGhillie_lsh"];
OPEX_friendly_ghillieUniforms_desert = ["U_B_FullGhillie_ard"];
OPEX_friendly_ghillieUniforms_snow = ["U_B_FullGhillie_ard", "U_I_FullGhillie_sard", "U_B_GhillieSuit"];
OPEX_friendly_heliPilotUniforms_woodland = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_heliPilotUniforms_desert = ["TFC_U_AircrewUniform_tachel_ar"];
OPEX_friendly_heliPilotUniforms_snow = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_aircraftPilotUniforms_desert = ["TFC_U_AircrewUniform_tachel_ar"];
OPEX_friendly_aircraftPilotUniforms_snow = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_tankPilotUniforms_woodland = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_tankPilotUniforms_desert = ["TFC_U_AircrewUniform_tachel_ar"];
OPEX_friendly_tankPilotUniforms_snow = ["TFC_U_AircrewUniform_tachel_tw"];
OPEX_friendly_medicUniforms_woodland = ["TFC_U_CombatUniform_OTW_CADPAT_TW"];
OPEX_friendly_medicUniforms_desert = ["TFC_U_CombatUniform_OTW_CADPAT_AR"];
OPEX_friendly_medicUniforms_snow = ["TFC_U_CombatUniform_OTW_CADPAT_WI"];
OPEX_friendly_instructorUniforms_woodland = ["TFC_U_CombatUniform_OTW_CADPAT_TW"];
OPEX_friendly_instructorUniforms_desert = ["TFC_U_CombatUniform_OTW_CADPAT_AR"];
OPEX_friendly_instructorUniforms_snow = ["TFC_U_CombatUniform_OTW_CADPAT_WI"];
OPEX_friendly_tshirtUniforms_woodland = ["TFC_U_CombatUniform_OTW_CADPAT_TW"];
OPEX_friendly_tshirtUniforms_desert = ["TFC_U_CombatUniform_OTW_CADPAT_AR"];
OPEX_friendly_tshirtUniforms_snow = ["TFC_U_CombatUniform_OTW_CADPAT_WI"];
OPEX_friendly_diverUniforms = ["U_B_Wetsuit"];

// VESTS
OPEX_friendly_commonVests_woodland = ["TFC_V_SORD","TFC_V_SORD_01","TFC_V_SORD_02","TFC_V_SORD_03"];
OPEX_friendly_commonVests_desert = ["TFC_V_SORD","TFC_V_SORD_01","TFC_V_SORD_02","TFC_V_SORD_03"];
OPEX_friendly_commonVests_snow = ["TFC_V_SORD","TFC_V_SORD_01","TFC_V_SORD_02","TFC_V_SORD_03"];
OPEX_friendly_specialVests_woodland = ["TFC_V_SORD_Ballistic_TW","TFC_V_SORD_Ballistic_01_TW","TFC_V_SORD_Ballistic_02_TW","TFC_V_SORD_Ballistic_03_TW"];
OPEX_friendly_specialVests_desert = ["TFC_V_SORD_Ballistic_AR","TFC_V_SORD_Ballistic_01_AR","TFC_V_SORD_Ballistic_02_AR","TFC_V_SORD_Ballistic_03_AR"];
OPEX_friendly_specialVests_snow = ["TFC_V_SORD","TFC_V_SORD_01","TFC_V_SORD_02","TFC_V_SORD_03"];
OPEX_friendly_medicVests_woodland = ["TFC_V_SORD"];
OPEX_friendly_medicVests_desert = ["TFC_V_SORD"];
OPEX_friendly_medicVests_snow = ["TFC_V_SORD"];
OPEX_friendly_beltVests_woodland = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_desert = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_snow = ["V_Rangemaster_belt"];
OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_snow = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests_woodland = ["TFC_V_SORD"];
OPEX_friendly_lightVests_desert = ["TFC_V_SORD"];
OPEX_friendly_lightVests_snow = ["TFC_V_SORD"];
OPEX_friendly_grenadierVests_woodland = ["TFC_V_SORD_Ballistic_03_TW"];
OPEX_friendly_grenadierVests_desert = ["TFC_V_SORD_Ballistic_03_AR"];
OPEX_friendly_grenadierVests_snow = ["TFC_V_SORD"];
OPEX_friendly_EODvests_woodland = ["TFC_V_SORD_Ballistic_03_TW"];
OPEX_friendly_EODvests_desert = ["TFC_V_SORD_Ballistic_03_AR"];
OPEX_friendly_EODvests_snow = ["TFC_V_SORD"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["TFC_H_Helmet_CG634_CADPAT_NG_TW","TFC_H_Helmet_CG634_CADPAT_NG_TW","TFC_H_Helmet_CG634_CADPAT_TW"];
OPEX_friendly_commonHelmets_desert = ["TFC_H_Helmet_CG634_CADPAT_NG_AR","TFC_H_Helmet_CG634_CADPAT_NG_AR","TFC_H_Helmet_CG634_CADPAT_AR"];
OPEX_friendly_commonHelmets_snow = ["TFC_H_Helmet_CG634_CADPAT_NG_WI","TFC_H_Helmet_CG634_CADPAT_NG_WI","TFC_H_Helmet_CG634_CADPAT_WI"];
OPEX_friendly_specialHelmets_woodland = ["TFC_H_Helmet_CG634_CADPAT_Scrimnet_NG_TW","TFC_H_Helmet_CG634_CADPAT_NET_TW","TFC_H_Helmet_FAST_MCAM"];
OPEX_friendly_specialHelmets_desert = ["TFC_H_Helmet_CG634_CADPAT_Scrimnet_NG_AR","TFC_H_Helmet_CG634_CADPAT_NET_AR","TFC_H_Helmet_FAST_MCAM"];
OPEX_friendly_specialHelmets_snow = ["TFC_H_Helmet_CG634_CADPAT_Scrimnet_NG_WI","TFC_H_Helmet_CG634_CADPAT_NET_WI","TFC_H_Helmet_FAST_MCAM"];
OPEX_friendly_EODhelmets_woodland = OPEX_friendly_commonHelmets_woodland;
OPEX_friendly_EODhelmets_desert = OPEX_friendly_commonHelmets_desert;
OPEX_friendly_EODhelmets_snow = OPEX_friendly_commonHelmets_snow;
OPEX_friendly_heliPilotHelmets = ["TFC_H_Helmet_Helo_Pilot"];
OPEX_friendly_aircraftPilotHelmets = ["TFC_H_Helmet_Helo_Crew"];
OPEX_friendly_tankCrewHelmets = ["TFC_H_Helmet_Helo_Pilot"];
OPEX_friendly_cameraHelmets_woodland = ["H_HelmetSpecB", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_snakeskin", "H_HelmetB_light", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_snakeskin"];
OPEX_friendly_cameraHelmets_desert = ["H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets_snow = ["H_HelmetSpecB_blk", "H_HelmetB_light_black"];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
OPEX_friendly_hats_woodland = ["TFC_H_Booniehat_CADPAT_TW"];
OPEX_friendly_hats_desert = ["TFC_H_Booniehat_CADPAT_AR"];
OPEX_friendly_hats_snow = ["TFC_H_Booniehat_CADPAT_J"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_leaderHeadgear_woodland = ["H_Beret_02", "H_MilCap_grn"];
OPEX_friendly_leaderHeadgear_desert = ["H_Beret_02", "H_MilCap_mcamo"];
OPEX_friendly_leaderHeadgear_snow = ["H_Beret_02", "H_MilCap_tna_F"];
OPEX_friendly_berets = ["tfc_H_Beret_12eRBC","tfc_H_Beret_para","tfc_H_Beret_bcr","tfc_H_Beret_canadianArmy","tfc_H_Beret_caf","tfc_H_Beret_cer","tfc_H_Beret_csor","tfc_H_Beret_fgh","tfc_H_Beret_hr","tfc_H_Beret_kocr","tfc_H_Beret_ldsh","tfc_H_Beret_nsh","tfc_H_Beret_peir","tfc_H_Beret_ppcli","tfc_H_Beret_pwor","tfc_H_Beret_r22er","tfc_H_Beret_rcacc","tfc_H_Beret_rcacs","tfc_H_Beret_rcaf","tfc_H_Beret_rcd","tfc_H_Beret_rch","tfc_H_Beret_rcn","tfc_H_Beret_rcscc","tfc_H_Beret_rhr","tfc_H_Beret_rhfc","tfc_H_Beret_RMRang","tfc_H_Beret_seaforthOfC","tfc_H_Beret_tsr","tfc_H_Beret_viii"];
OPEX_friendly_caps = ["tfc_Headgear_BCAP","tfc_Headgear_BCAP","tfc_Headgear_BCAP","tfc_cap_canadianRangers","tfc_Headgear_BCAP_Back"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F"];

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Combat","TFC_G_Ballistics_Clear"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted","TFC_G_Ballistics_Dark","TFC_G_Ballistics_Dark","TFC_G_Ballistics_Dark","TFC_G_Ballistics_Orange","TFC_G_Ballistics_Yellow"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["tfc_Carryall_tw","tfc_AssaultPack_TW"];
OPEX_friendly_mediumBackpacks_desert = ["tfc_Carryall_AR","tfc_AssaultPack_AR"];
OPEX_friendly_mediumBackpacks_snow = ["tfc_Carryall_tw","tfc_AssaultPack_TW"];
OPEX_friendly_bigBackpacks_woodland = ["tfc_Carryall_84mm_TW","TFC_CTS_Rucksack_TW"];
OPEX_friendly_bigBackpacks_desert = ["tfc_Carryall_84mm_AR","TFC_CTS_Rucksack_AR"];
OPEX_friendly_bigBackpacks_snow = ["tfc_Carryall_84mm_TW","TFC_CTS_Rucksack_WI"];
OPEX_friendly_medicBackpacks_woodland = ["tfc_Carryall_Med_TW","tfc_Carryall_Med_PJ"];
OPEX_friendly_medicBackpacks_desert = ["tfc_Carryall_Med_AR","tfc_Carryall_Med_PJ"];
OPEX_friendly_medicBackpacks_snow = ["tfc_Carryall_Med_TW","tfc_Carryall_Med_PJ"];
OPEX_friendly_radioBackpacks_woodland = ["TFC_tf_rt1523g_TW"];
OPEX_friendly_radioBackpacks_desert = ["TFC_tf_rt1523g_AR"];
OPEX_friendly_radioBackpacks_snow = ["TFC_tf_rt1523g_WI"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];