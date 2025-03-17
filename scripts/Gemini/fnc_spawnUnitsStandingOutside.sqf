/*
	This function spawns standing units outside.

	example:
	[OPEX_mapCenter, OPEX_mapRadius, 10, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingOutside;
*/

// GETTING ARGUMENTS
private _position = param [0, OPEX_mapCenter, [[], objNull]]; if (typeName (_this select 0) == "OBJECT") then {_position = position (_this select 0)};
private _radius = param [1, [0, OPEX_mapRadius], [0, []]]; if (_radius isEqualType 0) then {_radius = [0, _this select 1]};
private _quantity = param [2, -1, [0]];
private _side = param [3, OPEX_enemy_side1, [east]];
private _types = param [4, OPEX_enemy_units, [[], ""]]; if (typeName _types == "STRING") then {_types = [_types]};
private _skill = param [5, OPEX_enemy_AIskill, [[0.25, 0.5]]];
private _lifeTime = param [6, "distance", [""]];

// ADJUSTING QUANTITY
if ((_quantity == -1) && (random 100 < 10)) exitWith {};
if (_quantity == -1) then {_quantity = ceil (random 12)};
if (_quantity == 0) exitWith {};
if (_quantity > 12) then {_quantity = 12};

// SPAWNING UNITS
for "_i" from 1 to _quantity do
	{
		private _unitPos = ["land", _position, _radius select 0, _radius select 1, 1] call Gemini_fnc_findPos;
		_unit = [_side, grpNull, _types, _unitPos, _skill, false, _lifeTime] call Gemini_fnc_createUnit;
		_unit setCombatMode "red";
		_unit setDir (random 360);
		if (random 1 > 0.5) then {_unitAnim = selectRandom ["STAND", "STAND_IA", "SIT_LOW", "WATCH", "WATCH1", "WATCH2"]; [[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit]};
	};