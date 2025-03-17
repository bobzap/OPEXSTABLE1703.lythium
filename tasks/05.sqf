// =========================================================================================================
// TASK ID : 			05
// TASK OBJECTIVE :		FREE A HOSTAGE
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

	// LOOKING FOR AN ISOLATED LOCATION
	private _locationPos = ["isolated", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_locationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING LOCATION SIZE
	private _locationArea = [((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _locationSize = (_locationArea select 0) max (_locationArea select 1);

	// LOOKING FOR A BUILDING
	private _buildingPos = ["building", _locationPos, 0, (_locationArea select 0) min (_locationArea select 1)] call Gemini_fnc_findPos;
	if (_buildingPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _building = nearestBuilding _buildingPos;

	// LOOKING FOR A POSITION INSIDE FOUND BUILDING
	private _buildingPosList = [_building] call BIS_fnc_buildingPositions;
	{if (!(_x call Gemini_fnc_isInsideBuilding)) then {_buildingPosList = _buildingPosList - [_x]}} forEach _buildingPosList;
	private ["_reporterPos"];
	if (count _buildingPosList > 0) then {_reporterPos = selectRandom _buildingPosList} else {_reporterPos = ["land", _buildingPos, 1, 25] call Gemini_fnc_findPos};
	if (isNil "_buildingPos") exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING REPORTER
	private _reporter = [OPEX_friendly_side1, grpNull, OPEX_civilian_reporters, _reporterPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	reporter = _reporter;
	_reporter disableAI "move";
	_reporter disableAI "autoTarget";
	_reporter setCaptive true;
	_reporter allowDamage false;
	_reporter switchMove (selectRandom ["Acts_AidlPsitMstpSsurWnonDnon01", "Acts_ExecutionVictim_Loop"]);
	//_reporter setVariable ["VIP", true, true];
	//[_reporter, "STR_action_rescue", "scripts\Gemini\fnc_enlist.sqf", false, 1.5, "(_target distance _this < 3) && (!captive _this)"] remoteExec ["Gemini_fnc_addAction", 0, _reporter];

	// ADDING ACTION TO FREE REPORTER
	/*
	[
		_reporter, // Object the action is attached to
		localize "STR_action_rescue", // Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", // Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", // Progress icon shown on screen
		"(_target distance _this < 5) && (alive _target) && (captive _target)", // Condition for the action to be shown
		"(_target distance _this < 5) && (alive _target) && (captive _target)", // Condition for the action to progress
		{}, // Code executed when action starts
		{}, // Code executed on every progress tick
		{(_this select 3 select 0) say3D "cabletie_cut"; sleep 0.5; [_this select 3 select 0] join (createGroup OPEX_friendly_side1); (_this select 3 select 0) setCaptive false; (_this select 3 select 0) switchMove ""; (_this select 3 select 0) enableAI "move"; (_this select 3 select 0) enableAI "autoTarget"}, // Code executed on completion
		{}, // Code executed on interrupted
		[_reporter],	// Arguments passed to the scripts as _this select 3
		1.5, // Action duration [s]
		10, // Priority
		true, // Remove on completion
		false // Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _reporter]; // MP compatible implementation
	*/
	[
		_reporter,
		["STR_action_rescue", "white"],
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
		"(_target distance _this < 5) && (alive _target) && (captive _target)", "(_target distance _this < 5) && (alive _target) && (captive _target)",
		{}, {},
		{(_this select 3 select 0) say3D "cabletie_cut"; sleep 0.5; [_this select 3 select 0] join (createGroup OPEX_friendly_side1); (_this select 3 select 0) setCaptive false; (_this select 3 select 0) switchMove ""; (_this select 3 select 0) enableAI "move"; (_this select 3 select 0) enableAI "autoTarget"},
		{},
		[_reporter],
		1.5,
		10,
		false, false, false
	] remoteExec ["Gemini_fnc_holdActionAdd", 0, _reporter];

	// IF FRIENDS ARE SPOTTED, ENEMIES CAN KILL THE REPORTER
	private _trigger =
		[
			getPos reporter,
			[150, 150, 0, false],
			[OPEX_friendly_side3, OPEX_enemy_detection, true],
			["this", "[reporter] join (createGroup OPEX_friendly_side1); reporter setCaptive false", ""],
			[0, 50, 100, false],
			"task"
		] call Gemini_fnc_createTrigger;

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _buildingPos, 100, [OPEX_enemy_units, ceil (random 3)], 20, "task"] call Gemini_fnc_spawnVehicle;
	[_buildingPos, 50, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;
	[_buildingPos, 20, selectRandom [1,2,3], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,4,5], _buildingPos, [10, 40], "talk", _buildingPos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [1,2], _buildingPos, [15, 75], "patrol", _buildingPos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	for "_i" from 1 to 2 do {[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _buildingPos, [100, 250], "patrol", _buildingPos, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// SLIGHTLY MOVING MARKER
	private _markerPos = _locationPos;

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _markerPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _locationArea;
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos _markerPos;
	"taskMarker_B" setMarkerType "mil_pickup";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorRed";
	"taskMarker_B" setMarkerAlpha 1;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED WHEN REPORTER IS BACK AT HQ
	_reporter spawn
		{
			private _reporter = _this;
			while {OPEX_assignedTask && (alive _reporter)} do
				{
					sleep 3;
					if (OPEX_assignedTask && (alive _reporter) && (_reporter call Gemini_fnc_isInSafeLocation)) then
					{
						[] remoteExec ["Gemini_fnc_taskSucceeded"];
						["reputation", 0.05] call Gemini_fnc_bonus;
						_reporter removeAllMPEventHandlers "MPkilled";
						sleep 3;
						waitUntil {sleep 1; (speed (vehicle _reporter) < 1)};
						[_reporter] join GrpNull;
						if (vehicle _reporter != _reporter) then {_reporter allowGetIn false; unassignVehicle _reporter; sleep 1; _reporter setPos (_reporter getPos [3, random 360])};
						(group _reporter) addWaypoint [selectRandom OPEX_locations_safe, 100];
						[group _reporter, 1] setWaypointSpeed "limited";
						[group _reporter, 1] setWaypointBehaviour "safe";
						[group _reporter, 1] setWaypointType "dismiss";
					};
				};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF REPORTER IS DEAD
	_reporter addMPEventHandler ["MPkilled", {[] spawn Gemini_fnc_taskFailed; reporter = nil; publicVariable "reporter"}];
	_reporter allowDamage true;

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "target", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["stealth"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {[_reporter, "mil_warning", "ColorBlue", "HOSTAGE", "task"] call Gemini_fnc_createMarker};