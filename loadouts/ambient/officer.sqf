params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_specialUniforms));
_unit addHeadgear (selectRandom OPEX_friendly_leaderHeadgear);

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;