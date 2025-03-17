// =========================================================================================================
// TASK ID : 			01
// TASK OBJECTIVE :		RESCUE A PILOT AFTER HIS AIRCRAFT HAS BEEN CRASHED
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

	// AIRCRAFT POSITION
	private _aircraftPos = ["land_isolated", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_aircraftPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// PILOT POSITION
	private _pilotPos = ["land", _aircraftPos, 100, 200] call Gemini_fnc_findPos;
	if (_pilotPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// DAMAGING ALL OBJECTS AROUND AIRCRAFT TO SIMULATE CRASH EFFECT
	{_x setDamage 1} forEach (nearestObjects [_aircraftPos, [], 50]);

	// CLEARING THE AREA IN CASE ENEMIES ARE ALREADY NEARBY
	{if ((side _x == OPEX_enemy_side1) && (_x distance _pilotPos < 1000)) then {deleteVehicle _x}} forEach allUnits;

	// SPAWNING AIRCRAFT
	private _aircraft = [selectRandom OPEX_friendly_aircrafts, _aircraftPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_aircraft setDamage 1;

	// CREATING INFINITE SMOKE EFFECT (USEFULL TO HELP PLAYER TO LOCATE THE CRASH SITE
	private _smoke = ["test_EmptyObjectForSmoke", _aircraftPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_smoke attachTo [_aircraft, [0, 1.5, 0]];
	private _fire = ["test_EmptyObjectForFireBig", _aircraftPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_fire attachTo [_aircraft, [0, 1.5, 0]];
	private _light = ["#lightpoint", _aircraftPos, random 360, true, "task"] call Gemini_fnc_createVehicle;
	_light setLightBrightness 5.0;
	_light setLightAmbient [1.0, 0.5, 0.0];
	_light setLightColor [1.0, 0.5, 0.0];
	[_smoke, _fire, _light] spawn {sleep 5; {_x enableDynamicSimulation false} forEach _this};

	// SPAWNING PILOT
	private _pilot = [OPEX_friendly_side1, grpNull, [OPEX_friendly_aircraft_pilot], _pilotPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	_pilot allowDamage false;
	removeAllAssignedItems _pilot;
	removeBackpack _pilot;
	removeHeadgear _pilot;

	// MOVING PILOT INTO NEAREST BUILDING (IF THERE'S ANY)
	if ((nearestBuilding _aircraft) distance _aircraft < 100) then {_pilot setPos ((nearestBuilding _aircraft) buildingPos 1)};

	// SETTING PILOT BEHAVIOUR
	_pilot setDir ([_pilot, _aircraft] call BIS_fnc_dirTo);
	_pilot doWatch _aircraft;
	_pilot setCombatMode "green";
	_pilot setUnitPos "middle";
	_pilot allowDamage true;
	group _pilot setCombatMode "green";

	// ADJUSTING PILOT Z POS
	if ((getPos _pilot select 2) < (getPosATL _pilot select 2)) then {_pilot setPosATL [(getPos _pilot select 0), (getPos _pilot select 1), 0]};

	// CREATING HELPER (STROBE/FLARE/SMOKE - DEPENDING ON DAYTIME) WHEN A PLAYER IS NEAR, TO HELP FINDING THE PILOT
	_pilot spawn
		{
			private _pilot = _this;
			while {OPEX_assignedTask} do
				{
					sleep 30;
					if (OPEX_assignedTask && (alive _pilot) && (leader _pilot == _pilot) && ({_pilot distance _x < 500} count (allPlayers - entities "HeadlessClient_F") > 0)) then
						{
							if (OPEX_sunHeight < -10)
							then
								{
									if (!alive ((position _pilot) nearestObject "I_IRStrobe")) then {_strobe = ["I_IRStrobe", _pilot ModelToWorld [0, 1, 0], random 360, true, "task"] call Gemini_fnc_createVehicle; _strobe setPosATL [(getPos _strobe) select 0, (getPos _strobe) select 1, 0]};
									if ((random 1 > 0.5) && (!((position _pilot) call Gemini_fnc_isInsideBuilding))) then {_flare = "F_20mm_Red" createvehicle ((_pilot) ModelToWorld [random 15 - random 15, random 15 - random 15, 175]); _flare setVelocity [random 5 - random 5, random 5 - random 5, -5]};
								}
							else
								{
									if (!alive ((position _pilot) nearestObject "smokeShellBlue")) then {_smoke = ["smokeShellBlue", _pilot, random 360, true, "task"] call Gemini_fnc_createVehicle};
								}
						};
				};
		};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// SPAWNING ENEMY SQUAD(S) AROUND THE AIRCRAFT, MOVING TO ITS POSITION
	for "_i" from 1 to 5 do {[OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], -1, _aircraftPos, [1000,2000], "attack", _aircraftPos, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// RANDOMLY MOVING MARKER AROUND AIRCRAFT
	private _markerPos = [(_aircraftPos select 0) + random 300 - random 300, (_aircraftPos select 1) + random 300 - random 300];

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _markerPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize [500,500];
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
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED IF PILOT IS ALIVE AND BACK TO BASE
	[_pilot, _aircraft] spawn
		{
			private _pilot = _this select 0;
			private _aircraft = _this select 1;
			waitUntil {sleep 1; (((_pilot call Gemini_fnc_isInSafeLocation) || (!alive _pilot) || !OPEX_assignedTask) && (vehicle _pilot == _pilot))};
			if ((_pilot call Gemini_fnc_isInSafeLocation) && alive _pilot) then
				{
					// WHEN SAFE, PILOT LEAVES PLAYER'S GROUP
					_pilot removeAllMPEventHandlers "MPkilled";
					sleep 3; [_pilot] join GrpNull;
					(group _pilot) addWaypoint [getMarkerPos "OPEX_marker_camp", 100];
					[group _pilot, 1] setWaypointSpeed "limited";
					[group _pilot, 1] setWaypointBehaviour "safe";
					[group _pilot, 1] setWaypointType "dismiss";
					// DISPLAYING SUCCESS
					if (OPEX_assignedTask) then
						{
							[] remoteExec ["Gemini_fnc_taskSucceeded"];
							["support", "airStrike"] call Gemini_fnc_bonus; // NEW SUPPORT AVAILABLE
						};
				};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF PILOT IS DEAD
	_pilot addMPEventHandler ["MPkilled", {[] spawn Gemini_fnc_taskFailed}];

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

	if (_debug) then
		{
			[_pilot, "mil_warning", "ColorBlue", "PILOT", "task"] call Gemini_fnc_createMarker;
			[_aircraft, "mil_warning", "ColorBlue", "AIRCRAFT", "task"] call Gemini_fnc_createMarker;
		};