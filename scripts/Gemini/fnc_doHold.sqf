// GETTING SQUAD
private _squad = _this select 0;
private _radius = _this select 1;
private _destination = param [2, position (leader _squad), [[], objNull]]; if (typeName _center == "OBJECT") then {_center = position _center};

// SETTING SQUAD
while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
_squad setFormation (selectRandom ["ECH LEFT", "ECH RIGHT", "LINE", "VEE", "WEDGE"]);
{
	_x setBehaviour "aware";
	_x setCombatMode "red";
	_x setUnitPos (selectRandom ["auto", "middle", "middle", "middle", "down", "down", "down"]);
	_x doWatch _destination;
	private _dir = _x getDir _destination;
	_x setDir _dir;
	doStop _x;
	_x addEventHandler
		[
			"firedNear",
			{
				{
					_x doMove (position (_this select 1));
					_x setCombatMode "red";
					_x setBehaviour "combat";
					_x setUnitPos "auto";
					_x removeAllEventHandlers "firedNear";
					_x setSpeedMode "limited";
				} forEach units group (_this select 0)
			}
		];
	_x addEventHandler
		[
			"killed",
			{
				{
					_x doMove (position _x);
					_x setCombatMode "red";
					_x setBehaviour "combat";
					_x setUnitPos "auto";
					_x removeAllEventHandlers "killed";
					_x setSpeedMode "full";
				} forEach units group (_this select 0)
			}
		];
} forEach (units _squad);