// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _unit = _this select 0;

// =========================================================================================================
// CHECKING IF UNIT IS NOT PLAYER & EXECUTING ON SERVER ONLY
// =========================================================================================================

	if (_unit == player) exitWith {};

// =========================================================================================================
// AUTO ASSIGNING/UNASSIGNING ITEM
// =========================================================================================================

	waitUntil {!isNil "OPEX_sunHeight"};
	private _helmets = OPEX_friendly_commonHelmets_woodland + OPEX_friendly_commonHelmets_desert + OPEX_friendly_commonHelmets_snow + OPEX_friendly_specialHelmets_woodland + OPEX_friendly_specialHelmets_desert + OPEX_friendly_specialHelmets_snow;
	while {alive _unit} do
		{
			sleep (3 + (random 5));
			if (!alive _unit) exitWith {};

			private _nvg_notInstalled = items _unit select {_x in OPEX_friendly_NVGs};
			private _nvg_installed = hmd _unit;

			private _nvg = "";
			if (count _nvg_notInstalled > 0) then {_nvg = _nvg_notInstalled select 0};
			if (_nvg_installed != "") then {_nvg = _nvg_installed};

			// ASSIGNING NVG IF IT'S NIGHT AND IF UNIT IS NOT SAFE
			if ((_nvg != "") && (OPEX_sunHeight < 0) && (behaviour _unit != "safe") && (hmd _unit == "")) then {_unit linkItem _nvg; _unit removeItems _nvg};

			// REMOVING NVG IF IT'S NIGHT AND IF UNIT IS SAFE
			if ((_nvg != "") && (OPEX_sunHeight < 0) && (behaviour _unit == "safe") && (hmd _unit != "")) then {_unit unassignItem _nvg; if (!(_nvg in backpackItems _unit)) then {_unit addItemToBackpack _nvg}};

			// REMOVING NVG IF IT'S NOT NIGHT AND IF UNIT DOESN'T HAVE A HELMET
			if ((_nvg != "") && (OPEX_sunHeight > 0) && (hmd _unit != "") && (!(headgear player in _helmets))) then {_unit unassignItem _nvg; if (!(_nvg in backpackItems _unit)) then {_unit addItemToBackpack _nvg}};
		};