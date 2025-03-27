/*
    Fichier: fnc_intelligenceMission.sqf
    Description: Missions avancées pour territoires amis sécurisés
*/

Gemini_fnc_intelligenceMission = {
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