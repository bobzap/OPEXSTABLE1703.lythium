/*
    Fichier: fnc_territoryChiefs.sqf
    Description: Fonctions pour la gestion des chefs de village dans le système territorial
*/

// FONCTION: Spawn d'un chef de village
Gemini_fnc_spawnVillageChief = {
    params ["_territoryIndex"];
    
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
    
    // Créer le groupe pour le chef
    private _group = createGroup civilian;
    
    // Choisir apparence adaptée à la région
    private _unitType = selectRandom OPEX_civilian_units;
    
    // Trouver un bâtiment adapté
    private _buildings = nearestObjects [_position, ["House"], 150];
    private _building = selectRandom (_buildings select {count (_x buildingPos -1) > 0});
    private _bPos = _position;
    
    if (!isNil "_building") then {
        _bPos = selectRandom (_building buildingPos -1);
    } else {
        // Pas de bâtiment approprié, utiliser la position du territoire
        diag_log format ["[TERRITOIRE] Aucun bâtiment approprié trouvé pour le chef du territoire: %1", _name];
    };
    
    // Créer le chef
    private _chief = _group createUnit [_unitType, _bPos, [], 0, "NONE"];
    _chief setVariable ["isVillageChief", true, true];
    _chief setVariable ["territoryIndex", _territoryIndex, true];
    
    // Définir comportement
    _chief disableAI "PATH";
    if (!isNil "BIS_fnc_ambientAnim") then {
        [_chief, "SIT_U1"] call BIS_fnc_ambientAnim;
    };
    
    // Ajouter action d'interaction
    [_chief] call Gemini_fnc_addChiefInteraction;
    
    // Ajouter l'eventHandler de mort
    _chief addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer"];
        [_unit, _killer] call Gemini_fnc_handleChiefDeath;
    }];
    
    // Stocker dans les données de territoire
    _territoryData set [5, _chief];
    OPEX_territories set [_territoryIndex, _territoryData];
    publicVariable "OPEX_territories";
    
    // Créer un marqueur spécial pour le chef
    private _chiefMarker = createMarker [format ["territory_chief_%1", _name], getPos _chief];
    _chiefMarker setMarkerType "mil_triangle";
    _chiefMarker setMarkerColor "ColorYellow";
    _chiefMarker setMarkerText format ["%1 - Chef", _name];
    _chiefMarker setMarkerSize [0.6, 0.6];
    
    diag_log format ["[TERRITOIRE] Chef créé: %1", _chief];
    
    _chief
};
// FONCTION: Ajouter l'interaction au chef de village
Gemini_fnc_addChiefInteraction = {
    params ["_chief"];
    
    if (isNull _chief) exitWith {
        diag_log "[TERRITOIRE] Erreur: Chef nul pour l'ajout d'interaction";
    };
    
    // Action principale pour parler au chef
    _chief addAction [
        "<t color='#FFFF00'>Parler au chef de village</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            private _territoryIndex = _target getVariable ["territoryIndex", -1];
            
            if (_territoryIndex == -1) exitWith {hint "Erreur: Chef non lié à un territoire"};
            
            // Ouvrir le dialogue du chef (version simple pour le test)
            [_target, _caller, _territoryIndex] call Gemini_fnc_openChiefDialog;
        },
        nil,
        6,
        true,
        true,
        "",
        "alive _target && _target distance _this < 3"
    ];
    
    diag_log format ["[TERRITOIRE] Interaction ajoutée au chef: %1", _chief];
};

// FONCTION: Ouvrir le dialogue avec le chef
Gemini_fnc_openChiefDialog = {
    params ["_chief", "_player", "_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _state = _territoryData select 3;
    private _securityLevel = _territoryData select 4;
    
    // Marquer le chef comme contacté
    _territoryData set [6, true];
    OPEX_territories set [_territoryIndex, _territoryData];
    publicVariable "OPEX_territories";
    
    // Obtenir la réputation globale
    private _reputation = OPEX_stats_faction select 18;
    
    // Dialogue basé sur l'état du territoire
    private _text = "";
    
    switch (_state) do {
        case "enemy": {
            if (_reputation < 0.5) then {
                _text = "Je n'ai rien à vous dire. Partez d'ici!";
            } else {
                _text = "Nous avons peur des insurgés. Aidez-nous à libérer notre village!";
                // Proposer une mission de libération
                if (!OPEX_assignedTask) then {
                    private _acceptLib = [
                        "Accepter la mission de libération ?",
                        "Demande d'aide",
                        "Oui",
                        "Non"
                    ] call BIS_fnc_guiMessage;
                    
                    if (_acceptLib) then {
                        [_territoryIndex] call Gemini_fnc_offerLiberationMission;
                    };
                } else {
                    _text = _text + " (Terminez d'abord votre mission actuelle)";
                };
            };
        };
        case "neutral": {
            _text = format ["Notre village est relativement calme, mais nous avons besoin d'aide pour rester en sécurité. Niveau de sécurité actuel: %1%%", _securityLevel];
            // Proposer une mission de stabilisation
            if (!OPEX_assignedTask) then {
                private _acceptStab = [
                    "Accepter la mission de stabilisation ?",
                    "Demande d'aide",
                    "Oui",
                    "Non"
                ] call BIS_fnc_guiMessage;
                
                if (_acceptStab) then {
                    [_territoryIndex] call Gemini_fnc_offerStabilizationMission;
                };
            } else {
                _text = _text + " (Terminez d'abord votre mission actuelle)";
            };
        };
        case "friendly": {
            _text = format ["Merci de sécuriser notre village. Nous sommes en sécurité à %1%%.", _securityLevel];
            if (_securityLevel < 75) then {
                _text = _text + " Mais nous avons besoin de plus de sécurité.";
                // Proposer une mission de sécurisation
                if (!OPEX_assignedTask) then {
                    private _acceptSec = [
                        "Accepter la mission de sécurisation ?",
                        "Demande d'aide",
                        "Oui",
                        "Non"
                    ] call BIS_fnc_guiMessage;
                    
                    if (_acceptSec) then {
                        [_territoryIndex] call Gemini_fnc_offerSecurityMission;
                    };
                } else {
                    _text = _text + " (Terminez d'abord votre mission actuelle)";
                };
            } else {
                _text = _text + " Nos habitants vous sont reconnaissants.";
                // Proposer une mission avancée
                if (!OPEX_assignedTask) then {
                    private _acceptAdv = [
                        "Accepter une mission spéciale ?",
                        "Demande d'aide",
                        "Oui",
                        "Non"
                    ] call BIS_fnc_guiMessage;
                    
                    if (_acceptAdv) then {
                        [_territoryIndex] call Gemini_fnc_offerAdvancedMission;
                    };
                } else {
                    _text = _text + " (Terminez d'abord votre mission actuelle)";
                };
            };
        };
    };
    
    // Afficher le dialogue
    hint _text;
};

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
        [_territoryIndex] spawn Gemini_fnc_spawnTerritoryAttackers;
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
            [_idx] call Gemini_fnc_spawnVillageChief;
            
            // Notification
            ["globalChat", format ["Un nouveau chef a pris ses fonctions à %1.", _currentData select 0]] remoteExec ["Gemini_fnc_globalChat", 0];
        };
    };
};