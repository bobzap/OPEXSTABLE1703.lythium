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
			[player, askSupport_airStrike] remoteExec ["BIS_fnc_removeCommMenuItem"];
			OPEX_support_airStrike = false; publicVariable "OPEX_support_airStrike";
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
								airStrikeMarker = createMarker ['airStrikeMarker', _pos];
								'airStrikeMarker' setMarkerType 'mil_destroy';
								'airStrikeMarker' setMarkerColor 'colorRed';
								'airStrikeMarker' setMarkerText localize 'STR_OPEX_support_airStrike';
								if (!OPEX_debug) then {onMapSingleClick ''} else {onMapSingleClick '(vehicle player) setPos _pos'};
		"};
	if (alive _caller) then {openMap true};
	while {alive _caller && !click} do
		{
			sleep 1;
			if (!visibleMap) then
				{
					click = true; publicVariable "click";
					airStrikeMarker = createMarker ["airStrikeMarker", position _caller];
					"airStrikeMarker" setMarkerType "mil_destroy";
					"airStrikeMarker" setMarkerColor "colorRed";
					"airStrikeMarker" setMarkerText localize "STR_OPEX_support_airStrike";
					if (!OPEX_debug) then {onMapSingleClick ""} else {onMapSingleClick "(vehicle player) setPos _pos"}
				};
		};
	click = false; publicVariable "click";
	sleep 0.5;
	openMap false;

	// RADIO MESSAGE
	systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_confirmed"];
	sleep 5;
	systemChat format ["%1 : %2", localize "STR_codeName_HQ",  (format [localize "STR_support_ETA_laser", 1])];
	if (OPEX_debug) then {sleep 6} else {sleep 60};

// =========================================================================================================
// SPAWNING SUPPORT
// =========================================================================================================

	// SPAWNING CAS
	private _CAS = (createGroup OPEX_friendly_side1) createUnit ["ModuleCAS_F", getMarkerPos "airStrikeMarker", [], 0, "CAN_COLLIDE"];
	//_CAS setVariable ["vehicle", selectRandom OPEX_friendly_aircrafts, true];
	_CAS setVariable ["vehicle", "B_Plane_CAS_01_dynamicLoadout_F", true];
	_CAS setVariable ["type", 2, true]; // (0 = guns / 1 = missiles / 2 = both)

	sleep 30;
	deleteMarker "airStrikeMarker";
	OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";