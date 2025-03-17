//["airStrike"] remoteExec ["Gemini_fnc_addSupport", 2];
//["random"] remoteExec ["Gemini_fnc_addSupport", 2];

if (!isServer) exitWith {}; // server only

private ["_support", "_supports"];

_support = _this select 0;

// CHECKING IF SUPPORT IS ALREADY ASSIGNED
if ((_support == "suppliesDrop") && (OPEX_support_suppliesDrop)) exitWith {}; // need ???
if ((_support == "vehicleDrop") && (OPEX_support_vehicleDrop)) exitWith {}; // ACTIVATED WITH TASK 20
if ((_support == "airStrike") && (OPEX_support_airStrike)) exitWith {}; // ACTIVATED WITH TASK 01
if ((_support == "artilleryStrike") && (OPEX_support_artilleryStrike)) exitWith {}; // need a task where we escort a supply convoy to HQ (that is carrying mobile artillery battery & shells)
if ((_support == "airAssistance") && (OPEX_support_airAssistance)) exitWith {}; // ACTIVATED WITH TASK 21
if ((_support == "landAssistance") && (OPEX_support_landAssistance)) exitWith {}; // ACTIVATED WITH TASK 10 + need a TASK where we rescue an infantry squad
if ((_support == "transport") && (OPEX_support_transport)) exitWith {}; // need ?

// RANDOM CASE - until each support is assigned to a specific task
_supports = [];
if ((_support == "random") && (!OPEX_support_suppliesDrop)) then {_supports append ["suppliesDrop"]};
if ((_support == "random") && (!OPEX_support_vehicleDrop)) then {_supports append ["vehicleDrop"]};
if ((_support == "random") && (!OPEX_support_airStrike)) then {_supports append ["airStrike"]};
if ((_support == "random") && (!OPEX_support_artilleryStrike)) then {_supports append ["artilleryStrike"]};
if ((_support == "random") && (!OPEX_support_airAssistance)) then {_supports append ["airAssistance"]};
if ((_support == "random") && (!OPEX_support_landAssistance)) then {_supports append ["landAssistance"]};
if ((_support == "random") && (!OPEX_support_transport)) then {_supports append ["transport"]};
if (_support == "random") then {if (count _supports == 0) exitWith {}};
if (_support == "random") then {selectedSupport = selectRandom _supports};
if (_support != "random") then {selectedSupport = _support};

// ACTIVATING SUPPORT
publicVariable "selectedSupport";
if (selectedSupport == "suppliesDrop") then {OPEX_support_suppliesDrop = true; publicVariable "OPEX_support_suppliesDrop"};
if (selectedSupport == "vehicleDrop") then {OPEX_support_vehicleDrop = true; publicVariable "OPEX_support_vehicleDrop"};
if (selectedSupport == "airStrike") then {OPEX_support_airStrike = true; publicVariable "OPEX_support_airStrike"};
if (selectedSupport == "artilleryStrike") then {OPEX_support_artilleryStrike = true; publicVariable "OPEX_support_artilleryStrike"};
if (selectedSupport == "airAssistance") then {OPEX_support_airAssistance = true; publicVariable "OPEX_support_airAssistance"};
if (selectedSupport == "landAssistance") then {OPEX_support_landAssistance = true; publicVariable "OPEX_support_landAssistance"};
if (selectedSupport == "transport") then {OPEX_support_transport = true; publicVariable "OPEX_support_transport"};

// ADDING SUPPORT TO COMMUNICATION MENU
	[
	[],
	{
		if (selectedSupport == "suppliesDrop") then {askSupport_suppliesDrop = [player, "OPEX_support_suppliesDrop"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "vehicleDrop") then {askSupport_vehicleDrop = [player, "OPEX_support_vehicleDrop"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "airStrike") then {askSupport_airStrike = [player, "OPEX_support_airStrike"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "artilleryStrike") then {askSupport_artilleryStrike = [player, "OPEX_support_artilleryStrike"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "airAssistance") then {askSupport_airAssistance = [player, "OPEX_support_airAssistance"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "landAssistance") then {askSupport_landAssistance = [player, "OPEX_support_landAssistance"] call BIS_fnc_addCommMenuItem};
		if (selectedSupport == "transport") then {askSupport_transport = [player, "OPEX_support_transport"] call BIS_fnc_addCommMenuItem};
	}] remoteExecCall ["call"];
sleep 0.1;
selectedSupport = nil; publicVariable "selectedSupport";