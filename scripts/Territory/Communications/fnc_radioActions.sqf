/*
    Fichier: fnc_radioActions.sqf
    Description: Gestion des actions de communication radio pour le système territorial
    
    Ce fichier gère toutes les actions d'interface utilisateur liées aux communications radio,
    incluant les actions ACE et les actions standards.
*/

// Fonction pour initialiser l'action radio pour un joueur et un territoire
Gemini_fnc_initRadioAction = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifications de sécurité
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Joueur nul pour initialisation d'action radio";
        false
    };
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    // Récupérer les informations du territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][RADIO] Initialisation action radio pour %1 dans territoire %2", name _player, _territoryName];
    
    // Vérifier si le joueur est sur la bonne machine
    if (!hasInterface) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative d'ajouter action radio sans interface";
        false
    };
    
    // Créer la fonction appropriée selon que ACE est activé ou non
    if (OPEX_ace_enabled) then {
        // Version ACE
        [_player, _territoryIndex] call Gemini_fnc_addACERadioAction;
    } else {
        // Version standard
        [_player, _territoryIndex] call Gemini_fnc_addStandardRadioAction;
    };
    
    // Envoyer une notification au joueur
    [_player, _territoryName] call Gemini_fnc_radioAvailableNotification;
    
    true
};

// Fonction pour ajouter l'action radio via le système ACE
Gemini_fnc_addACERadioAction = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    if (isNull _player) exitWith {false};
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (_player != ACE_player && _player != player) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative d'ajout d'action ACE sur mauvais client. ACE_player=%1, client=%2", name ACE_player, name _player];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    // Vérifier si le joueur a déjà cette action
    private _existingActions = _player getVariable ["OPEX_radio_actionIDs", []];
    private _actionExists = false;
    
    {
        _x params ["_storedTerrIndex", "_actionID"];
        if (_storedTerrIndex == _territoryIndex) then {
            _actionExists = true;
        };
    } forEach _existingActions;
    
    if (_actionExists) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Action radio ACE déjà existante pour territoire %1", _territoryName];
        true
    };
    
    // Créer l'action ACE
    private _actionID = [
        format ["ContactHQaboutTerritory_%1", _territoryIndex],  // ID unique basé sur territoire
        "Contacter le PC (SITREP Zone)",                        // Texte affiché
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", // Icône
        {
            // Code exécuté quand l'action est activée
            params ["_target", "_player", "_params"];
            _params params ["_territoryIndex"];
            
            diag_log format ["[TERRITOIRE][RADIO] Action ACE exécutée pour territoire %1", _territoryIndex];
            [_player, _territoryIndex] call Gemini_fnc_startRadioDialog;
        },
        {
            // Condition pour que l'action soit disponible
            params ["_target", "_player", "_params"];
            _params params ["_territoryIndex"];
            
            private _state = _player getVariable ["territoryState", ""];
            private _authorized = _player getVariable ["territoryAuthorized", false];
            
            (_state == "unknown" && !_authorized)
        },
        {},  // Code additionnel (non utilisé)
        [_territoryIndex],  // Paramètres passés à l'action
        "",  // Position dans l'espace 3D (non utilisée)
        5,   // Distance d'activation
        [false, false, false, false, false],  // Paramètres visuels
        {}   // Code à exécuter quand l'action est visible
    ] call ace_interact_menu_fnc_createAction;
    
    // Ajouter l'action au menu ACE
    [_player, 1, ["ACE_SelfActions"], _actionID] call ace_interact_menu_fnc_addActionToObject;
    
    // Enregistrer l'ID pour pouvoir le supprimer plus tard
    private _newActionsList = _existingActions + [[_territoryIndex, _actionID]];
    _player setVariable ["OPEX_radio_actionIDs", _newActionsList, true];
    
    diag_log format ["[TERRITOIRE][RADIO] Action ACE ajoutée pour territoire %1", _territoryName];
    true
};

// Fonction pour ajouter l'action radio standard (sans ACE)
Gemini_fnc_addStandardRadioAction = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    if (isNull _player) exitWith {false};
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (_player != player) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative d'ajout d'action standard sur mauvais client. Player=%1, client=%2", name _player, name player];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    // Vérifier si une action existe déjà
    private _existingActionID = _player getVariable ["OPEX_radioAction_" + str(_territoryIndex), -1];
    if (_existingActionID != -1) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Action radio standard déjà existante pour territoire %1", _territoryName];
        true
    };
    
    // Créer l'action
    private _actionID = _player addAction [
        format ["<img image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa'/> Contacter le PC à propos de %1", _territoryName],
        {
            params ["_target", "_caller", "_actionId", "_args"];
            _args params ["_territoryIndex"];
            
            diag_log format ["[TERRITOIRE][RADIO] Action standard exécutée pour territoire %1", _territoryIndex];
            [_caller, _territoryIndex] spawn Gemini_fnc_startRadioDialog;
        },
        [_territoryIndex],
        6,
        true,
        true,
        "",
        "private _state = _this getVariable ['territoryState', '']; private _authorized = _this getVariable ['territoryAuthorized', false]; (_state == 'unknown' && !_authorized)"
    ];
    
    // Enregistrer l'ID
    _player setVariable ["OPEX_radioAction_" + str(_territoryIndex), _actionID, true];
    
    diag_log format ["[TERRITOIRE][RADIO] Action standard ajoutée pour territoire %1", _territoryName];
    true
};

// Fonction pour supprimer toutes les actions radio d'un joueur
Gemini_fnc_removeAllRadioActions = {
    params [["_player", objNull, [objNull]]];
    
    if (isNull _player) exitWith {false};
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (_player != player && (!isNil "ACE_player" && _player != ACE_player)) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative de suppression sur mauvais client. Player=%1, client=%2", name _player, name player];
        false
    };
    
    diag_log format ["[TERRITOIRE][RADIO] Suppression de toutes les actions radio pour %1", name _player];
    
    // Supprimer les actions ACE si disponibles
    if (OPEX_ace_enabled) then {
        private _existingActions = _player getVariable ["OPEX_radio_actionIDs", []];
        
        {
            _x params ["_territoryIndex", "_actionID"];
            [_player, 1, ["ACE_SelfActions", format ["ContactHQaboutTerritory_%1", _territoryIndex]]] call ace_interact_menu_fnc_removeActionFromObject;
            diag_log format ["[TERRITOIRE][RADIO] Action ACE supprimée pour territoire %1", _territoryIndex];
        } forEach _existingActions;
        
        _player setVariable ["OPEX_radio_actionIDs", [], true];
    };
    
    // Supprimer les actions standard
    for "_i" from 0 to (count OPEX_territories - 1) do {
        private _actionVar = "OPEX_radioAction_" + str(_i);
        private _actionID = _player getVariable [_actionVar, -1];
        
        if (_actionID != -1) then {
            _player removeAction _actionID;
            _player setVariable [_actionVar, -1, true];
            diag_log format ["[TERRITOIRE][RADIO] Action standard supprimée pour territoire %1", _i];
        };
    };
    
    true
};

// Fonction pour supprimer une action radio spécifique
Gemini_fnc_removeRadioAction = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    if (isNull _player || _territoryIndex < 0) exitWith {false};
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (_player != player && (!isNil "ACE_player" && _player != ACE_player)) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative de suppression sur mauvais client. Player=%1, client=%2", name _player, name player];
        false
    };
    
    diag_log format ["[TERRITOIRE][RADIO] Suppression action radio pour territoire %1", _territoryIndex];
    
    // Supprimer l'action ACE si disponible
    if (OPEX_ace_enabled) then {
        private _existingActions = _player getVariable ["OPEX_radio_actionIDs", []];
        private _newActionsList = [];
        private _actionRemoved = false;
        
        {
            _x params ["_storedTerrIndex", "_actionID"];
            if (_storedTerrIndex == _territoryIndex) then {
                [_player, 1, ["ACE_SelfActions", format ["ContactHQaboutTerritory_%1", _territoryIndex]]] call ace_interact_menu_fnc_removeActionFromObject;
                _actionRemoved = true;
            } else {
                _newActionsList pushBack _x;
            };
        } forEach _existingActions;
        
        if (_actionRemoved) then {
            _player setVariable ["OPEX_radio_actionIDs", _newActionsList, true];
        };
    };
    
    // Supprimer l'action standard
    private _actionVar = "OPEX_radioAction_" + str(_territoryIndex);
    private _actionID = _player getVariable [_actionVar, -1];
    
    if (_actionID != -1) then {
        _player removeAction _actionID;
        _player setVariable [_actionVar, -1, true];
    };
    
    true
};

// Fonction pour ajouter l'action d'acceptation de mission
Gemini_fnc_addMissionAcceptAction = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]],
        ["_missionType", "", [""]]
    ];
    
    if (isNull _player || _territoryIndex < 0) exitWith {false};
    
    // Vérifier si cette fonction est exécutée sur le bon client
    if (_player != player && (!isNil "ACE_player" && _player != ACE_player)) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Tentative d'ajout sur mauvais client. Player=%1, client=%2", name _player, name player];
        false
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE][RADIO] Ajout action d'acceptation mission %1 pour territoire %2", _missionType, _territoryName];
    
    // Sélectionner le type d'action selon que ACE est activé ou non
    if (OPEX_ace_enabled) then {
        // Version ACE
        private _actionID = [
            format ["AcceptMission_%1_%2", _territoryIndex, _missionType],
            "Accepter mission du PC",
            "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\attack_ca.paa",
            {
                params ["_target", "_player", "_params"];
                _params params ["_territoryIndex", "_missionType"];
                
                // Notification d'acceptation
                systemChat "[Vous] PC, ici patrouille. Mission acceptée. Terminé.";
                
                sleep 2;
                systemChat "[PC] Bien reçu. Mission en cours de préparation. Bonne chance. Terminé.";
                
                // Lancer la mission (côté serveur)
                [_territoryIndex, _missionType] remoteExec ["Gemini_fnc_territoryMissionManager", 2];
                
                // Supprimer l'action après acceptation
                [_player, 1, ["ACE_SelfActions", format ["AcceptMission_%1_%2", _territoryIndex, _missionType]]] call ace_interact_menu_fnc_removeActionFromObject;
            },
            {
                params ["_target", "_player", "_params"];
                _params params ["_territoryIndex"];
                
                // Vérifier si le joueur est autorisé dans ce territoire
                private _state = _player getVariable ["territoryState", ""];
                private _authorized = _player getVariable ["territoryAuthorized", false];
                
                (_state != "unknown" && _authorized)
            },
            {},
            [_territoryIndex, _missionType],
            "",
            5,
            [false, false, false, false, false],
            {}
        ] call ace_interact_menu_fnc_createAction;
        
        [_player, 1, ["ACE_SelfActions"], _actionID] call ace_interact_menu_fnc_addActionToObject;
        
        // Stocker l'ID d'action
        private _missionActions = _player getVariable ["OPEX_mission_actionIDs", []];
        _missionActions pushBack [_territoryIndex, _missionType, _actionID];
        _player setVariable ["OPEX_mission_actionIDs", _missionActions, true];
    } else {
        // Version standard
        private _actionID = _player addAction [
            format ["<img image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\attack_ca.paa'/> Accepter mission dans %1", _territoryName],
            {
                params ["_target", "_caller", "_actionId", "_args"];
                _args params ["_territoryIndex", "_missionType"];
                
                // Notification d'acceptation
                systemChat "[Vous] PC, ici patrouille. Mission acceptée. Terminé.";
                
                sleep 2;
                systemChat "[PC] Bien reçu. Mission en cours de préparation. Bonne chance. Terminé.";
                
                // Lancer la mission (côté serveur)
                [_territoryIndex, _missionType] remoteExec ["Gemini_fnc_territoryMissionManager", 2];
                
                // Supprimer l'action
                _caller removeAction _actionId;
            },
            [_territoryIndex, _missionType],
            6,
            true,
            true,
            "",
            "true"
        ];
        
        // Stocker l'ID pour référence
        _player setVariable [format ["OPEX_missionAction_%1_%2", _territoryIndex, _missionType], _actionID, true];
    };
    
    true
};

// Initialisation au démarrage du script
if (isServer) then {
    diag_log "[TERRITOIRE][RADIO] Module radioActions initialisé";
};