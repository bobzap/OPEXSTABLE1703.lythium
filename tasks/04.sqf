// =========================================================================================================
// TASK ID : 			04
// TASK OBJECTIVE :		PATROL AN AREA
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
// =========================================================================================================s

	// GETTING A RANDOM POSITION
	private _mainPos = ["land", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_mainPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _taskRadius = 1000;

	// SEARCHING FOR 5 RANDOM POSITIONS, AROUND THE ABOVE ONE
	private _patrolPos1 = ["land", _mainPos, 0, _taskRadius / 5] call Gemini_fnc_findPos;
	private _patrolPos2 = ["land", _mainPos, _taskRadius / 5, _taskRadius / 2.5] call Gemini_fnc_findPos;
	private _patrolPos3 = ["land", _mainPos, _taskRadius / 2.5, _taskRadius / 1.66] call Gemini_fnc_findPos;
	private _patrolPos4 = ["land", _mainPos, _taskRadius / 1.66, _taskRadius / 1.25] call Gemini_fnc_findPos;
	private _patrolPos5 = ["land", _mainPos, _taskRadius / 1.25, _taskRadius] call Gemini_fnc_findPos;
	if ((_patrolPos1 isEqualTo [0,0,0]) || (_patrolPos2 isEqualTo [0,0,0]) || (_patrolPos3 isEqualTo [0,0,0]) || (_patrolPos4 isEqualTo [0,0,0]) || (_patrolPos5 isEqualTo [0,0,0])) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// CREATING TRIGGER 1
	checkpoint1_cleared = false;
	private _trigger1 =
		[
			_patrolPos1,
			[15, 15, 0, false],
			[OPEX_friendly_side3, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;
	_trigger1 setTriggerStatements ["{this && OPEX_assignedTask && (((getPos _x) select 2) < 3)} forEach thisList", "checkpoint1_cleared = true; 'taskMarker_A' setMarkerColor 'colorGreen'", ""];

	// CREATING TRIGGER 2
	checkpoint2_cleared = false;
	private _trigger2 =
		[
			_patrolPos2,
			[15, 15, 0, false],
			[OPEX_friendly_side3, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;
	_trigger2 setTriggerStatements ["{this && OPEX_assignedTask && (((getPos _x) select 2) < 3)} forEach thisList", "checkpoint2_cleared = true; 'taskMarker_B' setMarkerColor 'colorGreen'", ""];

	// CREATING TRIGGER 3
	checkpoint3_cleared = false;
	private _trigger3 =
		[
			_patrolPos3,
			[15, 15, 0, false],
			[OPEX_friendly_side3, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;
	_trigger3 setTriggerStatements ["{this && OPEX_assignedTask && (((getPos _x) select 2) < 3)} forEach thisList", "checkpoint3_cleared = true; 'taskMarker_C' setMarkerColor 'colorGreen'", ""];

	// CREATING TRIGGER 4
	checkpoint4_cleared = false;
	private _trigger4 =
		[
			_patrolPos4,
			[15, 15, 0, false],
			[OPEX_friendly_side3, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;
	_trigger4 setTriggerStatements ["{this && OPEX_assignedTask && (((getPos _x) select 2) < 3)} forEach thisList", "checkpoint4_cleared = true; 'taskMarker_D' setMarkerColor 'colorGreen'", ""];

	// CREATING TRIGGER 5
	checkpoint5_cleared = false;
	private _trigger5 =
		[
			_patrolPos5,
			[15, 15, 0, false],
			[OPEX_friendly_side3, "present", false],
			["", "", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;
	_trigger5 setTriggerStatements ["{this && OPEX_assignedTask && (((getPos _x) select 2) < 3)} forEach thisList", "checkpoint5_cleared = true; 'taskMarker_E' setMarkerColor 'colorGreen'", ""];

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	{
		[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _x, _taskRadius / 6, [OPEX_enemy_units, selectRandom [2,3,4,5]], 5, "task"] call Gemini_fnc_spawnVehicle;
		[OPEX_enemy_side1, ["infantry"], -1, _x, _taskRadius / 6, "patrol", _x, OPEX_enemy_AIskill, 10, "task"] call Gemini_fnc_spawnSquad;
		if (random 100 > 90) then {[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _x, _taskRadius / 6, "talk", _x, OPEX_enemy_AIskill, 10, "task"] call Gemini_fnc_spawnSquad};
		if (random 100 > 90) then {[_x, _taskRadius / 6, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside};
	} forEach [_patrolPos1, _patrolPos2, _patrolPos3, _patrolPos4, _patrolPos5];

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// POSITION 1
	"taskMarker_A" setMarkerPos (position _trigger1);
	"taskMarker_A" setMarkerSize [1,1];
	"taskMarker_A" setMarkerType "mil_unknown";
	"taskMarker_A" setMarkerColor "colorBlack";
	"taskMarker_A" setMarkerAlpha 1;
	"taskMarker_A" setMarkerText "Alpha";

	// POSITION 2
	"taskMarker_B" setMarkerPos (position _trigger2);
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerType "mil_unknown";
	"taskMarker_B" setMarkerColor "colorBlack";
	"taskMarker_B" setMarkerAlpha 1;
	"taskMarker_B" setMarkerText "Bravo";

	// POSITION 3
	"taskMarker_C" setMarkerPos (position _trigger3);
	"taskMarker_C" setMarkerSize [1,1];
	"taskMarker_C" setMarkerType "mil_unknown";
	"taskMarker_C" setMarkerColor "colorBlack";
	"taskMarker_C" setMarkerAlpha 1;
	"taskMarker_C" setMarkerText "Charlie";

	// POSITION 4
	"taskMarker_D" setMarkerPos (position _trigger4);
	"taskMarker_D" setMarkerSize [1,1];
	"taskMarker_D" setMarkerType "mil_unknown";
	"taskMarker_D" setMarkerColor "colorBlack";
	"taskMarker_D" setMarkerAlpha 1;
	"taskMarker_D" setMarkerText "Delta";

	// POSITION 5
	"taskMarker_E" setMarkerPos (position _trigger5);
	"taskMarker_E" setMarkerSize [1,1];
	"taskMarker_E" setMarkerType "mil_unknown";
	"taskMarker_E" setMarkerColor "colorBlack";
	"taskMarker_E" setMarkerAlpha 1;
	"taskMarker_E" setMarkerText "Echo";

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED IF ALL CHECKPOINTS HAVE BEEN REACHED
	[] spawn
		{
			while {OPEX_assignedTask} do
				{
					sleep 3;
					if (OPEX_assignedTask && checkpoint1_cleared && checkpoint2_cleared && checkpoint3_cleared && checkpoint4_cleared && checkpoint5_cleared) then {[] remoteExec ["Gemini_fnc_taskSucceeded"]};
				};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF ...
	// there is no way to fail this task

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "walk", nil] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname