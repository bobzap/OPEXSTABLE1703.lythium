// =========================================================================================================
// WAITING FOR PLAYER
// =========================================================================================================

	private _player = _this select 0;

	waitUntil {(!isNull _player) && (_player == _player)};
	waitUntil {time > 0};

	// NAMING PLAYER (NECESSARY FOR SOME SCRIPT EXECUTION)
	private _playerID = "OPEX" + "_" + "playerID" + "_" + (getPlayerUID _player);
	[_player, _playerID] remoteExecCall ["Gemini_fnc_setVehicleVarName", 0, _player];

	// SETTING PLAYER LANGUAGE
	[_player] spawn Gemini_fnc_setSpeaker;

// =========================================================================================================
// REFRESHING DYNAMIC SIMULATION SYSTEM (otherwise, units/objects/vehicles with dynamic simulation enabled may be hidden at startup on dedicated persistent servers)
// =========================================================================================================

	call Gemini_fnc_refreshDynamicSimulation;