private ["_hintType", "_hintText"];

_hintType = _this select 0;
_hintText = _this select 1;

if (_hintType == "hint") then {hint localize _hintText};
if (_hintType == "hintC") then {hintC localize _hintText};
if (_hintType == "hintSilent") then {hintSilent localize _hintText};