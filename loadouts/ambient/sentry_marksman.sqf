params ["_unit"];

// UNIFORM
_unit forceAddUniform (selectRandom OPEX_friendly_commonUniforms);

// VEST
_unit addVest (selectRandom OPEX_friendly_commonVests);

// HEADGEAR
_unit addHeadgear (selectRandom (OPEX_friendly_commonHelmets + OPEX_friendly_hats));

// INSIGNA
[_unit] spawn Gemini_fnc_setUnitInsigna;

// RIFLE
private ["_rifle"];
_rifle = selectRandom OPEX_friendly_precisionRifles;
[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

// OPTIC
private ["_rifleOptic", "_compatibleRifleOptics"];
_rifleOptic = selectRandom (OPEX_friendly_sniperOptics + OPEX_friendly_distantCombatOptics);
_compatibleRifleOptics = [_rifle, 0] call Gemini_fnc_getWeaponAccessories;
if (_rifleOptic in _compatibleRifleOptics) then {_unit addPrimaryWeaponItem _rifleOptic};

// HANDGUN
private ["_handgun"];
_handgun = selectRandom OPEX_friendly_commonHandguns;
[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;