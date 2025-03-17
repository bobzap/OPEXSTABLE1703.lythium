/*
	all credits must goes to killzone_kid
	https://forums.bistudio.com/topic/191215-setvehiclevarname-and-remoteexec/
*/

params ["_vehicle", "_vehicleName"];

missionNamespace setVariable [_vehicleName, _vehicle, true];
_vehicle setVehicleVarName _vehicleName;