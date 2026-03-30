/*
    Fichier: fnc_radioDialog.sqf
    Description: Gestion des séquences de dialogue pour le système de communication radio
    
    Ce fichier contient les fonctions nécessaires pour simuler des échanges radio réalistes
    entre les joueurs et le quartier général.
*/

// Fonction principale pour démarrer un dialogue radio
// Dans la fonction startRadioDialog
// Dans fnc_radioDialog.sqf, correction de startRadioDialog:
Gemini_fnc_startRadioDialog = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifications
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Joueur nul pour dialogue radio";
        false
    };
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    // Vérifier si nous sommes sur la bonne machine
    if (!hasInterface) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative de dialogue sans interface";
        false
    };
    
    // Utiliser le joueur local
    private _localPlayer = player;
    
    // Si le joueur n'est pas le joueur local, sortir
    if (_player != _localPlayer) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative sur mauvais client. Player=%1, client=%2", name _player, name _localPlayer];
        false
    };
    
    // Vérifier si une radio est active
    if (missionNamespace getVariable ["OPEX_radioComm_active", false]) exitWith {
        // Notification plus visible
        [
            "<t size='1.3' color='#FF0000' align='center'>COMMUNICATION EN COURS</t><br/><t align='center'>Une autre communication radio est déjà active.<br/>Veuillez patienter.</t>", 
            0.5, 
            0.3, 
            10, 
            1
        ] call BIS_fnc_dynamicText;
        
        diag_log "[TERRITOIRE][RADIO] Communication déjà active - nouvelle tentative rejetée";
        false
    };
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _actualState = _territoryData select 3;
    
    diag_log format ["[TERRITOIRE][RADIO] Début dialogue radio pour %1 concernant %2 (état réel: %3)", name _player, _territoryName, _actualState];
    
    // Marquer la radio comme active globalement
    missionNamespace setVariable ["OPEX_radioComm_active", true, true];
    publicVariable "OPEX_radioComm_active";
    
    // Définir le joueur comme autorisé pour éviter les pénalités pendant le dialogue
    _player setVariable ["territoryAuthorized", true, true];
    
    // Premier message du joueur (plus visible)
    private _playerMsg = format ["<t size='1.3' color='#00FFFF'>Communication Radio</t><br/><t align='left'>[Vous] : PC, ici patrouille. Demande SITREP sur zone: %1. Terminé.</t>", _territoryName];
    [_playerMsg, 0.5, 0.3, 5, 1] call BIS_fnc_dynamicText;
    
    // Également en systemChat pour référence
    systemChat format ["[Vous] PC, ici patrouille. Demande SITREP sur zone: %1. Terminé.", _territoryName];
    
    // Séquence de dialogue
    [_player, _territoryIndex, _territoryName, _actualState] spawn {
        params ["_player", "_territoryIndex", "_territoryName", "_actualState"];
        
        // Première réponse du QG après délai
        sleep 3;
        private _pcMsg = format ["<t size='1.3' color='#00FFFF'>Communication Radio</t><br/><t align='left'>[PC] : Patrouille, ici PC. Bien reçu, nous analysons la zone: %1. Attente sur votre position. Terminé.</t>", _territoryName];
        [_pcMsg, 0.5, 0.3, 5, 1] call BIS_fnc_dynamicText;
        
        // Également en systemChat
        systemChat format ["[PC] Patrouille, ici PC. Bien reçu, nous analysons la zone: %1. Attente sur votre position. Terminé.", _territoryName];
        
        // Simuler analyse (délai aléatoire)
        sleep (5 + (random 5));
        
        // Obtenir la réponse du QG selon l'état du territoire
        private _responseData = [_territoryIndex] call Gemini_fnc_getHQResponse;
        _responseData params ["_responseText", "_responseState"];
        
        // Formater la réponse PC
        private _responseMsg = format ["<t size='1.3' color='#00FFFF'>Communication Radio</t><br/><t align='left'>[PC] : %1</t>", _responseText];
        [_responseMsg, 0.5, 0.3, 8, 1] call BIS_fnc_dynamicText;
        
        // Également en systemChat
        systemChat format ["[PC] %1", _responseText];
        
        // S'il s'agit d'un territoire réel (pas inconnu), révéler son état
        if (_actualState != "unknown") then {
            // Mettre à jour l'état réel du territoire
            [_territoryIndex, _actualState, -1] remoteExec ["Gemini_fnc_updateTerritoryState", 2];
            
            // Ajouter à la liste des territoires autorisés
            [_territoryIndex] remoteExec ["Gemini_fnc_addToAuthorizedTerritories", 2];
            
            // Message supplémentaire plus clair
            sleep 3;
            private _stateMsg = switch (_actualState) do {
                case "enemy": {"ZONE HOSTILE - Soyez extrêmement vigilant."};
                case "neutral": {"ZONE NEUTRE - Soyez courtois mais restez sur vos gardes."};
                case "friendly": {"ZONE AMIE - Sous contrôle des forces alliées."};
                default {"ZONE INDÉTERMINÉE - Procédez avec prudence."};
            };
            
            private _stateColor = switch (_actualState) do {
                case "enemy": {"#FF0000"};
                case "neutral": {"#00FF00"};
                case "friendly": {"#0080FF"};
                default {"#FFFFFF"};
            };
            
            private _finalMsg = format [
                "<t size='1.5' color='%1' align='center'>TERRITOIRE %2</t><br/><t size='1.2' align='center'>%3</t>",
                _stateColor,
                toUpper _actualState,
                _stateMsg
            ];
            
            [_finalMsg, 0.5, 0.3, 10, 1] call BIS_fnc_dynamicText;
            
            // Supprimer l'action radio pour ce territoire
            [_player, _territoryIndex] remoteExec ["Gemini_fnc_removeRadioAction", _player];
        } else {
            // Si territoire inconnu, message clair
            sleep 3;
            private _unknownMsg = format [
                "<t size='1.5' color='#FFFFFF' align='center'>ZONE NON RENSEIGNÉE</t><br/><t size='1.2' align='center'>Restez en dehors de %1 jusqu'à nouvel ordre ou procédez avec extrême prudence.</t>",
                _territoryName
            ];
            [_unknownMsg, 0.5, 0.3, 10, 1] call BIS_fnc_dynamicText;
            
            // Si territoire inconnu, retirer autorisation
            _player setVariable ["territoryAuthorized", false, true];
        };
        
        // Fin de la communication radio
        sleep 2;
        missionNamespace setVariable ["OPEX_radioComm_active", false, true];
        publicVariable "OPEX_radioComm_active";
    };
    
    true
};

// Fonction pour émettre des rapports de situation entre joueurs
Gemini_fnc_playerToPlayerRadio = {
    params [
        ["_sender", objNull, [objNull]],
        ["_recipient", objNull, [objNull]],
        ["_message", "", [""]]
    ];
    
    // Vérifications de base
    if (isNull _sender || isNull _recipient) exitWith {false};
    if (_message == "") exitWith {false};
    
    // Vérifier si les joueurs peuvent communiquer (ont des radios)
    if (!([_sender] call Gemini_fnc_canUseRadio) || !([_recipient] call Gemini_fnc_canUseRadio)) exitWith {
        hint "Communication impossible: radio requise.";
        false
    };
    
    // Envoyer le message global formaté
    [_recipient, name _sender, name _recipient, _message] call Gemini_fnc_territoryGlobalChat;
    
    // Effet audio pour le destinataire (si disponible)
    if (!isNil "Gemini_fnc_playSoundEffect") then {
        [_recipient, "radio_incoming"] remoteExec ["Gemini_fnc_playSoundEffect", _recipient];
    };
    
    true
};

// Fonction pour simuler une alerte radio du QG
Gemini_fnc_hqAlert = {
    params [
        ["_target", 0, [objNull, 0, []]],  // 0 pour tous, objet pour un joueur, array pour plusieurs
        ["_message", "", [""]],
        ["_priority", "normal", [""]]      // "normal", "high", "emergency"
    ];
    
    // Vérifier si le message est valide
    if (_message == "") exitWith {false};
    
    // Formater le message selon la priorité
    private _prefix = switch (_priority) do {
        case "high": {"URGENT"};
        case "emergency": {"ALERTE MAXIMALE"};
        default {""};
    };
    
    private _formattedMessage = if (_prefix != "") then {
        format ["%1: %2", _prefix, _message]
    } else {
        _message
    };
    
    // Envoyer le message
    [_target, "QG", "toutes les unités", _formattedMessage] call Gemini_fnc_territoryGlobalChat;
    
    // Effets audio selon priorité (si disponible)
    if (!isNil "Gemini_fnc_playSoundEffect") then {
        private _sound = switch (_priority) do {
            case "high": {"radio_urgent"};
            case "emergency": {"radio_alarm"};
            default {"radio_standard"};
        };
        
        [_target, _sound] remoteExecCall  ["Gemini_fnc_playSoundEffect", _target];
    };
    
    true
};

// Initialisation au démarrage du script
if (isServer) then {
    diag_log "[TERRITOIRE][RADIO] Module radioDialog initialisé";
};