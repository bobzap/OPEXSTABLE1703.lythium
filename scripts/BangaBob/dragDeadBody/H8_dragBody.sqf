/*
 DragBody script by BangaBob (H8erMaker) v1.2

 Description
  Drag dead bodies out of sight to avoid detection. JIP/MP/SP/Dedicated compatible

 Instructions
  Add this line into the init.sqf. This will add a drag action to all editor placed units.
	null = allUnits execVM "H8_dragBody.sqf";

 Functions
	[UNIT1,UNIT2,UNIT3] spawn H8_addDrag;
 Add living units into the script. (Useful for units spawned mid-mission).
*/

#define H8_DRAGTEXT		localize "STR_action_bodyDrag"		// AddAction text for drag body
#define H8_DROPTEXT		localize "STR_action_bodyRelease"	// AddAction text for dropping body
#define H8_LOADTEXT		localize "STR_action_bodyLoad"		// AddAction text for dropping body
#define H8_UNLOTEXT		localize "STR_action_bodyUnload"	// AddAction text for dropping body

// MAIN ACTION
 H8_fnc_Action =
	 {
		//_dragCond = "(isNull (attachedTo _target)) && (count (attachedObjects _this) == 0) && ((_target distance _this) < 3) && ((!(canStand _target)) || ((lifeState _target == 'DEAD') || (lifeState _target == 'INCAPACITATED')))";
		_dragCond = "(isNull (attachedTo _target)) && (count (attachedObjects _this) == 0) && ((_target distance _this) < 3) && (!alive _target)";
			{
				_x addaction [H8_DRAGTEXT, {call H8_DragAction},nil,6,false,true,"",_dragCond];
			} forEach _this;
	 };


// DRAG ACTION
 H8_DragAction =
	 {
		_unit = (_this select 0);

		// GLOBAL CODE
		_unitID = _unit getVariable "H8_increm";
		 [[_unit, vehicle player,_unitID],"H8_fnc_attach",true] call BIS_fnc_MP;
		 _unit attachTo [player,[0,1,0]];

		// CLIENT SIDE
		player playAction "grabDrag";
		player forceWalk true;

		_dropID= player addAction [H8_DROPTEXT,{call H8_dropAction},_unit,10];
		_hideID =player addAction [H8_LOADTEXT,{call H8_putIncar},_unit,10,false,false,"","((cursorTarget isKindOf ""Car"") || (cursorTarget isKindOf ""Tank"") || (cursorTarget isKindOf ""Air"") || (cursorTarget isKindOf ""Ship"")) && _target distance _this < 5 && alive cursorTarget && (cursorTarget emptyPositions ""cargo"" > 0)"];

		player setVariable ["H8hideVeh",_hideID];
		player setVariable ["H8dropact",_dropID];
	 };


// LOAD IN VEHICLE
 H8_putIncar =
	 {
		 _hideID = (_this select 2);
		 _dropID = player getVariable "H8dropact";
		 _unit = (_this select 3);
		 _vehicle = cursorTarget;

		private ["_loadedBodies"];
		_loadedBodies =_vehicle getVariable ["H8loadedBodies", []];
		if (isNil "_loadedBodies") then
			{
				_vehicle setVariable ["H8loadedBodies", [], true];
				[_vehicle] spawn {waitUntil {sleep 1; (!alive (_this select 0)) || (isNull (_this select 0))}; {deleteVehicle _x} forEach attachedObjects (_this select 0)};
			};
		_loadedBodies =_vehicle getVariable ["H8loadedBodies", []];
		if ((_vehicle emptyPositions "cargo" == 0) || (count _loadedBodies >= _vehicle emptyPositions "cargo")) exitWith {hint localize "STR_hint_fullVehicle"};

		// CLIENT CODE
			player playMove "amovpknlmstpsraswrfldnon";
			player forceWalk false;
			player removeAction _hideID;
			player removeAction _dropID;

		// GLOBAL CODE
			_unitID = _unit getVariable "H8_increm";
			0 = [[_unit, vehicle player,_unitID],"H8_fnc_detach",true] call BIS_fnc_MP;
			sleep 1;
			deTach _unit;
			if (alive _unit) then {_unit moveInCargo _vehicle} else {[_unit, true] remoteExec ["hideObjectGlobal", 2, _unit]; _unit attachTo [_vehicle,[0,0,-10000]]};
			_vehicle setVariable ["H8loadedBodies", _loadedBodies + [_unit], true];
			[[_vehicle],"H8_carAction",true] call BIS_fnc_MP;
	};

// UNLOAD ACTION
 H8_carAction =
	 {
		_vehicle = (_this select 0);
		private ["_loadedBodies"];
		sleep 1;
		_loadedBodies =_vehicle getVariable ["H8loadedBodies", []];
		sleep 0.5;
		if (count _loadedBodies == 1) then {_vehicle addAction [H8_UNLOTEXT,{call H8_removeBody},nil,0,false,false,"","_this distance _target < 7"]};
	 };

// REMOVE VEHICLE ACTION
 H8_carRemoveAction =
	 {
		 _vehicle = (_this select 0);
		 _id = (_this select 1);
		_vehicle removeAction _id;
	 };

// UNLOADING FROM VEHICLE
 H8_removeBody =
	 {
		_vehicle = (_this select 0);
		_player = (_this select 1);
		_id = (_this select 2);

		private ["_loadedBodies"];
		_loadedBodies =_vehicle getVariable ["H8loadedBodies", []];

		if (count _loadedBodies > 0) then
			{
				_unit = _loadedBodies select 0;
				_vehicle setVariable ["H8loadedBodies", _loadedBodies - [_unit], true];

				if (alive _unit) then {moveOut _unit} else {detach _unit; [_unit, false] remoteExec ["hideObjectGlobal", 2, _unit]};
				_pos  = _player modelToWorld [1,0,0];
				_unit setPos _pos;
				_unit switchMove "AinjPpneMstpSnonWrflDb_release";
			};
		if (count _loadedBodies == 1) then {[[_vehicle,_id],"H8_carRemoveAction",true] call BIS_fnc_MP};
	 };

// DROP
 H8_dropAction =
	 {
		 _dropID = (_this select 2);
		 _hideID = player getVariable "H8hideVeh";
		 _unit	=	(_this select 3);

		// GLOBAL CODE
		_unitID = _unit getVariable "H8_increm";
		 0 = [[_unit, vehicle player,_unitID],"H8_fnc_detach",true] call BIS_fnc_MP;
		 deTach _unit;

		// CLIENT SIDE
		player removeAction _hideID;
		player removeAction _dropID;
		player playMove "amovpknlmstpsraswrfldnon";
		player forceWalk false;
	 };

// ATTACH FUNCTION
 H8_fnc_attach =
	 {
		_unit 	= 	(_this select 0);
		_player = 	(_this select 1);
		_unitID =	(_this select 2);

		_id = format ["h8EF%1",_unitID];
	 	0 = [_id, "onEachFrame", "H8_fnc_moveBody",[_unit,_player]] call BIS_fnc_addStackedEventHandler;
	 };


// DETACH FUNCTION
 H8_fnc_detach =
	 {
		 _unit 	= 	(_this select 0);
		_player = 	(_this select 1);
		_unitID =	(_this select 2);

		_id = format ["h8EF%1",_unitID];
		 0 = [_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

		sleep 0.05;
		_relD = [_unit,_player] call BIS_fnc_dirTo;
		_unit switchMove "AinjPpneMstpSnonWrflDb_release";
		_unit setDir _relD;
	 };

// MOVE BODY FUNCTION
 H8_fnc_moveBody =
	{
		_unit 	= (_this select 0);
		_player	= (_this select 1);

		// CREDIT TOO Das Attorney FOR CODE
			_pos  = _player modelToWorld [0,1,0];
		    _unit setPos _pos;
			_unit setDir 180;
			_unit switchMove "AinjPpneMrunSnonWnonDb";
	 };


 H8_addDrag =
	 {
	 	{
	 		waitUntil {!isNil "H8_increments"};
		 	H8_increments = H8_increments + 1;
			_x setVariable ["H8_increm",H8_increments,true];
			H8_dragUnitArray set [count H8_dragUnitArray, _x];
		} forEach _this;

		[_this,"H8_fnc_Action",TRUE] call BIS_fnc_MP;

		publicVariable "H8_increments";
		publicVariable "H8_dragUnitArray";
	 };

waitUntil {!isNil "OPEX_params_ready"};

if (isServer) then
	{
		if (isNil ("H8_dragUnitArray")) then
			{
				   H8_dragUnitArray = [];
				   H8_increments = 0;
			};

		 		{
					H8_increments = H8_increments + 1;
					_x setVariable ["H8_increm",H8_increments,true];
					H8_dragUnitArray set [count H8_dragUnitArray, _x];
				} forEach _this;
		publicVariable "H8_increments";
		publicVariable "H8_dragUnitArray";
	};

if (!isServer && (player != player)) then {waitUntil {player == player}; waitUntil {time > 15};};

if (!isDedicated) then {waitUntil {!isNil "H8_dragUnitArray"}; 0 = H8_dragUnitArray spawn H8_fnc_Action};