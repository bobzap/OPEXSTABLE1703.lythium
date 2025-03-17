private _entity = param [0, objNull, [objNull, []]];
private _distance = param [1, OPEX_spawnDistanceMini, [0]];

if (typeName _entity isEqualTo "OBJECT") then {if (getPos _entity select 2 > 25) then {_distance = _distance * 3}}; // increasing max distance in case checked object is flying
if ({(_x distance2D _entity <= _distance) && (side _x == OPEX_friendly_side1)} count (allUnits) > 0) then {true} else {false};