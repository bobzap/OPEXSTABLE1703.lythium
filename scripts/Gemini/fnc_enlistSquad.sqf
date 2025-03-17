// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_this", "_unit", "_recruiter", "_group", "_actionID", "_canDemobilized"];

// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	_unit = _this select 0;
	_recruiter = _this select 1;
	_group = group (_this select 1);
	_actionID = _this select 2;
	_canDemobilized = _this select 3;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if (_recruiter != leader group _recruiter) exitWith {hintC localize "STR_hint_leaderOnly"}; // only team leaders can perform this action

// =========================================================================================================
// JOINING GROUP
// =========================================================================================================

	{
		if (alive _unit) then
			{	_x switchMove "";
				_x setCaptive false;
				_x allowDamage true;
				[_x, "auto"] remoteExec ["Gemini_fnc_setUnitPos", _x];
				_x doMove (position _unit);
				[_x, "move"] remoteExec ["Gemini_fnc_enableAI", _x];
				[_x] join _group;
				if (!isMultiplayer) then {addSwitchableUnit  _x}; // SETTING TEAM SWITCH AVAILABILITY
			};
	} forEach (units group _unit);