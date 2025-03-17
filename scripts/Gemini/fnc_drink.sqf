if (isNil "OPEX_param_primaryNeeds") exitWith {hint localize "STR_hint_noFoodMissingMod"};

private ["_unit"];

_unit = _this select 1;

_unit setVariable ["thirst", 0];
playSound "drinking";