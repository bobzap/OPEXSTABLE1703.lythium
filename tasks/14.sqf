// =========================================================================================================
// TASK ID : 			14
// TASK OBJECTIVE :		ATTACKING AN ENEMY TRAINING CAMP
// TASK CREATOR : 		GEMINI (gemini.69@free.fr)
// =========================================================================================================

// =========================================================================================================
// STARTING TASK CREATION
// =========================================================================================================

	private _unit = player;
	["hint", "STR_hint_creatingTask"] remoteExec ["Gemini_fnc_globalHint", _unit];

// =========================================================================================================
// CREATING TASK ON THE SERVER
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// GETTING MAIN VARIABLES
// =========================================================================================================

	private _debug = OPEX_debug;
	OPEX_taskID = _this select 0; publicVariable "OPEX_taskID";
	OPEX_assignedTask = true; publicVariable "OPEX_assignedTask";

// =========================================================================================================
// LOOKING FOR TASK POSITION(S)
// =========================================================================================================

	// LOOKING FOR AN RANDOM LOCATION
	private _campPos = ["military", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_campPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING LOCATION SIZE
	private _campSize = [((triggerArea ((_campPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_campPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	if (isNil "_campSize") then {_campSize = [100,100]};
	private _campRadius = (_campSize select 0) max (_campSize select 1);
	if (_campRadius < 50) then {_campRadius = 50};
	private _campDir = (triggerArea ((_campPos nearObjects ["EmptyDetector", 5]) select 0)) select 2;

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING COMMON OBJECTS
	private _flag = [OPEX_enemy_flag, ["land", _campPos, 1, _campRadius / 3, 3] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_flag setFlagTexture OPEX_enemy_flagTexture;
	private _lightSource = [["Campfire_burning_F", "MetalBarrel_burning_F"], ["land", _flag, 1, 10, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	private _clutterCutter = ["Land_ClutterCutter_large_F", _lightSource, random 360, true, "task"] call Gemini_fnc_createVehicle;

	// SPAWNING TRAINING COMPOSITIONS
	private _obstaclesPosition = ["land_noRoad", _campPos, 0, _campRadius, 10] call Gemini_fnc_findPos; if (!(_obstaclesPosition isEqualTo [0,0,0])) then {0 = [_obstaclesPosition, random 360, call (compile (preprocessFileLineNumbers "compositions\training_obstacles.sqf"))] call BIS_fnc_ObjectsMapper; {_x setVectorUp (surfaceNormal (position _x)); _x setPosATL [(getPos _x select 0), (getPos _x select 1), 0]; [_x, "task"] call Gemini_fnc_setLifeTime} forEach (nearestObjects [_obstaclesPosition, ["all"], 30])};
	private _shootingPosition = ["land_noRoad", _campPos, 0, _campRadius, 7.5] call Gemini_fnc_findPos; if (!(_shootingPosition isEqualTo [0,0,0])) then {0 = [_shootingPosition, random 360, call (compile (preprocessFileLineNumbers "compositions\training_shootingRange.sqf"))] call BIS_fnc_ObjectsMapper; {_x setVectorUp (surfaceNormal (position _x)); _x setPosATL [(getPos _x select 0), (getPos _x select 1), 0]; [_x, "task"] call Gemini_fnc_setLifeTime} forEach (nearestObjects [_shootingPosition, ["all"], 20])};
	private _fitnessPosition = ["land_noRoad", _campPos, 0, _campRadius * 0.5, 5] call Gemini_fnc_findPos; if (!(_fitnessPosition isEqualTo [0,0,0])) then {0 = [_fitnessPosition, random 360, call (compile (preprocessFileLineNumbers "compositions\training_fitness.sqf"))] call BIS_fnc_ObjectsMapper; {_x setVectorUp (surfaceNormal (position _x)); _x setPosATL [(getPos _x select 0), (getPos _x select 1), 0]; [_x, "task"] call Gemini_fnc_setLifeTime} forEach (nearestObjects [_fitnessPosition, ["all"], 15])};
	private _targetsPosition = ["land_noRoad", _campPos, 0, _campRadius, 5] call Gemini_fnc_findPos; if (!(_targetsPosition isEqualTo [0,0,0])) then {0 = [_targetsPosition, random 360, call (compile (preprocessFileLineNumbers "compositions\training_targets.sqf"))] call BIS_fnc_ObjectsMapper; {_x setVectorUp (surfaceNormal (position _x)); _x setPosATL [(getPos _x select 0), (getPos _x select 1), 0]; [_x, "task"] call Gemini_fnc_setLifeTime} forEach (nearestObjects [_targetsPosition, ["all"], 15])};

	p1 = _obstaclesPosition;
	p2 = _shootingPosition;
	p3 = _fitnessPosition;
	p4 = _targetsPosition;

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// SPAWNING STATIC DEFENSE
	[_campPos, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, _campRadius * 3, selectRandom [1,2,3], 95, "task"] call Gemini_fnc_spawnStaticDefense;

	// SPAWNING EMPTY VEHICLES
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _campPos, _campRadius, [OPEX_enemy_commonUnits, 0], 100, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _campPos, _campRadius, [OPEX_enemy_commonUnits, 0], 75, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_armored, OPEX_enemy_side1, _campPos, _campRadius, [OPEX_enemy_crewman, 3], 25, "task"] call Gemini_fnc_spawnVehicle;

	// SPAWNING ENEMIES
	[_campPos, _campRadius, selectRandom [5,8,10,12,15,20,25], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;
	[_campPos, _campRadius, selectRandom [5,8,10,12], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;
	for "_i" from 1 to (selectRandom [1,2,3,5]) do {[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,4], _campPos, _campRadius, "talk", _campPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};
	for "_i" from 1 to (selectRandom [1,2,3,5]) do {[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _campPos, _campRadius, "wait", _campPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};

	// SPAWNING PATROLS
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,8], _campPos, [50, 200], "patrol", _campPos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [5,7,10], _campPos, [200, 400], "patrol", _campPos, OPEX_enemy_AIskill, 80, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [5,8,12], _campPos, [400, 600], "patrol", _campPos, OPEX_enemy_AIskill, 60, "task"] call Gemini_fnc_spawnSquad;

	// CHECKING IF MISSION HAS BEEN PROPERLY SET
	private _countEnemies = count ((_campPos nearEntities ["Man",_campRadius]) select {side _x == OPEX_enemy_side1});
	if (_countEnemies == 0) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// CREATING MARKER(S)
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _campPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _campSize;
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0.75;
	"TaskMarker_A" setMarkerDir _campDir;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos _campPos;
	"TaskMarker_B" setMarkerType "mil_destroy";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorRed";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "destroy", "taskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF ALL ENEMIES ARE KILLED
	//sleep 1;
	[
		_campPos,
		[_campSize select 0, _campSize select 1, 0, false],
		[OPEX_enemy_side2, "not present", false],
		["OPEX_assignedTask && this", "[] remoteExec ['Gemini_fnc_taskSucceeded']; ['intel', 25] call Gemini_fnc_bonus", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// there's no way to fail this task