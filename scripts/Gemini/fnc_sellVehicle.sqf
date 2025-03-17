// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private ["_caller", "_vehicle"];
	_caller = _this select 1;
	_vehicle = vehicle _caller;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORIZED
// =========================================================================================================

	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can do this !

// =========================================================================================================
// SELLING VEHICLE
// =========================================================================================================

	if (_caller != vehicle _caller) then
		{
			// GETTING VEHICLE VALUE
			private _vehicleType = typeOf _vehicle;
			private _vehicleValue = 0;
			if (_vehicleType in OPEX_friendly_quads) then {_vehicleValue = OPEX_cost_fastTransport};
			if (_vehicleType in OPEX_friendly_transportCars) then {_vehicleValue = OPEX_cost_transportCar};
			if (_vehicleType in (OPEX_friendly_combatCarsMG + OPEX_friendly_combatCarsGL)) then {_vehicleValue = OPEX_cost_armedCar};
			if (_vehicleType in (OPEX_friendly_transportTrucksOpened + OPEX_friendly_transportTrucksCovered)) then {_vehicleValue = OPEX_cost_transportTruck};
			if (_vehicleType in OPEX_friendly_vtt) then {_vehicleValue = OPEX_cost_lightArmored};
			if (_vehicleType in OPEX_friendly_tanks) then {_vehicleValue = OPEX_cost_heavyArmored};
			if (_vehicleType in (OPEX_friendly_smallTransportHelicopters + OPEX_friendly_mediumTransportHelicopters + OPEX_friendly_bigTransportHelicopters)) then {_vehicleValue = OPEX_cost_transportChopper};
			if (_vehicleType in (OPEX_friendly_smallCombatHelicopters + OPEX_friendly_mediumCombatHelicopters)) then {_vehicleValue = OPEX_cost_armedChopper};
			if (_vehicleType in (OPEX_friendly_MGstatics + OPEX_friendly_ATstatics)) then {_vehicleValue = OPEX_cost_static};
			if (_vehicleType in OPEX_friendly_mortarStatics) then {_vehicleValue = OPEX_cost_mortar};
			if (_vehicleType in OPEX_friendly_portableDronesBackpack) then {_vehicleValue = OPEX_cost_drone};
			if (_vehicleType in OPEX_friendly_UAVs) then {_vehicleValue = OPEX_cost_UAV};
			if (_vehicleType in OPEX_friendly_zodiacs) then {_vehicleValue = OPEX_cost_boat};
			if (_vehicleType in (OPEX_friendly_medicalTrucks + OPEX_friendly_fuelTrucks + OPEX_friendly_repairTrucks + OPEX_friendly_ammoTrucks)) then {_vehicleValue = OPEX_cost_supplyTruck};
			if (_vehicleType in OPEX_friendly_logisticTrucks) then {_vehicleValue = OPEX_cost_mobileHQ};

			// APPLYING PENALTY IF VEHICLE IS DAMAGED
			_currentVehicleValue = round (_vehicleValue * (1 - (damage _vehicle)));

			private _intelLevel = OPEX_stats_faction select 14;

			if (OPEX_debug) then {hint format ["%1\n%2\n%3", _vehicleType, _intelLevel, _currentVehicleValue]};

			OPEX_stats_faction set [14, _intelLevel + _currentVehicleValue]; publicVariable "OPEX_stats_faction";
			//[OPEX_friendly_side1, "Base", "STR_globalStats_updateSell", name _caller, _currentVehicleValue, _intelLevel] remoteExec ["Gemini_fnc_globalChat"];

			{_x leaveVehicle _vehicle} forEach (crew _vehicle);
			deleteVehicle _vehicle;
		};