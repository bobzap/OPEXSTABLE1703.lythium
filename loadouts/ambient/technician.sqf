params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_commonUniforms);

// HEADGEAR
_unit addHeadgear (selectRandom ["H_Cap_marshal", "H_Cap_Headphones", "H_EarProtectors_white_F", "H_EarProtectors_black_F", "H_EarProtectors_yellow_F", "H_EarProtectors_orange_F", "H_EarProtectors_red_F", "H_construction_earprot_white_F", "H_construction_earprot_black_F", "H_construction_earprot_yellow_F", "H_construction_earprot_orange_F", "H_construction_earprot_red_F"]);

// FACEGEAR
if ((random 1 > 0.85) && (daytime > 8) && (dayTime < 17)) then {_unit addGoggles (selectRandom OPEX_friendly_sunglasses)};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;