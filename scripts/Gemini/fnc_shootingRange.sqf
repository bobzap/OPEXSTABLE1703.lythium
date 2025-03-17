private _action = param [0, "down", [""]];
private _delay = param [1, 5, [5]];

// GETTING TARGETS
OPEX_shootingRange_targetsEnemies = (allMissionObjects "all") select {typeOf _x == "Target_PopUp4_Moving_F"};
OPEX_shootingRange_targetsHostages = (allMissionObjects "all") select {(typeOf _x == "Hostage_PopUp_Moving_F") || (typeOf _x == "Hostage_PopUp2_Moving_F")};
private _targets = OPEX_shootingRange_targetsEnemies + OPEX_shootingRange_targetsHostages;
if (count _targets == 0) exitWith {};

// SHUFFLING TARGETS
OPEX_shootingRange_targetsEnemies = OPEX_shootingRange_targetsEnemies call BIS_fnc_arrayShuffle;
OPEX_shootingRange_targetsHostages = OPEX_shootingRange_targetsHostages call BIS_fnc_arrayShuffle;

// SELECTING ACTION
switch (_action) do
	{
		// LOWER TARGETS
		case "down" :
			{
				{_x animate ["terc", 1]} forEach _targets;
			};

		// RAISE TARGETS
		case "up" :
			{
				{_x animate ["terc", 0]} forEach _targets;
			};

		// STARTING PROGRAM
		case "start" :
			{
				// INITIALIZING PROGRAM
				missionNamespace setVariable ["OPEX_shootingRange", false, true];
				private _enemiesCount = 10;
				OPEX_shootingRange_enemiesDown = 0;
				OPEX_shootingRange_hostagesDown = 0;
				{
					_x animate ["terc", 1];
					_x addEventHandler
						[
							"HitPart",
							{
								if (((_this select 0 select 0) in OPEX_shootingRange_targetsEnemies) && ((_this select 0 select 0) animationPhase "terc" == 0)) then {OPEX_shootingRange_targetsEnemies = OPEX_shootingRange_targetsEnemies - [_this select 0 select 0]; OPEX_shootingRange_enemiesDown = OPEX_shootingRange_enemiesDown + 1};
								if (((_this select 0 select 0) in OPEX_shootingRange_targetsHostages) && ((_this select 0 select 0) animationPhase "terc" == 0)) then {OPEX_shootingRange_targetsHostages = OPEX_shootingRange_targetsHostages - [_this select 0 select 0]; OPEX_shootingRange_hostagesDown = OPEX_shootingRange_hostagesDown + 1};
								(_this select 0 select 0) animate ["terc", 1];
								(_this select 0 select 0) removeAllEventHandlers "HitPart";
							}
						];
				} forEach _targets;
				hint localize "STR_hint_shootingRange_getReady";
				private _bells = (allMissionObjects "all") select {typeOf _x == "Land_MysteriousBell_01_F"};
				if (count _bells > 0) then {(_bells select 0) animateSource ["RingTheBell", 1]};
				sleep 10;
				hint localize "STR_hint_shootingRange_go";
				sleep 3;

				// SPAWNING 10 ENEMIES
				_delay spawn
					{
						for "_i" from 0 to 9 do
							{
								sleep 1;
								(OPEX_shootingRange_targetsEnemies select 0) animate ["terc", 0];
								sleep _this;
								if ((OPEX_shootingRange_targetsEnemies select 0) animationPhase "terc" == 0) then {(OPEX_shootingRange_targetsEnemies select 0) animate ["terc", 1]; OPEX_shootingRange_targetsEnemies = OPEX_shootingRange_targetsEnemies - [OPEX_shootingRange_targetsEnemies select 0]};
							};
					};

				// SPAWNING 3 HOSTAGES/CIVILIANS
				_delay spawn
					{
						sleep _this;
						for "_i" from 0 to 2 do
							{
								sleep (_this + (random _this));
								(OPEX_shootingRange_targetsHostages select 0) animate ["terc", 0];
								sleep _this;
								if ((OPEX_shootingRange_targetsHostages select 0) animationPhase "terc" == 0) then {(OPEX_shootingRange_targetsHostages select 0) animate ["terc", 1]; OPEX_shootingRange_targetsHostages = OPEX_shootingRange_targetsHostages - [OPEX_shootingRange_targetsHostages select 0]};
							};
					};

				sleep (12 + (_delay * 10));
				// DISPLAYING RESULT
				(_bells select 0) animateSource ["RingTheBell", 0];
				missionNamespace setVariable ["OPEX_shootingRange", true, true];
				private _comment = "";
				if (OPEX_shootingRange_hostagesDown > 0) then {_comment = localize "STR_hint_shootingRange_comment_watchYourFire"};
				if ((OPEX_shootingRange_enemiesDown < _enemiesCount * 0.5) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_awfull"};
				if ((OPEX_shootingRange_enemiesDown >= _enemiesCount * 0.5) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_poor"};
				if ((OPEX_shootingRange_enemiesDown >= _enemiesCount * 0.6) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_unsatisfying"};
				if ((OPEX_shootingRange_enemiesDown >= _enemiesCount * 0.7) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_notbad"};
				if ((OPEX_shootingRange_enemiesDown >= _enemiesCount * 0.8) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_nice"};
				if ((OPEX_shootingRange_enemiesDown >= _enemiesCount * 0.9) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_verynice"};
				if ((OPEX_shootingRange_enemiesDown == _enemiesCount) && (OPEX_shootingRange_hostagesDown == 0)) then {_comment = localize "STR_hint_shootingRange_comment_perfect"};
				hint format [localize "STR_hint_shootingRange_result", OPEX_shootingRange_enemiesDown, _enemiesCount, round (OPEX_shootingRange_enemiesDown / _enemiesCount * 100), "%", OPEX_shootingRange_hostagesDown, toUpper _comment];
			};
	};