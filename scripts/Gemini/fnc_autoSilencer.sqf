// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _unit = _this select 0;

// =========================================================================================================
// CHECKING IF UNIT IS NOT PLAYER & EXECUTING ON SERVER ONLY
// =========================================================================================================

	if (isPlayer _unit) exitWith {};
	if (_unit == player) exitWith {};
	if (typeOf _unit == OPEX_friendly_scout) exitWith {}; //not usefull for scouts

// =========================================================================================================
// AUTO ASSIGNING/UNASSIGNING ITEM
// =========================================================================================================

	while {alive _unit} do
		{
			// TEMPO (TO SAVE CPU)
			sleep (3 + (random 5));
			if (!alive _unit) exitWith {};

			// GETTING UNIT GEAR
			private _primaryWeaponItems = primaryWeaponItems _unit; {_primaryWeaponItems set [_forEachIndex, toLower _x]} forEach _primaryWeaponItems;
			private _secondaryWeaponItems = primaryWeaponItems _unit; {_secondaryWeaponItems set [_forEachIndex, toLower _x]} forEach _secondaryWeaponItems;
			private _handgunItems = handgunItems _unit; {_handgunItems set [_forEachIndex, toLower _x]} forEach _handgunItems;
			private _items = items _unit; {_items set [_forEachIndex, toLower _x]} forEach _items;

			// GETTING SILENCERS
			private _rifleSilencers = (_primaryWeaponItems + _items) select {_x in OPEX_friendly_rifleSilencers};
			private _handgunSilencers = (_secondaryWeaponItems + _items) select {_x in OPEX_friendly_handgunSilencers};
			private _rifleSilencer = ""; if (count _rifleSilencers > 0) then {_rifleSilencer = selectRandom _rifleSilencers};
			private _handgunSilencer = ""; if (count _handgunSilencers > 0) then {_handgunSilencer = selectRandom _handgunSilencers};

			// 	AUTO ASSIGNING/UNASSIGNING SILENCER(S)
			if (behaviour _unit == "stealth") then
				{
					if ((primaryWeapon _unit != "") && (_rifleSilencer != "")) then {if ((!(_rifleSilencer in _primaryWeaponItems)) && (_rifleSilencer in _items)) then {_unit addPrimaryWeaponItem _rifleSilencer; _unit removeItems _rifleSilencer}};
					if ((handgunWeapon _unit != "") && (_handgunSilencer != "")) then {if ((!(_handgunSilencer in _handgunItems)) && (_handgunSilencer in _items)) then {_unit addHandgunItem _handgunSilencer; _unit removeItems _handgunSilencer}};
					if ((_rifleSilencer == "") && (_handgunSilencer != "")) then {_unit selectWeapon (handgunWeapon _unit)};
				}
			else
				{
					if ((primaryWeapon _unit != "") && (_rifleSilencer != "")) then {if (_rifleSilencer in _primaryWeaponItems) then {_unit removePrimaryWeaponItem _rifleSilencer; _unit addItemToBackpack _rifleSilencer}};
					if ((handgunWeapon _unit != "") && (_handgunSilencer != "")) then {if (_handgunSilencer in _handgunItems) then {_unit removeHandgunItem _handgunSilencer; _unit addItemToBackpack _handgunSilencer}};
					if ((_rifleSilencer == "") && (_handgunSilencer != "")) then {_unit selectWeapon (primaryWeapon _unit)};
				};

			// SELECTING DEFAULT MUZZLE (AVOID AI TO USE GRENADE LAUNCHER...)
			/*
			if (count weapons _unit > 0) then
				{
					private["_type", "_muzzles"];
					_type = ((weapons _unit) select 0);
					_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");
					if (count _muzzles > 1) then {_unit selectWeapon (_muzzles select 0)} else {_unit selectWeapon _type};
				};
			*/
		};