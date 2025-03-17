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

	if ((alive _unit) && (group _unit != _group)) then
		{	_unit switchMove "";
			_unit setCaptive false;
			_unit allowDamage true;
			[_unit, "auto"] remoteExec ["Gemini_fnc_setUnitPos", _unit];
			_unit doMove (position _unit);
			[_unit, "move"] remoteExec ["Gemini_fnc_enableAI", _unit];
			[_unit, "autoTarget"] remoteExec ["Gemini_fnc_enableAI", _unit];
			sleep 0.5;
			[_unit] join _group;
			if (isMultiplayer) then {addSwitchableUnit _unit}; // SETTING TEAM SWITCH AVAILABILITY
		};