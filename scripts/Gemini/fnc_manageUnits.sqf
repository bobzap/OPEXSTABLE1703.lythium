private _unit = _this select 0;

//if (!isNil "OPEX_taskID") then {if (OPEX_taskID == "05") exitWith {}}; // not required for OPEX_task 05

// ADDING ACTION TO ENLIST UNIT
[_unit, ["STR_action_enlist", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 5) && (group _target != group _this) && (!isPlayer _target) && (!isPlayer (leader _target))", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_enlist.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];

// ADDING ACTION TO DEMOBILIZE UNIT
[_unit, ["STR_action_demobilize", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 3) && (group _target == group _this) && (count units group _target > 1) && (!isPlayer _target) && (isPlayer (leader _target))", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_demobilize.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];

// ADDING ACTION TO ENLIST WHOLE SQUAD
[_unit, ["STR_action_enlistSquad", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 3) && (group _target != group _this) && (count units group _target > 1) && (!isPlayer _target) && (!isPlayer (leader _target))", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_enlistSquad.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];

// ADDING ACTION TO DEMOBILIZE WHOLE SQUAD
[_unit, ["STR_action_demobilizeSquad", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 3) && (count units group _target > 2) && (_this in units group _target)", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_demobilizeSquad.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];

// ADDING ACTION TO ENLIST WHOLE SQUAD AS HIGH COMMAND
[_unit, ["STR_action_enlistSquadHC", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 3) && (group _target != group _this) && (count units group _target > 1) && (!isPlayer _target) && (!isPlayer (leader _target)) && (!((group _target) in (hcAllGroups _this)))", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_enlistSquadHC.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];

// ADDING ACTION TO DEMOBILIZE WHOLE SQUAD FROM HIGH COMMAND
[_unit, ["STR_action_demobilizeSquadHC", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passleadership_ca.paa", "(!captive _target) && (alive _target) && (_target distance _this < 3) && ((group _target) in (hcAllGroups _this))", "true", {}, {}, {0 = _this execVM "scripts\Gemini\fnc_demobilizeSquadHC.sqf"}, {}, [], 0.5, 0, false, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, true];