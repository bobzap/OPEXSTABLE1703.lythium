private _unit = _this select 0;
if (_unit getVariable ["customActionsReady",false]) exitWith {};

// COLORS
private _white	= 	"<t color='#FFFFFF'>";
private _red	= 	"<t color='#FF0000'>";
private _green 	= 	"<t color='#00A903'>";

// DEBUG
[OPEX_debug] call Gemini_fnc_debug;

// SAVING ACTIONS
_unit setVariable ["customActionsReady",true];

// WEAPON ON BACK/HAND
if (!(isClass (configFile >> "CfgPatches" >> "ace_common"))) then
	{
		[_unit, _white + localize "STR_action_holsterWeapon" + "</t>", "pictures\icon_weapon_disabled.paa", "pictures\icon_weapon_disabled.paa", "(vehicle _target == player) && (count (weapons _target) > 0) && (currentWeapon player != '')", "true", {}, {}, {_target action ["SwitchWeapon", _target, _target, 100]}, {}, [], 1, 0, false, false, false] call BIS_fnc_holdActionAdd;
		[_unit, _white + localize "STR_action_takeOutWeapon" + "</t>", "pictures\icon_weapon.paa", "pictures\icon_weapon.paa", "(vehicle _target == player) && (count (weapons _target) > 0) && (primaryWeapon player != '') && (currentWeapon player == '')", "true", {}, {}, {_target action ["SwitchWeapon", _target, _target, 0]}, {}, [], 1, 0, false, false, false] call BIS_fnc_holdActionAdd;
	};

// SHOUT
OPEX_action_shoutStop = _unit addAction ["<t color=""#FF0000"">" + localize "STR_action_shoutStop" + "</t>", {[cursorTarget, _this select 1, _this select 2] remoteExec ["Gemini_fnc_shoutStop", 2]},nil, 5, false, true, "", "(vehicle _target == player) && ((driver cursorTarget) isKindOf 'man') && (alive cursorTarget) && (cursorTarget distance _this < 50) && (side cursorTarget != side _this) && (speed cursorTarget > 2)"];
OPEX_action_shoutDown = _unit addAction ["<t color=""#FF0000"">" + localize "STR_action_shoutDown" + "</t>", {[cursorTarget, _this select 1, _this select 2] remoteExec ["Gemini_fnc_shoutDown", 2]}, nil, 5, false, true, "", "(vehicle _target == player) && ((driver cursorTarget) isKindOf 'man') && (alive cursorTarget) && (cursorTarget distance _this < 100) && (cursorTarget distance _this > 0) && (side cursorTarget != side _this) && (unitPos cursorTarget != 'down')"];
OPEX_action_shoutGo = _unit addAction ["<t color=""#FF0000"">" + localize "STR_action_shoutGo" + "</t>", {[cursorTarget, _this select 1, _this select 2] remoteExec ["Gemini_fnc_shoutGo", 2]}, nil, 5, false, true, "", "(vehicle _target == player) && ((driver cursorTarget) isKindOf 'man') && (alive cursorTarget) && (cursorTarget distance _this < 100) && (cursorTarget distance _this > 0) && (side cursorTarget != side _this) && (speed cursorTarget == 0)"];

// REVIVE
[_unit] call Gemini_fnc_revive;

// BUY
private _duration = 1;
[_unit, _white + localize "STR_action_buySupplies" + "</t>", "pictures\icon_weapon.paa", "pictures\icon_weapon.paa", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {_this execVM "scripts\Gemini\fnc_dialog_buySupplies.sqf"}, {}, [], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
[_unit, _white + localize "STR_action_buyUnits" + "</t>", "pictures\icon_man.paa", "pictures\icon_man.paa", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {_this execVM "scripts\Gemini\fnc_dialog_buyUnits.sqf"}, {}, [], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
if (OPEX_param_gearManagement == 0)
	then
		{
			[_unit, _white + localize "STR_action_buyVehicles" + "</t>", "pictures\icon_vehicle.paa", "pictures\icon_vehicle.paa", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {_this execVM "scripts\Gemini\fnc_dialog_buyVehicles.sqf"}, {}, [], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
			[_unit, _white + localize "STR_action_sellVehicle" + "</t>", "pictures\icon_vehicle.paa", "pictures\icon_vehicle.paa", "(vehicle _target != player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target != player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {_this execVM "scripts\Gemini\fnc_sellVehicle.sqf"}, {}, [], _duration, 10, false, false] call BIS_fnc_holdActionAdd;
		}
	else
		{
			[_unit, _white + localize "STR_action_openVirtualGarage" + "</t>", "pictures\icon_vehicle.paa", "pictures\icon_vehicle.paa", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {["OPEX_marker_delivery","All"] call VVS_fnc_openVVS}, {}, [], _duration, 10, false, false] call BIS_fnc_holdActionAdd;
		};
if (OPEX_param_supportManagement == 0) then
		{
			[_unit, _white + localize "STR_action_buySupports" + "</t>", "pictures\icon_support.paa", "pictures\icon_support.paa", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", "(vehicle _target == player) && (_target distance2D OPEX_deliveryZone < 10)", {}, {}, {_this execVM "scripts\Gemini\fnc_dialog_buySupports.sqf"}, {}, [], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
		};

// FITNESS
private _duration = 1;
[_unit, _white + format [localize "STR_action_trainingPushUp"] + "</t>", "pictures\icon_fitness.paa", "pictures\icon_fitness.paa", "(currentWeapon _target == '') && (animationState player != 'amovpercmstpsnonwnondnon_exercisepushup') && (animationState player != 'amovpercmstpsnonwnondnon_exercisekneebendb') && (animationState player != 'amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon')", "true", {}, {}, {player playMove "AmovPercMstpSnonWnonDnon_exercisePushup"}, {}, [], _duration, 0, false, false, false] call BIS_fnc_holdActionAdd;
[_unit, _white + format [localize "STR_action_trainingSquat"] + "</t>", "pictures\icon_fitness.paa", "pictures\icon_fitness.paa", "(currentWeapon _target == '') && (animationState player != 'amovpercmstpsnonwnondnon_exercisepushup') && (animationState player != 'amovpercmstpsnonwnondnon_exercisekneebendb') && (animationState player != 'amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon')", "true", {}, {}, {player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB"}, {}, [], _duration, 0, false, false, false] call BIS_fnc_holdActionAdd;

// PRIMARY NEEDS
[_unit, _white + format [localize "STR_action_needsManager"] + "</t>", "pictures\icon_needs.paa", "pictures\icon_needs.paa", "(player == _target) && (OPEX_param_primaryNeeds == 1)", "true", {}, {}, {execVM "scripts\Gemini\fnc_needsManagerDialog.sqf"}, {}, [], 1, 0, false, false, false] call BIS_fnc_holdActionAdd;

// JOIN/LEAVE A PLAYER'S GROUP
if (isMultiplayer) then 
	{
		[_unit, _white + format [localize "STR_action_joinGroup"] + "</t>", "pictures\icon_joingroup.paa", "pictures\icon_joingroup.paa", "(isPlayer cursorTarget) && (cursorTarget != player) && (group cursorTarget != group player) && (cursorTarget distance2D player < 7.5)", "true", {}, {}, {private _group = group cursorTarget; private _leader = leader _group; [_this select 1] join _group; [_group, _leader] remoteExec ["selectLeader", groupOwner _group]}, {}, [], 2, -10, false, false, false] call BIS_fnc_holdActionAdd;
		[_unit, _white + format [localize "STR_action_leaveGroup"] + "</t>", "pictures\icon_leavegroup.paa", "pictures\icon_leavegroup.paa", "(isPlayer cursorTarget) && (cursorTarget != player) && (group cursorTarget == group player) && (cursorTarget distance2D player < 7.5)", "true", {}, {}, {[_this select 1] join grpNull}, {}, [], 2, -10, false, false, false] call BIS_fnc_holdActionAdd;
	};
// TASK 22 (CALL FOR CIVILIANS)
_unit addAction [_white + localize "STR_action_callCivilians" + "</t>", {[_this select 1] remoteExec ["Gemini_fnc_evacuate_call", 2]}, nil, 10, false, true, "", "OPEX_assignedTask && (OPEX_taskID == '22') && (player inArea 'TaskMarker_A')"];