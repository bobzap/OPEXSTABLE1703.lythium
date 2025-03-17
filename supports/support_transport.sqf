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
			[player, askSupport_transport] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_transport = false; publicVariable "OPEX_support_transport";
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
								transportMarker = createMarker ['transportMarker', _pos];
								'transportMarker' setMarkerType 'mil_pickup';
								'transportMarker' setMarkerColor 'colorBlue';
								'transportMarker' setMarkerText localize 'STR_OPEX_support_transport';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					transportMarker = createMarker ["transportMarker", position _caller];
					"transportMarker" setMarkerType "mil_pickup";
					"transportMarker" setMarkerColor "colorBlue";
					"transportMarker" setMarkerText (localize "STR_OPEX_support_transport");
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
// SPAWNING SUPPORT
// =========================================================================================================

	// CHECKING HOW MANY FRIENDLY UNITS ARE NEARBY THE CALLER
	private _nearbyUnits = _caller nearEntities ["Man", 100];
	{if (side _x != side _caller) then {_nearbyUnits = _nearbyUnits - [_x]}} forEach _nearbyUnits;
	private _squadCount = count units (group _caller);
	private _amount = 1 + ((count _nearbyUnits) max _squadCount);
	private ["_chopperType"];
	if (_amount < 6) then {_chopperType = selectRandom OPEX_friendly_smallTransportHelicopters} else {_chopperType = selectRandom OPEX_friendly_bigTransportHelicopters};

	// CHOPPER
	private _height = (50 + random 200);
	private _spawnPos = [_validPos select 0, _validPos select 1, _height];
	private _chopper = ([_spawnPos, 0, _chopperType, OPEX_friendly_side1] call BIS_fnc_spawnVehicle) select 0;
	_chopper setPos [getPos _chopper select 0, getPos _chopper select 1, _height];
	_chopper setDir ([_chopper, (getMarkerPos "transportMarker")] call BIS_fnc_dirTo);
	_chopper setBehaviour "safe";
	_chopper setCombatMode "green";
	_chopper setSpeedMode "full";
	_chopper move (getMarkerPos "transportMarker");
	_chopper flyInHeight _height;
	_chopper allowFleeing 0;
	_chopper setSkill 1;
	_chopper lock true;
	[_chopper, "support_"] call Gemini_fnc_setUnitName;
	0 = [_chopper] spawn Gemini_fnc_vehicleMusicReceiver_initVehicle;
	clearWeaponCargoGlobal _chopper; clearMagazineCargoGlobal _chopper; clearItemCargoGlobal _chopper; clearBackpackCargoGlobal _chopper;
	private _pilot = driver _chopper;
	_pilot setRank "captain";
	{[_x] joinSilent (group _pilot)} forEach ((crew _chopper) - [_pilot]);
	[_pilot, "target"] remoteExec ["disableAI", _chopper];
	[_pilot, "autotarget"] remoteExec ["disableAI", _chopper];
	[_pilot, "suppression"] remoteExec ["disableAI", _chopper];
	[_pilot, "autocombat"] remoteExec ["disableAI", _chopper];

	// RADIO MESSAGE
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_confirmed"];

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
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", (format [localize "STR_support_ETA", round ((((_chopper distance2D (getMarkerPos "transportMarker"))/1000) / (speed _chopper))*60)])];

// =========================================================================================================
// SUPPORTING
// =========================================================================================================

	// WAITING FOR SUPPORT HAS REACH DESTINATION
	//while {canMove _chopper && !unitReady _pilot} do {sleep 1};
	while {canMove _chopper && (_chopper distance2D (getMarkerPos "transportMarker") > 750)} do {sleep 1};

	// LANDING
	private _smoke = (getMarkerPos "transportMarker") nearestObject "SmokeShell";
	private ["_helipad"];
	if ((alive _smoke) && (_smoke distance (getMarkerPos "transportMarker") < 500)) then {_helipad = "Land_HelipadEmpty_F" createVehicle (position _smoke)} else {_helipad = "Land_HelipadEmpty_F" createVehicle (getMarkerPos "transportMarker")};
	waitUntil {unitReady _pilot};
	if (canMove _chopper) then {_chopper land "get in"};
	while {(canMove _chopper) && (getPos _chopper select 2 > 5)} do {sleep 3};
	_chopper flyInHeight 0;
	_chopper lock false;
	_chopper animateDoor ["door_L", 1];
	_chopper animateDoor ["door_R", 1];
	_chopper animateDoor ["door_back_L", 1];
	_chopper animateDoor ["door_back_R", 1];
	_chopper animateDoor ["CargoRamp_Open", 1];
	"transportMarker" setMarkerColor "colorGreen";

	// SETTING DESTINATION
	click = false;
	publicVariable "click";
	while {(canMove _chopper) && ({_x in _chopper} count (units group _caller) != count (units group _caller))} do {sleep 1};
	if (canMove _chopper) then
		{
			onMapSingleClick
			"
				click = true;
				publicVariable 'click';
				'transportMarker' setMarkerPos _pos;
				'transportMarker' setMarkerColor 'colorBlue';
			";
		};
	if (canMove _chopper) then {openMap true};
	while {canMove _chopper && !click} do {sleep 1};
	click = false; publicVariable "click";
	sleep 1;
	openMap false;

	// MOVING
	_chopper animateDoor ["door_L", 0];
	_chopper animateDoor ["door_R", 0];
	_chopper animateDoor ["door_back_L", 0];
	_chopper animateDoor ["door_back_R", 0];
	_chopper animateDoor ["CargoRamp_Open", 0];
	_chopper flyInHeight _height; _pilot move (getMarkerPos "transportMarker");
	_chopper setSpeedMode "full";
	while {canMove _chopper && (_chopper distance2D getMarkerPos "transportMarker" > 150)} do {sleep 5; _pilot move (getMarkerPos "transportMarker")};

	// LANDING
	if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
	private _helipadEnd = "Land_HelipadEmpty_F" createVehicle (getMarkerPos "transportMarker");
	_pilot move (position _helipadEnd);
	while {canMove _chopper && !unitReady _pilot} do {sleep 1};
	if (canMove _chopper) then {_chopper land "get out"};
	while {canMove _chopper && getPos _chopper select 2 > 3} do {sleep 1};
	_chopper animateDoor ["door_L", 1];
	_chopper animateDoor ["door_R", 1];
	_chopper animateDoor ["door_back_L", 1];
	_chopper animateDoor ["door_back_R", 1];
	_chopper animateDoor ["CargoRamp_Open", 1];
	_chopper flyInHeight 0;
	while {canMove _chopper && (({_x in _chopper} count allUnits) != (count units (group _pilot)))} do {sleep 1};
	_chopper animateDoor ["door_L", 0];
	_chopper animateDoor ["door_R", 0];
	_chopper animateDoor ["door_back_L", 0];
	_chopper animateDoor ["door_back_R", 0];
	_chopper animateDoor ["CargoRamp_Open", 0];
	_chopper lock true;
	_chopper flyInHeight _height;
	deleteMarker "transportMarker";

// =========================================================================================================
// DELETING SUPPORT
// =========================================================================================================

	if (canMove (_chopper)) then {_chopper move _spawnPos};
	while {canMove _chopper && ({_x distance2D _chopper < 2000} count (allPlayers - entities "HeadlessClient_F") !=  0)} do {sleep 1};
	if (!canMove _chopper) then {systemChat format ["%1 : %2", localize "STR_codeName_HQ",  localize "STR_support_destroyed"]};
	waitUntil {sleep 1; ({_x distance2D _chopper < 2000} count (allPlayers - entities "HeadlessClient_F") ==  0)};
	{deleteVehicle _x} forEach units group _pilot; {deleteVehicle _x} forEach ([_chopper] + (crew _chopper));
	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";

	// REASSIGNING SUPPORT IN SINGLE PLAYER
	if (!isMultiplayer) then {sleep (random 60); ["transport"] remoteExec ["Gemini_fnc_addSupport"]};