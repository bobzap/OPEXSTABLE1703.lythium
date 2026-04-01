/*
    Fichier: fnc_messagingSystem.sqf
    Description: Systeme centralise de notifications pour le systeme territorial
    Style: Tout via BIS_fnc_dynamicText

    Positions (fractions ecran 0-1, compatibles serveur dedie):
    - Layer 700: Notifications principales (x=0.6, y=0.15) — sous la boussole, a droite
    - Layer 701: Messages radio (x=0.55, y=0.28) — en dessous
    - Layer 702: Infos secondaires (x=0.6, y=0.40) — description chef etc.
*/

// Notification principale
Gemini_fnc_territoryNotification = {
    params [
        ["_target", objNull, [objNull, 0, []]],
        ["_title", "", [""]],
        ["_message", "", [""]],
        ["_type", "info", [""]],
        ["_duration", -1, [0]]
    ];

    private _color = switch (_type) do {
        case "warning": {"#FFA500"};
        case "error": {"#FF0000"};
        case "success": {"#55CC55"};
        case "radio": {"#00CCCC"};
        default {"#DDDDDD"};
    };

    if (_duration < 0) then {
        _duration = switch (_type) do {
            case "warning": {7};
            case "error": {7};
            case "radio": {5};
            default {5};
        };
    };

    private _formattedText = format [
        "<t size='1.0' color='%1' shadow='2' align='right'>%2</t><br/><t size='0.8' color='#BBBBBB' shadow='1' align='right'>%3</t>",
        _color, _title, _message
    ];

    // x=0.35 donne un bloc large (35% a 100%) avec texte aligne a droite
    [_formattedText, 0.35, 0.15, _duration, 0.3, 0, 700] remoteExec ["BIS_fnc_dynamicText", _target];

    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE][NOTIF] %1: %2 - %3",
            if (typeName _target == "OBJECT") then {name _target} else {"all"},
            _title, _message
        ];
    };
};

// Message radio — style [EXPEDITEUR] message
Gemini_fnc_territoryGlobalChat = {
    params [
        ["_target", objNull, [objNull, 0, []]],
        ["_sender", "QG", [""]],
        ["_recipient", "Patrouille", [""]],
        ["_message", "", [""]]
    ];

    private _formattedText = format [
        "<t size='0.85' color='#00CCCC' shadow='1' align='right'>[%1]</t><br/><t size='0.75' color='#BBBBBB' shadow='1' align='right'>%2</t>",
        _sender, _message
    ];

    // x=0.35 bloc large, texte aligne a droite
    [_formattedText, 0.35, 0.28, 6, 0.3, 0, 701] remoteExec ["BIS_fnc_dynamicText", _target];

    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE][RADIO] [%1 -> %2] %3", _sender, _recipient, _message];
    };
};

// Info secondaire — description chef, infos discretes
Gemini_fnc_territorySystemChat = {
    params [
        ["_target", objNull, [objNull, 0, []]],
        ["_message", "", [""]]
    ];

    private _formattedText = format [
        "<t size='0.75' color='#999999' shadow='1' align='right'>%1</t>",
        _message
    ];

    // x=0.35 bloc large, texte aligne a droite
    [_formattedText, 0.35, 0.38, 5, 0.3, 0, 702] remoteExec ["BIS_fnc_dynamicText", _target];

    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE][INFO] %1", _message];
    };
};

// Notification d'entree territoire
Gemini_fnc_territoryEntryNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_territoryState", "", [""]],
        ["_forceDisplay", false, [false]]
    ];

    if (isNull _player) exitWith {};

    private _title = "";
    private _message = "";
    private _type = "info";

    switch (_territoryState) do {
        case "unknown": {
            _title = format ["ZONE INCONNUE — %1", _territoryName];
            _message = "Contactez le PC par radio avant de poursuivre.";
            _type = "warning";
        };
        case "enemy": {
            _title = format ["ZONE HOSTILE — %1", _territoryName];
            _message = "Presence ennemie confirmee. Vigilance maximale.";
            _type = "error";
        };
        case "neutral": {
            _title = format ["ZONE NEUTRE — %1", _territoryName];
            _message = "Population cooperative. Restez vigilant.";
            _type = "info";
        };
        case "friendly": {
            _title = format ["ZONE AMIE — %1", _territoryName];
            _message = "Secteur sous controle allie.";
            _type = "success";
        };
        default {
            _title = format ["ZONE — %1", _territoryName];
            _message = "Statut inconnu.";
            _type = "info";
        };
    };

    [_player, _title, _message, _type] call Gemini_fnc_territoryNotification;

    if (OPEX_territory_verboseLogging) then {
        diag_log format ["[TERRITOIRE] Entree %1 dans %2 (%3)", name _player, _territoryName, _territoryState];
    };
};

// Notification de sortie territoire
Gemini_fnc_territoryExitNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_wasAuthorized", false, [false]],
        ["_wasState", "", [""]]
    ];

    if (isNull _player) exitWith {};

    [_player, "SORTIE DE ZONE", format ["Vous avez quitte %1", _territoryName], "info", 3]
        call Gemini_fnc_territoryNotification;

    if (OPEX_territory_verboseLogging) then {
        diag_log format ["[TERRITOIRE] Sortie %1 de %2", name _player, _territoryName];
    };
};

// Avertissement de penalite
Gemini_fnc_territoryPenaltyWarning = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]],
        ["_timeInZone", 0, [0]]
    ];

    [_player,
        "AVERTISSEMENT",
        format ["Zone %1 — presence non autorisee. Contactez le PC ou faites demi-tour.", _territoryName],
        "warning", 8
    ] call Gemini_fnc_territoryNotification;
};

// Notification de penalite
Gemini_fnc_territoryPenaltyNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];

    [_player,
        "PENALITE",
        "Presence non autorisee prolongee. Reputation affectee.",
        "error", 10
    ] call Gemini_fnc_territoryNotification;
};

// Notification radio disponible
Gemini_fnc_radioAvailableNotification = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryName", "", [""]]
    ];

    [_player,
        "RADIO DISPONIBLE",
        format ["Menu ACE (Win+T) pour contacter le PC sur %1", _territoryName],
        "radio", 6
    ] call Gemini_fnc_territoryNotification;
};

// Init
if (isServer && !isNil "OPEX_territoryConfig_initialized") then {
    diag_log "[TERRITOIRE][COMMS] Systeme de messagerie territoriale initialise";
};
