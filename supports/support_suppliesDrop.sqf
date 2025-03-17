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
			[player, askSupport_suppliesDrop] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_suppliesDrop = false; publicVariable "OPEX_support_suppliesDrop";
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
								suppliesDropMarker = createMarker ['suppliesDropMarker', _pos];
								'suppliesDropMarker' setMarkerType 'mil_flag';
								'suppliesDropMarker' setMarkerColor 'colorBlack';
								'suppliesDropMarker' setMarkerText localize 'STR_OPEX_support_suppliesDrop';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					suppliesDropMarker = createMarker ["suppliesDropMarker", position _caller];
					"suppliesDropMarker" setMarkerType "mil_flag";
					"suppliesDropMarker" setMarkerColor "colorBlack";
					"suppliesDropMarker" setMarkerText localize "STR_OPEX_support_suppliesDrop";
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
	_aircraft setDir ([_aircraft, (getMarkerPos "suppliesDropMarker")] call BIS_fnc_dirTo);
	_aircraft setBehaviour "stealth";
	_aircraft setCombatMode "green";
	_aircraft setSpeedMode "full";
	_aircraft doMove (getMarkerPos "suppliesDropMarker");
	_aircraft flyInHeight _height;
	_aircraft allowFleeing 0;
	_aircraft setSkill 1;
	private _pilot = driver _aircraft;
	_aircraft allowDamage false;
	_pilot allowDamage false;

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
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", (format [localize "STR_support_ETA", round ((((_aircraft distance2D (getMarkerPos "suppliesDropMarker"))/1000) / (speed _aircraft))*60)])];

// =========================================================================================================
// SUPPORTING
// =========================================================================================================

	// WAITING FOR SUPPORT HAS REACH DESTINATION
	while {canMove _aircraft && !unitReady _pilot} do {sleep 1};

	// DROPPING SUPPLIES
	private ["_ammoBox"];
	if (canMove _aircraft) then
		{
			private _parachute = createVehicle ["B_Parachute_02_F", [(getPos _aircraft select 0), (getPos _aircraft select 1), (getPos _aircraft select 2)], [], 0, "FLY"];
			_parachute setPos [(getPos _aircraft select 0), (getPos _aircraft select 1), (getPos _aircraft select 2)-15];
			_ammoBox = createVehicle ["B_supplyCrate_F", (position _parachute), [], 0, "FLY"];
			_ammoBox allowDamage false;
			clearWeaponCargoGlobal _ammoBox; clearMagazineCargoGlobal _ammoBox; clearItemCargoGlobal _ammoBox; clearBackpackCargoGlobal _ammoBox;
			private ["_index"];
			_index = 0; for "_i" from 1 to (count OPEX_friendly_commonRifles) do {_ammoBox addItemCargoGlobal [(OPEX_friendly_commonRifles select _index), 5]; _index = _index + 1};
			_index = 0; for "_i" from 1 to (count (OPEX_friendly_specialRifles + OPEX_friendly_GLrifles + OPEX_friendly_MGrifles + OPEX_friendly_precisionRifles)) do {_ammoBox addItemCargoGlobal [((OPEX_friendly_specialRifles + OPEX_friendly_GLrifles + OPEX_friendly_MGrifles + OPEX_friendly_precisionRifles) select _index), 1]; _index = _index + 1};
			_index = 0; for "_i" from 1 to (count OPEX_enemy_ATlaunchers) do {_ammobox addItemCargoGlobal [(OPEX_enemy_ATlaunchers select _index), 1]; _index = _index + 1};
			{_ammobox addItemCargoGlobal [(getArray (configfile >> "CfgWeapons" >> _x >> "magazines")) select 0, 50]} forEach OPEX_friendly_commonRifles;
			{_ammobox addItemCargoGlobal [(getArray (configfile >> "CfgWeapons" >> _x >> "magazines")) select 0, 10]} forEach (OPEX_friendly_specialRifles + OPEX_friendly_GLrifles + OPEX_friendly_MGrifles + OPEX_friendly_precisionRifles);
			{_ammobox addItemCargoGlobal [(getArray (configfile >> "CfgWeapons" >> _x >> "magazines")) select 0, 3]} forEach OPEX_friendly_ATlaunchers;
			_index = 0; for "_i" from 1 to (count OPEX_friendly_handGrenades) do {_ammobox addItemCargoGlobal [(OPEX_friendly_handGrenades select _index), 25]; _index = _index + 1};
			_index = 0; for "_i" from 1 to (count OPEX_friendly_smokeGrenades_white) do {_ammobox addItemCargoGlobal [(OPEX_friendly_smokeGrenades_white select _index), 10]; _index = _index + 1};
			_index = 0; for "_i" from 1 to (count OPEX_friendly_closeCombatOptics) do {_ammobox addItemCargoGlobal [(OPEX_friendly_closeCombatOptics select _index), 1]; _index = _index + 1};
			_index = 0; for "_i" from 1 to 1 do {_ammobox addItemCargoGlobal [OPEX_medical_firstAidKit, 10]; _index = _index + 1};
			if (count OPEX_medical_commonSupplies > 0) then {_index = 0; for "_i" from 1 to (count OPEX_medical_commonSupplies) do {_ammobox addItemCargoGlobal [(OPEX_medical_commonSupplies select _index), 10]; _index = _index + 1}};
			_ammoBox attachTo [_parachute, [0, 0, -1.3]];
			private _light1 = "B_IRStrobe" createVehicle [0,0,0]; _light1 attachTo [_ammoBox, [0,0,0.44]];
			private _light2 = "B_IRStrobe" createVehicle [0,0,0]; _light2 attachTo [_ammoBox, [0,0,-0.9]];
			[_parachute, _ammoBox] spawn
				{
					private _parachute = _this select 0;
					private _ammoBox = _this select 1;
					waitUntil {sleep 1; (getPos _ammoBox select 2) < 1 || isNull _parachute};
					"suppliesDropMarker" setMarkerColor "colorGreen";
					detach _ammoBox;
					_ammoBox setPosATL [getPos _ammoBox select 0, (getPos _ammoBox select 1), 0];
					deleteVehicle _parachute;
					_ammoBox allowDamage true;
					"suppliesDropMarker" setMarkerPos (position _ammoBox);
					private _smoke = "SmokeShellBlue" createVehicle (position _ammoBox);
					if (OPEX_sunHeight < 0) then {_smoke = "Chemlight_blue" createVehicle (position _ammoBox)};
				};
		};

// =========================================================================================================
// DELETING SUPPORT
// =========================================================================================================

	[_ammoBox] spawn {_ammoBox = _this select 0; waitUntil {sleep 1; ({_x distance2D _ammoBox < 500} count (allPlayers - entities "HeadlessClient_F") ==  0)}; deleteVehicle _ammoBox; deleteMarker "suppliesDropMarker"};
	if (canMove (_aircraft)) then {_pilot doMove _exitPos};
	while {canMove _aircraft && ({_x distance2D _aircraft < 2500} count (allPlayers - entities "HeadlessClient_F") !=  0)} do {sleep 1};
	if (!canMove _aircraft) then {systemChat format ["%1 : %2", localize "STR_codeName_HQ",  localize "STR_support_destroyed"]};
	waitUntil {sleep 1; ({_x distance2D _aircraft < 2500} count (allPlayers - entities "HeadlessClient_F") ==  0)};
	{deleteVehicle _x} forEach units group _pilot; {deleteVehicle _x} forEach ([_aircraft] + (crew _aircraft));
	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";