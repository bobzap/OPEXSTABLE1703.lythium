/*

	example :
	[
		_villagePos,
		[_villageArea select 0, _villageArea select 1, 0, false],
		[OPEX_enemy_side2, "not present", false],
		["this && OPEX_assignedTask && {thisTrigger distance _x < (triggerArea thisTrigger select 0) max (triggerArea thisTrigger select 1)} count (playableUnits + switchableUnits) > 0", "[] remoteExec ['Gemini_fnc_taskSucceeded']", ""],
		[0, 0, 0, false],
		"task"
	] call Gemini_fnc_createTrigger;

*/

private _position = param [0, [0,0,0], [[], objNull]]; if (typeName _position == "OBJECT") then {_position = position _position};
private _area = param [1, [10,10,0,false], []];
private _activation = param [2, ["WEST", "PRESENT", true], []];
private _statements = param [3, ["this", "", ""], []];
private _timeout = param [4, [0,0,0,false], []];
private _lifetime = param [5, "distance", [""]];

private ["_trigger"];
_trigger = createTrigger ["EmptyDetector", _position];
_trigger setTriggerArea _area;
_trigger setTriggerActivation _activation;
_trigger setTriggerStatements _statements;
_trigger setTriggerTimeout _timeout;
[_trigger, _lifeTime] call Gemini_fnc_setLifeTime;

_trigger