// =========================================================================================================
// TASK ID : 			09
// TASK OBJECTIVE :		CAPTURE A SUSPECT
// TASK CREATOR : 		GEMINI (gemini.69@free.fr)
// =========================================================================================================

// =========================================================================================================
// STARTING TASK CREATION
// =========================================================================================================

	private _unit = player;
	["hint", "STR_hint_creatingTask"] remoteExec ["Gemini_fnc_globalHint", _unit];

// =========================================================================================================
// CREATING TASK ON THE SERVER
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// GETTING MAIN VARIABLES
// =========================================================================================================

	private _debug = OPEX_debug;
	OPEX_taskID = _this select 0; publicVariable "OPEX_taskID";
	OPEX_assignedTask = true; publicVariable "OPEX_assignedTask";
	suspect = nil;

// =========================================================================================================
// DEFINING MAIN TASK POSITION
// =========================================================================================================

	// LOOKING FOR A LOCATION
	private _locationPos = [["city", "village"], OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_locationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// GETTING LOCATION SIZE
	private _locationArea = [((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _locationSize = (_locationArea select 0) min (_locationArea select 1);

	// LOOKING FOR A RANDOM POSITION
	private ["_suspectPos"];
	_suspectPos = ["building", _locationPos, 0, _locationSize] call Gemini_fnc_findPos;
	if (!(_suspectPos isEqualTo [0,0,0])) then
			{
				private _allBuildingPositions = nearestBuilding _suspectPos buildingPos -1;
				if (count _allBuildingPositions > 0) then {_suspectPos = selectRandom _allBuildingPositions} else {_suspectPos = [0,0,0]};
			};
	if (_suspectPos isEqualTo [0,0,0]) then {_suspectPos = ["land", _locationPos, 0, _locationSize] call Gemini_fnc_findPos};
	if (_suspectPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos [(_locationPos select 0), (_locationPos select 1) - 15];
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _locationArea;
	"TaskMarker_A" setMarkerColor "colorGreen";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos (getMarkerPos "TaskMarker_A");
	"TaskMarker_B" setMarkerType "mil_objective";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorGreen";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "target", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING CIVILIAN
	private _civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _suspectPos, OPEX_civilian_AIskill, true, "task"] call Gemini_fnc_createUnit;

	// GENERAL PARAMETERS
	sleep 1;
	suspect = _civilian;
	_civilian setVariable ["side", "hostile", true];
	_civilian setVariable ["sympathy", 0];
	_civilian setVariable ["isHandcuffed", false, true];
	_civilian setVariable ["recorded", false, true];

	// NAME
	[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
	private _civilianName = [name _civilian];
	_civilianName set [count _civilianName, selectRandom OPEX_enemy_names];
	_civilian setVariable ["name", _civilianName, true];
	_civilian setVariable ["known_realName", false, true];
	_civilian setVariable ["known_fakeName", false, true];

	// FACE
	[_civilian] spawn {sleep 1; [_this select 0, "PersianHead_A3_03"] remoteExec ["setFace", 0, _this select 0]};

	// GEAR
	_civilian forceAddUniform (selectRandom (OPEX_civilian_uniforms - ["LOP_U_CHR_Priest_01"]));
	_civilian addHeadGear (selectRandom ["H_Cap_red"]);
	removeGoggles _civilian;
	if (OPEX_sunHeight > 1) then {_civilian addGoggles (selectRandom ["G_Aviator"])} else {_civilian addItemToUniform "G_Aviator"};
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then {_civilian addItem "Gemini_deadManSwitch"; _civilian addItem "Gemini_cellphone"};
	[_civilian] call Gemini_fnc_checkCivilianGear;

	// NATIONALITY
	private _nationality = [selectRandom OPEX_mapNationalities];
	_nationality set [count _nationality, selectRandom OPEX_mapNationalities];
	_civilian setVariable ["nationality", _nationality, true];
	_civilian setVariable ["known_realNationality", false, true];
	_civilian setVariable ["known_fakeNationality", false, true];

	// BIRTHDATE
	private _date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
	private _month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
	private _year = ["1995", "1994", "1993", "1992", "1991", "1990", "1989", "1988", "1987", "1986", "1985", "1984", "1983", "1982", "1981", "1980"];
	private _separator = "/";
	private _birthDate = [(selectRandom _date) + _separator + (selectRandom _month) + _separator + (selectRandom _year)];
	_birthDate set [count _birthDate, (selectRandom _date) + _separator + (selectRandom _month) + _separator + (selectRandom _year)];
	_civilian setVariable ["birthdate", _birthDate, true];
	_civilian setVariable ["known_realBirthdate", false, true];
	_civilian setVariable ["known_fakeBirthdate", false, true];

	// JOB
	private _job = [selectRandom OPEX_civilian_jobs];
	_job set [count _job, selectRandom OPEX_civilian_jobs];
	_civilian setVariable ["job", _job, true];
	_civilian setVariable ["known_realJob", false, true];
	_civilian setVariable ["known_fakeJob", false, true];

	// LANGUAGE
	_civilian setVariable ["polyglot", true, true];

	// INTEL
	_civilian setVariable ["intel", "STR_civilian_intel_noData", true];

	// MOVES
	[_civilian] spawn Gemini_fnc_civilianMoves;
	[_civilian, _locationPos, _locationSize * 0.6] spawn Gemini_fnc_doPatrol;

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// no specific enemy for this task !

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF SUSPECT IS ALIVE AND IN JAIL
	private _triggerWin =
		[
			_locationPos,
			[0, 0, 0, false],
			["any", "present", true],
			["(OPEX_assignedTask) && (alive suspect) && (suspect getVariable ['isJailed', false])", "[] remoteExec ['Gemini_fnc_taskSucceeded']; ['intel', 25] call Gemini_fnc_bonus", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// FAILING TASK IF SUSPECT IS DEAD
	private _triggerLose =
		[
			_locationPos,
			[0, 0, 0, false],
			["any", "present", true],
			["(OPEX_assignedTask) && (!alive suspect)", "detach suspect; [] remoteExec ['Gemini_fnc_taskFailed']", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug) then
		{
			suspect = _civilian;
			private _marker = [_civilian, "mil_objective", "colorRed", "SUSPECT", "task"] call Gemini_fnc_createMarker;
			[_civilian, _marker] spawn
				{
					while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
					deleteMarker (_this select 1);
				};
		};