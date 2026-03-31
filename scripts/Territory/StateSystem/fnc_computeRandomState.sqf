/*
    Fichier: fnc_computeRandomState.sqf
    Description: Calcul de l'état initial aléatoire d'un territoire

    Utilise les probabilités définies dans fnc_territoryConfig.sqf :
    - OPEX_territory_chance_enemy (0.6)
    - OPEX_territory_chance_neutral (0.3)
    - OPEX_territory_chance_friendly (0.1)
    - OPEX_territory_campSafeRadius (2500)
*/

Gemini_fnc_computeRandomState = {
    params [
        ["_position", [0,0,0], [[]]],
        ["_radius", 400, [0]]
    ];

    if (!isServer) exitWith { "unknown" };

    // Distance au camp de base
    private _campPos = getMarkerPos "OPEX_marker_camp";
    private _distanceToCamp = _position distance2D _campPos;

    // Zone de sécurité proche du camp → toujours neutre ou ami
    private _safeRadius = missionNamespace getVariable ["OPEX_territory_campSafeRadius", 2500];

    if (_distanceToCamp < _safeRadius) exitWith {
        diag_log format ["[TERRITOIRE][STATE] Zone proche du camp (%1m) → friendly", round _distanceToCamp];
        "friendly"
    };

    // Zone intermédiaire (jusqu'à 2x le rayon sûr) → pondération vers neutre
    if (_distanceToCamp < _safeRadius * 2) exitWith {
        private _roll = random 1;
        private _state = if (_roll < 0.15) then {
            "friendly"
        } else {
            if (_roll < 0.65) then { "neutral" } else { "enemy" }
        };
        diag_log format ["[TERRITOIRE][STATE] Zone intermédiaire (%1m), roll=%2 → %3", round _distanceToCamp, _roll, _state];
        _state
    };

    // Zone éloignée → tirage aléatoire avec les probabilités de config
    private _chanceEnemy = missionNamespace getVariable ["OPEX_territory_chance_enemy", 0.6];
    private _chanceNeutral = missionNamespace getVariable ["OPEX_territory_chance_neutral", 0.3];
    // _chanceFriendly = le reste (1 - enemy - neutral)

    private _roll = random 1;
    private _state = if (_roll < _chanceEnemy) then {
        "enemy"
    } else {
        if (_roll < _chanceEnemy + _chanceNeutral) then { "neutral" } else { "friendly" }
    };

    diag_log format ["[TERRITOIRE][STATE] Zone éloignée (%1m), roll=%2 → %3", round _distanceToCamp, _roll, _state];
    _state
};
