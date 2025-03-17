private _caller =  _this select 1;
private _traveler = _this select 3 select 0;

Gemini_fnc_travel =
	{
		openMap false;
		titleText ["", "black out", 3];
		3 fadeSound 0;
		sleep 3;
		titleText [localize "STR_aFewMinutesLater", "black", 0.00001];
		if (!isMultiplayer) then {skipTime 0.75};
		if ((_this select 0) == "unit") then {(vehicle player) setPos (_this select 1)};
		if ((_this select 0) == "group") then {{(vehicle _x) setPos [(_this select 1 select 0) + random 25 - random 25, (_this select 1 select 1) + random 25 - random 25, 0]} forEach (units group player)};
		sleep 5;
		3 fadeSound 1;
		titleText ["", "black in", 3];
	};

if (_traveler == "unit") then
	{
		openMap true;
		hint localize "STR_hint_fastTravel_unit";
		onMapSingleClick "['unit', _pos] spawn Gemini_fnc_travel; true";
		waitUntil {!visibleMap};
		onMapSingleClick "";
	};

if (_traveler == "group") then
	{
		if ((leader _caller) != _caller) exitWith {hint localize "STR_hint_leaderOnly"};
		openMap true;
		hint localize "STR_hint_fastTravel_group";
		onMapSingleClick "['group', _pos] spawn Gemini_fnc_travel; true";
		waitUntil {!visibleMap};
		onMapSingleClick "";
	};