// =========================================================================================================
// TASK ID : 			19
// TASK OBJECTIVE :		FIND AND ATTACK A CAMP (PLAYER HAS TO INTERROGATE CIVILIANS TO GET INFORMATION ABOUT ITS POSITION)
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

	private _campRadius = 75;

	// LOOKING FOR A FOREST
	private _campPos = ["forest", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_campPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// DEFINING POSSIBLE OBJECTS
	private _lightSources = ["Campfire_burning_F", "Campfire_burning_F", "MetalBarrel_burning_F"];
	private _tents = ["Land_TentA_F", "Land_TentA_F", "Land_TentDome_F"];
	private _sleepingBags = ["Land_Sleeping_bag_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_brown_F"];
	private _various =
		[
			"Land_WoodenLog_F", "Land_WoodPile_F", "Land_WoodPile_large_F",
			"Land_WoodenBox_f", "Land_CratesPlastic_F", "Land_WoodenCrate_01_F",
			"Land_Sack_F", "Land_Sacks_heap_F", "Land_Sacks_goods_F", "Land_Cages_F", "Land_CratesShabby_F",
			"Land_BarrelWater_F", "Land_BarrelWater_grey_F", "Land_MetalBarrel_F",
			"Land_WoodenCart_F",
			"Land_CanisterPlastic_F",
			"Land_Garbage_square3_F", "Land_Garbage_square5_F", "Land_Garbage_line_F", "Land_JunkPile_F",
			"Land_Axe_F"
		];

	// SPAWNING CAMP
	private _lightSource = [_lightSources, ["land_isolated", _campPos, 1, 25, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource, random 360, true, "task"] call Gemini_fnc_createVehicle;
	private _lightSource2 = [_lightSources, ["land_isolated", _lightSource, 15, _campRadius, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource, random 360, true, "task"] call Gemini_fnc_createVehicle;
	private _lightSource3 = [_lightSources, ["land_isolated", _lightSource, 15, _campRadius, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource, random 360, true, "task"] call Gemini_fnc_createVehicle;
	for "_i" from 1 to 8 do {private _tent = [_tents, ["land_isolated", _lightSource, 1, _campRadius, 5] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _tent, random 360, true, "task"] call Gemini_fnc_createVehicle};
	for "_i" from 1 to 4 do {private _sleepingBag = [_sleepingBags, ["land_isolated", _lightSource, 1, 15, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _sleepingBag, random 360, true, "task"] call Gemini_fnc_createVehicle};
	for "_i" from 1 to 12 do {private _other = [_various, ["land_isolated", _lightSource, 1, _campRadius, 3] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle};
	{_x setVectorUp (surfaceNormal (position _x)); _x setPosATL [(getPos _x select 0), (getPos _x select 1), 0]} forEach (nearestObjects [_lightSource, ["all"], _campRadius * 1.5]);

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _lightSource, [0, _campRadius], "talk", _lightSource, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,4,5,6], _lightSource, [0, _campRadius], "wait", _lightSource, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _lightSource, [0, _campRadius * 3], "patrol", _lightSource, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5], _lightSource, [0, _campRadius * 10], "patrol", _lightSource, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _lightSource;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize [100,100];
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0;

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos _lightSource;
	"taskMarker_B" setMarkerType "mil_unknown";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorRed";
	"taskMarker_B" setMarkerAlpha 0;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF COMPOUND IS FOUND
	[
		_lightSource,
		[100, 100, 0, false],
		[OPEX_enemy_side2, OPEX_triggerDetectedByFriend, false],
		["OPEX_assignedTask && this", "[] remoteExec ['Gemini_fnc_taskSucceeded']", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "move", "OPEX_marker_camp"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {[_lightSource, "mil_objective", "colorRed", "CAMP", "task"] call Gemini_fnc_createMarker; player setUnitTrait ["interpret", true, true]};