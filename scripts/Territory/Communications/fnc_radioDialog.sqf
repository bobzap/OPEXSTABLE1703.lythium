/*
    Fichier: fnc_radioDialog.sqf
    Description: Sequences de dialogue radio entre le joueur et le QG
    Style: Notifications haut-droite uniquement (pas de systemChat/globalChat)
*/

// Fonction principale pour demarrer un dialogue radio
Gemini_fnc_startRadioDialog = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];

    if (isNull _player) exitWith { false };
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith { false };
    if (!hasInterface) exitWith { false };
    if (_player != player) exitWith { false };

    // Verifier si une radio est active
    if (missionNamespace getVariable ["OPEX_radioComm_active", false]) exitWith {
        [_player, "RADIO", "Communication deja en cours. Patientez.", "warning", 3] call Gemini_fnc_territoryNotification;
        false
    };

    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _actualState = _territoryData select 3;

    diag_log format ["[TERRITOIRE][RADIO] Dialogue radio: %1 pour %2 (etat: %3)", name _player, _territoryName, _actualState];

    // Marquer la radio comme active
    missionNamespace setVariable ["OPEX_radioComm_active", true, true];
    publicVariable "OPEX_radioComm_active";
    _player setVariable ["territoryAuthorized", true, true];

    // Message du joueur
    [_player, "QG", "Patrouille", format ["PC, ici patrouille. Demande SITREP sur zone %1. Termine.", _territoryName]] call Gemini_fnc_territoryGlobalChat;

    // Sequence de dialogue
    [_player, _territoryIndex, _territoryName, _actualState] spawn {
        params ["_player", "_territoryIndex", "_territoryName", "_actualState"];

        sleep 3;

        // Reponse PC - accusé de reception
        [_player, "PC", "Patrouille", format ["Bien recu. Analyse de la zone %1 en cours. Patientez. Termine.", _territoryName]] call Gemini_fnc_territoryGlobalChat;

        // Delai d'analyse aleatoire
        sleep (5 + random 5);

        // Reponse PC - resultat selon l'etat reel
        private _responseData = [_territoryIndex] call Gemini_fnc_getHQResponse;
        _responseData params ["_responseText", "_responseState"];

        [_player, "PC", "Patrouille", _responseText] call Gemini_fnc_territoryGlobalChat;

        // Reveler l'etat du territoire
        if (_actualState != "unknown") then {
            [_territoryIndex, _actualState, -1] remoteExec ["Gemini_fnc_updateTerritoryState", 2];
            [_territoryIndex] remoteExec ["Gemini_fnc_addToAuthorizedTerritories", 2];

            sleep 3;

            // Notification d'etat avec couleur
            private _stateType = switch (_actualState) do {
                case "enemy": { "error" };
                case "neutral": { "info" };
                case "friendly": { "success" };
                default { "info" };
            };
            private _stateMsg = switch (_actualState) do {
                case "enemy": { "Zone hostile confirmee. Vigilance maximale." };
                case "neutral": { "Zone neutre. Soyez courtois, restez sur vos gardes." };
                case "friendly": { "Zone amie. Sous controle des forces alliees." };
                default { "Statut indetermine. Prudence." };
            };

            [_player, format ["TERRITOIRE %1", toUpper _actualState], _stateMsg, _stateType, 8] call Gemini_fnc_territoryNotification;

            // Supprimer l'action radio
            [_player, _territoryIndex] remoteExec ["Gemini_fnc_removeRadioAction", _player];
        } else {
            sleep 3;
            [_player, "ZONE NON RENSEIGNEE", format ["Restez en dehors de %1 jusqu'a nouvel ordre.", _territoryName], "warning", 8] call Gemini_fnc_territoryNotification;
            _player setVariable ["territoryAuthorized", false, true];
        };

        // Fin de communication
        sleep 2;
        missionNamespace setVariable ["OPEX_radioComm_active", false, true];
        publicVariable "OPEX_radioComm_active";
    };

    true
};

// Rapport radio joueur-a-joueur
Gemini_fnc_playerToPlayerRadio = {
    params [
        ["_sender", objNull, [objNull]],
        ["_recipient", objNull, [objNull]],
        ["_message", "", [""]]
    ];

    if (isNull _sender || isNull _recipient) exitWith {false};
    if (_message == "") exitWith {false};

    if (!([_sender] call Gemini_fnc_canUseRadio) || !([_recipient] call Gemini_fnc_canUseRadio)) exitWith {
        [_sender, "RADIO", "Communication impossible: radio requise.", "warning", 3] call Gemini_fnc_territoryNotification;
        false
    };

    [_recipient, name _sender, name _recipient, _message] call Gemini_fnc_territoryGlobalChat;
    true
};

// Alerte radio du QG
Gemini_fnc_hqAlert = {
    params [
        ["_target", 0, [objNull, 0, []]],
        ["_message", "", [""]],
        ["_priority", "normal", [""]]
    ];

    if (_message == "") exitWith {false};

    private _type = switch (_priority) do {
        case "high": { "warning" };
        case "emergency": { "error" };
        default { "radio" };
    };

    private _prefix = switch (_priority) do {
        case "high": { "URGENT" };
        case "emergency": { "ALERTE" };
        default { "QG" };
    };

    [_target, _prefix, _message, _type, 8] call Gemini_fnc_territoryNotification;
    true
};

if (isServer) then {
    diag_log "[TERRITOIRE][RADIO] Module radioDialog initialise";
};
