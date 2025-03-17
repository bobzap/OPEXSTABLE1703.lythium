params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_commonUniforms);

// VEST
_unit addVest (selectRandom OPEX_friendly_commonVests);

// HEADGEAR
_unit addHeadgear (selectRandom OPEX_friendly_commonHelmets);

// FACEGEAR
if ((random 1 > 0.75) && (daytime > 7) && (dayTime < 19)) then {_unit addGoggles (selectRandom OPEX_friendly_sunglasses)};

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;

// RIFLE
private ["_rifle"];
_rifle = selectRandom OPEX_friendly_MGriflesLight;
[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

// HANDGUN
private ["_handgun"];
_handgun = selectRandom OPEX_friendly_commonHandguns;
[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;