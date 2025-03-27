/*
    Fichier: fnc_territoryAttack.sqf
    Description: Attaque dynamique d'un territoire par des forces ennemies
*/

Gemini_fnc_territoryAttack = {
    params ["_territoryIndex"];
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    private _name = _territoryData select 0;
    
    diag_log format ["[TERRITOIRE] Contre-attaque sur: %1", _name];
    
    // Notifier les joueurs
    ["globalChat", format ["Rapport: Forces ennemies repérées en approche de %1!", _name]] remoteExec ["Gemini_fnc_globalChat", 0];
    
    // Spawn d'attaquants à distance
    private _attackPos = [_position, _radius * 2, _radius * 3, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    
    private _squadTypes = ["infantry", "infantry", "infantry", "motorized", "armored"];
    private _squadType = selectRandom _squadTypes;
    private _squad = [OPEX_enemy_side1, [_squadType], -1, _attackPos, 0, "attack", _position, OPEX_enemy_AIskill, 100, "task"] call Gemini_fnc_spawnSquad;
    
    diag_log format ["[TERRITOIRE] Escouade d'attaque créée: %1", _squad];
    
    // Moniteur pour vérifier l'issue de l'attaque
    [_territoryIndex, _position, _radius] spawn {
        params ["_territoryIndex", "_position", "_radius"];
        
        sleep 120; // Attendre 2 minutes avant de commencer la vérification
        
        private _attackActive = true;
        private _friendliesPresent = false;
        private _enemiesPresent = false;
        private _endTime = time + 600; // 10 minutes max pour l'attaque
        
        while {_attackActive} do {
            sleep 30;
            
            private _friendlyCount = {alive _x && side _x == OPEX_friendly_side1} count (_position nearEntities ["Man", _radius]);
            private _enemyCount = {alive _x && side _x == OPEX_enemy_side1} count (_position nearEntities ["Man", _radius]);
            
            _friendliesPresent = _friendlyCount > 0;
            _enemiesPresent = _enemyCount > 0;
            
            // Si personne n'est présent ou si l'attaque a duré plus de 10 minutes
            if ((!_friendliesPresent && !_enemiesPresent) || (time > _endTime)) then {
                _attackActive = false;
            };
            
            // Si les ennemis sont présents mais pas les amis, diminuer la sécurité
            if (_enemiesPresent && !_friendliesPresent) then {
                private _territoryData = OPEX_territories select _territoryIndex;
                private _security = _territoryData select 4;
                private _state = _territoryData select 3;
                
                _security = _security - 10;
                
                // Si la sécurité tombe trop bas, changer l'état
                if (_security < 25 && _state != "enemy") then {
                    [_territoryIndex, "enemy", _security] call Gemini_fnc_updateTerritoryState;
                    ["globalChat", format ["Alerte: %1 est tombé aux mains de l'ennemi!", _territoryData select 0]] remoteExec ["Gemini_fnc_globalChat", 0];
                } else {
                    [_territoryIndex, "", _security] call Gemini_fnc_updateTerritoryState;
                };
            };
        };
    };
};