/*
	TO DELETE MANUALLY THE PERSISTENT SAVE, USE THIS COMMAND IN THE DEBUG CONSOLE:
	execVM "reset.sqf"
	and press "EXEC ALL"
*/

profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_server", nil];
profileNamespace setVariable ["OPEX_" + worldName + "_persistentData_player", nil];
profileNamespace setVariable ["OPEX_persistentStats_server", nil];
profileNamespace setVariable ["OPEX_persistentStats_player", nil];
sleep 1;
saveProfileNamespace;
if (isMultiplayer) then {"missionResetted" call BIS_fnc_endMissionServer} else {["missionResetted", true, true] call BIS_fnc_endMission};