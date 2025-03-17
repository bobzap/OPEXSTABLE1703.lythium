// GETTIN PARAMETERS
private _squad = param [0, grpNull, [grpNull, objNull]]; if (typeName _squad == "OBJECT") then {_squad = group _squad};
private _center = param [1, [0,0,0], [[], objNull]]; if (typeName _center == "OBJECT") then {_center = position _center};
private _radius = param [2, [0,0,0], [[], objNull]]; if (_radius isEqualType 0) then {_radius = [0, _this select 2]};
private _target = param [3, objNull, [[], objNull]];

// SETTING SQUAD
while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
_squad setFormation (selectRandom ["ECH LEFT", "ECH RIGHT", "LINE", "VEE", "WEDGE"]);
{
	_x setBehaviour "aware";
	_x setCombatMode "red";
	if (random 1 > 0.25) then {[[_x, selectRandom ["STAND", "STAND_IA", "WATCH", "WATCH1", "WATCH2", "SIT_LOW", "SIT_LOW"]], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _x]};
	doStop _x;
} forEach (units _squad);

// ADJUSTING UNIT POSITION
{
	private _unitPos = ["land", _center, _radius select 0, _radius select 1, 1] call Gemini_fnc_findPos;
	if (_unitPos isEqualTo [0,0,0]) then {_unitPos = position _x};
	_x setPos _unitPos;
	if (_target isEqualTo objNull) then {_x setDir (random 360)} else {_x setDir ((position _x) getDir _target)};
} forEach (units _squad);