// EXECUTING ON SERVER ONLY
if (!isServer) exitWith {};

// WAITING MISSION IS READY
waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_param_friendlyFaction"};
sleep 1;

// CHECKING IF IT'S NECESSARY TO REPLACE VANILLA VEHICLES
//if ((OPEX_param_friendlyFaction find "vanilla" > -1) || ("server" call Gemini_fnc_persistence_exists)) exitWith {};
if ("server" call Gemini_fnc_persistence_exists) exitWith {};

// CONVERTING
{
     private ["_oldVehicle", "_newVehicle", "_vehicleID", "_vehiclePos", "_vehicleDir", "_vehicleFuel", "_vehicleType"];
    _oldVehicle = _x;

    switch (OPEX_mapClimate) do
      {
        default
            {
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksOpened_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksOpened_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksCovered_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksCovered_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_fuelTrucks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_fuelTrucks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_logisticTrucks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_logisticTrucks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_medicalTrucks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_medicalTrucks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_repairTrucks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_repairTrucks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_ammoTrucks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_ammoTrucks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_transportCars_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_transportCars_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsMG_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsMG_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsGL_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsGL_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_vtt_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_vtt_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_tanks_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_tanks_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_quads_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_quads_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_smallCombatHelicopters_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_smallCombatHelicopters_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_mediumCombatHelicopters_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_mediumCombatHelicopters_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_smallTransportHelicopters_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_smallTransportHelicopters_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_mediumTransportHelicopters_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_mediumTransportHelicopters_woodland};
                if (typeOf _oldVehicle in OPEX_friendly_bigTransportHelicopters_woodland_default) then {_vehicleType = selectRandom OPEX_friendly_bigTransportHelicopters_woodland};
            };
        case "arid" :
            {
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksOpened_desert_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksOpened_desert};
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksCovered_desert_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksCovered_desert};
                if (typeOf _oldVehicle in OPEX_friendly_fuelTrucks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_fuelTrucks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_logisticTrucks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_logisticTrucks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_medicalTrucks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_medicalTrucks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_repairTrucks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_repairTrucks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_ammoTrucks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_ammoTrucks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_transportCars_desert_default) then {_vehicleType = selectRandom OPEX_friendly_transportCars_desert};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsMG_desert_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsMG_desert};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsGL_desert_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsGL_desert};
                if (typeOf _oldVehicle in OPEX_friendly_vtt_desert_default) then {_vehicleType = selectRandom OPEX_friendly_vtt_desert};
                if (typeOf _oldVehicle in OPEX_friendly_tanks_desert_default) then {_vehicleType = selectRandom OPEX_friendly_tanks_desert};
                if (typeOf _oldVehicle in OPEX_friendly_quads_desert_default) then {_vehicleType = selectRandom OPEX_friendly_quads_desert};
                if (typeOf _oldVehicle in OPEX_friendly_smallCombatHelicoptersCombat_desert_default) then {_vehicleType = selectRandom OPEX_friendly_smallCombatHelicopters_desert};
                if (typeOf _oldVehicle in OPEX_friendly_mediumCombatHelicoptersCombat_desert_default) then {_vehicleType = selectRandom OPEX_friendly_mediumCombatHelicopters_desert};
                if (typeOf _oldVehicle in OPEX_friendly_smallTransportHelicopters_desert_default) then {_vehicleType = selectRandom OPEX_friendly_smallTransportHelicopters_desert};
                if (typeOf _oldVehicle in OPEX_friendly_mediumTransportHelicopters_desert_default) then {_vehicleType = selectRandom OPEX_friendly_mediumTransportHelicopters_desert};
                if (typeOf _oldVehicle in OPEX_friendly_bigTransportHelicopters_desert_default) then {_vehicleType = selectRandom OPEX_friendly_bigTransportHelicopters_desert};
            };
        case "polar" :
            {
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksOpened_snow_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksOpened_snow};
                if (typeOf _oldVehicle in OPEX_friendly_transportTrucksCovered_snow_default) then {_vehicleType = selectRandom OPEX_friendly_transportTrucksCovered_snow};
                if (typeOf _oldVehicle in OPEX_friendly_fuelTrucks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_fuelTrucks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_logisticTrucks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_logisticTrucks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_medicalTrucks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_medicalTrucks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_repairTrucks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_repairTrucks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_ammoTrucks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_ammoTrucks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_transportCars_snow_default) then {_vehicleType = selectRandom OPEX_friendly_transportCars_snow};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsMG_snow_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsMG_snow};
                if (typeOf _oldVehicle in OPEX_friendly_combatCarsGL_snow_default) then {_vehicleType = selectRandom OPEX_friendly_combatCarsGL_snow};
                if (typeOf _oldVehicle in OPEX_friendly_vtt_snow_default) then {_vehicleType = selectRandom OPEX_friendly_vtt_snow};
                if (typeOf _oldVehicle in OPEX_friendly_tanks_snow_default) then {_vehicleType = selectRandom OPEX_friendly_tanks_snow};
                if (typeOf _oldVehicle in OPEX_friendly_quads_snow_default) then {_vehicleType = selectRandom OPEX_friendly_quads_snow};
                if (typeOf _oldVehicle in OPEX_friendly_smallCombatHelicoptersCombat_snow_default) then {_vehicleType = selectRandom OPEX_friendly_smallCombatHelicopters_snow};
                if (typeOf _oldVehicle in OPEX_friendly_mediumCombatHelicoptersCombat_snow_default) then {_vehicleType = selectRandom OPEX_friendly_mediumCombatHelicopters_snow};
                if (typeOf _oldVehicle in OPEX_friendly_smallTransportHelicopters_snow_default) then {_vehicleType = selectRandom OPEX_friendly_smallTransportHelicopters_snow};
                if (typeOf _oldVehicle in OPEX_friendly_mediumTransportHelicopters_snow_default) then {_vehicleType = selectRandom OPEX_friendly_mediumTransportHelicopters_snow};
                if (typeOf _oldVehicle in OPEX_friendly_bigTransportHelicopters_snow_default) then {_vehicleType = selectRandom OPEX_friendly_bigTransportHelicopters_snow};
            };
      };

    if (typeOf _oldVehicle in OPEX_civilian_cars) then {_vehicleType = selectRandom OPEX_civilian_cars};
    if (typeOf _oldVehicle in OPEX_civilian_trucks) then {_vehicleType = selectRandom OPEX_civilian_trucks};

    if (typeOf _oldVehicle in OPEX_friendly_zodiacs_default) then {_vehicleType = selectRandom OPEX_friendly_zodiacs};
    if (typeOf _oldVehicle in OPEX_friendly_ships_default) then {_vehicleType = selectRandom OPEX_friendly_ships};
    if (typeOf _oldVehicle in OPEX_friendly_aircrafts_default) then {_vehicleType = selectRandom OPEX_friendly_aircrafts};
    if (typeOf _oldVehicle in OPEX_friendly_UAVs_default) then {_vehicleType = selectRandom OPEX_friendly_UAVs};
    if (typeOf _oldVehicle in OPEX_friendly_UGVs_default) then {_vehicleType = selectRandom OPEX_friendly_UGVs};
    if (typeOf _oldVehicle in OPEX_friendly_portableDrones_default) then {_vehicleType = selectRandom OPEX_friendly_portableDrones};
    if (typeOf _oldVehicle in OPEX_friendly_portableDronesBackpack_default) then {_vehicleType = selectRandom OPEX_friendly_portableDronesBackpack};
    if (typeOf _oldVehicle in OPEX_friendly_MGstatics_default) then {_vehicleType = selectRandom OPEX_friendly_MGstatics};
    if (typeOf _oldVehicle in OPEX_friendly_GLstatics_default) then {_vehicleType = selectRandom OPEX_friendly_GLstatics};
    if (typeOf _oldVehicle in OPEX_friendly_ATstatics_default) then {_vehicleType = selectRandom OPEX_friendly_ATstatics};
    if (typeOf _oldVehicle in OPEX_friendly_AAstatics_default) then {_vehicleType = selectRandom OPEX_friendly_AAstatics};
    if (typeOf _oldVehicle in OPEX_friendly_mortarStatics_default) then {_vehicleType = selectRandom OPEX_friendly_mortarStatics};

    if (!isNil "_vehicleType") then
        {
            _vehiclePos = getPos _oldVehicle;
            _vehicleDir = getDir _oldVehicle;
            _vehicleFuel = fuel _oldVehicle;
            deleteVehicle _oldVehicle;
            [_oldVehicle, _vehicleType, _vehicleDir, _vehicleFuel, _vehiclePos] spawn
                {
                    waitUntil {isNull (_this select 0)};
                    sleep 3;
                    _newVehicle = [_this select 1, _this select 4, _this select 2, true] call Gemini_fnc_createVehicle;
                    waitUntil {!isNil "_newVehicle"};
                    sleep 5;
                    _newVehicle setFuel (_this select 3);
                };
        };

} forEach (vehicles select {(_x isKindOf "Car") || (_x isKindOf "Tank") || (_x isKindOf "Air") || (_x isKindOf "UAV") || (_x isKindOf "Ship")});

// ENABLING HELIPAD LIGHTS AFTER CONVERSION (TO AVOID POSSIBLE COLLISIONS AND EXPLOSIONS)
sleep 30;
{_x enableSimulationGlobal true; _x enableDynamicSimulation true} forEach ((allMissionObjects "all") select {"PortableHelipadLight" in (typeOf _x)});