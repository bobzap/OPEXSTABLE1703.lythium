hint format 
[
	localize "STR_hint_checkMods", 
	count OPEX_serverMods, 
	OPEX_serverMods, 
	count OPEX_clientMods, 
	OPEX_clientMods, 
	if (count (OPEX_serverMods - OPEX_clientMods) == 0) 
		then 
			{
				if (OPEX_serverMods isEqualTo OPEX_clientMods) then {localize "STR_none"} else {localize "STR_none_but"};
			} 
		else 
			{
				OPEX_serverMods - OPEX_clientMods
			}
];