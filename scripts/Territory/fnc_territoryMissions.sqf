/*
    Fichier: fnc_territoryMissions.sqf
    Description: Système de missions liées aux territoires
*/

// OFFRIR UNE MISSION DE LIBÉRATION (pour zones ennemies)
Gemini_fnc_offerLiberationMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    diag_log format ["[TERRITOIRE] Offre de mission de libération pour: %1", _locationName];
    
    // Créer la tâche
    private _taskID = format ["liberate_%1", _territoryIndex];
    private _taskDesc = format ["Libérer %1 en éliminant les forces ennemies présentes.", _locationName];
    private _taskTitle = format ["Libérer %1", _locationName];
    
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
    
    // Spawn d'ennemis pour la mission
    [_territoryIndex, 2, 4] spawn Gemini_fnc_spawnEnemiesForMission;
    
    // Ajouter script de vérification
    [_taskID, _territoryIndex] spawn {
        params ["_taskID", "_territoryIndex"];
        
        private _territoryData = OPEX_territories select _territoryIndex;
        private _position = _territoryData select 1;
        private _radius = _territoryData select 2;
        
        waitUntil {
            sleep 10;
            private _enemiesInArea = {alive _x && side _x == OPEX_enemy_side1} count (_position nearEntities ["Man", _radius]);
            _enemiesInArea == 0
        };
        
        // Mission réussie
        [_territoryIndex, "neutral", 35] call Gemini_fnc_updateTerritoryState;
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        
        // Récompense
["taskSucceeded"] call Gemini_fnc_updateStats;
        
        hint "Territoire libéré ! Un chef de village est maintenant disponible pour vous parler.";
    };
};

// OFFRIR UNE MISSION DE STABILISATION (pour zones neutres)
Gemini_fnc_offerStabilizationMission = {
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

// OFFRIR UNE MISSION DE SÉCURISATION (pour zones amies avec sécurité < 75%)
Gemini_fnc_offerSecurityMission = {
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

// OFFRIR UNE MISSION AVANCÉE (pour zones amies avec sécurité > 75%)
Gemini_fnc_offerAdvancedMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    
    diag_log format ["[TERRITOIRE] Offre de mission avancée pour: %1", _locationName];
    
    // Types de missions possibles
    private _missionTypes = [
        ["intel", "Collecter des renseignements sur les mouvements ennemis"],
        ["training", "Former les forces locales"]
    ];
    
    private _selectedMission = selectRandom _missionTypes;
    private _missionType = _selectedMission select 0;
    private _missionDesc = _selectedMission select 1;
    
    // Créer la tâche
    private _taskID = format ["advanced_%1_%2", _territoryIndex, _missionType];
    private _taskTitle = format ["Mission à %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [format ["%1 à %2.", _missionDesc, _locationName], _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "intel"
    ] call BIS_fnc_taskCreate;
    
 // Gérer la mission selon son type
switch (_missionType) do {
    case "intel": {
        // Créer un point de collecte d'intel
        private _intelPos = [_position, 50, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        private _marker = createMarker [format ["intel_%1", _territoryIndex], _intelPos];
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBlue";
        _marker setMarkerText "Intel";
        
        // Créer un informateur
        private _informer = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _intelPos, [0.5, 0.8], false, "task"] call Gemini_fnc_createUnit;
        
        // Action pour récupérer l'intel
        _informer addAction [
            "Obtenir des renseignements",
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_taskID", "_territoryIndex"];
                
                // Mission réussie
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                
                // Récompense
                ["taskSucceeded"] call Gemini_fnc_updateStats;
                ["gatheredIntel"] call Gemini_fnc_updateStats;
                
                hint "Renseignements obtenus ! Vous avez maintenant des informations sur les positions ennemies proches.";
                
                // Marquer les ennemis proches sur la carte
                private _nearestEnemies = (position _target) nearEntities [["Man", "Car", "Tank"], 2000];
                {
                    if (side _x == OPEX_enemy_side1) then {
                        private _enemyMarker = createMarker [format ["enemy_intel_%1", random 1000], position _x];
                        _enemyMarker setMarkerType "mil_warning";
                        _enemyMarker setMarkerColor "ColorRed";
                        _enemyMarker setMarkerSize [0.5, 0.5];
                        
                        // Supprimer le marqueur après un certain temps
                        [_enemyMarker] spawn {
                            params ["_marker"];
                            sleep 300; // 5 minutes
                            deleteMarker _marker;
                        };
                    };
                } forEach _nearestEnemies;
                
                removeAllActions _target;
            },
            [_taskID, _territoryIndex],
            1.5,
            true,
            true,
            "",
            "true",
            3
        ];
        
        // Gestion de la persistance de l'informateur
        [_informer, _marker] spawn {
            params ["_informer", "_marker"];
            waitUntil {
                sleep 5;
                count (actionIDs _informer) == 0 || !OPEX_assignedTask
            };
            
            // Attendre un peu avant de faire disparaître
            sleep 300; // 5 minutes
            
            // Vérifier qu'aucun joueur n'est proche
            if ({_x distance _informer < 200} count allPlayers == 0) then {
                deleteVehicle _informer;
                deleteMarker _marker;
            };
        };
    };
    
    case "training": {
            // Créer un point d'entraînement
            private _trainingPos = [_position, 50, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos;
            private _marker = createMarker [format ["training_%1", _territoryIndex], _trainingPos];
            _marker setMarkerType "mil_dot";
            _marker setMarkerColor "ColorBlue";
            _marker setMarkerText "Entraînement";
            
            // Créer des recrues
            private _trainees = [];
            for "_i" from 1 to 3 do {
                private _trainee = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _trainingPos, [0.3, 0.5], false, "task"] call Gemini_fnc_createUnit;
                _trainees pushBack _trainee;
            };
            
            // Compteur de temps d'entraînement
            [_taskID, _territoryIndex, _trainingPos, _marker, _trainees] spawn {
                params ["_taskID", "_territoryIndex", "_trainingPos", "_marker", "_trainees"];
                
                private _timeNeeded = 600; // 10 minutes
                private _timeSpent = 0;
                private _lastCheck = time;
                
                while {_timeSpent < _timeNeeded} do {
                    sleep 10;
                    private _friendliesInArea = {alive _x && side _x == OPEX_friendly_side1} count (_trainingPos nearEntities ["Man", 20]);
                    
                    if (_friendliesInArea > 0) then {
                        _timeSpent = _timeSpent + (time - _lastCheck);
                        hintSilent format ["Entraînement: %1%2", round((_timeSpent / _timeNeeded) * 100), "%"];
                    };
                    
                    _lastCheck = time;
                };
                
                // Mission réussie
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                
                // Récompense
                ["taskSucceeded"] call Gemini_fnc_updateStats;
                
                hint "Entraînement terminé ! Les forces locales peuvent maintenant mieux se défendre.";
                
                // Supprimer les recrues et le marqueur
                {deleteVehicle _x} forEach _trainees;
                deleteMarker _marker;
                
                // Spawn d'une patrouille amie dans la zone
                [OPEX_friendly_side1, ["infantry"], 3, _trainingPos, 150, "patrol", _trainingPos, [0.5, 0.8], 100, "task"] call Gemini_fnc_spawnSquad;
            };
        };
    };
};

// SPAWN D'ENNEMIS POUR UNE MISSION DE LIBÉRATION
Gemini_fnc_spawnEnemiesForMission = {
    params [
        ["_territoryIndex", 0, [0]],
        ["_minSquads", 1, [0]],
        ["_maxSquads", 3, [0]]
    ];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    private _squadsCount = _minSquads + floor(random (_maxSquads - _minSquads + 1));
    
    for "_i" from 1 to _squadsCount do {
        private _squadPos = [_position, 20, _radius * 0.8, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        private _squad = [OPEX_enemy_side1, ["infantry"], -1, _squadPos, 0, "defend", _position, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
        
        diag_log format ["[TERRITOIRE] Escouade ennemie créée pour la mission: %1", _squad];
    };
};

// SPAWN D'ATTAQUANTS POUR UNE CONTRE-ATTAQUE
Gemini_fnc_spawnTerritoryAttackers = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    private _name = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE] Contre-attaque sur: %1", _name];
    
    // Notifier les joueurs
    ["globalChat", format ["Rapport: Forces ennemies repérées en approche de %1!", _name]] remoteExec ["Gemini_fnc_globalChat", 0];
    
    // Spawn d'attaquants à distance
    private _attackPos = [_position, _radius * 2, _radius * 3, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    
    private _squadTypes = ["infantry", "infantry", "infantry", "motorized", "armored"];
    private _squadType = selectRandom _squadTypes;
    private _squad = [OPEX_enemy_side1, [_squadType], -1, _attackPos, 0, "attack", _position, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
    
    diag_log format ["[TERRITOIRE] Escouade d'attaque créée: %1", _squad];
    
    // Moniteur pour vérifier l'issue de l'attaque
    [_territoryIndex, _position, _radius] spawn {
        params ["_territoryIndex", "_position", "_radius"];
        
        sleep 120; // Attendre 2 minutes avant de commencer la vérification
        
        private _attackActive = true;
        private _friendliesPresent = false;
        private _enemiesPresent = false;
        
        while {_attackActive} do {
            sleep 30;
            
            private _friendlyCount = {alive _x && side _x == OPEX_friendly_side1} count (_position nearEntities ["Man", _radius]);
            private _enemyCount = {alive _x && side _x == OPEX_enemy_side1} count (_position nearEntities ["Man", _radius]);
            
            _friendliesPresent = _friendlyCount > 0;
            _enemiesPresent = _enemyCount > 0;
            
            // Si personne n'est présent ou si l'attaque a duré plus de 10 minutes
            if ((!_friendliesPresent && !_enemiesPresent) || (time > _endTime)) then {
                _attackActive = false;
            };
            
            // Si les ennemis sont présents mais pas les amis, diminuer la sécurité
            if (_enemiesPresent && !_friendliesPresent) then {
                private _territoryData = OPEX_territories select _territoryIndex;
                private _security = _territoryData select 4;
                private _state = _territoryData select 3;
                
                _security = _security - 10;
                
                // Si la sécurité tombe trop bas, changer l'état
                if (_security < 25 && _state != "enemy") then {
                    [_territoryIndex, "enemy", _security] call Gemini_fnc_updateTerritoryState;
                    ["globalChat", format ["Alerte: %1 est tombé aux mains de l'ennemi!", _territoryData select 0]] remoteExec ["Gemini_fnc_globalChat", 0];
                } else {
                    [_territoryIndex, "", _security] call Gemini_fnc_updateTerritoryState;
                };
            };
        };
    };
};

// SÉLECTION ALÉATOIRE D'UN TYPE DE MISSION SELON L'ÉTAT DU TERRITOIRE
Gemini_fnc_getRandomMissionForState = {
    params ["_territoryIndex", "_state"];
    
    private _missionFunction = nil;
    
    switch (_state) do {
        case "enemy": {
            _missionFunction = Gemini_fnc_offerLiberationMission;
        };
        case "neutral": {
            private _missions = [
                Gemini_fnc_offerStabilizationMission,
                Gemini_fnc_offerPatrolMission,
                Gemini_fnc_offerSupplyMission
            ];
            _missionFunction = selectRandom _missions;
        };
        case "friendly": {
            private _territoryData = OPEX_territories select _territoryIndex;
            private _securityLevel = _territoryData select 4;
            
            if (_securityLevel < 75) then {
                private _missions = [
                    Gemini_fnc_offerSecurityMission,
                    Gemini_fnc_offerCheckpointMission
                ];
                _missionFunction = selectRandom _missions;
            } else {
                private _missions = [
                    Gemini_fnc_offerAdvancedMission,
                    Gemini_fnc_offerIntelMission
                ];
                _missionFunction = selectRandom _missions;
            };
        };
    };
    
    _missionFunction
};