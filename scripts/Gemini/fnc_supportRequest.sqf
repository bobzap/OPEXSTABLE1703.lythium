// GETTING CALLER
private ["_caller"];
_caller = _this select 0;

// CHEKING UNITS NEARBY
_unitsNearby = _caller nearEntities ["Man", 300];

// CHECKING HOW MANY FRIENDS ARE NEARBY
private ["_friendliesNearby"];
_friendliesNearby = _unitsNearby;
{if (side _x != OPEX_friendly_side1) then {_friendliesNearby = _friendliesNearby - [_x]}} forEach _unitsNearby;

// CHECKING HOW MANY ENEMIES ARE NEARBY
private ["_enemiesNearby"];
_enemiesNearby = _unitsNearby;
{if (side _x != OPEX_enemy_side1) then {_enemiesNearby = _enemiesNearby - [_x]}} forEach _unitsNearby;

// DEBUG
private ["_debug"];
_debug = OPEX_debug;
if (_debug) then {hint format ["FRIENDS NEARBY: %1\nENEMIES NEARBY: %2", count _friendliesNearby, count _enemiesNearby]};

// ANALYZING REQUEST
systemChat format ["%1 : %2", name _caller, localize "STR_support_requested"];
sleep 5 + (random 10);
if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorizedLeaderOnly"]};
if (OPEX_incomingSupport) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorized"];};
if (count _enemiesNearby < 7) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorized"];};
if ((count _friendliesNearby) > (count _enemiesNearby)) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorized"];};
systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_wait"];

// DEFINING AVAILABLE SUPPORTS
private ["_availableSupport"];
_availableSupport = [];
if (!OPEX_support_airStrike) then {_availableSupport = _availableSupport + ["airStrike"] + ["airStrike"]};
if (!OPEX_support_artilleryStrike) then {_availableSupport = _availableSupport + ["artilleryStrike"] + ["artilleryStrike"] + ["artilleryStrike"]};
if (!OPEX_support_airAssistance) then {_availableSupport = _availableSupport + ["airAssistance"]};
if (!OPEX_support_landAssistance) then {_availableSupport = _availableSupport + ["landAssistance"]};
sleep 5 + (random 10);

// ADDING NEW SUPPORT (IF ANY)
private ["_selectedSupport"];
if (count _availableSupport > 0) then {_selectedSupport = selectRandom _availableSupport} else {if (true) exitWith {systemChat format ["%1 : %2", localize "STR_codeName_HQ", localize "STR_support_unauthorized"]}};
OPEX_incomingSupport = true; publicVariable "OPEX_incomingSupport";
[_selectedSupport] remoteExec ["Gemini_fnc_addSupport", 2];

// WHILE ONE OF THOSE SUPPORT IS AVAILABLE, WAITING
sleep 1;
while {OPEX_support_airStrike || OPEX_support_artilleryStrike || OPEX_support_airAssistance || OPEX_support_landAssistance} do {sleep 5};

// WAITING AT LEAST 10 MINUTES BEFORE ALLOWING A NEW SUPPORT REQUEST
sleep (600 + random 400);

// ALLOWING A NEW SUPPORT REQUEST
OPEX_incomingSupport = false; publicVariable "OPEX_incomingSupport";