/*
	example :
	[_squadGroup, _squadDestination, _squadSpawnPrecision select 1] spawn Gemini_fnc_doPatrol;
*/

// GETTING ARGUMENTS
private _squad = param [0, grpNull, [grpNull, objNull]]; if (typeName _squad == "OBJECT") then {_squad = group _squad};
private _center = param [1, [0,0,0], [[], objNull]]; if (typeName _center == "OBJECT") then {_center = position _center};
private _radius = param [2, [0, 500], [[], 0]]; if (typeName _radius != "ARRAY") then {_radius = [_radius / 10, _radius]};
private _surface = param [3, "land", [""]]; if (vehicle (leader _squad) != leader _squad) then {_surface = "road"};

// DEFINING MAIN FUNCTION
_waypointLoop =
	{
		// GETTING ARGUMENTS
		params ["_squad", "_center", "_radius", "_surface"];

		// DELETING PREVIOUS WAYPOINTS (IF THERE ARE ANY)
		while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};

		// CREATING NEW WAYPOINTS
		for "_i" from 1 to 5 do
			{
				// LOOKING FOR A RANDOM POSITION
				private _position = [_surface, _center, 25 + (_radius select 0), 25 + (_radius select 1)] call Gemini_fnc_findPos;
				if (_position isEqualTo [0,0,0]) then {_position = _center};

				// CREATING A WAYPOINT
				private ["_wp"];
				_wp = _squad addWaypoint [_position, -1];
				_wp setWaypointType "move";
				_wp setWaypointCompletionRadius 0;
				//if (vehicle (leader _squad) == leader _squad) then {_wp setWaypointTimeout [0, 10, 30]} else {_wp setWaypointTimeout [0, 0, 0]};
				_wp setWaypointTimeout [0, 0, 0];
				_wp setWaypointSpeed "limited";
				_wp setWaypointFormation (selectRandom ["column", "stag column", "vee", "line"]);
				_wp setWaypointBehaviour "safe";
				_wp setWaypointCombatMode "red";
				_wp setWaypointStatements ["true", "deleteWaypoint [group this, currentWaypoint (group this)]"];

				// LOOKING FOR A BUILDING - IF FOUND, RANDOMLY MOVING POSITION TO IT (INFANTRY PATROL ONLY)
				if ((vehicle leader _squad == leader _squad) && ((nearestBuilding (waypointPosition _wp) distance2D (waypointPosition _wp)) < 50) && (random 100 > 50)) then
					{
						_wp setWaypointPosition [position (nearestBuilding (waypointPosition _wp)), -1];
						_wp waypointAttachObject (nearestBuilding (waypointPosition _wp));
						_wp setWaypointHousePosition (count (nearestBuilding (waypointPosition _wp) buildingPos -1) - 1);
					};

				// DEBUGGING
				/*
				private _debug = OPEX_debug;
				if (_debug) then {[waypointPosition _wp, "mil_pickup", "ColorWhite", ""] call Gemini_fnc_createMarker};
				*/
			};
	};

// INITIALIZING FUNCTION
while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
while {{alive _x} count (units _squad) > 0} do
	{
		if (count waypoints _squad == 0) then {[_squad, _center, _radius, _surface] call _waypointLoop};
		sleep 3;
	};