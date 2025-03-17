// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientFriendlyRoadblock = 0; publicVariable "OPEX_ambientFriendlyRoadblock";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientFriendlyRoadblock >= 1) || (random 100 > 20)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock + 1; publicVariable "OPEX_ambientFriendlyRoadblock";

		// LOOKING FOR A RANDOM ROAD AROUND SELECTED PLAYER
		private _roadPos = ["road", _player] call Gemini_fnc_findPos;
		if (_roadPos isEqualTo [0,0,0]) exitWith {OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock - 1; publicVariable "OPEX_ambientFriendlyRoadblock"};
		private _roadPos = (_roadPos nearRoads 15) select 0;

		// LOOKING FOR CONNECTED ROADS
		private _nearRoads = _roadPos nearRoads 50;
		if (count _nearRoads < 3) exitWith {OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock - 1; publicVariable "OPEX_ambientFriendlyRoadblock"};
		private _road = _nearRoads select 0;
		private _connectedRoads = [];
		_connectedRoads = roadsConnectedTo _road;
		if (count _connectedRoads < 2) exitWith {OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock - 1; publicVariable "OPEX_ambientFriendlyRoadblock"};
		private _road1 = _connectedRoads select 0;
		private _road2 = _connectedRoads select 1;
		private _roadDir = [_road, _road1] call BIS_fnc_DirTo;
		private _roadPos = getPosATL _road;
		private _dir1 = [_road, _road1] call BIS_fnc_dirTo;
		private _dir2 = [_road, _road2] call BIS_fnc_dirTo;

		// CHECKING IF ENEMIES ARE NEARBY (to avoid roadblocks proximity)
		private _nearbyEnemies = (_roadPos nearEntities 250) select {side _x == OPEX_enemy_side1};
		if (count _nearbyEnemies > 0) exitWith {OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock - 1; publicVariable "OPEX_ambientFriendlyRoadblock"};

		// SPAWNING ROADBLOCK
		private _roadblock = selectRandom ["compositions\friendlyRoadblock_a.sqf", "compositions\friendlyRoadblock_b.sqf", "compositions\friendlyRoadblock_c.sqf"];
		0 = [_roadPos, selectRandom [_dir1, _dir2], call (compile (preprocessFileLineNumbers _roadblock))] call BIS_fnc_ObjectsMapper;
		private _lightSources = ["Land_PortableLight_single_F", "Land_PortableLight_double_F", "MetalBarrel_burning_F", "Campfire_burning_F", "RoadBarrier_small_F", "RoadCone_L_F"];
		{
			_x setVectorUp (surfaceNormal (position _x));
			_x setPosATL [(getPos _x select 0), (getPos _x select 1), 0];
			if (!(typeOf _x in _lightSources)) then {_x enableSimulationGlobal false};
			[_x] call Gemini_fnc_setLifeTime;
		} forEach (nearestObjects [_roadPos, ["all"], 20]);

		// SPAWNING VEHICLES
		[OPEX_friendly_mechanizedVehicles, OPEX_friendly_side1, _roadPos, [10,40], [OPEX_friendly_commonUnits, ceil (random 3)], 75] call Gemini_fnc_spawnVehicle;
		[OPEX_friendly_mechanizedVehicles, OPEX_friendly_side1, _roadPos, [10,40], [OPEX_friendly_commonUnits, ceil (random 3)], 50] call Gemini_fnc_spawnVehicle;

		// SPAWNING FRIENDS
		private _squad = [OPEX_friendly_side1, ["infantry"], selectRandom [4,6,8], _roadPos, [0, 20], "wait", objNull, OPEX_friendly_AIskill, 100] call Gemini_fnc_spawnSquad;
		if (isNil "_squad") exitWith {};
		{_x setDir (selectRandom [_dir1, _dir2])} forEach units _squad;
		[_roadPos, 25, -1, OPEX_friendly_side1, OPEX_friendly_commonUnits, OPEX_friendly_AIskill] call Gemini_fnc_spawnUnitsStandingInside;
		[OPEX_friendly_side1, ["infantry"], selectRandom [2,2,3,3,3,5], _roadPos, [10, 100], "patrol", _roadPos, OPEX_friendly_AIskill, 75] call Gemini_fnc_spawnSquad;

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT ROADBLOCK READY !";
				[_roadPos, "mil_warning", "ColorBlue", "ROADBLOCK"] call Gemini_fnc_createMarker;
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {!([_roadPos] call Gemini_fnc_isPlayerNearby)};
		OPEX_ambientFriendlyRoadblock = OPEX_ambientFriendlyRoadblock - 1; publicVariable "OPEX_ambientFriendlyRoadblock";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};