// =========================================================================================================
// UPDATING SUPPORT LIST
// =========================================================================================================

	execVM "supports\JIPsupport.sqf";
	private ["_supportRequest"];
	_supportRequest = createTrigger ["EmptyDetector", [0,0,0], false];
	_supportRequest setTriggerActivation ["Alpha", "present", true];
	_supportRequest setTriggerStatements ["this", "0 = [player] spawn Gemini_fnc_supportRequest", ""];
	1 setRadioMsg (localize "STR_support_request");