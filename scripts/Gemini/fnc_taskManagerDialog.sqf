// =========================================================================================================
// PRIVATIZING VARIABLE(S)
// =========================================================================================================

	private
		[
			"_caller",
			"_taskManager", "_taskManagerMainTitle", "_taskListTitle", "_taskList", "_taskOverviewTitle", "_taskOverview", "_start", "_close",
			"_task", "_index", "_line", "_taskPath", "_taskID", "_randomTask", "_availableTasks", "_taskAvailable"
		];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	_caller = _this select 1;

// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================

	_taskManager = 2000;
	_taskManagerMainTitle = 2001;
	_taskListTitle = 2300;
	_taskList = 2301;
	_taskOverviewTitle = 2400;
	_taskOverview = 2401;
	_close = 2004;
	_cancel = 2005;
	_start = 2006;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if (isNil "OPEX_params_ready") exitWith {hint "Mission is still initializing... Please, try again later."};
	if (!OPEX_params_ready) exitWith {hint "Mission is still initializing... Please, try again later."};
	if ((isMultiplayer) && (OPEX_param_taskManagement == 0) && (!(serverCommandAvailable "#kick"))) exitWith {hint localize "STR_hint_adminOnly"};
	if ((isMultiplayer) && (OPEX_param_taskManagement == 1) && (leader _caller != _caller)) exitWith {hint localize "STR_hint_leaderOnly"};


// =========================================================================================================
// SELECTING TASK
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_taskManager";
		ctrlSetText [_taskManagerMainTitle, toUpper localize "STR_dialog_taskManagerMainTitle"];

	// LISTING & DISPLAYING TASKS
		ctrlSetText [_taskListTitle, toUpper localize "STR_dialog_taskManagerListTitle"];
		_task = lbAdd [_taskList, (OPEX_tasks select 0 select 2)];
		_index = 1;
		for "_i" from 1 to (count OPEX_tasks - 1) do
			{
				_task = lbAdd [_taskList, (OPEX_tasks select _index select 2)];
				// ADDING A LOGO IF MISSION HAS BEEN SUCCEEDED
					if (!(missionNamespace getVariable (OPEX_tasks select _index select 0)))
					then {lbSetPicture [_taskList, _task, "pictures\taskAvailable.paa"]; lbSetPictureColor [_taskList, _task, [0.0, 0.0, 0.0, 0.0]]; lbSetPictureColorSelected [_taskList, _task, [0.0, 0.0, 0.0, 0.0]]}
					else {lbSetPicture [_taskList, _task, "pictures\taskSucceeded.paa"]; lbSetPictureColor [_taskList, _task, [0.0, 0.0, 0.0, 0.0]]; lbSetPictureColorSelected [_taskList, _task, [0.0, 0.0, 0.0, 0.0]]};
				// ADDING A LOGO TO CURRENT ASSIGNED TASK
					if ((OPEX_tasks select _index select 0) == OPEX_taskID) then {lbSetPicture [_taskList, _task, "pictures\taskAssigned.paa"]};
				// CHANGING COLOR OF CURRENT ASSIGNED TASK
					if ((OPEX_tasks select _index select 0) == OPEX_taskID) then {lbSetColor [_taskList, _task, [0.75, 0.4, 0.0, 1.0]]};
				_index = _index + 1;
			};
		lbSort ((findDisplay _taskManager) displayCtrl _taskList);

	// DISPLAYING OVERVIEWS
		ctrlSetText [_taskOverviewTitle, toUpper localize "STR_dialog_taskManagerOverviewTitle"];

	// DISPLAYING BUTTONS
		ctrlSetText [_close, toUpper localize "STR_dialog_close"];
		ctrlSetText [_cancel, toUpper localize "STR_dialog_cancel"];
		ctrlSetText [_start, toUpper localize "STR_dialog_start"];
		validation = false;
		buttonSetAction [_close, "closeDialog 0"];
		buttonSetAction 
		[
			_cancel, 
			"
				if ((OPEX_assignedTask) && (OPEX_taskDescription isEqualTo [])) exitWith {hint localize 'STR_hint_taskAssigning'};
				if ((OPEX_assignedTask) && (!(OPEX_taskDescription isEqualTo []))) then {closeDialog 0; [] remoteExec ['Gemini_fnc_taskCanceled']};
				if (!OPEX_assignedTask) then {hint localize 'STR_hint_noTaskAssigned'};
				"
		];
		buttonSetAction [_start, "if (OPEX_assignedTask) then {hint localize 'STR_hint_assignedTask'} else {validation = true}"];

	// SETTING DIALOG INTERFACE
		while {dialog} do
			{
				_line = lbCurSel _taskList;
				if (_line == -1) then {lbSetCurSel [_taskOverview, 0]};
			// DISPLAYING TASK OVERVIEW
				_index = 0;
				for "_i" from 1 to (count OPEX_tasks) do
					{
						if ((OPEX_tasks select _index select 2) == lbText [_taskList, _line]) then {ctrlSetText [_taskOverview, (OPEX_tasks select _index select 4)]};
						_index = _index + 1;
					};

			// GETTING TASK ID & PATH
				if (_line == -1 && validation) then {hint localize "STR_hint_noTaskSelected"; validation = false};
				if (_line == 0 && validation) then {closeDialog 0; _taskPath = (OPEX_tasks select 0 select 1)};
				if (_line > 0 && validation) then
					{
						closeDialog 0;
						_taskAvailable = true;
						_index = 1;
						for "_i" from 1 to (count OPEX_tasks - 1) do
							{
								if ((OPEX_tasks select _index select 2) == lbText [_taskList, _line]) then {_taskID = (OPEX_tasks select _index select 0); _taskPath = (OPEX_tasks select _index select 1)};
								_index = _index + 1;
							};
					};
				sleep 0.1; // tempo to save CPU
			};

	// IF NO TASK HAS BEEN SELECTED, EXITING
		if (isNil "_taskPath") exitWith {};

	// IF REQUESTED, LOOKING FOR A RANDOM TASK
		if (_taskPath == "") then
			{
				_availableTasks = [];
				_index = 1;
				for "_i" from 1 to (count OPEX_tasks - 1) do {if (!(missionNamespace getVariable (OPEX_tasks select _index select 0))) then {_availableTasks = _availableTasks + [OPEX_tasks select _index]}; _index = _index + 1};

				// CHECKING IF THERE ARE AVAILABLE TASKS - IF NOT, IT'S THE END
					if (count _availableTasks == 0) exitWith {_taskAvailable = false; ["scripts\Gemini\sqf_outro.sqf"] remoteExec ["BIS_fnc_execVM"]};

				// IF THERE ARE STILL AVAILABLE TASKS, SELECTING A RANDOM ONE
					_randomTask = selectRandom _availableTasks;
					_taskID = _randomTask select 0;
					_taskPath = _randomTask select 1;
					_taskAvailable = true;
			};

// =========================================================================================================
// CREATING TASK
// =========================================================================================================

	if ((_taskAvailable) && (!OPEX_assignedTask)) then {[[_taskID], _taskPath] remoteExec ["BIS_fnc_execVM"]};