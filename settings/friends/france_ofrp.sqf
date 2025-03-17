// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Mod"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Characters"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "OFrP_A3_Weapons"))) exitWith {};

// DEFINING FACTION NAMES
_OPEX_friendly_modName = "OFrP"; // e.g.: "RHS"
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
OPEX_friendly_transportTrucksOpened_woodland = ["B_T_Truck_01_covered_F"];
OPEX_friendly_transportTrucksOpened_desert = ["B_Truck_01_covered_F"];
OPEX_friendly_transportTrucksOpened_snow = ["B_T_Truck_01_covered_F"];
OPEX_friendly_transportTrucksCovered_woodland = ["B_T_Truck_01_transport_F"];
OPEX_friendly_transportTrucksCovered_desert = ["B_Truck_01_transport_F"];
OPEX_friendly_transportTrucksCovered_snow = ["B_T_Truck_01_transport_F"];
OPEX_friendly_fuelTrucks_woodland = ["B_T_Truck_01_fuel_F"];
OPEX_friendly_fuelTrucks_desert = ["B_Truck_01_fuel_F"];
OPEX_friendly_fuelTrucks_snow = ["B_T_Truck_01_fuel_F"];
OPEX_friendly_logisticTrucks_woodland = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_desert = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_snow = ["B_T_Truck_01_box_F"];
OPEX_friendly_medicalTrucks_woodland = ["B_T_Truck_01_medical_F"];
OPEX_friendly_medicalTrucks_desert = ["B_Truck_01_medical_F"];
OPEX_friendly_medicalTrucks_snow = ["B_T_Truck_01_medical_F"];
OPEX_friendly_repairTrucks_woodland = ["B_T_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_desert = ["B_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_snow = ["B_T_Truck_01_Repair_F"];
OPEX_friendly_ammoTrucks_woodland = ["B_T_Truck_01_ammo_F"];
OPEX_friendly_ammoTrucks_desert = ["B_Truck_01_ammo_F"];
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
OPEX_friendly_MGstatics = ["OFrP_V_AANF1_Static"];
OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
OPEX_friendly_ATstatics = ["B_T_Static_AT_F"];
OPEX_friendly_AAstatics = ["B_T_Static_AA_F"];
OPEX_friendly_mortarStatics = ["B_T_Mortar_01_F"];

// WEAPONS
OPEX_friendly_commonHandguns = ["OFrP_PAMAS"];
OPEX_friendly_specialHandguns = ["OFrP_Glock17_Gen4"];
OPEX_friendly_commonRifles = ["OFrP_FAMAS_F1"];
OPEX_friendly_specialRifles = ["OFrP_FAMAS_FELIN","OFrP_FAMAS_VAL","OFrP_HK416F_C","OFrP_HK416F_S"];
OPEX_friendly_GLrifles = ["OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_F1_GLM203","OFrP_FAMAS_VAL_GLM203","OFrP_HK416F_C_HK269","OFrP_HK416F_S_HK269","OFrP_HK417A1_20"];
OPEX_friendly_MGriflesLight = ["OFrP_Minimi_Para_556"];
OPEX_friendly_MGriflesHeavy = ["OFrP_Minimi_Para_762"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
OPEX_friendly_compactRifles = ["OFrP_HK416F_C"];
OPEX_friendly_precisionRifles = ["OFrP_FRF2"];
OPEX_friendly_sniperRifles = ["OFrP_PGM_Hecate2"];
OPEX_friendly_ATlaunchers = ["OFrP_AT4CS","OFrP_AT4CS","OFrP_ERYX"];
//OPEX_friendly_AAlaunchers = [];
OPEX_friendly_shotguns = ["OFrP_HK416F_C"];
//OPEX_friendly_diverRifles = [];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics append ["OFrP_OpticItem_EOTech_552"];
OPEX_friendly_distantCombatOptics append ["OFrP_OpticItem_AIMPoint_CompM2M68","OFrP_EOTech_Magnifier_UP","OFrP_OpticItem_Scrome_J4_Famas"];
OPEX_friendly_sniperOptics append ["OFrP_OpticItem_SwordTD","OFrP_OpticItem_Scrome_J10","OFrP_OpticItem_Scrome_J8"];
//OPEX_friendly_flashlights append [];
//OPEX_friendly_rifleSilencers append [];
//OPEX_friendly_handgunSilencers append [];
OPEX_friendly_pointers append ["OFrP_pointer_PIRAT_EL9A","OFrP_pointer_PIRAT_EL9B"];
OPEX_friendly_bipods append ["ofrp_acc_grip1"];

// VARIOUS ITEMS
OPEX_friendly_NVGs = ["OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie","OFrP_Lucie_Mask","OFrP_OVD"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV","OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_commonUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV"];
OPEX_friendly_commonUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_specialUniforms_woodland = ["OFrP_Uniform_T4S2_UBAS_CE01_FRHV_SDTBV"];
OPEX_friendly_specialUniforms_desert = ["OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_Short_DA_FRHV_SDTHV","OFrP_Uniform_T4S2_UBAS_DA01_FRHV_SDTBV","OFrP_Uniform_T4S2_UBAS_SE01_FRHV_SDTBV"];
OPEX_friendly_specialUniforms_snow = ["OFrP_Uniform_T4S2_UBAS_CE01_FRHV_SDTBV"];
OPEX_friendly_ghillieUniforms_woodland = ["U_I_FullGhillie_sard"];
OPEX_friendly_ghillieUniforms_desert = ["U_B_FullGhillie_ard"];
OPEX_friendly_ghillieUniforms_snow = ["U_B_FullGhillie_sard"];
OPEX_friendly_heliPilotUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_heliPilotUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV"];
OPEX_friendly_heliPilotUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
OPEX_friendly_aircraftPilotUniforms_desert = ["OFrP_Uniform_T4S2_Full_DA_FRHV_SDTHV"];
OPEX_friendly_aircraftPilotUniforms_snow = ["OFrP_Uniform_T4S2_Full_CE_FRHV_SDTHV"];
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
OPEX_friendly_EODhelmets_woodland = OPEX_friendly_commonHelmets_woodland;
OPEX_friendly_EODhelmets_desert = OPEX_friendly_commonHelmets_desert;
OPEX_friendly_EODhelmets_snow = OPEX_friendly_commonHelmets_snow;
OPEX_friendly_heliPilotHelmets = ["H_PilotHelmetHeli_B"];
OPEX_friendly_aircraftPilotHelmets = ["H_PilotHelmetFighter_B"];
OPEX_friendly_tankCrewHelmets = ["OFrP_Helmet_Spectra_OD","OFrP_Helmet_Spectra_ESSCOVER_OD"];
OPEX_friendly_hats_woodland = ["OFrP_Hat_Bob_CE"];
OPEX_friendly_hats_desert = ["OFrP_Hat_Bob_DA"];
OPEX_friendly_hats_snow = ["OFrP_Hat_Bob_CE"];
//OPEX_friendly_beanies_woodland append [];
//OPEX_friendly_beanies_desert append [];
//OPEX_friendly_beanies_snow append [];
OPEX_friendly_leaderHeadgear_woodland = ["OFrP_Hat_Beret_TDM","OFrP_Hat_Beret_Train","OFrP_Hat_Beret_1RHC","OFrP_Hat_Beret_3RHC","OFrP_Hat_Beret_5RHC","OFrP_Hat_Beret_4CCT","OFrP_Hat_Beret_1RA","OFrP_Hat_Beret_68RAA","OFrP_Hat_Beret_11RAMA","OFrP_Hat_Beret_1RC","OFrP_Hat_Beret_3RG","OFrP_Hat_Beret_6RG","OFrP_Hat_Beret_5RD","OFrP_Hat_Beret_7CCT","OFrP_Hat_Beret_9CCTMA","OFrP_Hat_Beret_1RI","OFrP_Hat_Beret_24RI","OFrP_Hat_Beret_35RI","OFrP_Hat_Beret_92RI","OFrP_Hat_Beret_126RI","OFrP_Hat_Beret_152RI","OFrP_Hat_Beret_1RCP","OFrP_Hat_Beret_16BC","OFrP_Hat_Beret_1RPIMA","OFrP_Hat_Beret_2RPIMA","OFrP_Hat_Beret_3RPIMA","OFrP_Hat_Beret_6RPIMA","OFrP_Hat_Beret_8RPIMA","OFrP_Hat_Beret_1RHP","OFrP_Hat_Beret_2RH","OFrP_Hat_Beret_3RH","OFrP_Hat_Beret_CM","OFrP_Hat_Beret_Legion","OFrP_Hat_Beret_CPA"];
OPEX_friendly_leaderHeadgear_desert = ["OFrP_Hat_Beret_TDM","OFrP_Hat_Beret_Train","OFrP_Hat_Beret_1RHC","OFrP_Hat_Beret_3RHC","OFrP_Hat_Beret_5RHC","OFrP_Hat_Beret_4CCT","OFrP_Hat_Beret_1RA","OFrP_Hat_Beret_68RAA","OFrP_Hat_Beret_11RAMA","OFrP_Hat_Beret_1RC","OFrP_Hat_Beret_3RG","OFrP_Hat_Beret_6RG","OFrP_Hat_Beret_5RD","OFrP_Hat_Beret_7CCT","OFrP_Hat_Beret_9CCTMA","OFrP_Hat_Beret_1RI","OFrP_Hat_Beret_24RI","OFrP_Hat_Beret_35RI","OFrP_Hat_Beret_92RI","OFrP_Hat_Beret_126RI","OFrP_Hat_Beret_152RI","OFrP_Hat_Beret_1RCP","OFrP_Hat_Beret_16BC","OFrP_Hat_Beret_1RPIMA","OFrP_Hat_Beret_2RPIMA","OFrP_Hat_Beret_3RPIMA","OFrP_Hat_Beret_6RPIMA","OFrP_Hat_Beret_8RPIMA","OFrP_Hat_Beret_1RHP","OFrP_Hat_Beret_2RH","OFrP_Hat_Beret_3RH","OFrP_Hat_Beret_CM","OFrP_Hat_Beret_Legion","OFrP_Hat_Beret_CPA"];
OPEX_friendly_leaderHeadgear_snow = ["OFrP_Hat_Beret_TDM","OFrP_Hat_Beret_Train","OFrP_Hat_Beret_1RHC","OFrP_Hat_Beret_3RHC","OFrP_Hat_Beret_5RHC","OFrP_Hat_Beret_4CCT","OFrP_Hat_Beret_1RA","OFrP_Hat_Beret_68RAA","OFrP_Hat_Beret_11RAMA","OFrP_Hat_Beret_1RC","OFrP_Hat_Beret_3RG","OFrP_Hat_Beret_6RG","OFrP_Hat_Beret_5RD","OFrP_Hat_Beret_7CCT","OFrP_Hat_Beret_9CCTMA","OFrP_Hat_Beret_1RI","OFrP_Hat_Beret_24RI","OFrP_Hat_Beret_35RI","OFrP_Hat_Beret_92RI","OFrP_Hat_Beret_126RI","OFrP_Hat_Beret_152RI","OFrP_Hat_Beret_1RCP","OFrP_Hat_Beret_16BC","OFrP_Hat_Beret_1RPIMA","OFrP_Hat_Beret_2RPIMA","OFrP_Hat_Beret_3RPIMA","OFrP_Hat_Beret_6RPIMA","OFrP_Hat_Beret_8RPIMA","OFrP_Hat_Beret_1RHP","OFrP_Hat_Beret_2RH","OFrP_Hat_Beret_3RH","OFrP_Hat_Beret_CM","OFrP_Hat_Beret_Legion","OFrP_Hat_Beret_CPA"];
OPEX_friendly_berets = ["OFrP_Hat_Beret_TDM","OFrP_Hat_Beret_Train","OFrP_Hat_Beret_1RHC","OFrP_Hat_Beret_3RHC","OFrP_Hat_Beret_5RHC","OFrP_Hat_Beret_4CCT","OFrP_Hat_Beret_1RA","OFrP_Hat_Beret_68RAA","OFrP_Hat_Beret_11RAMA","OFrP_Hat_Beret_1RC","OFrP_Hat_Beret_3RG","OFrP_Hat_Beret_6RG","OFrP_Hat_Beret_5RD","OFrP_Hat_Beret_7CCT","OFrP_Hat_Beret_9CCTMA","OFrP_Hat_Beret_1RI","OFrP_Hat_Beret_24RI","OFrP_Hat_Beret_35RI","OFrP_Hat_Beret_92RI","OFrP_Hat_Beret_126RI","OFrP_Hat_Beret_152RI","OFrP_Hat_Beret_1RCP","OFrP_Hat_Beret_16BC","OFrP_Hat_Beret_1RPIMA","OFrP_Hat_Beret_2RPIMA","OFrP_Hat_Beret_3RPIMA","OFrP_Hat_Beret_6RPIMA","OFrP_Hat_Beret_8RPIMA","OFrP_Hat_Beret_1RHP","OFrP_Hat_Beret_2RH","OFrP_Hat_Beret_3RH","OFrP_Hat_Beret_CM","OFrP_Hat_Beret_Legion","OFrP_Hat_Beret_CPA"];
OPEX_friendly_caps = ["H_Cap_tan","H_Cap_blk","H_Cap_oli"];
//OPEX_friendly_bandanas append [];
//OPEX_friendly_shemags append [];
OPEX_friendly_headsets append ["H_Cap_oli_hs"];

// FACEGEAR
//OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli", "R3F_cagoule_noire", "R3F_cagoule_olive", "R3F_cagoule_tan"];
//OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
//OPEX_friendly_glasses = ["G_Squares", "G_Combat", "R3F_lunettes_X800", "R3F_lunettes_ESS"];
//OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator"];
//OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
//OPEX_friendly_diverGlasses = ["G_B_Diving"];
if (isClass (configFile >> "CfgPatches" >> "rhsusf_main")) then {OPEX_friendly_glasses append ["rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw"]; OPEX_friendly_sunglasses append ["rhs_googles_black"]};

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_rgr","B_AssaultPack_blk","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
OPEX_friendly_mediumBackpacks_desert = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_cbr","B_Kitbag_cbr","B_Kitbag_tan"];
OPEX_friendly_mediumBackpacks_snow = ["OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","OFrP_Bag_CamelbakBFM500_OD","OFrP_Bag_Felin_45L","B_AssaultPack_khk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_rgr","B_AssaultPack_blk","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_rgr","B_TacticalPack_blk","B_TacticalPack_oli"];
OPEX_friendly_bigBackpacks_woodland = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_oli"];
OPEX_friendly_bigBackpacks_desert = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_cbr"];
OPEX_friendly_bigBackpacks_snow = ["OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","OFrP_Bag_CrusaderIII","B_Carryall_oli"];
OPEX_friendly_medicBackpacks_woodland = OPEX_friendly_mediumBackpacks_woodland;
OPEX_friendly_medicBackpacks_desert = OPEX_friendly_mediumBackpacks_desert;
OPEX_friendly_medicBackpacks_snow = OPEX_friendly_mediumBackpacks_snow;
OPEX_friendly_radioBackpacks_woodland = ["OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","B_RadioBag_01_black_F","B_RadioBag_01_wdl_F"];
OPEX_friendly_radioBackpacks_desert = ["OFrP_Bag_Felin_45L_Radio"];
OPEX_friendly_radioBackpacks_snow = ["OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","OFrP_Bag_Felin_45L_Radio","B_RadioBag_01_black_F","B_RadioBag_01_wdl_F"];