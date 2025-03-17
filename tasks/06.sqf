// =========================================================================================================
// TASK ID : 			06
// TASK OBJECTIVE :		DEFEND A FUEL TRUCK WHILE IT'S BEEN REPAIRING
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

// =========================================================================================================
// DEFINING TASK POSITION(S)
// =========================================================================================================

	// LOOKING FOR A ROAD
	private _roadPos = ["road", OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_roadPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

	// LOOKING FOR 2 CONSECUTIVE ROAD SEGMENTS
	private _road = (_roadPos nearRoads 20) select 0; if (isNil "_road") exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _road1 = (roadsConnectedTo _road) select 0; if (isNil "_road1") exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _road2 = (roadsConnectedTo _road) select 1; if (isNil "_road2") exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};

// =========================================================================================================
// SPAWNING OBJECTIVE
// =========================================================================================================

	// SPAWNING ESCORT VEHICLE
	private _escort = [OPEX_friendly_transportCars + OPEX_friendly_combatCarsMG + OPEX_friendly_combatCarsGL, _road1, 0, true, "task"] call Gemini_fnc_createVehicle;
	_escort enableSimulation false;
	_escort lock true;
	_escort setDir ([_road2, _road1] call BIS_fnc_DirTo);
	_escort setPos [(getPos _road1 select 0), (getPos _road1 select 1), 0.5];
	clearWeaponCargoGlobal _escort; clearMagazineCargoGlobal _escort; clearItemCargoGlobal _escort; clearBackpackCargoGlobal _escort;

	// SPAWNING TRUCK
	private _truck = [selectRandom OPEX_friendly_fuelTrucks, _road2, 0, true, "task"] call Gemini_fnc_createVehicle;
	_truck setHitPointDamage ["HitLFWheel", 1];
	_truck enableSimulation false;
	_truck lock true;
	_truck setDir ([_road2, _road1] call BIS_fnc_DirTo);
	_truck setPos [(getPos _road2 select 0), (getPos _road2 select 1), 0.5];
	clearWeaponCargoGlobal _truck; clearMagazineCargoGlobal _truck; clearItemCargoGlobal _truck; clearBackpackCargoGlobal _truck;

	// SPAWNING FRIENDLY SQUAD
	private _unit1 = [OPEX_friendly_side1, grpNull, [OPEX_friendly_rifleman], _roadPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	private _unit2 = [OPEX_friendly_side1, group _unit1, [OPEX_friendly_grenadier], _roadPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	private _unit3 = [OPEX_friendly_side1, group _unit1, [OPEX_friendly_rifleman], _roadPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	private _unit4 = [OPEX_friendly_side1, group _unit1, [OPEX_friendly_ammoAssistant], _roadPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	private _unit5 = [OPEX_friendly_side1, group _unit1, [OPEX_friendly_MGLight], _roadPos, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
	private _squad = group _unit1;
	_squad spawn
		{
			private _squad = _this;
			while {OPEX_assignedTask && (behaviour (leader _squad) != "combat")} do {sleep 3};
			{_x enableAI "move"; _x setUnitPos "auto"} forEach units _squad;
		};

	// SETTING SQUAD'S LEADER PATROL PATH
	[_squad, _truck, [10,50]] spawn Gemini_fnc_doPatrol;

	// MOVING OTHER UNITS AROUND THE CONVOY
	[_truck, _escort, _unit2, _unit3, _unit4, _unit5] spawn
		{
			private _truck = _this select 0;
			private _escort = _this select 1;
			private _unit2 = _this select 2;
			private _unit3 = _this select 3;
			private _unit4 = _this select 4;
			private _unit5 = _this select 5;
			doStop _unit2;
			doStop _unit3;
			doStop _unit4;
			doStop _unit5;
			_unit2 setUnitPos "middle";
			_unit3 setUnitPos "middle";
			_unit4 setUnitPos "middle";
			_unit5 setUnitPos "middle";
			_unit2 disableAI "move";
			_unit3 disableAI "move";
			_unit4 disableAI "move";
			_unit5 disableAI "move";
			[_truck, _unit2, [10, 0, 0], 90, true, true] call BIS_fnc_relPosObject; // right
			[_truck, _unit3, [-10, 0, 0], 270, true, true] call BIS_fnc_relPosObject; // left
			[_escort, _unit4, [0, 10, 0], 0, true, true] call BIS_fnc_relPosObject; // front
			[_truck, _unit5, [0, -10, 0], 180, true, true] call BIS_fnc_relPosObject; // back
		};

	// REPARATION SCRIPT
	[_truck, _squad] spawn
		{
			// SPAWNING FRIENDLY REPAIRER
			private _truck = _this select 0;
			private _squad = _this select 1;
			private _repairer = [OPEX_friendly_side1, grpNull, [OPEX_friendly_repairer], _truck, OPEX_friendly_AIskill, false, "task"] call Gemini_fnc_createUnit;
			[_truck, _repairer, [-2.4, 2.5, 0], 90, true, true] call BIS_fnc_relPosObject;
			_repairer setUnitPos "middle";
			_repairer disableAI "move";
			_repairer setPosATL [getPos _repairer select 0, getPos _repairer select 1, 0];
			[[_repairer, "REPAIR_VEH_KNEEL"], BIS_fnc_ambientAnim] remoteExec ["call", 0, _repairer];
			0 = _repairer spawn {sleep 1; waitUntil {!alive _this}; [_this, BIS_fnc_ambientAnim__terminate] remoteExec ["call", 0, _repairer]};
			{_repairer unlinkItem _x} forEach OPEX_friendly_NVGs;
			private _chemlight = createMine ["placed_chemlight_blue", position _repairer, [], 0];
			[_repairer, _chemlight, [-0.5, 0.0, 0], 0, true, true] call BIS_fnc_relPosObject;

			// WAITING FOR PLAYER IS NEAR
			private _repTime = 900; // how much time it needs to repair the truck (default: 900 seconds = 15 minutes)
			private _repStart = 5; // how much (%) the truck is already repaired (default: 5)
			if (OPEX_debug) then {_repStart = 95};
			private _repEnd = 100; // how much (%) means the truck is repaired - must NOT be modified (default 100)
			truck = _truck;
			_truck setVariable ["repairing", _repStart, true];
			waitUntil {sleep 5; (!OPEX_assignedTask || {_truck distance _x < 50} count (playableUnits + switchableUnits) > 0)};

			// REPAIRING (AUTOMATICALLY - BY AI REPAIRER)
			while {OPEX_assignedTask && (alive _truck) && (alive _repairer) && ((_truck getVariable "repairing") < _repEnd)} do
				{
					private _repairing = (_truck getVariable "repairing") + (1 / _repTime * _repEnd);
					_truck setVariable ["repairing", _repairing, true];
					sleep 1;
					if (((_truck getVariable "repairing") < _repEnd) && OPEX_assignedTask) then {["hintSilent", "STR_hint_repairing", round ((_truck getVariable "repairing") * (10 ^ 1)) / (10 ^ 1)] remoteExec ["Gemini_fnc_globalHintLoading"]};
				};

			// REPAIRING (MANUALLY - BY PLAYER IN CASE AI REPAIRER WOULD HAVE BEEN KILLED)
			if (alive _truck && !alive _repairer && ((_truck getVariable "repairing") < _repEnd)) then
				{
					[
						_truck, // object which action is attached
						 "STR_action_repair",  // action name
						{
							private _truck = _this select 0;
							private _caller = _this select 1;
							private _repTime = _this select 3 select 0;
							private _repEnd = _this select 3 select 1;
							if !("ToolKit" in items _caller) exitWith {hint localize "STR_hint_needToolkit"};
							_caller doWatch _truck;
							_caller setVariable ["position", position _caller, true];
							_position = _caller getVariable "position";
							sleep 1;
							while {OPEX_assignedTask && ((_truck getVariable "repairing") < _repEnd) && (alive _truck) && (alive _caller) && (vehicle _caller == _caller) && (speed _truck == 0) && (_position distance position _caller < 1)} do
								{
									_caller playActionNow "medicStartRightSide";
									_caller setUnitPos "middle";
									_repairing = (_truck getVariable "repairing") + (1 / _repTime * _repEnd);
									_truck setVariable ["repairing", _repairing, true];
									sleep 1;
									if (((_truck getVariable "repairing") < _repEnd) && OPEX_assignedTask) then {["hintSilent", "STR_hint_repairing", round ((_truck getVariable "repairing") * (10 ^ 1)) / (10 ^ 1)] remoteExec ["Gemini_fnc_globalHintLoading"]};
								};
							_caller playActionNow "medicStop";
							_caller setUnitPos "auto";
						},
						[_repTime, _repEnd],
						6, "true", true, "",
						"(_target distance _this < 7) && (alive _this)"
					] remoteExec ["Gemini_fnc_addAction", 0, _truck];
				};

			// WAIT UNTIL FULL REPAIRING OR UNASSIGNING TASK
			 while {((_truck getVariable "repairing") < _repEnd) && (alive _truck) && OPEX_assignedTask} do {sleep 1};

			 // IF REPARATION IS FULL AND TRUCK IS STILL ALIVE AND TASK IS STILL ACTIVE: SUCCEEDING !
			 if ((_truck getVariable "repairing" >= _repEnd) && (alive _truck) && OPEX_assignedTask) then
				 {
					["hintSilent", "STR_hint_repairing",  100] remoteExec ["Gemini_fnc_globalHintLoading"];
					_truck lock false;
					_truck setDammage 0;
					[] remoteExec ["Gemini_fnc_taskSucceeded"];
					["supply", "ammo"] call Gemini_fnc_bonus;
					_truck removeAllMPEventHandlers "MPkilled";
					removeAllActions _truck;
					if (alive _repairer) then
						{
							[_repairer, BIS_fnc_ambientAnim__terminate] remoteExec ["call", 0, _repairer];
							[_repairer] joinSilent _squad; _repairer enableAI "move";
							_repairer setUnitPos "auto";
						};
				 };

		};

		// IF TRUCK HAS BEEN REPAIRED AND THERE ARE STILL ALIVE AI AND AREA IS CLEAR... MOVING
		[_truck, _escort, _squad] spawn
			{
				private _truck = _this select 0;
				private _escort = _this select 1;
				private _squad = _this select 2;
				waitUntil {sleep 3; (!OPEX_assignedTask) && (behaviour (leader _squad) != "combat")};
				if (alive _truck) then
					{
						if ((count units _squad) == 0) exitWith {};
						{_x setBehaviour "safe"} forEach (units _squad);
						if ((count units _squad) == 1) then {(units _squad select 0) assignAsDriver _truck};
						if ((count units _squad) == 2) then {(units _squad select 0) assignAsDriver _escort; (units _squad select 1) assignAsDriver _truck};
						if ((count units _squad) == 3) then {(units _squad select 0) assignAsDriver _escort; (units _squad select 1) assignAsDriver _truck; (units _squad select 2) assignAsCargo _truck};
						if ((count units _squad) >= 4) then {(units _squad select 0) assignAsDriver _escort; (units _squad select 1) assignAsDriver _truck; (units _squad select 2) assignAsCargo _truck; (units _squad select 3) assignAsCargo _escort; (units _squad select 4) assignAsCargo _escort; ; (units _squad select 5) assignAsCargo _escort};
						private _destination = ["road", _truck, 250, 1250] call Gemini_fnc_findPos;
						if ((count units _squad) >= 1) then {{[_x] orderGetIn true; _x setSpeedMode "normal"; _x setBehaviour "safe"} forEach (units _squad); _wp = _squad addWaypoint [_destination, 0]};
					};
			};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[_debug, _truck] spawn
		{
			// WAITING UNTIL ANY PLAYER HAS ARRIVED NEAR TRUCK
			private _debug = _this select 0;
			private _truck = _this select 1;
			waitUntil {sleep 5; {_truck distance _x < 500} count (playableUnits + switchableUnits) > 0};

			// SPAWNING ENEMY WAVES
			private _maxWaves = selectRandom [1,2,3,4,5,6,7,8,9,10];
			currentEnemyWaves = 0;
			while {OPEX_assignedTask} do
				{
					if (OPEX_debug) then {sleep 5} else {sleep (30 + (random 60))};
					if (currentEnemyWaves < 0) then {currentEnemyWaves = 0}; // in case decreasing count has bugged (could sometimes happen if last units of a group are killed at the exact same time)
					if (OPEX_assignedTask && (currentEnemyWaves < _maxWaves) && ({_truck distance _x < 500} count (playableUnits + switchableUnits) > 0)) then
						{

							// SPAWNING SQUAD
							private _squad = [OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], -1, _truck, [500, 1500], "attack", _truck, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;

							// INCREASING WAVE COUNT
							currentEnemyWaves = currentEnemyWaves + 1;

							// DECREASING WAVE COUNT
							{
							   _x addEventHandler
							   [
									"killed",
									   {
											private _squad = group (_this select 0);
											if ({alive _x} count (units _squad) < 1) then {currentEnemyWaves = currentEnemyWaves - 1};
									   }
							   ];
							} forEach units _squad;
						};
				};
		};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER TYPE & TEXT
	"taskMarker_B" setMarkerPos (position _truck);
	"taskMarker_B" setMarkerType "mil_warning";
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerColor "colorBlue";
	"taskMarker_B" setMarkerAlpha 1;
	["taskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// TASK SUCCEEDED IF TRUCK HAS BEEN REPAIRED
	// already defined above

// =========================================================================================================
// DEFINING CONDITIONS OF DEFEAT
// =========================================================================================================

	// TASK FAILED IF TRUCK IS DESTROYED OR IF THERE ARE NO MORE FRIENDLY UNITS AROUND IT
	_truck addMPEventHandler ["MPkilled", {[] spawn Gemini_fnc_taskFailed}];
	_truck spawn
		{
			private _truck = _this;
			while {OPEX_assignedTask} do
				{
					sleep 3;
					if (OPEX_assignedTask && ({(_x distance _truck < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) ==  0)) then {_truck setDamage 1};
				};
		};

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "defend", "taskMarker_B"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["punchy"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname