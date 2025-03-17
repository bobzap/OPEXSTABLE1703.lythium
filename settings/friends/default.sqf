// FACTION
OPEX_friendly_side1 = west;
OPEX_friendly_side2 = "west";
OPEX_friendly_faction = "BLU_F";

// ===============================================================================
// ===============================================================================

// FACTION
OPEX_friendly_modName = "vanilla";
OPEX_friendly_factionName = "STR_friendly_mainFaction_UN";
OPEX_friendly_subFaction = "STR_friendly_subFaction_EU";

// ARMY NAME
OPEX_friendly_army = localize "STR_friendly_army_eu";

// FLAGS
OPEX_friendly_flag_marker = "flag_EU";
OPEX_friendly_flag_faction = "\A3\Data_F\Flags\Flag_uno_CO.paa"; // e.g.: NATO
OPEX_friendly_flag_country = "pictures\flag_eu.paa"; // e.g.: USA
OPEX_friendly_flag_army = "\A3\Data_F\Flags\Flag_uno_CO.paa"; // e.g.: Camp Liberty
OPEX_friendly_insigna = "UNO";

// CAMP
OPEX_friendly_camp = "Camp Gemini";
OPEX_sign_camp = "pictures\sign_camp_gemini.paa";

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
OPEX_briefingBoard = "pictures\briefingboard_generic.paa";
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

// AI GLOBAL SKILL
OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

// TRIGGERS
if (OPEX_friendly_side2 != "indep") then {OPEX_friendly_side3 = OPEX_friendly_side2} else {OPEX_friendly_side3 = "GUER"};
if (OPEX_friendly_side2 == "west") then {OPEX_triggerDetectedByEnemy = "EAST D"; OPEX_triggerDetectedByFriend = "WEST D"};
if (OPEX_friendly_side2 == "east") then {OPEX_triggerDetectedByEnemy = "WEST D"; OPEX_triggerDetectedByFriend = "EAST D"};
if (OPEX_friendly_side2 == "indep") then {OPEX_triggerDetectedByEnemy = "EAST D"; OPEX_triggerDetectedByFriend = "GUER D"};

// IDENTITIES
OPEX_friendly_identities = [];

// UNITS
OPEX_friendly_officer = "B_officer_F";
OPEX_friendly_teamLeader = "B_Soldier_SL_F";
OPEX_friendly_rifleman = "B_soldier_F";
OPEX_friendly_grenadier = "B_Soldier_GL_F";
OPEX_friendly_MGLight = "B_soldier_AAR_F";
OPEX_friendly_MGHeavy = "B_soldier_AR_F";
OPEX_friendly_AT = "B_soldier_AT_F";
OPEX_friendly_AA = "B_soldier_AA_F";
OPEX_friendly_ghillie = "B_sniper_F";
OPEX_friendly_spotter = "B_spotter_F";
OPEX_friendly_marksman = "B_soldier_M_F";
OPEX_friendly_scout = "B_recon_F";
OPEX_friendly_medic = "B_medic_F";
OPEX_friendly_repairer = "B_soldier_repair_F";
OPEX_friendly_sapper = "B_engineer_F";
OPEX_friendly_ammoAssistant = "B_Soldier_A_F";
OPEX_friendly_chopper_pilot = "B_Helipilot_F";
OPEX_friendly_aircraft_pilot = "B_pilot_F";
OPEX_friendly_crewman = "B_crew_F";
OPEX_friendly_diver = "B_diver_F";
OPEX_friendly_assault = "B_Soldier_lite_F";
OPEX_friendly_radioOperator = "B_Survivor_F";
OPEX_friendly_droneOperator = "B_soldier_UAV_F";
OPEX_friendly_interpret = "B_soldier_PG_F";
OPEX_friendly_commonUnits = [OPEX_friendly_rifleman, OPEX_friendly_grenadier, OPEX_friendly_MGLight, OPEX_friendly_MGHeavy, OPEX_friendly_AT, OPEX_friendly_marksman, OPEX_friendly_scout, OPEX_friendly_ammoAssistant];
OPEX_friendly_specialUnits = [OPEX_friendly_AA, OPEX_friendly_ghillie, OPEX_friendly_spotter, OPEX_friendly_medic, OPEX_friendly_repairer, OPEX_friendly_sapper, OPEX_friendly_radioOperator, OPEX_friendly_droneOperator, OPEX_friendly_interpret];
OPEX_friendly_units = OPEX_friendly_commonUnits + OPEX_friendly_commonUnits + OPEX_friendly_specialUnits;

// VEHICLES
OPEX_friendly_transportTrucksOpened_woodland = ["B_Truck_01_covered_F"];
OPEX_friendly_transportTrucksOpened_desert = ["B_Truck_01_covered_F"];
OPEX_friendly_transportTrucksOpened_snow = ["B_Truck_01_covered_F"];
OPEX_friendly_transportTrucksCovered_woodland = ["B_Truck_01_transport_F"];
OPEX_friendly_transportTrucksCovered_desert = ["B_Truck_01_transport_F"];
OPEX_friendly_transportTrucksCovered_snow = ["B_Truck_01_transport_F"];
OPEX_friendly_fuelTrucks_woodland = ["B_Truck_01_fuel_F"];
OPEX_friendly_fuelTrucks_desert = ["B_Truck_01_fuel_F"];
OPEX_friendly_fuelTrucks_snow = ["B_Truck_01_fuel_F"];
OPEX_friendly_logisticTrucks_woodland = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_desert = ["B_T_Truck_01_box_F"];
OPEX_friendly_logisticTrucks_snow = ["B_T_Truck_01_box_F"];
OPEX_friendly_medicalTrucks_woodland = ["B_Truck_01_medical_F"];
OPEX_friendly_medicalTrucks_desert = ["B_Truck_01_medical_F"];
OPEX_friendly_medicalTrucks_snow = ["B_Truck_01_medical_F"];
OPEX_friendly_repairTrucks_woodland = ["B_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_desert = ["B_Truck_01_Repair_F"];
OPEX_friendly_repairTrucks_snow = ["B_Truck_01_Repair_F"];
OPEX_friendly_ammoTrucks_woodland = ["B_Truck_01_ammo_F"];
OPEX_friendly_ammoTrucks_desert = ["B_Truck_01_ammo_F"];
OPEX_friendly_ammoTrucks_snow = ["B_Truck_01_ammo_F"];
OPEX_friendly_transportCars_woodland = ["B_MRAP_01_F"];
OPEX_friendly_transportCars_desert = ["B_MRAP_01_F"];
OPEX_friendly_transportCars_snow = ["B_MRAP_01_F"];
OPEX_friendly_combatCarsMG_woodland = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsMG_desert = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsMG_snow = ["B_MRAP_01_hmg_F"];
OPEX_friendly_combatCarsGL_woodland = ["B_MRAP_01_gmg_F"];
OPEX_friendly_combatCarsGL_desert = ["B_MRAP_01_gmg_F"];
OPEX_friendly_combatCarsGL_snow = ["B_MRAP_01_gmg_F"];
OPEX_friendly_vtt_woodland = ["B_APC_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F"];
OPEX_friendly_vtt_desert = ["B_APC_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F"];
OPEX_friendly_vtt_snow = ["B_APC_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F"];
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
OPEX_friendly_mediumTransportHelicopters_woodland = ["B_Heli_Transport_01_F"];
OPEX_friendly_mediumTransportHelicopters_desert = ["B_Heli_Transport_01_F"];
OPEX_friendly_mediumTransportHelicopters_snow = ["B_Heli_Transport_01_F"];
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

// DEFAULT VEHICLES (REFERENCE TO ALLOW CONVERSION TO OTHER MODS)
OPEX_friendly_transportTrucksOpened_woodland_default = OPEX_friendly_transportTrucksOpened_woodland;
OPEX_friendly_transportTrucksOpened_desert_default = OPEX_friendly_transportTrucksOpened_desert;
OPEX_friendly_transportTrucksOpened_snow_default = OPEX_friendly_transportTrucksOpened_snow;
OPEX_friendly_transportTrucksCovered_woodland_default = OPEX_friendly_transportTrucksCovered_woodland;
OPEX_friendly_transportTrucksCovered_desert_default = OPEX_friendly_transportTrucksCovered_desert;
OPEX_friendly_transportTrucksCovered_snow_default = OPEX_friendly_transportTrucksCovered_snow;
OPEX_friendly_fuelTrucks_woodland_default = OPEX_friendly_fuelTrucks_woodland;
OPEX_friendly_fuelTrucks_desert_default = OPEX_friendly_fuelTrucks_desert;
OPEX_friendly_fuelTrucks_desert_default = OPEX_friendly_fuelTrucks_desert;
OPEX_friendly_fuelTrucks_snow_default = OPEX_friendly_fuelTrucks_snow;
OPEX_friendly_logisticTrucks_woodland_default = OPEX_friendly_logisticTrucks_woodland;
OPEX_friendly_logisticTrucks_desert_default = OPEX_friendly_logisticTrucks_desert;
OPEX_friendly_logisticTrucks_snow_default = OPEX_friendly_logisticTrucks_snow;
OPEX_friendly_medicalTrucks_woodland_default = OPEX_friendly_medicalTrucks_woodland;
OPEX_friendly_medicalTrucks_desert_default = OPEX_friendly_medicalTrucks_desert;
OPEX_friendly_medicalTrucks_snow_default = OPEX_friendly_medicalTrucks_snow;
OPEX_friendly_repairTrucks_woodland_default = OPEX_friendly_repairTrucks_woodland;
OPEX_friendly_repairTrucks_desert_default = OPEX_friendly_repairTrucks_desert;
OPEX_friendly_repairTrucks_snow_default = OPEX_friendly_repairTrucks_snow;
OPEX_friendly_ammoTrucks_woodland_default = OPEX_friendly_ammoTrucks_woodland;
OPEX_friendly_ammoTrucks_desert_default = OPEX_friendly_ammoTrucks_desert;
OPEX_friendly_ammoTrucks_snow_default = OPEX_friendly_ammoTrucks_snow;
OPEX_friendly_transportCars_woodland_default = OPEX_friendly_transportCars_woodland;
OPEX_friendly_transportCars_desert_default = OPEX_friendly_transportCars_desert;
OPEX_friendly_transportCars_snow_default = OPEX_friendly_transportCars_snow;
OPEX_friendly_combatCarsMG_woodland_default = OPEX_friendly_combatCarsMG_woodland;
OPEX_friendly_combatCarsMG_desert_default = OPEX_friendly_combatCarsMG_desert;
OPEX_friendly_combatCarsMG_snow_default = OPEX_friendly_combatCarsMG_snow;
OPEX_friendly_combatCarsGL_woodland_default = OPEX_friendly_combatCarsGL_woodland;
OPEX_friendly_combatCarsGL_desert_default = OPEX_friendly_combatCarsGL_desert;
OPEX_friendly_combatCarsGL_snow_default = OPEX_friendly_combatCarsGL_snow;
OPEX_friendly_vtt_woodland_default = OPEX_friendly_vtt_woodland;
OPEX_friendly_vtt_desert_default = OPEX_friendly_vtt_desert;
OPEX_friendly_vtt_snow_default = OPEX_friendly_vtt_snow;
OPEX_friendly_tanks_woodland_default = OPEX_friendly_tanks_woodland;
OPEX_friendly_tanks_desert_default = OPEX_friendly_tanks_desert;
OPEX_friendly_tanks_snow_default = OPEX_friendly_tanks_snow;
OPEX_friendly_quads_woodland_default = OPEX_friendly_quads_woodland;
OPEX_friendly_quads_desert_default = OPEX_friendly_quads_desert;
OPEX_friendly_quads_snow_default = OPEX_friendly_quads_snow;
OPEX_friendly_zodiacs_default = OPEX_friendly_zodiacs;
OPEX_friendly_ships_default = OPEX_friendly_ships;
OPEX_friendly_aircrafts_default = OPEX_friendly_aircrafts;
OPEX_friendly_smallCombatHelicopters_woodland_default = OPEX_friendly_smallCombatHelicopters_woodland;
OPEX_friendly_smallCombatHelicoptersCombat_desert_default = OPEX_friendly_smallCombatHelicopters_desert;
OPEX_friendly_smallCombatHelicoptersCombat_snow_default = OPEX_friendly_smallCombatHelicopters_snow;
OPEX_friendly_mediumCombatHelicopters_woodland_default = OPEX_friendly_mediumCombatHelicopters_woodland;
OPEX_friendly_mediumCombatHelicoptersCombat_desert_default = OPEX_friendly_mediumCombatHelicopters_desert;
OPEX_friendly_mediumCombatHelicoptersCombat_snow_default = OPEX_friendly_mediumCombatHelicopters_snow;
OPEX_friendly_smallTransportHelicopters_woodland_default = OPEX_friendly_smallTransportHelicopters_woodland;
OPEX_friendly_smallTransportHelicopters_desert_default = OPEX_friendly_smallTransportHelicopters_desert;
OPEX_friendly_smallTransportHelicopters_snow_default = OPEX_friendly_smallTransportHelicopters_snow;
OPEX_friendly_mediumTransportHelicopters_woodland_default = OPEX_friendly_mediumTransportHelicopters_woodland;
OPEX_friendly_mediumTransportHelicopters_desert_default = OPEX_friendly_mediumTransportHelicopters_desert;
OPEX_friendly_mediumTransportHelicopters_snow_default = OPEX_friendly_mediumTransportHelicopters_snow;
OPEX_friendly_bigTransportHelicopters_woodland_default = OPEX_friendly_bigTransportHelicopters_woodland;
OPEX_friendly_bigTransportHelicopters_desert_default = OPEX_friendly_bigTransportHelicopters_desert;
OPEX_friendly_bigTransportHelicopters_snow_default = OPEX_friendly_bigTransportHelicopters_snow;
OPEX_friendly_UAVs_default = OPEX_friendly_UAVs;
OPEX_friendly_UGVs_default = OPEX_friendly_UGVs;
OPEX_friendly_portableDrones_default = OPEX_friendly_portableDrones;
OPEX_friendly_portableDronesBackpack_default = OPEX_friendly_portableDronesBackpack;
OPEX_friendly_MGstatics_default = OPEX_friendly_MGstatics;
OPEX_friendly_GLstatics_default = OPEX_friendly_GLstatics;
OPEX_friendly_ATstatics_default = OPEX_friendly_ATstatics;
OPEX_friendly_AAstatics_default = OPEX_friendly_AAstatics;
OPEX_friendly_mortarStatics_default = OPEX_friendly_mortarStatics;

// WEAPONS
OPEX_friendly_commonHandguns = ["hgun_Rook40_F"];
OPEX_friendly_specialHandguns = ["hgun_Rook40_F"];
OPEX_friendly_commonRifles = ["arifle_MX_Black_F"];
OPEX_friendly_specialRifles = ["arifle_MXC_Black_F"];
OPEX_friendly_GLrifles = ["arifle_MX_GL_Black_F"];
OPEX_friendly_MGriflesLight = ["arifle_MX_SW_Black_F"];
OPEX_friendly_MGriflesHeavy = ["MMG_02_black_RCO_BI_F"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["SMG_02_F", "SMG_05_F", "arifle_MXC_Black_F"];
OPEX_friendly_precisionRifles = ["arifle_MXM_Black_F"];
OPEX_friendly_sniperRifles = ["srifle_LRR_F"];
OPEX_friendly_ATlaunchers = ["launch_NLAW_F"];
OPEX_friendly_AAlaunchers = ["launch_B_Titan_olive_F"];
OPEX_friendly_shotguns = ["arifle_MX_Black_F"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["optic_aco", "optic_aco_grn", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_Holosight_blk_F", "optic_Holosight_smg_blk_F"];
OPEX_friendly_distantCombatOptics = ["optic_Arco_blk_F", "optic_MRCO", "optic_hamr", "optic_ERCO_blk_F"];
OPEX_friendly_sniperOptics = ["optic_LRPS", "optic_SOS", "optic_DMS", "optic_Nightstalker", "optic_tws"];
OPEX_friendly_flashlights = ["acc_flashlight"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_H", "muzzle_snds_I", "muzzle_snds_M", "muzzle_snds_B"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L"];
OPEX_friendly_pointers = ["acc_pointer_IR"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk"];

// VARIOUS ITEMS
OPEX_friendly_handGrenades = ["HandGrenade"];
OPEX_friendly_stunGrenades = [];
OPEX_friendly_smokeGrenades_white = ["SmokeShell"];
OPEX_friendly_smokeGrenades_colors = ["SmokeShellBlue", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed", "SmokeShellGreen", "SmokeShellPurple"];
OPEX_friendly_paintSprays = [];
OPEX_friendly_chemlights = ["Chemlight_blue", "Chemlight_yellow", "Chemlight_red", "Chemlight_green"];
OPEX_friendly_IRs = ["B_IR_Grenade"];
OPEX_friendly_explosives = ["ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", "APERSTripMine_Wire_Mag", "ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"];
OPEX_friendly_NVGs = ["NVGoggles_OPFOR"];
OPEX_friendly_commonBinoculars = ["Binocular"];
OPEX_friendly_spotterBinoculars = ["Rangefinder"];
OPEX_friendly_laserDesignators = ["laserdesignator"];
OPEX_friendly_toolKits = ["ToolKit"];
OPEX_friendly_medikits = ["Medikit"];
OPEX_friendly_mineDetectors = ["MineDetector"];
OPEX_friendly_radiosShortDistance = ["ItemRadio"];
OPEX_friendly_radiosLongDistance = ["B_Carryall_mcamo"];
OPEX_friendly_droneTerminals = ["B_UavTerminal"];
OPEX_friendly_tablets = [];
OPEX_friendly_earplugs = [];
OPEX_friendly_mapTools = [];
OPEX_friendly_rangeCards = [];
OPEX_friendly_sniperPDAs = [];
OPEX_friendly_weatherPDAs = [];
OPEX_friendly_advancedGPS = [];
OPEX_friendly_sandbags = [];
OPEX_friendly_tripods = [];
OPEX_friendly_HuntIRs = [];
OPEX_friendly_altimeters = [];
OPEX_friendly_ladders = [];
OPEX_medical_medikits = ["Medikit"];
OPEX_medical_firstAidKit = "FirstAidKit";
OPEX_medical_defibrillator = "Medikit";
OPEX_medical_commonSupplies = [];
OPEX_medical_advancedSupplies = [];
OPEX_medical_supplies = OPEX_medical_medikits + [OPEX_medical_firstAidKit] + [OPEX_medical_defibrillator] + OPEX_medical_commonSupplies + OPEX_medical_advancedSupplies;
OPEX_cableTies = [];
OPEX_bioScans = [];
OPEX_spyMicros = [];
OPEX_canteenItems = [];
OPEX_sleepingBags = ["B_Respawn_Sleeping_bag_blue_F", "B_Respawn_Sleeping_bag_brown_F", "B_Respawn_Sleeping_bag_F", "B_Respawn_TentA_F", "B_Respawn_TentDome_F"];
OPEX_entrenchingTools = [];
OPEX_ConcertinaWireCoils = [];
OPEX_wireCutters = [];
OPEX_flashlights = [];
OPEX_constructions = ["Fortifications", "Structures_Fences", "Tents", "Market", "Signs", "Lamps", "Furniture", "Flag", "Misc", "Furniture", "ThingX", "Thing"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_commonUniforms_desert = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_commonUniforms_snow = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_specialUniforms_woodland = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_specialUniforms_desert = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_specialUniforms_snow = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_ghillieUniforms_woodland = ["U_B_FullGhillie_sard","U_B_FullGhillie_lsh"];
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
OPEX_friendly_medicUniforms_woodland = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_medicUniforms_desert = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_medicUniforms_snow = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_instructorUniforms_woodland = ["U_B_CombatUniform_mcam"];
OPEX_friendly_instructorUniforms_desert = ["U_B_CombatUniform_mcam"];
OPEX_friendly_instructorUniforms_snow = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn"];
OPEX_friendly_tshirtUniforms_woodland = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_tshirtUniforms_desert = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_tshirtUniforms_snow = ["U_B_CombatUniform_mcam_tshirt"];
OPEX_friendly_diverUniforms = ["U_B_Wetsuit"];

// VESTS
OPEX_friendly_commonVests_woodland = ["V_PlateCarrier1_rgr"];
OPEX_friendly_commonVests_desert = ["V_PlateCarrier1_rgr"];
OPEX_friendly_commonVests_snow = ["V_PlateCarrier1_blk"];
OPEX_friendly_specialVests_woodland = ["V_PlateCarrier2_blk", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F"];
OPEX_friendly_specialVests_desert = ["V_PlateCarrier2_blk", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F"];
OPEX_friendly_specialVests_snow = ["V_PlateCarrier2_blk", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F"];
OPEX_friendly_medicVests_woodland = ["V_TacVestIR_blk"];
OPEX_friendly_medicVests_desert = ["V_TacVestIR_blk"];
OPEX_friendly_medicVests_snow = ["V_TacVestIR_blk"];
OPEX_friendly_beltVests_woodland = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_desert = ["V_Rangemaster_belt"];
OPEX_friendly_beltVests_snow = ["V_Rangemaster_belt"];
OPEX_friendly_shoulderVests_woodland = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_desert = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_shoulderVests_snow = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_friendly_lightVests_woodland = ["V_HarnessO_gry", "V_Chestrig_khk", "V_Chestrig_blk", "V_Chestrig_oli", "V_Chestrig_rgr"];
OPEX_friendly_lightVests_desert = ["V_HarnessO_brn", "V_HarnessO_gry", "V_Chestrig_khk", "V_Chestrig_blk", "V_Chestrig_oli", "V_Chestrig_rgr"];
OPEX_friendly_lightVests_snow = ["V_HarnessO_gry", "V_Chestrig_khk", "V_Chestrig_blk", "V_Chestrig_oli", "V_Chestrig_rgr"];
OPEX_friendly_grenadierVests_woodland = ["V_HarnessOGL_brn", "V_HarnessOGL_gry", "V_HarnessOGL_ghex_F"];
OPEX_friendly_grenadierVests_desert = ["V_HarnessOGL_brn", "V_HarnessOGL_gry", "V_HarnessOGL_ghex_F"];
OPEX_friendly_grenadierVests_snow = ["V_HarnessOGL_brn", "V_HarnessOGL_gry", "V_HarnessOGL_ghex_F"];
OPEX_friendly_EODvests_woodland = ["V_PlateCarrierGL_blk", "V_PlateCarrierGL_rgr", "V_PlateCarrierIAGL_oli"];
OPEX_friendly_EODvests_desert = ["V_PlateCarrierGL_blk", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_oli"];
OPEX_friendly_EODvests_snow = ["V_PlateCarrierGL_blk", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_oli"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["H_HelmetB"];
OPEX_friendly_commonHelmets_desert = ["H_HelmetB_sand"];
OPEX_friendly_commonHelmets_snow = ["H_HelmetB_black"];
OPEX_friendly_specialHelmets_woodland = ["H_HelmetB_grass", "H_HelmetB_black", "H_HelmetB_snakeskin"];
OPEX_friendly_specialHelmets_desert = ["H_HelmetB_grass", "H_HelmetB_black", "H_HelmetB_desert"];
OPEX_friendly_specialHelmets_snow = ["H_HelmetB_grass", "H_HelmetB_desert"];
OPEX_friendly_EODhelmets_woodland = ["H_HelmetB"];
OPEX_friendly_EODhelmets_desert = ["H_HelmetB_sand"];
OPEX_friendly_EODhelmets_snow = ["H_HelmetB_black"];
OPEX_friendly_heliPilotHelmets = ["H_PilotHelmetHeli_B"];
OPEX_friendly_aircraftPilotHelmets = ["H_CrewHelmetHeli_B"];
OPEX_friendly_tankCrewHelmets = ["H_HelmetCrew_B"];
OPEX_friendly_cameraHelmets_woodland = ["H_HelmetSpecB", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_snakeskin", "H_HelmetB_light", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_snakeskin"];
OPEX_friendly_cameraHelmets_desert = ["H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_HelmetSpecB_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_black", "H_HelmetB_light_sand"];
OPEX_friendly_cameraHelmets_snow = ["H_HelmetSpecB_blk", "H_HelmetB_light_black"];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
OPEX_friendly_hats_woodland = ["H_Booniehat_khk", "H_Booniehat_oli"];
OPEX_friendly_hats_desert = ["H_Booniehat_tan"];
OPEX_friendly_hats_snow = ["H_Booniehat_khk", "H_Booniehat_oli"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_leaderHeadgear_woodland = ["H_Beret_02", "H_MilCap_grn"];
OPEX_friendly_leaderHeadgear_desert = ["H_Beret_02", "H_MilCap_mcamo"];
OPEX_friendly_leaderHeadgear_snow = ["H_Beret_02", "H_MilCap_tna_F"];
OPEX_friendly_berets = ["H_Beret_02"];
OPEX_friendly_caps = ["H_Cap_tan", "H_Cap_tan_specops_US", "H_Cap_usblack", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F"];

// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Combat"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];
if (isClass (configFile >> "CfgPatches" >> "rhsusf_main")) then {OPEX_friendly_glasses append ["rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw"]; OPEX_friendly_sunglasses append ["rhs_googles_black"]};

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["B_AssaultPack_khk", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_AssaultPack_khk", "B_AssaultPack_rgr", "B_Kitbag_mcamo", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_rgr", "B_Carryall_green_F", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr", "B_TacticalPack_oli", "B_TacticalPack_rgr"];
OPEX_friendly_mediumBackpacks_desert = ["B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_AssaultPack_ocamo", "B_TacticalPack_ocamo"];
OPEX_friendly_mediumBackpacks_snow = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk"];
OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_green_F", "B_Carryall_oli", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_desert = ["B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_cbr", "B_Carryall_cbr", "B_Carryall_khk"];
OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_oucamo"];
OPEX_friendly_medicBackpacks_woodland = ["B_AssaultPack_khk", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_FieldPack_khk", "B_FieldPack_green_F", "B_Kitbag_mcamo", "B_FieldPack_blk", "B_FieldPack_oli", "B_Carryall_green_F", "B_Carryall_oli", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];
OPEX_friendly_medicBackpacks_desert = ["B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_FieldPack_cbr", "B_FieldPack_blk", "B_FieldPack_ocamo", "B_AssaultPack_ocamo", "B_Carryall_ocamo", "B_Carryall_cbr", "B_TacticalPack_ocamo"];
OPEX_friendly_medicBackpacks_snow = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_FieldPack_blk", "B_FieldPack_oucamo", "B_Carryall_oucamo", "B_Carryall_mcamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk"];
OPEX_friendly_radioBackpacks_woodland = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_desert = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_snow = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];