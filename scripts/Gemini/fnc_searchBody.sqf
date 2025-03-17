private _body = param [0, objNull, [objNull]];
private _searcher = param [1, objNull, [objNull]];

if ((_body getVariable ["heldIntel", 0]) > 0)
then
	{
		OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + (_body getVariable "heldIntel")];
		publicVariable "OPEX_stats_faction";
		_body setVariable ["heldIntel", 0, true];
		hint localize "STR_hint_intelGathered";
	}
else {hint localize "STR_hint_nothingSuspicious"};