// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_recruit", "_recruiter", "_group", "_wp"];

// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	_recruit = _this select 0;
	_recruiter = _this select 1;
	_actionID = _this select 2;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if (_recruiter != leader _recruiter) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can perform this action

// =========================================================================================================
// DEMOBILIZING
// =========================================================================================================

	[_recruit] join GrpNull;
	_group = group _recruit;
	_wp = _group addWaypoint [(getMarkerPos "OPEX_marker_camp"), 25];
	[_group, 1] setWaypointSpeed "limited";
	[_group, 1] setWaypointBehaviour "safe";
	_recruit setSpeedMode "limited";
	_recruit setBehaviour "safe";
	if (!isMultiplayer) then {removeSwitchableUnit _recruit}; // SETTING TEAM SWITCH AVAILABILITY

// =========================================================================================================
// DELETING UNIT WHEN PLAYER IS FAR ENOUGH (TO SAVE CPU)
// =========================================================================================================

	waitUntil {sleep 5; {_recruit distance _x < 250} count (playableUnits + switchableUnits) == 0};
	if (!(_recruit in (units group _recruiter))) then {deleteVehicle _recruit};