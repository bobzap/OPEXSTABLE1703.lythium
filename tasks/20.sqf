// =========================================================================================================
// TASK ID : 			20
// TASK OBJECTIVE :		INTERCEPT AN ENEMY CONVOY
// TASK CREATOR : 		GEMINI (gemini.69@free.fr)
//  /!\ THIS OPEX_task IS NOT WORKING PROPERLY YET - ARMA AI IS SO STUPID WHEN DRIVING VEHICLES, MORE ADJUSTMENTS ARE REQUIRED !!!
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
	convoy_20 = nil;
	driver_20_3 = nil;
	driver_20_4 = nil;

// =========================================================================================================
// DEFINING TASK POSITION(S)
// =========================================================================================================

	// LOOKING FOR A ROAD
	private _roadPos = ["road", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_roadPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _convoyStart = (_roadPos nearRoads 10) select 0;

	// LOOKING FOR A DESTINATION
	private _convoyDestination = [["industry", "military"], _roadPos, 2000, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_convoyDestination isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING DESTINATION SIZE
	private _destinationArea = [((triggerArea ((_convoyDestination nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_convoyDestination nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _destinationSize = (_destinationArea select 0) max (_destinationArea select 1);

	// GETTING CONVOY DIRECTION
	private _convoyDirection = _convoyStart getDir _convoyDestination;

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	[_convoyStart, _convoyDestination, _convoyDirection] spawn
		{
			private ["_convoyStart", "_convoyDestination", "_convoyDirection"];
			_convoyStart = _this select 0;
			_convoyDestination = _this select 1;
			_convoyDirection = _this select 2;

			// WAITING FOR PLAYERS INTO THE OPERATION AREA
			waitUntil {(!OPEX_assignedTask) || ({_convoyStart distance _x < 2000} count (playableUnits + switchableUnits) > 0) || ({_convoyDestination distance _x < 2000} count (playableUnits + switchableUnits) > 0)};
			if (!OPEX_assignedTask) exitWith {[] remoteExec ["Gemini_fnc_taskReset"]};

			// SPAWNING VEHICLE & SQUAD 1
			private _vehicle1 = [OPEX_enemy_combatCars + OPEX_enemy_transportCars, _convoyStart, _convoyDirection, true, "task"] call Gemini_fnc_createVehicle;
			{_vehicle1 enablePersonTurret [_x, false]} forEach (allTurrets _vehicle1);
			private _availablePositions1 = (_vehicle1 emptyPositions "Driver") + (_vehicle1 emptyPositions "Commander") + (_vehicle1 emptyPositions "Gunner") + (_vehicle1 emptyPositions "Cargo");
			private _squad1 = [OPEX_enemy_side1, ["infantry"], _availablePositions1, _convoyStart, 50, "", _convoyDestination, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
			{
				_x moveInAny _vehicle1;
				_x setBehaviour "safe";
				_x setSpeedMode "limited";
			} forEach units _squad1;
			_vehicle1 doMove _convoyDestination;
			_vehicle1 setUnloadInCombat [true, false];
			_vehicle1 limitSpeed 30;
			_vehicle1 allowDamage false;

			// SPAWNING VEHICLE & SQUAD 2
			waitUntil {!OPEX_assignedTask || (_vehicle1 distance _convoyStart > 20)};
			private _vehicle2 = [OPEX_enemy_combatCars + OPEX_enemy_combatCars + OPEX_enemy_combatCars + OPEX_enemy_armored, _convoyStart, getDir _vehicle1, true, "task"] call Gemini_fnc_createVehicle;
			{_vehicle2 enablePersonTurret [_x, false]} forEach (allTurrets _vehicle2);
			private _availablePositions2 = (_vehicle2 emptyPositions "Driver") + (_vehicle2 emptyPositions "Commander") + (_vehicle2 emptyPositions "Gunner") + (_vehicle2 emptyPositions "Cargo");
			private _squad2 = [OPEX_enemy_side1, ["infantry"], _availablePositions2, _convoyStart, 50, "", _convoyDestination, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
			{
				_x moveInAny _vehicle2;
				_x setBehaviour "safe";
				_x setSpeedMode "limited";
			} forEach units _squad2;
			_vehicle2 doMove _convoyDestination;
			_vehicle2 setUnloadInCombat [true, false];
			_vehicle2 limitSpeed 30;
			_vehicle2 allowDamage false;

			// SPAWNING VEHICLE & SQUAD 3
			waitUntil {!OPEX_assignedTask || (_vehicle2 distance _convoyStart > 20)};
			private _vehicle3 = [OPEX_enemy_transportTrucks, _convoyStart, getDir _vehicle2, true, "task"] call Gemini_fnc_createVehicle;
			{_vehicle3 enablePersonTurret [_x, false]} forEach (allTurrets _vehicle3);
			private _availablePositions3 = 3;
			private _squad3 = [OPEX_enemy_side1, ["infantry"], _availablePositions3, _convoyStart, 50, "", _convoyDestination, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
			{
				_x moveInAny _vehicle3;
				_x setBehaviour "safe";
				_x setSpeedMode "limited";
			} forEach units _squad3;
			_vehicle3 doMove _convoyDestination;
			_vehicle3 setUnloadInCombat [true, false];
			_vehicle3 limitSpeed 30;
			_vehicle3 allowDamage false;

			// SPAWNING VEHICLE & SQUAD 4
			waitUntil {!OPEX_assignedTask || (_vehicle3 distance _convoyStart > 20)};
			private _vehicle4 = [OPEX_enemy_transportTrucks, _convoyStart, getDir _vehicle3, true, "task"] call Gemini_fnc_createVehicle;
			{_vehicle4 enablePersonTurret [_x, false]} forEach (allTurrets _vehicle4);
			private _availablePositions4 = 3;
			private _squad4 = [OPEX_enemy_side1, ["infantry"], _availablePositions4, _convoyStart, 50, "", _convoyDestination, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
			{
				_x moveInAny _vehicle4;
				_x setBehaviour "safe";
				_x setSpeedMode "limited";
			} forEach units _squad4;
			_vehicle4 doMove _convoyDestination;
			_vehicle4 setUnloadInCombat [true, false];
			_vehicle4 limitSpeed 30;
			_vehicle4 allowDamage false;

			// SPAWNING VEHICLE & SQUAD 5
			waitUntil {!OPEX_assignedTask || (_vehicle4 distance _convoyStart > 20)};
			private _vehicle5 = [OPEX_enemy_combatCars + OPEX_enemy_combatCars + OPEX_enemy_transportCars, _convoyStart, getDir _vehicle4, true, "task"] call Gemini_fnc_createVehicle;
			{_vehicle5 enablePersonTurret [_x, false]} forEach (allTurrets _vehicle5);
			private _availablePositions5 = (_vehicle5 emptyPositions "Driver") + (_vehicle5 emptyPositions "Commander") + (_vehicle5 emptyPositions "Gunner") + (_vehicle5 emptyPositions "Cargo");
			private _squad5 = [OPEX_enemy_side1, ["infantry"], _availablePositions5, _convoyStart, 50, "", _convoyDestination, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
			{
				_x moveInAny _vehicle5;
				_x setBehaviour "safe";
				_x setSpeedMode "limited";
			} forEach units _squad5;
			_vehicle5 doMove _convoyDestination;
			_vehicle5 setUnloadInCombat [true, false];
			_vehicle5 limitSpeed 30;
			_vehicle5 allowDamage false;

			// SETTING VEHICLES CARGO
			{clearWeaponCargoGlobal _x; clearMagazineCargoGlobal _x; clearItemCargoGlobal _x; clearBackpackCargoGlobal _x} forEach [_vehicle1, _vehicle2, _vehicle3, _vehicle4, _vehicle5];
			{
				private _launcher = selectRandom (OPEX_enemy_AAlaunchers + OPEX_enemy_ATlaunchers);
				private _rocket = selectRandom ((configFile >> "CfgWeapons" >> _launcher >> "magazines") call BIS_fnc_GetCfgData);
				_x addWeaponCargoGlobal [_launcher, 10];
				_x addMagazineCargoGlobal [_rocket, 25];
			} forEach [_vehicle3, _vehicle4];

			// SUCCEEDING IF TRANSPORT TRUCKS ARE DESTROYED OR IF AA/AT LAUNCHERS HAVE BEEN UNLOADED FROM TRUCKS
			[_vehicle3, _vehicle4] spawn
				{
					private _vehicle3 = _this select 0;
					private _vehicle4 = _this select 1;
					while {OPEX_assignedTask && (alive _vehicle3 || alive _vehicle4) && (count (((getWeaponCargo _vehicle3) select 0) + ((getMagazineCargo _vehicle3) select 0) + ((getWeaponCargo _vehicle4) select 0) + ((getMagazineCargo _vehicle4) select 0)) > 0)} do {sleep 5};
					if (OPEX_assignedTask && ((!alive _vehicle3 && !alive _vehicle4) || (count (((getWeaponCargo _vehicle3) select 0) + ((getMagazineCargo _vehicle3) select 0) + ((getWeaponCargo _vehicle4) select 0) + ((getMagazineCargo _vehicle4) select 0)) == 0))) then
						{
							[] remoteExec ["Gemini_fnc_taskSucceeded"];
							["supply", "random"] call Gemini_fnc_bonus;
						};
				};

			// FAILING TASK IF AT LEAST 1 TRANSPORT TRUCK REACHES ITS DESTINATION
			[_vehicle3, _vehicle4, _convoyDestination] spawn
				{
					private _vehicle3 = _this select 0;
					private _vehicle4 = _this select 1;
					private _convoyDestination = _this select 2;
					while {OPEX_assignedTask} do
						{
							sleep 10;
							if (OPEX_assignedTask && ((_vehicle3 distance _convoyDestination < 25) || (_vehicle4 distance _convoyDestination < 25))) then {[] remoteExec ["Gemini_fnc_taskFailed"]};
						};
				};

			// PROCESSING CONVOY
			convoy_20 = [_vehicle1, _vehicle2, _vehicle3, _vehicle4, _vehicle5];
			convoy_20 spawn {while {OPEX_assignedTask} do {sleep 3; if (count convoy_20 > 0) then {{if ((!canMove _x) && (_x in convoy_20)) then {convoy_20 = convoy_20 - [_x]}} forEach convoy_20}}};
			_vehicle1 forceSpeed 10;
			waitUntil {!isNil "_vehicle5"};
			{_x allowDamage true; _x forceFollowRoad true} forEach [_vehicle1, _vehicle2, _vehicle3, _vehicle4, _vehicle5];
			driver_20_3 = driver _vehicle3;
			driver_20_4 = driver _vehicle4;
			while {OPEX_assignedTask && canMove _vehicle3 && canMove _vehicle4 && canMove driver_20_3 && canMove driver_20_4} do
				{
					sleep 1;
					if (count convoy_20 > 0) then
						{
							// MOVING
							if (count convoy_20 > 0) then {if (speed (convoy_20 select 0) == 0) then {while {(count (waypoints group (convoy_20 select 0))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 0))) select 0)}; (convoy_20 select 0) doMove _convoyDestination}};
							if (count convoy_20 > 1) then {if (speed (convoy_20 select 1) == 0) then {while {(count (waypoints group (convoy_20 select 1))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 1))) select 0)}; (convoy_20 select 1) doMove (position (convoy_20 select 0))}};
							if (count convoy_20 > 2) then {if (speed (convoy_20 select 2) == 0) then {while {(count (waypoints group (convoy_20 select 2))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 2))) select 0)}; (convoy_20 select 2) doMove (position (convoy_20 select 1))}};
							if (count convoy_20 > 3) then {if (speed (convoy_20 select 3) == 0) then {while {(count (waypoints group (convoy_20 select 3))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 3))) select 0)}; (convoy_20 select 3) doMove (position (convoy_20 select 2))}};
							if (count convoy_20 > 4) then {if (speed (convoy_20 select 4) == 0) then {while {(count (waypoints group (convoy_20 select 4))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 4))) select 0)}; (convoy_20 select 4) doMove (position (convoy_20 select 3))}};
							// LIMITING SPEED
							{_x limitSpeed 30} forEach (convoy_20 select {speed _x > 30});
							// LIMITING DISTANCE BETWEEN VEHICLES (BECAUSE ARMA'S AI DRIVERS ARE SOOOOOOOO STUPID !!!)
							if (count convoy_20 == 1) then {deleteWaypoint ((waypoints (group (convoy_20 select 0))) select 0)}; (convoy_20 select 0) doMove _convoyDestination;
							if (count convoy_20 > 1) then {if ((convoy_20 select 0) distance (convoy_20 select (count convoy_20 - 1)) > ((20 * (count convoy_20 - 1)))) then {doStop (convoy_20 select 0); while {(count (waypoints group (convoy_20 select 0))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 0))) select 0)}}};
							if (count convoy_20 > 1) then {if ((convoy_20 select 1) distance (convoy_20 select 0) < 20) then {doStop (convoy_20 select 1); while {(count (waypoints group (convoy_20 select 1))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 1))) select 0)}}};
							if (count convoy_20 > 2) then {if ((convoy_20 select 2) distance (convoy_20 select 1) < 20) then {doStop (convoy_20 select 2); while {(count (waypoints group (convoy_20 select 2))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 2))) select 0)}}};
							if (count convoy_20 > 3) then {if ((convoy_20 select 3) distance (convoy_20 select 2) < 20) then {doStop (convoy_20 select 3); while {(count (waypoints group (convoy_20 select 3))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 3))) select 0)}}};
							if (count convoy_20 > 4) then {if ((convoy_20 select 4) distance (convoy_20 select 3) < 20) then {doStop (convoy_20 select 4); while {(count (waypoints group (convoy_20 select 4))) > 0} do {deleteWaypoint ((waypoints (group (convoy_20 select 4))) select 0)}}};
							// ADJUSTING SPEED BETWEEN VEHICLES (SAME REASON AS ABOVE)
							if (count convoy_20 > 1) then {if ((convoy_20 select 0) distance (convoy_20 select (count convoy_20 - 1)) > ((10 * (count convoy_20 - 1)))) then {(convoy_20 select 0) forceSpeed (speed (convoy_20 select 0) / 2)}};
							if (count convoy_20 > 1) then {if ((convoy_20 select 1) distance (convoy_20 select 0) < 40) then {(convoy_20 select 1) forceSpeed (speed (convoy_20 select 1) / 2)}};
							if (count convoy_20 > 2) then {if ((convoy_20 select 2) distance (convoy_20 select 1) < 40) then {(convoy_20 select 2) forceSpeed (speed (convoy_20 select 2) / 2)}};
							if (count convoy_20 > 3) then {if ((convoy_20 select 3) distance (convoy_20 select 2) < 40) then {(convoy_20 select 3) forceSpeed (speed (convoy_20 select 3) / 2)}};
							if (count convoy_20 > 4) then {if ((convoy_20 select 4) distance (convoy_20 select 3) < 40) then {(convoy_20 select 4) forceSpeed (speed (convoy_20 select 4) / 2)}};
							// UPDATING CONVOY MARKER POSITION
							if  (canMove _vehicle4) then {"taskMarker_C" setMarkerPos (position _vehicle4)};
							if  (canMove _vehicle3) then {"taskMarker_C" setMarkerPos (position _vehicle3)};
						};
				};

			// DEBUGGING
			if (_debug) then
				{
					vehicle_20_1 = _vehicle1;
					vehicle_20_2 = _vehicle2;
					vehicle_20_3 = _vehicle3;
					vehicle_20_4 = _vehicle4;
					vehicle_20_5 = _vehicle5;
				};
		};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// SPAWNING DEFENSE VEHICLES
	private _defenseVehicle1 = [OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _convoyDestination, _destinationSize, [OPEX_enemy_units, ceil (random 3)], 80, "task"] call Gemini_fnc_spawnVehicle;
	private _defenseVehicle2 = [OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _convoyDestination, _destinationSize, [OPEX_enemy_units, ceil (random 3)], 40, "task"] call Gemini_fnc_spawnVehicle;
	private _defenseVehicle3 = [OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _convoyDestination, _destinationSize, [OPEX_enemy_units, ceil (random 3)], 20, "task"] call Gemini_fnc_spawnVehicle;

	// SPAWNING STATIC ENEMIES INSIDE BUILDINGS	(IF THERE ARE ANY)
	[_convoyDestination, _destinationSize, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingInside;

	// SPAWNING STATIC ENEMIES OUTSIDE
	[_convoyDestination, _destinationSize, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "task"] call Gemini_fnc_spawnUnitsStandingOutside;
	for "_i" from 1 to (selectRandom [1,2,3]) do {[OPEX_enemy_side1, ["infantry"], selectRandom [2,3], _convoyDestination, [0, _destinationSize], "talk", _convoyDestination, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};

	//  SPAWNING SQUAD(S) PATROLLING THE AREA
	for "_i" from 1 to (selectRandom [1,2,3]) do {[OPEX_enemy_side1, ["infantry"], -1, _convoyDestination, [0, _destinationSize * 2], "patrol", _convoyDestination, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// CONVOY START
	"taskMarker_A" setMarkerPos _roadPos;
	"taskMarker_A" setMarkerSize [1,1];
	"taskMarker_A" setMarkerType "mil_start";
	"taskMarker_A" setMarkerColor "colorRed";
	"taskMarker_A" setMarkerAlpha 1;
	"taskMarker_A" setMarkerText "";

	// CONVOY DESTINATION
	"taskMarker_B" setMarkerPos _convoyDestination;
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerType "mil_end";
	"taskMarker_B" setMarkerColor "colorRed";
	"taskMarker_B" setMarkerAlpha 1;
	"taskMarker_B" setMarkerText "";

	// AMBUSH
	"taskMarker_C" setMarkerPos [((_roadPos select 0) + (_convoyDestination select 0)) / 2, ((_roadPos select 1) + (_convoyDestination select 1)) / 2, 0];
	"taskMarker_C" setMarkerType "mil_warning";
	"taskMarker_C" setMarkerSize [1,1];
	"taskMarker_C" setMarkerColor "colorRed";
	"taskMarker_C" setMarkerAlpha 1;
	["taskMarker_C", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// already defined above

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// already defined above

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "attack", "taskMarker_C"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname