private ["_arguments", "_script"];

_arguments = _this select 0;
_script = _this select 1;

0 = _arguments execVM _script;


if (true) exitWith {};