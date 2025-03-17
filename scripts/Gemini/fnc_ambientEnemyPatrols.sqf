// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyPatrols = 0; publicVariable "OPEX_ambientEnemyPatrols";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// ADJUSTING LIMIT
		private _maxPatrols = 1;
		if (count OPEX_playingPlayers <= 3) then {_maxPatrols = 2};
		if ((count OPEX_playingPlayers > 3) && (count OPEX_playingPlayers <= 9)) then {_maxPatrols = 4};
		if (count OPEX_playingPlayers > 9) then {_maxPatrols = 6};

		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyPatrols >= _maxPatrols) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyPatrols = OPEX_ambientEnemyPatrols + 1; publicVariable "OPEX_ambientEnemyPatrols";

		// SPAWNING ENEMIES
		private _squad = [OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], selectRandom [3,5,5,5,8,10,12,20], _player, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], "patrol", _player, OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
		if (isNil "_squad") exitWith {OPEX_ambientEnemyPatrols = OPEX_ambientEnemyPatrols - 1; publicVariable "OPEX_ambientEnemyPatrols";};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT PATROL READY !";
				[position (leader _squad), "mil_warning", "ColorRed", "PATROL"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {(!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
		OPEX_ambientEnemyPatrols = OPEX_ambientEnemyPatrols - 1; publicVariable "OPEX_ambientEnemyPatrols";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};