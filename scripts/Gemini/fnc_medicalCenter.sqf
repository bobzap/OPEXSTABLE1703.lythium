/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_medicalCenter.sqf"
*/

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

private _fnc_heal =
	{
		private _injuredUnits = allUnits select {(_x inArea _this) && (damage _x > 0) && (alive _x) && (speed _x == 0)};
		if (count _injuredUnits == 0) exitWith {};
		{
			private _unit = _x;
			_unit setDamage ((damage _unit) - 0.05);
			private _percentage = ceil ((1 - (damage _unit)) * 100);
			["hintSilent", "STR_hint_healing", _percentage] remoteExec ["Gemini_fnc_globalHintLoading", _unit];
			if (damage _unit == 0) then {private _index = 0; {_unit setHitIndex [_index, 0]; _index = _index + 1} forEach ((getAllHitPointsDamage _unit) select 2); ["hint", "STR_hint_healed"] remoteExec ["Gemini_fnc_globalHint", _unit]};
		} forEach _injuredUnits;
	};

while {true} do {sleep 1; _this call _fnc_heal};