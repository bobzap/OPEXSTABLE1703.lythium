// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyBivouacs = 0; publicVariable "OPEX_ambientEnemyBivouacs";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// ADJUSTING LIMIT
		private _maxBivouacs = 1;
		if (count OPEX_playingPlayers <= 3) then {_maxBivouacs = 1};
		if ((count OPEX_playingPlayers > 3) && (count OPEX_playingPlayers <= 9)) then {_maxBivouacs = 2};
		if (count OPEX_playingPlayers > 9) then {_maxBivouacs = 3};

		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyBivouacs >= _maxBivouacs) || (random 100 > 25)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyBivouacs = OPEX_ambientEnemyBivouacs + 1; publicVariable "OPEX_ambientEnemyBivouacs";

		// LOOKING FOR A RANDOM ABANDONED AREA AROUND SELECTED PLAYER
		private _position = ["land_isolated", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.9, 5] call Gemini_fnc_findPos;
		if (_position isEqualTo [0,0,0]) exitWith {OPEX_ambientEnemyBivouacs = OPEX_ambientEnemyBivouacs - 1; publicVariable "OPEX_ambientEnemyBivouacs";};

		// SPAWNING BIVOUAC
		private _lightSource = [["Campfire_burning_F"], ["land", _position, 1, 10, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource] call Gemini_fnc_createVehicle;
		for "_i" from 1 to (round random 3) do {private _woodPile = [["Land_WoodenLog_F", "Land_WoodPile_F", "Land_WoodPile_large_F"], ["land", _lightSource, 1, 10, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle};
		for "_i" from 1 to (round random 5) do {private _tent = [["Land_TentA_F", "Land_TentDome_F"], ["land", _lightSource, 1, 15, 3] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _tent] call Gemini_fnc_createVehicle};
		for "_i" from 1 to (round random 5) do {private _sleepingBag = [["Land_Sleeping_bag_F", "Land_Sleeping_bag_folded_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_blue_folded_F", "Land_Sleeping_bag_brown_F", "Land_Sleeping_bag_brown_folded_F"], ["land", _lightSource, 1, 15, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle; private _clutterCutter = ["Land_ClutterCutter_large_F", _sleepingBag] call Gemini_fnc_createVehicle};

		// SPAWNING ENEMIES
		[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,4,5], _lightSource, [2, 7.5], "talk", [], OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
		[OPEX_enemy_side1, ["infantry"], 2, _lightSource, [50, 100], "patrol", _lightSource, OPEX_enemy_AIskill, 75] call Gemini_fnc_spawnSquad;

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT BIVOUAC READY !";
				[_lightSource, "mil_warning", "ColorRed", "BIVOUAC"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {_position call Gemini_fnc_isUnplayedArea};
		OPEX_ambientEnemyBivouacs = OPEX_ambientEnemyBivouacs - 1; publicVariable "OPEX_ambientEnemyBivouacs";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};