// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyReinforcements = 0; publicVariable "OPEX_ambientEnemyReinforcements";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// ADJUSTING LIMIT
		private _maxReinforcements = 1;
		if (count OPEX_playingPlayers <= 3) then {_maxReinforcements = 3};
		if ((count OPEX_playingPlayers > 3) && (count OPEX_playingPlayers <= 9)) then {_maxReinforcements = 5};
		if (count OPEX_playingPlayers > 9) then {_maxReinforcements = 10};

		// GETTING SPOTTED PLAYERS
		private _spottedPlayers = [];
		{if (OPEX_enemy_side1 knowsAbout _x > 3.5) then {_spottedPlayers append [_x]}} forEach OPEX_playingPlayers;

		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (count _spottedPlayers == 0) || (OPEX_ambientEnemyReinforcements >= _maxReinforcements) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyReinforcements = OPEX_ambientEnemyReinforcements + 1; publicVariable "OPEX_ambientEnemyReinforcements";

		// SPAWNING ENEMIES
		private _squad = [OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], selectRandom [3,3,3,5,5,5,5,5,8,10,12,15,20], _player, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], "attack", _player, OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
		if (isNil "_squad") exitWith {OPEX_ambientEnemyReinforcements = OPEX_ambientEnemyReinforcements - 1; publicVariable "OPEX_ambientEnemyReinforcements";};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT REINFORCEMENTS READY !";
				[position (leader _squad), "mil_warning", "ColorRed", "REINFORCEMENTS"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {(!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
		OPEX_ambientEnemyReinforcements = OPEX_ambientEnemyReinforcements - 1; publicVariable "OPEX_ambientEnemyReinforcements";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};