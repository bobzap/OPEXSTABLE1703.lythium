// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "AMF_Uniforms"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "AMF_vests"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "AMF_weapon_F"))) exitWith {};

// CHECKING IF CUSTOM FRANCE FACTION IS ENABLED (IN THAT CASE, LOADING THIS MOD ALONE IS USELESS)
//if (["STR_friendly_subFaction_France", "mix"] in OPEX_friendly_factions) exitWith {};

// DEFINING FACTION NAMES
_OPEX_friendly_modName = "AMF"; // e.g.: "RHS"
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
OPEX_friendly_transportTrucksOpened_woodland = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_transportTrucksOpened_desert = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_transportTrucksOpened_snow = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_transportTrucksCovered_woodland = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_transportTrucksCovered_desert = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_transportTrucksCovered_snow = ["B_AMF_VAB_ULTIMA_X8_F"];
OPEX_friendly_vtt_woodland = ["B_AMF_VAB_ULTIMA_TOP_X8_F"];
OPEX_friendly_vtt_desert = ["B_AMF_VAB_ULTIMA_TOP_X8_F"];
OPEX_friendly_vtt_snow = ["B_AMF_VAB_ULTIMA_TOP_X8_F"];
OPEX_friendly_tanks_woodland = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
OPEX_friendly_tanks_desert = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
OPEX_friendly_tanks_snow = ["B_AMF_AMX10_RCR_01_F","B_AMF_AMX10_RCR_SEPAR_01_F", "B_AMF_TANK_01"];
OPEX_friendly_mediumTransportHelicopters_woodland = ["B_AMF_Heli_Transport_01_F"];
OPEX_friendly_mediumTransportHelicopters_desert = ["B_AMF_Heli_Transport_01_F"];
OPEX_friendly_mediumTransportHelicopters_snow = ["B_AMF_Heli_Transport_01_F"];
OPEX_friendly_aircrafts = ["B_AMF_PLANE_FIGHTER_01_F","B_AMF_PLANE_FIGHTER_02_F"];

// WEAPONS
OPEX_friendly_commonHandguns = ["AMF_Pamas"];
OPEX_friendly_specialHandguns = ["AMF_Glock_17"];
OPEX_friendly_commonRifles = ["AMF_Samas_F1_01_F"];
OPEX_friendly_specialRifles = ["AMF_Famas_valo_01_F", "AMF_614_long_01_F", "AMF_614_long_ag_01_F", "AMF_614_long_VG_01_F", "AMF_614_short_01_F", "AMF_614_short_ag_01_F", "AMF_614_short_vg_01_F", "AMF_714_Long_01_F", "AMF_714_short_01_F"];
OPEX_friendly_GLrifles = ["AMF_614_long_HK269_01_F"];
OPEX_friendly_MGriflesLight = ["AMF_MINI_MG_01_F"];
OPEX_friendly_MGriflesHeavy = ["AMF_MINI_MG_01_F"];
OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy;
OPEX_friendly_compactRifles = ["AMF_614_short_ag_01_F", "AMF_614_short_vg_01_F"];
OPEX_friendly_precisionRifles = ["AMF_PGM_ULTIMA_RATIO_01_F"];
OPEX_friendly_sniperRifles = ["AMF_Perseis_II_01_F","AMF_Perseis_II_02_F"];
OPEX_friendly_ATlaunchers = ["launch_NLAW_F"];
OPEX_friendly_AAlaunchers = ["launch_B_Titan_olive_F"];
OPEX_friendly_shotguns = ["AMF_614_short_vg_01_F"];
OPEX_friendly_diverRifles = ["arifle_SDAR_F"];

// WEAPON ACCESSORIES
OPEX_friendly_closeCombatOptics = ["optic_aco", "optic_Aco_smg", "AMF_Eotech_552", "AMF_EOTECH_553", "AMF_Aimpoint_Pro_Patrol", "AMF_Red_Dot_Sight"];
OPEX_friendly_distantCombatOptics = ["optic_DMS", "optic_MRCO", "optic_hamr", "AMF_Aimpoint_Pro_Patrol"];
OPEX_friendly_sniperOptics = ["optic_LRPS", "optic_SOS", "optic_Nightstalker", "optic_tws"];
OPEX_friendly_flashlights = ["acc_flashlight", "acc_flashlight_pistol", "AMF_M952_VBK_black"];
OPEX_friendly_rifleSilencers = ["muzzle_snds_L", "muzzle_snds_H", "muzzle_snds_B", "muzzle_snds_M"];
OPEX_friendly_handgunSilencers = ["muzzle_snds_L", "muzzle_snds_acp"];
OPEX_friendly_pointers = ["acc_pointer_IR", "AMF_AN_PEQ_15_black", "AMF_LASER_PIRATE"];
OPEX_friendly_bipods = ["bipod_01_F_blk", "bipod_02_F_blk", "bipod_03_F_blk"];

// VARIOUS ITEMS
OPEX_friendly_handGrenades = ["HandGrenade"];
OPEX_friendly_smokeGrenades_white = ["SmokeShell"];
OPEX_friendly_smokeGrenades_colors = ["SmokeShellBlue", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellRed", "SmokeShellGreen", "SmokeShellPurple"];
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
OPEX_friendly_droneTerminals = ["B_UavTerminal"];

// UNIFORMS
OPEX_friendly_commonUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_commonUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_commonUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_specialUniforms_woodland = ["amf_uniform_01_CE_OD","amf_uniform_01_CE"];
OPEX_friendly_specialUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_specialUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_ghillieUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_ghillieUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_ghillieUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_heliPilotUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_heliPilotUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_heliPilotUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_aircraftPilotUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_aircraftPilotUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_aircraftPilotUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_tankPilotUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_tankPilotUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_tankPilotUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_medicUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_medicUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_medicUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_instructorUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_instructorUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_instructorUniforms_snow = ["amf_uniform_01_CE_OD"];
OPEX_friendly_tshirtUniforms_woodland = ["amf_uniform_01_CE_OD"];
OPEX_friendly_tshirtUniforms_desert = ["amf_uniform_01_DA"];
OPEX_friendly_tshirtUniforms_snow = ["amf_uniform_01_CE_OD"];
//OPEX_friendly_diverUniforms = [];

// VESTS
OPEX_friendly_commonVests_woodland = ["amf_smb_in_grn"];
OPEX_friendly_commonVests_desert = ["amf_smb_in"];
OPEX_friendly_commonVests_snow = ["amf_smb_in_grn"];
OPEX_friendly_specialVests_woodland = ["amf_smb_in_grn","amf_smb_inb_grn","amf_smb_tl_grn","amf_smb_tlb_grn","amf_plate_carrier3_green"];
OPEX_friendly_specialVests_desert = ["amf_smb_in","amf_smb_inb","amf_smb_tl","amf_smb_tlb","amf_plate_carrier3_tan"];
OPEX_friendly_specialVests_snow = ["amf_smb_in_grn","amf_smb_inb_grn","amf_smb_tl_grn","amf_smb_tlb_grn","amf_plate_carrier3_green"];
OPEX_friendly_medicVests_woodland = ["amf_smb_me_grn","amf_smb_meb_grn"];
OPEX_friendly_medicVests_desert = ["amf_smb_me","amf_smb_meb"];
OPEX_friendly_medicVests_snow = ["amf_smb_me_grn","amf_smb_meb_grn"];
/*
OPEX_friendly_beltVests_woodland = [];
OPEX_friendly_beltVests_desert = [];
OPEX_friendly_beltVests_snow = [];
OPEX_friendly_shoulderVests_woodland = [];
OPEX_friendly_shoulderVests_desert = [];
OPEX_friendly_shoulderVests_snow = [];
*/
OPEX_friendly_lightVests_woodland = ["amf_plate_carrier_green"];
OPEX_friendly_lightVests_desert = ["amf_plate_carrier_tan"];
OPEX_friendly_lightVests_snow = ["amf_plate_carrier_green"];
OPEX_friendly_grenadierVests_woodland = ["amf_smb_gr_grn","amf_smb_grb_grn"];
OPEX_friendly_grenadierVests_desert = ["amf_smb_gr","amf_smb_grb"];
OPEX_friendly_grenadierVests_snow = ["amf_smb_gr_grn","amf_smb_grb_grn"];
OPEX_friendly_EODvests_woodland = ["amf_smb_mc_grn","amf_smb_mcb_grn"];
OPEX_friendly_EODvests_desert = ["amf_smb_mc","amf_smb_mcb"];
OPEX_friendly_EODvests_snow = ["amf_smb_mc_grn","amf_smb_mcb_grn"];
OPEX_friendly_diverVests = ["V_RebreatherB"];

// HEADGEAR
OPEX_friendly_commonHelmets_woodland = ["AMF_TS3000_01_cover"];
OPEX_friendly_commonHelmets_desert = ["AMF_TS3000_01_da_cover"];
OPEX_friendly_commonHelmets_snow = ["AMF_TS3000_01_cover"];
OPEX_friendly_specialHelmets_woodland append ["AMF_FE_LIN","AMF_TS3000_01_od"];
OPEX_friendly_specialHelmets_desert append ["AMF_FE_LIN_DA","AMF_TS3000_01_tan"];
OPEX_friendly_specialHelmets_snow append ["AMF_FE_LIN","AMF_TS3000_01_od"];

/*
OPEX_friendly_EODhelmets_woodland = [];
OPEX_friendly_EODhelmets_desert = [];
OPEX_friendly_EODhelmets_snow = [];
OPEX_friendly_heliPilotHelmets = [];
OPEX_friendly_aircraftPilotHelmets = [];
OPEX_friendly_tankCrewHelmets = [];
OPEX_friendly_cameraHelmets_woodland = [];
OPEX_friendly_cameraHelmets_desert = [];
OPEX_friendly_cameraHelmets_snow = [];
OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow;
*/

OPEX_friendly_hats_woodland = ["H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli"];
OPEX_friendly_hats_desert = ["H_Booniehat_tan"];
OPEX_friendly_hats_snow = ["H_Booniehat_khk", "H_Booniehat_oli"];
OPEX_friendly_beanies_woodland = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_desert = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_beanies_snow = ["H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_blk", "H_Watchcap_khk"];
OPEX_friendly_leaderHeadgear_woodland = ["H_Beret_02", "H_Beret_02"];
OPEX_friendly_leaderHeadgear_desert = ["H_Beret_02", "H_Beret_02"];
OPEX_friendly_leaderHeadgear_snow = ["H_Beret_02", "H_Beret_02"];
OPEX_friendly_berets = ["H_Beret_02", "H_Beret_blk"];
OPEX_friendly_caps = ["H_Cap_tan", "H_Cap_blk", "H_Cap_blk", "H_Cap_blk", "H_Cap_oli", "H_Cap_oli", "H_Cap_grn"];
OPEX_friendly_bandanas = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg""H_Bandanna_camo"];
OPEX_friendly_shemags = ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_friendly_headsets = ["H_Cap_headphones", "H_HeadSet_black_F"];


// FACEGEAR
OPEX_friendly_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli"];
OPEX_friendly_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_friendly_glasses = ["G_Squares", "G_Squares", "G_Combat"];
OPEX_friendly_sunglasses = ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Red", "G_Shades_Green", "G_Sport_Blackred", "G_Squares_Tinted", "G_Lowprofile", "G_Spectacles_Tinted", "G_Aviator"];
OPEX_friendly_tacticalGlasses = ["G_Tactical_Clear"];
OPEX_friendly_diverGlasses = ["G_B_Diving"];
if (isClass (configFile >> "CfgPatches" >> "rhsusf_main")) then {OPEX_friendly_glasses append ["rhsusf_oakley_goggles_blk", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_ylw"]; OPEX_friendly_sunglasses append ["rhs_googles_black"]};

// BACKPACKS
OPEX_friendly_mediumBackpacks_woodland = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_AssaultPack_rgr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_mediumBackpacks_desert = ["B_AssaultPack_cbr", "B_AssaultPack_blk", "B_Kitbag_cbr", "B_Kitbag_rgr", "B_AssaultPack_ocamo", "B_TacticalPack_ocamo","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN"];
OPEX_friendly_mediumBackpacks_snow = ["B_AssaultPack_mcamo", "B_AssaultPack_blk", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_blk","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_bigBackpacks_woodland = ["B_Carryall_mcamo", "B_Carryall_oli", "B_Carryall_cbr", "B_Carryall_khk","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_bigBackpacks_desert = ["B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_cbr", "B_Carryall_cbr", "B_Carryall_khk","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN","AMF_FELIN_BACKPACK_TAN"];
OPEX_friendly_bigBackpacks_snow = ["B_Carryall_mcamo", "B_Carryall_oucamo","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK","AMF_FELIN_BACKPACK"];
OPEX_friendly_medicBackpacks_woodland = ["AMF_FELIN_BACKPACK"];
OPEX_friendly_medicBackpacks_desert = ["AMF_FELIN_BACKPACK_TAN"];
OPEX_friendly_medicBackpacks_snow = ["AMF_FELIN_BACKPACK"];
OPEX_friendly_radioBackpacks_woodland = ["B_RadioBag_01_wdl_F", "B_RadioBag_01_wdl_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_desert = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_radioBackpacks_snow = ["B_RadioBag_01_mtp_F", "B_RadioBag_01_mtp_F", "B_RadioBag_01_black_F"];
OPEX_friendly_diverBackpacks = ["B_assault_diver"];
OPEX_friendly_parachutes = ["B_Parachute"];