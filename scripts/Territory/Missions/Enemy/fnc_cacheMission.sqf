/*
    Fichier: fnc_cacheMission.sqf
    Description: Mission de recherche et destruction de cache d'armes
*/

Gemini_fnc_cacheMission = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _locationName = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    
    // Créer la tâche
    private _taskID = format ["cache_%1", _territoryIndex];
    private _taskDesc = format ["Localisez et détruisez la cache d'armes ennemie à %1.", _locationName];
    private _taskTitle = format ["Cache d'armes: %1", _locationName];
    
    [
        OPEX_friendly_side1,
        _taskID,
        [_taskDesc, _taskTitle, ""],
        _position,
        "CREATED",
        1,
        true,
        "destroy"
    ] call BIS_fnc_taskCreate;
    
    // Trouver position pour la cache
    private _cachePos = [_position, 20, _radius * 0.7, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    
    // Créer la cache
    private _crate = createVehicle [selectRandom OPEX_enemy_cacheCrates, _cachePos, [], 0, "NONE"];
    _crate setDamage 0;
    clearWeaponCargoGlobal _crate;
    clearMagazineCargoGlobal _crate;
    clearItemCargoGlobal _crate;
    clearBackpackCargoGlobal _crate;
    
    // Ajouter des gardes
    [OPEX_enemy_side1, ["infantry"], [2, 4], _cachePos, [5, 15], "guard", _cachePos, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
    
    // Montrer un indice approximatif
    private _markerPos = [_cachePos, 50] call BIS_fnc_randomPos;
    private _marker = createMarker [format ["cache_hint_%1", _territoryIndex], _markerPos];
    _marker setMarkerType "hd_unknown";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerText "Possible cache";
    _marker setMarkerSize [0.6, 0.6];
    
    // Vérification de la tâche
    [_taskID, _territoryIndex, _crate, _marker] spawn {
        params ["_taskID", "_territoryIndex", "_crate", "_marker"];
        
        waitUntil {
            sleep 1;
            !alive _crate
        };
        
        // Tâche accomplie
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        deleteMarker _marker;
        
        // Augmenter sécurité et réputation
        private _territoryData = OPEX_territories select _territoryIndex;
        private _newSecurity = ((_territoryData select 4) + 25) min 100;
        [_territoryIndex, "neutral", _newSecurity] call Gemini_fnc_updateTerritoryState;
        
        ["taskSucceeded"] call Gemini_fnc_updateStats;
        ["cacheDestroyed"] call Gemini_fnc_updateStats;
        ["globalChat", format ["Cache détruite: Sécurité de %1 augmentée à %2%%", _territoryData select 0, _newSecurity]] remoteExec ["Gemini_fnc_globalChat", 0];
    };
};