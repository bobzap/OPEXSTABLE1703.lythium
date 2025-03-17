// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientFriendlyBoats = 0; publicVariable "OPEX_ambientFriendlyBoats";

// CHECKING IF MAP HAS ENOUGH WATER
if (isNil "OPEX_mapWater") exitWith {};
if (!OPEX_mapWater) exitWith {};

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientFriendlyBoats >= 1) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientFriendlyBoats = OPEX_ambientFriendlyBoats + 1; publicVariable "OPEX_ambientFriendlyBoats";

		// LOOKING FOR A RANDOM POSITION AROUND SELECTED PLAYER
		private _position = ["water", _player] call Gemini_fnc_findPos;
		if (_position isEqualTo [0,0,0]) exitWith {OPEX_ambientFriendlyBoats = OPEX_ambientFriendlyBoats - 1; publicVariable "OPEX_ambientFriendlyBoats";};

		// SPAWNING BOAT & CREW
		private _boat = [selectRandom (OPEX_friendly_zodiacs + OPEX_friendly_ships), _position] call Gemini_fnc_createVehicle;
		private _squad = createGroup OPEX_friendly_side1;
		private _driver = [OPEX_friendly_side1, grpNull, [OPEX_friendly_rifleman], _position, OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
		_driver moveInDriver _boat;
		_driver setBehaviour "careless";
		[_driver] joinSilent _squad;
		for "_i" from 1 to (round random (_boat emptyPositions "cargo")) do
			{
				private _cargo = [OPEX_friendly_side1, grpNull, [OPEX_friendly_rifleman, OPEX_friendly_assault, OPEX_friendly_diver, OPEX_friendly_diver], _position, OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
				_cargo moveInCargo _boat;
				_cargo setBehaviour "careless";
				[_cargo] joinSilent _squad;
			};
		if (_boat emptyPositions "gunner" > 0) then
			{
				private _gunner = [OPEX_friendly_side1, grpNull, [OPEX_friendly_rifleman], _position, OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
				_gunner moveInGunner _boat;
				_gunner setBehaviour "careless";
				[_gunner] joinSilent _squad;
			};
		if (_boat emptyPositions "commander" > 0) then
			{
				private _commander = [OPEX_friendly_side1, grpNull, [OPEX_friendly_teamLeader], _position, OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
				_commander moveInCommander _boat;
				_commander setBehaviour "careless";
				[_commander] joinSilent _squad;
			};

		// CREATING WAYPOINTS
		for "_i" from 1 to 5 do
			{
				private _waypointPos = ["water", _driver, 100, 500] call Gemini_fnc_findPos;
				private _waypoint = _squad addWaypoint [_waypointPos, 0];
				_waypoint setWaypointSpeed (selectRandom ["limited", "normal", "normal", "full"]);
				if (_i == 5) then {_waypoint setWaypointType "cycle"};
			};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT BOAT READY !";
				[_position, "mil_warning", "ColorBlue", "BOAT"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {!([_boat] call Gemini_fnc_isPlayerNearby)};
		OPEX_ambientFriendlyBoats = OPEX_ambientFriendlyBoats - 1; publicVariable "OPEX_ambientFriendlyBoats";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};