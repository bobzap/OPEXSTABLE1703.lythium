params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_instructorUniforms);

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;