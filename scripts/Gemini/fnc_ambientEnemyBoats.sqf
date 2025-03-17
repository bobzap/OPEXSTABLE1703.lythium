// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyBoats = 0; publicVariable "OPEX_ambientEnemyBoats";

// CHECKING IF MAP HAS ENOUGH WATER
if (isNil "OPEX_mapWater") exitWith {};
if (!OPEX_mapWater) exitWith {};

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyBoats >= 1) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyBoats = OPEX_ambientEnemyBoats + 1; publicVariable "OPEX_ambientEnemyBoats";

		// LOOKING FOR A RANDOM POSITION AROUND SELECTED PLAYER
		private _position = ["water", _player] call Gemini_fnc_findPos;
		if (_position isEqualTo [0,0,0]) exitWith {OPEX_ambientEnemyBoats = OPEX_ambientEnemyBoats - 1; publicVariable "OPEX_ambientEnemyBoats";};

		// SPAWNING BOAT & CREW
		private _boat = [selectRandom OPEX_enemy_boats, _position] call Gemini_fnc_createVehicle;
		private _squad = createGroup OPEX_enemy_side1;
		private _driver = [OPEX_enemy_side1, grpNull, [OPEX_enemy_teamLeader, OPEX_enemy_rifleman, OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_marksman], _position, OPEX_enemy_AIskill] call Gemini_fnc_createUnit;
		_driver moveInDriver _boat;
		_driver setBehaviour "CARELESS";
		[_driver] joinSilent _squad;
		for "_i" from 1 to (round random (_boat emptyPositions "cargo")) do
			{
				private _cargo = [OPEX_enemy_side1, grpNull, [OPEX_enemy_rifleman, OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_marksman], _position, OPEX_enemy_AIskill] call Gemini_fnc_createUnit;
				_cargo moveInCargo _boat;
				_cargo setBehaviour "CARELESS";
				[_cargo] joinSilent _squad;
			};

		// CREATING WAYPOINTS
		for "_i" from 1 to 5 do
			{
				private _waypointPos = ["water", _driver, 100, 500] call Gemini_fnc_findPos;
				private _waypoint = _squad addWaypoint [_waypointPos, 0];
				_waypoint setWaypointSpeed (selectRandom ["limited", "normal", "normal", "full"]);
				if (random 10 > 6) then {_waypoint setWaypointTimeout [0, 60, 30]} else {_waypoint setWaypointTimeout [0, 0, 0]};
				if (_i == 5) then {_waypoint setWaypointType "CYCLE"};
			};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT BOAT READY !";
				[_position, "mil_warning", "ColorRed", "BOAT"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {_boat call Gemini_fnc_isUnplayedArea};
		OPEX_ambientEnemyBoats = OPEX_ambientEnemyBoats - 1; publicVariable "OPEX_ambientEnemyBoats";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};