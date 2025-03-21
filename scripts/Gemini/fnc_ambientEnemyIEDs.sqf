﻿// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyIEDs = 0; publicVariable "OPEX_ambientEnemyIEDs";

// DEFINING SECONDARY FUNCTIONS
IED_explosion =
	{
		private ["_IED", "_power"];
		_IED = _this select 0;
		_power = ["Bo_GBU12_LGB_MI10", "Bo_GBU12_LGB", "Bo_GBU12_LGB", "Bo_GBU12_LGB", "M_Mo_82mm_AT_LG", "HelicopterExploBig", "R_80mm_HE", "Bo_Mk82", "Bomb_04_F", "M_PG_AT"];
		_explosion = (selectRandom _power) createVehicle (position _IED);
		//_IED setDamage 1;
		deleteVehicle _IED;
		["IEDdestroyed"] call Gemini_fnc_updateStats;
		//[OPEX_friendly_side1, "Base", "STR_globalStats_updatePositive", globalStats_IED_destroyed, globalStats] remoteExec ["Gemini_fnc_globalChat"];
	};
IED_disarm =
	{
		["IEDdisarmed"] call Gemini_fnc_updateStats;
		//[OPEX_friendly_side1, "Base", "STR_globalStats_updatePositive", globalStats_IED_disarmed, globalStats] remoteExec ["Gemini_fnc_globalChat"];
	};
IED_delete =
	{
		private ["_IED", "_position"];
		_IED = _this select 0;
		_position = _this select 1;
		waitUntil {sleep 1; ({(_x distance2D _position) < OPEX_spawnDistanceMaxi} count OPEX_playingPlayers == 0)};
		deleteVehicle _IED;
	};

// DEFINING IED TRIGGER TYPES
// NO trigger - IED can explode if: (DESTROYED or DAMAGED)
private _IED_trigger_none =
	{
		private ["_IED", "_position"];
		_IED = _this select 0;
		_position = _this select 1;
		// CREATING TRIGGER
			// checking if IED is destroyed or damaged
				[_IED] spawn
					{
						private ["_IED"]; _IED = _this select 0;
						while {(alive _IED) && (damage _IED < 0.2)} do {sleep 0.5};
						if (alive _IED) then {[_IED] call IED_explosion};
					};
		[_IED, _position] spawn IED_delete;
	};
// REMOTE trigger - IED can explode if: (DESTROYED or DAMAGED) or (ANY FRIEND IS NEARBY) or (TRIGGERMAN is KILLED)
private _IED_trigger_remote =
	{
		private ["_IED", "_position"];
		_IED = _this select 0;
		_position = _this select 1;
		[_IED, _position] spawn
			{
				private ["_IED", "_position", "_overwatchPos"];
				_IED = _this select 0;
				_position = _this select 1;
				private _overwatchPos = ["overwatch", _position, 100, 300, 25] call Gemini_fnc_findPos;
				// CREATING TRIGGER MAN
					private ["_triggerMan", "_dir"];
					_triggerMan = [OPEX_enemy_side1, grpNull, [OPEX_enemy_rifleman], _overwatchPos, OPEX_enemy_AIskill] call Gemini_fnc_createUnit;
					[_triggerMan] spawn
						{
							private ["_triggerMan"];
							_triggerMan = _this select 0;
							removeAllItems _triggerMan;
							removeAllAssignedItems _triggerMan;
							if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then {_triggerMan addItem "Gemini_deadManSwitch"};
							if (random 10 >= 5) then {_triggerMan linkItem "ItemMap"};
							if (random 10 >= 5) then {_triggerMan linkItem "ItemWatch"};
							if (random 10 >= 5) then {_triggerMan linkItem "ItemCompass"};
							if (random 10 >= 5) then {_triggerMan addWeapon "Binocular"};
						};
					_dir = [_triggerMan, _IED] call BIS_fnc_dirTo;
					_triggerMan setDir _dir;
					_triggerMan setFormDir _dir;
					_triggerMan doWatch _IED;
					_triggerMan setBehaviour "stealth";
					_triggerMan setCombatMode "white";
					_triggerMan setUnitPos (selectRandom ["down", "middle"]);
				// CREATING ASSISTANT(S)
					for "_i" from 0 to 5 do
						{
							if (round (random 10) > 6) then
								{
									private ["_assistant", "_dir"];
									_assistant = [OPEX_enemy_side1, grpNull, [OPEX_enemy_rifleman, OPEX_enemy_grenadier, OPEX_enemy_MG, OPEX_enemy_marksman], _overwatchPos, OPEX_enemy_AIskill] call Gemini_fnc_createUnit;
									[_assistant] join _triggerMan;
									_assistant execVM "scripts\Gemini\fnc_randomizeLoadout.sqf";
									removeAllItems _assistant;
									removeAllAssignedItems _assistant;
									_assistant setUnitPos (selectRandom ["down", "middle"]);
									_assistant setPos [(position _triggerMan select 0) + random 25 - random 25, (position _triggerMan select 1) + random 25 - random 25, 0];
									_dir = [_assistant, _IED] call BIS_fnc_dirTo;
									_assistant setDir _dir;
									_assistant doWatch _IED;
									[_assistant, _position] spawn IED_delete;
								};
						};
				// CREATING TRIGGER
					// checking if IED is destroyed or damaged
						[_IED] spawn
							{
								private ["_IED"]; _IED = _this select 0;
								while {(alive _IED) && (damage _IED < 0.2)} do {sleep 0.5};
								if (alive _IED) then {[_IED] call IED_explosion};
							};
					// checking if any friend unit is nearby and if triggerman is alive
						[_IED, _triggerMan] spawn
							{
								private ["_IED", "_triggerMan"];
								_IED = _this select 0;
								_triggerMan = _this select 1;
								while {(alive _IED) && (damage _IED < 0.2)}
								do
									{
										sleep 0.5;
										if (isClass (configFile >> "CfgPatches" >> "Gemini_items"))
										then
											{
												if (({_x distance2D (position _IED) < (random 15)} count (allPlayers - entities "HeadlessClient_F") > 0) && ((alive _triggerMan) && ("Gemini_deadManSwitch" in ((items _triggerMan) + (uniformItems _triggerMan) + (backpackItems _triggerMan) + (vestItems _triggerMan))))) then {sleep (random 3); if (alive _IED) then {[_IED] call IED_explosion}};
												if ((!alive _triggerMan) && ("Gemini_deadManSwitch" in ((items _triggerMan) + (uniformItems _triggerMan) + (backpackItems _triggerMan) + (vestItems _triggerMan)))) then {sleep (random 3); if (alive _IED) then {[_IED] call IED_explosion}};
											}
										else
											{
												if (({_x distance2D (position _IED) < (random 15)} count (allPlayers - entities "HeadlessClient_F") > 0) && (alive _triggerMan)) then {sleep (random 3); if (alive _IED) then {[_IED] call IED_explosion}};
												if (!alive _triggerMan) then {sleep (random 3); if (alive _IED) then {[_IED] call IED_explosion}};
											};
									};
							};
					// checking if IED is disarmed
						[_IED, _position] spawn
							{
								private ["_IED", "_position"];
								_IED = _this select 0;
								_position = _this select 1;
								while {alive _IED} do {sleep 1};
								if (((getMagazineCargo ((nearestObjects [getPos player, ["GroundWeaponHolder"], 5]) select 0)) select 0 select 0) in ["IEDLandBig_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDUrbanSmall_Remote_Mag", "IEDLandSmall_Remote_Mag"]) then {call IED_disarm};
							};

					// DELETING TRIGGERMAN WHEN USELESS
					[_triggerMan, _position] spawn IED_delete;
			};
		[_IED, _position] spawn IED_delete;
	};
// CELLPHONE trigger - IED can explode if: (DESTROYED or DAMAGED) or ((ANY FRIEND IS NEARBY) and (TRIGGERMAN is ALIVE))
private _IED_trigger_cellphone =
	{
		private ["_IED", "_position"];
		_IED = _this select 0;
		_position = _this select 1;
		[_IED, _position] spawn
			{
				private ["_IED", "_position", "_overwatchPos"];
				_IED = _this select 0;
				_position = _this select 1;
				private _overwatchPos = ["overwatch", _position, 100, 300, 25] call Gemini_fnc_findPos;
				// CREATING TRIGGER MAN
					private ["_triggerMan", "_dir"];
					_triggerMan = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _overwatchPos, OPEX_civilian_AIskill] call Gemini_fnc_createUnit;
					_triggerMan forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_triggerMan addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
				// TURNING TRIGGERMAN INTO A CIVILIAN
					[_triggerMan, "triggerMan_"] call Gemini_fnc_setUnitName;
					// GEMINI'S INTERACTION SCRIPT !!!
					//[_triggerMan] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
					//[_triggerMan] remoteExec ["Gemini_fnc_civilianAction"];
					_triggerMan setVariable ["side", "hostile", true];
					_triggerMan setVariable ["sympathy", (floor random 10) - (floor random 10), true];
					_triggerMan setVariable ["isHandcuffed", false, true];
					if (floor random 10 < 3) then {_triggerMan setVariable ["recorded", true, true]} else {_triggerMan setVariable ["recorded", false, true]};
				// DEFINING CIVILIAN NAME
					private ["_name", "_knownName"];
					_name = [name _triggerMan];
					if ((_triggerMan getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_name set [count _name, OPEX_enemy_names call BIS_fnc_selectRandom]}};
					_triggerMan setVariable ["name", _name, true];
					_triggerMan setVariable ["known_realName", false, true];
					_triggerMan setVariable ["known_fakeName", false, true];
					_knownName = ["known_realName", "known_fakeName"] call BIS_fnc_selectRandom;
					if (_triggerMan getVariable "recorded") then {_triggerMan setVariable [_knownName, [true, false] call BIS_fnc_selectRandom, true]};
				// DEFINING CIVILIAN NATIONALITY
					private ["_nationality", "_knownNationality"];
					_nationality = [OPEX_mapNationalities call BIS_fnc_selectRandom];
					if ((_triggerMan getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_nationality set [count _nationality, OPEX_mapNationalities call BIS_fnc_selectRandom]}};
					_triggerMan setVariable ["nationality", _nationality, true];
					_triggerMan setVariable ["known_realNationality", false, true];
					_triggerMan setVariable ["known_fakeNationality", false, true];
					_knownNationality = ["known_realNationality", "known_fakeNationality"] call BIS_fnc_selectRandom;
					if (_triggerMan getVariable "recorded") then {_triggerMan setVariable [_knownNationality, [true, false] call BIS_fnc_selectRandom, true]};
				// DEFINING CIVILIAN BIRTHDATE
					private ["_date", "_month", "_year", "_separator", "_birthDate", "_knownBirthdate"];
					_date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
					_month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					_year = ["1995", "1994", "1993", "1992", "1991", "1990", "1989", "1988", "1987", "1986", "1985", "1984", "1983", "1982", "1981", "1980"];
					_separator = "/";
					_birthDate = [(_date call BIS_fnc_selectRandom) + _separator + (_month call BIS_fnc_selectRandom) + _separator + (_year call BIS_fnc_selectRandom)];
					if ((_triggerMan getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_birthDate set [count _birthDate, (_date call BIS_fnc_selectRandom) + _separator + (_month call BIS_fnc_selectRandom) + _separator + (_year call BIS_fnc_selectRandom)]}};
					_triggerMan setVariable ["birthdate", _birthDate, true];
					_triggerMan setVariable ["known_realBirthdate", false, true];
					_triggerMan setVariable ["known_fakeBirthdate", false, true];
					_knownBirthdate = ["known_realBirthdate", "known_fakeBirthdate"] call BIS_fnc_selectRandom;
					if (_triggerMan getVariable "recorded") then {_triggerMan setVariable [_knownBirthdate, [true, false] call BIS_fnc_selectRandom, true]};
				// DEFINING CIVILIAN JOB
					private ["_job", "_knownJob"];
					_job = [OPEX_civilian_jobs call BIS_fnc_selectRandom];
					if ((_triggerMan getVariable "side") == "hostile") then {if (6 < (floor random 10)) then {_job set [count _job, OPEX_civilian_jobs call BIS_fnc_selectRandom]}};
					_triggerMan setVariable ["job", _job, true];
					_triggerMan setVariable ["known_realJob", false, true];
					_triggerMan setVariable ["known_fakeJob", false, true];
					_knownJob = ["known_realJob", "known_fakeJob"] call BIS_fnc_selectRandom;
					if (_triggerMan getVariable "recorded") then {_triggerMan setVariable [_knownJob, [true, false] call BIS_fnc_selectRandom, true]};
				// DEFINING IF CIVILIAN IS POLYGLOT - DETERMINING IF HE UNDERSTAND PLAYERS LANGUAGE
					_triggerMan setVariable ["polyglot", [false, true] call BIS_fnc_selectRandom, true];
				// DEFINING CIVILIAN INTEL DATABASE - DETERMINING IF HE IS ALREADY KNOWN TO BE HOSTILE
					private ["_intel"];
					if ((_triggerMan getVariable "side" == "hostile") && (_triggerMan getVariable "recorded")) then
						{
							_intel =
								[
									"STR_triggerMan_intel_01", "STR_triggerMan_intel_02", "STR_triggerMan_intel_03", "STR_triggerMan_intel_04", "STR_triggerMan_intel_05",
									"STR_triggerMan_intel_06", "STR_triggerMan_intel_07", "STR_triggerMan_intel_08", "STR_triggerMan_intel_09", "STR_triggerMan_intel_10"
								] call BIS_fnc_selectRandom;
							_triggerMan setVariable ["intel", [_intel, "STR_triggerMan_intel_noData"] call BIS_fnc_selectRandom, true];
						}
					else {_triggerMan setVariable ["intel", "STR_triggerMan_intel_noData", true]};
					removeAllItems _triggerMan;
					removeAllAssignedItems _triggerMan;
				// RANDOMLY ADDING CIVILIAN ITEMS
					private ["_allItems"];
					_allItems = OPEX_civilian_items - ["Gemini_cellphone"];
					if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then {_triggerMan addItem "Gemini_cellphone"};
					for "_i" from 0 to (round random (count _allItems - 1)) do {_triggerMan addItem (selectRandom _allItems)};
				// RANDOMLY ADDING SUSPICIOUS ITEMS
					if (random 10 > 5) then {_triggerMan linkItem "ItemMap"};
					if (random 10 > 5) then {_triggerMan linkItem "ItemWatch"};
					if (random 10 > 5) then {_triggerMan linkItem "ItemCompass"};
					if (random 10 > 5) then {_triggerMan addWeapon "Binocular"};
				_dir = [_triggerMan, _IED] call BIS_fnc_dirTo;
				_triggerMan setDir _dir;
				_triggerMan doWatch _IED;
				// CREATING TRIGGER
				// checking if IED is destroyed or damaged
					[_IED] spawn
						{
							private ["_IED"]; _IED = _this select 0;
							while {(alive _IED) && (damage _IED < 0.2)} do {sleep 0.5};
							if (alive _IED) then {[_IED] call IED_explosion};
						};
				// checking if any friend unit is nearby and if triggerman is alive
					[_IED, _triggerMan] spawn
						{
							private ["_IED", "_triggerMan"];
							_IED = _this select 0;
							_triggerMan = _this select 1;
							while {(alive _IED) && (damage _IED < 0.2)}
							do
								{
									sleep 0.5;
									if (isClass (configFile >> "CfgPatches" >> "Gemini_items"))
									then {if (({_x distance2D (position _IED) < (random 15)} count (allPlayers - entities "HeadlessClient_F") > 0) && ((alive _triggerMan) && (!(_triggerMan getVariable "isHandcuffed")) && ("Gemini_cellphone" in ((items _triggerMan) + (uniformItems _triggerMan) + (backpackItems _triggerMan) + (vestItems _triggerMan))))) then {sleep (random 5); if (alive _IED) then {[_IED] call IED_explosion}}}
									else {if (({_x distance2D (position _IED) < (random 15)} count (allPlayers - entities "HeadlessClient_F") > 0) && ((alive _triggerMan) && (!(_triggerMan getVariable "isHandcuffed")))) then {sleep (random 5); if (alive _IED) then {[_IED] call IED_explosion}}}
								};
						};
					// checking if IED is disarmed
						[_IED, _position] spawn
							{
								private ["_IED", "_position"];
								_IED = _this select 0;
								_position = _this select 1;
								while {alive _IED} do {sleep 1};
								if (((getMagazineCargo ((nearestObjects [getPos player, ["GroundWeaponHolder"], 5]) select 0)) select 0 select 0) in ["IEDLandBig_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDUrbanSmall_Remote_Mag", "IEDLandSmall_Remote_Mag"]) then {call IED_disarm};
							};
					// DELETING TRIGGERMAN IF USELESS
					[_triggerMan, _position] spawn IED_delete;
			};
		[_IED, _position] spawn IED_delete;
	};
// PROXIMITY trigger - IED can explode if: (DESTROYED or DAMAGED) or (ANY FRIEND IS NEARBY)
private _IED_trigger_proximity =
	{
		private ["_IED", "_position"];
		_IED = _this select 0;
		_position = _this select 1;
		[_IED, _position] spawn
			{
				private ["_IED", "_position"];
				_IED = _this select 0;
				_position = _this select 1;
				// CREATING TRIGGER
					// checking if IED is destroyed or damaged
						[_IED] spawn
							{
								private ["_IED"]; _IED = _this select 0;
								while {(alive _IED) && (damage _IED < 0.2)} do {sleep 0.5};
								if (alive _IED) then {[_IED] call IED_explosion};
							};
					// checking if any friend unit is nearby and if triggerman is alive
						[_IED] spawn
							{
								private ["_IED", "_maxSpeed"];
								_IED = _this select 0;
								_maxSpeed = random 15;
								while {(alive _IED) && (damage _IED < 0.2)}
								do
									{
										sleep 0.5;
										if ({(_x distance2D (position _IED) < (random 5)) && ((speed _x > _maxSpeed) || (speed _x < _maxSpeed * -1))} count (allUnits) > 0) then {sleep (random 5); if (alive _IED) then {[_IED] call IED_explosion}};
									};
							};
					// checking if IED is disarmed
						[_IED, _position] spawn
							{
								private ["_IED", "_position"];
								_IED = _this select 0;
								_position = _this select 1;
								while {alive _IED} do {sleep 1};
								if (((getMagazineCargo ((nearestObjects [getPos player, ["GroundWeaponHolder"], 5]) select 0)) select 0 select 0) in ["IEDLandBig_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDUrbanSmall_Remote_Mag", "IEDLandSmall_Remote_Mag"]) then {call IED_disarm};
							};
			};
		[_IED, _position] spawn IED_delete;
	};

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// GETTING TRIGGER TYPES
		private _IED_trigger_none = _this select 0;
		private _IED_trigger_remote = _this select 1;
		private _IED_trigger_cellphone = _this select 2;
		private _IED_trigger_proximity = _this select 3;

		// ADJUSTING LIMIT
		private _maxIEDs = 1;
		if (count OPEX_playingPlayers <= 3) then {_maxIEDs = 1};
		if ((count OPEX_playingPlayers > 3) && (count OPEX_playingPlayers <= 9)) then {_maxIEDs = 2};
		if (count OPEX_playingPlayers > 9) then {_maxIEDs = 3};

		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientEnemyIEDs >= _maxIEDs) || (random 100 > 60)) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientEnemyIEDs = OPEX_ambientEnemyIEDs + 1; publicVariable "OPEX_ambientEnemyIEDs";

		// LOOKING FOR A RANDOM ROAD AROUND SELECTED PLAYER
		private _roadPos = ["road", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.9] call Gemini_fnc_findPos;
		if (_roadPos isEqualTo [0,0,0]) exitWith {OPEX_ambientEnemyIEDs = OPEX_ambientEnemyIEDs - 1; publicVariable "OPEX_ambientEnemyIEDs";};
		private _road = (_roadPos nearRoads 15) select 0;
		_roadPos = (_road modelToWorld [((boundingBox _road) select 1 select 0) * 0.9, 0, 0]); // returning a position at the side of the road

		// SPAWNING IED
		private _IED = createMine [selectRandom ["IEDLandBig_F", "IEDLandSmall_F", "IEDUrbanBig_F", "IEDUrbanSmall_F"], _roadPos, [], 0];
		_IED setPosATL [(getPos _IED select 0), (getPos _IED select 1), 0];

		// SETTING IED TYPE
		private _triggerType = selectRandom ["none","cellphone","remote","proximity","proximity"];
		switch _triggerType do
			{
				case "none"			:	{[_IED, position _IED] spawn _IED_trigger_none};
				case "remote"		:	{[_IED, position _IED] spawn _IED_trigger_remote};
				case "cellphone"	:	{[_IED, position _IED] spawn _IED_trigger_cellphone};
				case "proximity"	:	{[_IED, position _IED] spawn _IED_trigger_proximity};
				case default			{[_IED, position _IED] spawn _IED_trigger_none};
			};

		// DEBUGGING
		if (OPEX_debug) then
			{
				systemChat "AMBIENT IED READY !";
				private _marker = [_roadPos, "mil_warning", "ColorRed", "IED"] call Gemini_fnc_createMarker;
				switch _triggerType do
					{
						case "none"			:	{_marker setMarkerText "IED (no trigger)"};
						case "remote"		:	{_marker setMarkerText "IED (remote trigger)"};
						case "cellphone"	:	{_marker setMarkerText "IED (cellphone trigger)"};
						case "proximity"	:	{_marker setMarkerText "IED (proximity trigger)"};
						case default			{_marker setMarkerText "IED (no trigger)"};
					};
			};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {(_roadPos call Gemini_fnc_isUnplayedArea) || (!alive _IED)};
		OPEX_ambientEnemyIEDs = OPEX_ambientEnemyIEDs - 1; publicVariable "OPEX_ambientEnemyIEDs";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [_IED_trigger_none, _IED_trigger_remote, _IED_trigger_cellphone, _IED_trigger_proximity] spawn _mainFunction};