["test.ogv", "STR_A3_Campaign_Quote_7"] call BIS_fnc_quotations;
waitUntil {BIS_fnc_quotations_playing || !(isNil "BIS_fnc_quotations_skip")};