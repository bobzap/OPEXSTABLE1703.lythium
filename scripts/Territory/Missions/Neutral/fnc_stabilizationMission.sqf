/*
    Fichier: fnc_stabilizationMission.sqf
    Description: Mission de stabilisation d'un territoire neutre
*/

Gemini_fnc_stabilizationMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    diag_log format ["[TERRITOIRE] Offre de mission de stabilisation pour: %1", _locationName];
    
    // Créer la tâche
    private _taskID = format ["stabilize_%1", _territoryIndex];
    private _taskDesc = format ["Établir une présence militaire à %1 en y patrouillant pendant 10 minutes.", _locationName];
    private _taskTitle = format ["Stabiliser %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [_taskDesc, _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "defend"
    ] call BIS_fnc_taskCreate;
    
    // Ajouter script de vérification
    [_taskID, _territoryIndex] spawn {
        params ["_taskID", "_territoryIndex"];
        
        private _territoryData = OPEX_territories select _territoryIndex;
        private _position = _territoryData select 1;
        private _radius = _territoryData select 2;
        private _timeNeeded = 20; // 10 minutes en secondes
        private _timeSpent = 0;
        private _lastCheck = time;
        
        while {_timeSpent < _timeNeeded} do {
            sleep 10;
            private _friendliesInArea = {alive _x && side _x == OPEX_friendly_side1} count (_position nearEntities ["Man", _radius]);
            
            if (_friendliesInArea > 0) then {
                _timeSpent = _timeSpent + (time - _lastCheck);
                hintSilent format ["Stabilisation: %1%2", round((_timeSpent / _timeNeeded) * 100), "%"];
            };
            
            _lastCheck = time;
        };
        
        // Mission réussie
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        
        // Mise à jour explicite du territoire
        private _currentData = OPEX_territories select _territoryIndex;
        private _currentSecurity = _currentData select 4;
        
        // Augmentation significative de la sécurité (+25%)
        private _newSecurity = (_currentSecurity + 25) min 100;
        
        // Vérifier explicitement si le niveau de sécurité justifie un passage à friendly
        if (_newSecurity >= 75) then {
            diag_log format ["[TERRITOIRE] Sécurité suffisante (%1%), passage à l'état friendly", _newSecurity];
            [_territoryIndex, "friendly", _newSecurity] call Gemini_fnc_updateTerritoryState;
            hint format ["La zone %1 est maintenant sous contrôle allié avec %2% de sécurité!", _currentData select 0, _newSecurity];
        } else {
            diag_log format ["[TERRITOIRE] Mise à jour de la sécurité: %1% -> %2% (maintien état neutre)", _currentSecurity, _newSecurity];
            [_territoryIndex, "neutral", _newSecurity] call Gemini_fnc_updateTerritoryState;
            hint format ["Patrouille terminée ! Le niveau de sécurité de %1 a augmenté à %2%.", _currentData select 0, _newSecurity];
        };
        
        // Bonus de réputation
        ["taskSucceeded"] call Gemini_fnc_updateStats;
    };
};