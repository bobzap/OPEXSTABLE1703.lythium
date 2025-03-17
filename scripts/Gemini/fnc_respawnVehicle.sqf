// =========================================================================================================
// EXECUTING ON SERVER ONLY
// =========================================================================================================

	if (!isServer) exitWith {};


// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private ["_vehicle", "_newVehicle"];


// =========================================================================================================
// GETTING ARGUMENT(S) 
// =========================================================================================================

	_vehicle = _this select 0;


// =========================================================================================================
// EXECUTING SCRIPT
// =========================================================================================================

	// GETTING INITIAL VEHICLE INFORMATION
		private ["_position", "_direction", "_type"];	
		sleep 1;
		_vehicle setVariable ["respawnVehicle_position", position _vehicle, true];
		_vehicle setVariable ["respawnVehicle_direction", getDir _vehicle, true];
		_vehicle setVariable ["respawnVehicle_type", typeOf _vehicle, true];
		_position = _vehicle getVariable "respawnVehicle_position";
		_direction = _vehicle getVariable "respawnVehicle_direction";
		_type = _vehicle getVariable "respawnVehicle_type";

	// DELETING VEHICLE IF IT HAS BEEN DESTROYED OR IF IT HAS BEEN LEAVED, AND IF NO FRIENDLY UNITS ARE NEARBY
		[_vehicle] spawn 
			{
				private ["_vehicle"];
				_vehicle = _this select 0;
				while {(alive _vehicle) && ((_vehicle getVariable "respawnVehicle_position") distance _vehicle < 500)} do {sleep 5};
				while {{(_x distance _vehicle < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) > 0} do {sleep 5};
				deleteVehicle _vehicle;
			};

	// WAITING UNTIL ONE OF CONDITION BELOW IS NOT TRUE ANYMORE...
		while 
			{
				(
					// VEHICLE IS NEARBY ITS INITIAL POSITION
						(_vehicle distance (_vehicle getVariable "respawnVehicle_position") < 500) 
					&& 
					// VEHICLE IS ALIVE
						(alive _vehicle)
				)
				||
				// THERE IS NO FRIENDLY UNITS NEARBY
					({(_x distance _vehicle < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) > 0)					
			} 
		do {sleep 1};

	// CHECKING IF THERE IS NO VEHICLE AT RESPAWN POSITION AND IF THERE IS NO PLAYER NEARBY
		waitUntil {sleep 5; ((count (nearestObjects [_position, ["Car","Tank","Air","Man","Motorcycle"], 2]) == 0) && ({_position distance _x > 10} count (playableUnits + switchableUnits) > 0))};		

	// RESPAWNING VEHICLE
		_newVehicle = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
		_newVehicle setDir _direction;
		0 = [_newVehicle] execVM "scripts\Gemini\fnc_respawnVehicle.sqf";


// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================	

	if (true) exitWith {};