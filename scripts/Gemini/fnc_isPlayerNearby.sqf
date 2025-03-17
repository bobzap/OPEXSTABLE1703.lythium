private _entity = param [0, objNull, [objNull, []]];
private _distance = param [1, OPEX_spawnDistanceMaxi, [0]];

private _allPlayers = allPlayers - entities "HeadlessClient_F";

//if (count OPEX_playingPlayers == 0) exitWith {false};
if (typeName _entity isEqualTo "OBJECT") then {if (getPos _entity select 2 > 25) then {_distance = _distance * 3}}; // increasing max distance in case checked object is flying
//if ({(_x distance2D _entity <= _distance) && (_x in OPEX_playingPlayers)} count (allUnits) > 0) then {true} else {false};
if ({(_x distance2D _entity <= _distance) && (_x in _allPlayers)} count (allUnits) > 0) then {true} else {false};