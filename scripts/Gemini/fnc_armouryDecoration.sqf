// =========================================================================================================
// WAITING FOR REQUIRED MISSION PARAMETERS
// =========================================================================================================

	waitUntil {!isNil "OPEX_param_gearManagement"};
	waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};

// =========================================================================================================
// INITIALIZING ARMOURY
// =========================================================================================================

	// WAITING ALL MODS HAVE BEEN LOADED
	sleep 5;

	// DISABLING R3F LOGISTIC
	_this setVariable ["R3F_LOG_disabled", true];

// =========================================================================================================
// CREATING ARMOURY
// =========================================================================================================

	// APPLYING CUSTOM TEXTURE - doesn't look nice at this time, maybe I will think about a better grid texture later
	/*
	_texturePos = _this modelToWorld [0, -0.09, 0];
	_texture = "UserTexture10m_F" createVehicle _texturePos;
	_texture setDir (getDir _this);
	_texture enableSimulation false;
	_texture setObjectTexture [0, "pictures\test.paa"];
	_texture setPosATL [_texturePos select 0, _texturePos select 1, 1.75];
	*/

	if (!isServer) exitWith {};
	if ((isNil "armoury_ammo") || (isNil "armoury_clothes") || (isNil "armoury_explosives") || (isNil "armoury_grenades") || (isNil "armoury_launchers") || (isNil "armoury_support") || (isNil "armoury_weapons")) exitWith {};

	// SPAWING ITEMS ON THE WALLS
	switch (_this) do
		{
			// WEAPONS
			case armoury_weapons :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions = [[-0.65, -0.75, 2.00], [0.65, -0.75, 2.00], [-0.65, -0.75, 1.50], [0.65, -0.75, 1.50], [-0.65, -0.75, 1.00], [0.65, -0.75, 1.00]];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = OPEX_friendly_commonRifles + OPEX_friendly_specialRifles;
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapons = _weapons call BIS_fnc_arrayShuffle;
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addWeaponCargoGlobal [_weapons select _index, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 90, 0] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// LAUNCHERS
			case armoury_launchers :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions = [[0, -0.8, 1.85], [0, -0.8, 1.15]];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = OPEX_friendly_ATlaunchers + OPEX_friendly_AAlaunchers;
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addWeaponCargoGlobal [_weapons select _index, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 90, 0] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// AMMO
			case armoury_ammo :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions =
								[
									[-0.80, -0.75, 2.00], [-0.40, -0.75, 2.00], [0.00, -0.75, 2.00], [0.40, -0.75, 2.00], [0.80, -0.75, 2.00],
									[-0.80, -0.75, 1.60], [-0.40, -0.75, 1.60], [0.00, -0.75, 1.60], [0.40, -0.75, 1.60], [0.80, -0.75, 1.60],
									[-0.80, -0.75, 1.20], [-0.40, -0.75, 1.20], [0.00, -0.75, 1.20], [0.40, -0.75, 1.20], [0.80, -0.75, 1.20],
									[-0.80, -0.75, 0.80], [-0.40, -0.75, 0.80], [0.00, -0.75, 0.80], [0.40, -0.75, 0.80], [0.80, -0.75, 0.80]
								];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = getArray (configfile >> "CfgWeapons" >> OPEX_friendly_commonRifles select 0 >> "magazines");
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addMagazineCargoGlobal [_weapons select 0, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 90, 0] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// SUPPORT
			case armoury_support :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions =
								[
									[-0.75, -0.75, 2.00], [0.00, -0.75, 2.00], [0.75, -0.75, 2.00],
									[-0.75, -0.75, 1.75], [0.00, -0.75, 1.75], [0.75, -0.75, 1.75],
									[-0.75, -0.75, 1.50], [0.00, -0.75, 1.50], [0.75, -0.75, 1.50],
									[-0.75, -0.75, 1.25], [0.00, -0.75, 1.25], [0.75, -0.75, 1.25],
									[-0.75, -0.75, 1.00], [0.00, -0.75, 1.00], [0.75, -0.75, 1.00]
								];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = OPEX_friendly_closeCombatOptics + OPEX_friendly_distantCombatOptics + OPEX_friendly_sniperOptics;
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addItemCargoGlobal [_weapons select _index, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 90, 0] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// GRENADES
			case armoury_grenades :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions =
								[
									[-0.80, -0.10, 2.40], [-0.40, -0.10, 2.40], [0.00, -0.10, 2.40], [0.40, -0.10, 2.40], [0.80, -0.10, 2.40],
									[-0.80, -0.10, 2.00], [-0.40, -0.10, 2.00], [0.00, -0.10, 2.00], [0.40, -0.10, 2.00], [0.80, -0.10, 2.00],
									[-0.80, -0.10, 1.60], [-0.40, -0.10, 1.60], [0.00, -0.10, 1.60], [0.40, -0.10, 1.60], [0.80, -0.10, 1.60]
								];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = OPEX_friendly_handGrenades;
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addMagazineCargoGlobal [_weapons select 0, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 0, 0] call BIS_fnc_setPitchBank;
							_weapon setDir ((getDir _weapon) + 180);
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// EXPLOSIVES
			case armoury_explosives :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					_positions = [[-0.65, -0.75, 2.00], [0.65, -0.75, 2.00], [-0.65, -0.75, 1.50], [0.65, -0.75, 1.50], [-0.65, -0.75, 1.00], [0.65, -0.75, 1.00]];
					for "_i" from 1 to (count _positions) do
						{
							_weapons = OPEX_friendly_explosives;
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							_weapon addMagazineCargoGlobal [_weapons select 0, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, 90, 0] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};

			// CLOTHES
			case armoury_clothes :
				{
					private ["_index", "_positions", "_weapons", "_weapon"];
					_index = 0;
					if (worldName == "IslaDuala3") then {_positions = [[-0.65, -0.75, 1.30], [0.65, -0.75, 1.30], [-0.65, -0.75, 0.60], [0.65, -0.75, 0.60]]} else {_positions = [[-0.65, -0.75, 2.00], [0.65, -0.75, 2.00], [-0.65, -0.75, 1.30], [0.65, -0.75, 1.30], [-0.65, -0.75, 0.60], [0.65, -0.75, 0.60]]};
					for "_i" from 1 to (count _positions) do
						{
							switch (OPEX_mapClimate) do
								{
									case default 	{_weapons = OPEX_friendly_mediumBackpacks_woodland + OPEX_friendly_bigBackpacks_woodland};
									case "arid"	 :	{_weapons = OPEX_friendly_mediumBackpacks_desert + OPEX_friendly_bigBackpacks_desert};
									case "polar" : 	{_weapons = OPEX_friendly_mediumBackpacks_snow + OPEX_friendly_bigBackpacks_snow};
								};
							_weapon = "Library_WeaponHolder" createVehicle (_positions select _index);
							while {count _positions > count _weapons} do {_weapons = _weapons + _weapons}; // this command avoids issues if there are not enough defined elements
							_weapon addBackpackCargoGlobal [_weapons select _index, 1];
							[_this, _weapon, _positions select _index] call BIS_fnc_relPosObject;
							[_weapon, -90, 180] call BIS_fnc_setPitchBank;
							_weapon enableSimulationGlobal false;
							_index = _index + 1;
						};
				};
		};