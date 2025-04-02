/*
    Fichier: fnc_territoryEnter.sqf
    Description: Gestion de l'entrée d'un joueur dans un territoire
*/

// Fonction principale pour gérer l'entrée d'un joueur dans un territoire
Gemini_fnc_handleTerritoryEnter = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifications de base
    if (isNull _player || _territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][ENTRÉE] Paramètres invalides: player=%1, index=%2", _player, _territoryIndex];
        false
    };
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _territoryState = _territoryData select 3;
    
    // Mettre à jour les variables du joueur
    _player setVariable ["lastVisitedTerritory", _territoryName, true];
    _player setVariable ["territoryEntryTime", time, true];
    _player setVariable ["territoryState", _territoryState, true];
    _player setVariable ["territoryWarningReceived", false, true]; // Réinitialiser
    
    // Logs détaillés
    diag_log format ["[TERRITOIRE][ENTRÉE] Joueur %1 entre dans territoire %2 (%3)", 
        name _player, _territoryName, _territoryState];
    
    // Envoyer les notifications appropriées
    [_player, _territoryName, _territoryState] call Gemini_fnc_territoryEntryNotification;
    
    // Actions spécifiques selon l'état du territoire
    switch (_territoryState) do {
        case "unknown": {
            // Ajouter l'action de communication radio
            [_player, _territoryIndex] remoteExec ["Gemini_fnc_initRadioAction", _player];
            
            // Démarrer le suivi de pénalité (uniquement pour les territoires inconnus)
            [_player, _territoryIndex, _territoryName] spawn Gemini_fnc_startPenaltyTracking;
        };
        
        case "neutral":
        case "friendly": {
            // Gestion du chef de village
            [_territoryIndex] spawn {
                params ["_index"];
                sleep 1; // Petit délai pour stabilité
                
                private _territoryData = OPEX_territories select _index;
                private _name = _territoryData select 0;
                private _chief = _territoryData select 5;
                
                // Si pas de chef, en créer un
                if (isNull _chief) then {
                    diag_log format ["[TERRITOIRE][ENTRÉE] Création dynamique d'un chef pour %1", _name];
                    [_index] spawn Gemini_fnc_spawnVillageChief;
                };
            };
        };
    };
    
    true
};