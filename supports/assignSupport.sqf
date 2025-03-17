// =========================================================================================================
// DEBUGGING (COMMANDS TO MAKE SUPPORT AVAILABLE)
// =========================================================================================================

	askSupport_suppliesDrop = [player, "OPEX_support_suppliesDrop"] call BIS_fnc_addCommMenuItem; OPEX_support_suppliesDrop = true; publicVariable "OPEX_support_suppliesDrop";
	askSupport_vehicleDrop = [player, "OPEX_support_vehicleDrop"] call BIS_fnc_addCommMenuItem; OPEX_support_vehicleDrop = true; publicVariable "OPEX_support_vehicleDrop";
	askSupport_airStrike = [player, "OPEX_support_airStrike"] call BIS_fnc_addCommMenuItem; OPEX_support_airStrike = true; publicVariable "OPEX_support_airStrike";
	askSupport_artilleryStrike = [player, "OPEX_support_artilleryStrike"] call BIS_fnc_addCommMenuItem; OPEX_support_artilleryStrike = true; publicVariable "OPEX_support_artilleryStrike";
	askSupport_airAssistance = [player, "OPEX_support_airAssistance"] call BIS_fnc_addCommMenuItem; OPEX_support_airAssistance = true; publicVariable "OPEX_support_airAssistance";
	askSupport_landAssistance = [player, "OPEX_support_landAssistance"] call BIS_fnc_addCommMenuItem; OPEX_support_landAssistance = true; publicVariable "OPEX_support_landAssistance";
	askSupport_transport = [player, "OPEX_support_transport"] call BIS_fnc_addCommMenuItem; OPEX_support_transport = true; publicVariable "OPEX_support_transport";
	//if (true) exitWith {};

// =========================================================================================================
// ASSIGNING RANDOM SUPPORT
// =========================================================================================================

	// IF ALL SUPPORTS ARE ALREADY ASSIGNED, EXITING
	if (OPEX_support_suppliesDrop && OPEX_support_vehicleDrop && OPEX_support_airStrike && OPEX_support_artilleryStrike && OPEX_support_airAssistance && OPEX_support_landAssistance && OPEX_support_transport) exitWith {};

	//	LISTING ALL AVAILABLE(S) SUPPORT(S)
	private _availableSupports = [];
	if (!OPEX_support_suppliesDrop) then {_availableSupports = _availableSupports + ["OPEX_support_suppliesDrop"]};
	if (!OPEX_support_vehicleDrop) then {_availableSupports = _availableSupports + ["OPEX_support_vehicleDrop"]};
	if (!OPEX_support_airStrike) then {_availableSupports = _availableSupports + ["OPEX_support_airStrike"]};
	if (!OPEX_support_artilleryStrike) then {_availableSupports = _availableSupports + ["OPEX_support_artilleryStrike"]};
	if (!OPEX_support_airAssistance) then {_availableSupports = _availableSupports + ["OPEX_support_airAssistance"]};
	if (!OPEX_support_landAssistance) then {_availableSupports = _availableSupports + ["OPEX_support_landAssistance"]};
	if (!OPEX_support_transport) then {_availableSupports = _availableSupports + ["OPEX_support_transport"]};

	// SELECTING A RANDOM ONE
	if (isServer) then {support = selectRandom _availableSupports; publicVariable "support"};

	// ASSIGNING NEW SUPPORT
	waitUntil {sleep 1; !isNil "support"};
	sleep 5;
	if (!isDedicated) then
		{
			if (support == "OPEX_support_suppliesDrop") then {OPEX_support_suppliesDrop = true; publicVariable "OPEX_support_suppliesDrop"; askSupport_suppliesDrop = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_vehicleDrop") then {OPEX_support_vehicleDrop = true; publicVariable "OPEX_support_vehicleDrop"; askSupport_vehicleDrop = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_airStrike") then {OPEX_support_airStrike = true; publicVariable "OPEX_support_airStrike"; askSupport_airStrike = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_artilleryStrike") then {OPEX_support_artilleryStrike = true; publicVariable "OPEX_support_artilleryStrike"; askSupport_artilleryStrike = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_airAssistance") then {OPEX_support_airAssistance = true; publicVariable "OPEX_support_airAssistance"; askSupport_airAssistance = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_landAssistance") then {OPEX_support_landAssistance = true; publicVariable "OPEX_support_landAssistance"; askSupport_landAssistance = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
			if (support == "OPEX_support_transport") then {OPEX_support_transport = true; publicVariable "OPEX_support_transport"; askSupport_transport = [player, format ["%1", support]] call BIS_fnc_addCommMenuItem};
		};
	if (isServer) then {support = nil; publicVariable "support"};