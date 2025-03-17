/*
	This function spawns standing units.

	example:
	[OPEX_mapCenter, OPEX_mapRadius, 10, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingInside;
*/

// GETTING ARGUMENTS
private _position = param [0, OPEX_mapCenter, [[], objNull]]; if (typeName (_this select 0) == "OBJECT") then {_position = position (_this select 0)};
private _radius = param [1, OPEX_mapRadius, [4096]];
private _quantity = param [2, -1, [-1]];
private _side = param [3, OPEX_enemy_side1, [east]];
private _types = param [4, OPEX_enemy_units, [["I_soldier_F"]]];
private _skill = param [5, OPEX_enemy_AIskill, [[0.25, 0.5]]];
private _lifeTime = param [6, "distance", [""]];

if ((_quantity == -1) && (random 100 < 10)) exitWith {};

// GETTING ALL BUILDINGS
private _buildings = nearestObjects [_position, ["house"], _radius];
if (count _buildings == 0) exitWith {};

// REMOVING UNWANTED BUILDINGS
private _blacklist =
	[
		"Land_Pier_F"
	];
{if (typeOf _x in _blacklist) then {_buildings = _buildings - [_x]}} forEach _buildings;

// GETTING FREE BUILDING POSITIONS
private _allBuildingPositions = [];
{
	private _buildingPositions = (_x call BIS_fnc_buildingPositions) select {count (_x nearEntities ["Man", 2]) == 0};
	if (count _buildingPositions > 0) then {_allBuildingPositions append _buildingPositions};
} forEach _buildings;
if (count _allBuildingPositions == 0) exitWith {};

// SHUFFLING POSITIONS
_allBuildingPositions call BIS_fnc_arrayShuffle;
_allBuildingPositions call BIS_fnc_arrayShuffle;
_allBuildingPositions call BIS_fnc_arrayShuffle;

// ADJUSTING QUANTITY
private _maxQuantity = count _allBuildingPositions;
if (count _allBuildingPositions <= 10) then {_maxQuantity = (count _allBuildingPositions) / 2};
if ((count _allBuildingPositions > 10) && (count _allBuildingPositions <= 20)) then {_maxQuantity = (count _allBuildingPositions) / 4};
if ((count _allBuildingPositions > 20) && (count _allBuildingPositions <= 50)) then {_maxQuantity = (count _allBuildingPositions) / 8};
if (count _allBuildingPositions > 50) then {_maxQuantity = (count _allBuildingPositions) / 12};
if (_quantity == -1) then {_quantity = ceil (random _maxQuantity)};
if (_quantity > _maxQuantity) then {_quantity = _maxQuantity};
if (_quantity < 1) exitWith {};

// SPAWNING UNITS
for "_i" from 1 to _quantity do
	{
		private _unit = [_side, grpNull, _types, _allBuildingPositions select _i, _skill, false, _lifeTime] call Gemini_fnc_createUnit;
		_unit setCombatMode "red";
		if (random 1 > 0.5) then {_unitAnim = selectRandom ["STAND", "STAND_IA", "SIT_LOW", "WATCH", "WATCH1", "WATCH2"]; [[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit]};
	};