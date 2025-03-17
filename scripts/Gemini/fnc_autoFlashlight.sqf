// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _unit = _this select 0;

// =========================================================================================================
// CHECKING IF UNIT IS NOT PLAYER & EXECUTING ON SERVER ONLY
// =========================================================================================================

	if (isPlayer _unit) exitWith {};
	if (_unit == player) exitWith {};

// =========================================================================================================
// DEFINING SCRIPT
// =========================================================================================================

	private _script =
		{
			// GETTING UNIT
			private _unit = _this;

			// PRIMARY WEAPONS
			private _lamps = ([primaryWeapon _unit, 1] call Gemini_fnc_getWeaponAccessories) select {(_x in OPEX_friendly_flashlights) && (_x in ((primaryWeaponItems _unit) + (items _unit)))};
			private _lamp = if (count _lamps > 0) then {selectRandom _lamps} else {""};

			// 	AUTO ASSIGNING/UNASSIGNING LAMP
			if ((behaviour _unit == "safe") && (OPEX_sunHeight < 5) && (primaryWeapon _unit != "") && (_lamp != "") && (!(_lamp in primaryWeaponItems _unit)) && (_lamp in items _unit)) then {_unit addPrimaryWeaponItem _lamp; _unit removeItem _lamp};
			if ((behaviour _unit == "safe") && (OPEX_sunHeight < 5) && (!(_unit isFlashlightOn (primaryWeapon _unit)))) then {_unit enableGunLights "ForceOn"};
			if (((behaviour _unit != "safe") || (OPEX_sunHeight >= 5)) && (_unit isFlashlightOn (primaryWeapon _unit))) then {_unit enableGunLights "ForceOff"};
		};

// =========================================================================================================
// LOOPING
// =========================================================================================================

	while {alive _unit} do {sleep (random 5); if (!alive _unit) exitWith {}; _unit call _script};