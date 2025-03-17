private _position = _this;
if (typeName _position == "ARRAY") then {_position = _position};
if (typeName _position == "OBJECT") then {_position = position _position};

private _building = nearestBuilding _position;
private _buildingType = typeOf _building;

private _boundingBox = boundingBoxReal _building;
private _min = _boundingBox select 0;
private _max = _boundingBox select 1;

_myX = (_building worldToModel _position) select 0;
_myY = (_building worldToModel _position) select 1;
_myZ = (_building worldToModel _position) select 2;

private _isInside = false;
if ((_myX > (_min select 0)) && (_myX < (_max select 0))) then {
if ((_myY > (_min select 1)) && (_myY < (_max select 1))) then {
if ((_myZ > (_min select 2)) && (_myZ < (_max select 2))) then {
_isInside = true;
} else {_isInside = false};
} else {_isInside = false};
} else {_isInside = false};

if ((!_isInside) && ((lineIntersectsWith [ATLtoASL _position, [ATLtoASL _position select 0, ATLtoASL _position select 1, (ATLtoASL _position select 2) + 20], objNull, objNull, true]) isEqualTo [])) then {_isInside = false};
if ((_isInside) && (!((lineIntersectsWith [ATLtoASL _position, [ATLtoASL _position select 0, ATLtoASL _position select 1, (ATLtoASL _position select 2) + 20], objNull, objNull, true]) isEqualTo []))) then {_isInside = true};
if ((_isInside) && ((lineIntersectsWith [ATLtoASL _position, [ATLtoASL _position select 0, ATLtoASL _position select 1, (ATLtoASL _position select 2) + 20], objNull, objNull, true]) isEqualTo [])) then {_isInside = false};

_isInside




/*
private ["_result"];

_result = false;

// GETTING MAIN POSITION
private ["_position"];
_position = ATLtoASL [(_this select 0), (_this select 1), (_this select 2) + 1.5];

// DEFINING NEARBY POSITIONS
private ["_above", "_front", "_back", "_right", "_left"];
_above = [_position select 0, _position select 1, (_position select 2) + 20];
_front = [(_position select 0), (_position select 1) + 5, _position select 2];
_back = [(_position select 0), (_position select 1) - 5, _position select 2];
_right = [(_position select 0) + 5, (_position select 1), _position select 2];
_left = [(_position select 0) - 5, (_position select 1), _position select 2];


// CHECKING IF THERE'S A ROOF ABOVE POSITION
private ["_roofs"];
_roofs = lineIntersectsWith [_position, _above, objNull, objNull, true];

if (count _roofs == 0) exitwith {_result};
{if (!(_x isKindOf "building")) then {_roofs = _roofs - [_x]}} forEach _roofs;

// CHECKING IF THERE ARE WALLS AROUND POSITION
private ["_walls", "_wallsFront", "_wallsBack", "_wallsRight", "_wallsLeft"];
_walls = [];
_wallsFront = (lineIntersectsWith [_position, _front, objNull, objNull, true]);
_wallsBack = (lineIntersectsWith [_position, _back, objNull, objNull, true]);
_wallsRight = (lineIntersectsWith [_position, _right, objNull, objNull, true]);
_wallsLeft = (lineIntersectsWith [_position, _left, objNull, objNull, true]);
_walls = _wallsFront + _wallsBack + _wallsRight + _wallsLeft;
if (count _walls == 0) exitwith {_result};
{if (!(_x isKindOf "building")) then {_walls = _walls - [_x]}} forEach _walls;
if (count _walls == 0) exitwith {_result};

systemChat str (count _walls);
// CHECKING RESULTS
if ((count _roofs >= 1) && (count _walls >= 2)) then {_result = true} else {_result = false};

_result

*/