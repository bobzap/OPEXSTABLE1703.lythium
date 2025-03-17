Gemini_fnc_taskAssigned =
	{
		private ["_taskID", "_taskType", "_marker"];
		_taskID = _this select 0;
		OPEX_taskDescription = localize format ["STR_taskObjective_%1", _taskID];
		if (isNil "OPEX_task") then {OPEX_task = player createSimpleTask [OPEX_taskDescription]};
		OPEX_task setSimpleTaskDescription [localize format ["STR_taskBriefing_%1", _taskID], OPEX_taskDescription, OPEX_taskDescription];
		["TaskAssigned", ["", OPEX_taskDescription]] call BIS_fnc_showNotification;
		hintSilent "";

	};

Gemini_fnc_taskReset =
	{
		sleep 0.1;
		if (!isNil "OPEX_task") then
			{
				cancelSimpleTaskDestination OPEX_task;
				{_x removeSimpleTask OPEX_task; _x setVariable ["assignedTask",false]} forEach (allUnits + allDeadMen);
			};
		if (isServer) then
			{
				sleep 1;
				OPEX_assignedTask = false; publicVariable "OPEX_assignedTask";
				OPEX_task = nil; publicVariable "OPEX_task";
				OPEX_taskID = ""; publicVariable "OPEX_taskID";
				OPEX_taskDescription = []; publicVariable "OPEX_taskDescription";
			};
		{_x setMarkerShape "icon"; _x setMarkerType "empty"; _x setMarkerAlpha 0; _x setMarkerDir 0} forEach ["taskMarker_A", "taskMarker_B", "taskMarker_C", "taskMarker_D", "taskMarker_E", "taskMarker_F", "taskMarker_G", "taskMarker_H", "taskMarker_I", "taskMarker_J"];
		5 fadeMusic 0;
		sleep 5;
		playMusic "";
	};

Gemini_fnc_taskSucceeded =
	{
		private ["_index"];

		if (!OPEX_assignedTask) exitWith {};
		if (isNil "OPEX_task") exitWith {};

		OPEX_task setTaskState "succeeded";
		["TaskSucceeded", ["", OPEX_taskDescription]] call BIS_fnc_showNotification;
		// LOOKING FOR CURRENT TASK AND SETTING IT TO "DONE"
			if (isServer) then
				{
					_index = 1;
					for "_i" from 1 to (count OPEX_tasks - 1) do
						{
							if (((OPEX_tasks select _index select 0) == OPEX_taskID) && (!(Server getVariable (OPEX_tasks select _index select 0)))) then
								{
									//(OPEX_tasks select _index) set [2, true]; publicVariable "OPEX_tasks";
									Server setVariable [(OPEX_tasks select _index select 0), true, true];
									OPEX_succeededTasks = OPEX_succeededTasks + 1; publicVariable "OPEX_succeededTasks";
									OPEX_remainingTasks = OPEX_remainingTasks - 1; publicVariable "OPEX_remainingTasks";
								};
							_index = _index + 1;
						};
					//[OPEX_friendly_side1, "Base", "STR_globalStats_updatePositive", globalStats_mission_succeeded, globalStats] remoteExec ["Gemini_fnc_globalChat"];
				};
		// RESETTING TASK
		["taskSucceeded"] call Gemini_fnc_updateStats;
		[] spawn Gemini_fnc_taskReset;
	};

Gemini_fnc_taskFailed =
	{
		if (!OPEX_assignedTask) exitWith {};
		if (isNil "OPEX_task") exitWith {};

		OPEX_task setTaskState "failed";
		["TaskFailed", ["", OPEX_taskDescription]] call BIS_fnc_showNotification;
		if (isServer) then
			{
				["taskFailed"] call Gemini_fnc_updateStats;
				//[OPEX_friendly_side1, "Base", "STR_globalStats_updateNegative", globalStats_mission_failed, globalStats] remoteExec ["Gemini_fnc_globalChat"];
			};
		// RESETTING TASK
			[] spawn Gemini_fnc_taskReset;
	};

Gemini_fnc_taskCanceled =
	{
		if (!OPEX_assignedTask) exitWith {};
		if (isNil "OPEX_task") exitWith {};
		OPEX_task setTaskState "canceled";
		["TaskCanceled", ["", OPEX_taskDescription]] call BIS_fnc_showNotification;
		if (isServer) then {["taskCanceled"] call Gemini_fnc_updateStats};
		[] spawn Gemini_fnc_taskReset;
	};

Gemini_fnc_updateTaskMarkers =
	{
		private ["_markers", "_markerType", "_markerPos", "_markerSize", "_markerShape", "_markerDir", "_markerColor", "_markerText", "_markerBrush", "_markerAlpha"];

		_markers = _this;
		{
			_markerType = markerType _x;
			_markerPos = markerPos _x;
			_markerSize = markerSize _x;
			_markerShape = markerShape _x;
			_markerDir = markerDir _x;
			_markerColor = markerColor _x;
			_markerBrush = markerBrush _x;
			_markerAlpha = markerAlpha _x;
			_markerText = markerText _x;

			_x setMarkerType _markerType;
			_x setMarkerPos _markerPos;
			_x setMarkerSize _markerSize;
			_x setMarkerShape _markerShape;
			_x setMarkerDir _markerDir;
			_x setMarkerColor _markerColor;
			_x setMarkerBrush _markerBrush;
			_x setMarkerAlpha _markerAlpha;
			_x setMarkerTextLocal _markerText;

		} forEach _markers;
	};