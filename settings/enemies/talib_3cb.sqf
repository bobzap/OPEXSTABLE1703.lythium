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

	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKA"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKC"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKM"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKP"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_Weapons"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	_OPEX_enemy_modName = "3CB"; // mod name (example: "myCustomMod")
	_OPEX_enemy_subFaction = "STR_enemy_name_TALIB_4"; // e.g.; "Ultranationalists"
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
	OPEX_enemy_names = ["Abdel Brahimi", "Youcef Brahimi", "Djalil Brahimi", "Rachid Brahimi", "Ahmed Brahimi", "Amine El Tarkouri", "Djawad El Boukhrissi", "Habid Bounar", "Saïd Ben Youcef", "Habid Ben Youssef", "Saïd Bennacer", "Allah Bennacer", "Khaled Daouadi", "Djamal Bennacer", "Ismaël Slimani", "Ismaïl Abdellaoui", "Khaled Abdellaoui", "Ahmed Abdellaoui", "Zinedine al-Bagdadi", "Khaled Mansouri", "Ibrahim Mazraoui", "Habib Mazraoui", "Abdelatif Boutaïb", "Karim Idrissi", "Karim Chafik", "Mehdi El Hajjam", "Hicham al-Arabi", "Karim al-Muslim", "Allah al-Boukrissi", "Ismaël al-Arabbi", "Karim Ben Youssef", "Zinedine Benharda", "Ahmed Bentaleb", "Rachid Benatia", "Rachid al-Malawi", "Mehdi Touati", "Abdelkrim Driddi", "Abdelkrim al-Tayeb", "Issam Tayeb", "Oussama Bennasser", "Mohammed Mazraoui", "Mohamed el-Fahaoui", "Mohammed Benzema", "Khalid Ben Arfa", "Yacine Bouderbala", "Mourad Benzia", "Ahmed Bentala", "Driss El Karkouri", "Habib Hadji", "Islam al-Tayeb", "Islam Al Khaled", "Issam Ben Laden", "Djawad Benzema", "Khaled Merah", "Samir Merah", "Bilal Merah", "Hamza Ben Ouarda", "Idriss Ben Yecin", "Ibrahim Ben Malik", "Malik Bouderbalah", "Rayan Ben Mabrouk", "Khalid Ben Mabrouk", "Khalid Ben Malek", "Malek al-Wahda", "Nasser Boutaleb", "Nacer Ramhadi", "Nasser Soltani"]; // names used by the AI

	// UNITS
	OPEX_enemy_rifleman = "UK3CB_TKM_O_RIF_1";
	OPEX_enemy_teamLeader = "UK3CB_TKM_O_TL";
	OPEX_enemy_grenadier = "UK3CB_TKM_O_GL";
	OPEX_enemy_MG = "UK3CB_TKM_O_MG";
	OPEX_enemy_AT = "UK3CB_TKM_O_AT";
	OPEX_enemy_AA = "UK3CB_TKM_O_AA";
	OPEX_enemy_marksman = "UK3CB_TKM_O_SNI";
	OPEX_enemy_crewman = "UK3CB_TKM_O_RIF_2";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits; // don't delete this line if you have defined any of these variables

	// VEHICLES
	OPEX_enemy_transportTrucks = ["UK3CB_TKM_O_V3S_Closed","UK3CB_TKM_O_V3S_Open","UK3CB_TKM_O_Ural_Open","UK3CB_TKM_O_Ural_Covered"];
	OPEX_enemy_fuelTrucks = ["UK3CB_TKM_O_Ural_Fuel","UK3CB_TKM_O_V3S_Refuel"];
	OPEX_enemy_transportCars = ["UK3CB_TKM_O_Datsun_Open","UK3CB_TKM_O_Datsun_Open","UK3CB_TKM_O_Hilux_Open","UK3CB_TKM_O_Hilux_Open","UK3CB_TKM_O_LR_Closed","UK3CB_TKM_O_LR_Open","UK3CB_TKM_O_UAZ_Closed","UK3CB_TKM_O_UAZ_Open"];
	OPEX_enemy_combatCars = ["UK3CB_TKM_O_Datsun_Pkm","UK3CB_TKM_O_Hilux_Dshkm","UK3CB_TKM_O_Hilux_Pkm","UK3CB_TKM_O_LR_M2","UK3CB_TKM_O_LR_SF_M2","UK3CB_TKM_O_UAZ_Dshkm","UK3CB_TKM_O_UAZ_SPG9","UK3CB_TKM_O_Hilux_Spg9"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars; // don't delete this line if you have defined any of these variables
	OPEX_enemy_armored = ["UK3CB_TKM_O_BRDM2_HQ","UK3CB_TKM_O_BRDM2","UK3CB_TKM_O_BMP1","UK3CB_TKM_O_BTR40_MG","UK3CB_TKM_O_BTR60","UK3CB_TKM_O_MTLB_PKT","UK3CB_TKM_O_T34","UK3CB_TKM_O_T55"];
	OPEX_enemy_MGstatics = ["UK3CB_TKM_O_KORD_high","UK3CB_TKM_O_DSHKM","UK3CB_TKM_O_DSHKM"];
	OPEX_enemy_GLstatics = ["UK3CB_TKM_O_AGS"];
	OPEX_enemy_ATstatics = ["UK3CB_TKM_O_SPG9"];
	OPEX_enemy_AAstatics = ["UK3CB_TKM_O_Igla_AA_pod"];
	OPEX_enemy_mortarStatics = ["UK3CB_TKM_O_2b14_82mm"];
	OPEX_enemy_AAbatteries = ["UK3CB_TKM_O_ZU23"];
	OPEX_enemy_artilleryBatteries = ["UK3CB_TKM_O_D30"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics; // don't delete this line if you have defined any of these variables

	// WEAPONS
	OPEX_enemy_commonHandguns = ["rhs_weap_makarov_pm"];
	OPEX_enemy_specialHandguns = ["rhs_weap_savz61_folded","rhs_weap_6p53"];
	OPEX_enemy_commonRifles = ["rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74n","UK3CB_Enfield","UK3CB_Enfield_Rail","rhs_weap_akm","rhs_weap_akmn"];
	OPEX_enemy_specialRifles = ["UK3CB_M16","UK3CB_M16A1","rhs_weap_ak74m","rhs_weap_ak74n_npz","rhs_weap_ak74n_2","rhs_weap_ak74n_2_npz","rhs_weap_aks74","rhs_weap_aks74n"];
	OPEX_enemy_GLrifles = ["rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74m_gp25","rhs_weap_ak74n_gp25"];
	OPEX_enemy_MGrifles = ["UK3CB_RPK","UK3CB_M60","rhs_weap_pkm"];
	OPEX_enemy_precisionRifles = ["UK3CB_M14","UK3CB_M14_Rail"];
	OPEX_enemy_sniperRifles = ["UK3CB_SVD_OLD","UK3CB_M21","UK3CB_M21_Bipod_Railed"];
	OPEX_enemy_ATlaunchers = ["rhs_weap_rpg7"];
	OPEX_enemy_AAlaunchers = ["rhs_weap_igla"];

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
	OPEX_enemy_commonUniforms = ["UK3CB_TKM_O_U_01","UK3CB_TKM_O_U_01_B","UK3CB_TKM_O_U_01_C","UK3CB_TKM_O_U_01_D","UK3CB_TKM_O_U_03","UK3CB_TKM_O_U_03_B","UK3CB_TKM_O_U_03_C","UK3CB_TKM_O_U_04","UK3CB_TKM_O_U_04_B","UK3CB_TKM_O_U_04_C","UK3CB_TKM_O_U_05","UK3CB_TKM_O_U_05_B","UK3CB_TKM_O_U_05_C","UK3CB_TKM_B_U_01","UK3CB_TKM_B_U_01_B","UK3CB_TKM_B_U_01_C","UK3CB_TKM_B_U_03","UK3CB_TKM_B_U_03_B","UK3CB_TKM_B_U_03_C","UK3CB_TKM_B_U_04","UK3CB_TKM_B_U_04_B","UK3CB_TKM_B_U_04_C","UK3CB_TKM_B_U_05","UK3CB_TKM_B_U_05_B","UK3CB_TKM_B_U_05_C","UK3CB_TKC_C_U_01","UK3CB_TKC_C_U_01_B","UK3CB_TKC_C_U_01_C","UK3CB_TKC_C_U_01_D","UK3CB_TKC_C_U_01_E","UK3CB_TKC_C_U_02","UK3CB_TKC_C_U_02_B","UK3CB_TKC_C_U_02_C","UK3CB_TKC_C_U_02_D","UK3CB_TKC_C_U_02_E","UK3CB_TKC_C_U_03","UK3CB_TKC_C_U_03_B","UK3CB_TKC_C_U_03_C","UK3CB_TKC_C_U_03_D","UK3CB_TKC_C_U_03_E","UK3CB_TKC_C_U_06","UK3CB_TKC_C_U_06_B","UK3CB_TKC_C_U_06_C","UK3CB_TKC_C_U_06_D","UK3CB_TKC_C_U_06_E","UK3CB_TKM_I_U_01","UK3CB_TKM_I_U_01_B","UK3CB_TKM_I_U_01_C","UK3CB_TKM_I_U_03","UK3CB_TKM_I_U_03_B","UK3CB_TKM_I_U_03_C","UK3CB_TKM_I_U_04","UK3CB_TKM_I_U_04_B","UK3CB_TKM_I_U_04_C","UK3CB_TKM_I_U_05","UK3CB_TKM_I_U_05_B","UK3CB_TKM_I_U_05_C"];

	// VESTS
	OPEX_enemy_commonVests = [];
	OPEX_enemy_beltVests = [];
	OPEX_enemy_grenadierVests = [];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["UK3CB_H_Crew_Cap"];
	OPEX_enemy_headgears = ["UK3CB_TKC_H_Turban_01_1","UK3CB_TKC_H_Turban_02_1","UK3CB_TKC_H_Turban_06_1","UK3CB_TKC_H_Turban_03_1","UK3CB_TKC_H_Turban_04_1","UK3CB_TKC_H_Turban_05_1","UK3CB_TKM_O_H_Turban_03_1","UK3CB_TKM_O_H_Turban_04_1","UK3CB_TKM_O_H_Turban_05_1","UK3CB_TKM_O_H_Turban_01_1","UK3CB_TKM_O_H_Turban_02_1","UK3CB_TKM_B_H_Turban_03_1","UK3CB_TKM_B_H_Turban_04_1","UK3CB_TKM_B_H_Turban_05_1","UK3CB_TKM_B_H_Turban_01_1","UK3CB_TKM_B_H_Turban_02_1","UK3CB_TKM_I_H_Turban_03_1","UK3CB_TKM_I_H_Turban_04_1","UK3CB_TKM_I_H_Turban_05_1","UK3CB_TKM_I_H_Turban_01_1","UK3CB_TKM_I_H_Turban_02_1","UK3CB_H_Mil_Turban_Wrap"];
	OPEX_enemy_officerHeadgears = ["UK3CB_TKC_H_Turban_04_1","UK3CB_TKC_H_Turban_05_1","UK3CB_TKM_O_H_Turban_02_1","UK3CB_TKM_B_H_Turban_02_1","UK3CB_TKM_I_H_Turban_02_1"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["UK3CB_G_Neck_Shemag_Oli","UK3CB_G_Neck_Shemag_Tan","UK3CB_G_Neck_Shemag"];
	OPEX_enemy_scarfs = ["G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_tan","UK3CB_G_Face_Wrap_01"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_K","UK3CB_CHC_C_B_HIKER","UK3CB_UN_B_B_RIF","UK3CB_B_Fieldpack","UK3CB_B_Hiker","UK3CB_CW_US_B_LATE_B_RIF_03","UK3CB_CW_SOV_O_LATE_B_Sidor_RIF","UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF","UK3CB_TKA_O_B_RIF_Khk","UK3CB_TKA_O_B_ENG_Khk","UK3CB_TKA_O_B_RIF_Tan","UK3CB_TKA_O_B_ENG_Tan"];