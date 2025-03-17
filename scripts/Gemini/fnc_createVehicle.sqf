// example: _vehicle = ["Land_LampShabby_F", player, 90, true, "distance", false] call Gemini_fnc_createVehicle;

// EXECUTING ON SERVER ONLY
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};

// ENSURE ALL REQUIRED VARIABLES ARE DEFINED
if (isNil "OPEX_enemy_transportTrucks") then { OPEX_enemy_transportTrucks = []; };
if (isNil "OPEX_enemy_fuelTrucks") then { OPEX_enemy_fuelTrucks = []; };
if (isNil "OPEX_enemy_transportCars") then { OPEX_enemy_transportCars = []; };
if (isNil "OPEX_enemy_combatCars") then { OPEX_enemy_combatCars = []; };
if (isNil "OPEX_enemy_zodiacs") then { OPEX_enemy_zodiacs = []; };
if (isNil "OPEX_enemy_ships") then { OPEX_enemy_ships = []; };
if (isNil "OPEX_enemy_boats") then { OPEX_enemy_boats = []; };
if (isNil "OPEX_enemy_armored") then { OPEX_enemy_armored = []; };
if (isNil "OPEX_civilian_vehicles") then { OPEX_civilian_vehicles = []; };
if (isNil "OPEX_civilian_boats") then { OPEX_civilian_boats = []; };
if (isNil "OPEX_friendly_drones") then { OPEX_friendly_drones = []; };
if (isNil "OPEX_friendly_parachutes") then { OPEX_friendly_parachutes = ["B_Parachute"]; };
if (isNil "OPEX_debug") then { OPEX_debug = false; };

// GETTING ARGUMENTS
private ["_vehicleType"];
private _vehicleTypes = param [0, "B_QuadBike_01_F", ["", []]]; if (typeName _vehicleTypes == "ARRAY") then {_vehicleType = selectRandom _vehicleTypes} else {_vehicleType = _vehicleTypes};
private _position = param [1, [0,0,0], [[], objNull]]; if (typeName _position == "OBJECT") then {_position = position _position};
private _direction = param [2, random 360, [0]];
private _destroyable = param [3, true, [true]];
private _lifeTime = param [4, "distance", [""]];
private _canBeCarried = param [5, false, [false]];

// CREATING VEHICLE
private _tempPosition = [(_position select 0) + random 500 - random 500, (_position select 1) + random 500 - random 500, 500 + (random 500)];
private _vehicle = createVehicle [_vehicleType, _tempPosition, [], 0, "CAN_COLLIDE"];

// SETTING VEHICLE NAME (REQUIRED FOR SEVERAL SCRIPTS)
if ((_vehicle isKindOf "car") || (_vehicle isKindOf "tank") || (_vehicle isKindOf "air") || (_vehicle isKindOf "ship")) then
	{
		private _emptyVehicleID = "OPEX_vehicle_" + (str (round (random 99999))); // example: "OPEX_vehicle_12345"
		[_vehicle, _emptyVehicleID] remoteExecCall ["Gemini_fnc_setVehicleVarName", 0, _vehicle];
	};

// SETTING VEHICLE
_vehicle setDir _direction;
_vehicle setFuel (0.5 + (random 0.5));
_vehicle enableSimulationGlobal false;
_vehicle allowDamage false;
[_vehicle, _position, _destroyable] spawn
	{
		private _vehicle = _this select 0;
		private _position = _this select 1;
		private _destroyable = _this select 2;
		sleep 1;
		_vehicle setPosATL [_position select 0, _position select 1, 0];
		_vehicle setVectorUp (surfaceNormal (position _vehicle));
		_vehicle setPosATL [(getPos _vehicle) select 0, (getPos _vehicle) select 1, 0.25];
		_vehicle setDamage 0;
		sleep 1;
		if ((_destroyable) && (getPosATL _vehicle select 2 >= 0.5)) then {_vehicle setPosATL [_position select 0, _position select 1, 0.25]};
		if ((!_destroyable) && (getPosATL _vehicle select 2 >= 0.5)) then {_vehicle setPosATL [_position select 0, _position select 1, 0.25]};
		if (_destroyable) then {_vehicle enableSimulationGlobal true};
		_vehicle setDamage 0;
		sleep 1;
		if (_destroyable) then {_vehicle allowDamage true; _vehicle setDamage 0};
		if (!(typeOf _vehicle in OPEX_friendly_drones)) then {_vehicle enableDynamicSimulation true};
		_vehicle setDamage 0;

		// SETTING ITEMS ON THE GROUND
		if ((!(_vehicle isKindOf "car")) && (!(_vehicle isKindOf "tank")) && (!(_vehicle isKindOf "air")) && (!(_vehicle isKindOf "ship"))) then
			{
				_vehicle setPosATL [(getPos _vehicle) select 0, (getPos _vehicle) select 1, 0];
			};
	};

// SETTING CARGO
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
if (_vehicle isKindOf "air") then {
    // Vérifier que OPEX_friendly_parachutes contient au moins un élément
    if (count OPEX_friendly_parachutes > 0) then {
        _vehicle addBackpackCargoGlobal [selectRandom OPEX_friendly_parachutes, (_vehicle emptyPositions "cargo") + (_vehicle emptyPositions "driver") + (_vehicle emptyPositions "gunner") + (_vehicle emptyPositions "commander")];
    } else {
        _vehicle addBackpackCargoGlobal ["B_Parachute", (_vehicle emptyPositions "cargo") + (_vehicle emptyPositions "driver") + (_vehicle emptyPositions "gunner") + (_vehicle emptyPositions "commander")];
    };
};

// LOADING INTEL (RANDOMLY, IN ENEMY VEHICLES)
// Construction sécurisée du tableau des véhicules ennemis
private _enemyVehicles = [];
{
    if (!isNil _x) then {
        _enemyVehicles append (missionNamespace getVariable _x);
    };
} forEach ["OPEX_enemy_transportTrucks", "OPEX_enemy_fuelTrucks", "OPEX_enemy_transportCars", "OPEX_enemy_combatCars", "OPEX_enemy_boats", "OPEX_enemy_armored"];

// Construction sécurisée du tableau des véhicules civils
private _civilianVehicles = [];
{
    if (!isNil _x) then {
        _civilianVehicles append (missionNamespace getVariable _x);
    };
} forEach ["OPEX_civilian_vehicles", "OPEX_civilian_boats"];

// Vérification sécurisée si le véhicule est un véhicule ennemi ou civil
private _isEnemyVehicle = (typeOf _vehicle) in _enemyVehicles;
private _isCivilianVehicle = (typeOf _vehicle) in _civilianVehicles;

if (_isEnemyVehicle || _isCivilianVehicle) then {
    [_vehicle, ["STR_action_searchVehicle", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "(_target distance2D _this < 6) && (alive _target)", "(_target distance2D _this < 6) && (alive _target)", {}, {}, {_this call Gemini_fnc_searchVehicle}, {}, [], 10, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _vehicle];
    
    private _intelProbability = 0;
    if (_isEnemyVehicle) then {_intelProbability = 15} else {_intelProbability = 3};
    if (round (random 100) <= _intelProbability) then {_vehicle setVariable ["intel", round (random 25), true]} else {_vehicle setVariable ["intel", 0, true]};
};

// INITIALIZING MUSIC RECEIVER
if ((_vehicle isKindOf "landVehicle") || (_vehicle isKindOf "air") || (_vehicle isKindOf "ship") || (_vehicle isKindOf "tank")) then {
    if (!isNil "Gemini_fnc_vehicleMusicReceiver_initVehicle") then {
        0 = [_vehicle] spawn Gemini_fnc_vehicleMusicReceiver_initVehicle;
    } else {
        // Si la fonction n'existe pas, on évite d'attendre indéfiniment
        systemChat "Warning: Gemini_fnc_vehicleMusicReceiver_initVehicle function not found";
    };
};

// SETTING IF VEHICLE CAN BE CARRIED OR NOT (FOR SMALL OBJECTS)
_vehicle setVariable ["R3F_LOG_disabled", _canBeCarried, true];

// DEBUGGING
if ((OPEX_debug) && (!isNil "_vehicle")) then {
    private _marker = createMarker [format ["OPEX_marker_%1", random 100000], position _vehicle];
    _marker setMarkerType "mil_dot";
    if ((_vehicle isKindOf "air") || (_vehicle isKindOf "tank") || (_vehicle isKindOf "car") || (_vehicle isKindOf "ship")) then {_marker setMarkerColor "ColorBlack"} else {_marker setMarkerColor "ColorGrey"};
    [_marker, _vehicle] spawn {
        private ["_marker", "_vehicle"];
        _marker = _this select 0;
        _vehicle = _this select 1;
        while {(alive _vehicle) && (!isNil "_vehicle")} do {
            sleep 1;
            _marker setMarkerPos (getPos _vehicle);
        };
        deleteMarker _marker;
    };
};

// DELETING VEHICLE WHEN USELESS
if (!isNil "Gemini_fnc_setLifeTime") then {
    [_vehicle, _lifeTime] call Gemini_fnc_setLifeTime;
} else {
    systemChat "Warning: Gemini_fnc_setLifeTime function not found";
};

// RETURNING CREATED VEHICLE
_vehicle