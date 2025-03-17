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
	OPEX_enemy_names = ["Dimitri Podolski", "Josef Sukolin", "Alexander Pavlov", "Yuri Medvedev", "Michail Takochev", "Andreï Takarov", "Ivan Ramichenko", "Dimitri Letchkov", "Sergeï Kolarov", "Piotr Diakonov", "Andreas Volavetti", "Andrea Pessotto", "Gianluigi Perotta", "Zvoran Savicević", "Stefan Malaković", "Niko Stavić", "Zvonimir Brnović", "Ivan Djoković", "Novak Djordjević", "Pedrag Halilhodžić", "Miroslav Brožović", "Miralem Popescu", "Gheorghe Perišić", "Stavros Papadopulos", "Nikos Ariarankis", "Georgios Solaris", "Nikola Konstandinos", "Adonis Rastapopoulos", "Lars König", "Stefan Braüser", "Oliver Kimmich", "Thomas Matthäus", "Karl-Heinz Müller", "Friedrich Ziegler", "Hanz Möller", "Peter Hassler", "Phillip Wagner", "Stefan Werner", "Jakob van Kerkoven", "Ruben Depay", "Jeff van Houten", "Joshua de Ligt", "Markus de Boer"]; // names used by the AI

	// UNITS
	OPEX_enemy_rifleman = "I_soldier_F";
	OPEX_enemy_teamLeader = "I_Soldier_TL_F";
	OPEX_enemy_grenadier = "I_Soldier_GL_F";
	OPEX_enemy_MG = "I_Soldier_AR_F";
	OPEX_enemy_AT = "I_Soldier_AT_F";
	OPEX_enemy_AA = "I_Soldier_AA_F";
	OPEX_enemy_marksman = "I_Soldier_M_F";
	OPEX_enemy_crewman = "I_crew_F";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits; // don't delete this line if you have defined any of these variables

	// VEHICLES
	OPEX_enemy_transportTrucks = ["UK3CB_CCM_O_Kamaz_Covered","UK3CB_CCM_O_Kamaz_Open","UK3CB_CCM_O_V3S_Closed","UK3CB_CCM_O_V3S_Open","UK3CB_CCM_O_Ural","UK3CB_CCM_O_Ural_Open"];
	OPEX_enemy_fuelTrucks = ["UK3CB_CCM_O_Kamaz_Fuel","UK3CB_CCM_O_V3S_Refuel","UK3CB_CCM_O_Ural_Fuel"];
	OPEX_enemy_transportCars = ["UK3CB_CCM_O_Datsun_Civ_Closed","UK3CB_CCM_O_Datsun_Civ_Open","UK3CB_CCM_O_Datsun_Open","UK3CB_CCM_O_Hilux_Civ_Closed","UK3CB_CCM_O_Hilux_Civ_Open","UK3CB_CCM_O_LR_Closed","UK3CB_CCM_O_LR_Open","UK3CB_CCM_O_UAZ_Open"];
	OPEX_enemy_combatCars = ["UK3CB_CCM_O_Datsun_Pkm","UK3CB_CCM_O_Hilux_Dshkm","UK3CB_CCM_O_Hilux_Pkm","UK3CB_CCM_O_LR_M2","UK3CB_CCM_O_UAZ_Dshkm"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars; // don't delete this line if you have defined any of these variables
	OPEX_enemy_armored = ["UK3CB_CW_SOV_O_EARLY_BMD1K","UK3CB_CW_SOV_O_EARLY_BMD1PK","UK3CB_CW_SOV_O_EARLY_BMP2","UK3CB_CW_SOV_O_EARLY_BMP2K","UK3CB_CW_SOV_O_EARLY_BRM1K","UK3CB_CW_SOV_O_EARLY_BTR40_MG","UK3CB_CW_SOV_O_EARLY_MTLB_PKT","UK3CB_CW_SOV_O_EARLY_T55","UK3CB_CW_SOV_O_EARLY_T72A","UK3CB_CW_SOV_O_EARLY_T72BM","UK3CB_CW_SOV_O_EARLY_T72B"];
	OPEX_enemy_MGstatics = ["UK3CB_TKM_O_KORD_high","UK3CB_TKM_O_DSHKM","UK3CB_TKM_O_DSHKM"];
	OPEX_enemy_GLstatics = ["UK3CB_TKM_O_AGS"];
	OPEX_enemy_ATstatics = ["UK3CB_TKM_O_SPG9"];
	OPEX_enemy_AAstatics = ["UK3CB_TKM_O_Igla_AA_pod"];
	OPEX_enemy_mortarStatics = ["UK3CB_TKM_O_2b14_82mm"];
	OPEX_enemy_AAbatteries = ["UK3CB_TKM_O_ZU23"];
	OPEX_enemy_artilleryBatteries = ["UK3CB_TKM_O_D30"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics; // don't delete this line if you have defined any of these variables

	// WEAPONS
	OPEX_enemy_commonHandguns = ["rhs_weap_makarov_pm","rhs_weap_pya","rhs_weap_6p53","rhs_weap_tt33"];
	OPEX_enemy_specialHandguns = ["rhs_weap_savz61_folded"];
	OPEX_enemy_commonRifles = ["rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74n","rhs_weap_akm","rhs_weap_akmn","UK3CB_M16_Carbine","rhs_weap_ak74m_fullplum","rhs_weap_ak104","rhs_weap_ak105"];
	OPEX_enemy_specialRifles = ["UK3CB_M16","UK3CB_M16A1","rhs_weap_ak74m","rhs_weap_ak74n_npz","rhs_weap_ak74n_2","rhs_weap_ak74n_2_npz","rhs_weap_aks74","rhs_weap_aks74n","rhs_weap_m4a1_carryhandle","rhs_weap_m4","rhs_weap_ak74mr"];
	OPEX_enemy_GLrifles = ["rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74m_gp25","rhs_weap_ak74n_gp25","UK3CB_M16A2_UGL"];
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
	OPEX_enemy_commonUniforms = ["U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","UK3CB_CHC_C_U_HIKER_04","UK3CB_TKM_O_U_06","UK3CB_TKM_O_U_06_B","UK3CB_TKM_O_U_06_C","UK3CB_TKM_B_U_06","UK3CB_TKM_B_U_06_B","UK3CB_TKM_B_U_06_C","UK3CB_TKM_I_U_06","UK3CB_TKM_I_U_06_B","UK3CB_TKM_I_U_06_C","UK3CB_CHC_C_U_WOOD_04","UK3CB_CHC_C_U_WOOD_01","UK3CB_CHC_C_U_WOOD_02","UK3CB_CHC_C_U_WOOD_03","UK3CB_TKP_B_U_CombatUniform_TAN","UK3CB_CW_SOV_O_Late_U_Spetsnaz_Uniform_Gorka_01_KLMK","UK3CB_CW_SOV_O_Late_U_VDV_Spetsnaz_Uniform_Gorka_02_KLMK","UK3CB_CW_SOV_O_LATE_U_H_Pilot_Uniform_01_TTSKO","UK3CB_TKA_I_U_CombatUniform_01_OLI","UK3CB_TKA_I_U_CombatUniform_02_OLI","UK3CB_TKA_I_U_CombatUniform_01_TKA_Brush","UK3CB_TKA_I_U_CombatUniform_02_TKA_Brush","UK3CB_TKA_I_U_CombatUniform_03_TKA_Brush","UK3CB_TKP_I_U_QRF_CombatUniform_BLK","UK3CB_CW_SOV_O_Late_U_VDV_CombatUniform_01_TTSKO","UK3CB_CW_SOV_O_Late_U_VDV_CombatUniform_02_TTSKO","UK3CB_CW_SOV_O_Late_U_VDV_CombatUniform_03_TTSKO","UK3CB_CW_SOV_O_LATE_U_VDV_Crew_Uniform_01_TTSKO","UK3CB_CW_US_B_Early_U_SF_CombatUniform_03_ERDL_OLI","UK3CB_CW_US_B_Early_U_SF_CombatUniform_01_ERDL","UK3CB_CW_US_B_Early_U_SF_CombatUniform_04_ERDL_OLI","UK3CB_CW_US_B_Early_U_SF_CombatUniform_02_ERDL","UK3CB_CW_US_B_Early_U_CombatUniform_01_OLI","UK3CB_CW_SOV_O_Early_U_Spetsnaz_Uniform_01_KHK","UK3CB_CW_SOV_O_Early_U_Spetsnaz_Uniform_01_KLMK","UK3CB_CW_SOV_O_Early_U_VDV_Crew_Uniform_01_KLMK","rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain","rhsgref_uniform_para_ttsko_oxblood","rhsgref_uniform_para_ttsko_urban","rhsgref_uniform_vsr","rhsgref_uniform_ttsko_forest","rhsgref_uniform_ttsko_mountain","rhsgref_uniform_ttsko_urban","rhsgref_uniform_altis_lizard","rhsgref_uniform_altis_lizard_olive","rhsgref_uniform_dpm","rhsgref_uniform_dpm_olive","rhsgref_uniform_ERDL","rhsgref_uniform_og107_erdl","rhsgref_uniform_olive","rhsgref_uniform_woodland","rhsgref_uniform_woodland_olive"];

	// VESTS
	OPEX_enemy_commonVests append ["UK3CB_TKA_O_V_6b23_ml_Surpat","UK3CB_TKA_O_V_6b23_ml_sniper_Surpat","UK3CB_TKA_O_V_6b23_ml_Oli_ADPM","UK3CB_TKA_O_V_6b23_ml_Oli_TKA_Brush","UK3CB_TKP_I_V_6Sh92_Blk","UK3CB_TKP_I_V_6Sh92_Khk","UK3CB_TKP_I_V_6Sh92_Des","UK3CB_TKA_I_V_6Sh92_Khk","UK3CB_TKA_I_V_6Sh92_Grey","UK3CB_TKA_I_V_6Sh92_Grey","UK3CB_TKA_I_V_6Sh92_Grey","UK3CB_TKA_I_V_6Sh92_Oli","UK3CB_TKA_I_V_6Sh92_Des","UK3CB_TKA_I_V_6Sh92_TKA_Brush","UK3CB_TKA_B_V_GA_LITE_BLK","UK3CB_TKA_B_V_GA_LITE_DES_MARPAT","UK3CB_ANP_B_V_GA_LITE_TAN","UK3CB_ANP_B_V_GA_LITE_BLK","UK3CB_TKA_B_V_GA_LITE_TAN","UK3CB_TKA_B_V_GA_LITE_WDL","UK3CB_V_Chestrig_TKA_OLI","UK3CB_V_Chestrig_TKA_BRUSH","UK3CB_CW_US_B_LATE_V_PASGT_Crew_Vest","UK3CB_TKA_I_V_vydra_3m_TKA_Brush","UK3CB_TKA_I_V_vydra_3m_Tan","V_BandollierB_blk","rhsgref_6b23_ttsko_forest","rhsgref_6b23_khaki","rhsgref_6b23_khaki_officer"];
	OPEX_enemy_beltVests = ["UK3CB_V_Belt_KHK","UK3CB_V_Belt_Rig_KHK","UK3CB_V_Belt_Rig_Lite_KHK","UK3CB_V_Pouch"];
	OPEX_enemy_grenadierVests = ["UK3CB_TKA_O_V_6b23_ml_6sh92_vog_Oli_ADPM","UK3CB_TKA_O_V_6b23_ml_6sh92_vog_Oli_TKA_Brush","UK3CB_TKA_I_V_6Sh92_vog_Khk","UK3CB_TKA_I_V_6Sh92_vog_Grey","UK3CB_TKA_I_V_6Sh92_vog_Grey","UK3CB_TKA_I_V_6Sh92_vog_Grey","UK3CB_TKA_I_V_6Sh92_vog_Oli","UK3CB_TKA_I_V_6Sh92_vog_Des","UK3CB_TKA_I_V_6Sh92_vog_TKA_Brush","UK3CB_V_Chestrig_Lite_KHK"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["UK3CB_H_Crew_Cap"];
	OPEX_enemy_headgears append ["UK3CB_H_Beanie_01","UK3CB_CW_US_B_EARLY_H_BoonieHat_ERDL_01","UK3CB_CW_US_B_EARLY_H_BoonieHat_ERDL_02","UK3CB_CW_US_B_LATE_H_BoonieHat_WDL_01","UK3CB_CW_US_B_LATE_H_BoonieHat_WDL_02","UK3CB_ANA_B_H_BoonieHat_WDL","UK3CB_TKA_B_H_BoonieHat_WDL","UK3CB_ANA_B_H_Patrolcap_wdl","UK3CB_TKA_O_H_Patrolcap_ADPM","UK3CB_TKA_I_H_Patrolcap_OLI","UK3CB_TKA_B_H_Patrolcap_WDL","UK3CB_CW_US_B_LATE_H_Patrol_Cap_WDL_01","UK3CB_TKA_I_H_Shemag_Des","UK3CB_H_Shemag_blk","UK3CB_H_Shemag_grey","UK3CB_H_Shemag_oli","UK3CB_H_Shemag_tan","UK3CB_H_Shemag_white","UK3CB_TKP_O_H_Patrolcap_Blk","UK3CB_TKP_B_H_Patrolcap_TAN","UK3CB_H_Ushanka_Cap_01","UK3CB_H_Villager_Cap_01","rhsgref_hat_M1951"];
	OPEX_enemy_officerHeadgears = ["UK3CB_H_Civ_Beret","UK3CB_ANA_B_H_Beret_GRN","UK3CB_ANA_B_H_Beret_MAR","UK3CB_H_Beret_Officer"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk","G_Balaclava_oli","UK3CB_G_Neck_Shemag_Oli","UK3CB_G_Neck_Shemag_Tan","UK3CB_G_Neck_Shemag","rhsusf_shemagh2_grn","rhsusf_shemagh2_od","rhsusf_shemagh_tan","rhsusf_shemagh_grn","rhsusf_shemagh_od","rhsusf_shemagh_tan"];
	OPEX_enemy_scarfs = ["G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_tan","UK3CB_G_Face_Wrap_01"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks append ["UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_K","UK3CB_CHC_C_B_HIKER","UK3CB_UN_B_B_RIF","UK3CB_B_Fieldpack","UK3CB_B_Hiker","UK3CB_CW_US_B_LATE_B_RIF_03","UK3CB_CW_SOV_O_LATE_B_Sidor_RIF","UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF","UK3CB_TKA_O_B_RIF_Khk","UK3CB_TKA_O_B_ENG_Khk","UK3CB_TKA_O_B_RIF_Tan","UK3CB_TKA_O_B_ENG_Tan"];