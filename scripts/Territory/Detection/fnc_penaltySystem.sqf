/*
    Fichier: fnc_penaltySystem.sqf
    Description: Systeme de penalites pour intrusion non autorisee en territoire
    Style: Notifications via le hub centralise (fnc_messagingSystem)
*/

// Suivi de penalite
Gemini_fnc_startPenaltyTracking = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_territoryName", "", [""]]
    ];

    if (isNull _player || _territoryIndex < 0 || _territoryName == "") exitWith { false };

    diag_log format ["[TERRITOIRE][PENALITE] Debut surveillance pour %1 dans %2", name _player, _territoryName];

    private _penaltyDelay = 120;
    private _warningTime = 30;
    private _entryTime = time;
    private _warned = false;

    while {true} do {
        if ((_player getVariable ["lastVisitedTerritory", ""]) != _territoryName) exitWith {};
        if (_player getVariable ["territoryAuthorized", false]) exitWith {};

        private _timeInZone = time - _entryTime;

        // Avertissement 30s avant penalite
        if (_timeInZone > (_penaltyDelay - _warningTime) && !_warned) then {
            [_player, _territoryName, _timeInZone] call Gemini_fnc_territoryPenaltyWarning;
            _warned = true;
        };

        // Penalite apres 2 minutes
        if (_timeInZone > _penaltyDelay) then {
            [_player, _territoryName] call Gemini_fnc_applyTerritoryPenalty;
            break;
        };

        sleep 5;
    };
};

// Application de la penalite
Gemini_fnc_applyTerritoryPenalty = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];

    diag_log format ["[TERRITOIRE][PENALITE] Penalite pour %1 dans %2", name _player, _territoryName];

    // Notification au joueur via le hub centralise
    [_player, _territoryName] call Gemini_fnc_territoryPenaltyNotification;

    // Penalite de reputation (serveur)
    if (isServer) then {
        if (!isNil "Gemini_fnc_updateStats") then {
            ["civilianHarassed"] call Gemini_fnc_updateStats;
        };
    } else {
        ["civilianHarassed"] remoteExec ["Gemini_fnc_updateStats", 2];
    };

    _player setVariable ["territoryPenalized", true, true];
};
