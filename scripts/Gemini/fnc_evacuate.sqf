// DEFINING CUSTOM ACTIONS
Gemini_fnc_evacuate_follow =
	{
		private _civilian = _this select 0;
		private _soldier = _this select 1;
		[_civilian, _soldier] spawn
			{
				private _civilian = _this select 0;
				private _soldier = _this select 1;
				["hint", "STR_hint_followMe"] remoteExec ["Gemini_fnc_globalHint", _soldier];
				_civilian switchMove "";
				while {(count (waypoints group _civilian)) > 0} do {deleteWaypoint ((waypoints (group _civilian)) select 0)};
				_civilian doMove (_soldier modelToWorld [0,-5,0]);
				while {(_civilian distance2D _soldier < 50) && (!(stopped _civilian)) && (vehicle _civilian == _civilian) && (isNull (assignedVehicle _civilian))}
				do
					{
							while {(count (waypoints group _civilian)) > 0} do {deleteWaypoint ((waypoints (group _civilian)) select 0)};
							sleep 1;
							if ((_civilian distance2D _soldier > 10) && (!(stopped _civilian))) then
								{
									_civilian doMove (_soldier modelToWorld [0,-5,0]);
									if (speed _soldier > 10) then {_civilian setSpeedMode "full"} else {_civilian setSpeedMode "limited"};
								}
					};
			};
	};
Gemini_fnc_evacuate_wait =
	{
		private _civilian = _this select 0;
		private _soldier = _this select 1;
		["hint", "STR_hint_waitHere"] remoteExec ["Gemini_fnc_globalHint", _soldier];
		while {(count (waypoints group _civilian)) > 0} do {deleteWaypoint ((waypoints (group _civilian)) select 0)};
		doStop _civilian;
	};

Gemini_fnc_evacuate_getIn =
	{
		private _civilian = _this select 0;
		private _soldier = _this select 1;
		private _nearbyVehicles = (position _soldier) nearEntities [["Air", "Car", "Motorcycle", "Ship", "Tank"], 15];
		private _vehicle = ([_nearbyVehicles, [], {_civilian distance _x }, "ASCEND"] call BIS_fnc_sortBy) select 0;
		while {(count (waypoints group _civilian)) > 0} do {deleteWaypoint ((waypoints (group _civilian)) select 0)};
		["hint", "STR_hint_getIn"] remoteExec ["Gemini_fnc_globalHint", _soldier];
		_civilian doMove (getPos _vehicle);
		_civilian assignAsCargo _vehicle;
		[_civilian] orderGetIn true;
		private _action_getOut =
			{
				[_this select 0, _this select 2] remoteExec ["removeAction", 0, _this select 0];
				["hint", "STR_hint_getOut"] remoteExec ["Gemini_fnc_globalHint", _this select 1];
				{sleep (random 3); unassignVehicle _x; moveOut _x} forEach crew (_this select 0);
			};
		if (count (crew _vehicle) == 0) then {[_vehicle, "STR_action_getOut", _action_getOut, [], 5, "(count (crew _originalTarget) > 0) && (speed _originalTarget == 0) && ((getPos _originalTarget select 2) < 1)", false, true] remoteExec ["Gemini_fnc_addAction", 2, _vehicle]};
		waitUntil {(!OPEX_assignedTask) || (vehicle _civilian != _civilian)};
		_civilian moveInCargo _vehicle;
		while {OPEX_assignedTask && (canMove (vehicle _civilian))} do {sleep 3};
		waitUntil {sleep 1; speed (vehicle _civilian) == 0};
		unassignVehicle _civilian;
		doGetOut _civilian;
		_civilian switchMove "";
	};

Gemini_fnc_evacuate_call =
	{

		private _soldier = _this select 0;
		private _nearEntities = _soldier nearEntities ["Man", 35];
		private _nearCivilians = [];
		{if (side _x == civilian) then {_nearCivilians append [_x]}} forEach _nearEntities;
		if (count _nearCivilians == 0) exitWith {};
		["hint", "STR_hint_isThereAnyone"] remoteExec ["Gemini_fnc_globalHint", _soldier];
		{if ((vehicle _x == _x) && (isNull (assignedVehicle _x))) then {sleep (random 1); while {(count (waypoints group _x)) > 0} do {deleteWaypoint ((waypoints (group _x)) select 0)}; _x switchMove ""; _x doMove (_soldier modelToWorld [0,0,0])}} forEach _nearCivilians;
	};