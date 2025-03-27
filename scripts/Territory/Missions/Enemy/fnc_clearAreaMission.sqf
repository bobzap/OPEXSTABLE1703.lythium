/*
    Fichier: fnc_clearAreaMission.sqf
    Description: Mission d'élimination des ennemis dans un territoire hostile
*/

Gemini_fnc_clearAreaMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    // Créer la tâche
    private _taskID = format ["clear_%1", _territoryIndex];
    private _taskDesc = format ["Éliminez toutes les forces ennemies à %1 pour sécuriser la zone.", _locationName];
    private _taskTitle = format ["Nettoyage: %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [_taskDesc, _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "attack"
    ] call BIS_fnc_taskCreate;
    
    // Spawn d'ennemis pour la mission (1-3 groupes)
    private _groupsCount = 1 + floor(random 2);
    
    for "_i" from 1 to _groupsCount do {
        [OPEX_enemy_side1, ["infantry"], [2, 4], _position, [10, _radius * 0.8], "defend", _position, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
    };
    
    // Vérification de la tâche
    [_taskID, _territoryIndex, _position, _radius] spawn {
        params ["_taskID", "_territoryIndex", "_position", "_radius"];
        
        waitUntil {
            sleep 10;
            // Compter les ennemis vivants dans la zone
            private _enemiesAlive = {alive _x && side _x == OPEX_enemy_side1} count (_position nearEntities ["Man", _radius]);
            _enemiesAlive == 0
        };
        
        // Tâche accomplie
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        
        // Augmenter sécurité et réputation
        private _territoryData = OPEX_territories select _territoryIndex;
        private _newSecurity = ((_territoryData select 4) + 20) min 100;
        [_territoryIndex, "neutral", _newSecurity] call Gemini_fnc_updateTerritoryState;
        
        ["taskSucceeded"] call Gemini_fnc_updateStats;
        ["globalChat", format ["Zone nettoyée: %1 est maintenant sécurisée à %2%%", _territoryData select 0, _newSecurity]] remoteExec ["Gemini_fnc_globalChat", 0];
    };
};