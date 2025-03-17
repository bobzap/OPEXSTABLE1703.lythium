// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	private _caller = _this select 0; // unit who's requesting support
	private _debug = OPEX_debug; // OPEX_debug mod (true or false)

// =========================================================================================================
// CHECKING REQUEST
// =========================================================================================================

	// SENDING REQUEST
	systemChat format ["%1 : %2", name _caller, localize "STR_support_requested"];
	if (OPEX_incomingSupport) exitWith {sleep 5 + (random 10); systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_notAvailable"]; OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport"};
	OPEX_incomingSupport = true; publicVariable "OPEX_incomingSupport";
	sleep 5 + (random 10);

	// CHECKING REQUEST
	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorizedLeaderOnly"]; OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport"};
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_wait"];

	// STARTING SUPPORT
	if (OPEX_param_supportManagement == 0) then
		{
			[player, askSupport_landAssistance] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_landAssistance = false; publicVariable "OPEX_support_landAssistance";
		};

	// APPROVING REQUEST
	sleep 5 + (random 10);
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_authorized"];

// =========================================================================================================
// WAITING FOR COORDINATES
// =========================================================================================================

	// OPENING MAP
	click = false; publicVariable "click";
	if (alive _caller) then
		{onMapSingleClick "
								click = true;
								publicVariable 'click';
								landAssistanceMarker = createMarker ['landAssistanceMarker', _pos];
								'landAssistanceMarker' setMarkerType 'mil_join';
								'landAssistanceMarker' setMarkerColor 'colorBlue';
								'landAssistanceMarker' setMarkerText localize 'STR_OPEX_support_landAssistance';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					landAssistanceMarker = createMarker ["landAssistanceMarker", position _caller];
					"landAssistanceMarker" setMarkerType "mil_join";
					"landAssistanceMarker" setMarkerColor "colorBlue";
					"landAssistanceMarker" setMarkerText localize "STR_OPEX_support_landAssistance";
					if (!OPEX_debug) then {onMapSingleClick ""} else {onMapSingleClick "(vehicle player) setPos _pos"}
				};
		};
	click = false; publicVariable "click";
	sleep 0.5;
	openMap false;

	// RADIO MESSAGE
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_confirmed"];

// =========================================================================================================
// SEARCHING FOR POSITION TO SPAWN SUPPORT
// =========================================================================================================

	private _validPos = ["land", getMarkerPos "landAssistanceMarker", OPEX_spawnDistanceMini, OPEX_spawnDistanceMini * 1.5] call Gemini_fnc_findPos;

// =========================================================================================================
// CALCULATING ETA
// =========================================================================================================

	sleep 5;
	systemChat format ["%1 : %2", localize "STR_codeName_HQ",  (format [localize "STR_support_ETA", 10])];

// =========================================================================================================
// SUPPORTING
// =========================================================================================================

	for "_i" from 1 to (selectRandom [1,2,3]) do
		{
			sleep 1;

			// SPAWNING SQUAD
			private ["_squad"];
			private _roadsNearby = [];
			private _roadsNearby = _validPos nearRoads 75;
			if ((count _roadsNearby > 0) && (random 10 >= 5))
			then
				{
					// MOTORIZED SQUAD
					private _roadPos = position (_roadsNearby call BIS_fnc_selectRandom);
					private _spawnPos = _roadPos findEmptyPosition [0, 25, "B_Heli_Transport_01_F"];
					if (count _spawnPos == 0) then {_spawnPos = _roadPos};
					private _squad = [OPEX_friendly_side1, ["motorized", "armored"], 3 + round random 9, _spawnPos, 25, "patrol", position _caller, OPEX_friendly_AIskill, 100] call Gemini_fnc_spawnSquad;
					private _vehicle = (vehicle leader _squad);
					_vehicle limitSpeed 40;
					{_x allowDamage false} forEach units _squad;
					_vehicle allowDamage false;
				}
			else
				{
					// INFANTRY SQUAD
					_squad = [OPEX_friendly_side1, ["infantry"], 6 + round random 12, [(_validPos select 0) + random 50 - random 50, (_validPos select 1) + random 50 - random 50, 0], 25, "patrol", position _caller, OPEX_friendly_AIskill, 100] call Gemini_fnc_spawnSquad;
					{_x allowDamage false} forEach units _squad;
				};

			sleep 1;

			// MOVING
			while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
			if (vehicle leader _squad == leader _squad) then {_squad setBehaviour "aware"} else {_squad setBehaviour "safe"};
			_squad setCombatMode "red";
			_squad setSpeedMode "normal";
			_squad setFormation (["column", "wedge", "vee", "line", "file", "diamond"] call BIS_fnc_selectRandom);
			private _wp1 = _squad addWaypoint [(getMarkerPos "landAssistanceMarker"), 0];
			_wp1 setWaypointType "move";

			// DEBUGGING
			if (OPEX_debug) then
				{
					[_squad, _validPos] spawn
						{
							sleep 1;
							_debugMarker = createMarker [format ["debugMarker_%1", random 100000], (_this select 1)];
							_debugMarker setMarkerType "mil_triangle";
							_debugMarker setMarkerColor "colorBlue";
							_debugMarker setMarkerText "SUPPORT";
							while {alive leader (_this select 0)} do {sleep 1; _debugMarker setMarkerPos (position leader (_this select 0))};
							deleteMarker _debugMarker;
						};
				};

			// SUPPORTING
			[_squad, _validPos] spawn
				{
					private _squad = _this select 0;
					private _validPos = _this select 1;

					// SUPPORTING
					while {count units _squad > 0 && (([leader _squad, (getMarkerPos "landAssistanceMarker")] call BIS_fnc_distance2D) > 200) && (getMarkerColor "landAssistanceMarker" != "")} do {sleep 1};
					_squad setBehaviour "combat";
					_squad setCombatMode "red";
					_squad setSpeedMode "limited";
					{_x allowDamage true} forEach units _squad;
					if ((vehicle leader _squad) != leader _squad) then {(vehicle leader _squad) allowDamage true};
					private ["_wp2"];
					if (getMarkerColor "landAssistanceMarker" != "")
					then {_wp2 = _squad addWaypoint [(getMarkerPos "landAssistanceMarker"), 0]; _wp2 setWaypointType "SAD"}
					else {_wp2 = _squad addWaypoint [_validPos, 0]; _wp2 setWaypointType "move"};
					while {(count units _squad > 0) && (!unitReady leader _squad)} do {sleep 1};

					// DELETING SUPPORT
					while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
					_squad setSpeedMode "normal";
					_squad setBehaviour "safe";
					deleteMarker "landAssistanceMarker";
					private ["_wp3"];
					if (count units _squad > 0) then {_wp3 = _squad addWaypoint [_validPos, 0]; _wp3 setWaypointType "move"};
					while {(count units _squad > 0) && ({_x distance2D (leader _squad) < 750} count (allPlayers - entities "HeadlessClient_F") !=  0)} do {sleep 1};
					if (count units _squad == 0) then {systemChat format ["%1 : %2", localize "STR_codeName_HQ",  localize "STR_support_destroyed"]};
					waitUntil {sleep 1; ({_x distance2D (leader _squad) < 750} count (allPlayers - entities "HeadlessClient_F") ==  0)};
					{deleteVehicle _x} forEach units _squad;
					OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";
				};
		};