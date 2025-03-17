/*
	all credits must goes to killzone_kid
	https://forums.bistudio.com/topic/191215-setvehiclevarname-and-remoteexec/
*/

params ["_unit", "_baseName"];

// setting name dynamically
_unitName = (_baseName + (str (round (random 999999))));

// broadcasting it to every computer
missionNamespace setVariable [_unitName, _unit, true];
[_unit, _unitName] remoteExec ["setVehicleVarName", 0, _unit];