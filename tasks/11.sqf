// =========================================================================================================
// TASK ID : 			11
// TASK OBJECTIVE :		BRING BACK OR DESTROY AN ARMORED VEHICLE
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
	armoredVehicle = nil;

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

	// LOOKING FOR AN EMPTY POSITION INSIDE FOUND LOCATION
	private _emptyPos = ["land", _locationPos, 0, _locationSize, 15] call Gemini_fnc_findPos;
	if (_emptyPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _locationPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _locationArea;
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0.75;
	"TaskMarker_A" setMarkerDir _locationAngle;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos (getMarkerPos "TaskMarker_A");
	"TaskMarker_B" setMarkerType "mil_pickup";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorRed";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "move", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING ARMORED VEHICLE
	private _vehicleType = selectRandom OPEX_friendly_tanks;
	private _armoredVehicle = [[_vehicleType], OPEX_enemy_side1, _emptyPos, 0, [OPEX_enemy_crewman, 3], 100, "task"] call Gemini_fnc_spawnVehicle;
	armoredVehicle = _armoredVehicle;
	clearWeaponCargoGlobal _armoredVehicle; clearMagazineCargoGlobal _armoredVehicle; clearItemCargoGlobal _armoredVehicle; clearBackpackCargoGlobal _armoredVehicle;
	_armoredVehicle setPos _emptyPos;
	_armoredVehicle setFuel (random 1);
	_armoredVehicle addEventHandler ["killed", {[_this select 1, 10000] remoteExec ["addRating", _this select 1, _this select 0]}]; // this line is necessary because ArmA's engines consider that destroying a friendly vehicle, even if it's empty, is bad ;)

// =========================================================================================================
// SPAWNING AMBIENT OBJECTS
// =========================================================================================================

	// SPAWNING CAMO NET
	if ((count (nearestTerrainObjects [_emptyPos, ["House", "Tree"], 15]) == 0) && (count (_emptyPos nearRoads 15) == 0)) then
		{
			sleep 0.1;
			private _camoNet = ["CamoNet_OPFOR_open_F", _locationPos, getDir _armoredVehicle, false, "task"] call Gemini_fnc_createVehicle;
			_camoNet enableSimulationGlobal false;
			sleep 0.1;
			_camoNet setDir (getDir _camoNet + 90);
			_camoNet setPos [(getPos _armoredVehicle select 0), (getPos _armoredVehicle select 1), (getPos _armoredVehicle select 2) + 1];
			sleep 0.2;
			_camoNet setPos [(getPos _armoredVehicle select 0), (getPos _armoredVehicle select 1), (getPos _armoredVehicle select 2) + 1];
			_camoNet setVectorUp (surfaceNormal (position _camoNet));
			_camoNet allowDamage true;
		};
	if (count (_emptyPos nearRoads 15) > 0) then {[_armoredVehicle, 15] call Gemini_fnc_parkVehicle};
	sleep 0.1;

	// SPAWNING CRATES
	for "_i" from 1 to 2 do
		{
			private _crate = [["Land_CratesWooden_F", "Fort_Crate_wood", "Land_WoodenBox_F", "Land_WoodenCrate_01_F", "Land_WoodenCrate_01_stack_x3_F", "Land_WoodenCrate_01_stack_x5_F"], ["land", _armoredVehicle, 5, 25, 1] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle;
			_crate setVectorUp (surfaceNormal (position _crate));
			_crate setPos [getPos _crate select 0, getPos _crate select 1, 0];
		};

	// SPAWNING BARRELS
	for "_i" from 1 to 2 do
		{
			private _barrel = [["Land_MetalBarrel_F", "Land_CanisterPlastic_F", "Land_CanisterFuel_F"], ["land", _armoredVehicle, 5, 25, 1] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle;
			_barrel setVectorUp (surfaceNormal (position _barrel));
			_barrel setPos [getPos _barrel select 0, getPos _barrel select 1, 0];
		};

	// SPAWNING OTHERS
	for "_i" from 1 to 3 do
		{
			private _other = [["Land_Tyre_F", "Land_GasTank_01_blue_F", "Land_GasTank_01_yellow_F", "Land_GasTank_01_khaki_F", "Land_Bucket_F", "Land_Bucket_painted_F", "Land_WeldingTrolley_01_F", "Land_CanisterOil_F"], ["land", _armoredVehicle, 5, 25, 1] call Gemini_fnc_findPos, random 360, false, "task"] call Gemini_fnc_createVehicle;
			_other setVectorUp (surfaceNormal (position _other));
			_other setPos [getPos _other select 0, getPos _other select 1, 0];
		};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _locationPos, _locationSize, [OPEX_enemy_rifleman, selectRandom [1,2,3]], 75, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _emptyPos, 15, "talk", _armoredVehicle, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _locationPos, _locationSize / 2, "talk", _armoredVehicle, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[_armoredVehicle, 50, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;
	[_locationPos, _locationSize, selectRandom [2,3,5], OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _armoredVehicle, [25, 100], "patrol", _armoredVehicle, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10], _locationPos, [_locationSize, _locationSize * 3], "patrol", _locationPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF ARMORED VEHICLE IS BACK TO THE HQ OR IF IT HAS BEEN DESTROYED
	[
		_armoredVehicle,
		[0, 0, 0, false],
		["any", "present", false],
		["(OPEX_assignedTask) && ((armoredVehicle distance (getMarkerPos 'OPEX_marker_camp') < 150) || (!alive armoredVehicle))", "[] remoteExec ['Gemini_fnc_taskSucceeded']", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// there's no way to fail this task

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug && !isNil "_armoredVehicle") then {[_armoredVehicle, "mil_objective", "colorRed", "ARMORED VEHICLE", "task"] call Gemini_fnc_createMarker};