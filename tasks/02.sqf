// =========================================================================================================
// TASK ID : 			02
// TASK OBJECTIVE :		SEARCH AND DESTROY AN ENEMY MORTAR
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

	// LOOKING FOR A RANDOM POSITION TO SPAWN THE MORTAR
	private _mortarPos = ["land_isolated", OPEX_mapCenter, 0, OPEX_mapRadius * 0.9, 7.5] call Gemini_fnc_findPos;
	if (_mortarPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING MORTAR AND CUSTOM COMPOSITION
	private _mortarType = selectRandom OPEX_enemy_mortarStatics;
	private _composition =
		[
			[_mortarType,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false],
			["Land_BagFence_Long_F",[-2.79932,0.905762,-0.000999928],307,1,0,[0,0],"","",true,false],
			["Land_BagFence_Long_F",[3.10498,0.840332,-0.000999928],229,1,0,[0,0],"","",true,false],
			["Land_BagFence_Round_F",[0.015625,3.65674,-0.00130129],177,1,0,[0,-0],"","",true,false],
			["Land_BagFence_Long_F",[-1.33691,-4.22803,-0.000999928],0,1,0,[0,0],"","",true,false],
			["Land_BagFence_Long_F",[1.75488,-4.22314,-0.000999928],0,1,0,[0,0],"","",true,false],
			["Land_BagFence_Short_F",[-3.50098,-3.51709,-0.000999928],45,1,0,[0,0],"","",true,false],
			["Land_BagFence_Short_F",[3.97412,-3.646,-0.000999928],306,1,0,[0,0],"","",true,false],
			["Land_WoodenBox_F",[-1.95557,-5.19385,0],179,1,0,[0,-0],"","",true,false],
			["Land_WoodPile_F",[1.43164,-5.33154,0],101,1,0,[0,-0],"","",true,false],
			["Land_CanisterPlastic_F",[4.59814,-3.9292,0],29,1,0,[0,0],"","",true,false],
			["Land_Shovel_F",[3.14258,-5.37354,0],25,1,0,[0,0],"","",true,false]
		];
	0 = [_mortarPos, random 360, _composition] call BIS_fnc_ObjectsMapper;
	{[_x, "task"] call Gemini_fnc_setLifeTime} forEach (nearestObjects [_mortarPos, ["all"], 50]);
	private _mortar = _mortarPos nearestObject _mortarType;
	[_mortar, OPEX_enemy_side1, 25] spawn Gemini_fnc_boardVehicleIfDanger;
	private _clutterCutter = ["Land_ClutterCutter_large_F", _mortarPos, random 360, true, "task"] call Gemini_fnc_createVehicle;

	// SPAWNING SMALL CAMP NEARBY MORTAR
	private _campPos = ["land", _mortarPos, 15, 75, 2] call Gemini_fnc_findPos;
	private "_lightSource";
	if ((!(_campPos isEqualTo [0,0,0])) && (count (_campPos nearRoads 25) == 0)) then
		{
			_lightSource = [["Campfire_burning_F"], _campPos, random 360, true, "task"] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource, random 360, true, "task"] call Gemini_fnc_createVehicle;
			for "_i" from 1 to (selectRandom [2,3,4,5]) do {private _tent = [["Land_TentA_F", "Land_TentDome_F"], ["land", _lightSource, 1, 15, 4] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _tent, random 360, true, "task"] call Gemini_fnc_createVehicle};
			for "_i" from 1 to (selectRandom [0,1,2,3]) do {private _sleepingBag = [["Land_Sleeping_bag_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_brown_F"], ["land", _lightSource, 1, 20, 1] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _sleepingBag, random 360, true, "task"] call Gemini_fnc_createVehicle};
			for "_i" from 1 to (selectRandom [1,2,3]) do {private _woodPile = [["Land_WoodenLog_F", "Land_WoodPile_F"], ["land", _lightSource, 1, 10, 2] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle};
			for "_i" from 1 to 5 do {private _food = [["Land_CanisterPlastic_F", "Land_BottlePlastic_V1_F", "Land_BottlePlastic_V2_F", "Land_RiceBox_F", "Land_BakedBeans_F", "Land_Canteen_F"], ["land", _lightSource, 2, 10, 1] call Gemini_fnc_findPos, random 360, true, "task"] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _food, random 360, true, "task"] call Gemini_fnc_createVehicle};
		};

	// ADJUSTING ITEMS ON TERRAIN
	{
		_x setVectorUp (surfaceNormal (position _x));
		_x setPosATL [(getPos _x) select 0, (getPos _x) select 1, 0];
	} forEach (nearestObjects [_mortar, ["all"], 100]);

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// CREATING DEFENSE VEHICLE
	if (!isNil "_lightSource") then {[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _lightSource, [15,60], [OPEX_enemy_units, selectRandom [0,1]], 50, "task"] call Gemini_fnc_spawnVehicle};

	// SPAWNING ENEMIES NEXT TO THE MORTAR
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,2,3], _mortar, [1,5], "wait", objNull, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	{_x setPos (_mortar getRelPos [0.5 + random 3, random 360])} forEach (_mortar nearEntities ["Man", 15]);

	// SPAWNING ENEMIES NEXT TO THE CAMP
	if (!isNil "_lightSource") then {[OPEX_enemy_side1, ["infantry"], selectRandom [1,2,3], _lightSource, [2,6], "wait", _lightSource, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad};
	if (!isNil "_lightSource") then {[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _lightSource, [10,25], "talk", _lightSource, OPEX_enemy_AIskill, 85, "task"] call Gemini_fnc_spawnSquad};

	// SPAWNING ENEMY PATROL(S) AROUND THE MORTAR
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _mortar, [50,300], "patrol", _mortar, OPEX_enemy_AIskill, 85, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// RANDOMLY MOVING MARKER AROUND THE MORTAR
	private _markerPos = [(_mortarPos select 0) + random 300 - random 300, (_mortarPos select 1) + random 300 - random 300];

	// MARKER AREA
	"taskMarker_A" setMarkerPos _markerPos;
	"taskMarker_A" setMarkerShape "ellipse";
	"taskMarker_A" setMarkerBrush "FDiagonal";
	"taskMarker_A" setMarkerSize [500,500];
	"taskMarker_A" setMarkerColor "colorOrange";
	"taskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos _markerPos;
	"taskMarker_B" setMarkerType "mil_unknown";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorOrange";
	"taskMarker_B" setMarkerAlpha 1;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED IF MORTAR IS DESTROYED
	_mortar spawn
		{
			private _mortar = _this;
			while {alive _mortar && OPEX_assignedTask} do {sleep 5};
			if (OPEX_assignedTask && (!alive _mortar)) then
				{
					[] remoteExec ["Gemini_fnc_taskSucceeded"];
				};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF...
	// there is no way to fail this task

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "destroy", "taskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {[_mortar, "mil_warning", "ColorRed", "MORTAR", "task"] call Gemini_fnc_createMarker};