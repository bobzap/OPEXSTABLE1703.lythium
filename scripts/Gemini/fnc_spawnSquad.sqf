// =========================================================================================================
// SCRIPT COPYRIGHT
// =========================================================================================================

	/*
		Author:								Gemini
		Contact: 							gemini.69@free.fr
		Autohorized usage:					Yes
		Authorized copy/modifications: 		Yes, but please think to mention the author's name
	*/

// =========================================================================================================
// SCRIPT INSTRUCTIONS
// =========================================================================================================

	/*

		// DETAILED EXECUTION:
		[
			SIDE,						// (STRING)				squad side (west / east)
			TYPES,						// (ARRAY OF STRINGS)	possible squad types ("infantry" / "motorized" / "armored")
			QUANTITY OF UNITS, 			// (NUMBER)				quantity of units (-1 if random)
			POSITION,					// (ARRAY OF NUMBERS)	spawning position
			RADIUS,						// (ARRAY OF NUMBERS)	precision of spawning position, in meters (0 means exact position)
			MISSION,					// (STRING) 			squad mission ("defend" / "attack" / "patrol" / "hold")
			DESTINATION,				// (ARRAY OF NUMBERS)	squad destination
			SKILL,						// (ARRAY OF NUMBERS)	AI skill (minimum level and maximum level)
			PROBABILITY					// (NUMBER)				% probability to spawn squad (-1 if random)

		] call Gemini_fnc_spawnSquad;

		// EXAMPLES:
		_newFriendlySquad = [west, ["infantry", "mechanized"], 10, position player, 10, "patrol", position player, [0.2, 0.7], 100] call Gemini_fnc_spawnSquad;
		_newEnemySquad = [OPEX_enemy_side1, ["infantry"], -1, OPEX_mapCenter, OPEX_mapRadius, "patrol", position player, OPEX_enemy_AIskill, -1] call Gemini_fnc_spawnSquad;

	*/

// =========================================================================================================
// STARTING SCRIPT EXECUTION (SERVER ONLY)
// =========================================================================================================

	if (!isServer) exitWith {};
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};

// =========================================================================================================
// CHECKING PARAMETERS
// =========================================================================================================

	private _side = param [0, east, [east]];
	private _types = param [1, ["infantry"], [[""]]];
	private _quantity = param [2, -1, [0]];
	private _center = param [3, [0,0,0], [[], objNull]]; if (_center isEqualType objNull) then {_center = position _center};
	private _radius = param [4, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], [[],0]]; if (_radius isEqualType 0) then {_radius = [0, _this select 4]};
	private _mission = param [5, "patrol", [""]];
	private _destination = param [6, [0,0,0], [[], objNull]]; if (_destination isEqualType objNull) then {_destination = position _destination};
	private _skill = param [7, [0,1], [[]]];
	private _probability = param [8, 100, [0]];
	private _lifeTime = param [9, "distance", [""]];

// =========================================================================================================
// CHECKING PROBABILITY TO SPAWN SQUAD
// =========================================================================================================

	if (_probability == -1) then {_probability = random 100};
	if (random 100 > _probability) exitWith {};

// =========================================================================================================
// SELECTING SQUAD TYPE
// =========================================================================================================

	private _type = selectRandom _types;

// =========================================================================================================
// LOOKING FOR A VALID EMPTY POSITION
// =========================================================================================================

	private ["_position"];
	if (!(_radius isEqualTo [0,0]))
	then
		{
			if (_type == "infantry") then {_position = ["land", _center, _radius select 0, _radius select 1] call Gemini_fnc_findPos};
			if ((_type == "motorized") || (_type == "armored")) then
				{
					_position = ["road", _center, _radius select 0, _radius select 1] call Gemini_fnc_findPos;
					if (_position isEqualTo [0,0,0]) then {_position = ["land", _center, _radius select 0, _radius select 1] call Gemini_fnc_findPos};
				};
		}
	else {_position = _center};
	if (_position isEqualTo [0,0,0]) exitWith {};

// =========================================================================================================
// CREATING VEHICLE (IF NECESSARY)
// =========================================================================================================

	private ["_vehicle"];
	if (_side == OPEX_enemy_side1) then
		{
			if (_type == "motorized") then {_vehicle = [selectRandom OPEX_enemy_motorizedVehicles, _position, random 360, true, _lifeTime] call Gemini_fnc_createVehicle};
			if (_type == "armored") then {_vehicle = [selectRandom OPEX_enemy_armored, _position, random 360, true, _lifeTime] call Gemini_fnc_createVehicle};
		};
	if (_side == OPEX_friendly_side1) then
		{
			if (_type == "motorized") then {_vehicle = [OPEX_friendly_combatCarsMG + OPEX_friendly_combatCarsGL + OPEX_friendly_transportTrucksOpened + OPEX_friendly_transportTrucksCovered, _position, random 360, true, _lifeTime] call Gemini_fnc_createVehicle};
			if (_type == "armored") then {_vehicle = [OPEX_friendly_vtt + OPEX_friendly_tanks, _position, random 360, true, _lifeTime] call Gemini_fnc_createVehicle};
		};
	//if (!isNil "_vehicle") then {_vehicle spawn {sleep 10; waitUntil {(count (_this nearEntities ["Man", 100]) == 0) && (count crew _this == 0)}; deleteVehicle _this}};

// =========================================================================================================
// CREATING SQUAD
// =========================================================================================================

	// CONFIRMING HOW MANY UNITS ARE REQUIRED
	if (_quantity == -1) then {_quantity = selectRandom [2,3,5,8,10,12,15]} else {_quantity = _quantity};
	if ((_quantity == -1) && (_mission == "talk")) then {_quantity = selectRandom [2,2,2,2,3,3,3,3,4,5]};
	if (_quantity < 2) then {_quantity = 2};

	// DEFINING SQUAD COMPOSITION
	private _composition = [];
	if (_side == OPEX_enemy_side1) then
		{
			if (_quantity == 2) then {for "_i" from 1 to 2 do {_composition pushBack (selectRandom OPEX_enemy_units)}};
			if (_quantity > 2) then {_composition pushBack OPEX_enemy_teamLeader; for "_i" from 1 to (_quantity - 1) do {_composition pushBack (selectRandom (OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_commonUnits + OPEX_enemy_specialUnits))}};
		};
	if (_side == OPEX_friendly_side1) then
		{
			if (_quantity == 2) then {for "_i" from 1 to 2 do {_composition pushBack (selectRandom OPEX_friendly_units)}};
			if (_quantity > 2) then {_composition pushBack OPEX_friendly_teamLeader; for "_i" from 1 to (_quantity - 1) do {_composition pushBack (selectRandom (OPEX_friendly_commonUnits + OPEX_friendly_commonUnits + OPEX_friendly_commonUnits + OPEX_friendly_specialUnits))}};
		};

	// CREATING SQUAD GROUP
	private ["_tempGroup"];
	_tempGroup = createGroup _side;
	_tempGroup setBehaviour "safe";

	// SPAWNING SQUAD
	for "_i" from 1 to _quantity do {[_side, _tempGroup, _composition select (_i - 1), [(_position select 0) + random 10 - random 10, (_position select 1) + random 10 - random 10, 0], _skill, false, _lifeTime] call Gemini_fnc_createUnit};

	// PREVENTING A BEHAVIOUR ISSUE THAT MAY HAPPEN WHEN UNITS FROM A DIFFERENT CONFIG SIDE ARE USED (EXAMPLE: SPAWNING INDEP UNITS ON THE OPFOR SIDE)
	private ["_squad"];
	_squad = createGroup _side;
	{(units _tempGroup) joinSilent _squad} forEach units _tempGroup;
	_squad setBehaviour "safe";
	deleteGroup _tempGroup;

// =========================================================================================================
// MOVING SQUAD UNITS INTO VEHCILE (IF NECESSARY)
// =========================================================================================================

	if (((_type == "motorized") || (_type == "armored")) && (!isNil "_vehicle")) then
		{
			if ((alive _vehicle) && (canMove _vehicle)) then
				{
					private ["_unitsOutsideVehicle"];
					_unitsOutsideVehicle = units _squad;
					if (count units _squad > 0) then {if ((_vehicle emptyPositions "commander") > 0) then {(units _squad select 0) moveInCommander _vehicle} else {if ((_vehicle emptyPositions "driver") > 0) then {(units _squad select 0) moveInDriver _vehicle} else {if ((_vehicle emptyPositions "gunner") > 0) then {(units _squad select 0) moveInGunner _vehicle}}}};
					if (count units _squad > 1) then {if ((_vehicle emptyPositions "commander") > 0) then {(units _squad select 1) moveInCommander _vehicle} else {if ((_vehicle emptyPositions "driver") > 0) then {(units _squad select 1) moveInDriver _vehicle} else {if ((_vehicle emptyPositions "gunner") > 0) then {(units _squad select 1) moveInGunner _vehicle}}}};
					if (count units _squad > 2) then {if ((_vehicle emptyPositions "commander") > 0) then {(units _squad select 2) moveInCommander _vehicle} else {if ((_vehicle emptyPositions "driver") > 0) then {(units _squad select 2) moveInDriver _vehicle} else {if ((_vehicle emptyPositions "gunner") > 0) then {(units _squad select 2) moveInGunner _vehicle}}}};
					if (count units _squad > 3) then {if ((_vehicle emptyPositions "commander") > 0) then {(units _squad select 3) moveInCommander _vehicle} else {if ((_vehicle emptyPositions "driver") > 0) then {(units _squad select 3) moveInDriver _vehicle} else {if ((_vehicle emptyPositions "gunner") > 0) then {(units _squad select 3) moveInGunner _vehicle}}}};
					if (count units _squad > 4) then {if ((_vehicle emptyPositions "commander") > 0) then {(units _squad select 4) moveInCommander _vehicle} else {if ((_vehicle emptyPositions "driver") > 0) then {(units _squad select 4) moveInDriver _vehicle} else {if ((_vehicle emptyPositions "gunner") > 0) then {(units _squad select 4) moveInGunner _vehicle}}}};
					{if (_x in (crew _vehicle)) then {_unitsOutsideVehicle = _unitsOutsideVehicle - [_x]}} forEach (units _squad);
					{if (((_vehicle emptyPositions "cargo") > 0) && (count _unitsOutsideVehicle > 0)) then {_x moveInCargo _vehicle; _unitsOutsideVehicle = _unitsOutsideVehicle - [_x]}} forEach (units _squad);
					{
						_x setBehaviour "safe";
						_x setSpeedMode "limited";
						if (vehicle _x == _x) then {deleteVehicle _x}; // removing units that didn't board into the vehicle
					} forEach units _squad;

				};
		};

// =================================================================================================
// SETTING SQUAD TASK
// =================================================================================================

	if ((_mission == "attack") && (_type == "infantry")) then {[_squad, _destination] call BIS_fnc_taskAttack; leader _squad setSpeedMode (selectRandom ["limited", "normal", "full"]); leader _squad setCombatMode "red"; leader _squad setFormation (selectRandom ["WEDGE", "VEE", "LINE", "DIAMOND", "ECH LEFT", "ECH RIGHT"])};
	if ((_mission == "attack") && (_type != "infantry")) then {[_squad, _destination] call BIS_fnc_taskAttack; leader _squad setSpeedMode (selectRandom ["limited", "normal"]); leader _squad setCombatMode "red"; leader _squad setFormation "COLUMN"; {_x setBehaviour "safe"} forEach units _squad};
	if (_mission == "patrol") then {[_squad, _destination, _radius] spawn Gemini_fnc_doPatrol};
	if (_mission == "hold") then {[_squad, _radius, _destination] call Gemini_fnc_doHold};
	if (_mission == "talk") then {[_squad, _center, _radius] call Gemini_fnc_doTalk};
	if (_mission == "wait") then {[_squad, _center, _radius, _destination] call Gemini_fnc_doWait};

	{_x enableSimulationGlobal true} forEach units _squad;

// =========================================================================================================
// RETURNING SPAWNED SQUAD
// =========================================================================================================

	_squad