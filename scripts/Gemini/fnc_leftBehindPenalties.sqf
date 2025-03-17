if (!isServer) exitWith {};

waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
//waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
//if (!isMultiplayer) exitWith {};
if ((OPEX_param_abandonedVehicles == 0) && (OPEX_param_abandonedBodies == 0)) exitWith {};

while {true} do
	{

		sleep 60;

		if ((!OPEX_assignedTask) && (!OPEX_incomingSupport) && (count (allPlayers - entities "HeadlessClient_F") > 0) && (count OPEX_Zeus == 0)) then
			{
				// APPLYING PENALTY IF A FRIENDLY VEHICLE HAS BEEN ABANDONED INTO THE BATTLEFIELD
				private ["_allVehicles"];
				_allVehicles = vehicles;
				if (OPEX_param_abandonedVehicles == 1) then
					{
						{
							private ["_vehicle", "_value"];
							_vehicle = _x;
							if ((!([position _vehicle, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted)) && ({(_vehicle distance2D _x < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) ==  0) && ((typeOf _vehicle) in OPEX_friendly_vehicles) && (count (crew _vehicle) == 0) && (alive _vehicle)) then
								{
									private ["_value"];
									_value = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "armor");
									if (_vehicle isKindOf "air") then {_value = _value * 10};
									globalStats = globalStats - _value; publicVariable "globalStats";
									[OPEX_friendly_side1, "Base", "STR_globalStats_updateAbandonedVehicle", _value, globalStats] remoteExec ["Gemini_fnc_globalChat"];
									deleteVehicle _vehicle;
								}
						} forEach _allVehicles
					};

				// APPLYING PENALTY IF A FRIENDLY DEAD BODY HAS BEEN ABANDONED INTO THE BATTLEFIELD
				private ["_allUnits"];
				_allUnits = allDeadMen;
				if (OPEX_param_abandonedBodies == 1) then
					{
						{
							private ["_body", "_value"];
							_body = _x;
							if ((!([position _body, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted)) && ({(_body distance2D _x < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) ==  0) && ((typeOf _body) in OPEX_friendly_units) && (isPlayer (leader _body))) then
								{
									private ["_value"];
									_value = 25;
									globalStats = globalStats - _value; publicVariable "globalStats";
									[OPEX_friendly_side1, "Base", "STR_globalStats_updateAbandonedBody", _value, globalStats] remoteExec ["Gemini_fnc_globalChat"];
									deleteVehicle _body;
								}
						} forEach _allUnits
					};

			};
	};