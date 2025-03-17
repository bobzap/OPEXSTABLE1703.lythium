// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_recruit", "_recruiter", "_squad", "_wp"];

// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	_recruit = _this select 0;
	_squad = group (_this select 0);
	_recruiter = _this select 1;
	_actionID = _this select 2;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if (_recruiter != leader _recruiter) exitWith {hintC localize "STR_hint_leaderOnly"}; // only team leaders can perform this action

// =========================================================================================================
// DEMOBILIZING
// =========================================================================================================

	_recruiter hcRemoveGroup _squad;

	_wp = _squad addWaypoint [(getMarkerPos "OPEX_marker_camp"), 25];
	[_squad, 1] setWaypointSpeed "limited";
	[_squad, 1] setWaypointBehaviour "safe";
	{
		_x setSpeedMode "limited";
		_x setBehaviour "safe";
	} forEach units _squad;

// =========================================================================================================
// DELETING UNIT WHEN PLAYER IS FAR ENOUGH (TO SAVE CPU)
// =========================================================================================================

	waitUntil {sleep 5; {(leader _squad) distance _x < 250} count (playableUnits + switchableUnits) == 0};
	if (!(_squad in (hcAllGroups _recruiter))) then {{deleteVehicle _x} forEach units _squad};

// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================

	if (true) exitWith {};