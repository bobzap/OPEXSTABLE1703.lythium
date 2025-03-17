// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientCivilianBoats = 0; publicVariable "OPEX_ambientCivilianBoats";

// CHECKING IF MAP HAS ENOUGH WATER
if (isNil "OPEX_mapWater") exitWith {};
if (!OPEX_mapWater) exitWith {};

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientCivilianBoats >= 2) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientCivilianBoats = OPEX_ambientCivilianBoats + 1; publicVariable "OPEX_ambientCivilianBoats";

		// LOOKING FOR A RANDOM POSITION AROUND SELECTED PLAYER
		private _position = ["water", _player] call Gemini_fnc_findPos;
		if (_position isEqualTo [0,0,0]) exitWith {OPEX_ambientCivilianBoats = OPEX_ambientCivilianBoats - 1; publicVariable "OPEX_ambientCivilianBoats";};

		// SPAWNING BOAT & CREW
		private _boat = [selectRandom OPEX_civilian_boats, _position] call Gemini_fnc_createVehicle;
		private _squad = createGroup OPEX_civilian_side1;
		private _driver = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _position, OPEX_civilian_AIskill] call Gemini_fnc_createUnit;
		_driver moveInDriver _boat;
		_driver setBehaviour "careless";
		[_driver] joinSilent _squad;
		if (random 1 > 0.5) then
			{
				for "_i" from 1 to (round random (_boat emptyPositions "cargo")) do
					{
						private _cargo = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _position, OPEX_civilian_AIskill] call Gemini_fnc_createUnit;
						_cargo moveInCargo _boat;
						_cargo setBehaviour "careless";
						[_cargo] joinSilent _squad;
					};
			};

		// CREATING WAYPOINTS
		for "_i" from 1 to 5 do
			{
				private _waypointPos = ["water", _driver, 100, 500] call Gemini_fnc_findPos;
				private _waypoint = _squad addWaypoint [_waypointPos, 0];
				_waypoint setWaypointSpeed (selectRandom ["limited", "limited", "normal", "full"]);
				if (random 10 > 5) then {_waypoint setWaypointTimeout [0, 60, 30]} else {_waypoint setWaypointTimeout [0, 0, 0]};
				if (_i == 5) then {_waypoint setWaypointType "cycle"};
			};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT BOAT READY !";
				[_position, "mil_warning", "ColorYellow", "BOAT"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {_driver call Gemini_fnc_isUnplayedArea};
		OPEX_ambientCivilianBoats = OPEX_ambientCivilianBoats - 1; publicVariable "OPEX_ambientCivilianBoats";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};