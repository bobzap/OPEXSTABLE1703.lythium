params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_medicUniforms);

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;