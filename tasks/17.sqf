// =========================================================================================================
// TASK ID : 			17
// TASK OBJECTIVE :		DELIVER HUMANITARIAN SUPPLIES TO A VILLAGE
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
// CHECKING IF DELIVERY AREA IS CLEARED
// =========================================================================================================

	private _emptyPos = [];
	_emptyPos = (position OPEX_deliveryZone) isFlatEmpty [1, 1, 0.75, 10, 0, false];
	if (count _emptyPos == 0) exitWith {hint localize "STR_hint_DeliveryZoneEncumbered"};

// =========================================================================================================
// GETTING MAIN VARIABLES
// =========================================================================================================

	private _debug = OPEX_debug;
	OPEX_taskID = _this select 0; publicVariable "OPEX_taskID";
	OPEX_assignedTask = true; publicVariable "OPEX_assignedTask";

// =========================================================================================================
// DEFINING TASK LOCATION
// =========================================================================================================

	// LOOKING FOR A LOCATION
	private _locationPos = [["city", "city"], OPEX_mapCenter, 0, OPEX_mapRadius] call Gemini_fnc_findPos;
	if (_locationPos isEqualTo [0,0,0]) exitWith {["hint", "STR_hint_noTaskPos"] remoteExec ["Gemini_fnc_globalHint"]; [] remoteExec ["Gemini_fnc_taskReset"]};
	private _locationTrigger = (_locationPos nearObjects ["EmptyDetector", 5]) select 0;

	// GETTING LOCATION SIZE
	private _locationSize = [((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0), ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1)];
	private _locationRadius = (_locationSize select 0) max (_locationSize select 1);
	private _locationDir = (triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 2;

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// MARKER AREA
	"TaskMarker_A" setMarkerPos _locationPos;
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerSize _locationSize;
	"TaskMarker_A" setMarkerColor "colorGreen";
	"TaskMarker_A" setMarkerAlpha 0.75;
	"TaskMarker_A" setMarkerDir _locationDir;

	// MARKER TYPE & TEXT
	"TaskMarker_B" setMarkerPos [((getMarkerPos "TaskMarker_A") select 0), ((getMarkerPos "TaskMarker_A") select 1) - 15];
	"TaskMarker_B" setMarkerType "mil_objective";
	"TaskMarker_B" setMarkerSize [1,1];
	"TaskMarker_B" setMarkerColor "colorGreen";
	"TaskMarker_B" setMarkerAlpha 1;
	["TaskMarker_B", (format ["STR_taskObjective_" + OPEX_taskID])] remoteExec ["Gemini_fnc_setMarkerText"];

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "kill", "TaskMarker_A"] remoteExec ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "jungle" or a specific music classname

// =========================================================================================================
// SPAWNING SUPPLIES
// =========================================================================================================

	private _supply_medical = ["Land_PaperBox_01_small_closed_white_med_F", [(getPos OPEX_deliveryZone select 0) + 0, (getPos OPEX_deliveryZone select 1) + 0, 0], random 360, false, "task"] call Gemini_fnc_createVehicle;
	private _supply_food1 = ["Land_Sacks_heap_F", [(getPos OPEX_deliveryZone select 0) - 1.5, (getPos OPEX_deliveryZone select 1) + 1.5, 0], random 360, false, "task"] call Gemini_fnc_createVehicle;
	private _supply_food2 = ["Land_Sacks_goods_F", [(getPos OPEX_deliveryZone select 0) - 1.5, (getPos OPEX_deliveryZone select 1) - 1.5, 0], random 360, false, "task"] call Gemini_fnc_createVehicle;
	private _supply_water1 = ["Land_BarrelWater_F", [(getPos OPEX_deliveryZone select 0) + 1.5, (getPos OPEX_deliveryZone select 1) + 1.5, 0], random 360, false, "task"] call Gemini_fnc_createVehicle;
	private _supply_water2 = ["Land_BarrelWater_F", [(getPos OPEX_deliveryZone select 0) + 1.5, (getPos OPEX_deliveryZone select 1) - 1.5, 0], random 360, false, "task"] call Gemini_fnc_createVehicle;

// =========================================================================================================
// SPAWNING CIVILIANS
// =========================================================================================================

	// MAKING CIVILIANS MOVE TO SUPPLIES IF THEY HAVE BEEN DELIVERED
	[[_locationPos, _locationRadius, _locationTrigger], _supply_food1, _supply_food2, _supply_water1, _supply_water2, _supply_medical] spawn
		{
			private _locationPos = _this select 0 select 0;
			private _locationRadius = _this select 0 select 1;
			private _locationTrigger = _this select 0 select 2;
			private _supply_food1 = _this select 1;
			private _supply_food2 = _this select 2;
			private _supply_water1 = _this select 3;
			private _supply_water2 = _this select 4;
			private _supply_medical = _this select 5;
			while {OPEX_assignedTask} do
				{
					sleep 10;
					private _civilians = (_locationPos nearEntities ["Man", _locationRadius]) select {side _x == civilian};
					private _deliveredSupplies = [];
					if (OPEX_assignedTask && (alive _supply_food1) && ([_locationTrigger, _supply_food1] call BIS_fnc_inTrigger) && (isNull attachedTo _supply_food1)) then {_deliveredSupplies pushBack _supply_food1};
					if (OPEX_assignedTask && (alive _supply_food2) && ([_locationTrigger, _supply_food2] call BIS_fnc_inTrigger) && (isNull attachedTo _supply_food2)) then {_deliveredSupplies pushBack _supply_food2};
					if (OPEX_assignedTask && (alive _supply_water1) && ([_locationTrigger, _supply_water1] call BIS_fnc_inTrigger) && (isNull attachedTo _supply_water1)) then {_deliveredSupplies pushBack _supply_water1};
					if (OPEX_assignedTask && (alive _supply_water2) && ([_locationTrigger, _supply_water2] call BIS_fnc_inTrigger) && (isNull attachedTo _supply_water2)) then {_deliveredSupplies pushBack _supply_water2};
					if (OPEX_assignedTask && (alive _supply_medical) && ([_locationTrigger, _supply_medical] call BIS_fnc_inTrigger) && (isNull attachedTo _supply_medical)) then {_deliveredSupplies pushBack _supply_medical};
					if (OPEX_assignedTask && (count _civilians > 0) && (count _deliveredSupplies > 0)) then
						{
							{
								if ((OPEX_assignedTask) && (alive _x) && (random 100 < 25)) then
									{
										while {(count (waypoints group _x)) > 0} do {deleteWaypoint ((waypoints group _x) select 0)};
										_x switchMove "";
										_x enableAI "move";
										_deliveredSupply = selectRandom _deliveredSupplies;
										(group _x) addWaypoint [position _deliveredSupply, 15];
										_x setSpeedMode "limited";
										_x setBehaviour "safe";
									};
							} forEach _civilians;
						};
				};
		};

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	[_locationPos, _locationRadius] spawn
		{
			// GETTING VARIABLES
			private _locationPos = _this select 0;
			private _locationRadius = _this select 1;

			// LOOKING FOR THE MIDDLE POSITION BETWEEN THE LOCATION AND THE HQ
			private _ambushCenter = [(((position OPEX_deliveryZone) select 0) + (_locationPos select 0)) / 2, (((position OPEX_deliveryZone) select 1) + (_locationPos select 1)) / 2, 0];
			private _ambushRadius = (_locationPos distance2D OPEX_deliveryZone) / 2.5;

			// SPAWNING AN AMBUSH BETWEEN THE DESTINATION AND THE HQ
			private _ambushPos = ["overwatch", _ambushCenter, 0, _ambushRadius] call Gemini_fnc_findPos;
			if (!(_ambushPos isEqualTo [0,0,0])) then {[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,8,10,12,15,20], _ambushPos, [0,0], "hold", _ambushCenter, OPEX_enemy_AIskill, 80, "task"] call Gemini_fnc_spawnSquad};

			// SPAWNING A PATROL AROUND DESTINATION
			[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,8,12], _locationPos, [_locationRadius * 2, _locationRadius * 5], "patrol", _locationPos, OPEX_enemy_AIskill, 15, "task"] call Gemini_fnc_spawnSquad;
		};

// =========================================================================================================
// DEBUGGING
// =========================================================================================================

	if (OPEX_debug) then {OPEX_task17_supplies = [_supply_food1, _supply_food2, _supply_water1, _supply_water2, _supply_medical]; publicVariable "OPEX_task17_supplies"};

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY/DEFEAT
// =========================================================================================================

	while {OPEX_assignedTask} do
		{
			sleep 3;

			// SUCCEEDING TASK IF SUPPLIES HAVE BEEN DELIVERED
			if
				(
					OPEX_assignedTask
					&&
					(alive _supply_food1) && (alive _supply_food2) && (alive _supply_water1) && (alive _supply_water2) && (alive _supply_medical)
					&&
					(isNull attachedTo _supply_food1) && (isNull attachedTo _supply_food2) && (isNull attachedTo _supply_water1) && (isNull attachedTo _supply_water2) && (isNull attachedTo _supply_medical)
					&&
					([_locationTrigger, _supply_food1] call BIS_fnc_inTrigger) && ([_locationTrigger, _supply_food2] call BIS_fnc_inTrigger) && ([_locationTrigger, _supply_water1] call BIS_fnc_inTrigger) && ([_locationTrigger, _supply_water2] call BIS_fnc_inTrigger) && ([_locationTrigger, _supply_medical] call BIS_fnc_inTrigger)
				)
			then {[] remoteExec ["Gemini_fnc_taskSucceeded"]; ["reputation", 1] call Gemini_fnc_bonus};

			// FAILING TASK IF SUPPLIES ARE DESTROYED
			if (OPEX_assignedTask && ((!alive _supply_food1) || (!alive _supply_food2) || (!alive _supply_water1) || (!alive _supply_water2) || (!alive _supply_medical))) then {[] remoteExec ["Gemini_fnc_taskFailed"]};

			// FAILING TASK IF VEHICLE THE SUPPLIES ARE ATTACHED TO IS DESTROYED
			/*
			// not working at this time because R3G logistic script is attaching objects to a single invisible H instead of concerned vehicles - need to think about how to do improve it later
			// in the meantime, if player's vehicle is destroyed with supplies "inside" then he has to cancel the task
			if (((!alive (attachedTo _supply_food1)) && (!isNull (attachedTo _supply_food1))) || ((!alive (attachedTo _supply_food2)) && (!isNull (attachedTo _supply_food2))) || ((!alive (attachedTo _supply_water1)) && (!isNull (attachedTo _supply_water1))) || ((!alive (attachedTo _supply_water2))) && ((!isNull (attachedTo _supply_water2)) || (!alive (attachedTo _supply_medical))) && ((!isNull (attachedTo _supply_medical)))) then {[] remoteExec ["Gemini_fnc_taskFailed"]};
			*/
		};