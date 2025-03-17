//diag_log format ["############## %1 ############## - AIS init started", missionName];

/*
if (isServer) then {
	ais_ace_shutDown = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {
		ais_ace_shutDown = true;
		//["AIS: AIS shutdown itself cause ACE mod was detected. ACE and AIS cant work at the same time."] call BIS_fnc_logFormat;
	};
	publicVariable "ais_ace_shutDown";
};
*/

	ais_ace_shutDown = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith
		{
			ais_ace_shutDown = true;
			publicVariable "ais_ace_shutDown";
			//["AIS: AIS shutdown itself cause ACE mod was detected. ACE and AIS cant work at the same time."] call BIS_fnc_logFormat;
		};
	publicVariable "ais_ace_shutDown";


//removeAllMissionEventHandlers "Draw3D";
//removeAllMissionEventHandlers "EachFrame";
//ais_ace_shutDown = false;

call AIS_Core_fnc_initEvents;
AIS_Core_Interaction_Actions = [];