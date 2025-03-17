// =========================================================================================================
// TASK ID : 			18
// TASK OBJECTIVE :		RETRIEVE DATA FROM A CRASHED DRONE AND DESTROY THE DRONE
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

	// LOOKING FOR A RANDOM LAND POSITION
	private _crashPos = ["land_noRoad", OPEX_mapCenter, 0, OPEX_mapRadius, 10] call Gemini_fnc_findPos;
	if (_crashPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// CLEARING THE AREA IN CASE ENEMIES ARE ALREADY NEARBY
	{if ((side _x == OPEX_enemy_side1) && (_x distance _crashPos < 1000)) then {deleteVehicle _x}} forEach allUnits;

	// SPAWNING DRONE
	private _drone = [selectRandom OPEX_friendly_UAVs, _crashPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_drone setVehicleAmmoDef 0;
	_drone setVehicleAmmo 0;
	clearWeaponCargoGlobal _drone;
	clearMagazineCargoGlobal _drone;
	clearBackpackCargoGlobal _drone;
	_drone setVariable ["R3F_LOG_disabled", true, true];
	_drone allowDamage false; [_drone] spawn {sleep 5; (_this select 0) allowDamage true; (_this select 0) setDamage 0.5};
	_drone addEventHandler ["killed", {[_this select 1, 10000] remoteExec ["addRating", _this select 1, _this select 0]}]; // this line is necessary because ArmA's engines consider that destroying a friendly vehicle, even if it's empty, is bad ;)
	private _smoke = ["test_EmptyObjectForSmoke", _crashPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_smoke attachTo [_drone, [0,0,0]];

	// ADDING ACTION TO RETRIEVE DATA
	retrievedData = 0; publicVariable "retrievedData";
	/*
	[
		_drone, // Object the action is attached to
		localize "STR_action_retrieveData", // Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", // Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", // Progress icon shown on screen
		"(_target distance _this < 7) && (alive _target) && (retrievedData < 24)", // Condition for the action to be shown
		"(_target distance _this < 7) && (alive _target) && (retrievedData < 24) && ('ToolKit' in items _this)", // Condition for the action to progress
		{if (!("ToolKit" in items _caller)) then {hint localize "STR_hint_needToolkit"}}, // Code executed when action starts

		{if ("ToolKit" in items _caller) then {retrievedData = retrievedData + 1; publicVariable "retrievedData"; if (retrievedData == 24) then {hint localize "STR_hint_retrievedData"} else {hint format [localize "STR_hint_retrievingData", round (retrievedData / 24 * 100), "%"]}}}, // Code executed on every progress tick
		{}, // Code executed on completion
		{}, // Code executed on interrupted
		[],	// Arguments passed to the scripts as _this select 3
		180, // Action duration [s]
		10, // Priority
		true, // Remove on completion
		false // Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _drone]; // MP compatible implementation
	*/
	[
		_drone,
		["STR_action_retrieveData", "white"],
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
		"(_target distance _this < 7) && (alive _target) && (retrievedData < 24)", "(_target distance _this < 7) && (alive _target) && (retrievedData < 24)",
		{if (!("ToolKit" in items _caller)) then {hint localize "STR_hint_needToolkit"}}, {if ("ToolKit" in items _caller) then {retrievedData = retrievedData + 1; publicVariable "retrievedData"; if (retrievedData == 24) then {hint localize "STR_hint_retrievedData"} else {hint format [localize "STR_hint_retrievingData", round (retrievedData / 24 * 100), "%"]}}},
		{},
		{},
		[],
		180,
		10,
		true, false, true
	] remoteExec ["Gemini_fnc_holdActionAdd", 0, _drone];

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// SPAWNING PATROLS SEARCHING NEAR THE CRASH POSITION
	for "_i" from 1 to 3 do
		{
			private _squad = [OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _crashPos, [500, 1000], "patrol", _crashPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
			if (!isNil "_squad") then {_squad setSpeedMode "full"};
		};

	// SPAWNING SQUADS WHEN AT LEAST ONE PLAYER HAS REACH THE DRONE
	_crashPos spawn
		{
			waitUntil {sleep 5; {_this distance _x < 100} count (playableUnits + switchableUnits) > 0};
			for "_i" from 1 to 3 do {[OPEX_enemy_side1, ["infantry", "Infantry", "Infantry", "Infantry", "Motorized"], selectRandom [5,7,10,12,15,20], _this, [250, 1000], "attack", _this, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};
		};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// SLIGHTLY MOVING MARKER
	private _markerPos = [(_crashPos select 0) + random 50 - random 50, (_crashPos select 1) + random 50 - random 50];

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _markerPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize [150,150];
	"TaskMarker_A" setMarkerColor "colorOrange";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos _markerPos;
	"taskMarker_B" setMarkerType "mil_unknown";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorOrange";
	"taskMarker_B" setMarkerAlpha 1;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY AND DEFEAT
// =========================================================================================================

	_drone addMPEventHandler
		[
			"MPkilled",
				{
					// TASK SUCCEEDS IF DATA IS RETRIEVED BEFORE DRONE IS DESTROYED
					if (OPEX_assignedTask && (retrievedData >= 24)) then {[] spawn Gemini_fnc_taskSucceeded; ["intel", 50] call Gemini_fnc_bonus};

					// TASK FAILS IF DRONE IS DESTROYED BEFORE DATA HAVE BEEN RETRIEVED
					if (retrievedData < 24) then {[] spawn Gemini_fnc_taskFailed};
				}
		];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "move", "taskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {[_crashPos, "mil_objective", "colorRed", "DRONE", "task"] call Gemini_fnc_createMarker; drone_18 = _drone; publicVariable "drone_18"; player addItem "ToolKit"};