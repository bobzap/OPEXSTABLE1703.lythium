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
	_OPEX_enemy_subFaction = "STR_enemy_name_BOKO_4"; // e.g.; "Boko Haram"
	_OPEX_enemy_factionName1 = "STR_enemy_name_BOKO_1"; // e.g.: The islamic State
	_OPEX_enemy_factionName2 = "STR_enemy_name_BOKO_2"; // e.g.: the islamic state
	_OPEX_enemy_factionName3 = "STR_enemy_name_BOKO_3"; // e.g.: Daesh
	_OPEX_enemy_factionName4 = "STR_enemy_name_BOKO_4"; // e.g.: Daesh
	_OPEX_enemy_fighters = "STR_enemy_fighters_BOKO"; // e.g.: islamists

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
	OPEX_enemy_flagTexture = "pictures\flag_boko.paa";

	// AI GLOBAL SKILL
	OPEX_enemy_AIskill = [0.10, 0.50]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_enemy_names = ["Abedi Traoré", "Joseph-Désiré Amokachi", "Joseph Touré", "Désiré Sanogo", "Désiré Keita", "Mamadou N'Diaye", "Mamadou Moussa", "Moudiou Traoré", "André Diallo", "Joseph Diallo", "Moussa Diallo", "Mamadou Diakhaby", "Youssouf Diarra", "Abdoulaye Diarra", "Bafétimbi Ouedraogo", "Yaya M'Boukambé", "Youssouf Touré", "Ousmane Diakhaby", "Pape Sanogo", "Moussa Diakité", "Joseph Dembélé", "Bertrand Doukouré", "Moussa Traoré", "Basile Azola", "Pape Diakhaby", "Moussa Keita", "Pierre Mané", "André Koulibaly", "Idrissa Onana", "Kalidou Sané", "Abedi Yekini", "Emmanuel Ikpeba", "Georges Amuniké", "Patrick Kanu", "Diouf Touré", "Didier Weah", "Basile Traoré", "Basile Touré", "Basile Keita", "Kalidou Moussa", "Idrissa Diakhaby", "Issa Yekini", "Souleymane Mané", "Souleymane Ikpeba", "Djibril Diawara", "Adboulaye Dembélé", "Adama Dembélé", "Amadou Diawara", "Boubacar N'Diaye", "Habib N'Diaye", "Babacar N'Diefi", "Lassana Ouedraogo", "Lassana Diakhaby", "Lassana Dembélé", "Djibril Moussa", "Issa Diomandé"];

	// UNITS
	OPEX_enemy_rifleman = "CFP_O_BH_Rifleman_AK47_01";
	OPEX_enemy_teamLeader = "CFP_O_BH_Team_Leader_01";
	OPEX_enemy_grenadier = "CFP_O_BH_Grenadier__AK74_01";
	OPEX_enemy_MG = "CFP_O_BH_Machine_Gunner_PKM_01";
	OPEX_enemy_AT = "CFP_O_BH_Rifleman_AT_AK47_01";
	OPEX_enemy_AA = "CFP_O_BH_Explosive_Specialist_01";
	OPEX_enemy_marksman = "CFP_O_BH_Sniper_Enfield_01";
	OPEX_enemy_crewman = "CFP_O_BH_Rifleman_AK74_01";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman];
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

	// VEHICLES
	OPEX_enemy_transportTrucks = ["CFP_O_BH_Ural_01"];
	OPEX_enemy_fuelTrucks = ["I_G_VAN_01_fuel_F", "O_G_VAN_01_fuel_F", "C_VAN_01_fuel_F", "C_truck_02_fuel_F"];
	OPEX_enemy_transportCars = ["CFP_O_BH_Offroad_01"];
	OPEX_enemy_combatCars = ["CFP_O_BH_Humvee_M2_01", "CFP_O_BH_Landrover_M2_01", "CFP_O_BH_Offroad_AT_01", "CFP_O_BH_Offroad_MG_01", "CFP_O_BH_Pickup_PK_01"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_armored = ["cfp_o_is_T34", "cfp_o_is_T55", "cfp_o_is_T72", "cfp_o_is_T72_flag", "cfp_o_is_BMP1", "cfp_o_is_BMP1P", "cfp_o_is_BMP2", "cfp_o_is_BMP2_PKM", "cfp_o_is_M113", "cfp_o_is_M113_flag"];
	OPEX_enemy_MGstatics = ["CFP_O_BH_DShKM_01"];
	OPEX_enemy_GLstatics = ["cfp_o_is_AGS"];
	OPEX_enemy_ATstatics = ["CFP_O_BH_SPG_9_01"];
	OPEX_enemy_AAstatics = ["cfp_o_is_Metis"];
	OPEX_enemy_mortarStatics = ["CFP_O_BH_Podnos_2B14_01"];
	OPEX_enemy_artilleryBatteries = ["cfp_o_is_M119"];
	OPEX_enemy_AAbatteries = ["CFP_O_BH_ZU_23_01"];
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
	OPEX_enemy_commonUniforms = ["U_BG_Guerilla2_3", "U_BG_Guerilla2_1", "U_I_C_Soldier_Bandit_5_F", "U_I_C_Soldier_Bandit_1_F", "U_I_C_Soldier_Bandit_3_F", "U_I_C_Soldier_Bandit_2_F", "U_I_C_Soldier_Para_3_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_5_F", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Para_2_F", "CFP_Bandit_Adidas", "CFP_Bandit_Africa", "CFP_Bandit_Chang", "CFP_Bandit_ChocChip", "CFP_U_BattleDressUniform_dpmwoodlandgreen", "CFP_U_BattleDressUniform_edrl", "CFP_U_BattleDressUniform_M81light", "CFP_U_BattleDressUniform_M81_Sudan", "CFP_U_BattleDressUniform_M81", "CFP_U_BattleDressUniform_polygondesertdark", "CFP_U_BattleDressUniform_polygonwoodlanddark", "CFP_U_BattleDressUniform_tigerstripe2", "CFP_U_BattleDressUniform_tigerstripe", "CFP_U_BattleDressUniform_woodlanddark", "CFP_BDU_ERDL", "CFP_BDU_M81Mali", "CFP_BDU_M81Sudan2", "CFP_BDU_M81", "CFP_U_FieldUniform_AfricanWoodlandDark", "CFP_U_FieldUniform_DPMWoodland", "CFP_U_FieldUniform_edrl", "SP_0000_Standard_FieldUniform_Green", "CFP_U_FieldUniform_M81light", "CFP_U_FieldUniform_M81_Sudan", "CFP_U_FieldUniform_M81", "CFP_U_FieldUniform_polygondesertdark", "CFP_U_FieldUniform_polygonwoodlanddark", "CFP_U_FieldUniform_tigerstripe2", "CFP_U_FieldUniform_tigerstripe", "CFP_U_FieldUniform_marpatugandadark", "CFP_U_FieldUniform_marpatugandalight", "CFP_U_FieldUniform_woodlanddark", "CFP_U_FieldUniform_woodlandlight", "SP_0000_Standard_FieldUniform_ATacsFG_SS", "CFP_FieldUniform_blackacu_SS", "CFP_FieldUniform_dcum81_SS", "CFP_U_FieldUniform_M81_Sudan_SS", "CFP_U_FieldUniform_M81_SS", "CFP_U_FieldUniform_marpat_d_SS", "CFP_U_FieldUniform_marpat_w_SS", "CFP_FieldUniform_marpatm81_SS", "CFP_U_FieldUniform_tiger_desert_SS", "CFP_GUER_3CDespants", "CFP_GUER_ChocChippants", "CFP_GUER_ERDLpants", "CFP_GUER_GreenTan", "CFP_GUER_M81Tee", "CFP_GUER_M81Tee", "CFP_GUER_M81Tee", "CFP_GUER_M81", "CFP_GUER_MCampants", "CFP_GUER_PolyDesTee", "CFP_GUER_PolyDespants", "CFP_GUER_Khk_Wdl", "CFP_GUER_Tigerpants", "CFP_Polo_Liverpool", "CFP_Polo_RealMadrid", "SP_0000_Standard_WorkUniform_ATacsFG", "CFP_U_WorkUniform_DPM", "CFP_U_WorkUniform_Green", "CFP_U_WorkUniform_M81Des", "CFP_U_WorkUniform_M81_Sudan", "CFP_U_WorkUniform_M81", "CUP_U_B_BAF_BDU_DPM", "CUP_U_B_BAF_BDU_DPM_ODBottom", "CUP_U_B_US_BDU_roll2", "CUP_U_B_US_BDU_roll", "CUP_U_B_CZ_WDL_TShirt", "CUP_B_USMC_Navy_Blue", "CUP_B_USMC_Navy_Brown", "CUP_B_USMC_Navy_Green", "CUP_B_USMC_Navy_Red", "CUP_B_USMC_Navy_Violet", "CUP_B_USMC_Navy_Yellow", "CUP_U_O_Partisan_TTsKO", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_I_B_PMC_Unit_20", "CUP_I_B_PMC_Unit_17", "CUP_I_B_PMC_Unit_13", "CUP_I_B_PMC_Unit_14","CUP_I_B_PMC_Unit_16","CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Green","CFP_U_FieldUniform_AfricanWoodlandDark","CFP_U_FieldUniform_AfricanWoodlandLight"];

	// VESTS
	OPEX_enemy_commonVests = ["V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_HarnessO_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F", "CFP_AK_VEST_Black", "CFP_AK_VEST_EDRL", "CFP_AK_VEST_LOlive", "CFP_AK_VEST_Lime", "CFP_AK_VEST_M81", "CFP_AK_VEST_Olive", "CFP_AK_VEST_Tan", "CFP_AK_VEST", "CFP_Alice_Vest", "CFP_Alice_Vest2_Black", "CFP_Alice_Vest2", "SP_Bandolier1_Grey", "SP_Bandolier1_Black", "SP_Bandolier1_Green", "SP_Bandolier1_Tan", "SP_Tactical1_Black", "CFP_Tactical1_DPM", "CFP_Tactical1_EDRL", "SP_Tactical1_Green", "CFP_Tactical1_M81", "SP_Tactical1_Tan", "CFP_Tactical1_Woodland", "CFP_UtilityJacket_ChocChip", "CFP_UtilityJacket_EDRL", "CFP_UtilityJacket_M81", "CFP_UtilityJacket_PolygonDesert", "CFP_UtilityJacket_PolygonWoodland", "CFP_UtilityJacket_Woodland", "CUP_V_I_Guerilla_Jacket"];
	OPEX_enemy_beltVests = ["SP_Holster1_Black", "SP_Holster1_Brown", "CUP_V_B_BAF_MTP_Osprey_Mk4_Belt"];
	OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_brn", "V_HarnessOGL_gry"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_enemy_headgears = ["H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_surfer", "H_Bandanna_surfer_blk", "H_Cap_tan", "H_Cap_blk", "H_Cap_oli", "H_Cap_surfer", "H_Cap_grn", "H_Cap_red", "H_Hat_camo", "H_Hat_grey", "H_Hat_tan", "H_Hat_brown", "H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_tna_F", "H_StrawHat_dark", "H_ShemagOpen_tan", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_khk", "SP_BaseballCap_TweedCheckedBrown", "SP_BaseballCap_TweedCheckedGreen", "SP_BaseballCap_TweedCheckedGrey", "SP_BoonieHat_Black", "SP_BoonieHat_Green", "CFP_BoonieHat_M81", "CFP_BoonieHat_PolygonWoodland", "CFP_Headband_wdl", "SP_BoonieHat_Black", "SP_Hood_Black", "SP_Hood_Green", "CFP_Lungee_Shemagh_Black", "SP_Shemagh_Black", "SP_Shemagh_Black", "SP_Shemagh_Black", "SP_Shemagh_CheckBlack", "SP_Shemagh_CheckGreen", "SP_Shemagh_Green", "CFP_Shemagh_Head_Black", "CFP_Shemagh_Head_M81", "CFP_Shemagh_Full_Black", "CFP_Shemagh_Full_Green", "CFP_Shemagh_Full_M81"];
	OPEX_enemy_officerHeadgears = ["SP_Beret_Black", "SP_Beret_Brown", "SP_Beret_Grey", "SP_Beret_Tan", "SP_Beret_Yellow", "SP_Shemagh_CheckRed", "CFP_Shemagh_Full_Red", "CFP_Shemagh_Head_Red"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk"];
	OPEX_enemy_scarfs = ["G_Bandanna_aviator", "G_Bandanna_aviator", "G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_aviator", "G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_blk", "G_Bandanna_oli", "CFP_Shemagh_Half_Black", "CFP_Shemagh_Half_Black", "CFP_Shemagh_Half_Black", "CFP_Shemagh_Half_Red", "CFP_Shemagh_Half_Tan", "CUP_FR_NeckScarf3", "CUP_FR_NeckScarf", "CUP_FR_NeckScarf5", "CUP_FR_NeckScarf2","CFP_Shemagh_Neck_Black","CFP_Shemagh_Neck_Creme","CFP_Shemagh_Neck_Gold","CFP_Shemagh_Neck_M81","CFP_Shemagh_Face_Red","CFP_Shemagh_Face_Tan"];
	OPEX_enemy_glasses = ["G_Squares","G_Spectacles"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted", "G_Spectacles", "G_Aviator", "G_Aviator", "G_Aviator", "G_Aviator", "G_Aviator", "G_Spectacles_Tinted"];
	OPEX_enemy_beards = ["CFP_Beard","CFP_Beard_Grey","CFP_Scarfbeard_green","CFP_Scarfbeard_grey","CFP_Scarfbeard_tan"];
	
	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr", "CUP_B_AlicePack_OD", "CUP_B_AlicePack_Bedroll", "CUP_B_USPack_Black"];