/*
    Fichier: fnc_missionManager.sqf
    Description: Gestionnaire central des missions territoriales
*/

// Fonction principale pour attribuer une mission selon le type de territoire
Gemini_fnc_territoryMissionManager = {
    params [["_territoryIndex", -1, [0]], ["_state", "", [""]]];
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][MISSIONS] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][MISSIONS] Recherche de mission pour %1 (état: %2)", _name, _state];
    
    // Sélectionner le type de mission selon l'état du territoire
    switch (_state) do {
        case "unknown": {
            // Les missions pour territoires inconnus sont gérées différemment via la radio
            [_territoryIndex] call Gemini_fnc_initiateRadioCommunication;
        };
        case "enemy": {
            [_territoryIndex] call Gemini_fnc_offerEnemyMission;
        };
        case "neutral": {
            [_territoryIndex] call Gemini_fnc_offerNeutralMission;
        };
        case "friendly": {
            [_territoryIndex] call Gemini_fnc_offerFriendlyMission;
        };
        default {
            diag_log format ["[TERRITOIRE][MISSIONS] État non reconnu: %1", _state];
            false
        };
    };
    
    true
};

// Sélection aléatoire de mission pour territoire hostile
Gemini_fnc_offerEnemyMission = {
    params [["_territoryIndex", -1, [0]]];
    
    private _missionType = selectRandom ["clear", "cache", "rescue"];
    
    switch (_missionType) do {
        case "clear": { [_territoryIndex] call Gemini_fnc_clearAreaMission; };
        case "cache": { [_territoryIndex] call Gemini_fnc_cacheMission; };
        case "rescue": { [_territoryIndex] call Gemini_fnc_rescueMission; };
    };
};

// Sélection aléatoire de mission pour territoire neutre
Gemini_fnc_offerNeutralMission = {
    params [["_territoryIndex", -1, [0]]];
    
    [_territoryIndex] call Gemini_fnc_stabilizationMission;
};

// Sélection aléatoire de mission pour territoire ami
Gemini_fnc_offerFriendlyMission = {
    params [["_territoryIndex", -1, [0]]];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _securityLevel = _territoryData select 4;
    
    if (_securityLevel < 75) then {
        [_territoryIndex] call Gemini_fnc_securityMission;
    } else {
        [_territoryIndex] call Gemini_fnc_intelligenceMission;
    };
};