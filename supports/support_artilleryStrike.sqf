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
			[player, askSupport_artilleryStrike] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_artilleryStrike = false; publicVariable "OPEX_support_artilleryStrike";
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
								artilleryStrikeMarker = createMarker ['artilleryStrikeMarker', _pos];
								'artilleryStrikeMarker' setMarkerType 'mil_destroy';
								'artilleryStrikeMarker' setMarkerColor 'colorRed';
								'artilleryStrikeMarker' setMarkerText localize 'STR_OPEX_support_artilleryStrike';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					artilleryStrikeMarker = createMarker ["artilleryStrikeMarker", position _caller];
					"artilleryStrikeMarker" setMarkerType "mil_destroy";
					"artilleryStrikeMarker" setMarkerColor "colorRed";
					"artilleryStrikeMarker" setMarkerText localize "STR_OPEX_support_artilleryStrike";
					if (!OPEX_debug) then {onMapSingleClick ""} else {onMapSingleClick "(vehicle player) setPos _pos"}
				};
		};
	click = false; publicVariable "click";
	sleep 0.5;
	openMap false;

	// RADIO MESSAGE
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_confirmed"];

// =========================================================================================================
// BOMBING
// =========================================================================================================

	// SIMULATING ETA
	sleep (random 10);
	systemChat format ["%1 : %2", localize "STR_codeName_HQ",  (format [localize "STR_support_ETA", 1])];
	if (_debug) then {sleep 6} else {sleep 60};
	private _count = 0;
	private _precision = 50; // strike precision
	private _strikes = 10; // strike number
	while {_count != _strikes} do
		{
			_count = _count + 1;
			// Sh_82mm_AMOS / Sh_120mm_HE
			private _bomb = "Sh_82mm_AMOS" createVehicle [(getMarkerPos "artilleryStrikeMarker" select 0) + (round random _precision - round random _precision), (getMarkerPos "artilleryStrikeMarker" select 1) + (round random _precision - round random _precision), 175];
			_bomb setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
			_bomb setVelocity [0,0,-100];
			[_bomb] spawn {(_this select 0) say "arti_incoming"};
			sleep 5 + (random 5); // time between each shell
		};

	// DELETING MARKER
	deleteMarker "artilleryStrikeMarker";
	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";