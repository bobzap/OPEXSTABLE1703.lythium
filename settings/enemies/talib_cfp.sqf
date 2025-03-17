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

	if (!(isClass (configFile >> "CfgPatches" >> "cfp_main"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	_OPEX_enemy_modName = "CFP"; // e.g.: "CFP"
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
	OPEX_enemy_names = ["Abdel Brahimi", "Youcef Brahimi", "Djalil Brahimi", "Rachid Brahimi", "Ahmed Brahimi", "Amine El Tarkouri", "Djawad El Boukhrissi", "Habid Bounar", "Saïd Ben Youcef", "Habid Ben Youssef", "Saïd Bennacer", "Allah Bennacer", "Khaled Daouadi", "Djamal Bennacer", "Ismaël Slimani", "Ismaïl Abdellaoui", "Khaled Abdellaoui", "Ahmed Abdellaoui", "Zinedine al-Bagdadi", "Khaled Mansouri", "Ibrahim Mazraoui", "Habib Mazraoui", "Abdelatif Boutaïb", "Karim Idrissi", "Karim Chafik", "Mehdi El Hajjam", "Hicham al-Arabi", "Karim al-Muslim", "Allah al-Boukrissi", "Ismaël al-Arabbi", "Karim Ben Youssef", "Zinedine Benharda", "Ahmed Bentaleb", "Rachid Benatia", "Rachid al-Malawi", "Mehdi Touati", "Abdelkrim Driddi", "Abdelkrim al-Tayeb", "Issam Tayeb", "Oussama Bennasser", "Mohammed Mazraoui", "Mohamed el-Fahaoui", "Mohammed Benzema", "Khalid Ben Arfa", "Yacine Bouderbala", "Mourad Benzia", "Ahmed Bentala", "Driss El Karkouri", "Habib Hadji", "Islam al-Tayeb", "Islam Al Khaled", "Issam Ben Laden", "Djawad Benzema", "Khaled Merah", "Samir Merah", "Bilal Merah", "Hamza Ben Ouarda", "Idriss Ben Yecin", "Ibrahim Ben Malik", "Malik Bouderbalah", "Rayan Ben Mabrouk", "Khalid Ben Mabrouk", "Khalid Ben Malek", "Malek al-Wahda", "Nasser Boutaleb", "Nacer Ramhadi", "Nasser Soltani"];

	// UNITS
	OPEX_enemy_rifleman = "CFP_O_TBAN_Rifleman_AK_47_01";
	OPEX_enemy_teamLeader = "CFP_O_TBAN_Team_Leader_01";
	OPEX_enemy_grenadier = "CFP_O_TBAN_Grenadier_AK_74_01";
	OPEX_enemy_MG = "CFP_O_TBAN_Machine_Gunner_01";
	OPEX_enemy_AT = "CFP_O_TBAN_AT_Rifleman_2_01";
	OPEX_enemy_AA = "CFP_O_TBAN_AA_Specialist_01";
	OPEX_enemy_marksman = "CFP_O_TBAN_Sniper_01";
	OPEX_enemy_crewman = "CFP_O_TBAN_Rifleman_Lee_Enfield_01";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman];
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

	// VEHICLES
	OPEX_enemy_transportTrucks = ["CFP_O_TBAN_Truck_01", "CFP_O_TBAN_Praga_V3S_01"];
	OPEX_enemy_fuelTrucks = ["I_G_VAN_01_fuel_F", "O_G_VAN_01_fuel_F", "C_VAN_01_fuel_F", "C_truck_02_fuel_F"];
	OPEX_enemy_transportCars = ["CFP_O_TBAN_Dastun_Pickup_01"];
	OPEX_enemy_combatCars = ["CFP_O_TBAN_Offroad_Armed_01", "CFP_O_TBAN_Technical_PK_01"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_armored = ["CUP_O_MTLB_pk_TK_MILITIA"];
	OPEX_enemy_MGstatics = ["CFP_O_TBAN_DShKM_01"];
	OPEX_enemy_GLstatics = ["cfp_o_is_AGS"];
	OPEX_enemy_ATstatics = ["CFP_O_TBAN_SPG_9_01"];
	OPEX_enemy_AAstatics = ["cfp_o_is_Metis"];
	OPEX_enemy_mortarStatics = ["CFP_O_TBAN_Podnos_2B14_01"];
	OPEX_enemy_artilleryBatteries = ["cfp_o_is_M119"];
	OPEX_enemy_AAbatteries = ["cfp_o_is_ZU23"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics;

	// WEAPONS
	OPEX_enemy_commonHandguns = ["CUP_hgun_PB6P9", "CUP_hgun_Makarov"];
	OPEX_enemy_specialHandguns = ["CUP_hgun_MicroUzi"];
	OPEX_enemy_commonRifles = ["CUP_arifle_AK47_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AK74_Early", "CUP_srifle_LeeEnfield", "CUP_srifle_LeeEnfield", "CUP_srifle_LeeEnfield"];
	OPEX_enemy_specialRifles = ["CUP_arifle_AKM_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS74_Early", "CUP_arifle_M16A1"];
	OPEX_enemy_GLrifles = ["CUP_arifle_AK74_GL_Early", "CUP_arifle_AKM_GL_Early"];
	OPEX_enemy_MGrifles = ["CUP_lmg_PKM", "CUP_lmg_Pecheneg"];
	OPEX_enemy_precisionRifles = ["CUP_srifle_CZ550"];
	OPEX_enemy_sniperRifles = ["CUP_srifle_SVD_top_rail", "CUP_srifle_SVD"];
	OPEX_enemy_ATlaunchers = ["CUP_launch_RPG7V"];
	OPEX_enemy_AAlaunchers = ["CUP_launch_FIM92Stinger", "CUP_launch_9K32Strela"];

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
	OPEX_enemy_commonUniforms = ["CFP_U_KhetPartug_Long_AfricanWoodland", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Black", "CFP_U_KhetPartug_Long_Blue", "CFP_U_KhetPartug_Long_BlueGrey", "CFP_U_KhetPartug_Long_Brown", "CFP_U_KhetPartug_Long_Creme", "CFP_U_KhetPartug_Long_EDRL", "CFP_U_KhetPartug_Long_Grey", "CFP_U_KhetPartug_Long_light_olive", "CFP_U_KhetPartug_Long_M81", "CFP_U_KhetPartug_Long_olive_polygon", "CFP_U_KhetPartug_Long_olive", "CFP_U_KhetPartug_Long_PolygonDesert", "CFP_U_KhetPartug_Long_Purple", "CFP_U_KhetPartug_Short_Black", "CFP_U_KhetPartug_Short_Black", "CFP_U_KhetPartug_Short_Black", "CFP_U_KhetPartug_Short_Black", "CFP_U_KhetPartug_Short_Black", "CFP_U_KhetPartug_Short_Blue", "CFP_U_KhetPartug_Short_BlueGrey", "CFP_U_KhetPartug_Short_Brown", "CFP_U_KhetPartug_Short_Creme", "CFP_U_KhetPartug_Short_EDRL", "CFP_U_KhetPartug_Short_GreenOlive", "CFP_U_KhetPartug_Short_Grey", "CFP_U_KhetPartug_Short_light_olive", "CFP_U_KhetPartug_Short_M81", "CFP_U_KhetPartug_Short_olive_polygon", "CFP_U_KhetPartug_Short_olive", "CFP_U_KhetPartug_Short_PolygonDesert", "CFP_U_KhetPartug_Short_Purple", "CFP_U_KhetPartug_Short_Tan", "CFP_U_KhetPartug_Short_Woodland", "CFP_U_KhetPartug_Long_Tan", "CFP_U_KhetPartug_Long_Woodland", "CUP_I_B_PMC_Unit_20", "CUP_I_B_PMC_Unit_17", "CUP_I_B_PMC_Unit_13"];

	// VESTS
	OPEX_enemy_commonVests = ["V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_TacVest_camo", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F", "CFP_AK_VEST_Black", "CFP_AK_VEST_EDRL", "CFP_AK_VEST_LOlive", "CFP_AK_VEST_M81", "CFP_AK_VEST_Olive", "CFP_Alice_Vest2_Black", "SP_Bandolier1_Grey", "SP_Bandolier1_Black", "SP_Bandolier1_Green", "CFP_Field_Satchel", "CFP_Field_Satchel", "CFP_Field_Satchel", "CFP_LBT1961_Black", "SP_Modular1_Black", "SP_Modular1_Green", "SP_Modular1_Grey", "CFP_Modular1_IDF", "CFP_Modular1_M81", "CFP_Modular1_Woodland", "SP_OpforRig1_Black", "CFP_Modular1_M81", "CFP_Modular1_Woodland", "SP_OpforRig1_Green", "CFP_RAV_Black", "CFP_RAV_IDF", "CFP_RAV_Green", "SP_Tactical1_Black", "CFP_Tactical1_DPM", "CFP_Tactical1_EDRL", "SP_Tactical1_Green", "CFP_Tactical1_M81", "CFP_Tactical1_Woodland", "CFP_TakJacket_AfricanWoodland", "CFP_TakJacket_ChocChip", "CFP_TakJacket_EDRL", "CFP_TakJacket_M81", "CFP_TakJacket_OD", "CFP_TakJacket_PolygonDesert", "CFP_TakJacket_PolygonWoodland", "CFP_TakJacket_SudanWoodland", "CFP_TakJacket_Woodland", "CFP_UtilityJacket_ChocChip", "CFP_UtilityJacket_EDRL", "CFP_UtilityJacket_M81", "CFP_UtilityJacket_PolygonDesert", "CFP_UtilityJacket_PolygonWoodland", "CFP_UtilityJacket_Woodland", "CUP_V_I_Guerilla_Jacket", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01", "CUP_V_OI_TKI_Jacket5_04", "CUP_V_OI_TKI_Jacket5_05", "CUP_V_OI_TKI_Jacket5_02", "CUP_V_OI_TKI_Jacket5_06", "CUP_V_OI_TKI_Jacket5_03", "CUP_V_OI_TKI_Jacket5_01", "CUP_V_OI_TKI_Jacket3_04", "CUP_V_OI_TKI_Jacket3_02", "CUP_V_OI_TKI_Jacket3_03", "CUP_V_OI_TKI_Jacket3_05", "CUP_V_OI_TKI_Jacket3_06", "CUP_V_OI_TKI_Jacket3_01", "CUP_V_OI_TKI_Jacket6_04", "CUP_V_OI_TKI_Jacket6_05", "CUP_V_OI_TKI_Jacket6_02", "CUP_V_OI_TKI_Jacket6_06", "CUP_V_OI_TKI_Jacket6_03", "CUP_V_OI_TKI_Jacket6_01", "CUP_V_OI_TKI_Jacket2_04", "CUP_V_OI_TKI_Jacket2_06", "CUP_V_OI_TKI_Jacket2_03", "CUP_V_OI_TKI_Jacket2_02", "CUP_V_OI_TKI_Jacket2_05", "CUP_V_OI_TKI_Jacket2_01"];
	OPEX_enemy_beltVests = ["SP_Holster1_Black"];
	OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_enemy_headgears = ["H_ShemagOpen_tan", "H_Shemag_olive", "H_ShemagOpen_khk", "SP_BaseballCap_TweedCheckedBrown", "SP_BaseballCap_TweedCheckedGreen", "SP_BaseballCap_TweedCheckedGrey", "CFP_Lungee_BlueGrey", "CFP_Lungee_Brown", "CFP_Lungee_Green", "CFP_Lungee_Grey", "CFP_Lungee_LightOlive", "CFP_Lungee_M81", "CFP_Lungee_Tan", "CFP_Lungee_Shemagh_Black", "CFP_Lungee_Shemagh_M81", "CFP_Lungee_Shemagh_Olive", "SP_Shemagh_CheckRed", "CUP_H_TKI_Lungee_01", "CUP_H_TKI_Lungee_02", "CUP_H_TKI_Lungee_03", "CUP_H_TKI_Lungee_04", "CUP_H_TKI_Lungee_05", "CUP_H_TKI_Lungee_06", "CUP_H_TKI_Pakol_1_01" , "CUP_H_TKI_Pakol_2_04", "CUP_H_TKI_Pakol_2_05", "CUP_H_TKI_Pakol_2_06", "CUP_H_TKI_Pakol_1_02", "CUP_H_TKI_Pakol_1_03", "CUP_H_TKI_Pakol_1_04", "CUP_H_TKI_Pakol_1_05", "CUP_H_TKI_Pakol_1_061", "CUP_H_TKI_Pakol_2_01", "CUP_H_TKI_Pakol_2_02", "CUP_H_TKI_Pakol_2_03", "CUP_H_TKI_SkullCap_01", "CUP_H_TKI_SkullCap_02", "CUP_H_TKI_SkullCap_03", "CUP_H_TKI_SkullCap_04", "CUP_H_TKI_SkullCap_05", "CUP_H_TKI_SkullCap_06"];
	OPEX_enemy_officerHeadgears = ["CFP_Lungee_Open_BlueGrey", "CFP_Lungee_Open_Blue", "CFP_Lungee_Open_Brown", "CFP_Lungee_Open_Creme", "CFP_Lungee_Open_Grey", "CFP_Lungee_Open_LightOlive", "CFP_Lungee_Open_M81", "CFP_Lungee_Open_Tan", "CFP_Shemagh_Full_White"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk"];
	OPEX_enemy_scarfs = ["G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_tan", "CFP_Shemagh_Neck_Black","CFP_Shemagh_Neck_Creme","CFP_Shemagh_Neck_Gold","CFP_Shemagh_Neck_M81","CFP_Shemagh_Face_Red","CFP_Shemagh_Face_Tan"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];
	OPEX_enemy_beards = ["CFP_Beard","CFP_Beard_Grey","CFP_Scarfbeard_green","CFP_Scarfbeard_grey","CFP_Scarfbeard_tan"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr", "CUP_B_AlicePack_OD", "CUP_B_AlicePack_Bedroll", "CUP_B_USPack_Black"];