params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_tshirtUniforms));

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;

// HEADGEAR
_unit addHeadgear (selectRandom ["H_HeadBandage_bloody_F", "H_HeadBandage_stained_F", "H_HeadBandage_clean_F"]);