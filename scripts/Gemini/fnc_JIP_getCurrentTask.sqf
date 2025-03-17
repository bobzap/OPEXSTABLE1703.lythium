if ((OPEX_assignedTask) && (OPEX_taskID != "") && (!(player getVariable ["assignedTask", false]))) then
	{
		["taskMarker_A", "taskMarker_B", "taskMarker_C", "taskMarker_D", "taskMarker_E", "taskMarker_F", "taskMarker_G", "taskMarker_H", "taskMarker_I", "taskMarker_J"] call Gemini_fnc_updateTaskMarkers;
		[OPEX_taskID, nil] call Gemini_fnc_taskAssigned;
	};