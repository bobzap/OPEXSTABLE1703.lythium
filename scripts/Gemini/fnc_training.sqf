/*
	To add this function to an object (example: a computer), add this code into the init field:

	[this, "<t color='#FFFFFF'>" + format [localize "STR_action_trainingMedic", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'medic')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'medic')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["medic"], 10, 6, false, false] call BIS_fnc_holdActionAdd;
	[this, "<t color='#FFFFFF'>" + format [localize "STR_action_trainingEngineer", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'engineer')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'engineer')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["engineer"], 10, 6, false, false] call BIS_fnc_holdActionAdd;
	[this, "<t color='#FFFFFF'>" + format [localize "STR_action_trainingExplosive", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'explosiveSpecialist')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'explosiveSpecialist')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["explosiveSpecialist"], 10, 6, false, false] call BIS_fnc_holdActionAdd;
	[this, "<t color='#FFFFFF'>" + format [localize "STR_action_trainingDrone", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'UAVHacker')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'UAVHacker')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["UAVHacker"], 10, 6, false, false] call BIS_fnc_holdActionAdd;
	[this, "<t color='#FFFFFF'>" + format [localize "STR_action_trainingInterpret", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'interpret')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'interpret')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["interpret"], 10, 6, false, false] call BIS_fnc_holdActionAdd;
*/

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _unit = _this select 1;
	private _training = _this select 3 select 0;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if (OPEX_stats_faction select 14 < OPEX_cost_training) exitWith {hint localize "STR_hint_globalStatsTooLow"};

// =========================================================================================================
// TRAINING
// =========================================================================================================

	//hint localize "STR_hint_training";
	private _speciality = "";
	if (_training == "medic") then {_unit setUnitTrait ["engineer", false, false]; _unit setUnitTrait ["explosiveSpecialist", false, false]; _unit setUnitTrait ["UAVHacker", false, false]; _unit setUnitTrait ["medic", true, false]; _unit setUnitTrait ["interpret", false, true]; _speciality = localize "STR_hint_trainingMedic"};
	if (_training == "engineer") then {_unit setUnitTrait ["medic", false]; _unit setUnitTrait ["explosiveSpecialist", false]; _unit setUnitTrait ["UAVHacker", false]; _unit setUnitTrait ["engineer", true]; _unit setUnitTrait ["interpret", false, true]; _speciality = localize "STR_hint_trainingEngineer"};
	if (_training == "explosiveSpecialist") then {_unit setUnitTrait ["medic", false]; _unit setUnitTrait ["engineer", false]; _unit setUnitTrait ["UAVHacker", false]; _unit setUnitTrait ["explosiveSpecialist", true]; _unit setUnitTrait ["interpret", false, true]; _speciality = localize "STR_hint_trainingExplosive"};
	if (_training == "UAVHacker") then {_unit setUnitTrait ["medic", false]; _unit setUnitTrait ["engineer", false]; _unit setUnitTrait ["explosiveSpecialist", false]; _unit setUnitTrait ["UAVHacker", true]; _unit setUnitTrait ["interpret", false, true]; _speciality = localize "STR_hint_trainingUAV"};
	if (_training == "interpret") then {_unit setUnitTrait ["medic", false]; _unit setUnitTrait ["engineer", false]; _unit setUnitTrait ["explosiveSpecialist", false]; _unit setUnitTrait ["UAVHacker", false]; _unit setUnitTrait ["interpret", true, true]; _speciality = localize "STR_hint_trainingInterpret"};

// =========================================================================================================
// UPDATING STATS
// =========================================================================================================

	private _intel = OPEX_stats_faction select 14;
	OPEX_stats_faction set [14, _intel - OPEX_cost_training];
	publicVariable "OPEX_stats_faction";
	hint format [localize "STR_hint_trainingDone", _speciality];
	//sleep 5;
	//[OPEX_friendly_side1, "Base", "STR_globalStats_updateBuy", name _unit, 100, globalStats] remoteExec ["Gemini_fnc_globalChat"];