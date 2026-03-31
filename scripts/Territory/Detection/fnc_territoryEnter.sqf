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
        case "unknown": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'unknown'";

            // Attendre un délai avant d'ajouter l'action radio via spawn
            [_player, _territoryIndex] spawn {
                params ["_player", "_territoryIndex"];
                sleep 3;

                // Ajouter l'action radio côté client
                [_player, _territoryIndex] remoteExec ["Gemini_fnc_initRadioAction", _player];
            };

            // Démarrer le suivi de pénalité
            [_player, _territoryIndex, _territoryName] spawn Gemini_fnc_startPenaltyTracking;
        };

        case "enemy": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'enemy'";
            // Marquer le joueur comme autorisé (territoire déjà identifié comme hostile)
            _player setVariable ["territoryAuthorized", true, true];

            // Proposer une mission via radio après un délai
            [_player, _territoryIndex] spawn {
                params ["_player", "_territoryIndex"];
                sleep 5;

                // Proposer une mission si le joueur est toujours dans le territoire
                if ((_player getVariable ["lastVisitedTerritory", ""]) == ((OPEX_territories select _territoryIndex) select 0)) then {
                    [_player, _territoryIndex] remoteExec ["Gemini_fnc_offerMissionViaRadio", _player];
                };
            };
        };

        case "neutral": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'neutral'";
            [_player, _territoryIndex] spawn {
                params ["_player", "_index"];
                sleep 1;

                private _territoryData = OPEX_territories select _index;
                private _name = _territoryData select 0;
                private _chief = _territoryData select 5;

                // Si pas de chef, en créer un (la description sera envoyée par spawnVillageChief)
                if (isNull _chief) then {
                    [_index] call Gemini_fnc_spawnVillageChief;
                } else {
                    // Chef existant → envoyer la description au joueur
                    if (alive _chief) then {
                        private _dirText = _chief getVariable ["chiefDirection", "dans les environs"];
                        private _locText = _chief getVariable ["chiefLocation", "quelque part dans le village"];
                        private _descMsg = format ["[QG] Le responsable local de %1 se trouverait %2, %3.", _name, _dirText, _locText];
                        [_descMsg] remoteExec ["systemChat", _player];
                    };
                };
            };
        };

        case "friendly": {
            diag_log "[TERRITOIRE][DEBUG-ENTRÉE] Traitement cas 'friendly'";
            [_player, _territoryIndex] spawn {
                params ["_player", "_index"];
                sleep 1;

                private _territoryData = OPEX_territories select _index;
                private _name = _territoryData select 0;
                private _chief = _territoryData select 5;

                if (isNull _chief) then {
                    [_index] call Gemini_fnc_spawnVillageChief;
                } else {
                    if (alive _chief) then {
                        private _dirText = _chief getVariable ["chiefDirection", "dans les environs"];
                        private _locText = _chief getVariable ["chiefLocation", "quelque part dans le village"];
                        private _descMsg = format ["[QG] Le responsable local de %1 se trouverait %2, %3.", _name, _dirText, _locText];
                        [_descMsg] remoteExec ["systemChat", _player];
                    };
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