/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_rearmCenter.sqf"
*/

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

private _fnc_rearm =
	{
		private _armedVehicles = vehicles select {((_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "ship")) && (_x inArea _this) && (_x call Gemini_fnc_getVehicleAmmoDef < 1) && (alive _x) && (speed _x == 0)};
		if (count _armedVehicles == 0) exitWith {};
		{
			private _vehicle = _x;
			_vehicle engineOn false;
			private _percentage = ceil ((_x call Gemini_fnc_getVehicleAmmoDef) * 100);
			["hintSilent", "STR_hint_rearming", _percentage] remoteExec ["Gemini_fnc_globalHintLoading", _vehicle];
			{if (!(_vehicle turretLocal _x)) then {[_vehicle, (_vehicle call Gemini_fnc_getVehicleAmmoDef) + 0.025] remoteExecCall ["setVehicleAmmoDef", (_vehicle turretOwner _x), false]} else {_vehicle setVehicleAmmoDef ((_vehicle call Gemini_fnc_getVehicleAmmoDef) + 0.025)}} forEach (allTurrets _vehicle);
			if (_x call Gemini_fnc_getVehicleAmmoDef == 1) then {["hint", "STR_hint_rearmed"] remoteExec ["Gemini_fnc_globalHint", _vehicle]};
		} forEach _armedVehicles;
	};

while {true} do {sleep 1; _this call _fnc_rearm};