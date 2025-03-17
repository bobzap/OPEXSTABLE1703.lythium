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
	OPEX_enemy_rifleman = "LOP_IRA_Infantry_Rifleman";
	OPEX_enemy_teamLeader = "LOP_IRA_Infantry_TL";
	OPEX_enemy_grenadier = "LOP_IRA_Infantry_GL";
	OPEX_enemy_MG = "LOP_IRA_Infantry_AR";
	OPEX_enemy_AT = "LOP_IRA_Infantry_AT";
	OPEX_enemy_AA = "LOP_IRA_Infantry_Corpsman";
	OPEX_enemy_marksman = "LOP_IRA_Infantry_Marksman";
	OPEX_enemy_crewman = "LOP_IRA_Infantry_Driver";
	OPEX_enemy_commonUnits = [OPEX_enemy_rifleman];
	OPEX_enemy_specialUnits = [OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_AT, OPEX_enemy_AA, OPEX_enemy_marksman];
	OPEX_enemy_units = OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits;

	// VEHICLES
	OPEX_enemy_transportTrucks = ["I_G_VAN_01_transport_F", "O_G_VAN_01_transport_F", "C_Van_01_transport_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F", "LOP_ChDKZ_Ural", "LOP_ChDKZ_Ural_open"];
	OPEX_enemy_fuelTrucks = ["I_G_VAN_01_fuel_F", "O_G_VAN_01_fuel_F", "C_VAN_01_fuel_F", "C_truck_02_fuel_F"];
	OPEX_enemy_transportCars = ["I_G_Offroad_01_F", "O_G_Offroad_01_F", "C_Offroad_01_F", "LOP_ChDKZ_UAZ", "LOP_ChDKZ_UAZ_Open"];
	OPEX_enemy_combatCars = ["I_G_Offroad_01_armed_F", "O_G_Offroad_01_armed_F", "LOP_ChDKZ_UAZ_AGS", "LOP_ChDKZ_UAZ_DshKM", "LOP_ChDKZ_UAZ_SPG"];
	OPEX_enemy_motorizedVehicles = OPEX_enemy_transportTrucks + OPEX_enemy_transportCars + OPEX_enemy_combatCars;
	OPEX_enemy_zodiacs = ["I_G_Boat_Transport_01_F", "O_G_Boat_Transport_01_F"];
	OPEX_enemy_ships = ["C_Boat_Civil_01_F"];
	OPEX_enemy_armored = ["LOP_ChDKZ_BMP1", "LOP_ChDKZ_BMP1D", "LOP_ChDKZ_BMP2", "LOP_ChDKZ_BMP2D", "LOP_ChDKZ_BTR60", "LOP_ChDKZ_BTR70", "LOP_ChDKZ_T72BA", "LOP_ChDKZ_T72BB", "LOP_ChDKZ_T72BC"];
	OPEX_enemy_MGstatics = ["LOP_ChDKZ_Static_DSHKM", "LOP_ChDKZ_Kord_High"];
	OPEX_enemy_GLstatics = ["I_GMG_01_high_F"];
	OPEX_enemy_ATstatics = ["LOP_ChDKZ_Static_SPG9"];
	OPEX_enemy_AAstatics = ["LOP_ChDKZ_Igla_AA_pod"];
	OPEX_enemy_mortarStatics = ["I_G_Mortar_01_F"];
	OPEX_enemy_artilleryBatteries = ["LOP_SLA_Static_D30"];
	OPEX_enemy_AAbatteries = ["LOP_ChDKZ_ZU23"];
	OPEX_enemy_statics = OPEX_enemy_MGstatics + OPEX_enemy_GLstatics + OPEX_enemy_ATstatics + OPEX_enemy_AAstatics + OPEX_enemy_mortarStatics;

	// WEAPONS
	OPEX_enemy_commonHandguns = ["rhs_weap_makarov_pm"];
	OPEX_enemy_specialHandguns = ["hgun_Rook40_F"];
	OPEX_enemy_commonRifles = ["rhs_weap_ak74"];
	OPEX_enemy_specialRifles = ["LOP_Weap_LeeEnfield_railed", "rhs_weap_ak74m", "rhs_weap_ak103", "rhs_weap_ak105", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74"];
	OPEX_enemy_GLrifles = ["rhs_weap_ak74_gp25", "rhs_weap_akmn_gp25"];
	OPEX_enemy_MGrifles = ["rhs_weap_pkm", "rhs_weap_pkp"];
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
	OPEX_enemy_commonUniforms = ["LOP_U_US_Fatigue_13", "LOP_U_US_Fatigue_14", "LOP_U_IRA_Fatigue_GRK_BLK", "LOP_U_IRA_Fatigue_GRK_BLUE", "LOP_U_IRA_Fatigue_GRK_DPM", "LOP_U_IRA_Fatigue_GRK_OLV", "LOP_U_BH_Fatigue_FWDL", "LOP_U_BH_Fatigue_FWDL_TRI", "LOP_U_BH_Fatigue_FWDL_CHOCO", "LOP_U_BH_Fatigue_FWDL_ACU", "LOP_U_BH_Fatigue_FWDL_LIZ", "LOP_U_BH_Fatigue_FWDL_M81", "LOP_U_BH_Fatigue_GUE_FWDL", "LOP_U_BH_Fatigue_GUE_M81_OLV", "LOP_U_BH_Fatigue_M81_FWDL", "LOP_U_ChDKZ_Fatigue_01", "LOP_U_ChDKZ_Fatigue_02", "LOP_U_ChDKZ_Fatigue_03", "LOP_U_ChDKZ_Fatigue_04", "LOP_U_IRA_Fatigue_DPM_GNSW", "LOP_U_IRA_Fatigue_DPM", "LOP_U_IRA_Fatigue_DPM_BSW", "LOP_U_IRA_Fatigue_DPM_GSW", "LOP_U_IRA_Fatigue_DPM_TSW", "LOP_U_IRA_Fatigue_HTR_DPM", "LOP_U_IRA_Fatigue_HTR_DPM_J", "LOP_U_ISTS_Fatigue_18", "LOP_U_ISTS_Fatigue_28", "LOP_U_ISTS_Fatigue_26", "LOP_U_ISTS_Fatigue_20", "LOP_U_ISTS_Fatigue_21", "LOP_U_ISTS_Fatigue_19", "LOP_U_ISTS_Fatigue_16", "LOP_U_ISTS_Fatigue_17", "LOP_U_ISTS_Fatigue_08", "LOP_U_NAPA_Fatigue_01", "LOP_U_NAPA_Fatigue_02", "LOP_U_NAPA_Fatigue_04", "LOP_U_UA_Fatigue_01", "LOP_U_UA_Fatigue_02", "LOP_U_UA_Fatigue_03", "LOP_U_UA_Fatigue_04", "LOP_U_AFR_Fatigue_04", "LOP_U_AFR_Fatigue_04_slv", "LOP_U_UVF_Fatigue_BL_OSW", "LOP_U_UVF_Fatigue_COY_OSW", "LOP_U_UVF_Fatigue_GREY_GSW", "LOP_U_US_Fatigue_06", "LOP_U_US_Fatigue_07", "LOP_U_US_Fatigue_12", "LOP_U_US_Fatigue_09", "LOP_U_US_Fatigue_08", "LOP_U_TKA_Fatigue_02", "LOP_U_US_Fatigue_03", "LOP_U_US_Fatigue_10", "U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1", "U_BG_leader", "U_I_C_Soldier_Camo_F", "U_BG_Guerilla2_3", "U_BG_Guerilla2_1", "U_I_C_Soldier_Para_3_F", "U_I_C_Soldier_Para_2_F"];

	// VESTS
	OPEX_enemy_commonVests = ["LOP_V_6B23_M81", "LOP_V_6B23_OLV", "LOP_V_6B23_TTKO", "LOP_V_6Sh92_OLV", "LOP_V_6Sh92_WDL", "LOP_V_CarrierLite_ANA", "LOP_V_CarrierLite_BLK", "LOP_V_CarrierLite_OLV", "LOP_V_CarrierLite_WDL", "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_TacChestrig_cbr_F", "V_TacChestrig_oli_F", "V_TacChestrig_grn_F", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_brn", "V_TacVest_blk", "V_TacVest_oli", "V_I_G_resistanceLeader_F"];
	OPEX_enemy_beltVests = ["V_Rangemaster_belt"];
	OPEX_enemy_grenadierVests = ["V_HarnessOGL_brn", "V_HarnessOGL_gry"];

	// HEADGEAR
	OPEX_enemy_tankCrewHelmets = ["H_HelmetCrew_I"];
	OPEX_enemy_headgears = ["LOP_H_Beanie_dpmw", "LOP_H_Beanie_m81", "LOP_H_Villager_cap", "H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Bandanna_gry", "H_Bandanna_sand", "H_Bandanna_sgg", "H_Bandanna_camo", "LOP_H_6B27M_BLK", "LOP_H_6B27M_CDF", "LOP_H_6B27M_ess_CDF", "LOP_H_6B27M_Flora", "LOP_H_6B27M_ess_Flora", "LOP_H_6B27M_WDL", "LOP_H_6B27M_ess_WDL", "LOP_H_6B27M_wz93", "LOP_H_6B27M_ess_wz93", "H_Cap_tan", "H_Cap_blk", "H_Cap_oli", "H_Cap_grn", "H_Cap_red", "H_Hat_camo", "H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_tna_F"];
	OPEX_enemy_officerHeadgears = ["LOP_H_Beret_Pesh", "LOP_H_SLA_Beret", "LOP_H_ChDKZ_Beret", "LOP_H_Fieldcap_CDF", "LOP_H_Fieldcap_UKR"];


	// FACEGEAR
	OPEX_enemy_balaclavas = ["G_Balaclava_blk", "G_Balaclava_oli"];
	OPEX_enemy_scarfs = ["G_Bandanna_tan", "G_Bandanna_khk", "G_Bandanna_blk", "G_Bandanna_oli"];
	OPEX_enemy_glasses = ["G_Spectacles","G_Squares"];
	OPEX_enemy_sunglasses = ["G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue","G_Lowprofile","G_Spectacles_Tinted","G_Aviator","G_Aviator","G_Bandanna_aviator","G_Bandanna_aviator","G_Bandanna_aviator"];

	// BACKPACKS
	OPEX_enemy_commonBackpacks = ["B_FieldPack_cbr", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_blk", "B_FieldPack_khk", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Carryall_khk", "B_Carryall_ocamo", "B_TacticalPack_ocamo", "B_TacticalPack_mcamo", "B_TacticalPack_blk", "B_TacticalPack_oli", "B_TacticalPack_rgr"];