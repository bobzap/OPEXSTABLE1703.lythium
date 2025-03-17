// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	if (isDedicated) exitWith {};
	private ["_object", "_text", "_script", "_arguments", "_priority", "_condition", "_showWhenActive", "_hideOnUse"];


// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	_object = _this select 0;
	_text = _this select 1;
	_script = _this select 2;
	_arguments = [_this, 3, []] call BIS_fnc_param;
	_priority = [_this, 4, 1.5, [0]] call BIS_fnc_param;
	_condition = [_this, 5, "true", [""]] call BIS_fnc_param;
	_showWhenActive = [_this, 6, true, [true]] call BIS_fnc_param;
	_hideOnUse = [_this, 7, true, [true]] call BIS_fnc_param;

	if (isNil "_object") exitWith {};

// =========================================================================================================
// ADDING ACTION
// =========================================================================================================

	//_localizedText = "<t color=""#FFFFFF"">" + format ["(%1) ", _object] + localize _text + "</t>";
	_localizedText = "<t color=""#FFFFFF"">" + localize _text + "</t>";
	_object addAction [_localizedText, _script, _arguments, _priority, _showWhenActive, _hideOnUse, "", _condition];