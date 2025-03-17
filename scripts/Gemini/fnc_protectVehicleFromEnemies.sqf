waitUntil {!isNil "OPEX_param_protectedHQ"};

if (OPEX_param_protectedHQ == 0) exitWith {};
if (!isServer) exitWith {};

private ["_vehicle", "_radius"];

_vehicle = _this select 0;
_radius = _this select 1;

private ["_trigger"];
_trigger = createTrigger ["EmptyDetector", position _vehicle];
_trigger setTriggerArea [_radius, _radius, 0, false];
_trigger setTriggerActivation [OPEX_enemy_side2, "PRESENT", true];
//_trigger setTriggerStatements ["this", "{{deleteVehicle _x} forEach ((crew _x) + (units group _x) + [_x])} forEach thisList", ""];
_trigger setTriggerStatements ["this", "", ""];

_trigger attachTo [_vehicle, [0,3,0]];

OPEX_locations_safe = OPEX_locations_safe + [_trigger]; publicVariable "OPEX_locations_safe";