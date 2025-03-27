/*
    Fichier: fnc_securityMission.sqf
    Description: Missions de sécurisation pour territoires amis
*/

Gemini_fnc_securityMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    diag_log format ["[TERRITOIRE] Offre de mission de sécurisation pour: %1", _locationName];
    
    // Types de missions possibles
    private _missionTypes = [
        ["checkpoint", "Établir un checkpoint pour contrôler les accès à la zone"],
        ["patrol", "Effectuer des patrouilles régulières dans la zone"],
        ["supply", "Apporter des fournitures médicales aux habitants"]
    ];
    
    private _selectedMission = selectRandom _missionTypes;
    private _missionType = _selectedMission select 0;
    private _missionDesc = _selectedMission select 1;
    
    // Créer la tâche
    private _taskID = format ["secure_%1_%2", _territoryIndex, _missionType];
    private _taskTitle = format ["Sécuriser %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [format ["%1 à %2.", _missionDesc, _locationName], _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "defend"
    ] call BIS_fnc_taskCreate;
    
    // Gérer la mission selon son type
    switch (_missionType) do {
        case "checkpoint": {
            // Créer un marqueur pour le checkpoint
            private _checkpointPos = [_position, 50, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos;
            private _marker = createMarker [format ["checkpoint_%1", _territoryIndex], _checkpointPos];
            _marker setMarkerType "mil_triangle";
            _marker setMarkerColor "ColorBlue";
            _marker setMarkerText "Checkpoint";
            
            // Vérification
            [_taskID, _territoryIndex, _checkpointPos, _marker] spawn {
                params ["_taskID", "_territoryIndex", "_checkpointPos", "_marker"];
                
                private _timeNeeded = 900; // 15 minutes
                private _timeSpent = 0;
                private _lastCheck = time;
                
                while {_timeSpent < _timeNeeded} do {
                    sleep 10;
                    private _friendliesInArea = {alive _x && side _x == OPEX_friendly_side1} count (_checkpointPos nearEntities ["Man", 25]);
                    
                    if (_friendliesInArea > 0) then {
                        _timeSpent = _timeSpent + (time - _lastCheck);
                        hintSilent format ["Checkpoint: %1%2", round((_timeSpent / _timeNeeded) * 100), "%"];
                    };
                    
                    _lastCheck = time;
                };
                
                // Mission réussie
                private _territoryData = OPEX_territories select _territoryIndex;
                private _currentSecurity = _territoryData select 4;
                [_territoryIndex, "", _currentSecurity + 10] call Gemini_fnc_updateTerritoryState;
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                
                // Récompense
                ["taskSucceeded"] call Gemini_fnc_updateStats;
                
                hint "Checkpoint établi ! Le niveau de sécurité de la zone a augmenté.";
                deleteMarker _marker;
            };
        };
        
        case "patrol": {
            // Créer des points de patrouille
            private _patrolPoints = [];
            for "_i" from 1 to 3 do {
                private _patrolPos = [_position, 50, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                private _marker = createMarker [format ["patrol_%1_%2", _territoryIndex, _i], _patrolPos];
                _marker setMarkerType "mil_dot";
                _marker setMarkerColor "ColorBlue";
                _marker setMarkerText format ["Point %1", _i];
                _patrolPoints pushBack [_patrolPos, _marker];
            };
            
            // Vérification
            [_taskID, _territoryIndex, _patrolPoints] spawn {
                params ["_taskID", "_territoryIndex", "_patrolPoints"];
                
                private _pointsVisited = [false, false, false];
                private _allVisited = false;
                
                while {!_allVisited} do {
                    sleep 5;
                    
                    for "_i" from 0 to 2 do {
                        if (!(_pointsVisited select _i)) then {
                            private _point = (_patrolPoints select _i) select 0;
                            private _friendliesAtPoint = {alive _x && side _x == OPEX_friendly_side1} count (_point nearEntities ["Man", 15]);
                            
                            if (_friendliesAtPoint > 0) then {
                                _pointsVisited set [_i, true];
                                (_patrolPoints select _i) select 1 setMarkerColor "ColorGreen";
                                hint format ["Point de patrouille %1 atteint !", _i + 1];
                            };
                        };
                    };
                    
                    _allVisited = true;
                    {if (!_x) then {_allVisited = false}} forEach _pointsVisited;
                };
                
                // Mission réussie
                private _territoryData = OPEX_territories select _territoryIndex;
                private _currentSecurity = _territoryData select 4;
                [_territoryIndex, "", _currentSecurity + 10] call Gemini_fnc_updateTerritoryState;
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                
                // Récompense
                ["taskSucceeded"] call Gemini_fnc_updateStats;
                
                hint "Patrouille terminée ! Le niveau de sécurité de la zone a augmenté.";
                {deleteMarker (_x select 1)} forEach _patrolPoints;
            };
        };
        
        case "supply": {
            // Créer un point de livraison
            private _supplyPos = [_position, 20, 100, 3, 0, 20, 0] call BIS_fnc_findSafePos;
            private _marker = createMarker [format ["supply_%1", _territoryIndex], _supplyPos];
            _marker setMarkerType "mil_box";
            _marker setMarkerColor "ColorBlue";
            _marker setMarkerText "Fournitures";
            
            // Créer une caisse à déposer
            private _supplyBox = "Land_PaperBox_01_small_closed_brown_F" createVehicle (getMarkerPos "OPEX_marker_medical");
            _supplyBox setPos (getMarkerPos "OPEX_marker_medical");
            
            // Action pour charger la caisse
            _supplyBox addAction [
                "Prendre les fournitures médicales",
                {
                    params ["_target", "_caller", "_actionId", "_arguments"];
                    deleteVehicle _target;
                    _caller setVariable ["carryingSupplies", true, true];
                    hint "Fournitures médicales récupérées. Livrez-les au point marqué sur la carte.";
                },
                nil,
                1.5,
                true,
                true,
                "",
                "true",
                5
            ];
            
            // Vérification
            [_taskID, _territoryIndex, _supplyPos, _marker] spawn {
                params ["_taskID", "_territoryIndex", "_supplyPos", "_marker"];
                
                private _delivered = false;
                
                while {!_delivered} do {
                    sleep 5;
                    private _players = allPlayers select {(_x distance _supplyPos < 10) && (_x getVariable ["carryingSupplies", false])};
                    
                    if (count _players > 0) then {
                        private _player = _players select 0;
                        _player setVariable ["carryingSupplies", false, true];
                        _delivered = true;
                    };
                };
                
                // Mission réussie
                private _territoryData = OPEX_territories select _territoryIndex;
                private _currentSecurity = _territoryData select 4;
                [_territoryIndex, "", _currentSecurity + 15] call Gemini_fnc_updateTerritoryState;
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                
                // Récompense
                ["taskSucceeded"] call Gemini_fnc_updateStats;
                
                hint "Fournitures livrées ! Le niveau de sécurité et la réputation ont augmenté.";
                deleteMarker _marker;
            };
        };
    };
};