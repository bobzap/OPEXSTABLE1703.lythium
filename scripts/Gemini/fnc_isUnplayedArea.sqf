//if ({(_x distance2D _this <= OPEX_spawnDistanceMaxi) && (side _x == OPEX_friendly_side1)} count (allUnits) == 0) then {true} else {false};

if ([_this] call Gemini_fnc_isPlayerNearby) then {false} else {true};