// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyCaches = 0; publicVariable "OPEX_ambientEnemyCaches";

if (count OPEX_locations_isolated == 0) exitWith {};

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyCaches >= 1) || (random 100 > 20)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyCaches = OPEX_ambientEnemyCaches + 1; publicVariable "OPEX_ambientEnemyCaches";

		// LOOKING FOR THE NEAREST ISOLATED LOCATION AROUND SELECTED PLAYER
		private _locationPos = ["isolated", _player] call Gemini_fnc_findPos;
		if (_locationPos isEqualTo [0,0,0]) exitWith {OPEX_ambientEnemyCaches = OPEX_ambientEnemyCaches - 1; publicVariable "OPEX_ambientEnemyCaches";};
		_locationSize = ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0) max ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1);

		// SPAWNING AMMO CRATE
		private _crateType = selectRandom OPEX_enemy_cacheCrates;
		private _cratePos = ["land", _locationPos, 0, _locationSize / 2, 5] call Gemini_fnc_findPos;
		private _crate = [_crateType, _cratePos] call Gemini_fnc_createVehicle;
		//_crate setVariable ["R3F_LOG_disabled", true, true];
		clearWeaponCargoGlobal _crate; clearMagazineCargoGlobal _crate; clearItemCargoGlobal _crate; clearBackpackCargoGlobal _crate;
		for "_i" from 1 to (count OPEX_enemy_commonRifles) do {_crate addItemCargoGlobal [(OPEX_enemy_commonRifles select _i), ceil random 15]};
		for "_i" from 1 to (count OPEX_enemy_ATlaunchers) do {_crate addItemCargoGlobal [(OPEX_enemy_ATlaunchers select _i), ceil random 5]};
		{_crate addItemCargoGlobal [(getArray (configfile >> "CfgWeapons" >> _x >> "magazines")) select 0, ceil random 50]} forEach OPEX_enemy_commonRifles;
		{_crate addItemCargoGlobal [(getArray (configfile >> "CfgWeapons" >> _x >> "magazines")) select 0, ceil random 10]} forEach (OPEX_enemy_ATlaunchers + OPEX_enemy_AAlaunchers);
		for "_i" from 1 to (count OPEX_enemy_handGrenades) do {_crate addItemCargoGlobal [(OPEX_enemy_handGrenades select _i), ceil random 25]};

		// SPAWNING A TRUCK
		private _truckType = selectRandom OPEX_enemy_transportTrucks;
		private _truckPos = ["land", _cratePos, 5, _locationSize, 10] call Gemini_fnc_findPos;
		private _truck = [_truckType, _truckPos] call Gemini_fnc_createVehicle;
		_nearRoads = _crate nearRoads 35;
		if (count _nearRoads > 1)
			then {_truck setPos (position (_nearRoads select 0)); _truck setDir ([(_nearRoads select 0), (_nearRoads select 1)] call BIS_fnc_DirTo)}
			else {_dir = [_truck, _crate] call BIS_fnc_relativeDirTo; _truck setDir (_dir + 180)};
		if (_truck distance _crate > 50) then {deleteVehicle _truck};

		// SPAWNING ENEMIES
		[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _crate, [2, 10], "talk", [], OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
		[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _crate, [10, 200], "patrol", _crate, OPEX_enemy_AIskill, 75] call Gemini_fnc_spawnSquad;
		[_crate, 50, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingInside;
		[_locationPos, _locationSize, selectRandom [2,3,5], OPEX_enemy_side1, [OPEX_enemy_rifleman, OPEX_enemy_grenadier, OPEX_enemy_MG], OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingOutside;

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT ENEMY CACHE READY !";
				[_crate, "mil_warning", "ColorRed", "CACHE"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {(_locationPos call Gemini_fnc_isUnplayedArea) || (damage _crate >= 0.15)};
		if (damage _crate >= 0.15) then {"HelicopterExploBig" createvehicle _cratePos; "Bomb_04_F" createvehicle _cratePos; {_x setDamage 1} forEach (_crate nearEntities 15); deleteVehicle _crate; ["cacheDestroyed"] call Gemini_fnc_updateStats};
		OPEX_ambientEnemyCaches = OPEX_ambientEnemyCaches - 1; publicVariable "OPEX_ambientEnemyCaches";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};