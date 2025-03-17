params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_specialUniforms + OPEX_friendly_tshirtUniforms));

// HEADGEAR
if (random 1 > 0.5) then {_unit addHeadgear (selectRandom OPEX_friendly_caps)};

// FACEGEAR
if ((random 1 > 0.85) && (rain < 0.15) && (OPEX_sunHeight > 5)) then {_unit addGoggles (selectRandom OPEX_friendly_sunglasses)};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;

// RIFLE
_rifle = selectRandom (OPEX_friendly_commonRifles + OPEX_friendly_MGriflesLight);
[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;