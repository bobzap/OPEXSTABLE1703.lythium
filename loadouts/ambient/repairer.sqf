params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_tshirtUniforms));

// HEADGEAR
if (random 1 > 0.35) then {_unit addHeadgear (selectRandom OPEX_friendly_bandanas)};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;