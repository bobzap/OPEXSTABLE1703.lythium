/*
    Fichier: fnc_stateTransition.sqf
    Description: Gestion des transitions d'état des territoires

    Transitions valides :
    - unknown → enemy/neutral/friendly (identification par radio)
    - enemy → neutral (mission réussie, sécurité augmente)
    - neutral → friendly (sécurité >= 75%)
    - neutral → enemy (sécurité < 25% ou attaque)
    - friendly → neutral (attaque, sécurité diminue)
    - friendly → enemy (sécurité < 25%)
*/

// Demande de transition d'état avec validation
Gemini_fnc_requestStateTransition = {
    params [
        ["_territoryIndex", -1, [0]],
        ["_newState", "", [""]],
        ["_reason", "manual", [""]]
    ];

    if (!isServer) exitWith {
        diag_log "[TERRITOIRE][STATE] requestStateTransition doit être exécuté sur le serveur";
        false
    };

    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][STATE] Index invalide: %1", _territoryIndex];
        false
    };

    if (_newState == "") exitWith {
        diag_log "[TERRITOIRE][STATE] État cible vide";
        false
    };

    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _currentState = _territoryData select 3;

    // Pas de transition si même état
    if (_currentState == _newState) exitWith {
        if (OPEX_territory_debug) then {
            diag_log format ["[TERRITOIRE][STATE] Pas de transition pour %1: déjà en état %2", _name, _currentState];
        };
        false
    };

    // Vérifier si la transition est valide
    private _validTransitions = [
        ["unknown", "enemy"],
        ["unknown", "neutral"],
        ["unknown", "friendly"],
        ["enemy", "neutral"],
        ["enemy", "friendly"],
        ["neutral", "friendly"],
        ["neutral", "enemy"],
        ["friendly", "neutral"],
        ["friendly", "enemy"]
    ];

    private _transitionPair = [_currentState, _newState];
    if !(_transitionPair in _validTransitions) exitWith {
        diag_log format ["[TERRITOIRE][STATE] Transition invalide pour %1: %2 → %3 (raison: %4)", _name, _currentState, _newState, _reason];
        false
    };

    diag_log format ["[TERRITOIRE][STATE] Transition validée pour %1: %2 → %3 (raison: %4)", _name, _currentState, _newState, _reason];

    // Appliquer la transition via updateTerritoryState
    [_territoryIndex, _newState, -1] call Gemini_fnc_updateTerritoryState;

    true
};

// Vérification automatique des seuils de sécurité
Gemini_fnc_checkSecurityThresholds = {
    params [["_territoryIndex", -1, [0]]];

    if (!isServer) exitWith { false };

    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith { false };

    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _currentState = _territoryData select 3;
    private _securityLevel = _territoryData select 4;

    // Seuils depuis la config
    private _thresholdFriendly = missionNamespace getVariable ["OPEX_territory_security_friendly", 75];
    private _thresholdEnemy = missionNamespace getVariable ["OPEX_territory_security_enemy", 25];

    // Vérifier si un changement est nécessaire
    private _targetState = "";

    // Sécurité haute → friendly (sauf si déjà friendly ou unknown)
    if (_securityLevel >= _thresholdFriendly && _currentState != "friendly" && _currentState != "unknown") then {
        _targetState = "friendly";
    };

    // Sécurité basse → enemy (sauf si déjà enemy ou unknown)
    if (_securityLevel < _thresholdEnemy && _currentState != "enemy" && _currentState != "unknown") then {
        _targetState = "enemy";
    };

    // Appliquer si changement nécessaire
    if (_targetState != "") then {
        diag_log format ["[TERRITOIRE][STATE] Seuil de sécurité atteint pour %1: sécurité=%2%% → %3", _name, _securityLevel, _targetState];
        [_territoryIndex, _targetState, format ["sécurité %1%%", _securityLevel]] call Gemini_fnc_requestStateTransition;
        true
    } else {
        false
    };
};
