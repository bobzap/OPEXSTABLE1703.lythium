if (isDedicated) exitWith {};

private _markerName = param [0, "", [""]];
private _markerText = param [1, "", [""]];

if (["STR_", _markerText, true] call BIS_fnc_inString) then {_markerName setMarkerTextLocal (localize _markerText)} else {_markerName setMarkerTextLocal _markerText};