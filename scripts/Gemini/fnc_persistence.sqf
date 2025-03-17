// =========================================================================================================
// DEFINING MAIN FUNCTIONS
// =========================================================================================================

	Gemini_fnc_persistence_save =
		{
			waitUntil {!isNil "OPEX_params_ready"};
			if (_this == "server") then
				{
					if (!isServer) exitWith {};
					call Gemini_fnc_persistence_getCommonData;
					call Gemini_fnc_persistence_getVehiclesData;
					call Gemini_fnc_persistence_getCratesData;
					profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_server", OPEX_persistentData_server];
					profileNamespace setVariable ["OPEX_persistentStats_server", OPEX_stats_faction];
					saveProfileNamespace;
				};
			if (_this == "client") then
				{
					if (!hasInterface) exitWith {};
					call Gemini_fnc_persistence_getPlayerData;
					profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_player", OPEX_persistentData_player];
					profileNamespace setVariable ["OPEX_persistentStats_player", OPEX_stats_player];
					saveProfileNamespace;
				};
			enableSaving [false, false];
			//hint localize "STR_hint_dataSaved";
			if (_this == "server") then {["hint","STR_hint_dataSaved"] remoteExec ["Gemini_fnc_globalHint"]} else {hint localize "STR_hint_dataSaved"};
		};

	Gemini_fnc_persistence_reset =
		{
			if (_this == "all") then
				{
					profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_server", nil];
					profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_player", nil];
					profileNamespace setVariable ["OPEX_persistentStats_server", nil];
					profileNamespace setVariable ["OPEX_persistentStats_player", nil];
				};
			if (_this == "server") then {profileNamespace setVariable [("OPEX_" + worldName + "_persistentData_server"), nil]; profileNamespace setVariable ["OPEX_persistentStats_server", nil]; ["hint","STR_hint_missionReset"] remoteExec ["Gemini_fnc_globalHint"]};
			if (_this == "client") then {profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_player", nil]; profileNamespace setVariable ["OPEX_persistentStats_player", nil]; hint localize "STR_hint_playerReset"};
			saveProfileNamespace;
			if ((_this == "all") || (_this == "server")) then {if (isMultiplayer) then {"missionResetted" call BIS_fnc_endMissionServer} else {["missionResetted", true, true] call BIS_fnc_endMission}};
			//else {if (isMultiplayer) then {"missionUpdated" call BIS_fnc_endMissionServer} else {["missionUpdated", true, true] call BIS_fnc_endMission}};
		};

	Gemini_fnc_persistence_exists =
		{
			private _data = [];
			if (_this == "server") then
				{
					_data = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_server", []];
				};
			if (_this == "client") then
				{
					_data = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_player", []];
				};
			if (count _data == 0) then {false} else {true};
		};

	Gemini_fnc_persistence_new =
		{
			if (_this == "server") then
				{
					OPEX_persistentData_server = profileNameSpace getVariable  ["OPEX_" + worldName + "_persistentData_server", []];
					publicVariable "OPEX_persistentData_server";
					sleep 1;
					call Gemini_fnc_persistence_getCommonData;
					call Gemini_fnc_persistence_getVehiclesData;
					call Gemini_fnc_persistence_getCratesData;
					// "server" call Gemini_fnc_persistence_save;
				};
			if (_this == "client") then
				{
					OPEX_persistentData_player = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_player", []];
					sleep 1;
					call Gemini_fnc_persistence_getPlayerData;
					// "client" call Gemini_fnc_persistence_save;
				};
		};

	Gemini_fnc_persistence_resume =
		{
			if (_this == "server") then
				{
					OPEX_params_ready = true; publicVariable "OPEX_params_ready";
					call Gemini_fnc_persistence_loadCommonData;
					call Gemini_fnc_persistence_loadVehiclesData;
					call Gemini_fnc_persistence_loadCratesData;
				};
			if (_this == "client") then {call Gemini_fnc_persistence_loadPlayerData};
		};

// =========================================================================================================
// GETTING DATA
// =========================================================================================================

	Gemini_fnc_persistence_getCommonData =
		{
			waitUntil {(!isNil "OPEX_param_intel")};
			waitUntil {(!isNil "OPEX_support_transport")};
			private _settings = [OPEX_param_friendlyFaction, OPEX_param_enemyFaction, OPEX_param_taskManagement, OPEX_param_gearManagement, OPEX_param_supportManagement, OPEX_param_medical, OPEX_param_primaryNeeds, OPEX_param_fastTravel, OPEX_param_intel, date, timeMultiplier, OPEX_param_restManagement];
			private _progression = []; for "_i" from 1 to (count OPEX_tasks - 1) do {_progression append [[OPEX_tasks select _i select 0, missionNamespace getVariable (OPEX_tasks select _i select 0)]]};
			private _supports = [OPEX_support_suppliesDrop, OPEX_support_vehicleDrop, OPEX_support_airStrike, OPEX_support_artilleryStrike, OPEX_support_airAssistance, OPEX_support_landAssistance, OPEX_support_transport];
			private _data = [_settings, _progression, _supports];
			OPEX_persistentData_server set [0, _data]; publicVariable "OPEX_persistentData_server";
		};

	Gemini_fnc_persistence_getVehiclesData =
		{
			private _data = [];
			private _allVehicles = vehicles select {(_x isKindOf "Car") || (_x isKindOf "Tank") || (_x isKindOf "Air") || (_x isKindOf "UAV") || (_x isKindOf "Ship")};
			private _neededVehicles = [];
			if (count _allVehicles == 0) exitWith {OPEX_persistentData_server set [1, []]};
			{for "_i" from 0 to (count OPEX_locations_safe - 1) do {if (_x inArea (OPEX_locations_safe select _i)) then {_neededVehicles append [_x]}}} forEach _allVehicles;
			if (count _neededVehicles == 0) exitWith {OPEX_persistentData_server set [1, []]};
			{
				private _ID = vehicleVarName _x;
				private _type = typeOf _x;
				private _position = getPosATL _x;
				private _direction = getDir _x;
				private _damage = damage _x;

				private _damages = [];
_hitPointsData = getAllHitPointsDamage _x;
if (count _hitPointsData > 2) then {
    _damages = _hitPointsData select 2;
} else {
    _damages = [];
}; // {_x setHitIndex [_forEachIndex, _x]} forEach _damage;

				private _fuel = fuel _x;
				private ["_ammo"];
				if (finite getAmmoCargo _x) then {_ammo = getAmmoCargo _x} else {_ammo = -1};
				private _content = [(getWeaponCargo _x), (getMagazineCargo _x), (getItemCargo _x), (getBackpackCargo _x)];
				private _lock = locked _x;
				private _simulation = simulationEnabled _x;
				private _settings = [_ID, _type, _position, _direction, _damage, _damages, _fuel, _ammo, _content, _lock, _simulation];
				_data append [_settings];
			} forEach _neededVehicles;
			OPEX_persistentData_server set [1, _data]; publicVariable "OPEX_persistentData_server";
		};

	Gemini_fnc_persistence_getCratesData =
		{
			private _data = [];
			private _allCrates = vehicles select {(_x isKindOf "ReammoBox_F") && (typeOf _x != "Box_NATO_AmmoVeh_F")};
			private _neededCrates = [];
			if (count _allCrates == 0) exitWith {OPEX_persistentData_server set [2, []]};
			{for "_i" from 0 to (count OPEX_locations_safe - 1) do {if (_x inArea (OPEX_locations_safe select _i)) then {_neededCrates append [_x]}}} forEach _allCrates;
			if (count _neededCrates == 0) exitWith {OPEX_persistentData_server set [2, []]};
			{
				private _ID = vehicleVarName _x;
				private _type = typeOf _x;
				private _position = getPosATL _x;
				private _direction = getDir _x;
				private _damage = damage _x;
				private _content = [(getWeaponCargo _x), (getMagazineCargo _x), (getItemCargo _x), (getBackpackCargo _x)];
				private _simulation = simulationEnabled _x;
				private _settings = [_ID, _type, _position, _direction, _damage, _content, _simulation];
				_data append [_settings];
			} forEach _neededCrates;
			OPEX_persistentData_server set [2, _data]; publicVariable "OPEX_persistentData_server";
		};

	Gemini_fnc_persistence_getPlayerData =
		{
			private _ID = vehicleVarName player;
			private _position = getPosATL player;
			private _direction = getDir player;
			private _damages = [];
private _hitPointsData = getAllHitPointsDamage player;
if (!isNil "_hitPointsData" && {_hitPointsData isEqualType [] && {count _hitPointsData > 2}}) then {
    _damages = _hitPointsData select 2;
};
			private _speciality = "";
			if (player getUnitTrait "medic") then {_speciality = "medic"};
			if (player getUnitTrait "engineer") then {_speciality = "engineer"};
			if (player getUnitTrait "explosiveSpecialist") then {_speciality = "explosiveSpecialist"};
			if (player getUnitTrait "UAVHacker") then {_speciality = "UAVHacker"};
			if (player getUnitTrait "interpret") then {_speciality = "interpret"};
			private ["_needs"];
			waitUntil {!isNil "OPEX_param_primaryNeeds"};
			if (OPEX_param_primaryNeeds == 1) then
				{
					private _hunger = player getVariable ["hunger", 0];
					private _thirst = player getVariable ["thirst", 0];
					private _tiredness = player getVariable ["tiredness", 0];
					_needs = [_hunger, _thirst, _tiredness];
				} else {_needs = [0, 0, 0]};
			private _loadout = getUnitLoadout player;
			private _settings = [_ID, _position, _direction, _damage, _damages, _speciality, _needs, _loadout];
			OPEX_persistentData_player = _settings;
		};

// =========================================================================================================
// LOADING DATA
// =========================================================================================================

	Gemini_fnc_persistence_loadCommonData =
		{
			// GETTING PERSISTENT DATA
			OPEX_stats_faction = profileNameSpace getVariable ["OPEX_persistentStats_server", []]; publicVariable "OPEX_stats_faction";
			OPEX_persistentData_server = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_server", []]; publicVariable "OPEX_persistentData_server";

			// LOADING SETTINGS
			private _settings = OPEX_persistentData_server select 0 select 0;
			OPEX_param_friendlyFaction = _settings select 0; publicVariable "OPEX_param_friendlyFaction";
			OPEX_param_enemyFaction = _settings select 1; publicVariable "OPEX_param_enemyFaction";
			OPEX_param_taskManagement = _settings select 2; publicVariable "OPEX_param_taskManagement";
			OPEX_param_gearManagement = _settings select 3; publicVariable "OPEX_param_gearManagement";
			OPEX_param_supportManagement = _settings select 4; publicVariable "OPEX_param_supportManagement";
			OPEX_param_medical = _settings select 5; publicVariable "OPEX_param_medical";
			OPEX_param_primaryNeeds = _settings select 6; publicVariable "OPEX_param_primaryNeeds";
			OPEX_param_fastTravel = _settings select 7; publicVariable "OPEX_param_fastTravel";
			OPEX_param_intel = _settings select 8; publicVariable "OPEX_param_intel";
			[(_settings select 9)] remoteExec ["setDate"];
			setTimeMultiplier (_settings select 10);
			OPEX_param_restManagement = _settings select 11; publicVariable "OPEX_param_restManagement";

			// LOADING PROGRESSION
			for "_i" from 0 to (count (OPEX_persistentData_server select 0 select 1) - 1) do {missionNamespace setVariable [OPEX_persistentData_server select 0 select 1 select _i select 0, OPEX_persistentData_server select 0 select 1 select _i select 1]};
			OPEX_succeededTasks = (profileNameSpace getVariable "OPEX_persistentStats_server") select 8; publicVariable "OPEX_succeededTasks";
			OPEX_failedTasks = (profileNameSpace getVariable "OPEX_persistentStats_server") select 9; publicVariable "OPEX_failedTasks";
			OPEX_canceledTasks = (profileNameSpace getVariable "OPEX_persistentStats_server") select 10; publicVariable "OPEX_canceledTasks";

			// LOADING SUPPORTS
			OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";
			private _supports = OPEX_persistentData_server select 0 select 2;
			OPEX_support_suppliesDrop = _supports select 0; publicVariable "OPEX_support_suppliesDrop";
			OPEX_support_vehicleDrop = _supports select 1; publicVariable "OPEX_support_vehicleDrop";
			OPEX_support_airStrike = _supports select 2; publicVariable "OPEX_support_airStrike";
			OPEX_support_artilleryStrike = _supports select 3; publicVariable "OPEX_support_artilleryStrike";
			OPEX_support_airAssistance = _supports select 4; publicVariable "OPEX_support_airAssistance";
			OPEX_support_landAssistance = _supports select 5; publicVariable "OPEX_support_landAssistance";
			OPEX_support_transport = _supports select 6; publicVariable "OPEX_support_transport";
		};

	Gemini_fnc_persistence_loadVehiclesData =
		{
			private _oldVehicles = vehicles select {(_x isKindOf "Car") || (_x isKindOf "Tank") || (_x isKindOf "Air") || (_x isKindOf "UAV") || (_x isKindOf "Ship")};
			if (count _oldVehicles > 0) then {{deleteVehicle _x} forEach _oldVehicles};
			private _vehicles = OPEX_persistentData_server select 1;
			if (count _vehicles == 0) exitWith {};
			_vehicles spawn
				{
					private _vehicles = _this;
                    sleep 1;
					for "_i" from 0 to ((count _vehicles) - 1) do
						{
							private _vehicle = [_vehicles select _i select 1, _vehicles select _i select 2, 0, true] call Gemini_fnc_createVehicle;
							//_vehicle setVehicleVarName (_vehicles select _i select 0);
							_vehicle setDir (_vehicles select _i select 3);
							_vehicle setPosATL (_vehicles select _i select 2);
							[_vehicles, _vehicle, _i] spawn
								{
									sleep 0.1;
									private ["_vehicles", "_vehicle", "_i"];
									_vehicles = _this select 0;
									_vehicle = _this select 1;
									_i = _this select 2;
									_vehicle setDamage (_vehicles select _i select 4);
									{_vehicle setHitIndex [_forEachIndex, _x]} forEach (_vehicles select _i select 5);
									_vehicle setFuel (_vehicles select _i select 6);
									if (_vehicles select _i select 7 != -1) then {_vehicle setAmmoCargo (_vehicles select _i select 7)};
									for "_j" from 0 to ((count (OPEX_persistentData_server select 1 select _i select 8 select 0 select 0)) - 1) do {_vehicle addWeaponCargoGlobal [OPEX_persistentData_server select 1 select _i select 8 select 0 select 0 select _j, OPEX_persistentData_server select 1 select _i select 8 select 0 select 1 select _j]};
									for "_j" from 0 to ((count (OPEX_persistentData_server select 1 select _i select 8 select 1 select 0)) - 1) do {_vehicle addMagazineCargoGlobal [OPEX_persistentData_server select 1 select _i select 8 select 1 select 0 select _j, OPEX_persistentData_server select 1 select _i select 8 select 1 select 1 select _j]};
									for "_j" from 0 to ((count (OPEX_persistentData_server select 1 select _i select 8 select 2 select 0)) - 1) do {_vehicle addItemCargoGlobal [OPEX_persistentData_server select 1 select _i select 8 select 2 select 0 select _j, OPEX_persistentData_server select 1 select _i select 8 select 2 select 1 select _j]};
									for "_j" from 0 to ((count (OPEX_persistentData_server select 1 select _i select 8 select 3 select 0)) - 1) do {_vehicle addBackpackCargoGlobal [OPEX_persistentData_server select 1 select _i select 8 select 3 select 0 select _j, OPEX_persistentData_server select 1 select _i select 8 select 3 select 1 select _j]};
									_vehicle lock (_vehicles select _i select 9);
									_vehicle enableSimulationGlobal (_vehicles select _i select 10);
								};
						};
				};
		};

	Gemini_fnc_persistence_loadCratesData =
		{
			private _oldCrates = vehicles select {(_x isKindOf "ReammoBox_F") && (typeOf _x != "Box_NATO_AmmoVeh_F")};
			if (count _oldCrates > 0) then {{deleteVehicle _x} forEach _oldCrates};
			private _crates = OPEX_persistentData_server select 2;
			if (count _crates == 0) exitWith {};
			_crates spawn
				{
					private _crates = _this;
                    sleep 1;
					for "_i" from 0 to (count _crates - 1) do
						{
							//private _crate = [_crates select _i select 1, , 0, false] call Gemini_fnc_createVehicle;
							//_crate setVehicleVarName (_crates select _i select 0);
							private _crate = createVehicle [_crates select _i select 1, [10, 10, 500 + (random 5000)], [], 0, "CAN_COLLIDE"];
							[_crate, "hq"] call Gemini_fnc_setLifeTime;
							clearWeaponCargoGlobal _crate;
							clearMagazineCargoGlobal _crate;
							clearItemCargoGlobal _crate;
							clearBackpackCargoGlobal _crate;
							for "_j" from 0 to ((count (OPEX_persistentData_server select 2 select _i select 5 select 0 select 0)) - 1) do {_crate addWeaponCargoGlobal [OPEX_persistentData_server select 2 select _i select 5 select 0 select 0 select _j, OPEX_persistentData_server select 2 select _i select 5 select 0 select 1 select _j]};
							for "_j" from 0 to ((count (OPEX_persistentData_server select 2 select _i select 5 select 1 select 0)) - 1) do {_crate addMagazineCargoGlobal [OPEX_persistentData_server select 2 select _i select 5 select 1 select 0 select _j, OPEX_persistentData_server select 2 select _i select 5 select 1 select 1 select _j]};
							for "_j" from 0 to ((count (OPEX_persistentData_server select 2 select _i select 5 select 2 select 0)) - 1) do {_crate addItemCargoGlobal [OPEX_persistentData_server select 2 select _i select 5 select 2 select 0 select _j, OPEX_persistentData_server select 2 select _i select 5 select 2 select 1 select _j]};
							for "_j" from 0 to ((count (OPEX_persistentData_server select 2 select _i select 5 select 3 select 0)) - 1) do {_crate addBackpackCargoGlobal [OPEX_persistentData_server select 2 select _i select 5 select 3 select 0 select _j, OPEX_persistentData_server select 2 select _i select 5 select 3 select 1 select _j]};
							_crate enableSimulationGlobal false;
							[_crate, _crates, _i] spawn
								{
									sleep 1;
									(_this select 0) setDir ((_this select 1) select (_this select 2) select 3);
									(_this select 0) setPos [((_this select 1) select (_this select 2) select 2) select 0, ((_this select 1) select (_this select 2) select 2) select 1, (((_this select 1) select (_this select 2) select 2) select 2) + 0.1];
									(_this select 0) enableSimulationGlobal true;
									(_this select 0) setVariable ["R3F_LOG_disabled", false, true];
									(_this select 0) setDamage ((_this select 1) select (_this select 2) select 4);
								};
						};
				};
		};

	Gemini_fnc_persistence_loadPlayerData =
		{
			OPEX_stats_player = profileNameSpace getVariable ["OPEX_persistentStats_player", []];
			OPEX_persistentData_player = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_player", []];
			player setVehicleVarName (OPEX_persistentData_player select 0);
			player setPos (OPEX_persistentData_player select 1);
			player setDir (OPEX_persistentData_player select 2);
			player setDamage (OPEX_persistentData_player select 3);
			{player setHitIndex [_forEachIndex, _x]} forEach (OPEX_persistentData_player select 4);
			if (((OPEX_persistentData_player select 5) == "medic") || ((OPEX_persistentData_player select 5) == "engineer") || ((OPEX_persistentData_player select 5) == "UAVHacker") || ((OPEX_persistentData_player select 5) == "explosiveSpecialist")) then {player setUnitTrait [OPEX_persistentData_player select 5, true]};
			if ((OPEX_persistentData_player select 5) == "interpret") then {player setUnitTrait [OPEX_persistentData_player select 5, true, true]};
			waitUntil {!isNil "OPEX_param_primaryNeeds"};
			if (OPEX_param_primaryNeeds == 1) then
				{
					player setVariable ["hunger", (OPEX_persistentData_player select 6 select 0)];
					player setVariable ["thirst", (OPEX_persistentData_player select 6 select 1)];
					player setVariable ["tiredness", (OPEX_persistentData_player select 6 select 2)];
				};
			removeAllWeapons player;
			removeAllItems player;
			removeAllAssignedItems player;
			removeUniform player;
			removeVest player;
			removeBackpack player;
			removeHeadgear player;
			removeGoggles player;
			removeAllContainers player;
			player setUnitLoadout [(OPEX_persistentData_player select 7), false];
			[] spawn {sleep 5; waitUntil {!isNil "Gemini_fnc_guidedTour3D_setup"}; call Gemini_fnc_guidedTour3D_setup};
		};