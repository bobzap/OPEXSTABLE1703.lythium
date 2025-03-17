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
	_OPEX_enemy_subFaction = "STR_enemy_name_ULTRA_4"; // e.g.; "Ultranationalists"
	_OPEX_enemy_factionName1 = "STR_enemy_name_ULTRA_1"; // e.g.: The islamic State
	_OPEX_enemy_factionName2 = "STR_enemy_name_ULTRA_2"; // e.g.: the islamic state
	_OPEX_enemy_factionName3 = "STR_enemy_name_ULTRA_3"; // e.g.: Daesh
	_OPEX_enemy_factionName4 = "STR_enemy_name_ULTRA_4"; // e.g.: Daesh
	_OPEX_enemy_fighters = "STR_enemy_fighters_ULTRA"; // e.g.: islamists

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
	OPEX_enemy_flagTexture = "\A3\Data_F\Flags\Flag_FIA_CO.paa";

	// AI GLOBAL SKILL
	OPEX_enemy_AIskill = [0.10, 0.50]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_enemy_names = ["Dimitri Podolski", "Josef Sukolin", "Alexander Pavlov", "Yuri Medvedev", "Michail Takochev", "Andreï Takarov", "Ivan Ramichenko", "Dimitri Letchkov", "Sergeï Kolarov", "Piotr Diakonov", "Andreas Volavetti", "Andrea Pessotto", "Gianluigi Perotta", "Zvoran Savicević", "Stefan Malaković", "Niko Stavić", "Zvonimir Brnović", "Ivan Djoković", "Novak Djordjević", "Pedrag Halilhodžić", "Miroslav Brožović", "Miralem Popescu", "Gheorghe Perišić", "Stavros Papadopulos", "Nikos Ariarankis", "Georgios Solaris", "Nikola Konstandinos", "Adonis Rastapopoulos", "Lars König", "Stefan Braüser", "Oliver Kimmich", "Thomas Matthäus", "Karl-Heinz Müller", "Friedrich Ziegler", "Hanz Möller", "Peter Hassler", "Phillip Wagner", "Stefan Werner", "Jakob van Kerkoven", "Ruben Depay", "Jeff van Houten", "Joshua de Ligt", "Markus de Boer"];

	// UNITS
	OPEX_enemy_rifleman = "CUP_O_INS_Soldier";
	OPEX_enemy_teamLeader = "CUP_O_INS_Officer";
	OPEX_enemy_grenadier = "CUP_O_INS_Soldier_GL";
	OPEX_enemy_MG = "CUP_O_INS_Soldier_MG";
	OPEX_enemy_AT = "CUP_O_INS_Soldier_AT";
	OPEX_enemy_AA = "CUP_O_INS_Soldier_AA";
	OPEX_enemy_marksman = "CUP_O_INS_Sniper";
	OPEX_enemy_crewman = "CUP_O_INS_Crew";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman];
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

	// VEHICLES
	OPEX_enemy_transportTrucks = ["CUP_O_Ural_Open_CHDKZ", "CUP_O_Ural_CHDKZ", "CUP_O_Ural_CHDKZ", "CUP_O_Ural_CHDKZ"];
	OPEX_enemy_fuelTrucks = ["CUP_O_Ural_Refuel_CHDKZ"];
	OPEX_enemy_transportCars = ["CUP_O_Datsun_4seat", "CUP_O_Datsun_4seat", "CUP_O_UAZ_Unarmed_CHDKZ", "CUP_O_UAZ_Open_CHDKZ"];
	OPEX_enemy_combatCars = ["CUP_O_Datsun_PK", "CUP_O_Datsun_PK_Random", "CUP_O_Datsun_PK_Random", "CUP_O_UAZ_MG_CHDKZ", "CUP_O_UAZ_METIS_CHDKZ"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_armored = ["CUP_O_T55_CHDKZ", "CUP_O_T72_CHDKZ", "CUP_O_BMP2_CHDKZ", "CUP_O_BRDM2_CHDKZ"];
	OPEX_enemy_MGstatics = ["CUP_O_DSHKM_ChDKZ"];
	OPEX_enemy_GLstatics = ["CUP_O_AGS_ChDKZ"];
	OPEX_enemy_ATstatics = ["CUP_O_SPG9_ChDKZ"];
	OPEX_enemy_AAstatics = ["CUP_O_SPG9_ChDKZ"];
	OPEX_enemy_mortarStatics = ["CUP_O_2b14_82mm_ChDKZ"];
	OPEX_enemy_artilleryBatteries = ["CUP_O_D30_AT_ChDKZ"];
	OPEX_enemy_AAbatteries = ["CUP_O_ZU23_ChDKZ"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics;

	// WEAPONS
	OPEX_enemy_commonHandguns = ["CUP_hgun_PB6P9", "CUP_hgun_Makarov"];
	OPEX_enemy_specialHandguns = ["CUP_hgun_MicroUzi"];
	OPEX_enemy_commonRifles = ["CUP_arifle_AK47_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AK74_Early", "CUP_srifle_LeeEnfield"];
	OPEX_enemy_specialRifles = ["CUP_arifle_AKM_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS74_Early", "CUP_arifle_M16A1", "CUP_smg_saiga9", "CUP_sgun_Saiga12K"];
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
	OPEX_enemy_commonUniforms = ["U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1", "U_BG_leader", "U_I_C_Soldier_Camo_F", "U_BG_Guerilla2_3", "U_BG_Guerilla2_1", "U_I_C_Soldier_Para_3_F", "U_I_C_Soldier_Para_2_F", "SP_0000_Standard_BattleDressUniform_ATacsFG", "CFP_U_BattleDressUniform_dpmwoodlandgreen", "CFP_U_BattleDressUniform_DPMWoodland", "CFP_U_BattleDressUniform_edrl", "SP_0000_Standard_BattleDressUniform_GreenOlive", "SP_0000_Standard_BattleDressUniform_Green", "SP_0000_Standard_BattleDressUniform_Grey", "CFP_U_BattleDressUniform_M81light", "CFP_U_BattleDressUniform_M81", "CFP_U_BattleDressUniform_polygonwoodlanddark", "CFP_U_BattleDressUniform_tigerstripe2", "CFP_U_BattleDressUniform_tigerstripe", "CFP_U_BattleDressUniform_woodlanddark", "CFP_BDU_ERDL", "CFP_BDU_M81Sudan2", "CFP_BDU_M81", "CFP_U_Crye_M81", "CFP_U_FieldUniform_AfricanWoodlandDark", "CFP_U_FieldUniform_DPMWoodland", "CFP_U_FieldUniform_edrl", "SP_0000_Standard_FieldUniform_Green", "SP_0000_Standard_FieldUniform_Grey", "CFP_U_FieldUniform_M81light", "CFP_U_FieldUniform_M81_Sudan", "CFP_U_FieldUniform_M81", "CFP_U_FieldUniform_multicam", "CFP_U_FieldUniform_polygonwoodlanddark", "CFP_U_FieldUniform_tigerstripe2", "CFP_U_FieldUniform_tigerstripe", "CFP_U_FieldUniform_marpatugandadark", "CFP_U_FieldUniform_woodlanddark", "SP_0000_Standard_PulloverUniform_ATacsFG", "SP_0000_Standard_PulloverUniform_Black", "SP_0000_Standard_PulloverUniform_GreenOlive", "SP_0000_Standard_PulloverUniform_Green", "SP_0000_Standard_PulloverUniform_Grey", "SP_0000_Standard_PulloverUniform_NodUrban", "SP_0000_Standard_WorkUniform_ATacsFG", "CFP_U_WorkUniform_DPM", "CFP_U_WorkUniform_Green", "CFP_U_WorkUniform_M81Des", "CFP_U_WorkUniform_M81_Sudan", "CFP_U_WorkUniform_M81", "CFP_U_WorkUniform_TanM81", "CUP_U_B_BAF_BDU_DPM", "CUP_U_B_BAF_BDU_DPM_ODBottom", "CUP_U_B_GER_BDU_Flecktarn_ODBottom", "CUP_U_O_CHDKZ_Bardak", "CUP_U_O_CHDKZ_Lopotev", "CUP_U_O_CHDKZ_Kam_03", "CUP_U_O_CHDKZ_Kam_01", "CUP_U_O_CHDKZ_Kam_04", "CUP_U_O_CHDKZ_Commander", "CUP_U_O_CHDKZ_Kam_08", "CUP_U_O_CHDKZ_Kam_05", "CUP_U_O_CHDKZ_Kam_07", "CUP_U_O_CHDKZ_Kam_06", "CUP_U_I_GUE_Flecktarn2", "CUP_U_I_GUE_Flecktarn3", "CUP_U_I_GUE_Flecktarn", "CUP_U_I_GUE_Woodland1", "CUP_U_C_Pilot_01", "CUP_I_B_PMC_Unit_23", "CUP_U_C_Woodlander_01", "CUP_U_C_Woodlander_02", "CUP_U_C_Woodlander_03", "CUP_U_C_Woodlander_04"];

	// VESTS
	OPEX_enemy_commonVests = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_HarnessO_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F", "CFP_AK_VEST_Black", "CFP_AK_VEST_EDRL", "CFP_AK_VEST_LOlive", "CFP_AK_VEST_Lime", "CFP_AK_VEST_M81", "CFP_AK_VEST_Olive", "CFP_AK_VEST_Tan", "CFP_AK_VEST", "CFP_Alice_Vest", "CFP_Alice_Vest2_Black", "CFP_Alice_Vest2", "SP_Bandolier1_Grey", "SP_Bandolier1_Black", "SP_Bandolier1_Green", "SP_Bandolier1_Tan", "SP_Tactical1_Black", "CFP_Tactical1_DPM", "CFP_Tactical1_EDRL", "SP_Tactical1_Green", "CFP_Tactical1_M81", "SP_Tactical1_Tan", "CFP_Tactical1_Woodland", "CFP_UtilityJacket_ChocChip", "CFP_UtilityJacket_EDRL", "CFP_UtilityJacket_M81", "CFP_UtilityJacket_PolygonDesert", "CFP_UtilityJacket_PolygonWoodland", "CFP_UtilityJacket_Woodland", "CUP_V_I_Guerilla_Jacket"];
	OPEX_enemy_beltVests = ["SP_Holster1_Black", "SP_Holster1_Brown", "CUP_V_B_BAF_MTP_Osprey_Mk4_Belt"];
	OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_brn", "V_HarnessOGL_gry"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_enemy_headgears = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo", "H_Cap_tan", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn", "H_Cap_red", "H_Hat_camo", "H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_tna_F", "SP_BoonieHat_Black", "SP_BoonieHat_Green", "CFP_BoonieHat_M81", "CFP_BoonieHat_PolygonWoodland", "CFP_PatrolCap_Woodland", "CFP_PatrolCap_PolygonWoodland", "CFP_PatrolCap_M81", "CFP_PatrolCap_M81Sudan", "CUP_H_PMC_Beanie_Khaki", "CFP_75th_Beanie_Khaki2", "SP_BeanieHat_Black"];
	OPEX_enemy_officerHeadgears = ["SP_Beret_Black", "SP_Beret_Brown", "SP_Beret_Grey", "SP_Beret_Tan", "SP_Beret_Yellow", "SP_Beret2_Black", "SP_Beret2_Brown", "SP_Beret2_Grey", "SP_Beret2_Red", "SP_Beret2_Tan", "SP_Beret2_Yellow", "CFP_Headband_wdl"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli"];
	OPEX_enemy_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];
	OPEX_enemy_beards = ["CFP_Beard","CFP_Beard_Grey","CFP_Scarfbeard_green","CFP_Scarfbeard_grey","CFP_Scarfbeard_tan"];
	
	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr", "CUP_B_AlicePack_OD", "CUP_B_AlicePack_Bedroll", "CUP_B_USPack_Black"];