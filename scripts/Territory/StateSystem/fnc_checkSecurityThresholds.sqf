/*
    Fichier: fnc_checkSecurityThresholds.sqf
    Description: Verification automatique des seuils de securite pour transitions d'etat
    Usage: [_territoryIndex] call Gemini_fnc_checkSecurityThresholds
    Retourne: bool (true si une transition a eu lieu)
*/

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

private _targetState = "";

// Securite haute -> friendly (sauf si deja friendly ou unknown)
if (_securityLevel >= _thresholdFriendly && _currentState != "friendly" && _currentState != "unknown") then {
    _targetState = "friendly";
};

// Securite basse -> enemy (sauf si deja enemy ou unknown)
if (_securityLevel < _thresholdEnemy && _currentState != "enemy" && _currentState != "unknown") then {
    _targetState = "enemy";
};

// Appliquer si changement necessaire
if (_targetState != "") then {
    diag_log format ["[TERRITOIRE][STATE] Seuil de securite atteint pour %1: securite=%2%% -> %3", _name, _securityLevel, _targetState];
    [_territoryIndex, _targetState, format ["securite %1%%", _securityLevel]] call Gemini_fnc_requestStateTransition;
    true
} else {
    false
};
