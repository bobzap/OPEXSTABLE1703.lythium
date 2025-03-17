// =========================================================================================================
// UPDATING SUPPORT LIST (FOR JIP PLAYER)
// =========================================================================================================

	if (isDedicated) exitWith {};
	waitUntil {!isNil "OPEX_support_suppliesdrop"};
	waitUntil {!isNil "OPEX_support_vehicleDrop"};
	waitUntil {!isNil "OPEX_support_airStrike"};
	waitUntil {!isNil "OPEX_support_artilleryStrike"};
	waitUntil {!isNil "OPEX_support_airAssistance"};
	waitUntil {!isNil "OPEX_support_landAssistance"};
	waitUntil {!isNil "OPEX_support_transport"};
	waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
	waitUntil {!isNil "OPEX_introFinished"}; waitUntil {OPEX_introFinished};

	sleep 10;
	if (OPEX_support_suppliesDrop && isNil "AskSupport_suppliesDrop") then {AskSupport_suppliesDrop = [player, "OPEX_support_suppliesDrop"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_vehicleDrop && isNil "AskSupport_vehicleDrop") then {AskSupport_vehicleDrop = [player, "OPEX_support_vehicleDrop"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_airStrike && isNil "AskSupport_airStrike") then {AskSupport_airStrike = [player, "OPEX_support_airStrike"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_artilleryStrike && isNil "AskSupport_artilleryStrike") then {AskSupport_artilleryStrike = [player, "OPEX_support_artilleryStrike"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_airAssistance && isNil "AskSupport_airAssistance") then {AskSupport_airAssistance = [player, "OPEX_support_airAssistance"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_landAssistance && isNil "AskSupport_landAssistance") then {AskSupport_landAssistance = [player, "OPEX_support_landAssistance"] call BIS_fnc_addCommMenuItem};
	if (OPEX_support_transport && isNil "AskSupport_transport") then {AskSupport_transport = [player, "OPEX_support_transport"] call BIS_fnc_addCommMenuItem};