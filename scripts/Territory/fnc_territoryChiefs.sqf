/*
    Fichier: fnc_territoryChiefs.sqf
    Description: Fonctions pour la gestion des chefs de village dans le système territorial
*/

// FONCTION: Spawn d'un chef de village
Gemini_fnc_spawnVillageChief = {
     params ["_territoryIndex"];
    
    // Utiliser une variable globale pour éviter les appels simultanés
    if (missionNamespace getVariable ["OPEX_chief_spawning", false]) exitWith {
        diag_log "[TERRITOIRE] Création de chef déjà en cours - demande ignorée";
        objNull
    };
    
    missionNamespace setVariable ["OPEX_chief_spawning", true, true];
    
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE] Tentative de spawn de chef depuis un client - ignoré";
        missionNamespace setVariable ["OPEX_chief_spawning", false, true];
        objNull
    };
    
    diag_log format ["[TERRITOIRE] Début fonction spawn chef pour index: %1", _territoryIndex];
    
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE] Erreur: Index de territoire invalide: %1", _territoryIndex];
        objNull
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _position = _territoryData select 1;
    private _name = _territoryData select 0;
    
    // Vérifier si un chef existe déjà
    if !(isNull (_territoryData select 5)) exitWith {
        diag_log format ["[TERRITOIRE] Chef déjà existant pour le territoire: %1", _name];
        _territoryData select 5
    };
    
    diag_log format ["[TERRITOIRE] Création d'un chef pour: %1 à position %2", _name, _position];
    
    // Trouver une position sécurisée
    private _safePos = _position;
    private _foundBuildingPos = false;
    private _buildings = nearestObjects [_position, ["House"], 150];
    
    // Essayer de trouver une position dans un bâtiment
    {
        private _buildingPositions = _x buildingPos -1;
        if (count _buildingPositions > 0) then {
            _safePos = selectRandom _buildingPositions;
            _foundBuildingPos = true;
            diag_log format ["[TERRITOIRE] Position de bâtiment trouvée pour chef de %1: %2", _name, _safePos];
            break;
        };
    } forEach _buildings;
    
    // Si pas de bâtiment, trouver une position sécurisée sur le terrain
    if (!_foundBuildingPos) then {
        _safePos = [_position, 0, 50, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        if (count _safePos == 2) then { _safePos pushBack 0; }; // Assurer que Z est défini
        diag_log format ["[TERRITOIRE] Position extérieure trouvée pour chef de %1: %2", _name, _safePos];
    };
    
    // S'assurer que le Z n'est pas négatif
    if ((_safePos select 2) < 0) then {
        _safePos set [2, 0];
        diag_log format ["[TERRITOIRE] Correction de la hauteur Z pour chef de %1", _name];
    };
    
    // CRÉATION DE L'UNITÉ
    private _chief = [
        OPEX_civilian_side1,       // Côté (civil)
        grpNull,                   // Groupe (nouveau)
        OPEX_civilian_units,       // Types d'unités civiles
        _safePos,                  // Position sécurisée
        [0.5, 0.8],                // Niveau de compétence
        true,                      // Désactiver l'hostilité
        "distance"                 // Durée de vie
    ] call Gemini_fnc_createUnit;
    
    // Vérifier si la création a réussi
    if (isNull _chief) exitWith {
        diag_log format ["[TERRITOIRE] ERREUR: Échec de création du chef pour %1", _name];
        objNull
    };
    
    // Sécurité supplémentaire: s'assurer que l'unité n'est pas sous la carte
    if ((getPos _chief select 2) < 0) then {
        _chief setPosASL [_safePos select 0, _safePos select 1, getTerrainHeightASL [_safePos select 0, _safePos select 1] + 0.5];
        diag_log format ["[TERRITOIRE] Position du chef de %1 ajustée pour éviter placement sous la carte", _name];
    };
    
    // Définir les variables spécifiques aux chefs
    _chief setVariable ["isVillageChief", true, true];
    _chief setVariable ["territoryIndex", _territoryIndex, true];
    
    // S'assurer que les variables critiques sont définies correctement
    _chief setVariable ["side", "friendly", true];
    _chief setVariable ["sympathy", 100, true];
    _chief setVariable ["polyglot", true, true];
    _chief setVariable ["gatheredIntel", false, true];
    _chief setVariable ["informer", 100, true];
    
    // Définir comportement selon l'emplacement
    if (_foundBuildingPos) then {
        _chief disableAI "PATH";
        if (!isNil "BIS_fnc_ambientAnim") then {
            [_chief, "SIT_U1"] call BIS_fnc_ambientAnim;
        };
    } else {
        // Animation debout pour les chefs en extérieur
        if (!isNil "BIS_fnc_ambientAnim") then {
            [_chief, "STAND_U1"] call BIS_fnc_ambientAnim;
        };
    };
    
    // Ajouter l'interaction du chef
    [_chief] call Gemini_fnc_addChiefInteraction;
    
    // Ajouter l'eventHandler de mort
    _chief addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer"];
        [_unit, _killer] call Gemini_fnc_handleChiefDeath;
    }];
    
    // IMPORTANT: Mettre à jour les données du territoire IMMÉDIATEMENT
    private _updatedTerritoryData = OPEX_territories select _territoryIndex;
    _updatedTerritoryData set [5, _chief];
    OPEX_territories set [_territoryIndex, _updatedTerritoryData];
    publicVariable "OPEX_territories";
    
    // Stocker les infos descriptives du chef pour les notifications RP
    _chief setVariable ["chiefIndoors", _foundBuildingPos, true];

    // Calculer la direction approximative depuis le centre du territoire
    private _dir = _position getDir (getPos _chief);
    private _dirText = switch (true) do {
        case (_dir < 45 || _dir >= 315): { "au nord" };
        case (_dir >= 45 && _dir < 135): { "à l'est" };
        case (_dir >= 135 && _dir < 225): { "au sud" };
        default { "à l'ouest" };
    };
    _chief setVariable ["chiefDirection", _dirText, true];
    _chief setVariable ["chiefLocation", if (_foundBuildingPos) then { "dans un bâtiment" } else { "en extérieur" }, true];

    // Notifier les joueurs proches de la présence du chef (via le système de notifications)
    private _descMsg = format [
        "Un responsable local serait %1 de %2, %3.",
        _dirText, _name,
        if (_foundBuildingPos) then { "dans un batiment" } else { "en exterieur pres des habitations" }
    ];

    {
        if ((getPosATL _x) distance2D _position < (_territoryData select 2)) then {
            [_x, _descMsg] call Gemini_fnc_territorySystemChat;
        };
    } forEach allPlayers;

    diag_log format ["[TERRITOIRE] Chef créé avec succès pour %1: %2, %3", _name, _dirText, if (_foundBuildingPos) then {"intérieur"} else {"extérieur"}];
    
    missionNamespace setVariable ["OPEX_chief_spawning", false, true];
    _chief
};




// FONCTION: Ajouter l'interaction au chef de village
Gemini_fnc_addChiefInteraction = {
    params ["_chief"];
    
    if (isNull _chief) exitWith {
        diag_log "[TERRITOIRE] Erreur: Chef nul pour l'ajout d'interaction";
    };
    
    // Marquer comme chef de village
    _chief setVariable ["isVillageChief", true, true];
    
    // Action principale pour parler au chef (utilise le dialogue standard des civils)
    _chief addAction [
        "<t color='#FFFF00'>Parler au chef de village</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            // Arrêter l'animation ambiante avant d'ouvrir le dialogue
            [_target, "NONE"] call BIS_fnc_ambientAnim;
            [_target, _caller] execVM "scripts\Gemini\fnc_civilianInteractionsDialog.sqf";
        },
        nil,
        6,
        true,
        false,
        "",
        "alive _target && _target distance _this < 5"
    ];
    
    diag_log format ["[TERRITOIRE] Interaction ajoutée au chef: %1", _chief];
};

// NOTE: Gemini_fnc_openChiefMissionDialog est défini dans fnc_chiefInteractions.sqf

// FONCTION: Gestion de la mort d'un chef de village
Gemini_fnc_handleChiefDeath = {
    params ["_chief", "_killer"];
    
    private _territoryIndex = _chief getVariable ["territoryIndex", -1];
    if (_territoryIndex == -1) exitWith {
        diag_log "[TERRITOIRE] Chef mort non associé à un territoire";
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryName = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE] Chef de %1 est mort", _territoryName];
    
    // Déterminer qui a tué le chef
    private _killerSide = if (!isNull _killer) then {side _killer} else {sideUnknown};
    private _killedByPlayer = (!isNull _killer) && (isPlayer _killer);
    
    // Mise à jour du territoire
    _territoryData set [5, objNull]; // Effacer la référence au chef
    _territoryData set [6, false]; // Réinitialiser "contacté"
    OPEX_territories set [_territoryIndex, _territoryData];
    publicVariable "OPEX_territories";
    
    // Conséquences selon qui a tué le chef
    if (_killerSide == OPEX_friendly_side1) then {
        // Tué par les forces amies - impact négatif
        if (_killedByPlayer) then {
            // Notification
            ["globalChat", format ["Le chef du village %1 a été tué par nos forces!", _territoryName]] remoteExec ["Gemini_fnc_globalChat", 0];
            
            // Pénalité de réputation
            ["civilianKilled"] call Gemini_fnc_updateStats;
            
            // Baisse de sécurité
            private _currentSecurity = _territoryData select 4;
            private _newSecurity = (_currentSecurity - 30) max 0;
            
            // Si la sécurité tombe trop bas, le village devient hostile
            if (_newSecurity < 25) then {
                [_territoryIndex, "enemy", _newSecurity] call Gemini_fnc_updateTerritoryState;
            } else {
                [_territoryIndex, "", _newSecurity] call Gemini_fnc_updateTerritoryState;
            };
            
            // Annuler les missions en cours pour ce territoire
            private _taskIDs = [
                format ["stabilize_%1", _territoryIndex],
                format ["secure_%1_checkpoint", _territoryIndex],
                format ["secure_%1_patrol", _territoryIndex],
                format ["secure_%1_supply", _territoryIndex],
                format ["advanced_%1_intel", _territoryIndex],
                format ["advanced_%1_training", _territoryIndex]
            ];
            
            {
                if ([_x] call BIS_fnc_taskExists) then {
                    [_x, "CANCELED"] call BIS_fnc_taskSetState;
                };
            } forEach _taskIDs;
        };
    } else if (_killerSide == OPEX_enemy_side1) then {
        // Tué par les forces ennemies - village en danger
        ["globalChat", format ["Le chef du village %1 a été assassiné par des insurgés!", _territoryName]] remoteExec ["Gemini_fnc_globalChat", 0];
        
        // Baisse de sécurité
        private _currentSecurity = _territoryData select 4;
        private _newSecurity = (_currentSecurity - 20) max 0;
        [_territoryIndex, "", _newSecurity] call Gemini_fnc_updateTerritoryState;
        
        // Spawner des attaquants ennemis
        [_territoryIndex] spawn Gemini_fnc_territoryAttack ;
    };
    
    // Planifier le spawn d'un nouveau chef après un délai
    [_territoryIndex] spawn {
        params ["_idx"];
        
        // Attendre entre 10 et 20 minutes
        private _respawnTime = 600 + random 600;
        sleep _respawnTime;
        
        // Vérifier si le territoire est toujours non-hostile
        private _currentData = OPEX_territories select _idx;
        private _currentState = _currentData select 3;
        
        if (_currentState == "neutral" || _currentState == "friendly") then {
            // Créer un nouveau chef
            diag_log format ["[TERRITOIRE] Spawn d'un nouveau chef pour %1 après mort", _currentData select 0];
            [_idx] spawn {
    params ["_idx"];
    sleep 0.1;
    [_idx] spawn Gemini_fnc_spawnVillageChief;
};
            
            // Notification
            ["globalChat", format ["Un nouveau chef a pris ses fonctions à %1.", _currentData select 0]] remoteExec ["Gemini_fnc_globalChat", 0];
        };
    };
};