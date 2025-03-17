waitUntil {!isNil "OPEX_param_medical"};
waitUntil {!isNil "OPEX_params_ready"};
if ((isClass (configFile >> "CfgPatches" >> "ace_medical")) || (OPEX_param_medical == 1)) exitWith {};

call AIS_Core_fnc_preInit;
call AIS_Core_fnc_postInit;
call AIS_System_fnc_postInit;