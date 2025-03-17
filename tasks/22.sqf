// =========================================================================================================
// TASK ID : 			22
// TASK OBJECTIVE :		EVACUATE CIVILIANS
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
// GETTING TASK POSITIONS
// =========================================================================================================

	// LOOKING FOR A VILLAGE
	private _villagePos = ["village", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_villagePos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING VILLAGE SIZE
	private _villageArea = [((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _villageSize = (_villageArea select 0) max (_villageArea select 1);

	// GETTING A DESTINATION
	private _destinationPos = [["village", "city"], _villagePos, 1000, 2000] call Gemini_fnc_findPos;
	if (_destinationPos isEqualTo [0,0,0]) then {_destinationPos = [["village", "city"], _villagePos, 1000, 3500] call Gemini_fnc_findPos};
	if (_destinationPos isEqualTo [0,0,0]) then {_destinationPos = [["village", "city"], _villagePos, 1000, 5000] call Gemini_fnc_findPos};
	if (_destinationPos isEqualTo [0,0,0]) then {_destinationPos = [["village", "city"], _villagePos, 1000, 7500] call Gemini_fnc_findPos};
	if (_destinationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING DESTINATION SIZE
	private _destinationArea = [((triggerArea ((_destinationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_destinationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _destinationSize = (_destinationArea select 0) max (_destinationArea select 1);

	// LOOKING FOR ALL ENTERABLE BUILDINGS IN THE AREA
	private _nearbyBuildings = nearestObjects [_villagePos, ["house"], _villageSize * 0.60];
	private _counter = 0;
	private _nearbyEnterableBuildings = [];
	while {(_counter < count _nearbyBuildings)} do
		{
			_test = (_nearbyBuildings select _counter) buildingPos 1;
			if !((_test select 0) == 0 && (_test select 1) == 0 && (_test select 2) == 0) then {_nearbyEnterableBuildings = _nearbyEnterableBuildings + [(_nearbyBuildings select _counter)]};
			_counter = _counter + 1;
		};

	// GETTING INSIDE POSITIONS
	private _insidePositions = [];
	if (count _nearbyEnterableBuildings > 0) then
		{
			{
				private _buildingPositions = [];
				_buildingPositions = _x buildingPos -1;
				if (count _buildingPositions > 0) then {{if (typeName _x == "array") then {if (_x distance [0,0,0] > 1) then {_insidePositions append [_x]}}} forEach _buildingPositions};
			} forEach _nearbyEnterableBuildings;
		};

	// GETTING OUTSIDE POSITIONS
	private _outsidePositions = [];
	if ((daytime > 8) && (dayTime < 19)) then
		{
			for "_i" from 1 to 20 do
				{
					private ["_emptyPosition"];
					_emptyPosition = _villagePos findEmptyPosition [0, _villageSize * 0.8];
					if (count _emptyPosition > 0) then {if ((_emptyPosition) inArea "TaskMarker_A") then {_outsidePositions append [_emptyPosition]}};
				};
		};

	// CHECKING IF THERE ARE ENOUGH FOUND POSITIONS TO CREATE THE TASK
	if (count (_insidePositions + _outsidePositions) < 10) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// COMPILING POSSIBLE SPAWNING POSITIONS
	private _spawnPositions = [];
	if ((OPEX_sunHeight > 0) && (count _insidePositions <= 10)) then {_spawnPositions = _insidePositions + _outsidePositions};
	if ((OPEX_sunHeight > 0) && (count _insidePositions > 20)) then {_spawnPositions = _insidePositions + _outsidePositions + _outsidePositions};
	if ((OPEX_sunHeight > 0) && (count _insidePositions > 40)) then {_spawnPositions = _insidePositions + _outsidePositions + _outsidePositions + _outsidePositions};
	if ((OPEX_sunHeight <= 0) && (count _insidePositions < 10)) then {_spawnPositions = _insidePositions + _outsidePositions};
	if ((OPEX_sunHeight <= 0) && (count _insidePositions >= 10)) then {_spawnPositions = _insidePositions};
	if (count _spawnPositions == 0) then {_spawnPositions = _outsidePositions};
	if (count _spawnPositions == 0) then {_spawnPositions = [_villagePos]};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _villagePos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _villageArea;
	"TaskMarker_A" setMarkerColor "colorOrange";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER PICK UP
	"TaskMarker_B" setMarkerPos _villagePos;
	"TaskMarker_B" setMarkerType "mil_start";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorOrange";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

	// MARKER DESTINATION
	"TaskMarker_C" setMarkerPos _destinationPos;
	"TaskMarker_C" setMarkerType "mil_end";
	"TaskMarker_C" setMarkerSize [1,1];
	"TaskMarker_C" setMarkerColor "colorGreen";
	"TaskMarker_C" setMarkerAlpha 1;

	// MARKER DESTINATION AREA
	"TaskMarker_D" setMarkerPos _destinationPos;
	"TaskMarker_D" setMarkerShape "ellipse";
	"TaskMarker_D" setMarkerBrush "FDiagonal";
	"TaskMarker_D" setMarkerSize _destinationArea;
	"TaskMarker_D" setMarkerColor "colorGreen";
	"TaskMarker_D" setMarkerAlpha 0.75;

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

	// SPAWNING CIVILIANS
	private _civilian_22_01 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_02 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_03 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_04 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_05 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_06 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_07 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_08 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_09 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilian_22_10 = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, selectRandom _spawnPositions, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;
	private _civilians = [_civilian_22_01, _civilian_22_02, _civilian_22_03, _civilian_22_04, _civilian_22_05, _civilian_22_06, _civilian_22_07, _civilian_22_08, _civilian_22_09, _civilian_22_10];

	// PREVENTING CIVILIANS SPAWNING OUTSIDE OR LEAVING THE VILLAGE
	[_villagePos, _villageSize, _civilians] spawn
		{
			private _villagePos = _this select 0;
			private _villageSize = _this select 1;
			private _civilians = _this select 2;
			while {OPEX_assignedTask} do
				{
					sleep 5;
					if (OPEX_assignedTask) then
						{
							{
								_x setPos [(_villagePos select 0) + random 50 - random 50, (_villagePos select 1) + random 50 - random 50, 0];
								_x switchMove "";
								_x move _villagePos;
							} forEach (_civilians select {(!((position _x) inArea "TaskMarker_A")) && (isNull (assignedVehicle _x)) && (!((position _x) inArea "TaskMarker_B")) && (!([_x, 150] call Gemini_fnc_isPlayerNearby))});
						};
				};
		};

	// DELETING ANY OTHER CIVILIAN THAT WOULD BE INTO THE VILLAGE (TO AVOID ANY CONFUSION)
	[_civilians, _villagePos, _villageSize] spawn
		{
			private _civilians = _this select 0;
			private _villagePos = _this select 1;
			private _villageSize = _this select 2;
			while {OPEX_assignedTask} do
				{
					sleep 1;
					private _allUnitsNearby = _villagePos nearEntities ["Man", _villageSize];
					{if ((side _x == civilian) && (!(_x in _civilians))) then {deleteVehicle _x}} forEach _allUnitsNearby;
				};
		};
	// ADDING CUSTOM ACTIONS TO CIVILIANS
		{
			private _conditionFollow = "OPEX_assignedTask && (alive _originalTarget) && (_originalTarget distance2D _this < 15)";
			private _conditionWait = "OPEX_assignedTask && (alive _originalTarget) && (_originalTarget distance2D _this < 15)";
			private _conditionGetIn = "OPEX_assignedTask && (alive _originalTarget) && (count (_this nearEntities [['Air', 'Car', 'Motorcycle', 'Ship', Tank'], 15]) > 0) && (_originalTarget distance2D _this < 15)";
			[_x, "STR_action_follow", "[_this select 0, _this select 1] remoteExec ['Gemini_fnc_evacuate_follow', _this select 0, _this select 0]", [], 6, _conditionFollow, true, true] remoteExec ["Gemini_fnc_addAction", 0, _x];
			[_x, "STR_action_wait", "[_this select 0, _this select 1] remoteExec ['Gemini_fnc_evacuate_wait', _this select 0, _this select 0]", [], 6, _conditionWait, true, true] remoteExec ["Gemini_fnc_addAction", 0, _x];
			[_x, "STR_action_getIn", "[_this select 0, _this select 1] remoteExec ['Gemini_fnc_evacuate_getIn', _this select 0, _this select 0]", [], 6, _conditionGetIn, true, true] remoteExec ["Gemini_fnc_addAction", 0, _x];
		} forEach _civilians;

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[OPEX_enemy_side1, ["infantry"], -1, _villagePos, [_villageSize * 2, _villageSize * 3], "patrol", _villagePos, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], -1, _destinationPos, [500, 1000], "patrol", _destinationPos, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF CIVILIANS HAVE BEEN EVACUATED TO DESTINATION
	_civilians spawn
		{
			private _civilian_22_01 = _this select 0;
			private _civilian_22_02 = _this select 1;
			private _civilian_22_03 = _this select 2;
			private _civilian_22_04 = _this select 3;
			private _civilian_22_05 = _this select 4;
			private _civilian_22_06 = _this select 5;
			private _civilian_22_07 = _this select 6;
			private _civilian_22_08 = _this select 7;
			private _civilian_22_09 = _this select 8;
			private _civilian_22_10 = _this select 9;
			while
				{
					OPEX_assignedTask
					&&
					(
						(_civilian_22_01 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_02 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_03 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_04 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_05 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_06 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_07 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_08 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_09 distance2D (getMarkerPos "TaskMarker_C") > 150)
						||
						(_civilian_22_10 distance2D (getMarkerPos "TaskMarker_C") > 150)
					)
				} do {sleep 3};
			if (OPEX_assignedTask) then
				{
					[] remoteExec ["Gemini_fnc_taskSucceeded"];
					["reputation", 0.1] call Gemini_fnc_bonus;
					{_x move (_x getPos [random 150, random 360]); _x setBehaviour "safe"; _x setSpeedMode "limited"} forEach civilians_22;
				};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// FAILING TASK IF A CIVILIAN IS KILLED
	{_x addMPEventHandler ["MPkilled", {[] spawn Gemini_fnc_taskFailed}]} forEach _civilians;

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then {civilians_22 = _civilians; {[_x, "mil_objective", "colorGreen", "CIV", "task"] call Gemini_fnc_createMarker} forEach _civilians};