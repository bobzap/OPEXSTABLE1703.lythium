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

	if (!(isClass (configFile >> "CfgPatches" >> "ffaa_data"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "ffaa_armas"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "ffaa_unidades"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "ffaa_equipamiento"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "ffaa_estatico"))) exitWith {};

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "FFAA"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Spain"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

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
	OPEX_friendly_army = localize "STR_friendly_army_es"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Spain"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_spain.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_spain.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = ""; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Libertad"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_es.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_es.paa";
	OPEX_sign_armory = "pictures\sign_armory_es.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_es.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_es.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_es.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_es.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_es.paa";
	OPEX_sign_jail = "pictures\sign_jail_es.paa";
	OPEX_sign_medical = "pictures\sign_medical_es.paa";
	OPEX_sign_practice = "pictures\sign_practice_es.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_es.paa";
	OPEX_sign_toc = "pictures\sign_toc_es.paa";
	OPEX_sign_training = "pictures\sign_training_es.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_es.paa";
	OPEX_sign_showers = "pictures\sign_showers_es.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_es.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_es.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_es.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_es.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_es.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_es.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_es.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_es.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_es.paa";
	OPEX_tv = "pictures\tv_es.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_es.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_es.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["spanish_01", "spanish_02", "spanish_03", "spanish_04", "spanish_05", "spanish_06", "spanish_07", "spanish_08", "spanish_09", "spanish_10", "spanish_11", "spanish_12", "spanish_13", "spanish_14", "spanish_15", "spanish_16", "spanish_17", "spanish_18", "spanish_19", "spanish_20", "spanish_21", "spanish_22", "spanish_23", "spanish_24", "spanish_25", "spanish_26", "spanish_27", "spanish_28", "spanish_29", "spanish_30", "spanish_31", "spanish_32", "spanish_33", "spanish_34", "spanish_35", "spanish_36", "spanish_37", "spanish_38", "spanish_39", "spanish_40", "spanish_41", "spanish_42", "spanish_43", "spanish_44", "spanish_45", "spanish_46", "spanish_47", "spanish_48", "spanish_49", "spanish_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["ffaa_et_m250_carga_blin","ffaa_et_pegaso_carga"];
	OPEX_friendly_transportTrucksOpened_desert = ["ffaa_et_m250_carga_blin","ffaa_et_pegaso_carga"];
	OPEX_friendly_transportTrucksOpened_snow = ["ffaa_et_m250_carga_blin","ffaa_et_pegaso_carga"];
	OPEX_friendly_transportTrucksCovered_woodland = ["ffaa_et_m250_carga_lona_blin","ffaa_et_pegaso_carga_lona"];
	OPEX_friendly_transportTrucksCovered_desert = ["ffaa_et_m250_carga_lona_blin","ffaa_et_pegaso_carga_lona"];
	OPEX_friendly_transportTrucksCovered_snow = ["ffaa_et_m250_carga_lona_blin","ffaa_et_pegaso_carga_lona"];
	OPEX_friendly_fuelTrucks_woodland = ["ffaa_et_pegaso_combustible","ffaa_et_m250_combustible_blin"];
	OPEX_friendly_fuelTrucks_desert = ["ffaa_et_pegaso_combustible","ffaa_et_m250_combustible_blin"];
	OPEX_friendly_fuelTrucks_snow = ["ffaa_et_pegaso_combustible","ffaa_et_m250_combustible_blin"];
	OPEX_friendly_logisticTrucks_woodland = ["ffaa_et_toa_mando","ffaa_et_m250_estacion_nasams_blin"];
	OPEX_friendly_logisticTrucks_desert = ["ffaa_et_toa_mando","ffaa_et_m250_estacion_nasams_blin"];
	OPEX_friendly_logisticTrucks_snow = ["ffaa_et_toa_mando","ffaa_et_m250_estacion_nasams_blin"];
	OPEX_friendly_medicalTrucks_woodland = ["ffaa_et_lince_ambulancia","ffaa_et_toa_ambulancia"];
	OPEX_friendly_medicalTrucks_desert = ["ffaa_et_lince_ambulancia","ffaa_et_toa_ambulancia"];
	OPEX_friendly_medicalTrucks_snow = ["ffaa_et_lince_ambulancia","ffaa_et_toa_ambulancia"];
	OPEX_friendly_repairTrucks_woodland = ["ffaa_et_pegaso_repara_municion"];
	OPEX_friendly_repairTrucks_desert = ["ffaa_et_pegaso_repara_municion"];
	OPEX_friendly_repairTrucks_snow = ["ffaa_et_pegaso_repara_municion"];
	OPEX_friendly_ammoTrucks_woodland = ["ffaa_et_m250_repara_municion_blin"];
	OPEX_friendly_ammoTrucks_desert = ["ffaa_et_m250_repara_municion_blin"];
	OPEX_friendly_ammoTrucks_snow = ["ffaa_et_m250_repara_municion_blin"];
	OPEX_friendly_transportCars_woodland = ["ffaa_et_anibal","ffaa_et_vamtac_trans","ffaa_et_vamtac_trans_blind"];
	OPEX_friendly_transportCars_desert = ["ffaa_et_anibal","ffaa_et_vamtac_trans","ffaa_et_vamtac_trans_blind"];
	OPEX_friendly_transportCars_snow = ["ffaa_et_anibal","ffaa_et_vamtac_trans","ffaa_et_vamtac_trans_blind"];
	OPEX_friendly_combatCarsMG_woodland = ["ffaa_et_lince_m2","ffaa_et_lince_mg3","ffaa_et_vamtac_m2","ffaa_et_vamtac_crows"];
	OPEX_friendly_combatCarsMG_desert = ["ffaa_et_lince_m2","ffaa_et_lince_mg3","ffaa_et_vamtac_m2","ffaa_et_vamtac_crows"];
	OPEX_friendly_combatCarsMG_snow = ["ffaa_et_lince_m2","ffaa_et_lince_mg3","ffaa_et_vamtac_m2","ffaa_et_vamtac_crows"];
	OPEX_friendly_combatCarsGL_woodland = ["ffaa_et_lince_lag40","ffaa_et_vamtac_lag40","ffaa_et_vamtac_tow"];
	OPEX_friendly_combatCarsGL_desert = ["ffaa_et_lince_lag40","ffaa_et_vamtac_lag40","ffaa_et_vamtac_tow"];
	OPEX_friendly_combatCarsGL_snow = ["ffaa_et_lince_lag40","ffaa_et_vamtac_lag40","ffaa_et_vamtac_tow"];
	OPEX_friendly_vtt_woodland = ["ffaa_et_rg31_samson","ffaa_et_rg31_samson","ffaa_et_toa_m2","ffaa_et_toa_m2","ffaa_et_toa_spike"];
	OPEX_friendly_vtt_desert = ["ffaa_et_rg31_samson","ffaa_et_rg31_samson","ffaa_et_toa_m2","ffaa_et_toa_m2","ffaa_et_toa_spike"];
	OPEX_friendly_vtt_snow = ["ffaa_et_rg31_samson","ffaa_et_rg31_samson","ffaa_et_toa_m2","ffaa_et_toa_m2","ffaa_et_toa_spike"];
	OPEX_friendly_tanks_woodland = ["ffaa_et_leopardo","ffaa_et_pizarro_mauser"];
	OPEX_friendly_tanks_desert = ["ffaa_et_leopardo","ffaa_et_pizarro_mauser"];
	OPEX_friendly_tanks_snow = ["ffaa_et_leopardo","ffaa_et_pizarro_mauser"];
	OPEX_friendly_zodiacs = ["ffaa_ar_supercat","ffaa_ar_zodiac_hurricane","ffaa_ar_zodiac_hurricane_long"];
	OPEX_friendly_ships = ["ffaa_ar_serviola_p72","ffaa_ar_serviola_cargo","ffaa_ar_bam","ffaa_ar_bam_cargo"];
	OPEX_friendly_aircrafts = ["ffaa_ar_harrier"];
	OPEX_friendly_smallCombatHelicopters_woodland = ["ffaa_famet_tigre"];
	OPEX_friendly_smallCombatHelicopters_desert = ["ffaa_famet_tigre"];
	OPEX_friendly_smallCombatHelicopters_snow = ["ffaa_famet_tigre"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["ffaa_famet_tigre"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["ffaa_famet_tigre"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["ffaa_famet_tigre"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_smallTransportHelicopters_desert = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_smallTransportHelicopters_snow = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["ffaa_famet_cougar_armed","ffaa_famet_cougar","ffaa_nh90_tth_armed","ffaa_nh90_tth_transport"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["ffaa_famet_ch47_mg"];
	OPEX_friendly_bigTransportHelicopters_desert = ["ffaa_famet_ch47_mg"];
	OPEX_friendly_bigTransportHelicopters_snow = ["ffaa_famet_ch47_mg"];
	OPEX_friendly_UAVs = ["ffaa_et_searcherIII","ffaa_ea_reaper"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones; // don't delete this line if you have defined any of these variables
	OPEX_friendly_MGstatics = ["ffaa_m2_tripode"];
	OPEX_friendly_GLstatics = ["ffaa_lag40_tripode"];
	OPEX_friendly_ATstatics = ["ffaa_milan_tripode","ffaa_spike_tripode","ffaa_tow_tripode"];
	OPEX_friendly_AAstatics = ["ffaa_mistral_tripode"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["ffaa_armas_usp"];
	OPEX_friendly_specialHandguns = ["ffaa_armas_fnp9","ffaa_armas_fnp9","ffaa_armas_p226"];
	OPEX_friendly_commonRifles = ["ffaa_armas_hkg36e_normal","ffaa_armas_hkg36e_tir"];
	OPEX_friendly_specialRifles = ["ffaa_armas_hkg36e","ffaa_armas_hkg36k_normal","ffaa_armas_hkg36k","ffaa_armas_hkg36k_tir"];
	OPEX_friendly_GLrifles = ["ffaa_armas_hkag36e","ffaa_armas_hkag36e_tir","ffaa_armas_hkag36k","ffaa_armas_hkag36k_tir"];
	OPEX_friendly_MGriflesLight = ["ffaa_armas_mg4"];
	OPEX_friendly_MGriflesHeavy = ["ffaa_armas_mg3"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["ffaa_armas_hkmp5a5","ffaa_armas_hkmp5pdw","ffaa_armas_hkmp510a3","ffaa_armas_ump","ffaa_armas_p90"];
	OPEX_friendly_precisionRifles = ["ffaa_armas_aw50"];
	OPEX_friendly_sniperRifles = ["ffaa_armas_aw","ffaa_armas_m95"];
	OPEX_friendly_ATlaunchers = ["ffaa_armas_c90","ffaa_armas_c100"];
	OPEX_friendly_shotguns = ["ffaa_armas_sdass","ffaa_armas_sdassc"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics append ["ffaa_optic_holografico","ffaa_optic_g36_holo"];
	OPEX_friendly_distantCombatOptics append ["ffaa_optic_acog","ffaa_optic_Elcan","ffaa_optic_Elcan_ARD","ffaa_optic_susat"];
	OPEX_friendly_sniperOptics append ["ffaa_optic_enasa","ffaa_optic_Mk4_v1","ffaa_optic_Mk4_v2","ffaa_optic_lv","ffaa_optic_3x12x50","ffaa_optic_5x25x56"];
	OPEX_friendly_rifleSilencers append ["ffaa_snds_GT_556"];
	OPEX_friendly_pointers append ["ffaa_acc_puntero_ir"];
	OPEX_friendly_bipods append ["ffaa_bipod_G36"];

	// VARIOUS ITEMS
	//OPEX_friendly_ladders append ["FFAA_cuerda"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_commonUniforms_desert = ["ffaa_brilat_CombatUniform_item_d"];
	OPEX_friendly_commonUniforms_snow = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_specialUniforms_woodland = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_specialUniforms_desert = ["ffaa_brilat_CombatUniform_item_d"];
	OPEX_friendly_specialUniforms_snow = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_ghillieUniforms_woodland = ["ffaa_brilat_CombatUniform_sniper_item_b"];
	OPEX_friendly_ghillieUniforms_desert = ["ffaa_brilat_CombatUniform_sniper_item_d"];
	OPEX_friendly_ghillieUniforms_snow = ["ffaa_brilat_CombatUniform_sniper_item_b"];
	OPEX_friendly_heliPilotUniforms_woodland = ["ffaa_famet_uniforme_item_b"];
	OPEX_friendly_heliPilotUniforms_desert = ["ffaa_famet_uniforme_item_d"];
	OPEX_friendly_heliPilotUniforms_snow = ["ffaa_famet_uniforme_item_b"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["ffaa_pilot_harri_uniforme_item"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["ffaa_pilot_harri_uniforme_item"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["ffaa_pilot_harri_uniforme_item"];
	OPEX_friendly_tankPilotUniforms_woodland = ["ffaa_pilot_her_uniforme_item"];
	OPEX_friendly_tankPilotUniforms_desert = ["ffaa_pilot_her_uniforme_item_d"];
	OPEX_friendly_tankPilotUniforms_snow = ["ffaa_pilot_her_uniforme_item"];
	OPEX_friendly_medicUniforms_woodland = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_medicUniforms_desert = ["ffaa_brilat_CombatUniform_item_d"];
	OPEX_friendly_medicUniforms_snow = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_instructorUniforms_woodland = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_instructorUniforms_desert = ["ffaa_brilat_CombatUniform_item_d"];
	OPEX_friendly_instructorUniforms_snow = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_tshirtUniforms_woodland = ["ffaa_brilat_CombatUniform_item_b"];
	OPEX_friendly_tshirtUniforms_desert = ["ffaa_brilat_CombatUniform_item_d"];
	OPEX_friendly_tshirtUniforms_snow = ["ffaa_brilat_CombatUniform_item_b"];

	// VESTS
	OPEX_friendly_commonVests_woodland = ["ffaa_brilat_chaleco_01_bs"];
	OPEX_friendly_commonVests_desert = ["ffaa_brilat_chaleco_01_ds"];
	OPEX_friendly_commonVests_snow = ["ffaa_brilat_chaleco_01_bs"];
	OPEX_friendly_specialVests_woodland = ["ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_05_bs","ffaa_brilat_chaleco_06_bs","ffaa_brilat_chaleco_06_bs","ffaa_brilat_chaleco_06_bk"];
	OPEX_friendly_specialVests_desert = ["ffaa_brilat_chaleco_02_ds","ffaa_brilat_chaleco_02_ds","ffaa_brilat_chaleco_02_ds","ffaa_brilat_chaleco_05_ds","ffaa_brilat_chaleco_06_ds","ffaa_brilat_chaleco_06_ds","ffaa_brilat_chaleco_06_bk","ffaa_et_moe_peco_01_mtp","ffaa_et_moe_peco_02_mtp"];
	OPEX_friendly_specialVests_snow = ["ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_02_bs","ffaa_brilat_chaleco_05_bs","ffaa_brilat_chaleco_06_bs","ffaa_brilat_chaleco_06_bs","ffaa_brilat_chaleco_06_bk"];
	OPEX_friendly_medicVests_woodland = ["ffaa_brilat_chaleco_04_bs"];
	OPEX_friendly_medicVests_desert = ["ffaa_brilat_chaleco_04_ds"];
	OPEX_friendly_medicVests_snow = ["ffaa_brilat_chaleco_04_bs"];
	OPEX_friendly_lightVests_woodland = ["ffaa_brilat_chaleco_01_bs"];
	OPEX_friendly_lightVests_desert = ["ffaa_brilat_chaleco_01_ds"];
	OPEX_friendly_lightVests_snow = ["ffaa_brilat_chaleco_01_bs"];
	OPEX_friendly_grenadierVests_woodland = ["ffaa_brilat_chaleco_03_bs"];
	OPEX_friendly_grenadierVests_desert = ["ffaa_brilat_chaleco_03_ds"];
	OPEX_friendly_grenadierVests_snow = ["ffaa_brilat_chaleco_03_bs"];
	OPEX_friendly_EODvests_woodland = ["ffaa_brilat_chaleco_05_bs"];
	OPEX_friendly_EODvests_desert = ["ffaa_brilat_chaleco_05_ds"];
	OPEX_friendly_EODvests_snow = ["ffaa_brilat_chaleco_05_bs"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["ffaa_casco_marte_04_mod_3_b","ffaa_casco_marte_04_mod_3_b","ffaa_casco_marte_04_mod_4_b","ffaa_casco_marte_04_mod_1_b","ffaa_casco_marte_04_mod_2_b"];
	OPEX_friendly_commonHelmets_desert = ["ffaa_casco_marte_04_mod_3_d","ffaa_casco_marte_04_mod_3_d","ffaa_casco_marte_04_mod_4_d","ffaa_casco_marte_04_mod_1_d","ffaa_casco_marte_04_mod_2_d","ffaa_casco_opstats_1_d"];
	OPEX_friendly_commonHelmets_snow = ["ffaa_casco_marte_04_mod_3_b","ffaa_casco_marte_04_mod_3_b","ffaa_casco_marte_04_mod_4_b","ffaa_casco_marte_04_mod_1_b","ffaa_casco_marte_04_mod_2_b"];
	OPEX_friendly_specialHelmets_woodland = ["ffaa_brilat_casco_b","ffaa_brilat_casco_b","ffaa_brilat_casco_b","ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_2_bk","ffaa_moe_casco_02_3_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_2_b","ffaa_moe_casco_02_5_b","ffaa_moe_casco_02_4_b","ffaa_moe_casco_01_1_bk","ffaa_moe_casco_01_2_bk","ffaa_moe_casco_01_1_b","ffaa_moe_casco_01_2_b","ffaa_moe_casco_02_3_b"];
	OPEX_friendly_specialHelmets_desert = ["ffaa_brilat_casco_d","ffaa_brilat_casco_d","ffaa_brilat_casco_d","ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_4_b","ffaa_moe_casco_02_1_d","ffaa_moe_casco_02_4_d","ffaa_moe_casco_01_1_bk"];
	OPEX_friendly_specialHelmets_snow = ["ffaa_brilat_casco_b","ffaa_brilat_casco_b","ffaa_brilat_casco_b","ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_2_bk","ffaa_moe_casco_02_3_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_2_b","ffaa_moe_casco_02_5_b","ffaa_moe_casco_02_4_b","ffaa_moe_casco_01_1_bk","ffaa_moe_casco_01_2_bk","ffaa_moe_casco_01_1_b","ffaa_moe_casco_01_2_b","ffaa_moe_casco_02_3_b"];
	OPEX_friendly_EODhelmets_woodland = ["ffaa_brilat_casco_b"];
	OPEX_friendly_EODhelmets_desert = ["ffaa_brilat_casco_d"];
	OPEX_friendly_EODhelmets_snow = ["ffaa_brilat_casco_b"];
	OPEX_friendly_heliPilotHelmets = ["ffaa_casco_famet_piloto"];
	OPEX_friendly_aircraftPilotHelmets = ["ffaa_casco_famet_hmsd"];
	OPEX_friendly_tankCrewHelmets = ["ffaa_brilat_casco_tripulacion"];
	OPEX_friendly_cameraHelmets_woodland append ["ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_2_bk","ffaa_moe_casco_02_3_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_2_b","ffaa_moe_casco_02_5_b","ffaa_moe_casco_02_3_b","ffaa_moe_casco_02_4_b"];
	OPEX_friendly_cameraHelmets_desert append ["ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_4_b","ffaa_moe_casco_02_1_d","ffaa_moe_casco_02_4_d","ffaa_casco_opstats_1_d"];
	OPEX_friendly_cameraHelmets_snow append ["ffaa_moe_casco_02_1_bk","ffaa_moe_casco_02_2_bk","ffaa_moe_casco_02_3_bk","ffaa_moe_casco_02_4_bk","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_2_b","ffaa_moe_casco_02_5_b","ffaa_moe_casco_02_3_b","ffaa_moe_casco_02_4_b"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland append ["ffaa_brilat_chambergo_b"];
	OPEX_friendly_hats_desert append ["ffaa_brilat_chambergo_d"];
	OPEX_friendly_hats_snow append ["ffaa_brilat_chambergo_b"];
	OPEX_friendly_leaderHeadgear_woodland = ["ffaa_brilat_boina","ffaa_brimz_boina","ffaa_bripac_boina","ffaa_famet_boina","ffaa_fgne_boina","ffaa_moe_boina","ffaa_ar_gorra_marinero","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_4_b"];
	OPEX_friendly_leaderHeadgear_desert = ["ffaa_brilat_boina","ffaa_brimz_boina","ffaa_bripac_boina","ffaa_famet_boina","ffaa_fgne_boina","ffaa_moe_boina","ffaa_ar_gorra_marinero","ffaa_moe_casco_02_1_d","ffaa_moe_casco_02_4_d"];
	OPEX_friendly_leaderHeadgear_snow = ["ffaa_brilat_boina","ffaa_brimz_boina","ffaa_bripac_boina","ffaa_famet_boina","ffaa_fgne_boina","ffaa_moe_boina","ffaa_ar_gorra_marinero","ffaa_moe_casco_02_1_b","ffaa_moe_casco_02_4_b"];
	OPEX_friendly_berets = ["ffaa_brilat_boina","ffaa_brimz_boina","ffaa_bripac_boina","ffaa_famet_boina","ffaa_fgne_boina","ffaa_moe_boina"];
	OPEX_friendly_caps append ["ffaa_ar_gorra_marinero"];
	OPEX_friendly_headsets append ["ffaa_casco_hercules_piloto"];

	// FACEGEAR
	OPEX_friendly_glasses append ["ffaa_Glasses"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland append ["ffaa_brilat_mochila_asalto_boscoso","ffaa_brilat_mochila_asalto_boscoso","ffaa_brilat_mochila_boscoso","ffaa_brilat_mochila_boscoso","ffaa_brilat_mochila_ligera_boscoso","ffaa_brilat_mochila_ligera_boscoso"];
	OPEX_friendly_mediumBackpacks_desert append ["ffaa_brilat_mochila_asalto_arida","ffaa_brilat_mochila_asalto_arida","ffaa_brilat_mochila_arida","ffaa_brilat_mochila_arida","ffaa_brilat_mochila_ligera_arida","ffaa_brilat_mochila_ligera_arida"];
	OPEX_friendly_mediumBackpacks_snow append ["ffaa_brilat_mochila_asalto_boscoso","ffaa_brilat_mochila_asalto_boscoso","ffaa_brilat_mochila_boscoso","ffaa_brilat_mochila_boscoso","ffaa_brilat_mochila_ligera_boscoso","ffaa_brilat_mochila_ligera_boscoso"];
	OPEX_friendly_bigBackpacks_woodland append ["ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso"];
	OPEX_friendly_bigBackpacks_desert append ["ffaa_brilat_mochila_viaje_arida","ffaa_brilat_mochila_viaje_arida","ffaa_brilat_mochila_viaje_arida","ffaa_brilat_mochila_viaje_arida","ffaa_brilat_mochila_viaje_arida"];
	OPEX_friendly_bigBackpacks_snow append ["ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso","ffaa_brilat_mochila_viaje_boscoso"];
	OPEX_friendly_medicBackpacks_woodland = ["ffaa_brilat_mochila_medica"];
	OPEX_friendly_medicBackpacks_desert = ["ffaa_brilat_mochila_medica"];
	OPEX_friendly_medicBackpacks_snow = ["ffaa_brilat_mochila_medica"];