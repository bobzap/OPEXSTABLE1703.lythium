private _testedPos = param [0, position (OPEX_locations_safe select 0), [[], objNull]]; if (typeName _testedPos == "OBJECT") then {_testedPos = position _testedPos};
private _outside = [];
for "_i" from 0 to (count OPEX_locations_safe) do {if (!(_testedPos inArea (OPEX_locations_safe select _i))) then {_outside append [_testedPos]}};
if (count _outside > 0) then {true} else {false};