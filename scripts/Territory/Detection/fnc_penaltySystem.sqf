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
    private _penaltyDelay = 120; // 2 minutes avant pénalité (en secondes)
    private _warningTime = 30; // Avertissement 30 secondes avant
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
            
            private _warningMsg = format ["<t size='1.2' color='#FFA500'>AVERTISSEMENT</t><br/>Vous êtes dans %1 depuis presque 2 minutes sans autorisation.<br/>Faites demi-tour ou contactez le PC pour éviter une pénalité.", _territoryName];
            [_warningMsg, 0.5, 0.3, 8, 0] remoteExec ["BIS_fnc_dynamicText", _player];
            
            [_player, format ["AVERTISSEMENT: %1 minute en zone non autorisée. Sanction sur notre réputation imminente.", round(_timeInZone/60)]] remoteExec ["systemChat", _player];
            
            diag_log format ["[TERRITOIRE] AVERTISSEMENT envoyé à %1 pour présence non autorisée dans %2", name _player, _territoryName];
            
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
    
    diag_log format ["[TERRITOIRE][PÉNALITÉ] Application de la pénalité pour %1 dans %2", name _player, _territoryName];
    
    // Notification claire au joueur
    private _penaltyMsg = format ["<t size='1.2' color='#FF0000'>PÉNALITÉ</t><br/>Vous avez passé plus de 2 minutes en territoire non autorisé.<br/>Votre réputation a été affectée."];
    [_penaltyMsg, 0.5, 0.3, 8, 0] remoteExec ["BIS_fnc_dynamicText", _player];
    
    // Message système
    ["SANCTION: Trop de temps passé en zone non autorisée. Réputation affectée."] remoteExec ["systemChat", _player];
    
    // Annonce globale à tous les joueurs
    if (!isNil "Gemini_fnc_globalChat") then {
        ["globalChat", format ["La patrouille de %1 a pénétré en zone non renseignée sans autorisation.", name _player]] remoteExec ["Gemini_fnc_globalChat", 0];
    } else {
        // Fallback si la fonction globalChat n'est pas disponible
        [format ["GLOBAL: La patrouille de %1 a pénétré en zone non renseignée sans autorisation.", name _player]] remoteExec ["systemChat", 0];
    };
    
    // Pénalité de réputation (exécutée sur le serveur)
    if (isServer) then {
        if (!isNil "Gemini_fnc_updateStats") then {
            ["civilianHarassed"] call Gemini_fnc_updateStats;
        };
    } else {
        ["civilianHarassed"] remoteExec ["Gemini_fnc_updateStats", 2];
    };
    
    // Marquer le joueur comme pénalisé
    _player setVariable ["territoryPenalized", true, true];
};