private _entity = param [0, objNull, [objNull, []]];
private _distance = param [1, OPEX_spawnDistanceMini, [0]];

if (typeName _entity isEqualTo "OBJECT") then {if (getPos _entity select 2 > 25) then {_distance = _distance * 3}}; // increasing max distance in case checked object is flying

private _allTeammates = {(units group _x) + (hcAllGroups _x)} forEach (allPlayers - entities "HeadlessClient_F");
if ({(_x distance2D _entity <= _distance) && (_x in _allTeammates)} count (allUnits) > 0) then {true} else {false};