// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================

// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private
		[
			"_caller",
			"_selectedVehicle",
			"_emptyPos",
			"_randomVehicle",
			"_newVehicle"
		];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	_caller = _this select 0;
	_selectedVehicle = _this select 1;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	_emptyPos = [];
	_emptyPos = (position OPEX_deliveryZone) isFlatEmpty [1, 1, 0.75, 10, 0, false];
	if (count _emptyPos == 0) exitWith {hint localize "STR_hint_DeliveryZoneEncumbered"};

// =========================================================================================================
// VehicleING
// =========================================================================================================

	// GETTING CURRRENT INTEL LEVEL
	private ["_intel"];
	_intel = OPEX_stats_faction select 14;

	private ["_cost"];

	// QUICK TRANSPORT
		if (_selectedVehicle == 0) then
			{
				_cost = (abs OPEX_cost_fastTransport);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_quads, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// TRANSPORT CAR
		if (_selectedVehicle == 1) then
			{
				_cost = (abs OPEX_cost_transportCar);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_transportCars, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// ARMED CAR
		if (_selectedVehicle == 2) then
			{
				_cost = (abs OPEX_cost_armedCar);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_combatCarsMG + OPEX_friendly_combatCarsMG + OPEX_friendly_combatCarsGL, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// TRANSPORT TRUCK
		if (_selectedVehicle == 3) then
			{
				_cost = (abs OPEX_cost_transportTruck);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_transportTrucksOpened + OPEX_friendly_transportTrucksCovered, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// LIGHT ARMORED
		if (_selectedVehicle == 4) then
			{
				_cost = (abs OPEX_cost_lightArmored);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_vtt, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel- _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// HEAVY ARMORED
		if (_selectedVehicle == 5) then
			{
				_cost = (abs OPEX_cost_heavyArmored);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_tanks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// TRANSPORT CHOPPER
		if (_selectedVehicle == 6) then
			{
				_cost = (abs OPEX_cost_transportChopper);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_smallTransportHelicopters + OPEX_friendly_mediumTransportHelicopters + OPEX_friendly_bigTransportHelicopters, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// ARMED CHOPPER
		if (_selectedVehicle == 7) then
			{
				_cost = (abs OPEX_cost_armedChopper);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_smallCombatHelicopters + OPEX_friendly_mediumCombatHelicopters, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// STATIC
		if (_selectedVehicle == 8) then
			{
				_cost = (abs OPEX_cost_static);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_MGstatics + OPEX_friendly_ATstatics, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// MORTAR
		if (_selectedVehicle == 9) then
			{
				_cost = (abs OPEX_cost_static);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_mortarStatics, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// MOBILE DRONE
		if (_selectedVehicle == 10) then
			{
				_cost = (abs OPEX_cost_drone);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_portableDronesBackpack, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// UAV
		if (_selectedVehicle == 11) then
			{
				_cost = (abs OPEX_cost_UAV);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_UAVs, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// BOAT
		if (_selectedVehicle == 12) then
			{
				_cost = (abs OPEX_cost_boat);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_zodiacs, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// MEDICAL TRUCK
		if (_selectedVehicle == 13) then
			{
				_cost = (abs OPEX_cost_supplyTruck);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_medicalTrucks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// REFUEL TRUCK
		if (_selectedVehicle == 14) then
			{
				_cost = (abs OPEX_cost_supplyTruck);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_fuelTrucks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// REPAIR TRUCK
		if (_selectedVehicle == 15) then
			{
				_cost = (abs OPEX_cost_supplyTruck);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_repairTrucks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// REARM TRUCK
		if (_selectedVehicle == 16) then
			{
				_cost = (abs OPEX_cost_supplyTruck);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_ammoTrucks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	// MOBILE HQ
		if (_selectedVehicle == 17) then
			{
				_cost = (abs OPEX_cost_mobileHQ);
				if (_intel >= _cost)
				then
					{
						// SPAWNING VEHICLE
							_newVehicle = [OPEX_friendly_logisticTrucks, _emptyPos, 0, true] call Gemini_fnc_createVehicle;
							_newVehicle setFuel 1;
							0 = [_newVehicle, _intel, nil, OPEX_constructions] execVM "scripts\R3F\LOG\USER_FUNCT\init_creation_factory.sqf"; // FACTORY
							[OPEX_friendly_side1, _newVehicle] call BIS_fnc_addRespawnPosition; // ADDING A RESPAWN POINT TO THE MOBILE HQ
							[_newVehicle, 500] spawn Gemini_fnc_protectVehicleFromEnemies;
						// UPDATING STATS (CREDITS)
							OPEX_stats_faction set [14, _intel- _cost]; publicVariable "OPEX_stats_faction";
							//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
					}
				else {hint localize "STR_hint_globalStatsTooLow"};
			};

	//if (!isNil "_newVehicle") then {hint localize "STR_hint_deliveryDone"};