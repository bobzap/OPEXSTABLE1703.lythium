// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_officialCommonTasks", "_officialDedicatedTasks", "_customedTasks", "_index"];

// =========================================================================================================
// LIST OF ALL OFFICIAL TASKS
// =========================================================================================================

	// COMMON TASKS (COMPATIBLE WITH ALL MAPS)
	_officialCommonTasks =
		[
			["00", "", localize "STR_taskObjective_00", localize "STR_taskObjective_00", localize "STR_taskOverview_00", ""],
			["01", "tasks\01.sqf", localize "STR_taskObjective_01", localize "STR_taskObjective_01", localize "STR_taskOverview_01", localize "STR_taskBriefing_01"],
			["02", "tasks\02.sqf", localize "STR_taskObjective_02", localize "STR_taskObjective_02", localize "STR_taskOverview_02", localize "STR_taskBriefing_02"],
			["03", "tasks\03.sqf", localize "STR_taskObjective_03", localize "STR_taskObjective_03", localize "STR_taskOverview_03", localize "STR_taskBriefing_03"],
			["04", "tasks\04.sqf", localize "STR_taskObjective_04", localize "STR_taskObjective_04", localize "STR_taskOverview_04", localize "STR_taskBriefing_04"],
			["05", "tasks\05.sqf", localize "STR_taskObjective_05", localize "STR_taskObjective_05", localize "STR_taskOverview_05", localize "STR_taskBriefing_05"],
			["06", "tasks\06.sqf", localize "STR_taskObjective_06", localize "STR_taskObjective_06", localize "STR_taskOverview_06", localize "STR_taskBriefing_06"],
			["07", "tasks\07.sqf", localize "STR_taskObjective_07", localize "STR_taskObjective_07", localize "STR_taskOverview_07", localize "STR_taskBriefing_07"],
			["08", "tasks\08.sqf", localize "STR_taskObjective_08", localize "STR_taskObjective_08", localize "STR_taskOverview_08", localize "STR_taskBriefing_08"],
			["09", "tasks\09.sqf", localize "STR_taskObjective_09", localize "STR_taskObjective_09", localize "STR_taskOverview_09", localize "STR_taskBriefing_09"],
			["10", "tasks\10.sqf", localize "STR_taskObjective_10", localize "STR_taskObjective_10", localize "STR_taskOverview_10", localize "STR_taskBriefing_10"],
			["11", "tasks\11.sqf", localize "STR_taskObjective_11", localize "STR_taskObjective_11", localize "STR_taskOverview_11", localize "STR_taskBriefing_11"],
			["12", "tasks\12.sqf", localize "STR_taskObjective_12", localize "STR_taskObjective_12", localize "STR_taskOverview_12", localize "STR_taskBriefing_12"],
			["13", "tasks\13.sqf", localize "STR_taskObjective_13", localize "STR_taskObjective_13", localize "STR_taskOverview_13", localize "STR_taskBriefing_13"],
			["14", "tasks\14.sqf", localize "STR_taskObjective_14", localize "STR_taskObjective_14", localize "STR_taskOverview_14", localize "STR_taskBriefing_14"],
			["15", "tasks\15.sqf", localize "STR_taskObjective_15", localize "STR_taskObjective_15", localize "STR_taskOverview_15", localize "STR_taskBriefing_15"],
			["16", "tasks\16.sqf", localize "STR_taskObjective_16", localize "STR_taskObjective_16", localize "STR_taskOverview_16", localize "STR_taskBriefing_16"],
			["17", "tasks\17.sqf", localize "STR_taskObjective_17", localize "STR_taskObjective_17", localize "STR_taskOverview_17", localize "STR_taskBriefing_17"],
			["18", "tasks\18.sqf", localize "STR_taskObjective_18", localize "STR_taskObjective_18", localize "STR_taskOverview_18", localize "STR_taskBriefing_18"],
			["19", "tasks\19.sqf", localize "STR_taskObjective_19", localize "STR_taskObjective_19", localize "STR_taskOverview_19", localize "STR_taskBriefing_19"],
			//["20", "tasks\20.sqf", localize "STR_taskObjective_20", localize "STR_taskObjective_20", localize "STR_taskOverview_20", localize "STR_taskBriefing_20"],
			["21", "tasks\21.sqf", localize "STR_taskObjective_21", localize "STR_taskObjective_21", localize "STR_taskOverview_21", localize "STR_taskBriefing_21"],
			["22", "tasks\22.sqf", localize "STR_taskObjective_22", localize "STR_taskObjective_22", localize "STR_taskOverview_22", localize "STR_taskBriefing_22"]
		];

	// DEDICATED TASKS (COMPATIBLE WITH SPECIFIC MAPS ONLY)
	_officialDedicatedTasks = [];

		// FATA
		if (worldName == "fata") then
			{
				_officialDedicatedTasks =
						[
							["FATA_01", "tasks\FATA_01.sqf", localize "STR_taskObjective_FATA_01", localize "STR_taskObjective_FATA_01", localize "STR_taskOverview_FATA_01", localize "STR_taskBriefing_FATA_01"]
						];
			};

// =========================================================================================================
// LIST OF ALL CUSTOMED UNOFFICIAL TASKS
// =========================================================================================================

	// LIST ALL YOUR CUSTOMED TASKS BELOW - SEE EXAMPLES AND OFFICIAL TASK LIST TO GET THE IDEA
	// EXAMPLE 1: [task ID, task path, task description, task objective, task short overview, task detailed briefing]
	// EXAMPLE 2: ["01", "tasks\01.sqf","Kill an enemy officer", "Kill the officer", "An enemy officer has been spotted. You must kill him.", "Write your detailed briefing here."]
	// NOTE: each task must be closed by "," except the last one !

	_customedTasks =
		[
			// START OF YOUR CUSTOMED task LIST



			// END OF YOUR CUSTOMED task LIST
		];


// =========================================================================================================
// COMPILING ALL OFFICIAL + CUSTOMED TASKS
// =========================================================================================================

	OPEX_tasks = _officialCommonTasks + _officialDedicatedTasks + _customedTasks;
	//waitUntil {!isNil "OPEX_succeededTasks"};
	if (isNil "OPEX_succeededTasks") then {OPEX_succeededTasks = 0};
	if (isServer) then {OPEX_remainingTasks = (count OPEX_tasks) - 1 - OPEX_succeededTasks; publicVariable "OPEX_remainingTasks"};

// =========================================================================================================
// INITIALIZING TASK STATE
// =========================================================================================================

	if (isServer)
		then
			{
				_index = 1;
				for "_i" from 1 to (count OPEX_tasks - 1) do
					{
						missionNamespace setVariable [(OPEX_tasks select _index select 0), false, true];
						_index = _index + 1;
					};
			};