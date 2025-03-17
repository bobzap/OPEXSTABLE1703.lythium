// =========================================================================================================
// CIVILIAN MAIN FUNCTIONS
// =========================================================================================================

	// SETTING MAIN CIVILIAN SETUP
		Gemini_fnc_civilianSettings =
			{
				// CHECKING REQUEST
					if (!isServer) exitWith {};
					private _civilian = param [0, objNull, [objNull]];
					private _disableCivilianHostility = param [1, false, [false]];
					if (isNull _civilian) exitWith {};

				// INITIALIZING CIVILIAN ARREST STATUS
					_civilian setVariable ["isHandcuffed", false, true];
					_civilian setVariable ["isJailed", false, true];

				// SETTING CIVILIAN HOSTILITY & SYMPATHY, ACCORDING TO PLAYERS REPUTATION
					private ["_hostileProbability", "_sympathy"];
					switch ((call Gemini_fnc_reputation) select 1) do
						{
							case (localize "STR_reputation_terrible")	:	{_hostileProbability = 10; _sympathy = random [-100, -50, 100]};
							case (localize "STR_reputation_verybad")	:	{_hostileProbability = 8.5; _sympathy = random [-100, -35, 100]};
							case (localize "STR_reputation_bad")		:	{_hostileProbability = 7; _sympathy = random [-100, -15, 100]};
							case (localize "STR_reputation_neutral")	:	{_hostileProbability = 5; _sympathy = random [-100, 0, 100]};
							case (localize "STR_reputation_good")		:	{_hostileProbability = 4; _sympathy = random [-100, 15, 100]};
							case (localize "STR_reputation_verygood")	:	{_hostileProbability = 3; _sympathy = random [-100, 35, 100]};
							case (localize "STR_reputation_excellent")	:	{_hostileProbability = 2; _sympathy = random [-100, 50, 100]};
							default											{_hostileProbability = 5; _sympathy = random [-100, 0, 100]};
						};

				// SETTING CIVILIAN HOSTILITY
					if ((floor (random 100) < _hostileProbability) && (!_disableCivilianHostility)) then {_civilian setVariable ["side", "hostile", true]; _sympathy = -100} else {_civilian setVariable ["side", "friendly", true]};

				// SETTING CIVILIAN SYMPATHY
					_civilian setVariable ["sympathy", _sympathy, true];

				// SETTING CIVILIAN PROBABILITY TO HAVE INTEL
					if (_civilian getVariable "sympathy" > 25) then {_civilian setVariable ["informer", round random (_civilian getVariable "sympathy"), true]};

				// DEFINING IF CIVILIAN CAN BE AN INFORMER (default: about 30% of the local people) - 0: not an informer - other number: yes (can be positive or negative values)
					if ((_civilian getVariable "side" == "friendly") && (random 1 > 0.70)) then {_civilian setVariable ["informer", random 500, true]; _civilian setVariable ["gatheredIntel", false, true]} else {_civilian setVariable ["informer", random 500, true], _civilian setVariable ["gatheredIntel", true, true]};
					if (((_civilian getVariable "informer") != 0) && (random 1 > 0.5)) then {private ["_neg"]; _neg = -1 * (_civilian getVariable "informer"); _civilian setVariable ["informer", _neg, true]};

				// DEFINING IF CIVILIAN INTEL HAS BEEN RECORDED IN ARMY DATABASE (TO SIMULATE DYNAMIC DB)
					if (floor random 10 < 3) then {_civilian setVariable ["recorded", true, true]} else {_civilian setVariable ["recorded", false, true]};

				// DEFINING CIVILIAN NAME
					private ["_name", "_knownName"];
					_name = [name _civilian];
					if ((_civilian getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_name set [count _name, OPEX_enemy_names call BIS_fnc_selectRandom]}};
					_civilian setVariable ["name", _name, true];
					_civilian setVariable ["known_realName", false, true];
					_civilian setVariable ["known_fakeName", false, true];
					_knownName = ["known_realName", "known_fakeName"] call BIS_fnc_selectRandom;
					if (_civilian getVariable "recorded") then {_civilian setVariable [_knownName, [true, false] call BIS_fnc_selectRandom, true]};

				// DEFINING CIVILIAN NATIONALITY
					private ["_nationality", "_knownNationality"];
					_nationality = [OPEX_mapNationalities call BIS_fnc_selectRandom];
					if ((_civilian getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_nationality set [count _nationality, OPEX_mapNationalities call BIS_fnc_selectRandom]}};
					_civilian setVariable ["nationality", _nationality, true];
					_civilian setVariable ["known_realNationality", false, true];
					_civilian setVariable ["known_fakeNationality", false, true];
					_knownNationality = ["known_realNationality", "known_fakeNationality"] call BIS_fnc_selectRandom;
					if (_civilian getVariable "recorded") then {_civilian setVariable [_knownNationality, [true, false] call BIS_fnc_selectRandom, true]};

				// DEFINING CIVILIAN BIRTHDATE
					private ["_date", "_month", "_year", "_separator", "_birthDate", "_knownBirthdate"];
					_date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
					_month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					_year = ["1995", "1994", "1993", "1992", "1991", "1990", "1989", "1988", "1987", "1986", "1985", "1984", "1983", "1982", "1981", "1980"];
					_separator = "/";
					_birthDate = [(_date call BIS_fnc_selectRandom) + _separator + (_month call BIS_fnc_selectRandom) + _separator + (_year call BIS_fnc_selectRandom)];
					if ((_civilian getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_birthDate set [count _birthDate, (_date call BIS_fnc_selectRandom) + _separator + (_month call BIS_fnc_selectRandom) + _separator + (_year call BIS_fnc_selectRandom)]}};
					_civilian setVariable ["birthdate", _birthDate, true];
					_civilian setVariable ["known_realBirthdate", false, true];
					_civilian setVariable ["known_fakeBirthdate", false, true];
					_knownBirthdate = ["known_realBirthdate", "known_fakeBirthdate"] call BIS_fnc_selectRandom;
					if (_civilian getVariable "recorded") then {_civilian setVariable [_knownBirthdate, [true, false] call BIS_fnc_selectRandom, true]};

				// DEFINING CIVILIAN JOB
					private ["_job", "_knownJob"];
					_job = [OPEX_civilian_jobs call BIS_fnc_selectRandom];
					if ((_civilian getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_job set [count _job, OPEX_civilian_jobs call BIS_fnc_selectRandom]}};
					_civilian setVariable ["job", _job, true];
					_civilian setVariable ["known_realJob", false, true];
					_civilian setVariable ["known_fakeJob", false, true];
					_knownJob = ["known_realJob", "known_fakeJob"] call BIS_fnc_selectRandom;
					if (_civilian getVariable "recorded") then {_civilian setVariable [_knownJob, [true, false] call BIS_fnc_selectRandom, true]};

				// DEFINING IF CIVILIAN IS POLYGLOT - DETERMINING IF HE UNDERSTAND PLAYERS LANGUAGE
					_civilian setVariable ["polyglot", selectRandom [false, false, true], true];

				// DEFINING CIVILIAN INTEL DATABASE - DETERMINING IF HE IS ALREADY KNOWN TO BE HOSTILE
					private ["_intel"];
					if ((_civilian getVariable "side" == "hostile") && (_civilian getVariable "recorded")) then
						{
							_intel =
								[
									"STR_civilian_intel_01", "STR_civilian_intel_02", "STR_civilian_intel_03", "STR_civilian_intel_04", "STR_civilian_intel_05",
									"STR_civilian_intel_06", "STR_civilian_intel_07", "STR_civilian_intel_08", "STR_civilian_intel_09", "STR_civilian_intel_10"
								] call BIS_fnc_selectRandom;
							_civilian setVariable ["intel", [_intel, "STR_civilian_intel_noData"] call BIS_fnc_selectRandom, true];
						}
					else {_civilian setVariable ["intel", "STR_civilian_intel_noData", true]};
			};

	// SETTING CIVILIAN GEAR
		Gemini_fnc_checkCivilianGear =
			{
				// CHECKING REQUEST
					if (!isServer) exitWith {};
					private ["_civilian", "_itemList", "_civilianItems", "_index", "_suspicious"];
					_civilian = [_this, 0, objNull] call BIS_fnc_param;
					if (isNull _civilian) exitWith {};

					_civilian setVariable ["gear", items _civilian, true];

				// CHECKING CIVILIAN GEAR - IF HE HAS ENOUGH SUSPICIOUS ITEMS, RANDOMLY FORCE HIM TO BE HOSTILE
					_suspicious = 0;
					if ("ItemCompass" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) then {_suspicious = _suspicious + 1};
					if ("ItemRadio" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) then {_suspicious = _suspicious + 1};
					if ("Binocular" in (weapons _civilian)) then {_suspicious = _suspicious + 1};
					if ("ItemCompass" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) then {_suspicious = _suspicious + 1};
					if ("Gemini_cellphone" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) then {_suspicious = _suspicious + 1};
					if ("Gemini_deadManSwitch" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) then {_suspicious = _suspicious + 10};
					if ((_suspicious >= 4) && (floor random 10 >= 5)) then {_civilian setVariable ["side", "hostile", true]};
			};

	// MONITORING CIVILIAN MOVES
		Gemini_fnc_civilianMoves =
			{
				private ["_civilian"];
				_civilian = _this select 0;
				if (!isServer) exitWith {};
				while {alive _civilian} do {sleep 0.1; if (speed _civilian > (abs 5)) then {_civilian setVariable ["action", "moving", true]} else {_civilian setVariable ["action", "stopped", true]}};
			};

	// ADDING INTERACTION ACTION TO CIVILIAN
		Gemini_fnc_civilianAction =
			{
				// CHECKING REQUEST
					private ["_civilian"];
					_civilian = [_this, 0, objNull] call BIS_fnc_param;
					if (isDedicated) exitWith {};
					if (isNull _civilian) exitWith {};

				// ADDING ACTIONS TO INTERACT WITH CIVILIAN

					// STOP CIVILIAN
						_civilian addAction
							[
								"<t color=""#FFFFFF"">" + localize "STR_action_suspect_stop" + "</t>",
								{[(_this select 0), (_this select 1)] spawn Gemini_fnc_civilianInteractions_movement_halt},
								nil,
								6,
								true,
								true,
								"",
								"(!captive _this) && (alive _target) && (abs (speed _target) > 0.1) && (_target distance _this < 15) && (!(_civilian getVariable 'isHandcuffed'))"
							];

					// OPEN INTERACTION MENU
						_civilian addAction
							[
								"<t color=""#FFFFFF"">" + localize "STR_action_civilian_interaction" + "</t>",
								"scripts\Gemini\fnc_civilianInteractionsDialog.sqf",
								nil,
								6,
								true,
								true,
								"",
								"(!captive _this) && (alive _target) && (abs (speed _target) < 0.1) && (_target distance _this < 3) && (vehicle _this == _this)"
							];
			};

// =========================================================================================================
// HOSTILE BEHAVIOURS
// =========================================================================================================

	Gemini_fnc_civilianBehaviours =
		{
			if (!isServer) exitWith {};
			private ["_civilian", "_selectedBehaviour", "_explosion"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_selectedBehaviour = selectRandom ["passive", "passive", "passive", "active", "kamikaze"];
			switch (_selectedBehaviour) do
				{
					// PASSIVE ENEMY BEHAVIOUR
						case "passive": {};
					// ACTIVE ENEMY BEHAVIOUR
						case "active":
							{
								private ["_updatedGear", "_trigger", "_condition", "_activation", "_deactivation"];
								_updatedGear = (_civilian getVariable "gear") + ["STR_item_gun"];
								_civilian setVariable ["gear", _updatedGear call BIS_fnc_arrayShuffle, true];
								_trigger = createTrigger ["EmptyDetector", position _civilian];
								_trigger setTriggerArea [75, 75, 0, false];
								_trigger setTriggerActivation [OPEX_friendly_side3, "present", true];
								_trigger setTriggerTimeout [0, 30, 60, false];
								//_condition = format ["({(%1 knowsAbout _x > 0.5) && (vehicle _x distance thisTrigger < 75) && (side _x == OPEX_friendly_side1)} count allUnits > 0) && (!(%1 getVariable 'isHandcuffed'))", _civilian];
								_condition = format ["this && (!(%1 getVariable 'isHandcuffed'))", _civilian];
								_activation = format
									["	if ((alive %1) && (!(%1 getVariable 'isHandcuffed'))) then
											{
												%1 setVariable ['behaviour', -1000, true];
												%1 setVariable ['intel', 'STR_civilian_intel_terroActivity', true];
												%1 doWatch (thisList select 0);
												%1 addMagazine (['9Rnd_45ACP_Mag', '16Rnd_9x21_Mag'] call BIS_fnc_selectRandom);
												if ('9Rnd_45ACP_Mag' in magazines %1) then {%1 addWeapon 'hgun_ACPC2_F'};
												if ('16Rnd_9x21_Mag' in magazines %1) then {%1 addWeapon 'hgun_Rook40_F'};
												[%1, (weapons %1 select 0), (round random 2)] call BIS_fnc_addWeapon;
												closeDialog 0;
												%1 doWatch (thisList select 0);
												%1 setBehaviour 'combat';
												%1 setSpeedMode 'full';
												%1 setCombatMode 'red';
												%1 setUnitPos 'up';
												%1 setSkill ['courage', 1];
												[%1] join GrpNull;
												[%1] join (createGroup OPEX_enemy_side1);
												%1 setDir ([%1, (thisList select 0)] call BIS_fnc_dirTo);
												%1 doTarget (thisList select 0);
												%1 doFire (thisList select 0);
												private ['_voice'];
												_voice = ['AllahuAkbar_1', 'AllahuAkbar_2'] call BIS_fnc_selectRandom;
												deleteVehicle thisTrigger;
											};
										", _civilian
									];
								_deactivation = "";
								_trigger setTriggerStatements [_condition, _activation, _deactivation];
								_trigger attachTo [_civilian, [0,0,0]];
							};
					// KAMIKAZE ENEMY BEHAVIOUR
						case "kamikaze":
							{
								_civilian addEventHandler
									["Hit",
										{
											if ((random 1) < 0.25) then {_explosion = (["Bo_GBU12_LGB_MI10", "Bo_GBU12_LGB", "M_Mo_82mm_AT_LG", "HelicopterExploBig", "R_80mm_HE", "R_TBG32V_F"] call BIS_fnc_selectRandom) createVehicle (position (_this select 0))}
											else {if (true) exitWith {}};
										}
									];
								// RUNNING TO DETECTED ENEMY
									private ["_updatedGear", "_trigger", "_condition", "_activation", "_deactivation"];
									_civilian addVest "V_PlateCarrierIA1_dgtl";
									_updatedGear = (_civilian getVariable "gear") + ["STR_item_charge"];
									_civilian setVariable ["gear", _updatedGear call BIS_fnc_arrayShuffle, true];
									_trigger = createTrigger ["EmptyDetector", position _civilian];
									_trigger setTriggerArea [75, 75, 0, false];
									_trigger setTriggerActivation [OPEX_friendly_side3, "present", true];
									_trigger setTriggerTimeout [0, 15, 30, false];
									_condition = format ["this && (!(%1 getVariable 'isHandcuffed'))", _civilian];
									_activation = format
										["	if ((alive %1) && (!(%1 getVariable 'isHandcuffed'))) then
												{
													%1 setVariable ['behaviour', -1000, true];
													%1 setVariable ['intel', 'STR_civilian_intel_terroActivity', true];
													removeAllActions %1;
													%1 setSpeedMode 'full';
													%1 setUnitPos 'up';
													%1 setSkill ['courage', 1];
													[%1] join GrpNull;
													[%1] join createGroup OPEX_enemy_side1;
													[%1] spawn
															{
																while {alive (_this select 0)} do
																	{
																		private ['_voice'];
																		_voice = ['AllahuAkbar_1', 'AllahuAkbar_2'] call BIS_fnc_selectRandom;
																		(_this select 0) say _voice;
																		sleep 10 + (random 20);
																	}
															};
													[%1, (thisList select 0)] spawn
														{
															while {alive (_this select 0)} do
																{
																	(_this select 0) doMove position (_this select 1);
																	sleep 2;
																	if (((_this select 0) distance (_this select 1) < (random 20)) && (alive (_this select 0))) then
																		{
																			_explosion = (['Bo_GBU12_LGB_MI10', 'Bo_GBU12_LGB', 'M_Mo_82mm_AT_LG', 'HelicopterExploBig', 'R_80mm_HE'] call BIS_fnc_selectRandom) createVehicle (position (_this select 0));
																			deleteVehicle (_this select 0);
																		}
																}
														};
												};
											deleteVehicle thisTrigger;
											", _civilian
										];
									_deactivation = "";
									_trigger setTriggerStatements [_condition, _activation, _deactivation];
									_trigger attachTo [_civilian, [0,0,0]];
							};
				};
		};

// =========================================================================================================
// COMPILING MAIN FUNCTIONS
// =========================================================================================================

	Gemini_fnc_civilianInteractions =
		{
			// CHECKING REQUEST
				private _civilian = param [0, objNull, [objNull]];
				private _disableCivilianHostility = param [1, false, [false]];
				if (isNull _civilian) exitWith {};

			// CALLING FUNCTIONS
				[_civilian, _disableCivilianHostility] call Gemini_fnc_civilianSettings;
				[_civilian] call Gemini_fnc_checkCivilianGear;
				[_civilian] spawn Gemini_fnc_civilianMoves;
				if ((_civilian getVariable "side") == "hostile") then {[_civilian] call Gemini_fnc_civilianBehaviours};
				[_civilian] remoteExec ["Gemini_fnc_civilianAction", 0, _civilian];
		};


// =========================================================================================================
// CALLING INTERACTION FUNCTION
// =========================================================================================================

	// MUST BE CALLED WHERE CIVILIAN IS SPAWNED
		// [_civilian] call Gemini_fnc_civilianInteractions;


// =========================================================================================================
// LIST OF ALL INTERACTIONS
// =========================================================================================================

	Gemini_fnc_civilianInteractions_movement_halt =
		{
			private ["_civilian", "_caller"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_civilian reveal _caller;
			doStop _civilian;
			while {(count (waypoints _civilian)) > 0} do {deleteWaypoint ((waypoints _civilian) select 0); sleep 0.01};
			waitUntil {sleep 3; _civilian distance _caller > 15};
			sleep 5;
			if (!(_civilian getVariable "isHandcuffed")) then
				{
					_civilian doMove (position _civilian);
					[group _civilian, (getPos _civilian), 100] spawn Gemini_fnc_doPatrol;
				};
		};

	Gemini_fnc_civilianInteractions_movement_move =
		{
			private ["_civilian", "_caller"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			if (!(_civilian getVariable "isHandcuffed")) then
				{
					while {(count (waypoints _civilian)) > 0} do {deleteWaypoint ((waypoints _civilian) select 0); sleep 0.01};
					doStop _civilian;
					_civilian reveal _caller;
					closeDialog 0;
					sleep (random 1);
					_civilian enableAI "move";
					_civilian setUnitPos "auto";
					_civilian switchMove "";
					_civilian doMove (position _civilian);
					[group _civilian, _civilian, 100] spawn Gemini_fnc_doPatrol;
				};
		};

	Gemini_fnc_civilianInteractions_conversation =
		{
			private ["_civilian", "_caller", "_conversationID", "_nearestUnits", "_nearestEnemies", "_unit", "_randomNearbyEnemyPosition", "_newPos", "_marker1", "_marker2"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_conversationID = [_this, 2, 0] call BIS_fnc_param;
			_civilian reveal _caller;
			sleep 2;
			if ((_civilian getVariable "polyglot") || (_caller getUnitTrait "interpret") || (count ((_civilian nearEntities ["Man", 10]) select {(alive _x) && (_x getUnitTrait "interpret")}) > 0))
			then
				{
					if (_civilian getVariable "sympathy" >= 0)
					then
						{
							private ["_name", "_nationality", "_birthdate", "_job"];
							if (_conversationID == 1) then
								{
									titleText [[localize ("STR_civilianConversation_1a"), localize ("STR_civilianConversation_1b"), localize ("STR_civilianConversation_1c"), localize ("STR_civilianConversation_1d"), localize ("STR_civilianConversation_1e"), localize ("STR_civilianConversation_1f")] call BIS_fnc_selectRandom, "plain"];
									_civilian setVariable ["sympathy", (_civilian getVariable "sympathy"), true];
								};
							if (_conversationID == 2) then
								{
									_name = selectRandom (_civilian getVariable "name");
									titleText [(localize ("STR_civilianConversation_2") + " " + _name + "."), "plain"];
									if (_name == (_civilian getVariable "name") select 0) then {_civilian setVariable ["known_realName", true, true]} else {_civilian setVariable ["known_fakeName", true, true]};
								};
							if (_conversationID == 3) then
								{
									_nationality = selectRandom (_civilian getVariable "nationality");
									titleText [(localize ("STR_civilianConversation_3") + " " + localize _nationality + "."), "plain"];
									if (_nationality == (_civilian getVariable "nationality") select 0) then {_civilian setVariable ["known_realNationality", true, true]} else {_civilian setVariable ["known_fakeNationality", true, true]};
								};
							if (_conversationID == 4) then
								{
									_birthdate = selectRandom (_civilian getVariable "birthdate");
									titleText [(localize ("STR_civilianConversation_4") + " " + _birthdate + "."), "plain"];
									if (_birthdate == (_civilian getVariable "birthdate") select 0) then {_civilian setVariable ["known_realBirthdate", true, true]} else {_civilian setVariable ["known_fakeBirthdate", true, true]};
								};
							if (_conversationID == 5) then
								{
									_job = selectRandom (_civilian getVariable "job");
									titleText [(localize ("STR_civilianConversation_5") + " " + localize _job + "."), "plain"];
									if (_job == (_civilian getVariable "job") select 0) then {_civilian setVariable ["known_realJob", true, true]} else {_civilian setVariable ["known_fakeJob", true, true]};
								};
							if ((_conversationID == 6) && (OPEX_taskID != "19") && ((_civilian getVariable "side" != "friendly") || ((_civilian getVariable "informer") == 0) || (_civilian getVariable "gatheredIntel"))) then {if ((_civilian getVariable "side" == "friendly") && (_civilian getVariable "gatheredIntel")) then {titleText [selectRandom [localize "STR_civilianConversation_6e", localize "STR_civilianConversation_6f"], "plain"]} else {titleText [selectRandom [localize "STR_civilianConversation_6c", localize "STR_civilianConversation_6d"], "plain"]}};
							if ((_conversationID == 6) && (OPEX_taskID != "19") && (_civilian getVariable "side" == "friendly") && ((_civilian getVariable "informer") != 0)) then
								{
									_nearestUnits = (position _civilian) nearEntities [["Man", "Car", "Tank"], 1000];
									_nearestEnemies = [];
									if (OPEX_enemy_side1 countSide _nearestUnits > 0) then
										{
										   {
												_unit = _x;
												if (side _unit == OPEX_enemy_side1) then {_nearestEnemies = _nearestEnemies + [_unit]};
										   } foreach _nearestUnits;
										};
									if (count _nearestEnemies != 0) then
										{
											_randomNearbyEnemyPosition = position (selectRandom _nearestEnemies);
											private ["_accuracy"];
											_accuracy = _civilian getVariable "informer";
											_newPos = [(_randomNearbyEnemyPosition select 0) + _accuracy, (_randomNearbyEnemyPosition select 1)  + _accuracy, (_randomNearbyEnemyPosition select 2)];
											closeDialog 0;
											openMap true;
											[_civilian, _caller] spawn {waitUntil {sleep 0.1; !visibleMap}; [_this select 0, _this select 1] execVM "scripts\Gemini\fnc_civilianInteractionsDialog.sqf"};
											mapAnimAdd [0, 0.01, position _caller];
											mapAnimCommit;
											sleep 1;
											mapAnimAdd [3, 0.01, _newPos];
											mapAnimCommit;
											sleep 3;
											if (random 1 > 0.5) then {titleText [localize "STR_civilianConversation_6a", "plain"]} else {titleText [localize "STR_civilianConversation_6b", "plain"]};
											hint localize "STR_hint_addMarker";
										};
									if (!(_civilian getVariable "gatheredIntel")) then
										{
											_civilian setVariable ["gatheredIntel", true, true];
											if (count _nearestEnemies == 0) then {sleep (random 3)};
											["gatheredIntel"] call Gemini_fnc_updateStats;
											hint localize "STR_hint_intelGathered";
										};
								};
							// FOR A SPECIFIC TASK ONLY
							if ((_conversationID == 6) && (OPEX_assignedTask) && (OPEX_taskID == "19") && (_civilian getVariable "side" == "friendly") && ((_civilian getVariable "informer") != 0)) then
								{
									_nearestUnits = (getMarkerPos "TaskMarker_A") nearEntities [["Man", "Car", "Tank"], (getMarkerSize "TaskMarker_A" select 0) max (getMarkerSize "TaskMarker_A" select 1)];
									_nearestEnemies = [];
									if (OPEX_enemy_side1 countSide _nearestUnits > 0) then
										{
										   {
												_unit = _x;
												if (side _unit == OPEX_enemy_side1) then {_nearestEnemies = _nearestEnemies + [_unit]};
										   } foreach _nearestUnits;
										};
									if (count _nearestEnemies != 0) then
										{
											private ["_accuracy"];
											_accuracy = _civilian getVariable "informer";
											_newPos = [(getMarkerPos "TaskMarker_A" select 0) + _accuracy, (getMarkerPos "TaskMarker_A" select 1) + _accuracy, 0];
											closeDialog 0;
											openMap true;
											[_civilian, _caller] spawn {waitUntil {sleep 0.1; !visibleMap}; [_this select 0, _this select 1] execVM "scripts\Gemini\fnc_civilianInteractionsDialog.sqf"};
											mapAnimAdd [0, 0.075, position _caller];
											mapAnimCommit;
											sleep 1;
											mapAnimAdd [3, 0.075, _newPos];
											mapAnimCommit;
											sleep 3;
											if (random 1 > 0.5) then {titleText [localize "STR_civilianConversation_6a", "plain"]} else {titleText [localize "STR_civilianConversation_6b", "plain"]};
											hint localize "STR_hint_addMarker";
										};
									if (!(_civilian getVariable "gatheredIntel")) then
										{
											_civilian setVariable ["gatheredIntel", true, true];
											["gatheredIntel"] call Gemini_fnc_updateStats;
											hint localize "STR_hint_intelGathered";
										};
								};
						}
					else
						{
							titleText [selectRandom [localize "STR_civilianConversation_annoyed_a", localize "STR_civilianConversation_annoyed_b", localize "STR_civilianConversation_annoyed_c"], "plain"];
						};
				}
			else
				{
					switch (OPEX_mapLanguage) do
						{
							case "english" 	: {titleText [localize "STR_civilianConversation_noPolyglotEnglish", "plain"]};
							case "greek" 	: {titleText [localize "STR_civilianConversation_noPolyglotGreek", "plain"]};
							case "french"	: {titleText [localize "STR_civilianConversation_noPolyglotFrench", "plain"]};
							case "arabic"	: {titleText [localize "STR_civilianConversation_noPolyglotArabic", "plain"]};
							case "german" 	: {titleText [localize "STR_civilianConversation_noPolyglotGerman", "plain"]};
							default			  {titleText [localize "STR_civilianConversation_noPolyglotEnglish", "plain"]};
						};
				};
		};

	Gemini_fnc_civilianInteractions_IDcheck_card =
		{
			private ["_civilian", "_caller"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_civilian setVariable ["sympathy", (_civilian getVariable "sympathy") - 1, true];
			if (("Gemini_IDcard" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))) or ("Gemini_passport" in ((items _civilian) + (uniformitems _civilian) + (assigneditems _civilian))))
			then
				{
					sleep 2;
					_civilian setVariable ["known_realName", true, true];
					_civilian setVariable ["known_realBirthdate", true, true];
					_civilian setVariable ["known_realNationality", true, true];
					hint parseText
						(
							"<t size='1' align='right'>"
								+
								localize "STR_dialog_civilianInteractions_conversation_identity" + " : " + ((_civilian getVariable "name") select 0)
								+ "<br/>" +
								localize "STR_dialog_civilianInteractions_conversation_nationality" + " : " + localize ((_civilian getVariable "nationality") select 0)
								+ "<br/>" +
								localize "STR_dialog_civilianInteractions_conversation_birthdate" + " : " + ((_civilian getVariable "birthdate") select 0)
								+
							"</t>"
						);
				}
			else
				{
					if ((_civilian getVariable "polyglot") || (_caller getUnitTrait "interpret") || (count ((_civilian nearEntities ["Man", 10]) select {(alive _x) && (_x getUnitTrait "interpret")}) > 0))
					then {titleText [localize "STR_civilianConversation_noIDcard", "plain"]}
					else {
							switch (OPEX_mapLanguage) do
								{
									case "english" 	: {titleText [localize "STR_civilianConversation_noPolyglotEnglish", "plain"]};
									case "greek" 	: {titleText [localize "STR_civilianConversation_noPolyglotGreek", "plain"]};
									case "french"	: {titleText [localize "STR_civilianConversation_noPolyglotFrench", "plain"]};
									case "arabic"	: {titleText [localize "STR_civilianConversation_noPolyglotArabic", "plain"]};
									case "german" 	: {titleText [localize "STR_civilianConversation_noPolyglotGerman", "plain"]};
									default			  {titleText [localize "STR_civilianConversation_noPolyglotEnglish", "plain"]};
								};
						};
				};
		};

	Gemini_fnc_civilianInteractions_IDcheck_scan =
		{
			private ["_civilian", "_caller", "_scanCompleted", "_result"];
			_civilian = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_civilian setVariable ["sympathy", (_civilian getVariable "sympathy") - 3, true];
			_civilian reveal _caller;
			_scanCompleted = false;
			while {(_civilian distance _caller < 5) && (!_scanCompleted)} do
				{
					if (_civilian distance _caller < 5) then {hint localize "STR_hint_gettingBiometricData"};
					if (_civilian distance _caller < 5) then {if (OPEX_debug) then {sleep 2} else {sleep (3 + (floor random 25))}};
					if (_civilian distance _caller < 5) then {hint localize "STR_hint_connectingToDB"};
					if (_civilian distance _caller < 5) then {if (OPEX_debug) then {sleep 2} else {sleep (floor random 10)}};
					if (_civilian distance _caller < 5) then {_scanCompleted = true};
				};
			// IF SCAN HAS BEEN COMPLETED
				if (_scanCompleted) then
					{
						if (!(_civilian getVariable "recorded"))
						then {hint localize "STR_hint_noDataFound"; _civilian setVariable ["recorded", true, true]}
						else
							{
								private ["_name", "_nationality", "_birthdate", "_job", "_resultColor"];
									_name = [];
									if ((_civilian getVariable "known_realName")) then {_name set [count _name, ((_civilian getVariable "name") select 0)]};
									if ((_civilian getVariable "known_fakeName")) then {_name set [count _name, ((_civilian getVariable "name") select ((count (_civilian getVariable "name")) - 1))]};
									if (count _name == 0) then {_name = localize "STR_hint_unknown"};
									if (count _name == 1) then {_name = _name select 0}; if (count _name == 2) then {_name = (_name select 0) + "<br/>" + (_name select 1)};
									_nationality = [];
									if ((_civilian getVariable "known_realNationality")) then {_nationality set [count _nationality, ((_civilian getVariable "nationality") select 0)]};
									if ((_civilian getVariable "known_fakeNationality")) then {_nationality set [count _nationality, ((_civilian getVariable "nationality") select ((count (_civilian getVariable "nationality")) - 1))]};
									if (count _nationality == 0) then {_nationality = localize "STR_hint_unknown"};
									if (count _nationality == 1) then {_nationality = localize (_nationality select 0)}; if (count _nationality == 2) then {_nationality = localize (_nationality select 0) + "<br/>" + localize (_nationality select 1)};
									_birthdate = [];
									if ((_civilian getVariable "known_realBirthdate")) then {_birthdate set [count _birthdate, ((_civilian getVariable "birthdate") select 0)]};
									if ((_civilian getVariable "known_fakeBirthdate")) then {_birthdate set [count _birthdate, ((_civilian getVariable "birthdate") select ((count (_civilian getVariable "birthdate")) - 1))]};
									if (count _birthdate == 0) then {_birthdate = localize "STR_hint_unknown"};
									if (count _birthdate == 1) then {_birthdate = _birthdate select 0}; if (count _birthdate == 2) then {_birthdate = (_birthdate select 0) + "<br/>" + (_birthdate select 1)};
									_job = [];
									if ((_civilian getVariable "known_realJob")) then {_job set [count _job, ((_civilian getVariable "job") select 0)]};
									if ((_civilian getVariable "known_fakeJob")) then {_job set [count _job, ((_civilian getVariable "job") select ((count (_civilian getVariable "job")) - 1))]};
									if (count _job == 0) then {_job = localize "STR_hint_unknown"};
									if (count _job == 1) then {_job = localize (_job select 0)}; if (count _job == 2) then {_job = localize (_job select 0) + "<br/>" + localize (_job select 1)};
									if ((_civilian getVariable "side" == "hostile") && (_civilian getVariable "intel" != "STR_civilian_intel_noData")) then {_resultColor = "<t color='#FF0000'>"} else {_resultColor = "<t color='#FFFFFF'>"};
									hint parseText
										(
											"<t size='1' align='right'>"
												+
												toUpper localize "STR_dialog_civilianInteractions_conversation_identity" + "<br/>" + _name
												+ "<br/>" + "<br/>" +
												toUpper localize "STR_dialog_civilianInteractions_conversation_nationality" + "<br/>" + _nationality
												+ "<br/>" + "<br/>" +
												toUpper localize "STR_dialog_civilianInteractions_conversation_birthdate" + "<br/>" + (_birthdate)
												+ "<br/>" + "<br/>" +
												toUpper localize "STR_dialog_civilianInteractions_conversation_job" + "<br/>" + _job
												+ "<br/>" + "<br/>" +
												_resultColor
												+
												localize (_civilian getVariable "intel")
												+
												"</t>"
												+
											"</t>"
										);
							};
					}
			// IF SCAN HAS BEEN INTERRUPTED
				else {hint localize "str_hint_brokenLink"};
		};

	Gemini_fnc_civilianInteractions_suspect_down =
		{
			private ["_suspect", "_caller"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_suspect setVariable ["sympathy", (_suspect getVariable "sympathy") - 5, true];
			_suspect setCombatMode "blue";
			_suspect setUnitPos "down";
			waitUntil {sleep 1; _suspect distance _caller > (15 + random 35)};
			_suspect setUnitPos "auto";
		};

	Gemini_fnc_civilianInteractions_suspect_release =
		{
			private ["_suspect", "_caller"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_suspect setVariable ["sympathy", (_suspect getVariable "sympathy") + 1, true];
			_suspect setUnitPos "auto";
			closeDialog 0;
			_suspect say3D "cabletie_cut";
			while {(count (waypoints _suspect)) > 0} do {deleteWaypoint ((waypoints _suspect) select 0); sleep 0.01};
			sleep 0.5;
			_suspect enableAI "move";
			_suspect switchMove "";
			[group _suspect, (getPos _suspect), 100] spawn Gemini_fnc_doPatrol;
			_suspect setVariable ["isHandcuffed", false, true];
			_suspect setCaptive false;
		};

	Gemini_fnc_civilianInteractions_suspect_search =
		{
			private ["_suspect", "_caller", "_searchInterrupted"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			if (_suspect getVariable "side" == "friendly") then {["civilianSearched"] call Gemini_fnc_updateStats};
			_suspect setVariable ["sympathy", (_suspect getVariable "sympathy") - 10, true];
			hint localize "STR_hint_searching";
			sleep (3 + random 7);
			if (_suspect distance _caller <= 5) then
				{
					hint localize "STR_hint_searchCompleted"; createGearDialog [_suspect, findDisplay 106];
					if (((_suspect getVariable "side") == "hostile") && (!(_suspect getVariable "gatheredIntel"))) then {_suspect setVariable ["gatheredIntel", true, true]; ["gatheredIntel"] call Gemini_fnc_updateStats; hint localize "STR_hint_intelGathered"};
				} else {hint localize "STR_hint_searching"};
		};

	Gemini_fnc_civilianInteractions_suspect_handcuff =
		{
			private ["_suspect", "_caller"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			if (_suspect getVariable "side" == "friendly") then {["civilianHandcuffed"] call Gemini_fnc_updateStats};
			_suspect setVariable ["sympathy", (_suspect getVariable "sympathy") - 25, true];
			_suspect say3D "cabletie_clamp";
			if ("ACE_CableTie" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller))) then {_caller removeItem "ACE_CableTie"} else {if ("Gemini_cableTie" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller))) then {_caller removeItem "Gemini_cableTie"}};
			_suspect setVariable ["isHandcuffed", true, true];
			_suspect setCaptive true;
			sleep 0.5;
			_suspect switchMove "AmovPercMstpSsurWnonDnon";
		};

	Gemini_fnc_civilianInteractions_suspect_take =
		{
			private ["_suspect", "_caller"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			detach _suspect;
			_suspect attachTo [_caller, [0.1,0.7,0]];
			_caller action ["weaponOnBack", _caller];
			[_suspect, _caller] spawn {while {sleep 0.1; ((_this select 0) distance (_this select 1) <= 1 && (alive (_this select 0)))} do {(_this select 1) forceWalk true}; (_this select 1) forceWalk false};
			while {(count attachedObjects _caller != 0) || (alive _caller)} do {sleep 1};
			detach _suspect;
		};

	Gemini_fnc_civilianInteractions_suspect_unload =
		{
			private ["_vehicle"];
			_vehicle = [_this, 0, objNull] call BIS_fnc_param;
			_suspect = [_this, 1, objNull] call BIS_fnc_param;
			[_vehicle] remoteExec ["Gemini_fnc_removeAllActions", 0, _vehicle];
			{if (side _x != OPEX_friendly_side1) then
				{
					//unassignVehicle _x;
					[_suspect, "all"] remoteExec ["enableAI", _suspect];
					_x remoteExec ["unassignVehicle", 0];
					//doStop _x;
					_x remoteExec ["doStop", 0];
					private ["_emptyPos"];
					_emptyPos = ["land", _vehicle, 0, 15, 1] call Gemini_fnc_findPos;
					if (_emptyPos distance2D [0,0,0] < 10) then {_emptyPos = [(getPos _vehicle select 0) + 10, (getPos _vehicle select 1) + 10, 0]};
					[_x, _emptyPos] remoteExec ["setPos", 0];
					//_x switchMove "AmovPercMstpSsurWnonDnon";
					[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["switchMove", 0];
				}
			} forEach (crew _vehicle);
		};

	Gemini_fnc_civilianInteractions_suspect_load =
		{
			private ["_suspect", "_caller", "_nearbyVehicles", "_vehicle"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			_nearbyVehicles = (position _suspect) nearEntities [["Air", "Car", "Motorcycle", "Tank"], 7.5];
			_vehicle = ([_nearbyVehicles, [], {_suspect distance _x }, "ASCEND"] call BIS_fnc_sortBy) select 0;
			doStop _suspect;
			if (!isNil {_vehicle}) then
				{
					if ((_vehicle emptyPositions "cargo") == 0) exitWith {["hint", "STR_hint_fullVehicle"] remoteExec ["Gemini_fnc_globalHint", _caller]};
					detach _suspect;
					_suspect switchMove "";
					sleep 0.1;
					_suspect moveInCargo _vehicle;
					[_suspect, "all"] remoteExec ["disableAI", _suspect];
				}
			else {["hint", "STR_hint_noNearbyVehicle"] remoteExec ["Gemini_fnc_globalHint", _caller]};
			sleep 1;
			if (vehicle _suspect == _vehicle) then
				{
					[
						_vehicle,
						"STR_action_suspect_unload",
						{[_this select 3 select 0, _this select 3 select 1] remoteExec ["Gemini_fnc_civilianInteractions_suspect_unload", _this select 3 select 1]},
						[_vehicle, _suspect],
						6,
						"_target distance _this < 5"
					] remoteExec ["Gemini_fnc_addAction", 0, _vehicle];
				};
		};

	Gemini_fnc_civilianInteractions_suspect_drop =
		{
			private ["_suspect", "_caller"];
			_suspect = [_this, 0, objNull] call BIS_fnc_param;
			_caller = [_this, 1, objNull] call BIS_fnc_param;
			detach _suspect;
		};