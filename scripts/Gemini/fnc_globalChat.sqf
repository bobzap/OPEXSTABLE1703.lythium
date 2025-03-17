// to call ths function, e.g.:
// [myUnit, "myText"] remoteExec ["Gemini_fnc_globalChat"];
// [myUnit, "STR_globalStats_updatePositive", globalStats_mission_succeeded, globalStats] remoteExec ["Gemini_fnc_globalChat"];

private ["_side", "_identity", "_text", "_value1", "_value2", "_value3"];

_side = _this select 0;
_identity = _this select 1;
_text = _this select 2;
if (count _this > 2) then {_value1 = _this select 3} else {_value1 = 0};
if (count _this > 3) then {_value2 = _this select 4} else {_value2 = 0};
if (count _this > 4) then {_value3 = _this select 5} else {_value3 = 0};

// [_side, _identity] sideChat _text;
if (count _this == 4) then {hintSilent format [localize _text, _value1]};
if (count _this == 5) then {hintSilent format [localize _text, _value1, _value2]};
if (count _this == 6) then {hintSilent format [localize _text, _value1, _value2, _value3]};

// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================

	if (true) exitWith {};