/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_repairCenter.sqf"
*/

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

private _fnc_repair =
	{
		private _damagedVehicles = vehicles select {((_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "ship")) && (_x inArea _this) && (damage _x > 0) && (alive _x) && (speed _x == 0)};
		if (count _damagedVehicles == 0) exitWith {};
		{
			private _vehicle = _x;
			_vehicle engineOn false;
			_vehicle setDamage ((damage _vehicle) - 0.05);
			private _percentage = ceil ((1 - (damage _vehicle)) * 100);
			["hintSilent", "STR_hint_repairing", _percentage] remoteExec ["Gemini_fnc_globalHintLoading", _vehicle];
			if (damage _vehicle == 0) then {["hint", "STR_hint_repaired"] remoteExec ["Gemini_fnc_globalHint", _vehicle]};
		} forEach _damagedVehicles;
	};

while {true} do {sleep 1; _this call _fnc_repair};