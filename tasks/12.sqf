// =========================================================================================================
// TASK ID : 			12
// TASK OBJECTIVE :		REPATRIATE BODIES
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
	body_1 = nil;
	body_2 = nil;
	body_3 = nil;
	body_4 = nil;
	body_5 = nil;

// =========================================================================================================
// DEFINING MAIN TASK POSITION
// =========================================================================================================

	// LOOKING FOR A LOCATION
	private _locationPos = [["industry", "military", "isolated"], OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_locationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING LOCATION SIZE
	private _locationArea = [((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _locationSize = (_locationArea select 0) max (_locationArea select 1);
	private _locationAngle = (triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 2;

	// LOOKING FOR AN EMPTY MAIN POSITION
	private _emptyPos = ["land", _locationPos, 0, ((_locationArea select 0) min (_locationArea select 1)) * 0.70, 5] call Gemini_fnc_findPos;
	if (_emptyPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// LOOKING FOR 5 EMPTY POSITIONS NEARBY MAIN ONE
	private _pos1 = ["land", _emptyPos, 0, 5, 1.5] call Gemini_fnc_findPos; if (_pos1 isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _pos2 = ["land", _emptyPos, 0, 5, 1.5] call Gemini_fnc_findPos; if (_pos2 isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _pos3 = ["land", _emptyPos, 0, 5, 1.5] call Gemini_fnc_findPos; if (_pos3 isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _pos4 = ["land", _emptyPos, 0, 5, 1.5] call Gemini_fnc_findPos; if (_pos4 isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _pos5 = ["land", _emptyPos, 0, 5, 1.5] call Gemini_fnc_findPos; if (_pos5 isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _locationPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _locationArea;
	"TaskMarker_A" setMarkerColor "colorOrange";
	"TaskMarker_A" setMarkerAlpha 0.75;
	"TaskMarker_A" setMarkerDir _locationAngle;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos _locationPos;
	"TaskMarker_B" setMarkerType "mil_pickup";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorOrange";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "move", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["sad"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING BODIES
	private _friendlyUnitTypes = [OPEX_friendly_rifleman, OPEX_friendly_grenadier, OPEX_friendly_MGLight, OPEX_friendly_MGHeavy, OPEX_friendly_AT, OPEX_friendly_scout, OPEX_friendly_medic, OPEX_friendly_repairer, OPEX_friendly_ammoAssistant, OPEX_friendly_assault];
	private _bodies = [];
	for "_i" from 1 to 5 do
		{
			private _friendlyUnitType = selectRandom _friendlyUnitTypes;
			private _body = [OPEX_friendly_side1, grpNull, [_friendlyUnitType], _emptyPos, OPEX_enemy_AIskill, true, "task"] call Gemini_fnc_createUnit;
			[_body] call AIS_System_fnc_loadAIS;
			_body setVariable ["AIS_noReviveInit", true, true];
			_body setVariable ['revivable', false, true];
			_body setDir (random 360);
			removeAllWeapons _body;
			removeBackpackGlobal _body;
			removeGoggles _body;
			removeAllAssignedItems _body;
			removeAllItems _body;
			_body setDamage 1;
			_bodies pushBack _body;
		};
	body_1 = _bodies select 0; body_1 setPos _pos1;
	body_2 = _bodies select 1; body_2 setPos _pos2;
	body_3 = _bodies select 2; body_3 setPos _pos3;
	body_4 = _bodies select 3; body_4 setPos _pos4;
	body_5 = _bodies select 4; body_5 setPos _pos5;
	_bodies spawn
			{
				private _bodies = _this;
				sleep 3;
				{
					removeAllWeapons _x;
					removeBackpackGlobal _x;
					if (random 1 > 0.5) then {removeHeadgear _x};
					removeGoggles _x;
					removeAllAssignedItems _x;
					removeAllItems _x;
					_weapons = nearestObjects [_x, ["WeaponHolderSimulated"], 5];
					for "_i" from 0 to (count _weapons - 1) do {deleteVehicle (_weapons select _i)};
				} forEach _bodies;
			};

	// SPAWNING AMBIENT OBJECTS
	private _lightSource = [["MetalBarrel_burning_F", "Land_MetalBarrel_empty_F"], ["land", _emptyPos, 5, 10, 1] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle; _lightSource setVectorUp (surfaceNormal (position _lightSource));
	if (isClass (configFile >> "CfgPatches" >> "CUP_Worlds")) then {private _camera = ["Camera1", ["land", _emptyPos, 5, 10, 1] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle; _camera setVectorUp (surfaceNormal (position _camera)); _camera setDir (_camera getDir _emptyPos)};
	private _cart = [["Land_WoodenCart_F", "Land_WheelCart_F"], ["land", _emptyPos, 5, 10, 3] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle; _cart setVectorUp (surfaceNormal (position _cart));

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	sleep 1;
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _locationPos, _locationSize, [OPEX_enemy_rifleman, selectRandom [1,2,3]], 65, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,4,5], _lightSource, [2, 20], "talk", _lightSource, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[_emptyPos, _locationSize * 0.75, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;
	[_locationPos, _locationSize * 0.75, selectRandom [3,4,5], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _emptyPos, [50, 200], "patrol", _emptyPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF BODIES HAVE BEEN REPATRIETED TO THE MEDICAL CENTER
	[
		_emptyPos,
		[0, 0, 0, false],
		["any", "present", false],
		["(OPEX_assignedTask) && (body_1 distance (getMarkerPos 'OPEX_marker_medical') < 50) && (body_2 distance (getMarkerPos 'OPEX_marker_medical') < 50) && (body_3 distance (getMarkerPos 'OPEX_marker_medical') < 50) && (body_4 distance (getMarkerPos 'OPEX_marker_medical') < 50) && (body_5 distance (getMarkerPos 'OPEX_marker_medical') < 50)",
			"[] remoteExec ['Gemini_fnc_taskSucceeded']; ['support', 'random'] remoteExecCall ['Gemini_fnc_bonus', 2]; ['supply', 'random'] call Gemini_fnc_bonus",
			""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// FAILING TASK IF A BODY IS DESTROYED
	[
		_emptyPos,
		[0, 0, 0, false],
		["any", "present", false],
		["(OPEX_assignedTask) && ((isNull body_1) || (isNull body_2) || (isNull body_3) || (isNull body_4) || (isNull body_5))", "[] remoteExec ['Gemini_fnc_taskFailed']", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {[body_1, "mil_objective", "colorRed", "BODIES", "task"] call Gemini_fnc_createMarker};
	// {_x setPos getPos player} forEach [body_1, body_2, body_3, body_4, body_5];