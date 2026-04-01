/*
    Fichier: fnc_computeRandomState.sqf
    Description: Calcul de l'etat initial d'un territoire
    Usage: [_position, _radius] call Gemini_fnc_computeRandomState
    Retourne: string ("enemy", "neutral", "friendly", "unknown")

    Logique:
    - Proche du camp (<2500m): friendly (zone securisee connue)
    - Zone intermediaire (2500-5000m): 70% unknown, 20% neutral, 10% friendly
    - Zone eloignee (>5000m): 85% unknown, 10% enemy (connu par renseignement), 5% neutral

    L'etat "reel" (celui revele par la radio) est stocke separement.
    La plupart des territoires commencent "unknown" — le joueur doit utiliser la radio pour decouvrir leur vrai etat.
*/

params [
    ["_position", [0,0,0], [[]]],
    ["_radius", 400, [0]]
];

if (!isServer) exitWith { "unknown" };

private _campPos = getMarkerPos "OPEX_marker_camp";
private _distanceToCamp = _position distance2D _campPos;
private _safeRadius = missionNamespace getVariable ["OPEX_territory_campSafeRadius", 2500];

// Zone securisee proche du camp — toujours connue et amie
if (_distanceToCamp < _safeRadius) exitWith {
    diag_log format ["[TERRITOIRE][STATE] Zone proche du camp (%1m) -> friendly", round _distanceToCamp];
    "friendly"
};

// Zone intermediaire — quelques zones connues, majorite inconnues
if (_distanceToCamp < _safeRadius * 2) exitWith {
    private _roll = random 1;
    private _state = if (_roll < 0.10) then {
        "friendly"
    } else {
        if (_roll < 0.30) then { "neutral" } else { "unknown" }
    };
    diag_log format ["[TERRITOIRE][STATE] Zone intermediaire (%1m), roll=%2 -> %3", round _distanceToCamp, _roll, _state];
    _state
};

// Zone eloignee — presque tout inconnu, quelques renseignements sur les zones hostiles
private _roll = random 1;
private _state = if (_roll < 0.05) then {
    "neutral"
} else {
    if (_roll < 0.15) then { "enemy" } else { "unknown" }
};

diag_log format ["[TERRITOIRE][STATE] Zone eloignee (%1m), roll=%2 -> %3", round _distanceToCamp, _roll, _state];
_state
