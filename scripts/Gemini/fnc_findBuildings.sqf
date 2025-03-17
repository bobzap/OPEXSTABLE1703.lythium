/*
	function to search for buildings, according to required parameters
	returns: array of buildings (or empty array if none is found)

	[(position player), 100] call Gemini_fnc_findBuildings;


*/

/*
private ["_createMarker"];
_createMarker =
{
	private ["_position", "_marker"];
	_position = _this select 0;
	_marker = createMarker [format ["marker_%1", random 100000], _position];
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor "colorGreen";
};
*/

private ["_position", "_radius"];
_position = _this select 0;
_radius = _this select 1;

private _isEnterable = {[_x, 3] call BIS_fnc_isBuildingEnterable};
private _isNotBlacklisted = {!((typeOf _x) in ["Land_HouseV2_03", "Land_Nasypka", "Land_Pier_F", "Land_Radar_F"])};
private _isNotMilitary = {!((["cargo", typeOf _x] call BIS_fnc_inString) || (["office", typeOf _x] call BIS_fnc_inString))};
private _isNotTooClose = {!([_x, OPEX_spawnDistanceMini] call Gemini_fnc_isPlayerNearby)};
private _isNotInSafeArea = {!([_x] call Gemini_fnc_isInSafeLocation)};

private _validPosition = {call _isEnterable && call _isNotBlacklisted && call _isNotMilitary && call _isNotTooClose && call _isNotInSafeArea};

private _buildings = (nearestTerrainObjects [_position, ["House"], _radius]) select {call _validPosition};

//{[_x, "mil_objective", "colorPink", "", "unlimited"] call Gemini_fnc_createMarker} forEach _buildings;

_buildings