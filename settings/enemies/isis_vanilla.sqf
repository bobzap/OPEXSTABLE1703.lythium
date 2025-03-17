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

	if (!(isClass (configFile >> "CfgPatches" >> "A3_Characters_F"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	_OPEX_enemy_modName = "vanilla"; // mod name (example: "myCustomMod")
	_OPEX_enemy_subFaction = "STR_enemy_name_ISIS_4"; // e.g.; "Ultranationalists" - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_enemy_factionName1 = "STR_enemy_name_ISIS_1"; // e.g.: The islamic State - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_enemy_factionName2 = "STR_enemy_name_ISIS_2"; // e.g.: the islamic state - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_enemy_factionName3 = "STR_enemy_name_ISIS_3"; // e.g.: Daesh - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_enemy_factionName4 = "STR_enemy_name_ISIS_4"; // e.g.: Daesh - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_enemy_fighters = "STR_enemy_fighters_ISIS"; // e.g.: islamists - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

// =======================================================================================================================
// PART 3 (DO NOT EDIT OR DELETE these lines !)
// =======================================================================================================================

	// ENABLING FACTION
	waitUntil {!isNil "OPEX_enemy_factions"};
	if (isServer) then {OPEX_enemy_factions append [[_OPEX_enemy_subFaction, _OPEX_enemy_modName]]}; publicVariable "OPEX_enemy_factions";

	// WAITING FOR FACTION SELECTION
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};
	if (OPEX_param_enemyFaction != ((localize _OPEX_enemy_subFaction) + " " + "(" + _OPEX_enemy_modName + ")")) exitWith {};

	// CONFIRMING FACTION NAMES
	OPEX_enemy_modName = _OPEX_enemy_modName;
	OPEX_enemy_subFaction = _OPEX_enemy_subFaction;
	OPEX_enemy_factionName1 = _OPEX_enemy_factionName1;
	OPEX_enemy_factionName2 = _OPEX_enemy_factionName2;
	OPEX_enemy_factionName3 = _OPEX_enemy_factionName3;
	OPEX_enemy_factionName4 = _OPEX_enemy_factionName4;
	OPEX_enemy_fighters = _OPEX_enemy_fighters;

// =======================================================================================================================
// PART 4 (DO NOT LET ANY VARIABLE UNDEFINED OR EMPTY)
//		- if you don't know what a variable is about, please ask
//		- if you don't need to define a variable, simply delete the line (default content will be used instead)
// =======================================================================================================================

	// FLAG
	OPEX_enemy_flagTexture = "pictures\flag_isis.paa";

	// AI GLOBAL SKILL
	OPEX_enemy_AIskill = [0.10, 0.50]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_enemy_names = []; // names used by the AI

	// UNITS
	OPEX_enemy_rifleman = "O_Soldier_F";
	OPEX_enemy_teamLeader = "O_Soldier_TL_F";
	OPEX_enemy_grenadier = "O_Soldier_GL_F";
	OPEX_enemy_MG = "O_Soldier_AR_F";
	OPEX_enemy_AT = "O_Soldier_AT_F";
	OPEX_enemy_AA = "O_Soldier_AA_F";
	OPEX_enemy_marksman = "O_Soldier_M_F";
	OPEX_enemy_crewman = "O_crew_F";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits; // don't delete this line if you have defined any of these variables

	// VEHICLES
	OPEX_enemy_transportTrucks = ["I_G_Van_01_transport_F", "O_G_Van_01_transport_F", "C_Van_01_transport_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F"];
	OPEX_enemy_fuelTrucks = ["I_G_Van_01_fuel_F", "O_G_Van_01_fuel_F", "C_Van_01_fuel_F", "C_Truck_02_fuel_F"];
	OPEX_enemy_transportCars = ["I_G_Offroad_01_F", "O_G_Offroad_01_F", "C_Offroad_01_F"];
	OPEX_enemy_combatCars = ["I_G_Offroad_01_armed_F", "O_G_Offroad_01_armed_F"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars; // don't delete this line if you have defined any of these variables
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_boats = OPEX_enemy_zodiacs + OPEX_enemy_ships; // don't delete this line if you have defined any of these variables
	OPEX_enemy_armored = ["O_MBT_02_cannon_F"];
	OPEX_enemy_MGstatics = ["I_HMG_01_high_F"];
	OPEX_enemy_GLstatics = ["I_GMG_01_high_F"];
	OPEX_enemy_ATstatics = ["I_static_AT_F"];
	OPEX_enemy_AAstatics = ["I_static_AA_F"];
	OPEX_enemy_mortarStatics = ["I_G_Mortar_01_F"];
	OPEX_enemy_AAbatteries = ["I_static_AA_F"];
	OPEX_enemy_artilleryBatteries = ["I_G_Mortar_01_F"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics; // don't delete this line if you have defined any of these variables

	// WEAPONS
	OPEX_enemy_commonHandguns = ["hgun_Rook40_F"];
	OPEX_enemy_specialHandguns = ["hgun_Pistol_heavy_02_F"];
	if (395180 in (getDLCs 1)) then {OPEX_enemy_commonRifles = ["arifle_AK12_F", "arifle_AKM_F", "arifle_AKM_F", "arifle_AKS_F"]} else {OPEX_enemy_commonRifles = ["arifle_MX_Black_F"]};
	if (395180 in (getDLCs 1)) then {OPEX_enemy_specialRifles = ["hgun_PDW2000_F", "SMG_02_F"]} else {OPEX_enemy_specialRifles = ["hgun_PDW2000_F", "SMG_02_F"]};
	if (395180 in (getDLCs 1)) then {OPEX_enemy_GLrifles = ["arifle_AK12_GL_F"]} else {OPEX_enemy_GLrifles = ["arifle_MX_GL_Black_F"]};
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
	OPEX_enemy_commonUniforms = ["U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","U_BG_Guerilla2_3","U_BG_Guerilla2_1","U_I_G_Story_Protagonist_F"];
	if (395180 in (getDLCs 1)) then {OPEX_enemy_commonUniforms append ["U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F"]};
	if (1.02179e+006 in (getDLCs 1)) then {OPEX_enemy_commonUniforms append ["U_C_E_LooterJacket_01_F","U_I_L_Uniform_01_tshirt_skull_F"]};

	// VESTS
	OPEX_enemy_commonVests = ["V_HarnessO_brn", "V_HarnessO_gry", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr"];
	OPEX_enemy_beltVests = ["V_Rangemaster_belt"];
	OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_gry"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_khk","H_Bandanna_cbr"];
	OPEX_enemy_headgears = ["H_Bandanna_gry","H_Cap_blk","H_ShemagOpen_khk","H_ShemagOpen_tan","H_ShemagOpen_tan","H_Shemag_olive","H_Shemag_olive"];
	OPEX_enemy_officerHeadgears = OPEX_enemy_headgears;

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk"];
	OPEX_enemy_scarfs = ["G_Bandanna_blk","G_Bandanna_blk","G_Bandanna_blk","G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_oli"];
	OPEX_enemy_glasses = ["G_Squares","G_Spectacles"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];