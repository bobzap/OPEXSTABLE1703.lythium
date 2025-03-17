// =========================================================================================================
// OPEX INITIALIZATION
// =========================================================================================================

	0 cutText ["", "black in", 10e10];
	0 fadeSound 0; // 0 fadeSound 0; // muting sound
	enableRadio false;
	Server = missionNamespace;
	waitUntil {!isNil "BIS_fnc_init"}; // waiting for BI's functions
	enableSaving [false, false];

// =========================================================================================================
// SETTING DEV VARIABLES
// =========================================================================================================

	OPEX_version = "2.061";
	OPEX_debug = false; // [bool] true (if yes) or false (if no) - default: false
	OPEX_intro = true; // [bool] true (if yes) or false (if no) - default: true
	OPEX_updateNotice = [false, parseNumber OPEX_version]; // [bool, number] true if a notice must be displayed once a new update is released

// =========================================================================================================
// INITIALIZING MISSION
// =========================================================================================================

	// GETTING MISSION PATH
	OPEX_missionPath = [str missionConfigFile, 0, -15] call BIS_fnc_trimString;

	// GETTING UNITS/WEAPONS/VEHICLES/MODS ETC...
	call compile preProcessFileLineNumbers "settings\init.sqf";

	// GETTING VALID LOCATIONS
	[] spawn
		{
			sleep 3;
			OPEX_allLocations = OPEX_locations_safe + OPEX_locations_isolated + OPEX_locations_villages + OPEX_locations_cities + OPEX_locations_industrial + OPEX_locations_military;
			OPEX_validLocations = OPEX_locations_isolated + OPEX_locations_villages + OPEX_locations_cities + OPEX_locations_industrial + OPEX_locations_military;
			for "_i" from 0 to (count OPEX_locations_safe) do {{if ((position _x) inArea (OPEX_locations_safe select _i)) then {OPEX_validLocations = OPEX_validLocations - [_x]}} forEach (OPEX_locations_isolated + OPEX_locations_villages + OPEX_locations_cities + OPEX_locations_industrial + OPEX_locations_military)};
		};

// =========================================================================================================
// INITIALIZING TASKS
// =========================================================================================================

	call Gemini_fnc_taskFunctions; // initializing tasks functions
	call compile preProcessFileLineNumbers "tasks\taskList.sqf"; // getting task list

// =========================================================================================================
// INITIALIZING MAIN FUNCTIONS
// =========================================================================================================

	[] spawn Gemini_fnc_playingPlayers; // monitoring if players are outside any safe areas (HQ)
	[] spawn Gemini_fnc_deleteDisconnectedPlayers; // deleting player body after server disconnection

// =========================================================================================================
// INITIALIZING AMBIENT MODULES
// =========================================================================================================

	// CIVILIANS
	[] spawn Gemini_fnc_ambientCivilianLife;
	[] spawn Gemini_fnc_ambientCivilianCars;
	[] spawn Gemini_fnc_ambientCivilianBoats;

	// FRIENDS
	[] spawn Gemini_fnc_ambientFriendlyPatrols;
	[] spawn Gemini_fnc_ambientFriendlyBoats;
	[] spawn Gemini_fnc_ambientFriendlyRoadblocks;
	[] spawn Gemini_fnc_ambientFriendlyAir;

	// ENEMIES
	[] spawn Gemini_fnc_ambientEnemyPatrols;
	[] spawn Gemini_fnc_ambientEnemyReinforcements;
	[] spawn Gemini_fnc_ambientEnemyIEDs;
	[] spawn Gemini_fnc_ambientEnemyAmbushes;
	[] spawn Gemini_fnc_ambientEnemyBivouacs;
	[] spawn Gemini_fnc_ambientEnemyCaches;
	[] spawn Gemini_fnc_ambientEnemyGarrisons;
	[] spawn Gemini_fnc_ambientEnemyBoats;
	[] spawn Gemini_fnc_ambientEnemyRoadblocks;

// =========================================================================================================
// INITIALIZING OTHER FUNCTIONS
// =========================================================================================================

	// GEMINI
	[] spawn Gemini_fnc_customActionsObjects;
	[] spawn Gemini_fnc_getSunHeight;
	[] spawn Gemini_fnc_rpt;
	[] spawn Gemini_fnc_useInventoryObject;
	[] spawn Gemini_fnc_needs;
	//[] spawn Gemini_fnc_disableInGameRadio; // outdated ?
	[] spawn Gemini_fnc_vehicleMusicReceiver;
	[] spawn Gemini_fnc_incognito;
	[] spawn Gemini_fnc_stats;
	//[] spawn Gemini_fnc_checkMissionIntegrity; // outdated, need to be totally reworked from scratch
	[] spawn Gemini_fnc_colorCorrection;
	[] spawn Gemini_fnc_shout;
	[] spawn Gemini_fnc_guidedTour;
	[] spawn Gemini_fnc_cleaning;
	[] spawn Gemini_fnc_ads;
	[] spawn Gemini_fnc_selectCamo;
	[] spawn Gemini_fnc_setAllObjectsTextures;
	[] spawn Gemini_fnc_lowerVariables;
	//[] spawn Gemini_fnc_protectAreaFromEnemies; outdated ?

/*
	[missionNamespace, "OnSaveGame", {hint "GAME SAVED"}] call BIS_fnc_addScriptedEventHandler;
	addMissionEventHandler ["Loaded", {hint "GAME LOADED"}];
	_id = addMissionEventHandler ["Ended",{ _this execVM "missionEnded.sqf" }];

	addMissionEventHandler ["PlayerDisconnected", {hint "PLAYER SAVED"}];
	handlercon = addMissionEventHandler ["PlayerConnected", {hint "PLAYER LOADED"}];
*/


	// R3F


	[] spawn {sleep 10; if (!isNil "Vcm_ActivateAI") then {Vcm_ActivateAI = false}}; // DIASBLING VCOM AI MOD BECAUSE THIS MOD GENERATES MANY ERRORS AND UNEXPECTED SITUATIONS
	[] spawn {sleep 3; if ((isNil "bcombat_enable") && (!isClass(configFile >> "CfgPatches" >> "asr_ai3_main"))) then {execVM "scripts\R3F\AiComTarget\init.sqf"}}; // AI IMPROVEMENTS
	execVM "scripts\R3F\LOG\init.sqf"; Server setVariable ["R3F_LOG_disabled", true]; // logistic script
	[] spawn
		{
			waitUntil {!isNil "OPEX_params_ready"};
			waitUntil {!isNil "OPEX_stats_faction"};
			waitUntil {!isNil "OPEX_friendly_logisticTrucks"};
			sleep 5;
			waitUntil {count (vehicles select {(typeOf _x) in OPEX_friendly_logisticTrucks}) > 0};
			{
				0 = [_x, OPEX_stats_faction select 14, nil, OPEX_constructions] execVM "scripts\R3F\LOG\USER_FUNCT\init_creation_factory.sqf"; // FACTORY
				//[OPEX_friendly_side1, _x] call BIS_fnc_addRespawnPosition; // ADDING A RESPAWN POINT TO THE MOBILE HQ
				//[_x, 500] spawn Gemini_fnc_protectVehicleFromEnemies;
			} forEach (vehicles select {(typeOf _x) in OPEX_friendly_logisticTrucks});
		};

	// DUDA
	execVM "scripts\duda\fn_advancedTowingInit.sqf"; // towing script
	execVM "scripts\duda\fn_advancedSlingLoadingInit.sqf"; // towing script

	// BANGABOB
	null = allUnits execVM "scripts\BangaBob\dragDeadBody\H8_dragBody.sqf"; // DRAG DEAD BODY SCRIPT

	// CODE34
	0 = [] execVM "scripts\code34\real_weather.sqf"; // dynamic weather MP compatible

	//	VIPERIDAE
	if (!isClass (configFile >> "CfgPatches" >> "ace_interaction")) then {0 = [true, [true, true, true, true], [0, true, true], [[1000], true, false]] execVM "scripts\Viperidae\vip_lit\vip_lit_init.sqf"}; // little immersion tweaks

	// SHACKTAC
	if ((!isClass (configFile >> "CfgPatches" >> "ace_interaction")) && (isMultiplayer)) then {if (isServer) then {execVM "scripts\ShackTac\MapGestures\serverInit.sqf"}; if (!isDedicated) then {execVM "scripts\ShackTac\MapGestures\clientInit.sqf"}}; // map gestures

	// TFR
	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {TF_give_microdagr_to_soldier = false; TF_no_auto_long_range_radio = true}; // disabling auto-assignation of TFR radios

	// BCOMBAT
	// deactivating fleeing functions (if the mod has been detected)
	// thanks to scimitar for the feedback: https://forums.bistudio.com/forums/topic/194070-spmp-opex-op%C3%A9rations-ext%C3%A9rieures-new-dynamical-OPEX_task-generator-introducing-the-french-army/?do=findComment&comment=3216505
	if (isClass (configFile >> "CfgPatches" >> "bcombat")) then
		{
			waitUntil {!isNil "bcombat_allow_fleeing"}; if (bcombat_allow_fleeing) then {bcombat_allow_fleeing = false};
			waitUntil {!isNil "bcombat_allow_surrender"}; if (bcombat_allow_surrender) then {bcombat_allow_surrender = false};
			hintSilent "";
		};

	// TPW
	0 = [10,1000,1,1] execVM "scripts\TPW\tpw_hud_init.sqf";
	0 = [60,5] execvm "scripts\TPW\tpw_furniture.sqf";

	// PSYCHOBASTARD
	0 = [] execVM "scripts\Psychobastard\AIS\init.sqf";

	// AFAR RADIO SCRIPT
	[] spawn compileFinal (preprocessFile "scripts\AFAR\init.sqf");

// =========================================================================================================
// INITIALIZING DYNAMIC SIMULATION
// =========================================================================================================

	OPEX_spawnDistanceMini = 500;
	OPEX_spawnDistanceMaxi = OPEX_spawnDistanceMini * 3;

	"Group" setDynamicSimulationDistance (OPEX_spawnDistanceMini * 2);
	"Vehicle" setDynamicSimulationDistance (OPEX_spawnDistanceMini * 2);
	"EmptyVehicle" setDynamicSimulationDistance (OPEX_spawnDistanceMini / 5);
	"Prop" setDynamicSimulationDistance (OPEX_spawnDistanceMini / 25);
	"IsMoving" setDynamicSimulationDistanceCoef 2;
	enableDynamicSimulationSystem true;
	BIS_fps_rescanNewObjects = true; // refreshing dynamic simulation system (otherwise, units/objects/vehicles with dynamic simulation enabled may be hidden at startup on dedicated persistent servers ?)