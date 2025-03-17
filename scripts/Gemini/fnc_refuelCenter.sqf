/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_refuelCenter.sqf"
*/

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

private _fnc_refuel =
	{
		private _emptyVehicles = vehicles select {((_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "ship")) && (_x inArea _this) && (fuel _x < 1) && (alive _x) && (speed _x == 0)};
		if (count _emptyVehicles == 0) exitWith {};
		{
			private _vehicle = _x;
			_vehicle engineOn false;
			_vehicle setFuel ((fuel _vehicle) + 0.05);
			private _percentage = ceil ((fuel _vehicle) * 100);
			["hintSilent", "STR_hint_refueling", _percentage] remoteExec ["Gemini_fnc_globalHintLoading", _vehicle];
			if (fuel _vehicle == 1) then {["hint", "STR_hint_refueled"] remoteExec ["Gemini_fnc_globalHint", _vehicle]};
		} forEach _emptyVehicles;
	};

while {true} do {sleep 1; _this call _fnc_refuel};