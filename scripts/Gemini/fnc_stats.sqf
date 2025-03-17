// INITIALIZING FACTION STATS
Gemini_fnc_initStatsFaction =
	{
		// EXAMPLE
		// [] remoteExecCall ["Gemini_fnc_initStatsFaction", 2];

		OPEX_stats_killedEnemies = 0;

		// FACTION STATS
		OPEX_stats_faction =
			[
				0, // enemies killed		(0)
				0, // civilians killed		(1)
				0, // friends killed		(2)
				0, // enemies hit			(3)
				0, // civilians hit			(4)
				0, // friends hit			(5)
				0, // enemies jailed		(6)
				0, // civilians jailed		(7)
				0, // tasks succeeded		(8)
				0, // tasks failed			(9)
				0, // tasks canceled		(10)
				0, // IEDs disarmed			(11)
				0, // IEDs destroyed		(12)
				0, // caches destroyed		(13)
				0, // gathered intel		(14)
				0, // player deaths			(15)
				0, // searched civilians	(16)
				0, // hancuffed civilians	(17)
				1  // reputation bonus		(18)
			];
		publicVariable "OPEX_stats_faction";
	};

// INITIALIZING PLAYER STATS
Gemini_fnc_initStatsPlayer =
	{
		// EXAMPLE
		// [unit] remoteExecCall ["Gemini_fnc_initStatsPlayer", unit];

		// PLAYER STATS
		OPEX_stats_player =
			[
				0, // enemies killed	(0)
				0, // civilians killed	(1)
				0, // friends killed	(2)
				0, // enemies hit		(3)
				0, // civilians hit		(4)
				0, // friends hit		(5)
				0, // enemies jailed	(6)
				0, // civilians jailed	(7)
				0, // tasks succeeded	(8)
				0, // tasks failed		(9)
				0, // tasks canceled	(10)
				0, // IEDs disarmed		(11)
				0, // IEDs destroyed	(12)
				0, // caches destroyed	(13)
				0, // gathered intel	(14)
				0  // player deaths		(15)
			];
	};

// UPDATING FACTION STATS
Gemini_fnc_updateStatsFaction =
	{
		// EXAMPLES
		// ["enemyKilled", killedUnit] remoteExecCall ["Gemini_fnc_updateStatsFaction", 2];
		// ["taskSucceeded"] remoteExecCall ["Gemini_fnc_updateStatsFaction", 2];

		// GETTING ARGUMENTS
		private ["_stats", "_eventHandler"];
		_stats = _this select 0;
		if (count _this > 1) then {_eventHandler = _this select 1};

		// UPDATING STATS
		switch _stats do
			{
				case "enemyKilled"			: 	{OPEX_stats_faction set [0, (OPEX_stats_faction select 0) + 1]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["killed", 0]}};
				case "civilianKilled"		: 	{OPEX_stats_faction set [1, (OPEX_stats_faction select 1) + 1]; OPEX_stats_faction set [18, (OPEX_stats_faction select 18) - 0.5]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["killed", 0]}};
				case "friendKilled"			: 	{OPEX_stats_faction set [2, (OPEX_stats_faction select 2) + 1]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["killed", 0]}};
				case "enemyHit"				: 	{OPEX_stats_faction set [3, (OPEX_stats_faction select 3) + 1]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["hit", 0]}};
				case "civilianHit"			: 	{OPEX_stats_faction set [4, (OPEX_stats_faction select 4) + 1]; OPEX_stats_faction set [18, (OPEX_stats_faction select 18) - 0.2]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["hit", 0]}};
				case "friendHit"			: 	{OPEX_stats_faction set [5, (OPEX_stats_faction select 5) + 1]; if (!isNil "_eventHandler") then {_eventHandler removeEventHandler ["hit", 0]}};
				case "enemyJailed"			: 	{OPEX_stats_faction set [6, (OPEX_stats_faction select 6) + 1]};
				case "civilianJailed"		: 	{OPEX_stats_faction set [7, (OPEX_stats_faction select 7) + 1]};
				case "taskSucceeded"		: 	{OPEX_stats_faction set [8, (OPEX_stats_faction select 8) + 1]};
				case "taskFailed"			: 	{OPEX_stats_faction set [9, (OPEX_stats_faction select 9) + 1]};
				case "taskCanceled"			: 	{OPEX_stats_faction set [10, (OPEX_stats_faction select 10) + 1]};
				case "IEDdisarmed"			: 	{OPEX_stats_faction set [11, (OPEX_stats_faction select 11) + 1]};
				case "IEDdestroyed"			: 	{OPEX_stats_faction set [12, (OPEX_stats_faction select 12) + 1]};
				case "cacheDestroyed"		: 	{OPEX_stats_faction set [13, (OPEX_stats_faction select 13) + 1]};
				case "gatheredIntel"		: 	{OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + 1]};
				case "playerKilled"			: 	{OPEX_stats_faction set [15, (OPEX_stats_faction select 15) + 1]};
				case "civilianSearched"		: 	{OPEX_stats_faction set [16, (OPEX_stats_faction select 16) + 1]};
				case "civilianHandcuffed"	: 	{OPEX_stats_faction set [17, (OPEX_stats_faction select 17) + 1]};
				default 						{};
			};
		publicVariable "OPEX_stats_faction";
	};

// UPDATING PLAYER STATS
Gemini_fnc_updateStatsPlayer =
	{
		// EXAMPLE
		// [unit] remoteExecCall ["Gemini_fnc_updateStatsPlayer", unit];

		// GETTING ARGUMENTS
		private _stats = _this select 0;
		private ["_eventHandler"];
		if (count _this > 1) then {_eventHandler = _this select 1};

		// UPDATING STATS
		switch _stats do
			{
				case "enemyKilled"		: 	{if (_eventHandler select 2 == player) then {OPEX_stats_player set [0, (OPEX_stats_player select 0) + 1]}};
				case "civilianKilled"	: 	{if (_eventHandler select 2 == player) then {OPEX_stats_player set [1, (OPEX_stats_player select 1) + 1]}};
				case "friendKilled"		: 	{if (_eventHandler select 2 == player) then {OPEX_stats_player set [2, (OPEX_stats_player select 2) + 1]}};
				case "enemyHit"			: 	{if (_eventHandler select 3 == player) then {OPEX_stats_player set [3, (OPEX_stats_player select 3) + 1]}};
				case "civilianHit"		: 	{if (_eventHandler select 3 == player) then {OPEX_stats_player set [4, (OPEX_stats_player select 4) + 1]}};
				case "friendHit"		: 	{if (_eventHandler select 3 == player) then {OPEX_stats_player set [5, (OPEX_stats_player select 5) + 1]}};
				case "enemyJailed"		: 	{OPEX_stats_player set [6, (OPEX_stats_player select 6) + 1]};
				case "civilianJailed"	: 	{OPEX_stats_player set [7, (OPEX_stats_player select 7) + 1]};
				case "taskSucceeded"	: 	{OPEX_stats_player set [8, (OPEX_stats_player select 8) + 1]};
				case "taskFailed"		: 	{OPEX_stats_player set [9, (OPEX_stats_player select 9) + 1]};
				case "taskCanceled"		: 	{OPEX_stats_player set [10, (OPEX_stats_player select 10) + 1]};
				case "IEDdisarmed"		: 	{OPEX_stats_player set [11, (OPEX_stats_player select 11) + 1]};
				case "IEDdestroyed"		: 	{OPEX_stats_player set [12, (OPEX_stats_player select 12) + 1]};
				case "cacheDestroyed"	: 	{OPEX_stats_player set [13, (OPEX_stats_player select 13) + 1]};
				case "gatheredIntel"	: 	{OPEX_stats_player set [14, (OPEX_stats_player select 14) + 1]};
				case "playerKilled"		: 	{if (_eventHandler select 0 == player) then {OPEX_stats_player set [15, (OPEX_stats_player select 15) + 1]}};
				default 					{};
			};
	};

// UPDATING FACTION & PLAYER STATS
Gemini_fnc_updateStats =
	{
		// EXAMPLES
		// ["enemyKilled", eventHandler] call Gemini_fnc_updateStats;
		// ["taskSucceeded"] call Gemini_fnc_updateStats;

		// GETTING ARGUMENTS
		private ["_stats", "_statsr", "_eventHandler"];
		_stats = _this select 0;
		if (count _this > 1) then {_statsr = _this select 1 select 1; _eventHandler = _this select 1 select 0};

		// UPDATING FACTION STATS
		if (isServer) then {if (isNil "_eventHandler") then {[_stats] remoteExecCall ["Gemini_fnc_updateStatsFaction", 2]} else {[_stats, _eventHandler] remoteExecCall ["Gemini_fnc_updateStatsFaction", 2]}};

		// UPDATING PLAYER(S) STATS
		private ["_sharedStats"];
		_sharedStats = ["taskSucceeded", "taskFailed", "taskCanceled", "cacheDestroyed", "IEDdisarmed", "IEDdestroyed", "enemyJailed", "civilianJailed", "gatheredIntel"];
		if (_stats in _sharedStats) then {[_stats] remoteExecCall ["Gemini_fnc_updateStatsPlayer", [0,-2] select isDedicated]} else {if (count _this == 1) then {[_stats] remoteExecCall ["Gemini_fnc_updateStatsPlayer", [0,-2] select isDedicated]} else {[_stats, _this select 1] remoteExecCall ["Gemini_fnc_updateStatsPlayer", [0,-2] select isDedicated]}};
	};