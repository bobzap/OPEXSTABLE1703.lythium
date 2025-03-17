private _start = param [0, [100,100,100], [[], objNull]]; if (_start isEqualType objNull) then {_start = position _start};
private _middle = param [1, [500,500,500], [[], objNull]]; if (_middle isEqualType objNull) then {_middle = position _middle};

private _endX = ((_middle select 0) + ((_middle select 0) - (_start select 0)));
private _endY = ((_middle select 1) + ((_middle select 1) - (_start select 1)));
private _endZ = ((_middle select 2) + ((_middle select 2) - (_start select 2)));

private _end = [_endX, _endY, _endZ];

_end