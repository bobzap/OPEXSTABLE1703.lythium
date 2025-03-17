// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyAmbushes = 0; publicVariable "OPEX_ambientEnemyAmbushes";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyAmbushes >= 1) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyAmbushes = OPEX_ambientEnemyAmbushes + 1; publicVariable "OPEX_ambientEnemyAmbushes";

		// LOOKING FOR A RANDOM ROAD AROUND SELECTED PLAYER
		private _roadPos = ["road", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.8] call Gemini_fnc_findPos;
		if (_roadPos isEqualTo [0,0,0]) exitWith {OPEX_ambientEnemyAmbushes = OPEX_ambientEnemyAmbushes - 1; publicVariable "OPEX_ambientEnemyAmbushes";};

		// SPAWNING AMBUSH
		for "_i" from 1 to (selectRandom [1,1,1,2,2,2,3,3,4,5]) do
			{
				private _overwatchPos = ["overwatch", _roadPos, 75, 500] call Gemini_fnc_findPos;
				if (_overwatchPos isEqualTo [0,0,0]) exitWith {};
				private _squad = [OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,8,10,12,15], _overwatchPos, [0,0], "hold", _overwatchPos, OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
			};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT AMBUSH READY !";
				[_roadPos, "mil_warning", "ColorRed", "AMBUSH"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {_roadPos call Gemini_fnc_isUnplayedArea};
		OPEX_ambientEnemyAmbushes = OPEX_ambientEnemyAmbushes - 1; publicVariable "OPEX_ambientEnemyAmbushes";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};