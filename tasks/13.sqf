// =========================================================================================================
// TASK ID : 			13
// TASK OBJECTIVE :		INSTALL A SPY MICROPHONE
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
// DEFINING TASK POSITION
// =========================================================================================================

	// LOOKING FOR AN RANDOM LOCATION
	private _locationPos = [["city", "village"], OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_locationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING LOCATION SIZE
	private _locationArea = [((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _locationSize = (_locationArea select 0) min (_locationArea select 1);

	// LOOKING FOR A RANDOM BUILDING
	private _buildingPos = ["building", _locationPos, 0, _locationSize] call Gemini_fnc_findPos;
	if (_buildingPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _building = nearestBuilding _buildingPos;

// =========================================================================================================
// CREATING MARKER
// =========================================================================================================

	// MARKER TYPE & TEXT
	"TaskMarker_A" setMarkerPos (position _building);
	"TaskMarker_A" setMarkerType "mil_objective";
	"TaskMarker_A" setMarkerSize [1,1];
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 1;
	["TaskMarker_A", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "interact", "taskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["stealth"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// DEFINING A FUNCTION TO CHECK IF UNIT HAS A MICRO
	fnc_hasMicro =
		{
			private _unit = _this;
			private _result = false;
			if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then {if ("Gemini_spyMicro" in ((uniformItems _unit) + (backpackItems _unit) + (vestItems _unit))) then {_result = true}} else {_result = true};
			_result
		};

	// ADDING ACTION TO BUILDING
	spotted = false;
	microInstallation = 0; publicVariable "microInstallation";
	/*
	[
		_building, // Object the action is attached to
		localize "STR_action_installSpyMicro", // Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
		"(OPEX_taskID == '13') && ((position _this) call Gemini_fnc_isInsideBuilding) && (!spotted) && (_this call fnc_hasMicro) && (microInstallation < 24)", // Condition for the action to be shown
		"(OPEX_taskID == '13') && ((position _this) call Gemini_fnc_isInsideBuilding) && (!spotted) && (_this call fnc_hasMicro) && (microInstallation < 24)", // Condition for the action to progress
		{hint localize "STR_hint_installSpyMicroStart"; (_this select 1) playActionNow "Gear"}, // Code executed when action starts
		{microInstallation = microInstallation + 1; publicVariable "microInstallation"; (_this select 1) playActionNow "Gear"}, // Code executed on every progress tick
		{hint localize "STR_hint_installSpyMicroDone"; if ((_this select 1) call (_this select 3 select 0)) then {(_this select 1) removeItem "Gemini_spyMicro"}; sleep 3; if (!spotted) then {hint localize "STR_hint_leaveAreaStealth"}}, // Code executed on completion
		{if (microInstallation >= 24) then {hint localize "STR_hint_installSpyMicroDone"; if ((_this select 1) call (_this select 3 select 0)) then {(_this select 1) removeItem "Gemini_spyMicro"}; sleep 3; if (!spotted) then {hint localize "STR_hint_leaveAreaStealth"}}},	// Code executed on interrupted
		[],	// Arguments passed to the scripts as _this select 3
		12, // Action duration [s]
		10, // Priority
		true, // Remove on completion
		false // Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _building]; // MP compatible implementation
	*/
	[
		_building,
		["STR_action_installSpyMicro", "white"],
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"(OPEX_taskID == '13') && ((position _this) call Gemini_fnc_isInsideBuilding) && (!spotted) && (_this call fnc_hasMicro) && (microInstallation < 24)", "(OPEX_taskID == '13') && ((position _this) call Gemini_fnc_isInsideBuilding) && (!spotted) && (_this call fnc_hasMicro) && (microInstallation < 24)",
		{hint localize "STR_hint_installSpyMicroStart"; (_this select 1) playActionNow "Gear"}, {microInstallation = microInstallation + 1; publicVariable "microInstallation"; (_this select 1) playActionNow "Gear"},
		{hint localize "STR_hint_installSpyMicroDone"; if ((_this select 1) call (_this select 3 select 0)) then {(_this select 1) removeItem "Gemini_spyMicro"}; sleep 3; if (!spotted) then {hint localize "STR_hint_leaveAreaStealth"}},
		{if (microInstallation >= 24) then {hint localize "STR_hint_installSpyMicroDone"; if ((_this select 1) call (_this select 3 select 0)) then {(_this select 1) removeItem "Gemini_spyMicro"}; sleep 3; if (!spotted) then {hint localize "STR_hint_leaveAreaStealth"}}},
		[],
		12,
		10,
		true, false, true
	] remoteExec ["Gemini_fnc_holdActionAdd", 0, _building];

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	if (random 100 > 50)
		then {[OPEX_enemy_side1, ["infantry"], selectRandom [0,2,2,3,3], _building, [10, 50], "talk", _building, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad}
		else {[_building, 150, selectRandom [0,1,1,2,2], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside};
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _building, [50, 100], "patrol", _building, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,8], _building, [250, 500], "patrol", _building, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// CHECKING IF FRIENDS ARE NERABY THE BUILDING
	friendsNearby = false;
	[
		_building,
		[150, 150, 0, false],
		[OPEX_friendly_side3, "present", true],
		["OPEX_assignedTask && this", "friendsNearby = true", "friendsNearby = false"],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

	// SUCCEEDING TASK IF DEVICE IS INSTALLED && IF NO FRIENDS HAVE BEEN SPOTTED NEABY THE BUILDING && IF NOT FRIENDLY UNITS ARE NEARBY THE BUILDING
	[
		_building,
		[0, 0, 0, false],
		["any", "present", false],
		["OPEX_assignedTask && (microInstallation >= 24) && !spotted && !friendsNearby", "[] remoteExec ['Gemini_fnc_taskSucceeded']; ['intel', 100] call Gemini_fnc_bonus", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// FAILING TASK IF FRIENDS ARE SPOTTED NEARBY THE BUILDING
	[
		_building,
		[150, 150, 0, false],
		[OPEX_friendly_side3, OPEX_triggerDetectedByEnemy, false],
		["OPEX_assignedTask && this", "spotted = true; publicVariable 'spotted'; [] remoteExec ['Gemini_fnc_taskFailed']", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;