// =========================================================================================================
// TASK ID : 			08
// TASK OBJECTIVE :		NEUTRALIZE 3 ENEMY OFFICERS
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
// DEFINING MAIN TASK POSITION
// =========================================================================================================

	// LOOKING FOR A VILLAGE
	private _villagePos = ["village", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_villagePos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING VILLAGE SIZE
	private _villageArea = [((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_villagePos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _villageSize = (_villageArea select 0) max (_villageArea select 1);

// =========================================================================================================
// DEFINING OTHER TASK POSITIONS
// =========================================================================================================

	// DEFING DEFAULT MEETING POSITION
	private _outsideMeeting = true;

	// LOOKING FOR BUILDINGS NEAR LOCATION
	private _buildingPos = ["building", _villagePos, 0, _villageSize * 0.80] call Gemini_fnc_findPos;

	// LOOKING FOR AN APPROPRIATE MEETING POSITION (INSIDE OR OUTSIDE)
	private ["_meetingPos"];
	if ((!("_buildingPos" isEqualTo [0,0,0])) && (random (1 - rain) < 0.5))

		// LOOKING FOR INSIDE POSITION
			then
				{
					// SELECTING BUILDING
					private _building = nearestBuilding _buildingPos;

					// LOOKING FOR A POSITION INSIDE BUILDING
					private _buildingPosList = ([_building] call BIS_fnc_buildingPositions) select {_x call Gemini_fnc_isInsideBuilding};
					{if (!(_x call Gemini_fnc_isInsideBuilding)) then {_buildingPosList = _buildingPosList - [_x]}} forEach _buildingPosList;
					_meetingPos = selectRandom _buildingPosList;
					if (isNil "_meetingPos") then {_meetingPos = ["land", _villagePos, 0, _villageSize * 0.60] call Gemini_fnc_findPos; _outsideMeeting = true} else {_outsideMeeting = false};
				}

		// LOOKING FOR OUTSIDE POSITION
			else
				{
					// SEARCHING FOR A RANDOM POSITION INSIDE THE VILLAGE
					_meetingPos = ["land", _villagePos, 0, _villageSize * 0.75] call Gemini_fnc_findPos;
					_outsideMeeting = true;
				};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos [(_villagePos select 0), (_villagePos select 1) - 15];
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _villageArea;
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos [(_villagePos select 0), (_villagePos select 1) - 15];
	"TaskMarker_B" setMarkerType "mil_destroy";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorRed";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "kill", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["stealth"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING OFFICERS
	officer_1 = [OPEX_enemy_side1, grpNull, [OPEX_enemy_teamLeader], _meetingPos, OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
	officer_2 = [OPEX_enemy_side1, grpNull, [OPEX_enemy_teamLeader], _meetingPos, OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
	officer_3 = [OPEX_enemy_side1, grpNull, [OPEX_enemy_teamLeader], _meetingPos, OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
	{_x allowDamage false; _x setCombatMode "red"} forEach [officer_1, officer_2, officer_3];
	if ((isNil "officer_1") || (isNil "officer_2") || (isNil "officer_3")) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// ADJUSTING OFFICERS POSITION
	if (!_outsideMeeting)
	then
		{
			{
				private _officerPos = position _x;
				while {(count (_officerPos nearEntities 1.5) > 1) || (!(_officerPos call Gemini_fnc_isInsideBuilding))} do {_officerPos = _meetingPos getPos [2, random 360]};
				_x setPosATL _officerPos;
			} forEach [officer_1, officer_2, officer_3];
		}
	else
		{
			{
				private _officerPos = ["land", _meetingPos, 0.5, 4, 2] call Gemini_fnc_findPos;
				_x setPosATL _officerPos;
			} forEach [officer_1, officer_2, officer_3];
		};
	if (officer_1 distance2D [0,0,0] < 10) then {officer_1 setPos (_meetingPos getPos [random 10, random 360])};
	if (officer_2 distance2D [0,0,0] < 10) then {officer_2 setPos (officer_1 getPos [2, random 360])};
	if (officer_3 distance2D [0,0,0] < 10) then {officer_3 setPos (officer_2 getPos [2, random 360])};

	// ADJUSTING DIRECTION
	[] spawn
		{
			sleep 3;
			private _dir = (([officer_1, officer_2] call BIS_fnc_dirTo));
			officer_1 setFormDir _dir;
			officer_1 setDir _dir;
			private _dir = (([officer_2, officer_1] call BIS_fnc_relativeDirTo));
			officer_2 setFormDir _dir;
			officer_2 setDir _dir;
			private _dir = (([officer_3, officer_1] call BIS_fnc_relativeDirTo));
			officer_3 setFormDir _dir;
			officer_3 setDir _dir;
		};

	// SETTING GEAR
	{
		removeGoggles _x;
		removeHeadgear _x;
		removeBackpack _x;
		_x unassignItem "NVGoggles_OPFOR";
		_x removeItem "NVGoggles_OPFOR";
		_x allowDamage true;
	} forEach [officer_1, officer_2, officer_3];
	officer_1 addHeadgear (selectRandom OPEX_enemy_officerHeadgears);
	officer_2 addHeadgear (selectRandom OPEX_enemy_officerHeadgears);
	officer_3 addHeadgear (selectRandom OPEX_enemy_officerHeadgears);

	// ADDING AMBIENT LIGHT SOURCE
	if (_outsideMeeting)
		then
			{
				private _lightPos = ["land", _meetingPos, 0, 10, 2] call Gemini_fnc_findPos;
				private _lightSource = ["MetalBarrel_burning_F", _meetingPos, 0, true, "task"] call Gemini_fnc_createVehicle;
				_lightSource setVectorUp (surfaceNormal (position _lightSource));
			}
		else
			{
				private _lightSource = ["#lightpoint", _meetingPos, 0, true, "task"] call Gemini_fnc_createVehicle;
				_lightSource setLightColor [250,200,150];
				_lightSource setLightAmbient [1,1,0.2];
				_lightSource setLightAttenuation [1,4,4,0,1,4];
				_lightSource setLightIntensity 6.5;
				_lightSource setLightUseFlare true;
				_lightSource setLightFlareSize 0.5;
				_lightSource setLightFlareMaxDistance 75;
			};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// VEHICLES
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _meetingPos, 100, [OPEX_enemy_rifleman, selectRandom [1,2,3]], 100, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _meetingPos, 100, [OPEX_enemy_rifleman, selectRandom [1,2,3]], 100, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _meetingPos, 100, [OPEX_enemy_rifleman, selectRandom [1,2,3]], 100, "task"] call Gemini_fnc_spawnVehicle;
	[OPEX_enemy_armored, OPEX_enemy_side1, _meetingPos, 250, [OPEX_enemy_crewman, 3], 50, "task"] call Gemini_fnc_spawnVehicle;

	// BODYGUARDS
	[_meetingPos, [10,25], selectRandom [3,4,5], OPEX_enemy_side1, [OPEX_enemy_rifleman], OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;

	// DEFENDERS
	[_meetingPos, 50, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _meetingPos, [20, 40], "talk", _meetingPos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _meetingPos, [40, 60], "talk", _meetingPos, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

	// PATROLS
	[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _buildingPos, [20, 40], "patrol", _buildingPos, OPEX_enemy_AIskill, 90, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5], _buildingPos, [40, 120], "patrol", _buildingPos, OPEX_enemy_AIskill, 80, "task"] call Gemini_fnc_spawnSquad;
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10], _buildingPos, [120, 250], "patrol", _buildingPos, OPEX_enemy_AIskill, 70, "task"] call Gemini_fnc_spawnSquad;

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF ALL ENEMY OFFICERS ARE DEAD
	private _trigger =
		[
			_buildingPos,
			[0, 0, 0, false],
			["any", "present", true],
			["(OPEX_assignedTask) && (!alive officer_1) && (!alive officer_2) && (!alive officer_3)", "[] remoteExec ['Gemini_fnc_taskSucceeded']; ['intel', 50] call Gemini_fnc_bonus", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// there is now way to fail this task...

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (OPEX_debug) then
		{
			[officer_1, "mil_objective", "colorRed", "OFFICER 1", "task"] call Gemini_fnc_createMarker;
			[officer_2, "mil_objective", "colorRed", "OFFICER 2", "task"] call Gemini_fnc_createMarker;
			[officer_3, "mil_objective", "colorRed", "OFFICER 3", "task"] call Gemini_fnc_createMarker;
		};