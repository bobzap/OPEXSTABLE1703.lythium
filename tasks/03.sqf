// =========================================================================================================
// TASK ID : 			03
// TASK OBJECTIVE :		SECURE A VILLAGE
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
// DEFINING TASK POSITION(S)
// =========================================================================================================

	// LOOKING FOR A VILLAGE
	private _villagePos = ["village", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_villagePos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING VILLAGE SIZE
	private _villageArea = [((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _villageSize = (_villageArea select 0) max (_villageArea select 1);

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	private _spawnEnemies =
		{
			// DEFINING MAIN VARIABLES
			private _debug = _this select 0;
			private _villagePos = _this select 1;
			private _villageSize = _this select 2;

			// SPAWNING DEFENSE VEHICLES
			[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _villagePos, _villageSize, [OPEX_enemy_units, ceil (random 3)], 40, "task"] call Gemini_fnc_spawnVehicle;
			[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _villagePos, _villageSize, [OPEX_enemy_units, ceil (random 3)], 40, "task"] call Gemini_fnc_spawnVehicle;

			// SPAWNING STATIC ENEMIES INSIDE BUILDINGS
			[_villagePos, _villageSize, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;

			// SPAWNING ENEMIES INTO THE VILLAGE
			[_villagePos, _villageSize, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;

			//  SPAWNING SQUAD(S) PATROLLING THE AREA
			for "_i" from 1 to 2 do {[OPEX_enemy_side1, ["infantry"], selectRandom [2,2,2,3,3,5,7,10,12], _villagePos, _villageSize * 3, "patrol", _villagePos, OPEX_enemy_AIskill, 50] call Gemini_fnc_spawnSquad};
		};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// see "conditions of victory"

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	private _trigger =
		[
			_villagePos,
			[0, 0, 0, false],
			[OPEX_enemy_side2, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// DEFINING 2 RANDOM CASES
	if (random 10 > 1.5)

	// SOMETIMES, INTEL IS RIGHT: ENEMY IS IN THE VILLAGE, SO PLAYERS HAVE TO KILL THEM
	then
		{
			_trigger setTriggerArea [_villageArea select 0, _villageArea select 1, 0, false];
			_trigger setTriggerActivation [OPEX_enemy_side2, "not present", false];
			_trigger setTriggerStatements ["this && OPEX_assignedTask && {thisTrigger distance _x < (triggerArea thisTrigger select 0) max (triggerArea thisTrigger select 1)} count (playableUnits + switchableUnits) > 0", "[] remoteExec ['Gemini_fnc_taskSucceeded']", ""];
			sleep 1;
			0 = [_debug, _villagePos, _villageSize] spawn _spawnEnemies;
		}

	// SOMETIMES, INTEL IS WRONG: NO ENEMY IS IN THE VILLAGE, SO PLAYERS JUST NEED TO REACH THE CENTER OF THE VILLAGE
	else
		{
			_trigger setTriggerArea [(_villageArea select 0) / 5, (_villageArea select 1) / 5, 0, false];
			_trigger setTriggerActivation [OPEX_friendly_side3, "present", false];
			_trigger setTriggerStatements ["this && OPEX_assignedTask && ({(_x inArea thisTrigger) && (side _x == OPEX_enemy_side1)} count (allUnits) == 0)", "[] remoteExec ['Gemini_fnc_taskSucceeded']; ['reputation', 0.05] call Gemini_fnc_bonus", ""];
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// there is no way to fail this task

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"taskMarker_A" setMarkerPos _villagePos;
	"taskMarker_A" setMarkerShape "ellipse";
	"taskMarker_A" setMarkerBrush "FDiagonal";
	"taskMarker_A" setMarkerSize _villageArea;
	"taskMarker_A" setMarkerColor "colorRed";
	"taskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos _villagePos;
	"taskMarker_B" setMarkerType "mil_warning";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorRed";
	"taskMarker_B" setMarkerAlpha 1;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "attack", "taskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname