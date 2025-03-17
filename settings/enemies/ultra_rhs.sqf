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

	if (!(isClass (configFile >> "CfgPatches" >> "rhsgref_main"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	_OPEX_enemy_modName = "RHS"; // mod name (example: "myCustomMod")
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
	//OPEX_enemy_names = ["Dimitri Podolski", "Josef Sukolin", "Alexander Pavlov", "Yuri Medvedev", "Michail Takochev", "Andreï Takarov", "Ivan Ramichenko", "Dimitri Letchkov", "Sergeï Kolarov", "Piotr Diakonov", "Andreas Volavetti", "Andrea Pessotto", "Gianluigi Perotta", "Zvoran Savicević", "Stefan Malaković", "Niko Stavić", "Zvonimir Brnović", "Ivan Djoković", "Novak Djordjević", "Pedrag Halilhodžić", "Miroslav Brožović", "Miralem Popescu", "Gheorghe Perišić", "Stavros Papadopulos", "Nikos Ariarankis", "Georgios Solaris", "Nikola Konstandinos", "Adonis Rastapopoulos", "Lars König", "Stefan Braüser", "Oliver Kimmich", "Thomas Matthäus", "Karl-Heinz Müller", "Friedrich Ziegler", "Hanz Möller", "Peter Hassler", "Phillip Wagner", "Stefan Werner", "Jakob van Kerkoven", "Ruben Depay", "Jeff van Houten", "Joshua de Ligt", "Markus de Boer"]; // names used by the AI

	// UNITS
	OPEX_enemy_rifleman = "rhsgref_ins_rifleman";
	OPEX_enemy_teamLeader = "rhsgref_ins_squadleader";
	OPEX_enemy_grenadier = "rhsgref_ins_grenadier";
	OPEX_enemy_MG = "rhsgref_ins_machinegunner";
	OPEX_enemy_AT = "rhsgref_ins_grenadier_rpg";
	OPEX_enemy_AA = "rhsgref_ins_specialist_aa";
	OPEX_enemy_marksman = "rhsgref_ins_sniper";
	OPEX_enemy_crewman = "rhsgref_ins_crew";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman, OPEX_enemy_rifleman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman]; // don't delete this line if you have defined any of these variables
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits; // don't delete this line if you have defined any of these variables

	// VEHICLES
	OPEX_enemy_transportTrucks = ["rhsgref_ins_gaz66","rhsgref_ins_gaz66o","rhsgref_ins_ural","rhsgref_ins_ural_open","rhsgref_ins_ural_work","rhsgref_ins_ural_work_open","rhsgref_ins_zil131","rhsgref_ins_zil131_open"];
	OPEX_enemy_transportCars append ["rhsgref_ins_uaz","rhsgref_ins_uaz_open"];
	OPEX_enemy_combatCars append ["rhsgref_ins_uaz_dshkm"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars; // don't delete this line if you have defined any of these variables
	OPEX_enemy_armored = ["rhsgref_ins_btr60","rhsgref_ins_btr70","rhsgref_ins_bmd2","rhsgref_ins_bmp1p","rhsgref_ins_bmp2e","rhsgref_ins_bmp2","rhsgref_ins_bmp2d","rhsgref_ins_bmp2k","rhsgref_BRDM2_ins","rhsgref_BRDM2UM_ins","rhsgref_BRDM2_HQ_ins","rhsgref_ins_t72ba","rhsgref_ins_t72bb","rhsgref_ins_t72bc"];
	OPEX_enemy_MGstatics = ["rhsgref_ins_DSHKM"];
	OPEX_enemy_GLstatics = ["rhsgref_ins_AGS30_TriPod"];
	OPEX_enemy_ATstatics = ["rhsgref_ins_SPG9M","rhsgref_ins_SPG9"];
	OPEX_enemy_AAstatics = ["rhsgref_ins_Igla_AA_pod"];
	OPEX_enemy_AAbatteries = ["rhsgref_ins_ZU23"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics; // don't delete this line if you have defined any of these variables

	// WEAPONS
	OPEX_enemy_commonHandguns = ["rhs_weap_tt33"];
	OPEX_enemy_specialHandguns = ["rhs_weap_savz61_folded"];
	OPEX_enemy_commonRifles = ["rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74","rhs_weap_ak74n","rhs_weap_akm","rhs_weap_akmn","rhs_weap_ak74m_fullplum","rhs_weap_ak104","rhs_weap_ak105","rhs_weap_kar98k","rhs_weap_m1garand_sa43","rhs_weap_savz58p_black","rhs_weap_savz58p","rhs_weap_savz58v","rhs_weap_savz58v_black"];
	OPEX_enemy_specialRifles = ["rhs_weap_ak74m","rhs_weap_ak74n_npz","rhs_weap_ak74n_2","rhs_weap_ak74n_2_npz","rhs_weap_aks74","rhs_weap_aks74n","rhs_weap_m4a1_carryhandle","rhs_weap_m4","rhs_weap_ak74mr","rhs_weap_savz58p_rail","rhs_weap_savz58p_rail_black","rhs_weap_savz58v_rail","rhs_weap_savz58v_rail_black"];
	OPEX_enemy_GLrifles = ["rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74_gp25","rhs_weap_ak74m_gp25","rhs_weap_ak74n_gp25"];
	OPEX_enemy_MGrifles = ["rhs_weap_pkm","rhs_weap_pkp"];
	OPEX_enemy_precisionRifles = ["rhs_weap_svds","rhs_weap_svds_npz","rhs_weap_svdp","rhs_weap_svdp_npz","rhs_weap_m38_rail"];
	OPEX_enemy_sniperRifles = ["rhs_weap_t5000"];
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
	OPEX_enemy_commonUniforms = ["U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain","rhsgref_uniform_para_ttsko_oxblood","rhsgref_uniform_para_ttsko_urban","rhsgref_uniform_vsr","rhsgref_uniform_ttsko_forest","rhsgref_uniform_ttsko_mountain","rhsgref_uniform_ttsko_urban","rhsgref_uniform_altis_lizard","rhsgref_uniform_altis_lizard_olive","rhsgref_uniform_dpm","rhsgref_uniform_dpm_olive","rhsgref_uniform_ERDL","rhsgref_uniform_og107","rhsgref_uniform_og107_erdl","rhsgref_uniform_olive","rhsgref_uniform_woodland","rhsgref_uniform_woodland_olive"];

	// VESTS
	OPEX_enemy_commonVests append ["rhsgref_6b23_khaki_nco","rhsgref_6b23_khaki_officer","rhsgref_6b23_khaki_rifleman","rhsgref_6b23_khaki_sniper","rhsgref_6b23_khaki","rhsgref_6b23_ttsko_forest_rifleman","rhsgref_6b23_ttsko_forest","rhsgref_6b23_ttsko_mountain_nco","rhsgref_6b23_ttsko_mountain_officer","rhsgref_6b23_ttsko_mountain_rifleman","rhsgref_6b23_ttsko_mountain_sniper","rhsgref_6b23_ttsko_mountain","rhs_6b5_khaki","rhs_6b5_rifleman_khaki","rhs_6b5_officer_khaki","rhs_6b5_sniper_khaki","rhs_6b5","rhs_6b5_rifleman","rhs_6b5_officer","rhs_6b5_sniper","rhs_6b5_ttsko","rhs_6b5_rifleman_ttsko","rhs_6b5_officer_ttsko","rhs_6b5_sniper_ttsko","rhs_6b5_vsr","rhs_6b5_rifleman_vsr","rhs_6b5_officer_vsr","rhs_6b5_sniper_vsr","rhsgref_otv_digi","rhsgref_otv_digi","rhsgref_otv_digi","rhsgref_otv_khaki","rhsgref_otv_khaki","rhsgref_otv_khaki","rhsgref_otv_khaki","rhsgref_otv_khaki","rhsgref_TacVest_ERDL","rhsgref_TacVest_ERDL","rhsgref_TacVest_ERDL"];
	OPEX_enemy_beltVests = ["rhs_vest_commander","rhs_vest_pistol_holster"];
	OPEX_enemy_grenadierVests append ["rhsgref_uniform_woodland_olive","rhsgref_chicom"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["rhs_tsh4"];
	OPEX_enemy_headgears append ["rhs_beanie_green","rhs_beanie_green","rhs_beanie_green","rhs_beanie_green","rhs_beanie_green","rhs_beanie","rhs_Booniehat_flora","rhs_Booniehat_flora","rhs_Booniehat_flora"];
	OPEX_enemy_officerHeadgears append ["rhsgref_fieldcap_ttsko_forest","rhsgref_fieldcap_ttsko_mountain","rhsgref_fieldcap_ttsko_urban","rhsgref_hat_M1951"];

	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk","G_Balaclava_oli"];
	OPEX_enemy_scarfs append ["rhs_scarf","rhsusf_shemagh_grn","rhsusf_shemagh2_grn","rhsusf_shemagh_od","rhsusf_shemagh2_od","rhsusf_shemagh_tan","rhsusf_shemagh2_tan"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks append ["rhsgref_hidf_alicepack","rhsgref_ttsko_alicepack","rhsgref_wdl_alicepack","rhs_sidor","rhs_sidor","rhs_assault_umbts","rhs_assault_umbts","rhs_assault_umbts_engineer_empty","rhs_assault_umbts_engineer_empty"];