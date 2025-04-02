/*
    Fichier: fnc_penaltySystem.sqf
    Description: Système de pénalités pour intrusion non autorisée en territoire
*/

// Fonction principale pour démarrer le suivi de pénalité
Gemini_fnc_startPenaltyTracking = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_territoryName", "", [""]]
    ];
    
    // Vérifications
    if (isNull _player || _territoryIndex < 0 || _territoryName == "") exitWith {
        diag_log "[TERRITOIRE][PÉNALITÉ] Paramètres invalides pour suivi de pénalité";
        false
    };
    
    diag_log format ["[TERRITOIRE][PÉNALITÉ] Début surveillance pénalité pour %1 en territoire %2", name _player, _territoryName];
    
    // Paramètres de pénalité
    private _penaltyDelay = OPEX_territory_penalty_delay;
    private _warningTime = OPEX_territory_penalty_warning;
    private _entryTime = time;
    private _warned = false;
    
    // Boucle de surveillance
    while {true} do {
        // Vérifier si le joueur est toujours dans le même territoire
        if ((_player getVariable ["lastVisitedTerritory", ""]) != _territoryName) exitWith {
            diag_log format ["[TERRITOIRE][PÉNALITÉ] Surveillance pénalité terminée - joueur a quitté %1", _territoryName];
        };
        
        // Vérifier si le joueur est maintenant autorisé
        if (_player getVariable ["territoryAuthorized", false]) exitWith {
            diag_log format ["[TERRITOIRE][PÉNALITÉ] Surveillance pénalité terminée - joueur autorisé dans %1", _territoryName];
        };
        
        // Calculer temps écoulé
        private _timeInZone = time - _entryTime;
        
        // Avertissement avant pénalité
        if (_timeInZone > (_penaltyDelay - _warningTime) && !_warned) then {
            diag_log format ["[TERRITOIRE][PÉNALITÉ] AVERTISSEMENT pour %1 - presque %2 minutes dans %3", 
                name _player, round(_penaltyDelay/60), _territoryName];
            
            [_player, _territoryName, _timeInZone] call Gemini_fnc_territoryPenaltyWarning;
            _warned = true;
        };
        
        // Appliquer pénalité après délai
        if (_timeInZone > _penaltyDelay) then {
            diag_log format ["[TERRITOIRE][PÉNALITÉ] PÉNALITÉ pour %1 - plus de %2 minutes dans %3", 
                name _player, round(_penaltyDelay/60), _territoryName];
            
            [_player, _territoryName] call Gemini_fnc_applyTerritoryPenalty;
            break;
        };
        
        sleep 5;
    };
};

// Fonction pour appliquer une pénalité
Gemini_fnc_applyTerritoryPenalty = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];
    
    // Notification claire au joueur
    [_player, _territoryName] call Gemini_fnc_territoryPenaltyNotification;
    
    // Pénalité de réputation (exécutée sur le serveur)
    if (isServer) then {
        ["civilianHarassed"] call Gemini_fnc_updateStats;
    } else {
        ["civilianHarassed"] remoteExec ["Gemini_fnc_updateStats", 2];
    };
    
    // Marquer le joueur comme pénalisé
    _player setVariable ["territoryPenalized", true, true];
    
    // Possibilité d'ajouter d'autres conséquences
    // ...
};