/*
    Fichier: fnc_radioMissions.sqf
    Description: Interface entre le système de communication radio et le gestionnaire de missions
    
    Ce fichier gère la connexion entre les communications radio et le système de missions territoriales,
    permettant de proposer et d'accepter des missions via la radio.
*/

// Fonction pour proposer une mission via radio
Gemini_fnc_offerMissionViaRadio = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifications de base
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Joueur nul pour offre de mission";
        false
    };
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _territoryState = _territoryData select 3;
    
    diag_log format ["[TERRITOIRE][RADIO] Offre de mission pour %1 dans territoire %2 (%3)", name _player, _territoryName, _territoryState];
    
    // Définir le type de mission selon l'état du territoire
    private _missionType = "none";
    private _missionDesc = "";
    
    switch (_territoryState) do {
        case "enemy": {
            // Pour territoires hostiles, missions de combat
            _missionType = selectRandom ["clear", "cache", "rescue"];
            
            _missionDesc = switch (_missionType) do {
                case "clear": {"élimination des forces hostiles"};
                case "cache": {"destruction d'une cache d'armes"};
                case "rescue": {"sauvetage d'un chef de village"};
                default {"reconnaissance"};
            };
        };
        
        case "neutral": {
            // Pour territoires neutres, missions de stabilisation
            _missionType = "stabilize";
            _missionDesc = "établissement d'une présence militaire";
        };
        
        case "friendly": {
            // Pour territoires amis, missions de sécurité ou renseignement
            private _securityLevel = _territoryData select 4;
            
            if (_securityLevel < 75) then {
                _missionType = "secure";
                _missionDesc = "renforcement de la sécurité";
            } else {
                _missionType = "intel";
                _missionDesc = "collecte de renseignements";
            };
        };
        
        default {
            _missionType = "none";
            _missionDesc = "reconnaissance";
        };
    };
    
    // Si aucune mission disponible, sortir
    if (_missionType == "none") exitWith {
        [_player, "QG", "[Vous]", "Pas de mission disponible dans ce secteur pour le moment. Terminé."] call Gemini_fnc_territoryGlobalChat;
        false
    };
    
    // Offrir la mission via message radio
    [_player, "QG", "[Vous]", format ["Patrouille, nous avons une mission de %1 dans le secteur %2. Acceptez-vous cette mission? Terminé.", _missionDesc, _territoryName]] call Gemini_fnc_territoryGlobalChat;
    
    // Ajouter l'action d'acceptation
    [_player, _territoryIndex, _missionType] call Gemini_fnc_addMissionAcceptAction;
    
    true
};

// Fonction pour accepter une mission via radio
Gemini_fnc_acceptMissionViaRadio = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_missionType", "", [""]]
    ];
    
    // Vérifications
    if (isNull _player || _territoryIndex < 0 || _missionType == "") exitWith {false};
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][RADIO] Acceptation mission %1 pour territoire %2", _missionType, _territoryName];
    
    // Confirmation d'acceptation
    [_player, "[Vous]", "QG", "Mission acceptée. Nous procédons immédiatement. Terminé."] call Gemini_fnc_territoryGlobalChat;
    
    sleep 2;
    
    // Confirmation du QG
    [_player, "QG", "[Vous]", "Bien reçu. Les détails de mission sont envoyés à votre carte. Bonne chance. Terminé."] call Gemini_fnc_territoryGlobalChat;
    
    // Supprimer l'action d'acceptation
    if (OPEX_ace_enabled) then {
        // Supprimer l'action ACE
        private _missionActions = _player getVariable ["OPEX_mission_actionIDs", []];
        private _newActionsList = [];
        
        {
            _x params ["_storedTerrIndex", "_storedMissionType", "_actionID"];
            if (_storedTerrIndex == _territoryIndex && _storedMissionType == _missionType) then {
                [_player, 1, ["ACE_SelfActions", format ["AcceptMission_%1_%2", _territoryIndex, _missionType]]] call ace_interact_menu_fnc_removeActionFromObject;
            } else {
                _newActionsList pushBack _x;
            };
        } forEach _missionActions;
        
        _player setVariable ["OPEX_mission_actionIDs", _newActionsList, true];
    } else {
        // Supprimer l'action standard
        private _actionID = _player getVariable [format ["OPEX_missionAction_%1_%2", _territoryIndex, _missionType], -1];
        if (_actionID != -1) then {
            _player removeAction _actionID;
            _player setVariable [format ["OPEX_missionAction_%1_%2", _territoryIndex, _missionType], -1, true];
        };
    };
    
    // Lancer la mission
    [_territoryIndex, _missionType] remoteExec ["Gemini_fnc_territoryMissionManager", 2];
    
    true
};

// Fonction pour faire un rapport de mission terminée
Gemini_fnc_reportMissionCompletion = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_success", true, [true]]
    ];
    
    // Vérifications
    if (isNull _player || _territoryIndex < 0) exitWith {false};
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][RADIO] Rapport de mission pour territoire %1 (succès: %2)", _territoryName, _success];
    
    // Message du joueur
    if (_success) then {
        [_player, "[Vous]", "QG", format ["PC, ici patrouille. Mission dans secteur %1 accomplie. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
        
        sleep 2;
        
        // Réponse positive du QG
        [_player, "QG", "[Vous]", format ["Patrouille, bien reçu. Félicitations pour le succès de la mission à %1. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
    } else {
        [_player, "[Vous]", "QG", format ["PC, ici patrouille. Échec de la mission dans secteur %1. Nous nous retirons. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
        
        sleep 2;
        
        // Réponse du QG
        [_player, "QG", "[Vous]", format ["Patrouille, compris. Revenez à la base pour débriefing. Nous réévaluerons la situation à %1. Terminé.", _territoryName]] call Gemini_fnc_territoryGlobalChat;
    };
    
    true
};

// Fonction pour demander du soutien
Gemini_fnc_requestSupport = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_supportType", "", [""]]
    ];
    
    // Vérifications
    if (isNull _player || _territoryIndex < 0 || _supportType == "") exitWith {false};
    
    // Récupérer les données du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    // Types de soutien disponibles
    private _availableTypes = ["transport", "airstrike", "artillery", "supplies", "reinforcement"];
    
    // Vérifier si le type demandé est valide
    if !(_supportType in _availableTypes) exitWith {
        hint "Type de soutien non reconnu";
        false
    };
    
    diag_log format ["[TERRITOIRE][RADIO] Demande de soutien %1 pour territoire %2", _supportType, _territoryName];
    
    // Message du joueur
    private _supportName = switch (_supportType) do {
        case "transport": {"transport"};
        case "airstrike": {"frappe aérienne"};
        case "artillery": {"soutien d'artillerie"};
        case "supplies": {"ravitaillement"};
        case "reinforcement": {"renforts"};
        default {"assistance"};
    };
    
    [_player, "[Vous]", "QG", format ["PC, ici patrouille dans secteur %1. Demande de %2 urgente. Terminé.", _territoryName, _supportName]] call Gemini_fnc_territoryGlobalChat;
    
    sleep 2;
    
    // Vérification disponibilité (selon configuration)
    private _supportAvailable = switch (_supportType) do {
        case "transport": {missionNamespace getVariable ["OPEX_support_transport", false]};
        case "airstrike": {missionNamespace getVariable ["OPEX_support_airStrike", false]};
        case "artillery": {missionNamespace getVariable ["OPEX_support_artilleryStrike", false]};
        case "supplies": {missionNamespace getVariable ["OPEX_support_suppliesDrop", false]};
        case "reinforcement": {missionNamespace getVariable ["OPEX_support_landAssistance", false]};
        default {false};
    };
    
    // Réponse selon disponibilité
    if (_supportAvailable) then {
        [_player, "QG", "[Vous]", format ["Patrouille, demande de %1 approuvée. En route vers votre position. ETA 2 minutes. Terminé.", _supportName]] call Gemini_fnc_territoryGlobalChat;
        
        // Lancer la fonction appropriée de soutien (remoteExec sur le serveur)
        // Cette partie dépend des fonctions existantes dans votre framework
        private _supportFunction = switch (_supportType) do {
            case "transport": {"Gemini_fnc_callTransport"};
            case "airstrike": {"Gemini_fnc_callAirStrike"};
            case "artillery": {"Gemini_fnc_callArtilleryStrike"};
            case "supplies": {"Gemini_fnc_callSuppliesDrop"};
            case "reinforcement": {"Gemini_fnc_callReinforcement"};
            default {""};
        };
        
        if (_supportFunction != "") then {
            [[_player, _territoryIndex], _supportFunction] remoteExec ["spawn", 2];
        };
    } else {
        [_player, "QG", "[Vous]", format ["Patrouille, demande de %1 refusée. Ressources indisponibles actuellement. Terminé.", _supportName]] call Gemini_fnc_territoryGlobalChat;
    };
    
    true
};

// Initialisation au démarrage du script
if (isServer) then {
    diag_log "[TERRITOIRE][RADIO] Module radioMissions initialisé";
};

// Mission simple d'élimination
Gemini_fnc_simpleEliminationMission = {
    params [["_territoryIndex", -1, [0]]];
    
    // Vérifier que nous sommes sur le serveur
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE][MISSION] Tentative de création de mission depuis un client - ignoré";
    };
    
    diag_log format ["[TERRITOIRE][MISSION] Création de mission d'élimination pour territoire %1", _territoryIndex];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    // Créer un objectif de mission
    private _taskID = format ["eliminate_%1", _territoryIndex];
    private _taskDesc = format ["Éliminer l'insurgé armé qui se cache à %1.", _territoryName];
    private _taskTitle = format ["Élimination: %1", _territoryName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [_taskDesc, _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "kill"
    ] call BIS_fnc_taskCreate;
    
    // Trouver une position dans un bâtiment pour l'insurgé
    private _buildings = nearestObjects [_position, ["House"], _radius];
    private _insurgentPos = _position;
    private _foundBuilding = false;
    
    if (count _buildings > 0) then {
        private _building = selectRandom _buildings;
        private _buildingPositions = _building buildingPos -1;
        
        if (count _buildingPositions > 0) then {
            _insurgentPos = selectRandom _buildingPositions;
            _foundBuilding = true;
        };
    };
    
    // Créer l'insurgé
    private _group = createGroup OPEX_enemy_side1;
    private _insurgent = _group createUnit [selectRandom OPEX_enemy_units, _insurgentPos, [], 0, "NONE"];
    
    // Configurer l'insurgé
    _insurgent setUnitPos "UP";
    _insurgent disableAI "PATH";
    if (_foundBuilding) then {
        _insurgent setDir (random 360);
    } else {
        // Trouver une position aléatoire si pas de bâtiment
        _insurgentPos = [_position, 10, _radius * 0.5, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        _insurgent setPos _insurgentPos;
    };
    
    diag_log format ["[TERRITOIRE][MISSION] Insurgé créé à la position %1", getPos _insurgent];
    
    // Ajouter surveillance de mission
    [_taskID, _insurgent] spawn {
        params ["_taskID", "_insurgent"];
        
        // Vérifier que nous sommes sur le serveur
        if (!isServer) exitWith {};
        
        // Attendre que l'insurgé soit mort
        waitUntil {
            sleep 5;
            !alive _insurgent
        };
        
        diag_log format ["[TERRITOIRE][MISSION] Insurgé éliminé, mission %1 terminée", _taskID];
        
        // Mission réussie
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        
        // Récompense
        ["taskSucceeded"] call Gemini_fnc_updateStats;
        ["globalChat", "Insurgé éliminé. Mission accomplie."] remoteExec ["Gemini_fnc_globalChat", 0];
    };
};