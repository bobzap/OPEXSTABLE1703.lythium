/*
    Fichier: fnc_radioCommunication.sqf
    Description: Système de communication radio avec le PC pour zones inconnues
*/

// Variables globales pour la gestion du statut radio
if (isServer) then {
    OPEX_radioComm_active = false;
    OPEX_radioComm_authorized = [];
    publicVariable "OPEX_radioComm_active";
    publicVariable "OPEX_radioComm_authorized";
};

// Fonction d'initialisation de la communication radio
Gemini_fnc_initiateRadioCommunication = {
    params [["_territoryIndex", -1, [0]], ["_player", objNull, [objNull]]];
    
    diag_log format ["[TERRITOIRE][RADIO] Début fonction initiateRadioCommunication: index=%1, joueur=%2", _territoryIndex, _player];
    
    // Cette fonction doit être exécutée sur le client du joueur concerné
    if (!hasInterface) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative d'exécution sur un serveur headless";
        false
    };
    
    // Si aucun joueur spécifié, utiliser le joueur local
    if (isNull _player) then {
        _player = player;
        diag_log format ["[TERRITOIRE][RADIO] Joueur non spécifié, utilisation du joueur local: %1", name _player];
    };
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (player != _player) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Fonction exécutée sur le mauvais client. Player=%1, Cible=%2", name player, name _player];
        false
    };
    
    // Vérifier l'index du territoire
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][RADIO] Ajout d'action ACE en cours pour le joueur %1, territoire %2", name _player, _territoryName];
    
    // Vérifier si le joueur a déjà l'action pour ce territoire
    private _existingActions = _player getVariable ["OPEX_radio_actionIDs", []];
    
    // Identifier si une action existe déjà pour ce territoire
    private _existingAction = false;
    {
        _x params ["_storedTerrIndex", "_actionID"];
        if (_storedTerrIndex == _territoryIndex) then {
            _existingAction = true;
        };
    } forEach _existingActions;
    
    // Si une action existe déjà pour ce territoire, ne pas en créer une nouvelle
    if (_existingAction) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Action ACE déjà présente pour %1 concernant %2", name _player, _territoryName];
        true
    };
    
    // Créer l'action ACE pour contacter le PC - avec plus de détails de débogage
    private _actionID = [
        format ["ContactHQaboutTerritory_%1", _territoryIndex],  // ID unique basé sur territoire
        "Contacter le PC (SITREP Zone)",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa",
        {
            params ["_target", "_player", "_params"];
            _params params ["_territoryIndex"];
            
            diag_log format ["[TERRITOIRE][RADIO] Action ACE exécutée par %1 pour territoire %2", name _player, _territoryIndex];
            [_player, _territoryIndex] call Gemini_fnc_startRadioSequence;
        },
        {
            params ["_target", "_player", "_params"];
            _params params ["_territoryIndex"];
            
            private _state = _player getVariable ["territoryState", ""];
            private _authorized = _player getVariable ["territoryAuthorized", false];
            
            private _result = (_state == "unknown" && !_authorized);
            // Debug pour la condition
            if (!_result) then {
                diag_log format ["[TERRITOIRE][RADIO] Condition non remplie: state=%1, authorized=%2", _state, _authorized];
            };
            _result
        },
        {},
        [_territoryIndex],
        "",
        5,
        [false, false, false, false, false],
        {}
    ] call ace_interact_menu_fnc_createAction;
    
    // Ajouter au joueur
    [_player, 1, ["ACE_SelfActions"], _actionID] call ace_interact_menu_fnc_addActionToObject;
    
    // Stocker l'ID d'action pour pouvoir la supprimer plus tard
    private _newActionsList = _existingActions + [[_territoryIndex, _actionID]];
    _player setVariable ["OPEX_radio_actionIDs", _newActionsList, true];
    
    // Log le résultat
    diag_log format ["[TERRITOIRE][RADIO] Action ACE ajoutée pour %1 concernant %2", name _player, _territoryName];
    
    // Notifier le joueur visuellement que l'action est disponible
    [
        format ["<t color='#00FF00'>Communication radio disponible</t><br/>Utilisez votre menu d'interaction ACE (par défaut: Windows+T)<br/>pour contacter le PC à propos de %1", _territoryName], 
        0.5, 
        0.4, 
        8, 
        1
    ] remoteExec ["BIS_fnc_dynamicText", _player];
    
    // Retourner vrai
    true
};

// Fonction pour supprimer les actions de communication radio
Gemini_fnc_removeRadioCommunication = {
    params [["_player", objNull, [objNull]], ["_territoryIndex", -1, [0]]];
    
    // Cette fonction doit être exécutée sur le client du joueur concerné
    if (!hasInterface) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative de suppression sur un serveur headless";
        false
    };
    
    // Si aucun joueur spécifié, utiliser le joueur local
    if (isNull _player) then {
        _player = player;
    };
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (player != _player) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Suppression exécutée sur le mauvais client. Player=%1, Cible=%2", name player, name _player];
        false
    };
    
    private _existingActions = _player getVariable ["OPEX_radio_actionIDs", []];
    private _newActionsList = [];
    private _actionsRemoved = false;
    
    // Si on veut supprimer toutes les actions
    if (_territoryIndex == -1) then {
        {
            _x params ["_storedTerrIndex", "_actionID"];
            // Supprimer l'action ACE
            [_player, 1, ["ACE_SelfActions", format ["ContactHQaboutTerritory_%1", _storedTerrIndex]]] call ace_interact_menu_fnc_removeActionFromObject;
            diag_log format ["[TERRITOIRE][RADIO] Action ACE supprimée pour territoire %1", _storedTerrIndex];
            _actionsRemoved = true;
        } forEach _existingActions;
        
        // Vider la liste
        _player setVariable ["OPEX_radio_actionIDs", [], true];
    } else {
        // Supprimer uniquement l'action pour le territoire spécifié
        {
            _x params ["_storedTerrIndex", "_actionID"];
            if (_storedTerrIndex == _territoryIndex) then {
                // Supprimer l'action ACE
                [_player, 1, ["ACE_SelfActions", format ["ContactHQaboutTerritory_%1", _storedTerrIndex]]] call ace_interact_menu_fnc_removeActionFromObject;
                diag_log format ["[TERRITOIRE][RADIO] Action ACE supprimée pour territoire %1", _storedTerrIndex];
                _actionsRemoved = true;
            } else {
                // Conserver les autres actions
                _newActionsList pushBack _x;
            };
        } forEach _existingActions;
        
        // Mettre à jour la liste des actions
        _player setVariable ["OPEX_radio_actionIDs", _newActionsList, true];
    };
    
    _actionsRemoved
};

// Séquence de dialogue radio
Gemini_fnc_startRadioSequence = {
    params ["_player", "_territoryIndex"];
    
    // Vérifier si nous sommes sur l'interface client
    if (!hasInterface) exitWith {};
    
    // Utiliser ACE_player si disponible, sinon player
    private _localPlayer = if (!isNil "ACE_player") then {ACE_player} else {player};
    
    // Si le joueur n'est pas le joueur local, sortir
    if (_player != _localPlayer) exitWith {};
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    private _actualState = _territoryData select 3;
    
    // Mise à jour des variables uniquement si côté serveur
    if (isServer) then {
        OPEX_radioComm_active = true;
        publicVariable "OPEX_radioComm_active";
    } else {
        // Demander au serveur de mettre à jour la variable
        ["OPEX_radioComm_active", true] remoteExec ["publicVariable", 2];
    };
    
    // Message initial (visible uniquement pour le joueur local)
    systemChat format ["[Vous] PC, ici patrouille. Demande SITREP sur zone: %1. Terminé.", _territoryName];
    
    // Réponse du PC après délai (visible pour tous)
    [_player, _territoryIndex, _territoryName, _actualState] spawn {
        params ["_player", "_territoryIndex", "_territoryName", "_actualState"];
        
        // Vérifier uniquement si nous sommes sur le client qui a initié l'action
        if (!hasInterface) exitWith {};
        private _localPlayer = if (!isNil "ACE_player") then {ACE_player} else {player};
        if (_player != _localPlayer) exitWith {};
        
        sleep 3;
        systemChat format ["[PC] Patrouille, ici PC. Bien reçu, nous analysons la zone: %1. Attente sur votre position. Terminé.", _territoryName];
        
        // Délai d'analyse (5-10 secondes)
        private _analyzeTime = 5 + (random 5);
        sleep _analyzeTime;
        
        // Réponse selon l'état réel du territoire
        private _response = switch (_actualState) do {
            case "enemy": {
                format ["[PC] Patrouille, ici PC. Secteur %1 est HOSTILE. Présence ennemie confirmée. Procédez avec extrême prudence. Terminé.", _territoryName]
            };
            case "neutral": {
                format ["[PC] Patrouille, ici PC. Secteur %1 est NEUTRE. Population coopérative, mais restez vigilants. Terminé.", _territoryName]
            };
            case "friendly": {
                format ["[PC] Patrouille, ici PC. Secteur %1 est AMI. Zone sous contrôle des forces alliées. Terminé.", _territoryName]
            };
            default {
                format ["[PC] Patrouille, ici PC. Données indisponibles sur secteur %1. Restez sur votre position, nous envoyons du renfort pour évaluation. Terminé.", _territoryName]
            };
        };
        
        systemChat _response;
        
        // Mise à jour du territoire (exécutée sur le serveur)
        if (_actualState != "unknown") then {
            // Réinitialiser la notification si le joueur revient plus tard
            _player setVariable ["territoryWarningReceived", false, true];
            
            // Marquer le territoire comme autorisé
            _player setVariable ["territoryAuthorized", true, true];
            
            // Suppression de l'action radio pour ce territoire
            [_player, _territoryIndex] remoteExec ["Gemini_fnc_removeRadioCommunication", _player];
            
            // Révéler l'état réel du territoire (exécuté sur le serveur)
            [_territoryIndex, _actualState, -1] remoteExec ["Gemini_fnc_updateTerritoryState", 2];
            
            // Ajouter à la liste des territoires autorisés (exécuté sur le serveur)
            if (isServer) then {
                OPEX_radioComm_authorized pushBackUnique _territoryIndex;
                publicVariable "OPEX_radioComm_authorized";
            } else {
                [_territoryIndex] remoteExec ["Gemini_fnc_addToAuthorizedTerritories", 2];
            };
            
            // Proposer une mission si territoire hostile
            if (_actualState == "enemy") then {
                sleep 3;
                systemChat format ["[PC] Patrouille, ici PC. Nous avons une mission pour vous dans ce secteur. Souhaitez-vous l'accepter? Terminé."];
                
                // Ajouter l'action ACE pour accepter la mission
                private _acceptMissionAction = [
                    format ["AcceptEnemyMission_%1", _territoryIndex],
                    "Accepter mission du PC",
                    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\attack_ca.paa",
                    {
                        params ["_target", "_player", "_params"];
                        _params params ["_territoryIndex"];
                        
                        systemChat "[Vous] PC, ici patrouille. Mission acceptée. Terminé.";
                        
                        sleep 2;
                        systemChat "[PC] Bien reçu. Nous proposons l'élimination d'un insurgé armé qui se cache dans le secteur. Bonne chance. Terminé.";
                        
                        // Lancer la mission simple de test (exécuté sur le serveur)
                        [_territoryIndex] remoteExec ["Gemini_fnc_simpleEliminationMission", 2];
                        
                        // Supprimer l'action après acceptation
                        [_player, 1, ["ACE_SelfActions", format ["AcceptEnemyMission_%1", _territoryIndex]]] call ace_interact_menu_fnc_removeActionFromObject;
                    },
                    {
                        params ["_target", "_player", "_params"];
                        _params params ["_territoryIndex"];
                        
                        (_player getVariable ["territoryState", ""]) == "enemy" && 
                        (_player getVariable ["territoryAuthorized", false])
                    },
                    {},
                    [_territoryIndex],
                    "",
                    5,
                    [false, false, false, false, false],
                    {}
                ] call ace_interact_menu_fnc_createAction;
                
                private _localPlayer = if (!isNil "ACE_player") then {ACE_player} else {player};
                [_localPlayer, 1, ["ACE_SelfActions"], _acceptMissionAction] call ace_interact_menu_fnc_addActionToObject;
                
                // Stocker l'ID d'action pour pouvoir la supprimer plus tard
                private _missionActions = _player getVariable ["OPEX_mission_actionIDs", []];
                _missionActions pushBack [_territoryIndex, _acceptMissionAction];
                _player setVariable ["OPEX_mission_actionIDs", _missionActions, true];
            };
        };
        
        // Fin de la communication radio (exécuté sur le serveur)
        if (isServer) then {
            OPEX_radioComm_active = false;
            publicVariable "OPEX_radioComm_active";
        } else {
            ["OPEX_radioComm_active", false] remoteExec ["publicVariable", 2];
        };
    };
};

// Fonction utilitaire pour ajouter un territoire aux autorisés (exécutée sur le serveur)
Gemini_fnc_addToAuthorizedTerritories = {
    params ["_territoryIndex"];
    
    if (!isServer) exitWith {};
    
    OPEX_radioComm_authorized pushBackUnique _territoryIndex;
    publicVariable "OPEX_radioComm_authorized";
};

// Mission simple d'élimination (pour les tests)
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