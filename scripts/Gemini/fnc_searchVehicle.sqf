private _vehicle = param [0, objNull, [objNull]];
private _searcher = param [1, objNull, [objNull]];

if ((_vehicle getVariable ["intel", 0]) > 0)
then
	{
		OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + (_vehicle getVariable "intel")];
		publicVariable "OPEX_stats_faction";
		_vehicle setVariable ["intel", 0, true];
		hint localize "STR_hint_intelGathered";
	}
else {hint localize "STR_hint_nothingSuspicious"};