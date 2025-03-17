// GETTING SQUAD
private _squad = _this select 0;
private _center = _this select 1;
private _radius = _this select 2;

// CHECKING IF THERE ARE ENOUGH UNITS IN SQUAD TO TALK
if (count units _squad <= 1) exitWith {};

// FINDING A POSITION
private _position = ["land", _center, _radius select 0, _radius select 1, 1.25] call Gemini_fnc_findPos;
if (_position isEqualTo [0,0,0]) then {_position = _center};

// MOVING UNITS AROUND FOUND POSITION
{
	_x setPosATL (_position getPos [2.5, random 360]);
	_x setBehaviour "safe";
	_x setDir ((position _x) getDir _position);
	doStop _x;
	switch (selectRandom [1,2,3,4]) do
		{
		
		
			;
			case 1	:	{[[_x, selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA"]], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _x]};
			case 2	:	{_x switchMove "AmovPercMstpSrasWrflDnon_AmovPercMstpSnonWnonDnon"; _x disableAi "anim"; _x spawn {waitUntil {(behaviour _this isEqualTo "COMBAT") || (!alive _this)}; _this enableAI "anim"}};
			default 	{};
		};
} forEach (units _squad);