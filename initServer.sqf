	// WAITING FOR SERVER
	waitUntil {time > 0};
	waitUntil {!isNil "BIS_fnc_init"};

	{_x disableAI "RADIOPROTOCOL"} forEach allUnits;

	// CHECKING IF A PERSISTENT SAVE EXISTS - IF YES, LOADING IT - IF NOT, CREATING IT
	if ("server" call Gemini_fnc_persistence_exists) then {"server" spawn Gemini_fnc_persistence_resume} else {"server" spawn Gemini_fnc_persistence_new};

/// ---------------------------------------------------------------
/// INITIALIZING THESE VARIABLES EVERY TIME THE SERVER STARTS
/// ---------------------------------------------------------------

	// INITIALIZING TASK STATE
	OPEX_assignedTask = false; publicVariable "OPEX_assignedTask";
	OPEX_task = nil; publicVariable "OPEX_task";
	OPEX_taskID = ""; publicVariable "OPEX_taskID";
	OPEX_taskDescription = []; publicVariable "OPEX_taskDescription";

	// INITIALIZING PLAYING PLAYERS (PLAYERS OUTSIDE SAFE AREAS)
	OPEX_playingPlayers = []; publicVariable "OPEX_playingPlayers";

	// INITIALIZING ENTITIES & MARKERS COUNT
	OPEX_entities = [[], [], [], []]; publicVariable "OPEX_entities";
	OPEX_markers = [[], [], [], []]; publicVariable "OPEX_markers";
	OPEX_logics = allUnits select {side _x == sideLogic}; publicVariable "OPEX_logics";

	// CREATING TASK MARKERS
	_taskMarker_A = createMarker ["taskMarker_A", [0,0,0]]; _taskMarker_A setMarkerType "empty";
	_taskMarker_B = createMarker ["taskMarker_B", [0,0,0]]; _taskMarker_B setMarkerType "empty";
	_taskMarker_C = createMarker ["taskMarker_C", [0,0,0]]; _taskMarker_C setMarkerType "empty";
	_taskMarker_D = createMarker ["taskMarker_D", [0,0,0]]; _taskMarker_D setMarkerType "empty";
	_taskMarker_E = createMarker ["taskMarker_E", [0,0,0]]; _taskMarker_E setMarkerType "empty";
	_taskMarker_F = createMarker ["taskMarker_F", [0,0,0]]; _taskMarker_F setMarkerType "empty";
	_taskMarker_G = createMarker ["taskMarker_G", [0,0,0]]; _taskMarker_G setMarkerType "empty";
	_taskMarker_H = createMarker ["taskMarker_H", [0,0,0]]; _taskMarker_H setMarkerType "empty";
	_taskMarker_I = createMarker ["taskMarker_I", [0,0,0]]; _taskMarker_I setMarkerType "empty";
	_taskMarker_J = createMarker ["taskMarker_J", [0,0,0]]; _taskMarker_J setMarkerType "empty";

	// DEFINING RESPAWN POSITIONS
	//mainRespawnPoint = [missionNamespace, "OPEX_marker_medical", localize "STR_marker_medicalCenter"] call BIS_fnc_addRespawnPosition;
	//publicVariable "mainRespawnPoint";

	// INITIALIZING REVIVE FUNCTION
	[] spawn Gemini_fnc_revive;

	// INITIALIZING DYNAMIC GROUP MANAGER
	["Initialize"] call BIS_fnc_dynamicGroups;

/// ---------------------------------------------------------------
/// INITIALIZING THESE VARIABLES ONLY ONCE WHEN THE MISSION STARTS
/// ---------------------------------------------------------------

	waitUntil {!isNil "OPEX_params_ready"};

	// INITIALIZING AIs IDENTITIES & LANGUAGE
	{[_x] spawn Gemini_fnc_setIdentity} forEach (allUnits - allPlayers);

	// CONVERTING VANILLA CONTENT (thanks to Jack Ost for the suggestion and for his help !)
	[] spawn Gemini_fnc_convertVehicles;
	[] spawn Gemini_fnc_convertLoadouts;


// 1. D'abord, charger le fichier d'initialisation du territoire
execVM "scripts\Territory\init.sqf";

// 2. Ensuite, attendre que les fonctions principales soient compilées
[] spawn {
    // Attendre que le fichier init.sqf ait compilé les fonctions principales
    waitUntil {!isNil "Gemini_fnc_initTerritorySystem" && !isNil "Gemini_fnc_createTerritory"};
    diag_log "[TERRITOIRE] Fonctions de base compilées, chargement des interactions chef...";
    
    // 3. Charger les interactions du chef à ce moment-là
    execVM "scripts\Territory\fnc_chiefInteractions_simple.sqf";
    
    // 4. Attendre que les interactions du chef soient compilées
    waitUntil {!isNil "Gemini_fnc_openChiefMissionDialog"};
    diag_log "[TERRITOIRE] Toutes les fonctions territoriales compilées, initialisation du système...";
    
    // 5. Initialiser le système de territoire
    [] call Gemini_fnc_initTerritorySystem;
    
    // 6. Attendre la confirmation d'initialisation
    waitUntil {!isNil "OPEX_territories_initialized"};
    diag_log "[TERRITOIRE] Initialisation du système territorial complète depuis initServer";
		};





	if (!("server" call Gemini_fnc_persistence_exists)) then
		{
			// TASKS
			OPEX_succeededTasks = 0; publicVariable "OPEX_succeededTasks";
			OPEX_failedTasks = 0; publicVariable "OPEX_failedTasks";
			OPEX_canceledTasks = 0; publicVariable "OPEX_canceledTasks";

			// STATS
			[] spawn {waitUntil {!isNil "Gemini_fnc_initStatsFaction"}; call Gemini_fnc_initStatsFaction};

			// DAY TIME
			waitUntil {!isNil "OPEX_param_dayTime"};
			switch (OPEX_param_dayTime) do
				{
					case 0	:	{[[2019, 6, 13, ceil (random 23), ceil (random 59)]] remoteExec ["setDate"]}; // random time
					case 1	:	{[[2019, 6, 13, 4, 45]] remoteExec ["setDate"]}; // morning
					case 2	:	{[[2019, 6, 13, 12, 0]] remoteExec ["setDate"]}; // noon
					case 3	:	{[[2019, 6, 13, 19, 0]] remoteExec ["setDate"]}; // evening
					case 4	:	{[[2019, 6, 13, 0, 0]] remoteExec ["setDate"]}; // midnight
				};

			// TIME MULTIPLIER
			waitUntil {!isNil "OPEX_param_timeMultiplier"};
			switch (OPEX_param_timeMultiplier) do
				{
					case 0	:	{setTimeMultiplier 1};
					case 1	:	{setTimeMultiplier 3};
					case 2	:	{setTimeMultiplier 6};
					case 3	:	{setTimeMultiplier 12};
					case 4	:	{setTimeMultiplier 24};
				};

			// INTEL
			waitUntil {!isNil "OPEX_stats_faction"};
			waitUntil {count OPEX_stats_faction > 0};
			waitUntil {!isNil "OPEX_param_intel"};
			switch (OPEX_param_intel) do
				{
					case 0	:	{OPEX_stats_faction set [14, 0]};
					case 1	:	{OPEX_stats_faction set [14, 50]};
					case 2	:	{OPEX_stats_faction set [14, 100]};
					case 3	:	{OPEX_stats_faction set [14, 500]};
					case 4	:	{OPEX_stats_faction set [14, 1000]};
					case 5	:	{OPEX_stats_faction set [14, 10000]};
				};
			publicVariable "OPEX_stats_faction";

			// SUPPORT
			OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";
			if (OPEX_param_supportManagement == 0)
			then
				{
					// REALISTIC
					OPEX_support_suppliesDrop = false;
					OPEX_support_vehicleDrop = false;
					OPEX_support_airStrike = false;
					OPEX_support_artilleryStrike = false;
					OPEX_support_airAssistance = false;
					OPEX_support_landAssistance = false;
					if ((!isMultiplayer) && (!OPEX_debug)) then {OPEX_support_transport = true} else {OPEX_support_transport = false};
					//if (OPEX_debug) then {OPEX_support_transport = false};
				}
			else
				{
					// UNLIMITED
					OPEX_support_suppliesDrop = true;
					OPEX_support_vehicleDrop = true;
					OPEX_support_airStrike = true;
					OPEX_support_artilleryStrike = true;
					OPEX_support_airAssistance = true;
					OPEX_support_landAssistance = true;
					OPEX_support_transport = true;
				};
			publicVariable "OPEX_support_suppliesDrop";
			publicVariable "OPEX_support_vehicleDrop";
			publicVariable "OPEX_support_airStrike";
			publicVariable "OPEX_support_artilleryStrike";
			publicVariable "OPEX_support_airAssistance";
			publicVariable "OPEX_support_landAssistance";
			publicVariable "OPEX_support_transport";

			// NAMING VEHICLES (necessary for some scripts execution
			{
				if ((_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "ship")) then
				{
					private ["_emptyVehicleID"];
					_emptyVehicleID = "OPEX_vehicle_" + (str (round (random 99999))); // example: "OPEX_vehicle_12345"
					/*
					_x setVehicleVarName _emptyVehicleID;
					missionNamespace setVariable [_emptyVehicleID, _x];
					publicVariable _emptyVehicleID;
					waitUntil {vehicleVarName _x == _emptyVehicleID};
					*/
					[_x, _emptyVehicleID] remoteExecCall ["Gemini_fnc_setVehicleVarName", 0, _x];
				}
			} forEach vehicles;

			// NAMING AI UNITS (necessary for some scripts execution
			{
				private _unitsID = "OPEX_unit_" + (str (round (random 99999))); // example: "OPEX_unit_67890"
				[_x, _unitsID] remoteExecCall ["Gemini_fnc_setVehicleVarName", 0, _x];
			} forEach (allUnits - allPlayers);

			// EMPTYING VEHICLES CARGO
			{
				if ((_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "ship")) then
					{
						clearWeaponCargoGlobal _x;
						clearMagazineCargoGlobal _x;
						clearItemCargoGlobal _x;
						clearBackpackCargoGlobal _x;
						if (_x isKindOf "air") then {_x addBackpackCargoGlobal [selectRandom OPEX_friendly_parachutes, (_x emptyPositions "cargo") + (_x emptyPositions "driver") + (_x emptyPositions "gunner") + (_x emptyPositions "commander")]};
					};
			} forEach vehicles;

			// FILLING AMMO CRATES
			{_x spawn Gemini_fnc_fillCrate} forEach (vehicles select {(_x isKindOf "ReammoBox_F")});
		};

	// SYNCHRONIZING PLAYERS TO HIGH COMMAND MODULE
	_logicGroup = createGroup (sideLogic);
	_groupHC = _logicGroup createUnit ["HighCommand", [0, 0, 0], [], 0, "NONE"];
	[player, [_groupHC]] remoteExec ["synchronizeObjectsAdd"];
	//_Group_HC_S = _logicGroup createUnit ["HighCommandSubordinate", [0, 0, 0], [], 0, "NONE"];
	//_Group_HC_C synchronizeObjectsAdd [_Group_HC_S];

	// SETTING HQ MARKERS
	waitUntil {getMarkerColor "OPEX_marker_toc" != ""};
	private _respawnMarkers = allMapMarkers select {"bis_o" in _x}; if (count _respawnMarkers > 0) then {{_x setMarkerAlpha 0} forEach _respawnMarkers}; // hiding respawn marker
	private _flag = [getMarkerPos "OPEX_marker_toc", OPEX_friendly_flag_marker, "Default", OPEX_friendly_camp, "hq"] call Gemini_fnc_createMarker;
	_flag setMarkerSize [2,2];

	