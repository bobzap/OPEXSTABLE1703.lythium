/*
    Fichier: fnc_chiefInteractions.sqf
    Description: Fonctions pour les 3 boutons du dialogue chef de village

    Bouton "Missions disponibles" -> Gemini_fnc_openChiefMissionDialog
    Bouton "Etat du village"      -> Gemini_fnc_showTerritoryStatus
    Bouton "Votre reputation"     -> Gemini_fnc_showFactionReputation
*/

// BOUTON 1: Missions disponibles
Gemini_fnc_openChiefMissionDialog = {
    params [
        ["_chief", objNull, [objNull]],
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];

    if (isNull _chief || isNull _player) exitWith {};

    if (_territoryIndex < 0) then {
        _territoryIndex = _chief getVariable ["territoryIndex", -1];
    };
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {};

    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _state = _territoryData select 3;
    private _securityLevel = _territoryData select 4;

    // Determiner la mission disponible selon l'etat
    private _missionInfo = switch (_state) do {
        case "friendly": {
            if (_securityLevel < 75) then {
                ["Securisation", "Le village a besoin de patrouilles et de checkpoints pour renforcer la securite."]
            } else {
                ["Renseignement", "La zone est securisee. Collectez des informations aupres de la population."]
            };
        };
        case "neutral": {
            ["Stabilisation", "Etablissez une presence militaire pour rassurer la population."]
        };
        case "enemy": {
            ["Combat", "Des forces hostiles occupent la zone. Nettoyage necessaire."]
        };
        default {
            ["Aucune", "Aucune mission disponible pour le moment."]
        };
    };

    _missionInfo params ["_missionType", "_missionDesc"];

    private _text = format [
        "<t size='1.0' color='#FFD700' shadow='2' align='right'>Missions — %1</t><br/><t size='0.8' color='#BBBBBB' shadow='1' align='right'>Type: %2</t><br/><t size='0.75' color='#999999' shadow='1' align='right'>%3</t>",
        _name, _missionType, _missionDesc
    ];

    [_text, 0.35, 0.15, 8, 0.3, 0, 700] remoteExec ["BIS_fnc_dynamicText", _player];
};

// BOUTON 2: Etat du village
Gemini_fnc_showTerritoryStatus = {
    params [["_chief", objNull, [objNull]], ["_player", objNull, [objNull]]];

    if (isNull _chief) exitWith {};

    private _territoryIndex = _chief getVariable ["territoryIndex", -1];
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {};

    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _state = _territoryData select 3;
    private _securityLevel = _territoryData select 4;

    private _stateText = switch (_state) do {
        case "friendly": {"sous controle allie"};
        case "neutral": {"neutre"};
        case "enemy": {"hostile"};
        default {"inconnu"};
    };

    private _stateColor = [_state] call Gemini_fnc_getTerritoryColor;
    private _incident = [_territoryIndex] call Gemini_fnc_getRecentIncidents;

    private _text = format [
        "<t size='1.0' color='#FFD700' shadow='2' align='right'>Village de %1</t><br/><t size='0.8' color='%2' shadow='1' align='right'>Statut: %3</t><br/><t size='0.8' color='#BBBBBB' shadow='1' align='right'>Securite: %4%%</t><br/><t size='0.75' color='#999999' shadow='1' align='right'>%5</t>",
        _name, _stateColor, _stateText, _securityLevel, _incident
    ];

    [_text, 0.35, 0.15, 8, 0.3, 0, 700] remoteExec ["BIS_fnc_dynamicText", _player];
};

// Couleur selon l'etat
Gemini_fnc_getTerritoryColor = {
    params ["_state"];
    switch (_state) do {
        case "friendly": {"#5588FF"};
        case "neutral": {"#55CC55"};
        case "enemy": {"#FF4444"};
        default {"#DDDDDD"};
    };
};

// Incidents recents (narratif)
Gemini_fnc_getRecentIncidents = {
    params ["_territoryIndex"];
    selectRandom [
        "Aucun incident recent signale.",
        "Quelques vols rapportes par les habitants.",
        "Une patrouille ennemie reperee hier soir.",
        "Un vehicule suspect a traverse le village.",
        "Des coups de feu entendus cette nuit.",
        "La population semble calme mais mefiante.",
        "Des traces de passage de vehicules lourds."
    ]
};

// BOUTON 3: Reputation
Gemini_fnc_showFactionReputation = {
    params [["_chief", objNull, [objNull]], ["_player", objNull, [objNull]]];

    if (isNull _chief) exitWith {};

    // Recuperer la reputation actuelle
    private _reputation = call Gemini_fnc_reputation;
    private _reputationValue = _reputation select 0;
    private _reputationText = _reputation select 1;

    private _color = switch (true) do {
        case (_reputationValue < -100): {"#FF4444"};
        case (_reputationValue < 0): {"#FFA500"};
        case (_reputationValue < 100): {"#FFFF00"};
        default {"#55CC55"};
    };

    private _effect = [_reputationValue] call Gemini_fnc_getReputationEffect;

    private _text = format [
        "<t size='1.0' color='#FFD700' shadow='2' align='right'>Reputation locale</t><br/><t size='0.9' color='%1' shadow='1' align='right'>%2</t><br/><t size='0.8' color='#BBBBBB' shadow='1' align='right'>Score: %3</t><br/><t size='0.75' color='#999999' shadow='1' align='right'>%4</t>",
        _color, _reputationText, _reputationValue, _effect
    ];

    [_text, 0.35, 0.15, 8, 0.3, 0, 700] remoteExec ["BIS_fnc_dynamicText", _player];
};

// Effet de la reputation
Gemini_fnc_getReputationEffect = {
    params ["_reputationValue"];
    switch (true) do {
        case (_reputationValue < -100): {"La population est hostile."};
        case (_reputationValue < 0): {"La cooperation est difficile."};
        case (_reputationValue < 50): {"Cooperation limitee possible."};
        case (_reputationValue < 100): {"Soutien modere de la population."};
        default {"La population est cooperative."};
    };
};
