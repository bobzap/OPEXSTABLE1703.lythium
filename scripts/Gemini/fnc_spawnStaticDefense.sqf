/*
	[POSITION, STATIC_CLASS, SIDE, AZIMUTH, PRECISION, GUARDIANS AMOUNT, PROBABILITY] spawn Gemini_fnc_spawnStaticDefense;
	[position player, [OPEX_enemy_MGstatics, OPEX_enemy_side1], 50, (ceil random 2)] spawn Gemini_fnc_spawnStaticDefense;
	[position player, OPEX_enemy_MGstatics + OPEX_enemy_mortarStatics, OPEX_enemy_side1, 100, 5] spawn Gemini_fnc_spawnStaticDefense;
	[_position, OPEX_enemy_statics, OPEX_enemy_side1, _azimuth, 0, ceil (random 2), 0.4] spawn Gemini_fnc_spawnStaticDefense;
*/

	// PRIVATIZING VARIABLES
	private ["_position", "_staticType", "_side", "_azimuth", "_radius", "_guardians", "_probability", "_composition", "_flatPosition"];

	// GETTING ARGUMENTS
	_position = _this select 0;
	_staticType = selectRandom (_this select 1);
	_side = _this select 2;
	_azimuth = _this select 3;
	_radius = _this select 4;
	_guardians = _this select 5;
	_probability = _this select 6;
	private _lifeTime = param [7, "distance", [""]];

	if (random 1 <= _probability) then
		{
			// GETTING COMPOSITION PATH
			if (_radius > 0) then
				{
					if ((_staticType in OPEX_enemy_MGstatics) || (_staticType in OPEX_friendly_MGstatics)) then {_composition = "compositions\mg_360.sqf"};
					if ((_staticType in OPEX_enemy_ATstatics) || (_staticType in OPEX_friendly_ATstatics)) then {_composition = "compositions\at_360.sqf"};
					if ((_staticType in OPEX_enemy_AAstatics) || (_staticType in OPEX_friendly_AAstatics)) then {_composition = "compositions\aa_360.sqf"};
					if ((_staticType in OPEX_enemy_mortarStatics) || (_staticType in OPEX_friendly_mortarStatics)) then {_composition = "compositions\mortar_360.sqf"};
					_flatPosition = ["land_isolated", _position, 0, _radius, 10] call Gemini_fnc_findPos;
				}
			else
				{
					if ((_staticType in OPEX_enemy_MGstatics) || (_staticType in OPEX_friendly_MGstatics)) then {_composition = "compositions\mg.sqf"};
					if ((_staticType in OPEX_enemy_ATstatics) || (_staticType in OPEX_friendly_ATstatics)) then {_composition = "compositions\at.sqf"};
					if ((_staticType in OPEX_enemy_AAstatics) || (_staticType in OPEX_friendly_AAstatics)) then {_composition = "compositions\aa.sqf"};
					if ((_staticType in OPEX_enemy_mortarStatics) || (_staticType in OPEX_friendly_mortarStatics)) then {_composition = "compositions\mortar.sqf"};
					_flatPosition = _position;
				};

			// TEMP FIX
			if (isNil "_composition") exitWith {};
			if (isNil "_flatPosition") exitWith {};

			// SPAWNING COMPOSITION
			0 = [_flatPosition, _azimuth, [_side] call (compile (preprocessFileLineNumbers _composition))] call BIS_fnc_ObjectsMapper;
			{
				_x setVectorUp (surfaceNormal (position _x));
				_x setPosATL [(getPos _x select 0), (getPos _x select 1), 0];
				[_x, _lifeTime] call Gemini_fnc_setLifeTime;
			} forEach (nearestObjects [_flatPosition, ["all"], 10]);

			// CREATING GUARDIANS (IF REQUIRED)
			if (_guardians > 0) then {private _squad = [OPEX_enemy_side1, ["infantry"], _guardians, _flatPosition, [0, 15], "talk", [], OPEX_enemy_AIskill, 100, _lifeTime] call Gemini_fnc_spawnSquad};

			// MAKING NEAREST AI BOARDING INTO THE STATIC DEFENSE IN CASE ENEMY HAS BEEN SPOTTED
			_static = _flatPosition nearestObject _staticType;
			[_static, _side, 25] spawn Gemini_fnc_boardVehicleIfDanger;

			// DEBUGGING
			if (OPEX_debug) then
				{
					private ["_debugMarker"];
					_debugMarker = createMarker [format ["OPEX_debugMarker_staticDefense_%1", random 100000], _flatPosition];
					_debugMarker setMarkerType "mil_dot";
					_debugMarker setMarkerColor "ColorOrange";
					[_static, _debugMarker] spawn
						{
							while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
							deleteMarker (_this select 1);
						};
				};
		};