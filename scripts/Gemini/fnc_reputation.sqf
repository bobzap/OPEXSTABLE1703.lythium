/*
	reputation = call Gemini_fnc_reputation;
	
	it returns an array where :
	_this select 0 = the current reputation (number)
	_this select 1 = the current reputation (text)
	
	examples:
	[5, "neutral"]
	[-57, "bad"]
	[125, "verygood"]
	
	usage: 
	(call Gemini_fnc_reputation) select 0; // returns the current reputation (number) - example : 184
	(call Gemini_fnc_reputation) select 1; // returns the current reputation (localized text) - example: "very good"
	
*/

private ["_killedEnemies", "_killedCivilians", "_killedFriends", "_hitCivilians", "_jailedEnemies", "_jailedCivilians", "_succeededTasks", "_failedTasks", "_disarmedIEDs", "_destroyedIEDs", "_destroyedCaches", "_searchedCivilians", "_handcuffedCivilians"];
_killedEnemies = 1 * (OPEX_stats_faction select 0);
_killedCivilians = -50 * (OPEX_stats_faction select 1);
_killedFriends = -5 * (OPEX_stats_faction select 2);
//_hitEnemies = 1 * (OPEX_stats_faction select 3);
_hitCivilians = -25 * (OPEX_stats_faction select 4);
//_hitFriends = -3 * (OPEX_stats_faction select 5);
_jailedEnemies = 15 * (OPEX_stats_faction select 6);
_jailedCivilians = -15 * (OPEX_stats_faction select 7);
_succeededTasks = 25 * (OPEX_stats_faction select 8);
_failedTasks = -10 * (OPEX_stats_faction select 9);
_disarmedIEDs = 15 * (OPEX_stats_faction select 11);
_destroyedIEDs = 10 * (OPEX_stats_faction select 12);
_destroyedCaches = 10 * (OPEX_stats_faction select 13);
_searchedCivilians = -1 * (OPEX_stats_faction select 16);
_handcuffedCivilians = -3 * (OPEX_stats_faction select 17);

private ["_reputation", "_bonus"];
_reputation = _killedEnemies + _killedCivilians + _killedFriends + _hitCivilians + _jailedEnemies + _jailedCivilians + _succeededTasks + _failedTasks + _disarmedIEDs + _destroyedIEDs + _destroyedCaches + _searchedCivilians + _handcuffedCivilians;
if (_reputation < 0) then {_bonus = 1} else {_bonus = OPEX_stats_faction select 18};
if (_bonus < 1) then {_bonus = 1};


private ["_number"];
_number = _reputation * _bonus;

private ["_text"];
if (_number <= -200) then {_text = localize "STR_reputation_terrible"};
if ((_number > -200) && (_number <= -100)) then {_text = localize "STR_reputation_verybad"};
if ((_number > -100) && (_number <= -10)) then {_text = localize "STR_reputation_bad"};
if ((_number > -10) && (_number <= 10)) then {_text = localize "STR_reputation_neutral"};
if ((_number > 10) && (_number <= 100)) then {_text = localize "STR_reputation_good"};
if ((_number > 100) && (_number <= 200)) then {_text = localize "STR_reputation_verygood"};
if (_number <= -200) then {_text = localize "STR_reputation_excellent"};

[_number, _text]