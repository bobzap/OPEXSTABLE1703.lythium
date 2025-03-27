/*
    Fichier: fnc_messagingSystem.sqf
    Description: Système centralisé de messages et notifications pour le système territorial
    
    Ce fichier fournit des fonctions standardisées pour tous les types de notifications
    utilisées dans le système territorial.
*/

// Fonction pour envoyer une notification visuelle (dynamicText)
Gemini_fnc_territoryNotification = {
    params [
        ["_target", objNull, [objNull, 0, []]],  // Cible (joueur, côté ou array)
        ["_title", "", [""]],                    // Titre de la notification
        ["_message", "", [""]],                   // Message principal
        ["_type", "info", [""]],                 // Type: info, warning, error, success
        ["_duration", -1, [0]]                   // Durée (utilise défaut si -1)
    ];
    
    private _color = switch (_type) do {
        case "warning": {"#FFA500"};  // Orange
        case "error": {"#FF0000"};    // Rouge
        case "success": {"#00FF00"};  // Vert
        default {"#FFFFFF"};          // Blanc (info)
    };
    
    // Durée par défaut selon type
    if (_duration < 0) then {
        _duration = switch (_type) do {
            case "warning": {OPEX_territory_notif_warning};
            case "error": {OPEX_territory_notif_warning};
            default {OPEX_territory_notif_duration};
        };
    };
    
    // Créer le texte formaté
    private _formattedText = format [
        "<t size='1.2' color='%1' align='center'>%2</t><br/><t align='center'>%3</t>",
        _color,
        _title,
        _message
    ];
    
    // Envoyer la notification
    [_formattedText, 0.5, 0.2, _duration, 0] remoteExec ["BIS_fnc_dynamicText", _target];
    
    // Log si en mode debug
    if (OPEX_territory_debug) then {
        private _targetName = if (isNull _target) then {"all"} else {
            if (typeName _target == "OBJECT") then {name _target} else {"multiple"}
        };
        diag_log format ["[TERRITOIRE][NOTIF] Envoyé à %1: %2 - %3", _targetName, _title, _message];
    };
};

// Fonction pour envoyer un message systemChat
Gemini_fnc_territorySystemChat = {
    params [
        ["_target", objNull, [objNull, 0, []]],  // Cible (joueur, côté ou array)
        ["_message", "", [""]]                   // Message à envoyer
    ];
    
    // Envoyer le message
    [_message] remoteExec ["systemChat", _target];
    
    // Log si en mode debug
    if (OPEX_territory_debug) then {
        private _targetName = if (isNull _target) then {"all"} else {
            if (typeName _target == "OBJECT") then {name _target} else {"multiple"}
        };
        diag_log format ["[TERRITOIRE][SYSCHAT] Envoyé à %1: %2", _targetName, _message];
    };
};

// Fonction pour envoyer un message global formalisé
Gemini_fnc_territoryGlobalChat = {
    params [
        ["_target", objNull, [objNull, 0, []]],  // Cible (joueur, côté ou array)
        ["_sender", "QG", [""]],                 // Expéditeur du message (ex: "QG", "Chef", etc.)
        ["_recipient", "Patrouille", [""]],      // Destinataire (ex: "Patrouille", "Forces", etc.)
        ["_message", "", [""]]                   // Contenu du message
    ];
    
    // Formater le message global
    private _formattedMessage = format ["%1 à %2: %3", _sender, _recipient, _message];
    
    // Envoyer via la fonction globale existante
    ["globalChat", _formattedMessage] remoteExec ["Gemini_fnc_globalChat", _target];
    
    // Log si en mode debug
    if (OPEX_territory_debug) then {
        private _targetName = if (isNull _target) then {"all"} else {
            if (typeName _target == "OBJECT") then {name _target} else {"multiple"}
        };
        diag_log format ["[TERRITOIRE][GLOBAL] Envoyé à %1: %2", _targetName, _formattedMessage];
    };
};

// Fonction complète pour toutes les notifications d'entrée territoire
Gemini_fnc_territoryEntryNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_territoryState", "", [""]],
        ["_forceDisplay", false, [false]]
    ];
    
    // Ne rien faire si le joueur est nul
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][NOTIF] Erreur: Joueur nul pour notification d'entrée";
    };
    
    // Définir titre, message et couleur selon l'état
    private _title = "";
    private _message = "";
    private _type = "info";
    private _chatMessage = "";
    
    switch (_territoryState) do {
        case "unknown": {
            _title = format ["TERRITOIRE INCONNU: %1", _territoryName];
            _message = "Contactez le PC avant d'approcher.";
            _type = "warning";
            _chatMessage = format ["Nous n'avons aucune information sur %1. Contactez le PC pour obtenir des renseignements avant de poursuivre.", _territoryName];
        };
        case "enemy": {
            _title = format ["TERRITOIRE HOSTILE: %1", _territoryName];
            _message = "Soyez extrêmement vigilant.";
            _type = "error";
            _chatMessage = format ["Attention, vous êtes entré dans un territoire hostile: %1. Restez sur vos gardes.", _territoryName];
        };
        case "neutral": {
            _title = format ["TERRITOIRE NEUTRE: %1", _territoryName];
            _message = "Les habitants sont coopératifs mais restez vigilant.";
            _type = "info";
            _chatMessage = format ["Vous êtes entré dans le territoire neutre de %1. Les locaux semblent pacifiques, mais restez sur vos gardes.", _territoryName];
        };
        case "friendly": {
            _title = format ["TERRITOIRE AMI: %1", _territoryName];
            _message = "Zone sécurisée sous contrôle allié.";
            _type = "success";
            _chatMessage = format ["Vous êtes entré dans le territoire ami de %1. Nos forces y assurent la sécurité.", _territoryName];
        };
        default {
            _title = format ["TERRITOIRE: %1", _territoryName];
            _message = "Statut inconnu.";
            _type = "info";
            _chatMessage = format ["Vous êtes entré dans le territoire %1.", _territoryName];
        };
    };
    
    // Envoyer notification visuelle
    [_player, _title, _message, _type] call Gemini_fnc_territoryNotification;
    
    // Envoyer message system chat
    [_player, format ["Territoire %1: %2", toLower _territoryState, _territoryName]] call Gemini_fnc_territorySystemChat;
    
    // Envoyer message global chat
    [_player, "QG", "Patrouille", _chatMessage] call Gemini_fnc_territoryGlobalChat;
    
    // Logs
    if (OPEX_territory_verboseLogging) then {
        diag_log format ["[TERRITOIRE] Notifications d'entrée envoyées à %1 pour territoire %2 (%3)", 
            name _player, _territoryName, _territoryState];
    };
};

// Fonction complète pour notification de sortie de territoire
Gemini_fnc_territoryExitNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_wasAuthorized", false, [false]],
        ["_wasState", "", [""]]
    ];
    
    // Ne rien faire si le joueur est nul
    if (isNull _player) exitWith {};
    
    // Notification visuelle de sortie
    [_player, "SORTIE DE ZONE", format ["Vous avez quitté le territoire de %1", _territoryName], "info"] 
        call Gemini_fnc_territoryNotification;
    
    // Message simple
    [_player, format ["Vous avez quitté le territoire: %1", _territoryName]] 
        call Gemini_fnc_territorySystemChat;
    
    // Message spécial si territoire inconnu non-autorisé mais pas pénalisé
    if (_wasState == "unknown" && !_wasAuthorized && {(_player getVariable ["territoryPenalized", false]) == false}) then {
        [_player, "QG", "Patrouille", "Bonne décision de vous retirer d'une zone non autorisée. Continuez la mission."] 
            call Gemini_fnc_territoryGlobalChat;
    };
    
    // Logs
    if (OPEX_territory_verboseLogging) then {
        diag_log format ["[TERRITOIRE] Notifications de sortie envoyées à %1 pour territoire %2", 
            name _player, _territoryName];
    };
};

// Fonction pour avertissement de pénalité
Gemini_fnc_territoryPenaltyWarning = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_timeInZone", 0, [0]]
    ];
    
    private _warningMsg = format ["<t size='1.2' color='#FFA500'>AVERTISSEMENT</t><br/>Vous êtes dans %1 depuis presque 2 minutes sans autorisation.<br/>Faites demi-tour ou contactez le PC pour éviter une pénalité.", _territoryName];
    [_warningMsg, 0.5, 0.3, OPEX_territory_notif_warning, 0] remoteExec ["BIS_fnc_dynamicText", _player];
    
    [_player, format ["AVERTISSEMENT: %1 minute en zone non autorisée. Sanction sur notre réputation imminente.", round(_timeInZone/60)]] 
        call Gemini_fnc_territorySystemChat;
    
    if (OPEX_territory_verboseLogging) then {
        diag_log format ["[TERRITOIRE] AVERTISSEMENT envoyé à %1 pour présence non autorisée dans %2", 
            name _player, _territoryName];
    };
};

// Fonction pour notification de pénalité
Gemini_fnc_territoryPenaltyNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];
    
    // Notification claire de pénalité
    private _penaltyMsg = format ["<t size='1.2' color='#FF0000'>PÉNALITÉ</t><br/>Vous avez passé plus de 2 minutes en territoire non autorisé.<br/>Votre réputation a été affectée."];
    [_penaltyMsg, 0.5, 0.3, OPEX_territory_notif_warning, 0] remoteExec ["BIS_fnc_dynamicText", _player];
    
    // Message système
    [_player, "SANCTION: Trop de temps passé en zone non autorisée. Réputation affectée."] 
        call Gemini_fnc_territorySystemChat;
    
    // Annonce globale à tous les joueurs
    [0, "QG", "toutes les unités", format ["La patrouille de %1 a pénétré en zone non renseignée sans autorisation.", name _player]] 
        call Gemini_fnc_territoryGlobalChat;
    
    // Log
    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE] PÉNALITÉ appliquée à %1 pour présence prolongée dans %2", 
            name _player, _territoryName];
    };
};

// Fonction pour notification de réception radio
Gemini_fnc_radioAvailableNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];
    
    // Message pour informer de la disponibilité de l'action radio
    private _message = format ["<t color='#00FF00'>Communication radio disponible</t><br/>Utilisez votre menu d'interaction ACE (par défaut: Windows+T)<br/>pour contacter le PC à propos de %1", _territoryName];
    [_message, 0.5, 0.4, 8, 1] remoteExec ["BIS_fnc_dynamicText", _player];
    
    // Message global également
    [_player, "QG", name _player, format ["Utilisez votre menu ACE pour nous contacter au sujet de %1.", _territoryName]] 
        call Gemini_fnc_territoryGlobalChat;
};

// Initialiser si c'est exécuté directement
if (isServer && !isNil "OPEX_territoryConfig_initialized") then {
    diag_log "[TERRITOIRE][COMMS] Système de messagerie territoriale initialisé";
};