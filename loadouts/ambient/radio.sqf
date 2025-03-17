params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_commonUniforms);
// HEADGEAR
_unit addHeadgear (selectRandom ["H_Cap_marshal", "H_Cap_headphones", "H_HeadSet_white_F", "H_HeadSet_yellow_F", "H_HeadSet_orange_F", "H_HeadSet_red_F", "H_HeadSet_black_F"]);

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;