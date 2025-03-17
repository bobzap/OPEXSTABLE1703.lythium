_disconnected = objNull;
{if (getPlayerUID _x == _this) then {_disconnected = _x}} forEach playableUnits;