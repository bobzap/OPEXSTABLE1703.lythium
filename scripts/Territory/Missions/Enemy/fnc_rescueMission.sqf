/*
    Fichier: fnc_rescueMission.sqf
    Description: Mission de sauvetage du chef de village
*/

Gemini_fnc_rescueMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    // Créer la tâche
    private _taskID = format ["rescue_%1", _territoryIndex];
    private _taskDesc = format ["Le chef du village %1 est détenu par les forces ennemies. Localisez-le et libérez-le.", _locationName];
    private _taskTitle = format ["Sauvetage: Chef de %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [_taskDesc, _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "help"
    ] call BIS_fnc_taskCreate;
    
    // Trouver position pour la détention
    private _buildingPos = [_position, 20, _radius * 0.7, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    
    // Créer le chef captif
    private _group = createGroup civilian;
    private _chief = _group createUnit [selectRandom OPEX_civilian_units, _buildingPos, [], 0, "NONE"];
    _chief setCaptive true;
    _chief setVariable ["isRescueTarget", true, true];
    _chief setVariable ["territoryIndex", _territoryIndex, true];
    removeAllWeapons _chief;
    _chief disableAI "MOVE";
    
    // Animation de prisonnier
    [_chief, "Acts_AidlPsitMstpSsurWnonDnon01"] remoteExec ["switchMove", 0, _chief];
    
    // Ajouter des gardes
    [OPEX_enemy_side1, ["infantry"], [2, 4], _buildingPos, [5, 15], "guard", _buildingPos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
    
    // Ajouter action de libération
    [
        _chief,
        "Libérer le chef",
        {
            params ["_target", "_caller", "_actionId", "_args"];
            private _territoryIndex = _target getVariable "territoryIndex";
            private _taskID = format ["rescue_%1", _territoryIndex];
            
            // Libérer le captif
            _target setCaptive false;
            _target enableAI "MOVE";
            [_target, ""] remoteExec ["switchMove", 0, _target];
            
            // Marquer la tâche comme réussie
            [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
            
            // Augmenter sécurité et réputation
            private _territoryData = OPEX_territories select _territoryIndex;
            private _newSecurity = ((_territoryData select 4) + 35) min 100;
            [_territoryIndex, "neutral", _newSecurity] call Gemini_fnc_updateTerritoryState;
            
            // Stocker le chef dans les données du territoire
            _territoryData set [5, _target];
            _territoryData set [6, true]; // Chef contacté
            OPEX_territories set [_territoryIndex, _territoryData];
            publicVariable "OPEX_territories";
            
            // Ajouter l'interaction avec le chef
            [_target] call Gemini_fnc_addChiefInteraction;
            
            ["taskSucceeded"] call Gemini_fnc_updateStats;
            ["globalChat", format ["Chef libéré: %1 est maintenant sécurisée à %2%%", _territoryData select 0, _newSecurity]] remoteExec ["Gemini_fnc_globalChat", 0];
        },
        nil,
        6,
        true,
        true,
        "",
        "alive _target && _this distance _target < 3"
    ] remoteExec ["addAction", 0, _chief];
    
    // Indice sur la position
    private _markerPos = [_buildingPos, 50] call BIS_fnc_randomPos;
    private _marker = createMarker [format ["rescue_hint_%1", _territoryIndex], _markerPos];
    _marker setMarkerType "hd_unknown";
    _marker setMarkerColor "ColorBlue";
    _marker setMarkerText "Information sur le chef";
    _marker setMarkerSize [0.6, 0.6];
    
    // Surveillance de la mission
    [_taskID, _territoryIndex, _chief, _marker] spawn {
        params ["_taskID", "_territoryIndex", "_chief", "_marker"];
        
        waitUntil {
            sleep 5;
            (isNull _chief) || (!(_chief getVariable ["isRescueTarget", false]))
        };
        
        // Vérifier si c'est à cause de la mort du chef
        if (isNull _chief) then {
            [_taskID, "FAILED"] call BIS_fnc_taskSetState;
            deleteMarker _marker;
            ["taskFailed"] call Gemini_fnc_updateStats;
            ["globalChat", "Le chef a été tué. Mission échouée!"] remoteExec ["Gemini_fnc_globalChat", 0];
        };
    };
};