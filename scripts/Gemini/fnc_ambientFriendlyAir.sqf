// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
OPEX_ambientFriendlyAir = 0; publicVariable "OPEX_ambientFriendlyAir";
waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
sleep 3;

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientFriendlyAir >= 1) || (random 100 > 20)) exitWith {};
		private _allPlayers = allPlayers - entities "HeadlessClient_F";
		if ((count (_allPlayers select {speed _x < 20}) == 0) || (OPEX_ambientFriendlyAir >= 1) || (random 100 > 20)) exitWith {};

		// SELECTING A RANDOM PLAYER
		//private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});
		private _player = selectRandom (_allPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientFriendlyAir = OPEX_ambientFriendlyAir + 1; publicVariable "OPEX_ambientFriendlyAir";

		// LOOKING FOR A RANDOM POSITION AROUND SELECTED PLAYER
		private _position = ["any", _player, OPEX_spawnDistanceMaxi, OPEX_spawnDistanceMaxi * 2] call Gemini_fnc_findPos;
		if (_position isEqualTo [0,0,0]) exitWith {OPEX_ambientFriendlyAir = OPEX_ambientFriendlyAir - 1; publicVariable "OPEX_ambientFriendlyAir";};

		// RANDOMLY SELECTING CHOPPER OR AIRCRAFT
		private ["_type"];
		if (random 1 > 0.5) then {_type = "aircraft"} else {_type = "chopper"};
		private ["_class", "_height"];
		switch _type do
			{
				case "aircraft"	:	{_class = selectRandom OPEX_friendly_aircrafts; _height = selectRandom [1000,1200,1400,1600]};
				case "chopper"	:	{_class = selectRandom OPEX_friendly_choppers; _height = selectRandom [300,450,600]};
				default				{_class = selectRandom OPEX_friendly_choppers; _height = 600};
			};

		// CALCULATING DESTINATION
		private _trajectoryTemp = [_position, _player] call Gemini_fnc_trajectory;
		private _destinationTemp = [_trajectoryTemp select 0, _trajectoryTemp select 1, _height];
		private _trajectory = [_player, _destinationTemp] call Gemini_fnc_trajectory;
		private _destination = [_trajectory select 0, _trajectory select 1, _height];

		// SPAWNING VEHICLE
		private _spawnPos = [_position select 0, _position select 1, _height];
		private _azimuth = [_position, _player] call BIS_fnc_dirTo;
		private _vehicle = ([_spawnPos, _azimuth, _class, civilian] call BIS_fnc_spawnVehicle) select 0;
		_vehicle doMove _destination;
		sleep 1;
		_vehicle flyInHeight _height;
		_vehicle allowFleeing 0;
		_vehicle disableAI "target";
		_vehicle disableAI "autoTarget";
		_vehicle setSkill 1;
		_vehicle setCaptive true;
		[_vehicle, _destination] spawn
			{
				sleep 1;
				deleteWaypoint [(group driver (_this select 0)), 0];
				_wp = (group driver (_this select 0)) addWaypoint [(_this select 1), 0];
				_wp setWaypointType "move";
				_wp setWaypointBehaviour (selectRandom ["safe", "aware", "stealth", "combat"]);
				_wp setWaypointCombatMode "blue";
				_wp setWaypointSpeed (selectRandom ["normal", "full", "full"]);
			};
		[_vehicle, "distance"] call Gemini_fnc_setLifeTime;

		// DEBUGGING
		if (OPEX_debug) then
			{
				airVehicle = _vehicle;
				systemChat "AMBIENT AIR READY !";
				[_spawnPos, "mil_start", "ColorBlue", "AIR", "unlimited"] call Gemini_fnc_createMarker;
				[_destination, "mil_end", "ColorBlue", "AIR", "unlimited"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {!alive _vehicle};
		OPEX_ambientFriendlyAir = OPEX_ambientFriendlyAir - 1; publicVariable "OPEX_ambientFriendlyAir";
		{deleteVehicle _x} forEach ((crew _vehicle) + [_vehicle]);
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};