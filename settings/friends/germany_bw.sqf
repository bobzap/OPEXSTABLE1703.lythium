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

	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_common"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_weapons"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_units"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "BW"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Germany"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

// =======================================================================================================================
// PART 3 (DO NOT EDIT OR DELETE these lines !)
// =======================================================================================================================

	// ENABLING FACTION
	waitUntil {!isNil "OPEX_friendly_factions"};
	if (isServer) then {OPEX_friendly_factions append [[_OPEX_friendly_subFaction, _OPEX_friendly_modName]]}; publicVariable "OPEX_friendly_factions";

	// WAITING FOR FACTION SELECTION
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};
	if (!(OPEX_param_friendlyFaction isEqualTo [_OPEX_friendly_subFaction, _OPEX_friendly_modName])) exitWith {};

	// CONFIRMING FACTION NAMES
	OPEX_friendly_modName = _OPEX_friendly_modName;
	OPEX_friendly_factionName = _OPEX_friendly_factionName;
	OPEX_friendly_subFaction = _OPEX_friendly_subFaction;

// =======================================================================================================================
// PART 4 (DO NOT LET ANY VARIABLE UNDEFINED OR EMPTY)
//		- if you don't know what a variable is about, please ask
//		- if you don't need to define a variable, simply delete the line (default content will be used instead)
// =======================================================================================================================

	// ARMY NAME
	OPEX_friendly_army = localize "STR_friendly_army_ger"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Germany"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_germany.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_germany.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Wagner"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_ger.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_generic.paa";
	OPEX_sign_armory = "pictures\sign_armory_generic.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_generic.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_generic.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_generic.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_generic.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_generic.paa";
	OPEX_sign_jail = "pictures\sign_jail_generic.paa";
	OPEX_sign_medical = "pictures\sign_medical_generic.paa";
	OPEX_sign_practice = "pictures\sign_practice_generic.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_generic.paa";
	OPEX_sign_toc = "pictures\sign_toc_generic.paa";
	OPEX_sign_training = "pictures\sign_training_generic.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_generic.paa";
	OPEX_sign_showers = "pictures\sign_showers_generic.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_generic.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_generic.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_de.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_de.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_de.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_de.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_de.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_de.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_de.paa";
	OPEX_tv = "pictures\tv_generic.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_ge.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["german_01", "german_02", "german_03", "german_04", "german_05", "german_06", "german_07", "german_08", "german_09", "german_10", "german_11", "german_12", "german_13", "german_14", "german_15", "german_16", "german_17", "german_18", "german_19", "german_20", "german_21", "german_22", "german_23", "german_24", "german_25", "german_26", "german_27", "german_28", "german_29", "german_30", "german_31", "german_32", "german_33", "german_34", "german_35", "german_36", "german_37", "german_38", "german_39", "german_40", "german_41", "german_42", "german_43", "german_44", "german_45", "german_46", "german_47", "german_48", "german_49", "german_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["B_T_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksOpened_desert = ["B_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksOpened_snow = ["B_T_Truck_01_covered_F"];
	OPEX_friendly_transportTrucksCovered_woodland = ["B_T_Truck_01_transport_F"];
	OPEX_friendly_transportTrucksCovered_desert = ["B_Truck_01_transport_F"];
	OPEX_friendly_transportTrucksCovered_snow = ["B_T_Truck_01_transport_F"];	
	OPEX_friendly_fuelTrucks_woodland = ["B_T_Truck_01_fuel_F"];
	OPEX_friendly_fuelTrucks_desert = ["B_Truck_01_fuel_F"];
	OPEX_friendly_fuelTrucks_snow = ["B_T_Truck_01_fuel_F"];
	OPEX_friendly_logisticTrucks_woodland = ["B_T_Truck_01_box_F"];
	OPEX_friendly_logisticTrucks_desert = ["B_T_Truck_01_box_F"];
	OPEX_friendly_logisticTrucks_snow = ["B_T_Truck_01_box_F"];
	OPEX_friendly_medicalTrucks_woodland = ["B_T_Truck_01_medical_F"];
	OPEX_friendly_medicalTrucks_desert = ["B_Truck_01_medical_F"];
	OPEX_friendly_medicalTrucks_snow = ["B_T_Truck_01_medical_F"];
	OPEX_friendly_repairTrucks_woodland = ["B_T_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_desert = ["B_Truck_01_Repair_F"];
	OPEX_friendly_repairTrucks_snow = ["B_T_Truck_01_Repair_F"];
	OPEX_friendly_ammoTrucks_woodland = ["B_T_Truck_01_ammo_F"];
	OPEX_friendly_ammoTrucks_desert = ["B_Truck_01_ammo_F"];
	OPEX_friendly_ammoTrucks_snow = ["B_T_Truck_01_ammo_F"];	
	OPEX_friendly_transportCars_woodland = ["BWA3_Eagle_Fleck"];
	OPEX_friendly_transportCars_desert = ["BWA3_Eagle_Tropen"];
	OPEX_friendly_transportCars_snow = ["BWA3_Eagle_Fleck"];
	OPEX_friendly_combatCarsMG_woodland = ["BWA3_Eagle_FLW100_Fleck"];
	OPEX_friendly_combatCarsMG_desert = ["BWA3_Eagle_FLW100_Tropen"];
	OPEX_friendly_combatCarsMG_snow = ["BWA3_Eagle_FLW100_Fleck"];
	OPEX_friendly_combatCarsGL_woodland = ["BWA3_Eagle_FLW100_Fleck"];
	OPEX_friendly_combatCarsGL_desert = ["BWA3_Eagle_FLW100_Tropen"];
	OPEX_friendly_combatCarsGL_snow = ["BWA3_Eagle_FLW100_Fleck"];	
	OPEX_friendly_vtt_woodland = ["BWA3_Puma_Fleck"];
	OPEX_friendly_vtt_desert = ["BWA3_Puma_Tropen"];
	OPEX_friendly_vtt_snow = ["BWA3_Puma_Fleck"];
	OPEX_friendly_tanks_woodland = ["BWA3_Leopard2_Fleck"];
	OPEX_friendly_tanks_desert = ["BWA3_Leopard2_Tropen"];
	OPEX_friendly_tanks_snow = ["BWA3_Leopard2_Fleck"];
	OPEX_friendly_quads_woodland = ["B_Quadbike_01_F"];
	OPEX_friendly_quads_desert = ["B_Quadbike_01_F"];
	OPEX_friendly_quads_snow = ["B_Quadbike_01_F"];
	OPEX_friendly_zodiacs = ["B_Boat_Transport_01_F"];
	OPEX_friendly_ships = ["B_Boat_Armed_01_minigun_F"];
	OPEX_friendly_aircrafts = ["B_Plane_CAS_01_dynamicLoadout_F", "B_Plane_Fighter_01_F", "B_Plane_Fighter_01_Stealth_F"];	
	OPEX_friendly_smallCombatHelicopters_woodland = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_smallCombatHelicopters_desert = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_smallCombatHelicopters_snow = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["BWA3_Tiger_Gunpod_FZ","BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS","BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["B_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_desert = ["B_Heli_Light_01_F"];
	OPEX_friendly_smallTransportHelicopters_snow = ["B_Heli_Light_01_F"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["B_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["B_Heli_Transport_01_F"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["B_Heli_Transport_01_F"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_bigTransportHelicopters_desert = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_bigTransportHelicopters_snow = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F"];
	OPEX_friendly_UAVs = ["B_UAV_02_dynamicLoadout_F"];
	OPEX_friendly_UGVs = ["B_UGV_01_F", "B_UGV_01_rcws_olive_F"];
	OPEX_friendly_portableDrones = ["B_UAV_01_F"];
	OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
	OPEX_friendly_MGstatics = ["B_HMG_01_high_F"];
	OPEX_friendly_GLstatics = ["B_GMG_01_high_F"];
	OPEX_friendly_ATstatics = ["B_Static_AT_F"];
	OPEX_friendly_AAstatics = ["B_Static_AA_F"];
	OPEX_friendly_mortarStatics = ["B_Mortar_01_F"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["BWA3_P8"];
	OPEX_friendly_specialHandguns = ["BWA3_MP7"];
	OPEX_friendly_commonRifles = ["BWA3_G36A1","BWA3_G36A1","BWA3_G36A2"];
	OPEX_friendly_specialRifles = ["BWA3_G36A3","BWA3_G36KA0","BWA3_G36KA1","BWA3_G36KA2","BWA3_G36KA3","BWA3_G36KA4","BWA3_G38","BWA3_G38C","BWA3_G38K","BWA3_G27"];
	OPEX_friendly_GLrifles = ["BWA3_G36A1_AG40","BWA3_G36A1_AG40","BWA3_G36A1_AG40","BWA3_G36A2_AG40","BWA3_G36A3_AG40","BWA3_G38_AG40","BWA3_G38K_AG40","BWA3_G27_AG40"];
	OPEX_friendly_MGriflesLight = ["BWA3_MG4","BWA3_MG5"];
	OPEX_friendly_MGriflesHeavy = ["BWA3_MG3"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["BWA3_G27"];
	OPEX_friendly_precisionRifles = ["BWA3_G29"];
	OPEX_friendly_sniperRifles = ["BWA3_G82"];
	OPEX_friendly_ATlaunchers = ["BWA3_Bunkerfaust","BWA3_CarlGustav","BWA3_PzF3","BWA3_RGW90"];
	OPEX_friendly_AAlaunchers = ["BWA3_Fliegerfaust"];
	OPEX_friendly_shotguns = ["BWA3_G27"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["BWA3_optic_CompM2","BWA3_optic_MicroT1","BWA3_optic_MicroT2","BWA3_optic_EOTech552","BWA3_optic_EOTech","BWA3_optic_RSAS"];
	OPEX_friendly_distantCombatOptics append ["BWA3_optic_NSA80","BWA3_optic_EOTech_Mag_Off","BWA3_optic_ZO4x30","BWA3_optic_ZO4x30_MicroT2","BWA3_optic_ZO4x30_RSAS","BWA3_optic_ZO4x30i","BWA3_optic_ZO4x30i_MicroT2","BWA3_optic_ZO4x30i_RSAS"];
	OPEX_friendly_sniperOptics append ["BWA3_optic_PMII_ShortdotCC","BWA3_optic_PMII_DMR","BWA3_optic_PMII_DMR_MicroT1_front","BWA3_optic_PMII_DMR_MicroT1_rear","BWA3_optic_M5Xi_MSR","BWA3_optic_M5Xi_MSR_MicroT2","BWA3_optic_M5Xi_Tremor3","BWA3_optic_M5Xi_Tremor3_MicroT2","BWA3_optic_Hensoldt"];
	OPEX_friendly_rifleSilencers append ["BWA3_muzzle_snds_Rotex_IIA","BWA3_muzzle_snds_QDSS","BWA3_muzzle_snds_Rotex_IIIC","BWA3_muzzle_snds_Rotex_Monoblock"];
	OPEX_friendly_handgunSilencers append ["BWA3_muzzle_snds_Rotex_II"];
	OPEX_friendly_pointers append ["BWA3_acc_VarioRay_irlaser_black","BWA3_acc_LLM01_irlaser","BWA3_acc_LLM01_irlaser_underbarrel"];
	OPEX_friendly_bipods append ["BWA3_bipod_Harris","BWA3_bipod_Atlas","BWA3_bipod_MG3"];

	// VARIOUS ITEMS
	OPEX_medical_commonSupplies append ["BWA3_ItemNaviPad"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["BWA3_Uniform2_Fleck","BWA3_Uniform2_sleeves_Fleck"];
	OPEX_friendly_commonUniforms_desert = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_commonUniforms_snow = ["BWA3_Uniform2_Multi","BWA3_Uniform2_sleeves_Multi"];
	OPEX_friendly_specialUniforms_woodland = ["BWA3_Uniform_Fleck","BWA3_Uniform_sleeves_Fleck"];
	OPEX_friendly_specialUniforms_desert = ["BWA3_Uniform_Tropen","BWA3_Uniform_sleeves_Tropen"];
	OPEX_friendly_specialUniforms_snow = ["BWA3_Uniform_Multi","BWA3_Uniform_sleeves_Multi"];
	OPEX_friendly_ghillieUniforms_woodland = ["BWA3_Uniform2_Ghillie_Fleck","BWA3_Uniform_Ghillie_Fleck"];
	OPEX_friendly_ghillieUniforms_desert = ["BWA3_Uniform2_Ghillie_Tropen","BWA3_Uniform_Ghillie_Tropen"];
	OPEX_friendly_ghillieUniforms_snow = ["BWA3_Uniform2_Ghillie_Multi","BWA3_Uniform_Ghillie_Multi"];
	OPEX_friendly_heliPilotUniforms_woodland = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_heliPilotUniforms_desert = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_heliPilotUniforms_snow = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_tankPilotUniforms_woodland = ["BWA3_Uniform_Crew_Fleck"];
	OPEX_friendly_tankPilotUniforms_desert = ["BWA3_Uniform_Crew_Tropen"];
	OPEX_friendly_tankPilotUniforms_snow = ["BWA3_Uniform_Crew_Multi"];
	OPEX_friendly_medicUniforms_woodland = ["BWA3_Uniform2_Fleck"];
	OPEX_friendly_medicUniforms_desert = ["BWA3_Uniform2_Tropen"];
	OPEX_friendly_medicUniforms_snow = ["BWA3_Uniform2_Multi"];
	OPEX_friendly_instructorUniforms_woodland = ["BWA3_Uniform2_Fleck"];
	OPEX_friendly_instructorUniforms_desert = ["BWA3_Uniform2_Tropen"];
	OPEX_friendly_instructorUniforms_snow = ["BWA3_Uniform2_Multi"];
	OPEX_friendly_tshirtUniforms_woodland = ["BWA3_Uniform_tee_Fleck"];
	OPEX_friendly_tshirtUniforms_desert = ["BWA3_Uniform_tee_Tropen"];
	OPEX_friendly_tshirtUniforms_snow = ["BWA3_Uniform_sleeves_Multi"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["BWA3_Vest_JPC_Rifleman_Fleck"];
	OPEX_friendly_commonVests_desert = ["BWA3_Vest_Rifleman_Tropen"];
	OPEX_friendly_commonVests_snow = ["BWA3_Vest_JPC_Rifleman_Multi"];
	OPEX_friendly_specialVests_woodland = ["BWA3_Vest_JPC_Leader_Fleck","BWA3_Vest_JPC_Radioman_Fleck","BWA3_Vest_Leader_Fleck","BWA3_Vest_MachineGunner_Fleck","BWA3_Vest_Marksman_Fleck","BWA3_Vest_Rifleman_Fleck"];
	OPEX_friendly_specialVests_desert = ["BWA3_Vest_JPC_Leader_Tropen","BWA3_Vest_JPC_Radioman_Tropen","BWA3_Vest_Leader_Tropen","BWA3_Vest_MachineGunner_Tropen","BWA3_Vest_Marksman_Tropen","BWA3_Vest_Rifleman_Tropen"];
	OPEX_friendly_specialVests_snow = ["BWA3_Vest_JPC_Leader_Multi","BWA3_Vest_JPC_Radioman_Multi","BWA3_Vest_Leader_Multi","BWA3_Vest_MachineGunner_Multi","BWA3_Vest_Marksman_Multi","BWA3_Vest_Rifleman_Multi"];
	OPEX_friendly_medicVests_woodland = ["BWA3_Vest_Medic_Fleck"];
	OPEX_friendly_medicVests_desert = ["BWA3_Vest_Medic_Tropen"];
	OPEX_friendly_medicVests_snow = ["BWA3_Vest_Medic_Multi"];
	OPEX_friendly_lightVests_woodland = ["BWA3_Vest_Fleck"];
	OPEX_friendly_lightVests_desert = ["BWA3_Vest_Tropen"];
	OPEX_friendly_lightVests_snow = ["BWA3_Vest_Multi"];
	OPEX_friendly_grenadierVests_woodland = ["BWA3_Vest_Grenadier_Fleck"];
	OPEX_friendly_grenadierVests_desert = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_grenadierVests_snow = ["BWA3_Vest_Grenadier_Multi"];
	OPEX_friendly_EODvests_woodland = ["BWA3_Vest_Grenadier_Fleck"];
	OPEX_friendly_EODvests_desert = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_EODvests_snow = ["BWA3_Vest_Grenadier_Multi"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["BWA3_M92_Fleck"];
	OPEX_friendly_commonHelmets_desert = ["BWA3_M92_Tropen"];
	OPEX_friendly_commonHelmets_snow = ["BWA3_M92_Multi"];
	OPEX_friendly_specialHelmets_woodland = ["BWA3_CrewmanKSK","BWA3_CrewmanKSK_Headset","BWA3_CrewmanKSK_Fleck","BWA3_CrewmanKSK_Fleck_Headset","BWA3_OpsCore","BWA3_OpsCore_Camera","BWA3_OpsCore_Fleck","BWA3_OpsCore_Fleck_Camera","BWA3_OpsCore_Fleck_Patch"];
	OPEX_friendly_specialHelmets_desert = ["BWA3_CrewmanKSK","BWA3_CrewmanKSK_Headset","BWA3_CrewmanKSK_Tropen","BWA3_CrewmanKSK_Tropen_Headset","BWA3_OpsCore","BWA3_OpsCore_Camera","BWA3_OpsCore_Tropen","BWA3_OpsCore_Tropen_Camera","BWA3_OpsCore_Tropen_Patch"];
	OPEX_friendly_specialHelmets_snow = ["BWA3_CrewmanKSK","BWA3_CrewmanKSK_Headset","BWA3_CrewmanKSK_Fleck","BWA3_CrewmanKSK_Fleck_Headset","BWA3_OpsCore","BWA3_OpsCore_Camera","BWA3_OpsCore_Fleck","BWA3_OpsCore_Fleck_Camera","BWA3_OpsCore_Fleck_Patch"];
	OPEX_friendly_EODhelmets_woodland = ["BWA3_M92_Fleck"];
	OPEX_friendly_EODhelmets_desert = ["BWA3_M92_Tropen"];
	OPEX_friendly_EODhelmets_snow = ["BWA3_M92_Multi"];
	OPEX_friendly_heliPilotHelmets = ["BWA3_Knighthelm"];
	OPEX_friendly_aircraftPilotHelmets = ["BWA3_Knighthelm"];
	OPEX_friendly_tankCrewHelmets = ["BWA3_CrewmanKSK_Headset"];
	OPEX_friendly_cameraHelmets_woodland append ["BWA3_OpsCore_Camera","BWA3_OpsCore_Fleck_Camera"];
	OPEX_friendly_cameraHelmets_desert append ["BWA3_OpsCore_Camera","BWA3_OpsCore_Tropen_Camera"];
	OPEX_friendly_cameraHelmets_snow append ["BWA3_OpsCore_Camera","BWA3_OpsCore_Fleck_Camera"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["BWA3_Booniehat_Fleck"];
	OPEX_friendly_hats_desert = ["BWA3_Booniehat_Tropen"];
	OPEX_friendly_hats_snow = ["BWA3_Booniehat_Multi"];
	OPEX_friendly_leaderHeadgear_woodland = ["BWA3_Beret_Falli","BWA3_Beret_HFlieger","BWA3_Beret_Jaeger","BWA3_Beret_PzAufkl","BWA3_Beret_PzGren","BWA3_Beret_Pz","BWA3_Beret_Wach_blue","BWA3_Beret_Wach_green"];
	OPEX_friendly_leaderHeadgear_desert = ["BWA3_Beret_Falli","BWA3_Beret_HFlieger","BWA3_Beret_Jaeger","BWA3_Beret_PzAufkl","BWA3_Beret_PzGren","BWA3_Beret_Pz","BWA3_Beret_Wach_blue","BWA3_Beret_Wach_green"];
	OPEX_friendly_leaderHeadgear_snow = ["BWA3_Beret_Falli","BWA3_Beret_HFlieger","BWA3_Beret_Jaeger","BWA3_Beret_PzAufkl","BWA3_Beret_PzGren","BWA3_Beret_Pz","BWA3_Beret_Wach_blue","BWA3_Beret_Wach_green"];
	OPEX_friendly_berets = ["BWA3_Beret_Falli","BWA3_Beret_HFlieger","BWA3_Beret_Jaeger","BWA3_Beret_PzAufkl","BWA3_Beret_PzGren","BWA3_Beret_Pz","BWA3_Beret_Wach_blue","BWA3_Beret_Wach_green"];

	// FACEGEAR
	OPEX_friendly_glasses append ["BWA3_G_Combat_clear","BWA3_G_Combat_clear","BWA3_G_Combat_clear"];
	OPEX_friendly_sunglasses append ["BWA3_G_Combat_clear","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_orange","BWA3_G_Combat_orange","BWA3_G_Combat_orange"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["BWA3_AssaultPack_Fleck","BWA3_FieldPack_Fleck","BWA3_Kitbag_Fleck","BWA3_TacticalPack_Fleck"];
	OPEX_friendly_mediumBackpacks_desert = ["BWA3_AssaultPack_Tropen","BWA3_FieldPack_Tropen","BWA3_Kitbag_Tropen","BWA3_TacticalPack_Tropen"];
	OPEX_friendly_mediumBackpacks_snow = ["BWA3_AssaultPack_Multi","BWA3_FieldPack_Multi","BWA3_Kitbag_Multi","BWA3_TacticalPack_Multi"];
	OPEX_friendly_bigBackpacks_woodland = ["BWA3_Carryall_Fleck","BWA3_PatrolPack_Fleck"];
	OPEX_friendly_bigBackpacks_desert = ["BWA3_Carryall_Tropen","BWA3_PatrolPack_Tropen"];
	OPEX_friendly_bigBackpacks_snow = ["BWA3_Carryall_Multi","BWA3_PatrolPack_Multi"];
	OPEX_friendly_medicBackpacks_woodland = ["BWA3_AssaultPack_Fleck_Medic","BWA3_Kitbag_Fleck_Medic","BWA3_TacticalPack_Fleck_Medic"];
	OPEX_friendly_medicBackpacks_desert = ["BWA3_AssaultPack_Tropen_Medic","BWA3_Kitbag_Tropen_Medic","BWA3_TacticalPack_Tropen_Medic"];
	OPEX_friendly_medicBackpacks_snow = ["BWA3_AssaultPack_Multi_Medic","BWA3_Kitbag_Multi_Medic","BWA3_TacticalPack_Multi_Medic"];