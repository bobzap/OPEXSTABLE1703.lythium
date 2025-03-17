/*
	FUNCTION TO MAKE NEAREST AIs BOARD INTO THE NEAREST VEHICLE/STATIC WHEN IN DANGER
	[vehicle, side, distance] spawn Gemini_fnc_boardVehicleIfDanger
*/

if (!isNil "VCOMAI_Func") exitWith {}; // disabling this feature if VComAI is detected, because it may create a conflict ?

private ["_vehicle", "_side", "_distance"];

_vehicle = _this select 0;
_side = _this select 1;
_distance = _this select 2;

if ((_vehicle emptyPositions "gunner") == 0) exitWith {};

while {alive _vehicle} do
	{
		sleep 5;
		sleep (random 20);
		if (alive _vehicle) then
			{
				_nearbyUnits = [];
				_nearbyUnits = _vehicle nearEntities ["Man", _distance];
				if (count _nearbyUnits > 0) then
					{
						{if ((side _x != _side) || (behaviour _x != "combat")) then {_nearbyUnits = _nearbyUnits - [_x]}} forEach _nearbyUnits;
						if ((count _nearbyUnits >= 1) && ((_vehicle emptyPositions "gunner") > 0)) then
							{
								[_nearbyUnits select (count _nearbyUnits - 1)] joinSilent grpNull;
								(_nearbyUnits select (count _nearbyUnits - 1)) setSpeedMode "full";
								(_nearbyUnits select (count _nearbyUnits - 1)) enableAI "move";
								(_nearbyUnits select (count _nearbyUnits - 1)) doMove (position (_nearbyUnits select 0));
								(_nearbyUnits select (count _nearbyUnits - 1)) assignAsGunner _vehicle;
								[_nearbyUnits select (count _nearbyUnits - 1)] orderGetIn true;
								(_nearbyUnits select (count _nearbyUnits - 1)) setCombatMode "red";
							};
						if ((count _nearbyUnits >= 2) && ((_vehicle emptyPositions "driver") > 0)) then
							{
								[_nearbyUnits select (count _nearbyUnits - 2)] joinSilent (_nearbyUnits select (count _nearbyUnits - 1));
								(_nearbyUnits select (count _nearbyUnits - 2)) setSpeedMode "full";
								(_nearbyUnits select (count _nearbyUnits - 2)) enableAI "move";
								(_nearbyUnits select (count _nearbyUnits - 2)) doMove (position (_nearbyUnits select 2));
								(_nearbyUnits select (count _nearbyUnits - 2)) assignAsDriver _vehicle;
								[_nearbyUnits select (count _nearbyUnits - 2)] orderGetIn true;
								(_nearbyUnits select (count _nearbyUnits - 2)) setCombatMode "red";
							};
						if ((count _nearbyUnits >= 3) && ((_vehicle emptyPositions "commander") > 0)) then
							{
								[_nearbyUnits select (count _nearbyUnits - 3)] joinSilent (_nearbyUnits select (count _nearbyUnits - 1));
								(_nearbyUnits select (count _nearbyUnits - 3)) setSpeedMode "full";
								(_nearbyUnits select (count _nearbyUnits - 3)) enableAI "move";
								(_nearbyUnits select (count _nearbyUnits - 3)) doMove (position (_nearbyUnits select 3));
								(_nearbyUnits select (count _nearbyUnits - 3)) assignAsCommander _vehicle;
								[_nearbyUnits select (count _nearbyUnits - 3)] orderGetIn true;
								(_nearbyUnits select (count _nearbyUnits - 3)) setCombatMode "red";
							};
						if ((alive _vehicle) && ((_vehicle emptyPositions "driver") == 0)) then
							{
								private ["_wp"];
								while {count (waypoints (group (driver _vehicle))) > 0} do {deleteWaypoint ((waypoints (group (driver _vehicle))) select 0)};
								sleep 1;
								_wp = (group (driver _vehicle)) addWaypoint [position _vehicle, 100];
								_wp setWaypointType "SAD";
							};
					};
			};
	};