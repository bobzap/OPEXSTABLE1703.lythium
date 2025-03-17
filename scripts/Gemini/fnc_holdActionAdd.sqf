/*
	example 1:
	[player, ["STR_myLocalizedText", "white"], ""\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", ""\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, {hint "CODE OK"}, {hint "CODE INTERRRUPTED"}, [], 1, 10, true, false, true] call BIS_fnc_holdActionAdd;

	example 2:
	[_vehicle, ["STR_action_searchVehicle", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "(_target distance2D _this < 6) && (alive _target)", "(_target distance2D _this < 6) && (alive _target)", {}, {}, {_this call Gemini_fnc_searchVehicle}, {}, [], 10, 0, false, false, true] remoteExec ["Gemini_fnc_holdActionAdd", 0, _vehicle];
*/

private _entity = param [0, objNull, [objNull, 0]];
private _text = param [1, ["noLocalizedText", "white"], [["", ""]]];
private _iconShow = param [2, "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", [""]];
private _iconProgress = param [3, "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", [""]];
private _conditionShow = param [4, "true", [""]];
private _conditionProgress = param [5, "true", [""]];
private _codeStart = param [6, {}, [{}]];
private _codeProgress = param [7, {}, [{}]];
private _codeCompleted = param [8, {}, [{}]];
private _codeInterrupted = param [9, {}, [{}]];
private _arguments = param [10, [], [[]]];
private _duration = param [11, 1, [1]];
private _priority = param [12, 10, [10]];
private _removeCompleted = param [13, true, [true]];
private _showUnconscious = param [14, false, [false]];
private _showWindow = param [15, true, [true]];

private _localizedText = _text select 0;
private _color = "";
switch (_text select 1) do
 	{
 		case "white"	:	{_color = "<t color='#FFFFFF'>"};
 		case "red"		:	{_color = "<t color='#FF0000'>"};
 		case "green"	:	{_color = "<t color='#00A903'>"};
 		case "orange"	:	{_color = "<t color='#EC9A00'>"};
 		default 			{_color = "<t color='#FFFFFF'>"};
 	};

[_entity, _color + (localize _localizedText) + "</t>", _iconShow, _iconProgress, _conditionShow, _conditionProgress, _codeStart, _codeProgress, _codeCompleted, _codeInterrupted, _arguments, _duration, _priority, _removeCompleted, _showUnconscious, _showWindow] call BIS_fnc_holdActionAdd;