private _unit = param [0, objNull, [objNull]];
private _group = group _unit;
private _units = units _group;
private _players = _units select {isPlayer _x};

private ["_result"];
if (count _players > 0) then {_result = true} else {_result = false};

_result