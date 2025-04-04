/*
    Fichier: fnc_territoryExit.sqf
    Description: Gestion de la sortie d'un joueur d'un territoire
    Version: 2.0 (Corrigée)
*/

// Fonction principale pour gérer la sortie d'un joueur d'un territoire
Gemini_fnc_handleTerritoryExit = {
    params [["_player", objNull, [objNull]]];
    
    diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Début handleTerritoryExit pour joueur %1", name _player];
    
    // Vérification
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][SORTIE] Erreur: Joueur nul";
        false
    };
    
    // Récupérer les informations du territoire que le joueur quitte
    private _lastTerritory = _player getVariable ["lastVisitedTerritory", ""];
    private _wasAuthorized = _player getVariable ["territoryAuthorized", false];
    private _wasState = _player getVariable ["territoryState", ""];
    
    diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Informations territoire quitté: %1 (état: %2, autorisé: %3)", 
        _lastTerritory, _wasState, _wasAuthorized];
    
    // Si pas de territoire précédent, sortir
    if (_lastTerritory == "") exitWith {
        diag_log format ["[TERRITOIRE][SORTIE] Joueur %1 n'avait pas de territoire précédent", name _player];
        false
    };
    
    diag_log format ["[TERRITOIRE][SORTIE] Joueur %1 quitte le territoire %2", name _player, _lastTerritory];
    
    // Envoyer les notifications
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Avant appel à territoryExitNotification";
    [_player, _lastTerritory, _wasAuthorized, _wasState] call Gemini_fnc_territoryExitNotification;
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Après appel à territoryExitNotification";
    
    // Trouver l'index du territoire quitté
    private _territoryLeftIndex = -1;
    {
        if ((_x select 0) == _lastTerritory) exitWith {
            _territoryLeftIndex = _forEachIndex;
        };
    } forEach OPEX_territories;
    
    diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Index du territoire quitté: %1", _territoryLeftIndex];
    
    // Gestion du chef de village pour territoires neutres/amis
    if (_territoryLeftIndex != -1 && (_wasState == "neutral" || _wasState == "friendly")) then {
        diag_log "[TERRITOIRE][DEBUG-SORTIE] Avant appel à handleChiefOnExit";
        [_player, _territoryLeftIndex] call Gemini_fnc_handleChiefOnExit;
        diag_log "[TERRITOIRE][DEBUG-SORTIE] Après appel à handleChiefOnExit";
    };
    
    // Supprimer les actions de communication radio
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Suppression des actions radio";
    if (OPEX_ace_enabled) then {
        diag_log "[TERRITOIRE][DEBUG-SORTIE] ACE détecté, utilisation de removeAllRadioActions";
        [_player] remoteExec ["Gemini_fnc_removeAllRadioActions", _player];
    } else {
        diag_log "[TERRITOIRE][DEBUG-SORTIE] ACE non détecté, suppression action standard";
        private _actionID = _player getVariable ["OPEX_radioActionID", -1];
        if (_actionID != -1) then {
            _player removeAction _actionID;
            _player setVariable ["OPEX_radioActionID", -1, true];
        };
    };
    
    // Réinitialiser les variables du joueur
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Réinitialisation des variables du joueur";
    _player setVariable ["lastVisitedTerritory", "", true];
    _player setVariable ["territoryWarningReceived", false, true];
    _player setVariable ["territoryAuthorized", false, true];
    _player setVariable ["territoryPenalized", false, true];
    _player setVariable ["territoryState", "", true];
    
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Fin handleTerritoryExit";
    true
};

// Fonction pour gérer le chef lors de la sortie d'un territoire
Gemini_fnc_handleChiefOnExit = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Début handleChiefOnExit pour joueur %1, index %2", name _player, _territoryIndex];
    
    // Vérifier s'il y a d'autres joueurs dans ce territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryPos = _territoryData select 1;
    private _territoryRadius = _territoryData select 2;
    private _territoryName = _territoryData select 0;
    private _chief = _territoryData select 5;
    private _otherPlayersInTerritory = false;
    
    diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Vérification autres joueurs dans %1", _territoryName];
    
    // Vérifier pour chaque joueur s'il est dans le territoire
    {
        if (_x != _player) then {
            private _otherPlayerPos = getPosATL _x;
            if (([_otherPlayerPos select 0, _otherPlayerPos select 1, 0] distance2D [_territoryPos select 0, _territoryPos select 1, 0]) < _territoryRadius) then {
                _otherPlayersInTerritory = true;
                diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Autre joueur présent: %1", name _x];
            };
        };
    } forEach allPlayers;
    
    // Si aucun autre joueur n'est présent et qu'un chef existe, le supprimer
    if (!_otherPlayersInTerritory && !isNull _chief) then {
        diag_log format ["[TERRITOIRE][SORTIE] Suppression du chef de %1, plus aucun joueur présent", _territoryName];
        deleteVehicle _chief;
        _territoryData set [5, objNull];
        OPEX_territories set [_territoryIndex, _territoryData];
        publicVariable "OPEX_territories";
    } else {
        diag_log format ["[TERRITOIRE][DEBUG-SORTIE] Chef maintenu pour %1 (autres joueurs présents: %2, chef existant: %3)", 
            _territoryName, _otherPlayersInTerritory, !isNull _chief];
    };  // Point-virgule ajouté ici pour corriger l'erreur
    
    diag_log "[TERRITOIRE][DEBUG-SORTIE] Fin handleChiefOnExit";
};