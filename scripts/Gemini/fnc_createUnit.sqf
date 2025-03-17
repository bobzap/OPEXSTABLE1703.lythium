// =========================================================================================================
// SCRIPT COPYRIGHT
// =========================================================================================================

	/*
		Author:								Gemini
		Contact: 							gemini.69@free.fr
		Autohorized usage:					Yes
		Authorized copy/modifications:	 	Yes, but please think to mention the author's name
	*/

// =========================================================================================================
// SCRIPT INSTRUCTIONS
// =========================================================================================================

	/*

		// DETAILED EXECUTION:
		[
			SIDE,						// (SIDE)				unit side
			GROUP, 						// (GROUP)				unit group
			TYPES,						// (ARRAY OF STRINGS)	possible unit types (class names)
			POSITION,					// (ARRAY OF NUMBERS)	spawning position
			SKILL						// (ARRAY OF NUMBERS)	AI skill (minimum level and maximum level)
		] call Gemini_fnc_createUnit;

		// EXAMPLES:
		_newFriendlyUnit = [west, group player, ["B_soldier_F", "B_Soldier_GL_F"], position player, [0.2, 0.7]] call Gemini_fnc_createUnit;
		_newEnemyUnit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, position player, OPEX_enemy_AIskill] call Gemini_fnc_createUnit;
		_driver = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, [0,0,0], OPEX_civilian_AIskill] call Gemini_fnc_createUnit;

	*/

// =========================================================================================================
// STARTING SCRIPT EXECUTION (SERVER ONLY)
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// CHECKING PARAMETERS
// =========================================================================================================

	private _unitSide = param [0, civilian, [civilian]];
	private _unitGroup = param [1, grpNull, [grpNull]]; if (_unitGroup isEqualTo grpNull) then {_unitGroup = createGroup _unitSide};
	private _unitTypes = param [2, ["C_man_1"], [[],""]]; if (typeName _unitTypes != "ARRAY") then {_unitTypes = [_unitTypes]};
	private _unitSpawnPosition = param [3, [0,0,0], [[], objNull]]; if (typeName _unitSpawnPosition isEqualTo objNull) then {_unitSpawnPosition = position _unitSpawnPosition};
	private _unitSkill = param [4, [0,1], [[0,1]]];
	private _disableCivilianHostility = param [5, false, [false]];
	private _lifeTime = param [6, "distance", [""]];

// =========================================================================================================
// CREATING UNIT
// =========================================================================================================

	private _unit = _unitGroup createUnit [selectRandom _unitTypes, _unitSpawnPosition, [], 0, "NONE"];


	[_unit] joinSilent _unitGroup;
	_unitGroup setBehaviour "safe";
	_unitGroup setSpeedMode "unchanged";
	_unitGroup setCombatMode "green";
	_unitGroup deleteGroupWhenEmpty true;

// =========================================================================================================
// SETTING CREATED UNIT (COMMON SETTINGS)
// =========================================================================================================

	// NAMING UNIT (NECESSARY FOR SEVERAL SCRIPTS)
	private ["_unitID"];
	if (_unitSide != sideLogic) then
		{
			_unitID = "OPEX_unit_" + (str (round (random 99999))); // example: "OPEX_unit_12345"
			[_unit, _unitID] remoteExecCall ["Gemini_fnc_setVehicleVarName", 0, _unit];
		};

	// SETTING UNIT SKILL
	_unit setSkill (((_unitSkill select 0) + (random ((_unitSkill select 1) - (_unitSkill select 0)))) / 2);
	_unit setSkill ["courage", 1];
	_unit setSkill ["commanding", 1];
	_unit setSkill ["aimingSpeed", 0.3];
	_unit setSkill ["spotDistance", 1];
	_unit setSkill ["aimingAccuracy", 0.45];
	_unit setSkill ["aimingShake", 0.3];  // modif sayker
	_unit setSkill ["spotTime", 1]; // FORCING AI SPOT TIME BECAUSE AI IN ARMA IS A BIT SLOW TO REACT  spotDistance

	// ADDING ACTION TO DRAG BODY
	if (!isNil "H8_addDrag") then {[_unit] spawn H8_addDrag};

	// ENABLING DYMAMIC SIMULATION
	(group _unit) enableDynamicSimulation true;

	// RANDOMIZING LOADOUT
	_unit call Gemini_fnc_randomizeLoadout;

	// ???
	_unit spawn
		{
			sleep 3;
			if (count (units group _this) == 1) then {_this setBehaviour "safe"};
			//_this setVehiclePosition [[getPos _this select 0, getPos _this select 1, 0], [], 0, "CAN_COLLIDE"]; // adjusting height
		};

	//  SETTING PROPER FACE
	private _whiteFaces =
		[
			"WhiteHead_01", "WhiteHead_02", "WhiteHead_03", "WhiteHead_04", "WhiteHead_05",
			"WhiteHead_06", "WhiteHead_07", "WhiteHead_08", "WhiteHead_09", "WhiteHead_10",
			"WhiteHead_11", "WhiteHead_12", "WhiteHead_13", "WhiteHead_14", "WhiteHead_15",
			"WhiteHead_16", "WhiteHead_17", "WhiteHead_18", "WhiteHead_19", "WhiteHead_20",
			"WhiteHead_21", "WhiteHead_23",
			"GreekHead_A3_01", "GreekHead_A3_02", "GreekHead_A3_03", "GreekHead_A3_04", "GreekHead_A3_05",
			"GreekHead_A3_06", "GreekHead_A3_07", "GreekHead_A3_08", "GreekHead_A3_09", "GreekHead_A3_11",
			"GreekHead_A3_12", "GreekHead_A3_13", "GreekHead_A3_14"
		];
	private _blackFaces = ["AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03"];
	if (395180 in (getDLCs 1)) then {_blackFaces append ["TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_07","TanoanHead_A3_01","TanoanHead_A3_06","TanoanHead_A3_08"]};
	private _arabicFaces =
		[
			"PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
			"PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
			"PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
			"WhiteHead_08","WhiteHead_16", "GreekHead_A3_01","GreekHead_A3_03"
		];

	if ((side _unit == OPEX_friendly_side1) && (OPEX_friendly_subFaction == "STR_friendly_subFaction_Russia")) then {[_unit, selectRandom _whiteFaces] remoteExec ["setFace", 0, _unit]};
	if ((side _unit == OPEX_enemy_side1) && ((OPEX_enemy_subFaction == "STR_enemy_name_BOKO_4") || (worldName in ["Tanoa"]))) then {[_unit, selectRandom _blackFaces] remoteExec ["setFace", 0, _unit]};
	if (side _unit == OPEX_civilian_side1) then
		{
			switch OPEX_mapRegion do
				{
					case "europe"		:	{};
					case "middleEast"	:	{[_unit, selectRandom _arabicFaces] remoteExec ["setFace", 0, _unit]};
					case "africa"		:	{[_unit, selectRandom _blackFaces] remoteExec ["setFace", 0, _unit]};
					case "pacific"		:	{[_unit, selectRandom _blackFaces] remoteExec ["setFace", 0, _unit]};
					default 				{};
				};
		};

// =========================================================================================================
// SETTING CREATED UNIT (IF UNIT IS ENEMY)
// =========================================================================================================

	if (_unitSide == OPEX_enemy_side1) then
		{
			// COUNTING KILLED UNITS
			_unit addEventHandler ["killed", "['enemyKilled', _this] call Gemini_fnc_updateStats"];
			//_unit addEventHandler ["hit", "if (side (_this select 1) == OPEX_friendly_side1) then {['enemyHit', _this] call Gemini_fnc_updateStats}"];
			//_unit addEventHandler ["hit", "['enemyHit', _this] call Gemini_fnc_updateStats"];

			// ADDING INTEL
			[_unit, ["STR_action_searchBody", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "(_target distance2D _this < 1.75) && (!alive _target)", "(_target distance2D _this < 1.75) && (!alive _target)", {}, {}, {_this call Gemini_fnc_searchBody}, {}, [], 7.5, 3, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _unit];

			private _intelProbability = 0;
			if ((typeOf _unit) in [OPEX_enemy_teamLeader]) then {_intelProbability = 9} else {_intelProbability = 3};
			if (round (random 100) <= _intelProbability) then {_unit setVariable ["heldIntel", round (random 10), true]} else {_unit setVariable ["heldIntel", 0, true]};
		};

// =========================================================================================================
// SETTING CREATED UNIT (IF UNIT IS FRIENDLY)
// =========================================================================================================

	if (_unitSide == OPEX_friendly_side1) then
		{
			// COUNTING KILLED UNITS
			_unit addEventHandler ["killed", "['friendKilled', _this] call Gemini_fnc_updateStats; [_this select 0] spawn {sleep 300; (_this select 0) setVariable ['revivable',false,true]}"];
			//_unit addEventHandler ["hit", "if (side (_this select 1) == OPEX_friendly_side1) then {['friendHit', _this] call Gemini_fnc_updateStats}"];

			// SETTING OTHER FUNCTIONS
			[_unit] spawn Gemini_fnc_needs;
			[_unit] spawn Gemini_fnc_setIdentity;
			[_unit] spawn Gemini_fnc_autoNVG;
			[_unit] spawn Gemini_fnc_autoFlashlight;
			[_unit] spawn Gemini_fnc_autoSilencer;
			//[_unit] spawn Gemini_fnc_incognito; // to be tested
			[_unit] call Gemini_fnc_manageUnits;
			[_unit] remoteExec ["Gemini_fnc_GPStracker", 0, _unit];

			// REVIVE ACTION
			if (!isNil "Gemini_fnc_addReviveAction") then { 
    [_unit] call Gemini_fnc_addReviveAction; 
} else { 
    if (OPEX_debug) then {systemChat "Warning: Gemini_fnc_addReviveAction function not found"}; 
};

			if ((OPEX_param_medical != 1) && (!(isClass (configFile >> "CfgPatches" >> "ace_medical")))) then {[_unit] call AIS_System_fnc_loadAIS};

			// ADDING AN OPTION TO RESET UNIT POSITION (MAY BE USEFULL BECAUSE SOMETIMES AI IS BLOCKED INTO BUILDINGS) - thanks to GUITOU (http://steamcommunity.com/profiles/76561198171567815) for the suggestion
			_unit addAction
				[localize "STR_action_resetPosition",
					{
						private ["_newPos"];
						_newPos = ["land", (_this select 0), 0, 5, 1] call Gemini_fnc_findPos;
						(_this select 0) setPos _newPos;
					},
					nil, 0, false, true, "",
					"(_target == _this) && (!isPlayer _target)"
				];

			// TEMPORARY ! REMOVING HANDGUN FROM AI UNITS BECAUSE THEY OFTEN SELECT IT INSTEAD OF THEIR RIFLE, I DON'T KNOW WHY
			_unit spawn {sleep 3; if (primaryWeapon _this != "") then {_this removeWeapon (handgunWeapon _this)}};
		};

// =========================================================================================================
// SETTING CREATED UNIT (IF UNIT IS CIVILIAN)
// =========================================================================================================

	if (_unitSide == OPEX_civilian_side1) then
		{
			// NAMING CIVILIAN (REQUIRED BY SOME SCRIPTS OR TRIGGERS)
			private ["_civilianName"];
			[_unit, "civilian_"] call Gemini_fnc_setUnitName;

			// STARTING CIVILIAN ACTIVITY
			_unit call Gemini_fnc_civilianActivity;

			// ADDING CIVILIAN INTERACTIONS
			[_unit, _disableCivilianHostility] spawn {sleep 3; [_this select 0, _this select 1] spawn Gemini_fnc_civilianInteractions};

			// DEFINING CIVILIAN REACTION WHEN HEARING A FIRE SHOT
			_unit addEventHandler
				[
					"FiredNear",
					"
						private ['_civilian'];
						_civilian = _this select 0;
						if ((!(_civilian getVariable 'isHandcuffed')) && (vehicle _civilian == _civilian)) then
							{
								[_civilian] spawn
									{
										private ['_civilian', '_reaction'];
										_civilian = _this select 0;
										_civilian removeEventHandler ['FiredNear', 0];
										sleep (random 0.5);
										_civilian enableSimulationGlobal true;
										_civilian switchMove '';
										_civilian setSpeedMode 'full';
										_civilian allowFleeing 1;
										if ((!(_civilian getVariable 'isHandcuffed')) && (random 10 >= 5)) then {_civilian doMove [(getPos _civilian select 0) + random 250 - random 250, (getPos _civilian select 1) + random 250 - random 250, 0]};
										if ((!(_civilian getVariable 'isHandcuffed')) && (random 10 >= 7)) then {sleep (random 2); _civilian say (selectRandom ['scream_1', 'scream_2', 'scream_3'])};
										switch (round (random 4)) do
											{
												if (!(_civilian getVariable 'isHandcuffed')) then
													{
														case 0: {_civilian switchMove 'ApanPercMstpSnonWnonDnon_G01'};
														case 1: {_civilian playMoveNow 'ApanPknlMstpSnonWnonDnon_G01'};
														case 2: {_civilian playMoveNow 'ApanPpneMstpSnonWnonDnon_G01'};
														default
															{
																private ['_reaction'];
																_reaction = selectRandom ['up', 'up', 'up', 'middle', 'middle', 'middle', 'down'];
																if (_reaction == 'up') then {_civilian setUnitPos 'up'};
																if (_reaction == 'middle') then {_civilian setUnitPos 'middle'};
																if (_reaction == 'down') then {_civilian setUnitPos 'down'};
															}
													};
											};
									};
							};
					"
				];

			// ADDING PENALTY IF CIVILIAN IS HIT OR KILLED
			_unit spawn
				{
					private _unit = _this;
					if ((_unit getVariable ["side", "friendly"]) == "friendly") then
						{
							// COUNTING INJURED UNITS
							_unit addEventHandler ["hit", "['civilianHit', _this] call Gemini_fnc_updateStats"];

							// COUNTING KILLED UNITS
							_unit addEventHandler
									[
										"killed",
										"
											private ['_unit'];
											_unit = _this select 0;
											_unit enableSimulationGlobal true;
											_unit switchMove '';
											['civilianKilled', _this] call Gemini_fnc_updateStats;
											_unit removeEventHandler ['killed', 0];
										"
									];
						};
				};
		};

	_unit enableSimulationGlobal true;

	// SETTING LANGUAGE
	[_unit] call Gemini_fnc_setSpeaker;

// =================================================================================================
// SETTING UNIT LIFETIME
// =================================================================================================

	[_unit, _lifeTime] call Gemini_fnc_setLifeTime;

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (OPEX_debug) then
		{
			private ["_debugMarker"];
			_debugMarker = createMarker [format ["OPEX_debugMarker_unit_%1", random 100000], position _unit];
			_debugMarker setMarkerType "mil_dot";
			if (side _unit == west) then {_debugMarker setMarkerColor "ColorBlue"};
			if (side _unit == east) then {_debugMarker setMarkerColor "ColorRed"};
			if (side _unit == resistance) then {_debugMarker setMarkerColor "ColorGreen"};
			if (side _unit == civilian) then {_debugMarker setMarkerColor "ColorYellow"};
			if (side _unit == sideLogic) then {_debugMarker setMarkerAlpha 0};
			[_unit, _debugMarker] spawn
				{
					while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
					deleteMarker (_this select 1);
				};
		};

// =========================================================================================================
// RETURNING CREATED UNIT
// =========================================================================================================

	_unit