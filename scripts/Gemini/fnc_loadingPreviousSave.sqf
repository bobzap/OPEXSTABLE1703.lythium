if (isDedicated) exitWith {};

addMissionEventHandler
	["Loaded",
		{
			if (OPEX_assignedTask) then {["TaskAssigned", ["", OPEX_taskDescription]] call BIS_fnc_showNotification};
			[] spawn {sleep 3; [] call bis_fnc_refreshCommMenu};
		}
	];