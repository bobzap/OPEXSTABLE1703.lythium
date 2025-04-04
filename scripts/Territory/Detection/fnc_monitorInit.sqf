/*
    Fichier: fnc_monitorInit.sqf
    Description: Initialisation du système de surveillance territorial
    Version: 2.0 (Révisée)
*/

// Fonction principale pour initialiser le moniteur territorial
Gemini_fnc_initTerritoryMonitor = {
    diag_log "[TERRITOIRE][DEBUG] Début fonction initTerritoryMonitor";
    
    // Vérifier si le moniteur est déjà actif
    if (!isNil "OPEX_territory_monitoring_active" && {OPEX_territory_monitoring_active}) exitWith {
        diag_log "[TERRITOIRE][MONITEUR] Surveillance déjà active";
        false
    };
    
    // Vérifier que nous sommes sur le serveur
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE][MONITEUR] Initialisation annulée - n'est pas serveur";
        false
    };
    
    // Attendre que le système territorial soit initialisé
    if (isNil "OPEX_territories_initialized" || !OPEX_territories_initialized) then {
        diag_log "[TERRITOIRE][MONITEUR] Attente de l'initialisation des territoires...";
        waitUntil {!isNil "OPEX_territories_initialized" && {OPEX_territories_initialized}};
    };
    
    diag_log "[TERRITOIRE][DEBUG] Initialisation territoriale vérifiée avec succès";
    
    // Définir l'indicateur global
    missionNamespace setVariable ["OPEX_territory_monitoring_active", true, true];
    
    // Logs d'initialisation détaillés
    diag_log format ["[TERRITOIRE][MONITEUR] Surveillance territoriale activée - %1 territoires au total", count OPEX_territories];
    
    // Démarrer la boucle principale de surveillance
    [] spawn Gemini_fnc_runTerritoryMonitor;
    
    diag_log "[TERRITOIRE][DEBUG] Boucle de surveillance démarrée";
    
    // Retourner le succès
    true
};

// Fonction pour exécuter la boucle de surveillance
Gemini_fnc_runTerritoryMonitor = {
    diag_log "[TERRITOIRE][DEBUG] Début de la boucle de surveillance Gemini_fnc_runTerritoryMonitor";
    
    // Vérifier si la surveillance est activée
    if (isNil "OPEX_territory_monitoring_active") then {
        OPEX_territory_monitoring_active = true;
        publicVariable "OPEX_territory_monitoring_active";
    };
    
    // Afficher les détails de tous les territoires au démarrage
    diag_log "[TERRITOIRE][MONITEUR] Liste de tous les territoires avec rayons:";
    {
        private _name = _x select 0;
        private _pos = _x select 1;
        private _radius = _x select 2;
        private _state = _x select 3;
        diag_log format ["  - %1: position %2, rayon %3m, état %4", _name, _pos, _radius, _state];
    } forEach OPEX_territories;
    
    // Compteur de cycles pour le debug
    private _cycleCount = 0;
    
    // Boucle principale
    while {OPEX_territory_monitoring_active} do {
        _cycleCount = _cycleCount + 1;
        diag_log format ["[TERRITOIRE][DEBUG] Cycle de surveillance #%1 - Joueurs actifs: %2", _cycleCount, count allPlayers];
        
        // Pour chaque joueur, vérifier sa position par rapport aux territoires
        {
            [_x] call Gemini_fnc_checkPlayerTerritory;
        } forEach allPlayers;
        
        // Pause pour éviter de surcharger le serveur
        sleep 3;
    };
    
    diag_log "[TERRITOIRE][MONITEUR] Boucle de surveillance terminée";
};

// Fonction pour vérifier la position d'un joueur par rapport aux territoires
Gemini_fnc_checkPlayerTerritory = {
    params [["_player", objNull, [objNull]]];
    
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][DEBUG] Joueur nul dans checkPlayerTerritory";
        false
    };
    
    private _playerPos = getPosATL _player;
    private _playerName = name _player;
    private _inTerritory = false;
    private _territoryIndex = -1;
    private _lastTerritory = _player getVariable ["lastVisitedTerritory", ""];
    
    diag_log format ["[TERRITOIRE][DEBUG] Vérification de position pour joueur: %1 (pos: %2, dernier territoire: %3)", 
        _playerName, [round(_playerPos select 0), round(_playerPos select 1)], _lastTerritory];
    
    // Vérifier chaque territoire
    {
        private _territoryData = _x;
        private _name = _territoryData select 0;
        private _position = _territoryData select 1;
        private _radius = _territoryData select 2;
        private _state = _territoryData select 3;
        
        // Calcul de distance 2D (ignorer Z)
        private _distance = [_playerPos select 0, _playerPos select 1, 0] distance2D [_position select 0, _position select 1, 0];
        
        // Log pour territoires proches
        if (_distance < _radius + 100) then {
            diag_log format ["[TERRITOIRE][DEBUG] Joueur %1 est à %2m du territoire %3 (rayon: %4m)", 
                _playerName, round(_distance), _name, round(_radius)];
        };
        
        // Vérifier si joueur dans ce territoire
        if (_distance < _radius) then {
            _inTerritory = true;
            _territoryIndex = _forEachIndex;
            
            diag_log format ["[TERRITOIRE][DEBUG] !!! JOUEUR DÉTECTÉ !!! %1 EST DANS %2 (distance: %3m, rayon: %4m)", 
                _playerName, _name, round(_distance), round(_radius)];
            
            // Si le joueur est entré dans un nouveau territoire
            if (_lastTerritory != _name) then {
                diag_log format ["[TERRITOIRE][DEBUG] Nouveau territoire pour %1: %2 (ancien: %3)", 
                    _playerName, _name, _lastTerritory];
                    
                // Vérifier si les fonctions sont correctement définies
                if (!isNil "Gemini_fnc_handleTerritoryEnter") then {
                    [_player, _forEachIndex] call Gemini_fnc_handleTerritoryEnter;
                    diag_log format ["[TERRITOIRE][DEBUG] Notification d'entrée envoyée pour %1 dans %2", _playerName, _name];
                } else {
                    diag_log "[TERRITOIRE][ERREUR] Fonction handleTerritoryEnter manquante!";
                };
            };
            
            // Sortir de la boucle, nous avons trouvé le territoire
            break;
        };
    } forEach OPEX_territories;
    
    // Si le joueur n'est dans aucun territoire mais avait un territoire précédemment
    if (!_inTerritory && _lastTerritory != "") then {
        diag_log format ["[TERRITOIRE][DEBUG] %1 a quitté le territoire %2", _playerName, _lastTerritory];
        
        // Vérifier si les fonctions sont correctement définies
        if (!isNil "Gemini_fnc_handleTerritoryExit") then {
            [_player] call Gemini_fnc_handleTerritoryExit;
            diag_log format ["[TERRITOIRE][DEBUG] Notification de sortie envoyée pour %1 (territoire quitté: %2)", 
                _playerName, _lastTerritory];
        } else {
            diag_log "[TERRITOIRE][ERREUR] Fonction handleTerritoryExit manquante!";
        };
    };
    
    _inTerritory
};