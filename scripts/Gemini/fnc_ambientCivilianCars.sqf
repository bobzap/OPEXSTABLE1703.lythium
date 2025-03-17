// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientCivilianCars = 0; publicVariable "OPEX_ambientCivilianCars";
waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
sleep 3;

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// ADJUSTING LIMIT
		private _maxCars = 10;

		// CHECKING IF PLAYER IS MOVING TOO FAST (E.G.: INSIDE A HELICOPTED) AND IF LIMIT HAS BEEN REACHED ALREADY
		//if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientCivilianCars >= _maxCars)) exitWith {};
		private _allPlayers = allPlayers - entities "HeadlessClient_F"; if (count _allPlayers == 0) exitWith {};
		if ((count (_allPlayers select {speed _x < 20}) == 0) || (OPEX_ambientCivilianCars >= _maxCars)) exitWith {};

		// SELECTING A RANDOM PLAYER
		//private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});
		private _player = selectRandom (_allPlayers select {speed _x < 20});

		// LOOKING FOR NEARBY BUILDINGS
		private _nearbyBuildings = [];
		_nearbyBuildings = [_player, OPEX_spawnDistanceMaxi] call Gemini_fnc_findBuildings;
		if (count _nearbyBuildings == 0) exitWith {};

		// DEFINING LOCATION CARS AMOUNT
		private _maxCarsNearby = 1 max (round (count _nearbyBuildings / 25)); // 1 car for 25 houses
		private _carsNearbyPlayer = (_player nearEntities ["Car", OPEX_spawnDistanceMaxi]) select {((typeOf _x) in OPEX_civilian_vehicles) && (!(_x call Gemini_fnc_isInSafeLocation))};
		if (_maxCarsNearby <= count _carsNearbyPlayer) exitWith {};

		// checking current count
		if (OPEX_ambientCivilianCars >= _maxCars) exitWith {};

		// selecting a random building
		private _building = selectRandom _nearbyBuildings;

		// checking if a vehicle is already nearby
		private _nearbyCars = (_building nearEntities ["Car", 50]) select {((typeOf _x) in OPEX_civilian_vehicles) && (!(_x call Gemini_fnc_isInSafeLocation))};
		if (count _nearbyCars == 0) then
			{
				// looking for an empty position around the building
				private _emptyPosition = [_building, 5, 50, 15, 0, 0.35, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (count _emptyPosition > 0) then
					{
						private _randomCar = selectRandom OPEX_civilian_vehicles;
						private _car = [_randomCar, _emptyPosition] call Gemini_fnc_createVehicle;
						OPEX_ambientCivilianCars = OPEX_ambientCivilianCars + 1; publicVariable "OPEX_ambientCivilianCars";
						// waiting for the end, then updated cars count
						_car spawn
							{
								sleep 3;
								[_this] call Gemini_fnc_parkVehicle;
								waitUntil {!alive _this};
								OPEX_ambientCivilianCars = OPEX_ambientCivilianCars - 1; publicVariable "OPEX_ambientCivilianCars";
							};
					};
			};
	};

while {true} do {sleep 5; [] call _mainFunction};