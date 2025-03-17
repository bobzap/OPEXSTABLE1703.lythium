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
			[player, askSupport_airAssistance] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_airAssistance = false; publicVariable "OPEX_support_airAssistance";
		};

	// APPROVING REQUEST
	OPEX_incomingSupport = true; publicVariable "OPEX_incomingSupport";
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
								airAssistanceMarker = createMarker ['airAssistanceMarker', _pos];
								'airAssistanceMarker' setMarkerType 'mil_join';
								'airAssistanceMarker' setMarkerColor 'colorBlue';
								'airAssistanceMarker' setMarkerText localize 'STR_OPEX_support_airAssistance';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					airAssistanceMarker = createMarker ["airAssistanceMarker", position _caller];
					"airAssistanceMarker" setMarkerType "mil_join";
					"airAssistanceMarker" setMarkerColor "colorBlue";
					"airAssistanceMarker" setMarkerText localize "STR_OPEX_support_airAssistance";
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

	private _validPos = ["any", _caller, 1000, 5000] call Gemini_fnc_findPos;

// =========================================================================================================
// SPAWNING SUPPORT
// =========================================================================================================

	private _height = 75;
	private _spawnPos = [_validPos select 0, _validPos select 1, _height];
	private _chopperType = selectRandom (OPEX_friendly_smallCombatHelicopters + OPEX_friendly_mediumCombatHelicopters);
	private _chopper = ([_spawnPos, 0, _chopperType, OPEX_friendly_side1] call BIS_fnc_spawnVehicle) select 0;
	_chopper setPos [getPos _chopper select 0, getPos _chopper select 1, _height];
	_chopper setDir ([_chopper, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_dirTo);
	_chopper setBehaviour "stealth";
	_chopper setCombatMode "blue";
	_chopper setSpeedMode "full";
	_chopper doMove (getMarkerPos "airAssistanceMarker");
	_chopper flyInHeight _height;
	_chopper allowFleeing 0;
	_chopper disableAI "target";
	_chopper disableAI "autoTarget";
	_chopper setSkill 1;
	private _pilot = driver _chopper;

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (OPEX_debug) then
		{
			[_chopper, _spawnPos] spawn
				{
					sleep 1;
					_debugMarker = createMarker [format ["debugMarker_%1", random 100000], (_this select 1)];
					_debugMarker setMarkerType "mil_triangle";
					_debugMarker setMarkerColor "colorBlue";
					_debugMarker setMarkerText "SUPPORT";
					while {alive (_this select 0)} do {sleep 1; _debugMarker setMarkerPos (position (_this select 0))};
					deleteMarker _debugMarker;
				};
		};

// =========================================================================================================
// CALCULATING ETA
// =========================================================================================================

	waitUntil {sleep 1; speed _chopper > 100};
	sleep 5;
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", (format [localize "STR_support_ETA", round ((((_chopper distance2D (getMarkerPos "suppliesDropMarker"))/1000) / (speed _chopper))*60)])];

// =========================================================================================================
// SUPPORTING
// =========================================================================================================

	while {canMove _chopper && (([_chopper, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_distance2D) > 500)} do {sleep 1};
	_chopper enableAI "target";
	_chopper enableAI "autoTarget";
	_chopper setBehaviour "combat";
	_chopper setCombatMode "red";
	_chopper setSpeedMode "normal";
	_chopper flyInHeight 50;
	_wp = (group _chopper) addWaypoint [(getMarkerPos "airAssistanceMarker"), 0];
	_wp setWaypointType "SAD";
	{if (((side _x) == OPEX_enemy_side1) && (([_x, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_distance2D) < 500)) then {{_chopper reveal _x}}} forEach allUnits;
	while {(canMove _chopper) && (isNull (assignedTarget _chopper)) && (([_chopper, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_distance2D) >= 100) && (([_chopper, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_distance2D) < 1000)}
	do {sleep 1};
	_chopper setBehaviour "combat";
	while {(canMove _chopper) && (speed _chopper > 10) && (behaviour _chopper == "combat") && (someAmmo _chopper) && (canFire _chopper)}
	do {sleep 1; {if (((side _x) == OPEX_enemy_side1) && (([_x, (getMarkerPos "airAssistanceMarker")] call BIS_fnc_distance2D) < 500)) then {{_chopper reveal _x; _chopper doTarget _x}}} forEach allUnits};

// =========================================================================================================
// DELETING SUPPORT
// =========================================================================================================

	while {(count (waypoints group _chopper)) > 0} do {deleteWaypoint ((waypoints group _chopper) select 0)};
	deleteMarker "airAssistanceMarker";
	if (alive (_chopper)) then {_chopper flyInHeight _height; _chopper doMove _spawnPos};
	while {(canMove _chopper) && ({_x distance2D _chopper < 2500} count (allPlayers - entities "HeadlessClient_F") !=  0)} do {sleep 1};
	if ((!canMove _chopper) || (getPos _chopper select 2 < 3)) then {systemChat format ["%1 : %2", localize "STR_codeName_HQ",  localize "STR_support_destroyed"]};
	waitUntil {sleep 1; ({_x distance2D _chopper < 2500} count (allPlayers - entities "HeadlessClient_F") ==  0)};
	{deleteVehicle _x} forEach units group _pilot; {deleteVehicle _x} forEach ([_chopper] + (crew _chopper));
	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";