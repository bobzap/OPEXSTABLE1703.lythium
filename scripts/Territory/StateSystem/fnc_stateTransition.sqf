/*
    Fichier: fnc_stateTransition.sqf
    Description: Demande de transition d'état avec validation
    Usage: [_territoryIndex, _newState, _reason] call Gemini_fnc_requestStateTransition
    Retourne: bool

    Transitions valides :
    - unknown -> enemy/neutral/friendly (identification par radio)
    - enemy -> neutral (mission réussie)
    - enemy -> friendly (mission réussie + sécurité haute)
    - neutral -> friendly (sécurité >= 75%)
    - neutral -> enemy (sécurité < 25% ou attaque)
    - friendly -> neutral (attaque, sécurité diminue)
    - friendly -> enemy (sécurité < 25%)
*/

params [
    ["_territoryIndex", -1, [0]],
    ["_newState", "", [""]],
    ["_reason", "manual", [""]]
];

if (!isServer) exitWith {
    diag_log "[TERRITOIRE][STATE] requestStateTransition doit etre execute sur le serveur";
    false
};

if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
    diag_log format ["[TERRITOIRE][STATE] Index invalide: %1", _territoryIndex];
    false
};

if (_newState == "") exitWith {
    diag_log "[TERRITOIRE][STATE] Etat cible vide";
    false
};

private _territoryData = OPEX_territories select _territoryIndex;
private _name = _territoryData select 0;
private _currentState = _territoryData select 3;

// Pas de transition si meme état
if (_currentState == _newState) exitWith {
    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE][STATE] Pas de transition pour %1: deja en etat %2", _name, _currentState];
    };
    false
};

// Verifier si la transition est valide
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
    diag_log format ["[TERRITOIRE][STATE] Transition invalide pour %1: %2 -> %3 (raison: %4)", _name, _currentState, _newState, _reason];
    false
};

diag_log format ["[TERRITOIRE][STATE] Transition validee pour %1: %2 -> %3 (raison: %4)", _name, _currentState, _newState, _reason];

// Appliquer la transition
[_territoryIndex, _newState, -1] call Gemini_fnc_updateTerritoryState;

true
