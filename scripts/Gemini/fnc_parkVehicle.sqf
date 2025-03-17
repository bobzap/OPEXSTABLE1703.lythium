/*
	examples:
	[_vehicle, 50] call Gemini_fnc_parkVehicle;
	[_vehicle] call Gemini_fnc_parkVehicle;
*/

private _vehicle = param [0, objNull, [objNull]];
private _vehiclePos = position _vehicle;

private ["_radius"];
if (count _this > 1) then {_radius = _this select 1} else {_radius = 15};

private _nearRoads = _vehiclePos nearRoads _radius;
if (count _nearRoads == 0) exitWith {};

private _road = _nearRoads select 0;

private _roadConnectedTo = roadsConnectedTo _road;
private _connectedRoad = _roadConnectedTo select 0;
private _roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;

_vehicle setDir _roadDirection;
_vehicle setPos getPos _vehicle;


/*
private _connectedRoads = [];
_connectedRoads = roadsConnectedTo _road;
if (count _connectedRoads < 2) exitWith {};

private _road1 = _connectedRoads select 0;
private _road2 = _connectedRoads select 1;
private _roadDir = [_road, _road1] call BIS_fnc_DirTo;
private _roadPos = getPosATL _road;
private _posX = (_roadPos select 0) + (4 * sin _roadDir);
private _posY = (_roadPos select 1) +  (4 * cos _roadDir);

private _roadSide = _road getRelPos [5,90]; // side of the road


if ([_roadSide, 10] call Gemini_fnc_isEmptyPos) then {_vehicle setDir _roadDir; _vehicle setPos _roadSide};

*/