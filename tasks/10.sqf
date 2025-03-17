// =========================================================================================================
// TASK ID : 			10
// TASK OBJECTIVE :		NEUTRALIZE A SNIPER
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
	sniper = nil;

// =========================================================================================================
// DEFINING MAIN TASK POSITION
// =========================================================================================================

	// LOOKING FOR A RANDOM POSITION
	private _randomPos = ["land", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_randomPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// LOOKING FOR AN OVERWATCH POSITION AROUND THAT POSITION
	private _overwatchPos = ["overwatch", _randomPos, 150, 450] call Gemini_fnc_findPos;
	if (_overwatchPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _randomPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize [500, 500];
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 0.75;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos _randomPos;
	"TaskMarker_B" setMarkerType "mil_destroy";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorRed";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "kill", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING SNIPER
	private _sniper = [OPEX_enemy_side1, grpNull, [OPEX_enemy_marksman], _overwatchPos, OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
	_sniper doWatch _randomPos;
	private _sniperAzimuth = [_sniper, _randomPos] call BIS_fnc_dirTo;
	_sniper setDir _sniperAzimuth;
	_sniper setUnitPos (selectRandom ["down", "down", "down", "down", "down", "middle"]);
	_sniper setBehaviour "combat";
	_sniper setCombatMode "red";
	sniper = _sniper;

	// SPAWNING SPOTTER
	private _spotter = [OPEX_enemy_side1, grpNull, [OPEX_enemy_rifleman], _overwatchPos, OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
	_spotter setPos (_overwatchPos getPos [5, random 360]);
	_spotter doWatch _randomPos;
	private _spotterAzimuth = [_spotter, _randomPos] call BIS_fnc_dirTo;
	_spotter setDir _spotterAzimuth;
	_spotter setUnitPos (selectRandom ["down", "down", "down", "down", "down", "middle"]);
	_spotter setBehaviour "stealth";
	_spotter setCombatMode "green";
	[_spotter] join _sniper;
	doStop _sniper;
	doStop _spotter;

	// SETTING SNIPER & SPOTTER SKILLS
	[_sniper, _spotter, _randomPos] spawn
		{
			sleep 5;
			private _sniper = _this select 0;
			private _spotter = _this select 1;
			private _randomPos = _this select 2;
			_sniper setSkill ["aimingAccuracy", 1];
			_sniper setSkill ["aimingShake", 1];
			_sniper setSkill ["aimingSpeed", 0];
			_sniper setSkill ["spotDistance", 1];
			_sniper setSkill ["spotTime", 1];
			_sniper setSkill ["reloadSpeed", 0];
			_spotter setSkill ["spotDistance", 1];
			_spotter setSkill ["spotTime", 1];
			_spotter setSkill ["commanding", 1];
			_spotter addWeapon "Binocular";
			sleep 3;
			_spotter selectWeapon "Binocular";
			// OPTIMIZING AI DETECTION
			while {OPEX_assignedTask} do
				{
					sleep 5;
					if (alive _sniper) then {{_sniper reveal [_x, 4]} forEach (_randomPos nearEntities 100)};
					if (alive _spotter) then {{_spotter reveal [_x, 4]} forEach (_randomPos nearEntities 100)};
				};
		};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// no other specific enemy is require for this task

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// SUCCEEDING TASK IF SNIPER HAS BEEN KILLED
	_sniper spawn
		{
			private _sniper = _this;
			while {(alive _sniper) && (OPEX_assignedTask)} do {sleep 3};
			if ((!alive _sniper) && (OPEX_assignedTask)) then {[] remoteExec ["Gemini_fnc_taskSucceeded"]; ['support', 'landAssistance'] call Gemini_fnc_bonus};
		};

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// there is no way to fail this task !

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (_debug && !isNil "_sniper") then
		{
			//systemChat format ["DISTANCE BETWEEN SNIPER AND TARGET: %1 meters", round (_sniper distance _randomPos)];
			//sniper = _sniper;
			private _markerSniper = [_sniper, "mil_objective", "colorRed", "SNIPER", "task"] call Gemini_fnc_createMarker;
			private _markerSpotter = [_spotter, "mil_objective", "colorRed", "SPOTTER", "task"] call Gemini_fnc_createMarker;
			[_sniper, _markerSniper] spawn
				{
					while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
					deleteMarker (_this select 1);
				};
			[_spotter, _markerSpotter] spawn
				{
					while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
					deleteMarker (_this select 1);
				};
		};