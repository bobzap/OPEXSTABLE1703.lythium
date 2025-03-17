// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
sleep 3;

// GETTING CIVILIAN INTERACTIONS FUNCTIONS
[] call Gemini_fnc_civilianInteractionsFunctions;

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// COUNTING CURRENT POPULATION
		private _allPlayers = allPlayers - entities "HeadlessClient_F"; if (count _allPlayers == 0) exitWith {};
		private _maxCivilians = 50; // maximum 50 civilians at the same time
		if (count _allPlayers == 2) then {_maxCivilians = 100};
		if ((count _allPlayers > 2) && (count _allPlayers <= 5)) then {_maxCivilians = 150};
		if (count _allPlayers > 5) then {_maxCivilians = 200};
		private _allCivilians = {(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits;
		private _availableSlots = _maxCivilians - _allCivilians;

		// DEBUGGING
		private _debug = false;
		if (_debug) then {systemChat format ["[AMBIENT CIVILIAN LIFE] ALIVE CIVILIANS: %1/%2 (POTENTIAL: %3)", _allCivilians, _maxCivilians, _availableSlots]};

		// CHECKING IF PLAYER IS MOVING TOO FAST (E.G.: INSIDE A HELICOPTER) AND IF LIMIT HAS BEEN REACHED ALREADY
		if ((count (_allPlayers select {speed _x < 20}) == 0) || (_allCivilians >= _maxCivilians) || (_availableSlots <= 0)) exitWith {};

		// SELECTING A RANDOM PLAYER
		//private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});
		private _player = selectRandom (_allPlayers select {speed _x < 20});
		private _playerPos = position _player;

		// LOOKING FOR NEARBY BUILDINGS
		private _nearbyBuildings = [];
		_nearbyBuildings = [_player, OPEX_spawnDistanceMaxi] call Gemini_fnc_findBuildings;
		if (count _nearbyBuildings == 0) exitWith {};

		// DEFINING LOCATION POPULATION AMOUNT
		private _maxCiviliansPerLocation = 2 max (round (count _nearbyBuildings / 5)); // ratio = 1 civilian for 5 houses
		private _maxCiviliansNearby = _maxCiviliansPerLocation min 50; // maximum 50 civilians per location

		// CHECKING IF THE LOCATION HASN'T BEEN POPULATED ALREADY
		private _nearbyCivilians = [];
		_nearbyCivilians = (_player nearEntities ["Man", OPEX_spawnDistanceMaxi]) select {(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))};
		if (count _nearbyCivilians >= _maxCiviliansNearby) exitWith {};

		// POPULATING LOCATION
		for "_i" from 1 to ((_maxCiviliansNearby - count _nearbyCivilians) min _maxCivilians) do
			{
				sleep 0.5;
				if (_player distance2D _playerPos > 100) exitWith {}; // canceling current spawn process if player has moved too far from its initial position
				if ({(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits < _maxCivilians) then
					{
						// LOOKING FOR A POSITION INSIDE A BUILDING
						private _randomBuilding = selectRandom _nearbyBuildings;
						private _buildingPositions = [];
						_buildingPositions = _randomBuilding buildingPos -1;
						private ["_randomPos"];
						if (count _buildingPositions > 0)
						then {_randomPos = selectRandom _buildingPositions}
						else {_randomPos = [[[position _randomBuilding, 50]],["water"]] call BIS_fnc_randomPos};
						// SPAWNING CIVILIAN
						private _civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _randomPos, OPEX_civilian_AIskill] call Gemini_fnc_createUnit;
					};
			};
	};

while {true} do {sleep 5; [] call _mainFunction};