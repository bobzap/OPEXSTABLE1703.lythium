/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_jail.sqf"
*/

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

private _fnc_jail =
	{
		private _inCustodyUnits = allUnits select {(_x inArea _this) && (!(_x getVariable ["isJailed", false])) && (side _x != OPEX_friendly_side1)};
		if (count _inCustodyUnits == 0) exitWith {};
		{
			private _unit = _x;
			private _player = attachedTo _unit;
			["hint", "STR_hint_personJailed"] remoteExec ["Gemini_fnc_globalHint", 0, false];
			detach _unit;
			[_unit] remoteExec ["Gemini_fnc_removeAllActions"];

			// IF HOSTILE
			if (_unit getVariable ["side", ""] == "hostile") then
				{
					["enemyJailed"] call Gemini_fnc_updateStats;
					//OPEX_stats_faction set [6, (OPEX_stats_faction select 6) + 1]; publicVariable "OPEX_stats_faction";
					//{OPEX_stats_player set [6, (OPEX_stats_player select 6) + 1]} remoteExec ["bis_fnc_call", _player];
				};

			// IF INNOCENT
			if (_unit getVariable ["side", ""] != "hostile") then
				{
					["civilianJailed"] call Gemini_fnc_updateStats;
					//OPEX_stats_faction set [7, (OPEX_stats_faction select 7) + 1]; publicVariable "OPEX_stats_faction";
					//{OPEX_stats_player set [7, (OPEX_stats_player select 7) + 1]} remoteExec ["bis_fnc_call", _player];
				};

			_unit setVariable ["isJailed", true, true];
			waitUntil {{(_x distance _this < 100) && (side _x == OPEX_friendly_side1)} count (allPlayers - entities "HeadlessClient_F") == 0};
			deleteVehicle _unit;
		} forEach _inCustodyUnits;
	};

while {true} do {sleep 1; _this call _fnc_jail};