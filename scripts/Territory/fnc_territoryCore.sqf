/*
    Fichier: fnc_territoryCore.sqf
    Description: Fonctions principales du système de contrôle territorial
*/

// INITIALISATION DU SYSTÈME DE TERRITOIRE
Gemini_fnc_initTerritorySystem = {
    if (!isServer) exitWith {};
    
    // Initialiser l'array principal des territoires
    OPEX_territories = [];
    publicVariable "OPEX_territories";
    
    // Log dans le RPT
    diag_log "[TERRITOIRE] Initialisation du système...";
    
    // Utiliser les localités existantes pour créer les territoires
    {
        private _locationName = text _x;
        private _locationPos = position _x;
        private _radius = (size _x select 0) max 200;
        
        // Ne pas utiliser les zones sûres
        if (!([_locationPos, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted)) then {
            // Déterminer état initial (basé sur la distance de la FOB)
            private _state = "enemy";
            if (_locationPos distance (getMarkerPos "OPEX_marker_camp") < 1000) then {
                _state = "neutral";
            };
            
            // Créer un territoire
            [_locationName, _locationPos, _radius, _state] call Gemini_fnc_createTerritory;
            diag_log format ["[TERRITOIRE] Territoire créé: %1 (%2)", _locationName, _state];
        };
    } forEach nearestLocations [OPEX_mapCenter, ["NameVillage", "NameCity", "NameCityCapital"], OPEX_mapRadius];
    
    // Marqueur de test
    if (count OPEX_territories == 0) then {
        diag_log "[TERRITOIRE] ATTENTION: Aucun territoire n'a été créé!";
        
        // Créer un territoire de test
        ["Test Village", getMarkerPos "OPEX_marker_camp", 300, "friendly"] call Gemini_fnc_createTerritory;
    };
    
    diag_log format ["[TERRITOIRE] Système initialisé avec %1 territoires", count OPEX_territories];
    OPEX_territories_initialized = true;
    publicVariable "OPEX_territories_initialized";
    
    // Initialiser les chefs pour tous les territoires neutres et amis
    [] spawn {
        // Attendre un peu que tous les territoires soient créés
        sleep 5;
        
        diag_log "[TERRITOIRE] Initialisation des chefs de village...";
        
        {
            private _territoryData = _x;
            private _state = _territoryData select 3;
            private _index = _forEachIndex;
            private _name = _territoryData select 0;
            
            if (_state == "neutral" || _state == "friendly") then {
                // Vérifier qu'il n'y a pas déjà un chef
                if (isNull (_territoryData select 5)) then {
                    diag_log format ["[TERRITOIRE] Création initiale d'un chef pour territoire %1 (%2)", _name, _state];
                    [_index] spawn Gemini_fnc_spawnVillageChief;
                };
            };
        } forEach OPEX_territories;
    };
};

// CRÉATION D'UN TERRITOIRE
Gemini_fnc_createTerritory = {
    params [
        ["_name", "", [""]],
        ["_position", [0,0,0], [[]]],
        ["_radius", 200, [0]],
        ["_state", "enemy", [""]]
    ];
    
    if (_name == "" || _position isEqualTo [0,0,0]) exitWith {
        diag_log "[TERRITOIRE] Erreur: Impossible de créer un territoire sans nom ou position";
        []
    };
    
    diag_log format ["[TERRITOIRE] Création du territoire: %1 (état: %2)", _name, _state];
    
    // Structure de données pour un territoire
    private _territoryData = [
        _name,              // Nom
        _position,          // Position
        _radius,            // Rayon
        _state,             // État (enemy/neutral/friendly)
        25,                 // Niveau de sécurité (%)
        objNull,            // Référence au chef de village (si présent)
        false,              // Chef contacté
        time,               // Timestamp dernier changement
        []                  // Marqueurs associés
    ];
    
    // Créer des marqueurs pour le territoire
    [_territoryData] call Gemini_fnc_createTerritoryMarkers;
    
    // Ajouter à l'array principal
    OPEX_territories pushBack _territoryData;
    publicVariable "OPEX_territories";
    
    // Index du territoire nouvellement créé
    private _index = count OPEX_territories - 1;
    
    // Spawner le chef de village si c'est une zone neutre ou amie
    if (_state != "enemy") then {
        diag_log format ["[TERRITOIRE] Territoire non-hostile: %1 - Tentative de spawn chef", _name];
        
        // Appel direct sans spawn pour déboguer
        [_index] call Gemini_fnc_spawnVillageChief;
    };
    
    _territoryData
};

// CRÉATION DES MARQUEURS DE TERRITOIRE
Gemini_fnc_createTerritoryMarkers = {
    params [["_territoryData", [], [[]]]];
    
    if (count _territoryData < 4) exitWith {
        diag_log "[TERRITOIRE] Erreur: Données de territoire invalides pour création de marqueurs";
        []
    };
    
    private _name = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    private _state = _territoryData select 3;
    
    // Couleur basée sur l'état
    private _color = switch (_state) do {
        case "friendly": {"ColorBLUFOR"};
        case "neutral": {"ColorCIV"};
        default {"ColorOPFOR"};
    };
    
    // Créer un marqueur de zone
    private _markerArea = createMarker [format ["territory_area_%1", _name], _position];
    _markerArea setMarkerShape "ELLIPSE";
    _markerArea setMarkerBrush "SolidBorder";
    _markerArea setMarkerSize [_radius, _radius];
    _markerArea setMarkerColor _color;
    _markerArea setMarkerAlpha 0.3;
    
    // Créer un marqueur icône
    private _markerIcon = createMarker [format ["territory_icon_%1", _name], _position];
    _markerIcon setMarkerType "loc_Ruin";
    _markerIcon setMarkerColor _color;
    _markerIcon setMarkerText _name;
    
    // Stocker les marqueurs dans les données du territoire
    _territoryData set [8, [_markerArea, _markerIcon]];
    
    [_markerArea, _markerIcon]
};

// MISE À JOUR DE L'ÉTAT D'UN TERRITOIRE
Gemini_fnc_updateTerritoryState = {
    params [
        ["_territoryIndex", -1, [0]],
        ["_newState", "", [""]],
        ["_securityLevel", -1, [0]]
    ];
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _oldState = _territoryData select 3;
    private _oldSecurity = _territoryData select 4;
    private _name = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE] Mise à jour du territoire %1: État %2 -> %3, Sécurité: %4 -> %5", 
        _name, _oldState, _newState, _oldSecurity, _securityLevel];
    
    // Logique de changement d'état automatique basée sur la sécurité
    if (_securityLevel != -1) then {
        // Si la sécurité dépasse 75% et que nous ne sommes pas déjà en état friendly
        if (_securityLevel >= 75 && _oldState != "friendly") then {
            _newState = "friendly";
            diag_log format ["[TERRITOIRE] Changement automatique vers friendly pour %1 (sécurité: %2%)", _name, _securityLevel];
        };
        
        // Si la sécurité tombe sous 25% et que nous ne sommes pas déjà en état enemy
        if (_securityLevel < 25 && _oldState != "enemy") then {
            _newState = "enemy";
            diag_log format ["[TERRITOIRE] Changement automatique vers enemy pour %1 (sécurité: %2%)", _name, _securityLevel];
        };
    };
    
    // Mise à jour des données
    if (_newState != "") then {
        _territoryData set [3, _newState];
    };
    
    if (_securityLevel != -1) then {
        _territoryData set [4, _securityLevel];
    };
    
    _territoryData set [7, time]; // Timestamp
    
    // Mise à jour des marqueurs
    private _markers = _territoryData select 8;
    private _currentState = if (_newState != "") then {_newState} else {_oldState};
    
    private _color = switch (_currentState) do {
        case "friendly": {"ColorBLUFOR"};
        case "neutral": {"ColorCIV"};
        default {"ColorOPFOR"};
    };
    
    if (count _markers > 1) then {
        (_markers select 0) setMarkerColor _color;
        (_markers select 1) setMarkerColor _color;
    };
    
    // Mise à jour de l'array principal
    OPEX_territories set [_territoryIndex, _territoryData];
    publicVariable "OPEX_territories";
    
    // Gestion des chefs de village
    if (_oldState != _currentState) then {
        diag_log format ["[TERRITOIRE] Changement d'état pour %1: %2 -> %3", _name, _oldState, _currentState];
        
        if (_currentState == "friendly" || _currentState == "neutral") then {
            if (isNull (_territoryData select 5)) then {
                diag_log format ["[TERRITOIRE] Création forcée d'un chef pour %1", _name];
                [_territoryIndex] call Gemini_fnc_spawnVillageChief;
            };
        };
        
        // Notification
        private _message = switch (_currentState) do {
            case "friendly": {format ["%1 est maintenant sous contrôle ami!", _name]};
            case "neutral": {format ["%1 est maintenant neutre.", _name]};
            case "enemy": {format ["%1 est tombé aux mains de l'ennemi!", _name]};
        };
        
        ["globalChat", _message] remoteExec ["Gemini_fnc_globalChat", 0];
    };
    
    true
};