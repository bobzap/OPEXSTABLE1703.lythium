private ["_player"];
_player = _this;

Gemini_fnc_quickrearm =
	{
		private ["_caller", "_target", "_units"];
		_caller = _this select 0;
		_target = _this select 1;
		if (_target == "unit") then {_units = [_caller]};
		if (_target == "squad") then {_units = (units group _caller) - [_caller]};
		if ((_target == "squad") && (isMultiplayer)) then {{if (_x in playableUnits) then {_units = _units - [_x]}} forEach _units};

		// PROCESSING
		hint localize "STR_hint_rearming";
		sleep 3;

		{

			// GETTING MAGAZINE NAMES
				private ["_handgunMagazine", "_secondaryMagazine", "_primaryMagazine", "_fak", "_handGrenade"];
				if ((handgunWeapon _x) != "") then {_handgunMagazine = (getArray (configFile >> "CfgWeapons" >> (handgunWeapon _x) >> "magazines")) select 0} else {_handgunMagazine = ""};
				if ((secondaryWeapon _x) != "") then {_secondaryMagazine = (getArray (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "magazines")) select 0} else {_secondaryMagazine = ""};
				if ((primaryWeapon _x) != "") then {_primaryMagazine = (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "magazines")) select 0} else {_primaryMagazine = ""};
				_fak = OPEX_medical_firstAidKit;
				_handGrenade = OPEX_friendly_handGrenades select 0;

			// COUNTING CURRENT MAGAZINES
				private ["_currentMagazines", "_handgunMagazineLeft", "_secondaryMagazineLeft", "_primaryMagazineLeft"];
				_currentMagazines = magazinesAmmoFull _x;
				_handgunMagazineLeft = 0;
				_secondaryMagazineLeft = 0;
				_primaryMagazineLeft = 0;
				for "_i" from 0 to ((count _currentMagazines) - 1) do {if (_currentMagazines select _i select 0 == _handgunMagazine) then {_handgunMagazineLeft = _handgunMagazineLeft + 1}};
				for "_i" from 0 to ((count _currentMagazines) - 1) do {if (_currentMagazines select _i select 0 == _secondaryMagazine) then {_secondaryMagazineLeft = _secondaryMagazineLeft + 1}};
				for "_i" from 0 to ((count _currentMagazines) - 1) do {if (_currentMagazines select _i select 0 == _primaryMagazine) then {_primaryMagazineLeft = _primaryMagazineLeft + 1}};

			// REARMING
				if ((_handgunMagazine != "") && (_handgunMagazineLeft < 2)) then {if (_x canAdd [_handgunMagazine, (2 - _handgunMagazineLeft)]) then {_x addMagazines [_handgunMagazine, (2 - _handgunMagazineLeft)]}};
				if ((_secondaryMagazine != "") && (_secondaryMagazineLeft < 2)) then {if (_x canAdd [_secondaryMagazine, (2 - _secondaryMagazineLeft)]) then {_x addMagazines [_secondaryMagazine, (2 - _secondaryMagazineLeft)]}};
				if ((_primaryMagazine != "") && (_primaryMagazineLeft < 8)) then {if (_x canAdd [_primaryMagazine, (8 - _primaryMagazineLeft)]) then {_x addMagazines [_primaryMagazine, (8 - _primaryMagazineLeft)]}};
				if (!(OPEX_medical_firstAidKit in (items _x))) then {if (_x canAdd [_fak, 1]) then {_x addItem _fak}};
				if (!(_handGrenade in (items _x))) then {if (_x canAdd [_handGrenade, 1]) then {_x addMagazine _handGrenade}; if (_x canAdd [_handGrenade, 1]) then {_x addMagazine _handGrenade}; if (_x canAdd [_handGrenade, 1]) then {_x addMagazine _handGrenade}};

		} forEach _units;

		// DONE
		hint localize "STR_hint_rearmed";
	};

_player addAction
	[
		"<t color=""#FFFFFF"">" + localize "STR_action_quickrearming" + "</t>", {0 = [_this select 3, "unit"] spawn Gemini_fnc_quickrearm}, _player, 6, false, true, "",
		"(OPEX_param_gearManagement == 1) && (_this distance2D (getMarkerPos 'OPEX_marker_armory') < 10)"
	];

_player addAction
	[
		"<t color=""#FFFFFF"">" + localize "STR_action_quickrearming_squad" + "</t>", {0 = [_this select 3, "squad"] spawn Gemini_fnc_quickrearm}, _player, 6, false, true, "",
		"((!isMultiplayer) || (OPEX_param_gearManagement == 1)) && ((_this distance2D (getMarkerPos 'OPEX_marker_armory') < 10) && (_this == leader (group _this)) && (count (units group _this) > 1))"
	];