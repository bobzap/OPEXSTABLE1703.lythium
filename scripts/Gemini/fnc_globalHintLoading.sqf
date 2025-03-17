private ["_hintType", "_hintText", "_value"];

_hintType = _this select 0;
_hintText = _this select 1;
_value = _this select 2;

if (_hintType == "hint") then {hint format [(localize _hintText) + " " + "(%1%2)", _value, "%"];};
if (_hintType == "hintC") then {hintC format [(localize _hintText) + " " + "(%1%2)", _value, "%"];};
if (_hintType == "hintSilent") then {hintSilent format [(localize _hintText) + " " + "(%1%2)", _value, "%"];};