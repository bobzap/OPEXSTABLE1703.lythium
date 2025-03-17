Gemini_fnc_shoutAlert =
	{
		private ["_caller", "_nearByUnits"];
		_caller = _this select 0;
		_nearByUnits = _caller nearEntities ["man", 50];
		{if (side _x == side _caller) then {_nearByUnits = _nearByUnits - [_x]}} forEach _nearByUnits;
		{sleep random 3; if (alive _x) then {_x reveal _caller; _x doWatch _caller}} forEach _nearByUnits;
	};

Gemini_fnc_shoutStop =
	{
		private ["_target", "_caller", "_action"];
		_target = _this select 0;
		_caller = _this select 1;
		_action = _this select 2;

		if ((driver _target) getVariable "isHandcuffed") exitWith {};

		[_caller, _target] spawn Gemini_fnc_shoutAlert;

		if (side (driver _target) == civilian) then
			{
				_dist = _caller distance _target;
				sleep (random (_dist / 5));
				_target disableAI "move";
				while {(count (waypoints _target)) > 0} do {deleteWaypoint ((waypoints _target) select 0); sleep 0.01};
				waitUntil {sleep 3; _target distance _caller > 25};
				sleep (random 3);
				_target enableAI "move";
				_target doMove (position _target);
				[group _target, (getPos _target), 100] spawn Gemini_fnc_doPatrol;
			};
	};

Gemini_fnc_shoutDown =
	{
		private ["_target", "_caller", "_action"];
		_target = _this select 0;
		_caller = _this select 1;
		_action = _this select 2;

		if ((driver _target) getVariable "isHandcuffed") exitWith {};

		[_caller] spawn Gemini_fnc_shoutAlert;
		_target switchMove "";

		if (side (driver _target) == civilian) then
			{
				sleep (random 5);
				_target setUnitPos "down";
				waitUntil {sleep 5; _target distance _caller > 25};
				_target setUnitPos "auto";
			};
	};

Gemini_fnc_shoutGo =
	{
		private ["_target", "_caller", "_action"];
		_target = _this select 0;
		_caller = _this select 1;
		_action = _this select 2;

		if ((driver _target) getVariable "isHandcuffed") exitWith {};

		[_caller] spawn Gemini_fnc_shoutAlert;
		_target switchMove "";

		if (side (driver _target) == civilian) then
			{
				sleep (random 1);
				while {(count (waypoints _target)) > 0} do {deleteWaypoint ((waypoints _target) select 0); sleep 0.01};
				sleep 1;
				_target enableAI "move";
				_target setUnitPos "auto";
				_target switchMove "";
				_target doMove (position _target);
				[group _target, (getPos _target), 100] spawn Gemini_fnc_doPatrol;
			};
	};