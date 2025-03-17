private _debug = true;

private _position = param [0, [0,0,0], [[], objNull]]; if (_position isEqualType objNull) then {_position = position _position};
private _radius = param [1, 50, [0]];

private _north = lineIntersects [ATLToASL _position, ATLToASL [(_position select 0), (_position select 1) + _radius, 5]];
private _south = lineIntersects [ATLToASL _position, ATLToASL [(_position select 0), (_position select 1) - _radius, 5]];
private _west = lineIntersects [ATLToASL _position, ATLToASL [(_position select 0) - _radius, (_position select 1), 5]];
private _east = lineIntersects [ATLToASL _position, ATLToASL [(_position select 0) + _radius, (_position select 1), 5]];
private _top = lineIntersects [ATLToASL _position, ATLToASL [(_position select 0), (_position select 1), (_position select 1) + _radius]];

private _nearTerrainObjects = !((nearestTerrainObjects [_position, [], _radius]) isEqualTo []);
private _nearObjects = !((nearestObjects [_position, ["House", "Building", "allVehicles"], _radius]) isEqualTo []);

//if (_debug) then {systemChat format ["N:%1 | S:%2 | W:%3 | E:%4 | T:%5", _north, _south, _west, _east, _top]};

if (!_north && !_south && !_west && !_east && !_top && !_nearTerrainObjects && !_nearObjects) then {true} else {false};