// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private
		[
			"_assignedSupports"
		];

// =========================================================================================================
// DELETING RANDOM SUPPORT
// =========================================================================================================

	// IF NO SUPPORT IS ALREADY ASSIGNED, EXITING
		if (!OPEX_support_suppliesDrop && !OPEX_support_vehicleDrop && !OPEX_support_airStrike && !OPEX_support_artilleryStrike && !OPEX_support_airAssistance && !OPEX_support_landAssistance && !OPEX_support_transport) exitWith {};

	//	LISTING ALL ASSIGNED SUPPORT(S)
		_assignedSupports = [];
		if (OPEX_support_suppliesDrop) then {_assignedSupports = _assignedSupports + ["OPEX_support_suppliesDrop"]};
		if (OPEX_support_vehicleDrop) then {_assignedSupports = _assignedSupports + ["OPEX_support_vehicleDrop"]};
		if (OPEX_support_airStrike) then {_assignedSupports = _assignedSupports + ["OPEX_support_airStrike"]};
		if (OPEX_support_artilleryStrike) then {_assignedSupports = _assignedSupports + ["OPEX_support_artilleryStrike"]};
		if (OPEX_support_airAssistance) then {_assignedSupports = _assignedSupports + ["OPEX_support_airAssistance"]};
		if (OPEX_support_landAssistance) then {_assignedSupports = _assignedSupports + ["OPEX_support_landAssistance"]};
		if (OPEX_support_transport) then {_assignedSupports = _assignedSupports + ["OPEX_support_transport"]};

	// SELECTING A RANDOM ONE
		if (isServer) then {support = _assignedSupports call BIS_fnc_selectRandom; publicVariable "support"};

	// UNASSIGNING SUPPORT
		waitUntil {sleep 1; !isNil "support"};
		if (!isDedicated) then
			{
				if (support == "OPEX_support_suppliesDrop") then {OPEX_support_suppliesDrop = false; publicVariable "OPEX_support_suppliesDrop"; [player, AskSupport_suppliesDrop] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_vehicleDrop") then {OPEX_support_vehicleDrop = false; publicVariable "OPEX_support_vehicleDrop"; [player, AskSupport_vehicleDrop] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_airStrike") then {OPEX_support_airStrike = false; publicVariable "OPEX_support_airStrike"; [player, AskSupport_airStrike] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_artilleryStrike") then {OPEX_support_artilleryStrike = false; publicVariable "OPEX_support_artilleryStrike"; [player, AskSupport_artilleryStrike] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_airAssistance") then {OPEX_support_airAssistance = false; publicVariable "OPEX_support_airAssistance"; [player, AskSupport_airAssistance] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_landAssistance") then {OPEX_support_landAssistance = false; publicVariable "OPEX_support_landAssistance"; [player, AskSupport_landAssistance] call BIS_fnc_removeCommMenuItem};
				if (support == "OPEX_support_transport") then {OPEX_support_transport = false; publicVariable "OPEX_support_transport"; [player, AskSupport_transport] call BIS_fnc_removeCommMenuItem};
			};
		if (isServer) then {support = nil; publicVariable "support"};