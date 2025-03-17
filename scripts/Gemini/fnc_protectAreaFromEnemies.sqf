waitUntil {!isNil "OPEX_param_protectedHQ"};
if (OPEX_param_protectedHQ == 0) exitWith {};
if (!isServer) exitWith {};

private ["_safeAreas"];
_safeAreas = OPEX_locations_safe;

if (isNil "OPEX_locations_safe") exitWith {};
if (count _safeAreas == 0) exitWith {};

while {true} do
	{
		sleep 10;
		{
			private ["_neabyUnits"];
			_neabyUnits = (position _x) nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], (triggerArea _x select 0) max (triggerArea _x select 1)];
			{if ((side _x == OPEX_enemy_side1) && (!captive _x)) then {{deleteVehicle _x} forEach ((units group _x) + [_x])}} forEach _neabyUnits;
		} forEach _safeAreas;
	};