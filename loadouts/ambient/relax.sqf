params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_tshirtUniforms));

// HEADGEAR
if (random 1 > 0.7) then {_unit addHeadgear (selectRandom (OPEX_friendly_caps + OPEX_friendly_bandanas + OPEX_friendly_caps))};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;