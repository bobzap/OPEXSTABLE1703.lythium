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
			[player, askSupport_vehicleDrop] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_vehicleDrop = false; publicVariable "OPEX_support_vehicleDrop";
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
								vehicleDropMarker = createMarker ['vehicleDropMarker', _pos];
								'vehicleDropMarker' setMarkerType 'mil_flag';
								'vehicleDropMarker' setMarkerColor 'colorBlack';
								'vehicleDropMarker' setMarkerText localize 'STR_OPEX_support_vehicleDrop';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					vehicleDropMarker = createMarker ["vehicleDropMarker", position _caller];
					"vehicleDropMarker" setMarkerType "mil_flag";
					"vehicleDropMarker" setMarkerColor "colorBlack";
					"vehicleDropMarker" setMarkerText localize "STR_OPEX_support_vehicleDrop";
					if (!OPEX_debug) then {onMapSingleClick ""} else {onMapSingleClick "(vehicle player) setPos _pos"}
				};
		};
	click = false; publicVariable "click";
	sleep 0.5;
	openMap false;

// =========================================================================================================
// SEARCHING FOR POSITION TO SPAWN SUPPORT
// =========================================================================================================

	private _validPos = ["any", _caller, 1000, 5000] call Gemini_fnc_findPos;

// =========================================================================================================
// SEARCHING FOR A POSITION TO DESPAWN SUPPORT
// =========================================================================================================

	private _startX = _validPos select 0;
	private _startY = _validPos select 1;
	private _destX = (getMarkerPos "suppliesDropMarker") select 0;
	private _destY = (getMarkerPos "suppliesDropMarker") select 1;
	private ["_endX", "_endY"];
	if (_startX > _destX) then {_endX = 1.5 * (_destX - _startX)} else {_endX = 1.5 * (_startX + _destX)};
	if (_startY > _destY) then {_endY = 1.5 * (_destY - _startY)} else {_endY = 1.5 * (_startY + _destY)};
	private _exitPos = [_endX, _endY, 250];

// =========================================================================================================
// SPAWNING SUPPORT
// =========================================================================================================

	// AIRCRAFT
	private _height = 250;
	private _spawnPos = [_validPos select 0, _validPos select 1, _height];
	private _aircraftType = selectRandom OPEX_friendly_bigTransportHelicopters;
	private _aircraft = ([_spawnPos, 0, _aircraftType, OPEX_friendly_side1] call BIS_fnc_spawnVehicle) select 0;
	_aircraft setPos [getPos _aircraft select 0, getPos _aircraft select 1, _height];
	_aircraft setDir ([_aircraft, (getMarkerPos "vehicleDropMarker")] call BIS_fnc_dirTo);
	_aircraft setBehaviour "stealth";
	_aircraft setCombatMode "green";
	_aircraft setSpeedMode "full";
	_aircraft doMove (getMarkerPos "vehicleDropMarker");
	_aircraft flyInHeight _height;
	_aircraft allowFleeing 0;
	_aircraft setSkill 1;
	private _pilot = driver _aircraft;

	// VEHICLE TO DROP
	private _vehicle = [OPEX_friendly_transportCars + OPEX_friendly_combatCarsMG + OPEX_friendly_vtt, [(_spawnPos select 0), (_spawnPos select 1), (_height - 50)], 0, true, "unlimited"] call Gemini_fnc_createVehicle;
	private _vehicleMass = getMass _vehicle;

	// ROPE
	_vehicle setMass 800;
	private _rope1 = ropeCreate [_aircraft, [0, 1.5, -2.35], _vehicle, [1.25, 1.75, -0.1], 25];
	private _rope2 = ropeCreate [_aircraft, [0, 1.5, -2.35], _vehicle, [-1.25, 1.75, -0.1], 25];
	private _rope3 = ropeCreate [_aircraft, [0, 1.5, -2.35], _vehicle, [1.25, -1.75, -0.1], 25];
	private _rope4 = ropeCreate [_aircraft, [0, 1.5, -2.35], _vehicle, [-1.25, -1.75, -0.1], 25];

	// RADIO MESSAGE
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_confirmed"];

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (OPEX_debug) then
		{
			[_aircraft, _spawnPos] spawn
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

	waitUntil {sleep 1; speed _aircraft > 100};
	sleep 5;
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", (format [localize "STR_support_ETA", round ((((_aircraft distance2D (getMarkerPos "vehicleDropMarker"))/1000) / (speed _aircraft))*60)])];
	_aircraft flyInHeight (_height / 2);

// =========================================================================================================
// SUPPORTING
// =========================================================================================================

	// WAITING FOR SUPPORT HAS REACH DESTINATION
	while {canMove _aircraft && !unitReady _pilot} do {sleep 1};

	// DROPPING VEHICLE
	if (canMove _aircraft) then
		{
			private ["_helipad"];
			private _smoke = (getMarkerPos "vehicleDropMarker") nearestObject "SmokeShell";
			if (alive _smoke) then {_helipad = "Land_HelipadEmpty_F" createVehicle (position _smoke)} else {_helipad = "Land_HelipadEmpty_F" createVehicle (getMarkerPos "vehicleDropMarker")};
			if (alive _aircraft) then {_aircraft land "get in"};
			waitUntil {sleep 1; ((!canMove _aircraft) || ((getPos _vehicle select 2) < 1))};
			deleteVehicle _helipad;
			_aircraft land "none";
			_vehicle setMass _vehicleMass;
			_vehicle ropeDetach _rope1;
			_vehicle ropeDetach _rope2;
			_vehicle ropeDetach _rope3;
			_vehicle ropeDetach _rope4;
			"vehicleDropMarker" setMarkerPos (position _vehicle);
			"vehicleDropMarker" setMarkerColor "colorGreen";
			_aircraft flyInHeight (_height * 2);
			_vehicle enableSimulationGlobal true;
			_vehicle setFuel 1;
			_vehicle setDamage 0;
		};

// =========================================================================================================
// DELETING SUPPORT
// =========================================================================================================

	[_vehicle] spawn {_vehicle = _this select 0; waitUntil {sleep 1; ({_x distance2D _vehicle < 5} count (allPlayers - entities "HeadlessClient_F") > 0)}; deleteMarker "vehicleDropMarker"};
	if (alive (_aircraft)) then {_pilot doMove _exitPos};
	while {canMove _aircraft && ({_x distance2D _aircraft < 2000} count (allPlayers - entities "HeadlessClient_F") !=  0)} do {sleep 1};
	if (!canMove _aircraft) then {systemChat format ["%1 : %2", localize "STR_codeName_HQ",  localize "STR_support_destroyed"]};
	waitUntil {sleep 1; ({_x distance2D _aircraft < 2000} count (allPlayers - entities "HeadlessClient_F") ==  0)};
	{deleteVehicle _x} forEach units group _pilot; {deleteVehicle _x} forEach ([_aircraft] + (crew _aircraft));
 	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";