// FACTION
OPEX_enemy_side1 = east;
OPEX_enemy_side2 = "east";

// TRIGGERS
OPEX_enemy_detection = "EAST D";

// SETTING RESISTANCE SIDE
east setFriend [resistance, 1];
resistance setFriend [east, 1];

// ===============================================================================
// ===============================================================================

if (isServer) then {OPEX_enemy_factions = []; publicVariable "OPEX_enemy_factions"};

// DEFINING FACTION NAMES
OPEX_enemy_modName = "vanilla"; // e.g.: "vanilla"
OPEX_enemy_subFaction = "STR_enemy_name_ULTRA_4"; // e.g.; "Ultranationalists"
OPEX_enemy_factionName1 = "STR_enemy_name_ULTRA_1"; // e.g.: The islamic State
OPEX_enemy_factionName2 = "STR_enemy_name_ULTRA_2"; // e.g.: the islamic state
OPEX_enemy_factionName3 = "STR_enemy_name_ULTRA_3"; // e.g.: Daesh
OPEX_enemy_factionName4 = "STR_enemy_name_ULTRA_4"; // e.g.: Daesh
OPEX_enemy_fighters = "STR_enemy_fighters_ULTRA"; // e.g.: islamists

// AI GLOBAL SKILL
OPEX_enemy_AIskill = [0.10, 0.50]; // [lowest possible level, highest possible level]

// FLAG
OPEX_enemy_flag = "FlagCarrierTKMilitia_EP1";

// IDENTITIES
OPEX_enemy_names =
	[
		"Dimitri Podolski", "Josef Sukolin", "Michail Takochev", "Andreï Takarov", "Andreas Volavetti",
		"Andrea Pessotto", "Stefan Malakovic", "Niko Stavic", "Zvonimir Brnovic", "Ivan Djokovic",
		"Stavros Papadopulos", "Nikos Ariarankis", "Georgios Solaris", "Nikola Konstandinos", "Adonis Rastapopoulos"
	];

// UNITS
OPEX_enemy_rifleman = "I_soldier_F";
OPEX_enemy_teamLeader = "I_Soldier_TL_F";
OPEX_enemy_grenadier = "I_Soldier_GL_F";
OPEX_enemy_MG = "I_Soldier_AR_F";
OPEX_enemy_AT = "I_Soldier_AT_F";
OPEX_enemy_AA = "I_Soldier_AA_F";
OPEX_enemy_marksman = "I_Soldier_M_F";
OPEX_enemy_crewman = "I_crew_F";
OPEX_enemy_commonUnits = [OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman];
OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

// VEHICLES
OPEX_enemy_transportTrucks = ["I_G_Van_01_transport_F", "O_G_Van_01_transport_F", "C_Van_01_transport_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F"];
OPEX_enemy_fuelTrucks = ["I_G_Van_01_fuel_F", "O_G_Van_01_fuel_F", "C_Van_01_fuel_F", "C_Truck_02_fuel_F"];
OPEX_enemy_transportCars = ["I_G_Offroad_01_F", "O_G_Offroad_01_F", "C_Offroad_01_F"];
OPEX_enemy_combatCars = ["I_G_Offroad_01_armed_F", "O_G_Offroad_01_armed_F"];
OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
OPEX_enemy_boats = OPEX_enemy_zodiacs + OPEX_enemy_ships;
OPEX_enemy_armored = ["O_MBT_02_cannon_F"];
OPEX_enemy_MGstatics = ["I_HMG_01_high_F"];
OPEX_enemy_GLstatics = ["I_GMG_01_high_F"];
OPEX_enemy_ATstatics = ["I_static_AT_F"];
OPEX_enemy_AAstatics = ["I_static_AA_F"];
OPEX_enemy_mortarStatics = ["I_G_Mortar_01_F"];
OPEX_enemy_AAbatteries = ["I_static_AA_F"];
OPEX_enemy_artilleryBatteries = ["I_G_Mortar_01_F"];
OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics;

// WEAPONS
OPEX_enemy_commonHandguns = ["hgun_Rook40_F"];
OPEX_enemy_specialHandguns = ["hgun_Pistol_heavy_02_F"];
if (395180 in (getDLCs 1)) then {OPEX_enemy_commonRifles = ["arifle_AK12_F", "arifle_AKM_F", "arifle_AKM_F", "arifle_AKS_F"]} else {OPEX_enemy_commonRifles = ["arifle_Katiba_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_specialRifles = ["hgun_PDW2000_F", "SMG_02_F"]} else {OPEX_enemy_specialRifles = ["hgun_PDW2000_F", "SMG_02_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_GLrifles = ["arifle_AK12_GL_F"]} else {OPEX_enemy_GLrifles = ["arifle_Katiba_GL_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_MGrifles = ["LMG_03_F", "LMG_Zafir_F"]} else {OPEX_enemy_MGrifles = ["LMG_Zafir_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_precisionRifles = ["srifle_DMR_07_blk_F", "srifle_DMR_01_F"]} else {OPEX_enemy_precisionRifles = ["srifle_DMR_01_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_sniperRifles = ["srifle_LRR_F"]} else {OPEX_enemy_sniperRifles = ["srifle_LRR_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_ATlaunchers = ["launch_RPG7_F"]} else {OPEX_enemy_ATlaunchers = ["launch_RPG32_F"]};
if (395180 in (getDLCs 1)) then {OPEX_enemy_AAlaunchers = ["launch_RPG32_F"]} else {OPEX_enemy_AAlaunchers = ["launch_RPG32_F"]};

// VARIOUS ITEMS
OPEX_enemy_handGrenades = ["HandGrenade"];
OPEX_enemy_smokeGrenades_white = ["SmokeShell"];
OPEX_enemy_explosives = ["IEDLandBig_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDLandSmall_Remote_Mag", "IEDUrbanSmall_Remote_Mag"];
OPEX_enemy_binoculars = ["Binocular"];
OPEX_enemy_toolKits = ["ToolKit"];
OPEX_enemy_medikits = ["Medikit"];
OPEX_enemy_radiosShortDistance = ["ItemRadio"];
OPEX_enemy_radiosLongDistance = ["ItemRadio"];
OPEX_enemy_cacheCrates = ["Box_FIA_wps_F"];

// UNIFORMS
OPEX_enemy_commonUniforms = ["LOP_U_ISTS_Fatigue_02", "LOP_U_ISTS_Fatigue_03"];

// VESTS
OPEX_enemy_commonVests = ["V_HarnessO_brn", "V_HarnessO_gry", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
OPEX_enemy_beltVests = ["V_Rangemaster_belt"];
OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_gry"];

// HEADGEAR
OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
OPEX_enemy_headgears = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo", "H_Cap_tan", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn", "H_Cap_blk_Raven", "H_Cap_brn_SPECOPS", "H_Cap_blu", "H_Cap_red", "H_Hat_camo", "H_Hat_grey", "H_Hat_brown", "H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "H_Booniehat_tan", "H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive"];
OPEX_enemy_officerHeadgears = ["H_Beret_blk"];

// FACEGEAR
OPEX_enemy_balaclavas = ["G_Balaclava_blk","G_Balaclava_blk","G_Balaclava_oli"];
OPEX_enemy_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];
OPEX_enemy_beards = [];

// BACKPACKS
OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];