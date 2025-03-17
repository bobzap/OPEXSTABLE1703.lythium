if (!isServer) exitWith {};

sleep 5;

// FATA CAVE ITEMS - not usefull anymore ?
/*
if (worldName == "fata") then
	{
		private _caveItems = [];
		{
			private _nearbyItems = nearestObjects [_x, [], (triggerArea _x select 0) max (triggerArea _x select 1)];
			_caveItems append _nearbyItems
		} forEach OPEX_locations_caves;
		sleep 3;
		if (count _caveItems > 0) then {{[_x, "unlimited"] call Gemini_fnc_setLifeTime} forEach _caveItems};
	};
*/

// GETTING ALL ABANDONED THINGS
private _cleaning =
	{
		// UAVs
		if ((count (vehicles select {_x isKindOf "UAV"}) > 0) && (count (OPEX_entities select 0) > 0)) then 
			{
				{
					if ((_x in (OPEX_entities select 0)) && (canMove _x)) then {OPEX_entities set [0, (OPEX_entities select 0) - [_x]]}; // removing drones from distant list if it can move
					if ((!(_x in (OPEX_entities select 0))) && (!(canMove _x))) then {OPEX_entities set [0, (OPEX_entities select 0) pushBackUnique _x]}; // adding drones from distant list if he can't move
				} forEach (vehicles select {_x isKindOf "UAV"});
			};

		// ENTITIES
		if (count (OPEX_entities select 0) > 0) then {{if ((!([_x] call Gemini_fnc_isPlayerNearby)) && (!([_x] call Gemini_fnc_isTeammateNearby)) && (!([_x] call Gemini_fnc_isInPlayerGroup)) && (!([position _x, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted))) then {{deleteVehicle _x} forEach (crew _x + [_x]); OPEX_entities set [0, (OPEX_entities select 0) - [_x]]}} forEach (OPEX_entities select 0)};
		if (count (OPEX_entities select 1) > 0) then {{if ((!([_x] call Gemini_fnc_isPlayerNearby)) && (!([_x] call Gemini_fnc_isTeammateNearby)) && (!([_x] call Gemini_fnc_isInPlayerGroup)) && (!([position _x, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted)) && (!OPEX_assignedTask)) then {{deleteVehicle _x} forEach (crew _x + [_x]); OPEX_entities set [1, (OPEX_entities select 1) - [_x]]}} forEach (OPEX_entities select 1)};
		if (count (OPEX_entities select 2) > 0) then {{if ((!([_x] call Gemini_fnc_isPlayerNearby)) && (!([_x] call Gemini_fnc_isTeammateNearby)) && (!([_x] call Gemini_fnc_isInPlayerGroup)) && (!([position _x, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted)) && (!alive _x)) then {{deleteVehicle _x} forEach (crew _x + [_x]); OPEX_entities set [2, (OPEX_entities select 2) - [_x]]}} forEach (OPEX_entities select 2)};
		publicVariable "OPEX_entities";

		// MARKERS
		if (count (OPEX_markers select 0) > 0) then {{if (!([getMarkerPos _x] call Gemini_fnc_isPlayerNearby)) then {deleteMarker _x; OPEX_markers set [0, (OPEX_markers select 0) - [_x]]}} forEach (OPEX_markers select 0)};
		if (count (OPEX_markers select 1) > 0) then {{if ((!([getMarkerPos _x] call Gemini_fnc_isPlayerNearby)) && (!OPEX_assignedTask)) then {deleteMarker _x; OPEX_markers set [1, (OPEX_markers select 1) - [_x]]}} forEach (OPEX_markers select 1)};
		if (count (OPEX_markers select 2) > 0) then {{if (!([getMarkerPos _x] call Gemini_fnc_isPlayerNearby)) then {_x setMarkerAlpha 0}} forEach (OPEX_markers select 2)};
		publicVariable "OPEX_markers";

		// TRIGGERS


		// GAME LOGICS
		private _allLogics = allUnits select {side _x == sideLogic};
		private _unwantedLogics = (allUnits select {side _x == sideLogic}) - OPEX_logics;
		if (count _unwantedLogics > 0) then {{if (count ((_x nearEntities 2) select {!(_x isKindOf "Logic")}) == 0) then {deleteVehicle _x}} forEach _unwantedLogics};
		publicVariable "OPEX_logics";
	};

// CLEANING
while {true} do
	{
		sleep 3;
		call _cleaning;
	};