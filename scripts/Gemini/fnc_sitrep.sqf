// =========================================================================================================
// SETTING DATA
// =========================================================================================================

// MISSION
	private ["_MISSION_TITLE", "_missionVersion"];
	_MISSION_TITLE = format ["<t size='3' align='right' color='#FFFFFF' >" + localize "STR_onLoadName" + "</t>"];
	_missionVersion = format [localize "STR_hint_sitrep_version" + " : " + "%1", OPEX_version];

// SERVER
	private ["_SERVER_TITLE", "_serverName", "_countPlayers", "_serverTime", "_playerTime", "_time"];
	_SERVER_TITLE = format ["<t size='1.2' align='right'>" + localize "STR_hint_sitrep_serverInfo" + "</t>"];
	_serverName = format [localize "STR_hint_sitrep_serverName" + " : %1", if (isMultiplayer) then {serverName} else {localize "STR_hint_sitrep_serverNameSP"}];
	_countPlayers = format [localize "STR_hint_sitrep_countPlayers" + " : %1", (count (allPlayers - entities "HeadlessClient_F"))];
	_serverTime = format [localize "STR_hint_sitrep_serverTime" + " : " + "%1", if (isMultiplayer) then {[serverTime, "HH:MM:SS"] call BIS_fnc_secondsToString} else {[time, "HH:MM:SS"] call BIS_fnc_secondsToString}];
	//_playerTime = format ["%1" + " : " + "%2", name player, [time, "HH:MM:SS"] call BIS_fnc_secondsToString];

// SITUATION
	private ["_SITUATION_TITLE", "_situation_location", "_situation_friend", "_situation_enemy"];
	_SITUATION_TITLE = format ["<t size='1.2' align='right'>" + localize "STR_hint_sitrep_situation" + "</t>"];
	_situation_location = format [localize "STR_hint_sitrep_situation_location" + " : %1, %2", localize OPEX_mapCountry, localize OPEX_mapLocality];
	_situation_friend = format [localize "STR_hint_sitrep_situation_friend" + " : %1", localize OPEX_friendly_subFaction];
	_situation_enemy = format [localize "STR_hint_sitrep_situation_enemy" + " : %1", localize OPEX_enemy_factionName4];

// ACTIVITY
	private ["_ACTIVITY_TITLE", "_activity_reputation", "_activity_gatheredIntel", "_activity_destroyedCaches", "_activity_disarmedIEDs", "_activity_destroyedIEDs", "_activity_jailedHostiles", "_activity_jailedFriends", "_activity_killedCivilians", "_activity_killedEnemies", "_activity_killedFriends", "_activity_killedPlayers"];
	private ["_activity_injuredCivilians", "_activity_injuredEnemies", "_activity_injuredFriends"];
	_ACTIVITY_TITLE = format ["<t size='1.2' align='right'>" + localize "STR_hint_sitrep_activity" + "</t>"];
	_activity_reputation = format [localize "STR_hint_sitrep_situation_reputation" + " : %1", (call Gemini_fnc_reputation) select 1];
	_activity_gatheredIntel = format [localize "STR_hint_sitrep_intel" + " : %1 (%2)", OPEX_stats_faction select 14, OPEX_stats_player select 14];
	_activity_destroyedCaches = format [localize "STR_hint_sitrep_destroyedCaches" + " : %1 (%2)", OPEX_stats_faction select 13, OPEX_stats_player select 13];
	_activity_disarmedIEDs = format [localize "STR_hint_sitrep_disarmedIEDs" + " : %1 (%2)", OPEX_stats_faction select 11, OPEX_stats_player select 11];
	_activity_destroyedIEDs = format [localize "STR_hint_sitrep_destroyedIEDs" + " : %1 (%2)", OPEX_stats_faction select 12, OPEX_stats_player select 12];
	_activity_jailedHostiles = format [localize "STR_hint_sitrep_jailedHostiles" + " : %1 (%2)", OPEX_stats_faction select 6, OPEX_stats_player select 6];
	_activity_jailedFriends = format [localize "STR_hint_sitrep_jailedFriends" + " : %1 (%2)", OPEX_stats_faction select 7, OPEX_stats_player select 7];
	_activity_injuredCivilians = format [localize "STR_hint_sitrep_injuredCivilians" + " : %1 (%2)", OPEX_stats_faction select 4, OPEX_stats_player select 4];
	//_activity_injuredEnemies = format [localize "STR_hint_sitrep_injuredEnemies" + " : %1 (%2)", OPEX_stats_faction select 3, OPEX_stats_player select 3];
	//_activity_injuredFriends = format [localize "STR_hint_sitrep_injuredFriends" + " : %1 (%2)", OPEX_stats_faction select 5, OPEX_stats_player select 5];
	_activity_killedCivilians = format [localize "STR_hint_sitrep_killedCivilians" + " : %1 (%2)", OPEX_stats_faction select 1, OPEX_stats_player select 1];
	_activity_killedEnemies = format [localize "STR_hint_sitrep_killedEnemies" + " : %1 (%2)", OPEX_stats_faction select 0, OPEX_stats_player select 0];
	_activity_killedFriends = format [localize "STR_hint_sitrep_killedFriends" + " : %1 (%2)", OPEX_stats_faction select 2, OPEX_stats_player select 2];
	_activity_killedPlayers = format [localize "STR_hint_sitrep_killedPlayers" + " : %1 (%2)", OPEX_stats_faction select 15, OPEX_stats_player select 15];

// TASKS
	private ["_TASKS_TITLE", "_task", "_succeededTasks", "_failedTasks", "_canceledTasks", "_remainingTasks", "_currentTask"];
	_TASKS_TITLE = format ["<t size='1.2' align='right'>" + localize "STR_hint_sitrep_tasks" + "</t>"];
	_task = [];
	if (!isNil "OPEX_task") then {_task = OPEX_taskDescription};
	if ((isNil "OPEX_task") && (!OPEX_assignedTask)) then {_task = localize "STR_hint_sitrep_noTask"};
	if ((isNil "OPEX_task") && (OPEX_assignedTask)) then {_task = localize "STR_hint_sitrep_taskCreation"};
	_succeededTasks = format [localize "STR_hint_sitrep_succeededTasks" + " : " + "%1 (%2)", OPEX_stats_faction select 8, OPEX_stats_player select 8];
	_failedTasks = format [localize "STR_hint_sitrep_failedTasks" + " : " + "%1 (%2)", OPEX_stats_faction select 9, OPEX_stats_player select 9];
	_canceledTasks = format [localize "STR_hint_sitrep_canceledTasks" + " : " + "%1 (%2)", OPEX_stats_faction select 10, OPEX_stats_player select 10];
	_remainingTasks = format [localize "STR_hint_sitrep_remainingTasks" + " : " + "%1", OPEX_remainingTasks];
	_currentTask = format [localize "STR_hint_sitrep_currentTask" + " : " + "%1", _task];

// NOTICE
	private ["_notice"];
	_notice = format ["<t size='0.7' align='right'>" + localize "STR_hint_sitrep_notice" + "</t>"];

// =========================================================================================================
// DISPLAYING DATA
// =========================================================================================================

	hint parseText
		(
			"<t size='1' align='right' font='PuristaMedium'>"
										+
				_MISSION_TITLE
										+ "<br/>" +
					_missionVersion
										+ "<br/>" + "<br/>" +
				_SERVER_TITLE
										+ "<br/>" +
					_serverName
										+ "<br/>" +
					_countPlayers
										+ "<br/>" +
					_serverTime
					//					+ "<br/>" +
					//_playerTime
										+ "<br/>" + "<br/>" +
				_SITUATION_TITLE
										+ "<br/>" +
					_situation_location
										+ "<br/>" +
					_situation_friend
										+ "<br/>" +
					_situation_enemy
										+ "<br/>" + "<br/>" +
				_ACTIVITY_TITLE
										+ "<br/>" +
					_activity_reputation
										+ "<br/>" +
					_activity_gatheredIntel
										+ "<br/>" +
					_activity_destroyedCaches
										+ "<br/>" +
					_activity_disarmedIEDs
										+ "<br/>" +
					_activity_destroyedIEDs
										+ "<br/>" +
					_activity_jailedHostiles
										+ "<br/>" +
					_activity_jailedFriends
										+ "<br/>" +
					_activity_injuredCivilians
										+ "<br/>" +
					_activity_killedCivilians
										+ "<br/>" +
					_activity_killedEnemies
										+ "<br/>" +
					_activity_killedFriends
										+ "<br/>" +
					_activity_killedPlayers
										+ "<br/>" + "<br/>" +
				_TASKS_TITLE
										+ "<br/>" +
					_succeededTasks
										+ "<br/>" +
					_failedTasks
										+ "<br/>" +
					_canceledTasks
										+ "<br/>" +
					_remainingTasks
										+ "<br/>" +
					_currentTask


										+ "<br/>" + "<br/>" +
					_notice

			+ "</t>"
		);