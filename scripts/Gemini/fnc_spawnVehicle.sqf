/*
	FUNCTION TO SPAWN AN EMPTY VEHICLE (WITH OPTIONNAL GUARDIANS) THAT COULD BE USED BY AI BY IF NECESSARY
	vehicle = [vehicleTypes, position, side, radius, guardians, probability] call Gemini_fnc_spawnVehicle
	_vehicle = [(OPEX_enemy_armored + OPEX_enemy_motorizedVehicles), position, OPEX_enemy_side1, 50, [OPEX_enemy_units, 5], 0.5] call Gemini_fnc_spawnVehicle
	_vehicle = [["isc_is_offroad_M2_o"], OPEX_enemy_side1, getPos player, 100, 0, 1.0] call Gemini_fnc_spawnVehicle
*/

waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};

private _vehicleType = selectRandom (_this select 0);
private _side = _this select 1;
private _center = _this select 2;
private _radius = _this select 3; if (_radius isEqualType 0) then {_radius = [0, _this select 3]};
private _guardianTypes = _this select 4 select 0;
private _guardianAmount = _this select 4 select 1;
private _probability = _this select 5;
private _lifeTime = param [6, "distance", [""]];

if (random 100 <= _probability) then
	{
		// LOOKING FOR AN EMPTY POSITION
		private ["_emptyPos"];
		if (_radius isEqualTo [0,0]) then {_emptyPos = _center} else {_emptyPos = ["land", _center, _radius select 0, _radius select 1, 10] call Gemini_fnc_findPos};

		// SPAWNING VEHICLE
		private _vehicle = [_vehicleType, _emptyPos, random 360, true, _lifeTime] call Gemini_fnc_createVehicle;

		//if (random 1 > 0.5) then {[_vehicle] call Gemini_fnc_parkVehicle};

		// IF NECESSARY, SPAWNING CREW NEXT TO THE VEHICLE
		if (_guardianAmount > 0)
		then
			{
				private _squadPos = (position _vehicle) findEmptyPosition [10, 20, "I_soldier_F"];
				if (count _squadPos == 0) then {_squadPos = ["land", _vehicle, 0, 20, 1] call Gemini_fnc_findPos};
				private _squad = createGroup _side;
				for "_i" from 1 to _guardianAmount do
					{
						private _unit = [OPEX_enemy_side1, _squad, _guardianTypes, _squadPos getPos [1, random 360], OPEX_enemy_AIskill, false, _lifeTime] call Gemini_fnc_createUnit
					};
				_squad setBehaviour "safe";
				[_squad, _squadPos, [5,25]] call Gemini_fnc_doTalk;
			};
		[_vehicle, _side, 25] spawn Gemini_fnc_boardVehicleIfDanger;

		// RETURNING SPAWNED VEHICLE
		_vehicle
	};