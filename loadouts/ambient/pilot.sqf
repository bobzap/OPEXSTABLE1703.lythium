params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_heliPilotUniforms + OPEX_friendly_aircraftPilotUniforms));

// HEADGEAR
if (random 1 > 0.5) then {_unit addHeadgear (selectRandom OPEX_friendly_caps)};
// FACEGEAR
if ((random 1 > 0.25) && (daytime > 8) && (dayTime < 18)) then {_unit addGoggles (selectRandom OPEX_friendly_sunglasses)};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;