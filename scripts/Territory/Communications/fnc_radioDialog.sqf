/*
    Fichier: fnc_radioDialog.sqf
    Description: Gestion des séquences de dialogue pour le système de communication radio
    
    Ce fichier contient les fonctions nécessaires pour simuler des échanges radio réalistes
    entre les joueurs et le quartier général.
*/

// Fonction principale pour démarrer un dialogue radio
// Dans la fonction startRadioDialog
Gemini_fnc_startRadioDialog = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifications de sécurité
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Joueur nul pour dialogue radio";
        false
    };
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    // Vérifier que nous sommes sur la bonne machine (client du joueur)
    if (!hasInterface) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative de dialogue radio sans interface";
        false
    };
    
    // Utiliser ACE_player si disponible, sinon player
    private _localPlayer = if (!isNil "ACE_player") then {ACE_player} else {player};
    
    // Si le joueur n'est pas le joueur local, sortir
    if (_player != _localPlayer) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative de dialogue sur mauvais client. Player=%1, client=%2", name _player, name _localPlayer];
        false
    };
    
    // Vérifier si une radio est active
    if (missionNamespace getVariable ["OPEX_radioComm_active", false]) exitWith {
        [_player, "Communication en cours", "Une autre communication radio est déjà active. Veuillez patienter.", "warning"] call Gemini_fnc_territoryNotification;
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
    
    // Effet audio optionnel (si disponible)
    if (!isNil "Gemini_fnc_playSoundEffect") then {
        [_player, "radio_start"] call Gemini_fnc_playSoundEffect;
    };
    
    // Premier message du joueur
    [_player, "[Vous]", "PC", format ["PC, ici patrouille. Demande SITREP sur zone: %1. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
    
    // Séquence de dialogue
    [_player, _territoryIndex, _territoryName, _actualState] spawn {
        params ["_player", "_territoryIndex", "_territoryName", "_actualState"];
        
        private _initialDelay = OPEX_territory_radio_initialDelay;
        
        // Première réponse du QG après délai
        sleep _initialDelay;
        [_player, "QG", "[Vous]", format ["Patrouille, ici PC. Bien reçu, nous analysons la zone: %1. Attente sur votre position. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
        
        // Simuler analyse (délai aléatoire)
        private _analyzeDelayRange = OPEX_territory_radio_analyzeTime;
        private _analyzeTime = (_analyzeDelayRange select 0) + (random ((_analyzeDelayRange select 1) - (_analyzeDelayRange select 0)));
        
        sleep _analyzeTime;
        
        // Obtenir la réponse du QG selon l'état du territoire
        private _responseData = [_territoryIndex] call Gemini_fnc_getHQResponse;
        
        // Vérifier que les données sont valides
        if (isNil "_responseData" || {!(_responseData isEqualType [])}) then {
            _responseData = ["Données indisponibles sur secteur " + _territoryName + ". Restez sur votre position, nous envoyons du renfort pour évaluation.", "unknown"];
            diag_log "[TERRITOIRE][RADIO] Avertissement: getHQResponse a renvoyé des données invalides";
        };
        
        _responseData params ["_responseText", "_responseState"];
        
        // Envoyer la réponse
        [_player, "QG", "[Vous]", _responseText] call Gemini_fnc_territoryGlobalChat;
        
        // Mettre à jour l'état du territoire si ce n'est pas "unknown"
        if (_actualState != "unknown") then {
            // Réinitialiser la notification si le joueur revient plus tard
            _player setVariable ["territoryWarningReceived", false, true];
            
            // Marquer le territoire comme autorisé
            _player setVariable ["territoryAuthorized", true, true];
            
            // Suppression de l'action radio pour ce territoire
            [_player, _territoryIndex] call Gemini_fnc_removeRadioAction;
            
            // Révéler l'état réel du territoire (exécuté sur le serveur)
            [_territoryIndex, _actualState, -1] remoteExec ["Gemini_fnc_updateTerritoryState", 2];
            
            // Ajouter à la liste des territoires autorisés (exécuté sur le serveur)
            [_territoryIndex] remoteExec ["Gemini_fnc_addToAuthorizedTerritories", 2];
            
            // Ajouter un message explicite sur l'état du territoire
            private _stateMessage = switch (_actualState) do {
                case "enemy": {"Zone HOSTILE - Soyez extrêmement vigilant."};
                case "neutral": {"Zone NEUTRE - Soyez courtois mais restez sur vos gardes."};
                case "friendly": {"Zone AMIE - Sous contrôle des forces alliées."};
                default {"Zone INDÉTERMINÉE - Procédez avec prudence."};
            };
            
            // Message supplémentaire pour clarifier l'état du territoire
            sleep 2;
            [_player, "QG", "[Vous]", format ["Confirmez: %1 est désormais classifié comme territoire %2. %3", _territoryName, _actualState, _stateMessage]] call Gemini_fnc_territoryGlobalChat;
            
            // Notification visuelle
            private _stateColor = switch (_actualState) do {
                case "enemy": {"#FF0000"};
                case "neutral": {"#00FF00"};
                case "friendly": {"#0080FF"};
                default {"#FFFFFF"};
            };
            
            private _stateNotification = format ["<t size='1.2' color='%1'>TERRITOIRE %2</t><br/>%3", _stateColor, toUpper _actualState, _stateMessage];
            [_stateNotification, 0.5, 0.3, 5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
            
            // Proposer une mission si nécessaire
            if (_actualState == "enemy" || _actualState == "neutral" || _actualState == "friendly") then {
                // Petit délai avant proposition
                sleep 3;
                
                // Message de proposition de mission
                [_player, "QG", "[Vous]", format ["Patrouille, ici PC. Nous avons une mission pour vous dans ce secteur. Souhaitez-vous l'accepter? Terminé."]] call Gemini_fnc_territoryGlobalChat;
                
                // Type de mission selon l'état
                private _missionType = switch (_actualState) do {
                    case "enemy": {"clear"};
                    case "neutral": {"stabilize"};
                    case "friendly": {"secure"};
                    default {"none"};
                };
                
                // Ajouter l'action d'acceptation de mission
                [_player, _territoryIndex, _missionType] call Gemini_fnc_addMissionAcceptAction;
            };
        } else {
            // Si le territoire reste inconnu, indiquer clairement au joueur
            sleep 2;
            [_player, "QG", "[Vous]", format ["Zone %1 inconnue. Restez en dehors jusqu'à nouvel ordre ou procédez avec extrême prudence.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
        };
        
        // Fin de la communication radio (exécuté sur le serveur)
        sleep 1;
        missionNamespace setVariable ["OPEX_radioComm_active", false, true];
        publicVariable "OPEX_radioComm_active";
        
        // Effet audio de fin (si disponible)
        if (!isNil "Gemini_fnc_playSoundEffect") then {
            [_player, "radio_end"] call Gemini_fnc_playSoundEffect;
        };
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