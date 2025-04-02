/*
    Fichier: fnc_territoryExit.sqf
    Description: Gestion de la sortie d'un joueur d'un territoire
*/

// Fonction principale pour gérer la sortie d'un joueur d'un territoire
Gemini_fnc_handleTerritoryExit = {
    params [["_player", objNull, [objNull]]];
    
    // Vérification
    if (isNull _player) exitWith {
        diag_log "[TERRITOIRE][SORTIE] Erreur: Joueur nul";
        false
    };
    
    // Récupérer les informations du territoire que le joueur quitte
    private _lastTerritory = _player getVariable ["lastVisitedTerritory", ""];
    private _wasAuthorized = _player getVariable ["territoryAuthorized", false];
    private _wasState = _player getVariable ["territoryState", ""];
    
    // Si pas de territoire précédent, sortir
    if (_lastTerritory == "") exitWith {
        diag_log format ["[TERRITOIRE][SORTIE] Joueur %1 n'avait pas de territoire précédent", name _player];
        false
    };
    
    diag_log format ["[TERRITOIRE][SORTIE] Joueur %1 quitte le territoire %2", name _player, _lastTerritory];
    
    // Envoyer les notifications
    [_player, _lastTerritory, _wasAuthorized, _wasState] call Gemini_fnc_territoryExitNotification;
    
    // Trouver l'index du territoire quitté
    private _territoryLeftIndex = -1;
    {
        if ((_x select 0) == _lastTerritory) exitWith {
            _territoryLeftIndex = _forEachIndex;
        };
    } forEach OPEX_territories;
    
    // Gestion du chef de village pour territoires neutres/amis
    if (_territoryLeftIndex != -1 && (_wasState == "neutral" || _wasState == "friendly")) then {
        [_player, _territoryLeftIndex] call Gemini_fnc_handleChiefOnExit;
    };
    
    // Supprimer les actions de communication radio
    if (OPEX_ace_enabled) then {
        [_player] remoteExec ["Gemini_fnc_removeAllRadioActions", _player];
    } else {
        private _actionID = _player getVariable ["OPEX_radioActionID", -1];
        if (_actionID != -1) then {
            _player removeAction _actionID;
            _player setVariable ["OPEX_radioActionID", -1, true];
        };
    };
    
    // Réinitialiser les variables du joueur
    _player setVariable ["lastVisitedTerritory", "", true];
    _player setVariable ["territoryWarningReceived", false, true];
    _player setVariable ["territoryAuthorized", false, true];
    _player setVariable ["territoryPenalized", false, true];
    _player setVariable ["territoryState", "", true];
    
    true
};

// Fonction pour gérer le chef lors de la sortie d'un territoire
Gemini_fnc_handleChiefOnExit = {
    params [
        ["_player", objNull, [objNull]],
        ["_territoryIndex", -1, [0]]
    ];
    
    // Vérifier s'il y a d'autres joueurs dans ce territoire
    private _territoryData = OPEX_territories select _territoryIndex;
    private _territoryPos = _territoryData select 1;
    private _territoryRadius = _territoryData select 2;
    private _territoryName = _territoryData select 0;
    private _chief = _territoryData select 5;
    private _otherPlayersInTerritory = false;
    
    // Vérifier pour chaque joueur s'il est dans le territoire
    {
        if (_x != _player) then {
            private _otherPlayerPos = getPosATL _x;
            if (([_otherPlayerPos select 0, _otherPlayerPos select 1, 0] distance2D [_territoryPos select 0, _territoryPos select 1, 0]) < _territoryRadius) then {
                _otherPlayersInTerritory = true;
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
    };
};