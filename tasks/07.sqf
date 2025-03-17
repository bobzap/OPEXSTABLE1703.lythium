// =========================================================================================================
// TASK ID : 			07
// TASK OBJECTIVE :		DEFEND A VILLAGE
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
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos [(_villagePos select 0), (_villagePos select 1) - 25];
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _villageArea;
	"TaskMarker_A" setMarkerColor "colorOrange";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos [(_villagePos select 0), (_villagePos select 1) - 25];
	"TaskMarker_B" setMarkerType "mil_objective";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorOrange";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "defend", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// WAITING UNTIL A PLAYER IS ARRIVED TO THE VILLAGE (OR UNTIL TASK IS CANCELED)
	while {({_villagePos distance _x < _villageSize} count (playableUnits + switchableUnits) == 0) && (OPEX_assignedTask)} do {sleep 5};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	attackingEnemies = [];
	if (OPEX_assignedTask) then
		{
			for "_i" from 1 to (selectRandom [3,3,3]) do
				{

					// LOOKING FOR A RANDOM POS
					private _squadPos = ["land", _villagePos, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi] call Gemini_fnc_findPos;
					if (!(_squadPos isEqualTo [0,0,0])) then
						{
							for "_i" from 1 to (selectRandom [1,1,2,2,3,4,5]) do
								{
									// SPAWNING SQUAD
									private _squad = [OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], -1, _squadPos, 50, "attack", _villagePos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
									if ((leader _squad) distance2D _villagePos <= 500) then {_squad setSpeedMode "limited"};
									if (((leader _squad) distance2D _villagePos > 500) && ((leader _squad) distance2D _villagePos <= 1000)) then {_squad setSpeedMode "normal"};
									if ((leader _squad) distance2D _villagePos > 1000) then {_squad setSpeedMode "full"};
									_squad setCombatMode "red";

									// UPDATING ALIVE ENEMIES ARRAY
									{attackingEnemies append [_x]} forEach (units _squad);
								};

								// CREATIING A MARKER TO INFORM PLAYER ABOUT THE ENEMY
								private _trigger = (_villagePos nearObjects ["EmptyDetector", 5]) select 0;
								private _spottedEnemies = [_squadPos, "mil_arrow", "colorRed", "", "task"] call Gemini_fnc_createMarker;
								_spottedEnemies setMarkerSize [1.5,1.5];
								_spottedEnemies setMarkerAlpha 1;
								[_spottedEnemies, "STR_marker_hostileMovements"] remoteExec ["Gemini_fnc_setMarkerText"];
								private _azimuth = ([_trigger, _squadPos] call BIS_fnc_relativeDirTo) + 180;
								_spottedEnemies setMarkerDir _azimuth;
						};
				};
		};
	if ((OPEX_assignedTask) && (count attackingEnemies > 0)) then {[OPEX_friendly_side1, "Base", "STR_radio_hostileMovements"] remoteExec ["Gemini_fnc_sideChat"]};

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED IF PLAYERS ARE IN THE VILLAGE AND ENEMIES ARE NOT
	while {(OPEX_assignedTask) && (count (attackingEnemies select {(speed _x != 0) && (alive _x)}) > 0) && ([_villagePos, _villageSize] call Gemini_fnc_isFriendNearby)} do {sleep 5};
	if (OPEX_assignedTask && (count (attackingEnemies select {(speed _x != 0) && (alive _x)}) == 0) && ([_villagePos, _villageSize] call Gemini_fnc_isFriendNearby)) then {[] remoteExec ["Gemini_fnc_taskSucceeded"]; ["reputation", 0.5] call Gemini_fnc_bonus};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF ENEMIES ARE IN THE VILLAGE AND PLAYERS ARE NOT
	if (OPEX_assignedTask && (count (attackingEnemies select {(speed _x != 0) && (alive _x)}) > 0) && (!([_villagePos, _villageSize] call Gemini_fnc_isFriendNearby)) && ({(_x distance2D _villagePos < _villageSize) && (side _x == OPEX_enemy_side1)} count (allUnits) > 0)) then {[] remoteExec ["Gemini_fnc_taskFailed"]};