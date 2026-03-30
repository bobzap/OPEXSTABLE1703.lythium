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
    
    diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Début handleTerritoryEnter pour joueur %1, index %2", name _player, _territoryIndex];
    
    // Vérifications de base
    if (isNull _player || _territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][ENTRÉE] Paramètres invalides: player=%1, index=%2", _player, _territoryIndex];
        false
    };
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _territoryState = _territoryData select 3;
    
    diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Territoire identifié: %1 (%2)", _territoryName, _territoryState];
    
    // Mettre à jour les variables du joueur
    _player setVariable ["lastVisitedTerritory", _territoryName, true];
    _player setVariable ["territoryEntryTime", time, true];
    _player setVariable ["territoryState", _territoryState, true];
    _player setVariable ["territoryWarningReceived", false, true]; // Réinitialiser
    
    diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Variables joueur mises à jour: lastVisitedTerritory = %1", _territoryName];
    
    // Logs détaillés
    diag_log format ["[TERRITOIRE][ENTRÉE] Joueur %1 entre dans territoire %2 (%3)", 
        name _player, _territoryName, _territoryState];
    
    // Envoyer les notifications appropriées
    diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Avant appel à territoryEntryNotification pour %1", _territoryName];
    [_player, _territoryName, _territoryState] call Gemini_fnc_territoryEntryNotification;
    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Après appel à territoryEntryNotification";
    
    // Actions spécifiques selon l'état du territoire
    diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Traitement des actions spécifiques pour état: %1", _territoryState];
    switch (_territoryState) do {
        // Dans fnc_territoryEnter.sqf, modification:
case "unknown": {
    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'unknown'";
    // Envoyer d'abord la notification d'entrée
    [_player, _territoryName, _territoryState] call Gemini_fnc_territoryEntryNotification;
    
    // Attendre un délai avant d'ajouter l'action radio via spawn
    [_player, _territoryIndex] spawn {
        params ["_player", "_territoryIndex"];
        sleep 3; // Attendre 3 secondes
        
        // Ajouter l'action radio
        [_player, _territoryIndex] remoteExec ["Gemini_fnc_initRadioAction", _player];
    };
    
    // Démarrer le suivi de pénalité 
    [_player, _territoryIndex, _territoryName] spawn Gemini_fnc_startPenaltyTracking;
};
        
        case "neutral": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'neutral'";
            // Gestion du chef de village
            [_territoryIndex] spawn {
                params ["_index"];
                diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Début spawn chef village pour index %1", _index];
                sleep 1; // Petit délai pour stabilité
                
                private _territoryData = OPEX_territories select _index;
                private _name = _territoryData select 0;
                private _chief = _territoryData select 5;
                
                diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Chef existant pour %1: %2", _name, _chief];
                
                // Si pas de chef, en créer un
                if (isNull _chief) then {
                    diag_log format ["[TERRITOIRE][ENTRÉE] Création dynamique d'un chef pour %1", _name];
                    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Avant appel à spawnVillageChief";
                    [_index] spawn Gemini_fnc_spawnVillageChief;
                    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Après appel à spawnVillageChief";
                };
            };
        };
        
        case "friendly": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'friendly'";
            // Gestion du chef de village
            [_territoryIndex] spawn {
                params ["_index"];
                diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Début spawn chef village pour index %1", _index];
                sleep 1; // Petit délai pour stabilité
                
                private _territoryData = OPEX_territories select _index;
                private _name = _territoryData select 0;
                private _chief = _territoryData select 5;
                
                diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] Chef existant pour %1: %2", _name, _chief];
                
                // Si pas de chef, en créer un
                if (isNull _chief) then {
                    diag_log format ["[TERRITOIRE][ENTRÉE] Création dynamique d'un chef pour %1", _name];
                    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Avant appel à spawnVillageChief";
                    [_index] spawn Gemini_fnc_spawnVillageChief;
                    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Après appel à spawnVillageChief";
                };
            };
        };
        
        default {
            diag_log format ["[TERRITOIRE][DEBUG-ENTRÉE] État de territoire non géré: %1", _territoryState];
        };
    };
    
    diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Fin handleTerritoryEnter";
    true
};