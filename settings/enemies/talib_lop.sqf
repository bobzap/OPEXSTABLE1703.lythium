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

	if (!(isClass (configFile >> "CfgPatches" >> "po_main"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	_OPEX_enemy_modName = "LOP"; // e.g.: "LOP"
	_OPEX_enemy_subFaction = "STR_enemy_name_TALIB_4"; // e.g.; "Talibans"
	_OPEX_enemy_factionName1 = "STR_enemy_name_TALIB_1"; // e.g.: The islamic State
	_OPEX_enemy_factionName2 = "STR_enemy_name_TALIB_2"; // e.g.: the islamic state
	_OPEX_enemy_factionName3 = "STR_enemy_name_TALIB_3"; // e.g.: Daesh
	_OPEX_enemy_factionName4 = "STR_enemy_name_TALIB_4"; // e.g.: Daesh
	_OPEX_enemy_fighters = "STR_enemy_fighters_TALIB"; // e.g.: islamists

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
	OPEX_enemy_flagTexture = "pictures\flag_taliban.paa";

	// AI GLOBAL SKILL
	OPEX_enemy_AIskill = [0.10, 0.50]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_enemy_names = ["Abdel Brahimi", "Youcef Brahimi", "Djalil Brahimi", "Rachid Brahimi", "Ahmed Brahimi", "Amine El Tarkouri", "Djawad El Boukhrissi", "Habid Bounar", "Saïd Ben Youcef", "Habid Ben Youssef", "Saïd Bennacer", "Allah Bennacer", "Khaled Daouadi", "Djamal Bennacer", "Ismaël Slimani", "Ismaïl Abdellaoui", "Khaled Abdellaoui", "Ahmed Abdellaoui", "Zinedine al-Bagdadi", "Khaled Mansouri", "Ibrahim Mazraoui", "Habib Mazraoui", "Abdelatif Boutaïb", "Karim Idrissi", "Karim Chafik", "Mehdi El Hajjam", "Hicham al-Arabi", "Karim al-Muslim", "Allah al-Boukrissi", "Ismaël al-Arabbi", "Karim Ben Youssef", "Zinedine Benharda", "Ahmed Bentaleb", "Rachid Benatia", "Rachid al-Malawi", "Mehdi Touati", "Abdelkrim Driddi", "Abdelkrim al-Tayeb", "Issam Tayeb", "Oussama Bennasser", "Mohammed Mazraoui", "Mohamed el-Fahaoui", "Mohammed Benzema", "Khalid Ben Arfa", "Yacine Bouderbala", "Mourad Benzia", "Ahmed Bentala", "Driss El Karkouri", "Habib Hadji", "Islam al-Tayeb", "Islam Al Khaled", "Issam Ben Laden", "Djawad Benzema", "Khaled Merah", "Samir Merah", "Bilal Merah", "Hamza Ben Ouarda", "Idriss Ben Yecin", "Ibrahim Ben Malik", "Malik Bouderbalah", "Rayan Ben Mabrouk", "Khalid Ben Mabrouk", "Khalid Ben Malek", "Malek al-Wahda", "Nasser Boutaleb", "Nacer Ramhadi", "Nasser Soltani"];

	// UNITS
	OPEX_enemy_rifleman = "LOP_AM_OPF_Infantry_Rifleman";
	OPEX_enemy_teamLeader = "LOP_AM_OPF_Infantry_SL";
	OPEX_enemy_grenadier = "LOP_AM_OPF_Infantry_GL";
	OPEX_enemy_MG = "LOP_AM_OPF_Infantry_AR";
	OPEX_enemy_AT = "LOP_AM_OPF_Infantry_AT";
	OPEX_enemy_AA = "LOP_AM_OPF_Infantry_Corpsman";
	OPEX_enemy_marksman = "LOP_AM_OPF_Infantry_Marksman";
	OPEX_enemy_crewman = "LOP_AM_OPF_Infantry_Rifleman_2";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman];
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

	// VEHICLES
	OPEX_enemy_transportTrucks = ["LOP_AFR_Civ_Ural", "LOP_AFR_Civ_Ural_open"];
	OPEX_enemy_fuelTrucks = ["I_G_VAN_01_fuel_F", "O_G_VAN_01_fuel_F", "C_VAN_01_fuel_F", "C_truck_02_fuel_F"];
	OPEX_enemy_transportCars = ["LOP_AM_OPF_Landrover", "LOP_ISTS_OPF_M1025_D", "LOP_AM_OPF_Offroad", "LOP_AFR_Civ_Ural", "LOP_AFR_Civ_Ural_open", "LOP_TAK_Civ_UAZ", "LOP_TAK_Civ_UAZ_Open", "LOP_AM_OPF_UAZ", "LOP_AM_OPF_UAZ_Open"];
	OPEX_enemy_combatCars = ["LOP_AM_OPF_Landrover_M2", "LOP_ISTS_OPF_M1025_W_M2", "LOP_ISTS_OPF_M1025_W_Mk19", "LOP_AM_OPF_Offroad_M2", "LOP_AM_OPF_UAZ_DSHKM", "LOP_AM_OPF_UAZ_AGS", "LOP_AM_OPF_UAZ_SPG"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_armored = ["LOP_ISTS_OPF_BMP1", "LOP_ISTS_OPF_BMP2", "LOP_AM_OPF_BTR60", "LOP_ISTS_OPF_M113_W", "OP_ISTS_OPF_M113_W", "LOP_ISTS_OPF_T34", "LOP_ISTS_OPF_T55", "LOP_ISTS_OPF_T72BA"];
	OPEX_enemy_MGstatics = ["LOP_AM_OPF_Static_DSHKM", "LOP_AM_OPF_Kord_High"];
	OPEX_enemy_GLstatics = ["I_GMG_01_high_F"];
	OPEX_enemy_ATstatics = ["LOP_AM_OPF_Static_SPG9"];
	OPEX_enemy_AAstatics = ["LOP_AM_OPF_Igla_AA_pod"];
	OPEX_enemy_mortarStatics = ["I_G_Mortar_01_F"];
	OPEX_enemy_artilleryBatteries = ["LOP_SLA_Static_D30"];
	OPEX_enemy_AAbatteries = ["LOP_AM_OPF_Static_ZU23"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics;

	// WEAPONS
	OPEX_enemy_commonHandguns = ["rhs_weap_makarov_pm"];
	OPEX_enemy_specialHandguns = ["hgun_Rook40_F"];
	OPEX_enemy_commonRifles = ["rhs_weap_ak74", "LOP_Weap_LeeEnfield_railed"];
	OPEX_enemy_specialRifles = ["rhs_weap_ak74m", "rhs_weap_ak103", "rhs_weap_ak105", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74"];
	OPEX_enemy_GLrifles = ["rhs_weap_ak74_gp25", "rhs_weap_akmn_gp25"];
	OPEX_enemy_MGrifles = ["rhs_weap_pkm"];
	OPEX_enemy_precisionRifles = ["rhs_weap_svdp_wd_npz", "rhs_weap_svdp_npz", "rhs_weap_svds_npz"];
	OPEX_enemy_sniperRifles = ["rhs_weap_svdp", "rhs_weap_svds", "rhs_weap_svdp_wd"];
	OPEX_enemy_ATlaunchers = ["rhs_weap_rpg7"];
	OPEX_enemy_AAlaunchers = ["rhs_weap_fim92"];

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
	OPEX_enemy_commonUniforms = ["LOP_U_ISTS_Fatigue_01", "LOP_U_ISTS_Fatigue_02", "LOP_U_ISTS_Fatigue_03", "LOP_U_ISTS_Fatigue_04", "LOP_U_AM_Fatigue_01", "LOP_U_AM_Fatigue_01_2", "LOP_U_AM_Fatigue_01_3", "LOP_U_AM_Fatigue_01_4", "LOP_U_AM_Fatigue_01_5", "LOP_U_AM_Fatigue_01_6", "LOP_U_AM_Fatigue_02", "LOP_U_AM_Fatigue_02_2", "LOP_U_AM_Fatigue_02_3", "LOP_U_AM_Fatigue_02_4", "LOP_U_AM_Fatigue_02_5", "LOP_U_AM_Fatigue_02_6", "LOP_U_AM_Fatigue_03", "LOP_U_AM_Fatigue_03_2", "LOP_U_AM_Fatigue_03_3", "LOP_U_AM_Fatigue_03_4", "LOP_U_AM_Fatigue_03_5", "LOP_U_AM_Fatigue_03_6", "LOP_U_AM_Fatigue_04", "LOP_U_AM_Fatigue_04_2", "LOP_U_AM_Fatigue_04_3", "LOP_U_AM_Fatigue_04_4", "LOP_U_AM_Fatigue_04_5", "LOP_U_AM_Fatigue_04_6", "LOP_U_TAK_Civ_Fatigue_01", "LOP_U_TAK_Civ_Fatigue_02", "LOP_U_TAK_Civ_Fatigue_04", "LOP_U_TAK_Civ_Fatigue_05", "LOP_U_TAK_Civ_Fatigue_06", "LOP_U_TAK_Civ_Fatigue_07", "LOP_U_TAK_Civ_Fatigue_08", "LOP_U_TAK_Civ_Fatigue_09", "LOP_U_TAK_Civ_Fatigue_10", "LOP_U_TAK_Civ_Fatigue_11", "LOP_U_TAK_Civ_Fatigue_12", "LOP_U_TAK_Civ_Fatigue_13", "LOP_U_TAK_Civ_Fatigue_14", "LOP_U_TAK_Civ_Fatigue_15", "LOP_U_TAK_Civ_Fatigue_16"];

	// VESTS
	OPEX_enemy_commonVests = [];
	OPEX_enemy_beltVests = [];
	OPEX_enemy_grenadierVests = [];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_enemy_headgears = ["LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Shemag_BLK", "LOP_H_Shemag_BLK", "LOP_H_Shemag_BLK", "H_ShemagOpen_tan", "H_Shemag_olive", "H_ShemagOpen_khk", "LOP_H_Turban", "LOP_H_Turban", "LOP_H_Turban", "LOP_H_Turban", "LOP_H_Turban", "LOP_H_Turban_mask", "LOP_H_Turban_mask", "LOP_H_Turban_mask", "LOP_H_Turban_mask", "LOP_H_Turban_mask"];
	OPEX_enemy_officerHeadgears = ["LOP_H_Turban", "LOP_H_Pakol"];


	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk"];
	OPEX_enemy_scarfs = ["G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_tan"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];