/*
    Fichier: fnc_monitorInit.sqf
    Description: Initialisation du système de surveillance territorial
*/

// Fonction principale pour initialiser le moniteur territorial
Gemini_fnc_initTerritoryMonitor = {
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
    
    // Définir l'indicateur global
    missionNamespace setVariable ["OPEX_territory_monitoring_active", true, true];
    
    // Logs d'initialisation détaillés
    diag_log format ["[TERRITOIRE][MONITEUR] Surveillance territoriale activée - %1 territoires au total", count OPEX_territories];
    
    // Démarrer la boucle principale de surveillance
    [] spawn Gemini_fnc_runTerritoryMonitor;
    
    // Retourner le succès
    true
};

// Fonction pour exécuter la boucle de surveillance
Gemini_fnc_runTerritoryMonitor = {
    // Afficher les détails de tous les territoires au démarrage
    if (OPEX_territory_debug) then {
        diag_log "[TERRITOIRE][MONITEUR] Liste de tous les territoires avec rayons:";
        {
            private _name = _x select 0;
            private _pos = _x select 1;
            private _radius = _x select 2;
            private _state = _x select 3;
            diag_log format ["  - %1: position %2, rayon %3m, état %4", _name, _pos, _radius, _state];
        } forEach OPEX_territories;
    };
    
    // Boucle principale
    while {OPEX_territory_monitoring_active} do {
        // Vérification périodique des positions des joueurs par rapport aux territoires
        if (OPEX_territory_debug && {time % 15 < 0.1}) then { // Environ toutes les 15 secondes
            {
                private _player = _x;
                private _playerPos = getPosATL _player;
                private _playerName = name _player;
                
                diag_log format ["[TERRITOIRE][MONITEUR] DEBUG: Position de %1: %2", _playerName, _playerPos];
                
                {
                    private _name = _x select 0;
                    private _pos = _x select 1;
                    private _radius = _x select 2;
                    private _distance = _playerPos distance _pos;
                    
                    if (_distance < _radius + 100) then { // Afficher seulement les territoires proches
                        diag_log format ["  - Distance à %1: %2m / %3m (%4)", 
                            _name, round(_distance), round(_radius), 
                            if (_distance < _radius) then {"DANS ZONE"} else {"hors zone"}];
                    };
                } forEach OPEX_territories;
            } forEach allPlayers;
        };
        
        // Pour chaque joueur, vérifier sa position par rapport aux territoires
        {
            [_x] call Gemini_fnc_checkPlayerTerritory;
        } forEach allPlayers;
        
        // Intervalle entre vérifications
        sleep 5;
    };
};

// Fonction pour vérifier la position d'un joueur par rapport aux territoires
Gemini_fnc_checkPlayerTerritory = {
    params [["_player", objNull, [objNull]]];
    
    if (isNull _player) exitWith {false};
    
    private _playerPos = getPosATL _player;
    private _playerName = name _player;
    private _inTerritory = false;
    private _territoryIndex = -1;
    
    // Vérifier chaque territoire
    {
        private _territoryData = _x;
        private _name = _territoryData select 0;
        private _position = _territoryData select 1;
        private _radius = _territoryData select 2;
        private _state = _territoryData select 3;
        
        // Calcul de distance 2D (ignorer Z)
        private _distance = [_playerPos select 0, _playerPos select 1, 0] distance2D [_position select 0, _position select 1, 0];
        
        // Vérifier si joueur dans ce territoire
        if (_distance < _radius) then {
            _inTerritory = true;
            _territoryIndex = _forEachIndex;
            
            // Log uniquement en mode debug
            if (OPEX_territory_debug) then {
                diag_log format ["[TERRITOIRE][MONITEUR] Joueur %1 dans territoire %2 (%3) - distance %4m/%5m", 
                    _playerName, _name, _state, round(_distance), round(_radius)];
            };
            
            // Si le joueur est entré dans un nouveau territoire
            if ((_player getVariable ["lastVisitedTerritory", ""]) != _name) then {
                [_player, _forEachIndex] call Gemini_fnc_handleTerritoryEnter;
            };
            
            // Sortir de la boucle, nous avons trouvé le territoire
            break;
        };
    } forEach OPEX_territories;
    
    // Si le joueur n'est dans aucun territoire mais avait un territoire précédemment
    if (!_inTerritory && (_player getVariable ["lastVisitedTerritory", ""]) != "") then {
        [_player] call Gemini_fnc_handleTerritoryExit;
    };
    
    _inTerritory
};