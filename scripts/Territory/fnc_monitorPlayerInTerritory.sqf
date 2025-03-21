// FONCTION AMÉLIORÉE AVEC GESTION DES CONSÉQUENCES ET LOGS DE DÉBOGAGE AVANCÉS
Gemini_fnc_monitorPlayerInTerritory = {
    // Logs initiaux
    diag_log "[TERRITOIRE] Début de la fonction monitorPlayerInTerritory";
    
    // Vérifier si serveur
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE] Fonction annulée - n'est pas serveur";
    };
    
    // Indicateur global
    missionNamespace setVariable ["OPEX_territory_monitoring_active", true, true];
    
    // Spawn de la boucle principale
    [] spawn {
        // Attendre l'initialisation
        waitUntil {!isNil "OPEX_territories_initialized"};
        waitUntil {OPEX_territories_initialized};
        
        // Logs d'initialisation plus détaillés
        diag_log format ["[TERRITOIRE] Surveillance territoriale activée - %1 territoires au total", count OPEX_territories];
        
        // Afficher les détails de tous les territoires au démarrage
        diag_log "[TERRITOIRE] Liste de tous les territoires avec rayons:";
        {
            private _name = _x select 0;
            private _pos = _x select 1;
            private _radius = _x select 2;
            private _state = _x select 3;
            diag_log format ["  - %1: position %2, rayon %3m, état %4", _name, _pos, _radius, _state];
        } forEach OPEX_territories;
        
        // Boucle principale
        while {true} do {
            // Vérification périodique des positions des joueurs par rapport aux territoires
            if (time % 15 < 0.1) then { // Environ toutes les 15 secondes
                {
                    private _player = _x;
                    private _playerPos = getPosATL _player;
                    private _playerName = name _player;
                    
                    diag_log format ["[TERRITOIRE] DEBUG: Position de %1: %2", _playerName, _playerPos];
                    
                    {
                        private _name = _x select 0;
                        private _pos = _x select 1;
                        private _radius = _x select 2;
                        private _distance = _playerPos distance _pos;
                        
                        if (_distance < _radius + 100) then { // Afficher seulement les territoires proches
                            diag_log format ["  - Distance à %1: %2m / %3m (%4)", 
                                _name, round(_distance), round(_radius), 
                                if (_distance < _radius) then {"DANS ZONE"} else {"hors zone"}];
                        };
                    } forEach OPEX_territories;
                } forEach allPlayers;
            };
            
            // Pour chaque joueur
            {
                private _player = _x;
                private _playerPos = getPosATL _player;
                private _playerName = name _player;
                
                // Variables pour le territoire où le joueur est
                private _inTerritory = false;
                private _territoryState = "";
                private _territoryIndex = -1;
                private _territoryName = "";
                private _territoryRadius = 0;
                
                // Vérifier chaque territoire
                {
    private _territoryData = _x;
    private _name = _territoryData select 0;
    private _position = _territoryData select 1;
    private _radius = _territoryData select 2;
    private _state = _territoryData select 3;
    
    // Calcul de distance 2D (ignorer Z)
    private _distance = [_playerPos select 0, _playerPos select 1, 0] distance2D [_position select 0, _position select 1, 0];
    
    // Vérifier si joueur dans ce territoire avec log détaillé
    if (_distance < _radius) then {
        // Log détaillé de la vérification de distance
        diag_log format ["[TERRITOIRE] Distance vérifiée: %1 distance %2m / rayon %3m (dans territoire: oui)", 
            _name, round(_distance), round(_radius)];
        
        _inTerritory = true;
        _territoryState = _state;
        _territoryIndex = _forEachIndex;
        _territoryName = _name;
        _territoryRadius = _radius;
        
        diag_log format ["[TERRITOIRE] Joueur %1 dans territoire %2 (%3) - distance %4m/%5m", 
            _playerName, _name, _state, round(_distance), round(_radius)];
        break;
    } else {
        // Log pour les territoires proches mais où le joueur n'est pas
        if (_distance < _radius + 50) then {
            diag_log format ["[TERRITOIRE] Joueur %1 proche mais hors territoire %2 - distance %3m/%4m (Z joueur: %5, Z territoire: %6)", 
                _playerName, _name, round(_distance), round(_radius), round(_playerPos select 2), round(_position select 2)];
        };
    };
} forEach OPEX_territories;
                
                // Si joueur dans un territoire
                if (_inTerritory && _territoryIndex != -1) then {
                    // Vérifier si nouveau territoire
                    private _lastTerritory = _player getVariable ["lastVisitedTerritory", ""];
                    
                    // Si c'est un nouveau territoire
                    if (_lastTerritory != _territoryName) then {
                        // Marquer le nouveau territoire avec plus de logs
                        _player setVariable ["lastVisitedTerritory", _territoryName, true];
                        _player setVariable ["territoryWarningReceived", true, true];
                        _player setVariable ["territoryEntryTime", time, true];
                        _player setVariable ["territoryState", _territoryState, true];
                        
                        diag_log format ["[TERRITOIRE] NOUVEAU territoire pour %1: %2 (%3) - envoi notifications", 
                            _playerName, _territoryName, _territoryState];
                        
                        // Action selon l'état avec logs pour notifications
                        switch (_territoryState) do {
                            case "unknown": {
                                // Messages pour territoire inconnu avec confirmation
                                private _message = format ["<t size='1.2' color='#FF8C00' align='center'>TERRITOIRE INCONNU: %1</t><br/><t align='center'>Contactez le PC avant d'approcher.</t>", _territoryName];
                                
                                // Utiliser plusieurs méthodes pour s'assurer que le message passe
                                [_message, 0.5, 0.2, 5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
                                diag_log format ["[TERRITOIRE] NOTIF dynamicText envoyée à %1 pour %2 (inconnu)", _playerName, _territoryName];
                                
                                [format ["Territoire non renseigné: %1", _territoryName]] remoteExec ["systemChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF systemChat envoyée à %1 pour %2 (inconnu)", _playerName, _territoryName];
                                
                                ["globalChat", format ["QG à Patrouille: Nous n'avons aucune information sur %1. Contactez le PC pour obtenir des renseignements avant de poursuivre.", _territoryName]] remoteExec ["Gemini_fnc_globalChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF globalChat envoyée à %1 pour %2 (inconnu)", _playerName, _territoryName];
                                
                                // Démarrer suivi de pénalité
                                [_player, _territoryIndex, _territoryName] spawn {
                                    params ["_unit", "_idx", "_name"];
                                    
                                    // Paramètres de pénalité
                                    private _penaltyDelay = 15; // 15 secondes avant pénalité
                                    private _warningTime = 5; // Avertissement 5 secondes avant
                                    private _entryTime = time;
                                    private _warned = false;
                                    
                                    diag_log format ["[TERRITOIRE] Début surveillance pénalité pour %1 en territoire %2", name _unit, _name];
                                    
                                    // Boucle de surveillance
                                    while {true} do {
                                        // Vérifier si le joueur est toujours dans le même territoire
                                        if ((_unit getVariable ["lastVisitedTerritory", ""]) != _name) exitWith {
                                            diag_log format ["[TERRITOIRE] Surveillance pénalité terminée - joueur a quitté %1", _name];
                                        };
                                        
                                        // Vérifier si le joueur est maintenant autorisé
                                        if (_unit getVariable ["territoryAuthorized", false]) exitWith {
                                            diag_log format ["[TERRITOIRE] Surveillance pénalité terminée - joueur autorisé dans %1", _name];
                                        };
                                        
                                        // Calculer temps écoulé
                                        private _timeInZone = time - _entryTime;
                                        
                                        // Avertissement avant pénalité
                                        if (_timeInZone > (_penaltyDelay - _warningTime) && !_warned) then {
                                            diag_log format ["[TERRITOIRE] AVERTISSEMENT pour %1 - presque 2 minutes dans %2", name _unit, _name];
                                            private _warningMsg = format ["<t size='1.2' color='#FFA500'>AVERTISSEMENT</t><br/>Vous êtes dans %1 depuis presque 2 minutes sans autorisation.<br/>Faites demi-tour ou contactez le PC pour éviter une pénalité.", _name];
                                            [_warningMsg, 0.5, 0.3, 6, 0] remoteExec ["BIS_fnc_dynamicText", _unit];
                                            [format ["AVERTISSEMENT: %1 minute en zone non autorisée. Sanction sur notre réputation imminente.", round(_timeInZone/60)]] remoteExec ["systemChat", _unit];
                                            _warned = true;
                                        };
                                        
                                        // Appliquer pénalité après délai
                                        if (_timeInZone > _penaltyDelay) then {
                                            diag_log format ["[TERRITOIRE] PÉNALITÉ pour %1 - plus de 2 minutes dans %2", name _unit, _name];
                                            private _penaltyMsg = format ["<t size='1.2' color='#FF0000'>PÉNALITÉ</t><br/>Vous avez passé plus de 2 minutes en territoire non autorisé.<br/>Votre réputation a été affectée."];
                                            [_penaltyMsg, 0.5, 0.3, 6, 0] remoteExec ["BIS_fnc_dynamicText", _unit];
                                            ["SANCTION: Trop de temps passé en zone non autorisée. Réputation affectée."] remoteExec ["systemChat", _unit];
                                            [format ["QG à toutes les unités: La patrouille de %1 a pénétré en zone non renseignée sans autorisation.", name _unit]] remoteExec ["systemChat", 0];
                                            ["civilianHarassed"] call Gemini_fnc_updateStats; // Pénalité de réputation
                                            _unit setVariable ["territoryPenalized", true, true];
                                            break;
                                        };
                                        
                                        sleep 5;
                                    };
                                };
                            };
                            
                            case "enemy": {
                                // Messages pour territoire hostile avec confirmation
                                private _message = format ["<t size='1.2' color='#FF0000' align='center'>TERRITOIRE HOSTILE: %1</t><br/><t align='center'>Soyez extrêmement vigilant.</t>", _territoryName];
                                [_message, 0.5, 0.2, 5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
                                diag_log format ["[TERRITOIRE] NOTIF dynamicText envoyée à %1 pour %2 (hostile)", _playerName, _territoryName];
                                
                                [format ["Territoire hostile: %1", _territoryName]] remoteExec ["systemChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF systemChat envoyée à %1 pour %2 (hostile)", _playerName, _territoryName];
                                
                                ["globalChat", format ["QG à Patrouille: Attention, vous êtes entré dans un territoire hostile: %1. Restez sur vos gardes.", _territoryName]] remoteExec ["Gemini_fnc_globalChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF globalChat envoyée à %1 pour %2 (hostile)", _playerName, _territoryName];
                            };
                            
                            case "neutral": {
                                // Messages pour territoire neutre avec confirmation
                                private _message = format ["<t size='1.2' color='#00FF00' align='center'>TERRITOIRE NEUTRE: %1</t><br/><t align='center'>Les habitants sont coopératifs mais restez vigilant.</t>", _territoryName];
                                [_message, 0.5, 0.2, 5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
                                diag_log format ["[TERRITOIRE] NOTIF dynamicText envoyée à %1 pour %2 (neutre)", _playerName, _territoryName];
                                
                                [format ["Territoire neutre: %1", _territoryName]] remoteExec ["systemChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF systemChat envoyée à %1 pour %2 (neutre)", _playerName, _territoryName];
                                
                                ["globalChat", format ["QG à Patrouille: Vous êtes entré dans le territoire neutre de %1. Les locaux semblent pacifiques, mais restez sur vos gardes.", _territoryName]] remoteExec ["Gemini_fnc_globalChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF globalChat envoyée à %1 pour %2 (neutre)", _playerName, _territoryName];
                                
                                // Gestion du chef - mais via un spawn séparé pour éviter tout problème
                                [_territoryIndex] spawn {
                                    params ["_index"];
                                    sleep 1; // Petit délai pour s'assurer que toutes les variables sont à jour
                                    
                                    // Récupérer les données actualisées
                                    private _territoryData = OPEX_territories select _index;
                                    private _name = _territoryData select 0;
                                    private _chief = _territoryData select 5;
                                    
                                    // Si pas de chef, en créer un
                                    if (isNull _chief) then {
                                        diag_log format ["[TERRITOIRE] Création dynamique d'un chef pour %1 (neutre)", _name];
                                        [_index] call Gemini_fnc_spawnVillageChief;
                                    } else {
                                        diag_log format ["[TERRITOIRE] Chef déjà existant pour %1: %2", _name, _chief];
                                    };
                                };
                            };
                            
                            case "friendly": {
                                // Messages pour territoire ami avec confirmation
                                private _message = format ["<t size='1.2' color='#0000FF' align='center'>TERRITOIRE AMI: %1</t><br/><t align='center'>Zone sécurisée sous contrôle allié.</t>", _territoryName];
                                [_message, 0.5, 0.2, 5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
                                diag_log format ["[TERRITOIRE] NOTIF dynamicText envoyée à %1 pour %2 (ami)", _playerName, _territoryName];
                                
                                [format ["Territoire ami: %1", _territoryName]] remoteExec ["systemChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF systemChat envoyée à %1 pour %2 (ami)", _playerName, _territoryName];
                                
                                ["globalChat", format ["QG à Patrouille: Vous êtes entré dans le territoire ami de %1. Nos forces y assurent la sécurité.", _territoryName]] remoteExec ["Gemini_fnc_globalChat", _player];
                                diag_log format ["[TERRITOIRE] NOTIF globalChat envoyée à %1 pour %2 (ami)", _playerName, _territoryName];
                                
                                // Gestion du chef - mais via un spawn séparé pour éviter tout problème
                                [_territoryIndex] spawn {
                                    params ["_index"];
                                    sleep 1; // Petit délai pour s'assurer que toutes les variables sont à jour
                                    
                                    // Récupérer les données actualisées
                                    private _territoryData = OPEX_territories select _index;
                                    private _name = _territoryData select 0;
                                    private _chief = _territoryData select 5;
                                    
                                    // Si pas de chef, en créer un
                                    if (isNull _chief) then {
                                        diag_log format ["[TERRITOIRE] Création dynamique d'un chef pour %1 (ami)", _name];
                                        [_index] call Gemini_fnc_spawnVillageChief;
                                    } else {
                                        diag_log format ["[TERRITOIRE] Chef déjà existant pour %1: %2", _name, _chief];
                                    };
                                };
                            };
                            
                            default {
                                // Pour tout autre état non prévu
                                diag_log format ["[TERRITOIRE] ERREUR: État de territoire non reconnu pour %1: '%2'", _territoryName, _territoryState];
                            };
                        };
                    };
                } else {
    // Si le joueur était dans un territoire mais n'y est plus
    private _lastTerritory = _player getVariable ["lastVisitedTerritory", ""];
    if (_lastTerritory != "") then {
        diag_log format ["[TERRITOIRE] Joueur %1 quitte le territoire %2", _playerName, _lastTerritory];
        
        // Notification de sortie
        private _exitMsg = format ["<t size='1.2' color='#FFFFFF'>SORTIE DE ZONE</t><br/>Vous avez quitté le territoire de %1", _lastTerritory];
        [_exitMsg, 0.5, 0.2, 4, 0] remoteExec ["BIS_fnc_dynamicText", _player];
        [format ["Vous avez quitté le territoire: %1", _lastTerritory]] remoteExec ["systemChat", _player];
        
        // Message spécial si territoire inconnu et non-autorisé
        private _wasAuthorized = _player getVariable ["territoryAuthorized", false];
        private _wasUnknown = (_player getVariable ["territoryState", ""]) == "unknown";
        private _wasState = _player getVariable ["territoryState", ""];
        
        if (_wasUnknown && !_wasAuthorized && {(_player getVariable ["territoryPenalized", false]) == false}) then {
            ["globalChat", "QG à Patrouille: Bonne décision de vous retirer d'une zone non autorisée. Continuez la mission."] remoteExec ["Gemini_fnc_globalChat", _player];
        };
        
        // Trouver l'index du territoire quitté
        private _territoryLeftIndex = -1;
        {
            if ((_x select 0) == _lastTerritory) exitWith {
                _territoryLeftIndex = _forEachIndex;
            };
        } forEach OPEX_territories;
        
       // Vérifier s'il y a d'autres joueurs dans ce territoire
private _otherPlayersInTerritory = false;
if (_territoryLeftIndex != -1) then {
    private _territoryPos = (OPEX_territories select _territoryLeftIndex) select 1;
    private _territoryRadius = (OPEX_territories select _territoryLeftIndex) select 2;
    
    {
        if (_x != _player) then {
            private _otherPlayerPos = getPosATL _x;
            if (([_otherPlayerPos select 0, _otherPlayerPos select 1, 0] distance2D [_territoryPos select 0, _territoryPos select 1, 0]) < _territoryRadius) then {
                _otherPlayersInTerritory = true;
                diag_log format ["[TERRITOIRE] Un autre joueur (%1) est présent dans %2, chef maintenu", name _x, _lastTerritory];
            };
        };
    } forEach allPlayers;
            
            // Si territoire neutre/ami et aucun autre joueur présent, supprimer le chef
            if ((_wasState == "neutral" || _wasState == "friendly") && !_otherPlayersInTerritory) then {
                private _territoryData = OPEX_territories select _territoryLeftIndex;
                private _chief = _territoryData select 5;
                
                if (!isNull _chief) then {
                    diag_log format ["[TERRITOIRE] Suppression du chef de %1, plus aucun joueur présent", _lastTerritory];
                    deleteVehicle _chief;
                    _territoryData set [5, objNull];
                    OPEX_territories set [_territoryLeftIndex, _territoryData];
                    publicVariable "OPEX_territories";
                };
            };
        };
        
        // Réinitialiser les variables
        _player setVariable ["lastVisitedTerritory", "", true];
        _player setVariable ["territoryWarningReceived", false, true];
        _player setVariable ["territoryAuthorized", false, true];
        _player setVariable ["territoryPenalized", false, true];
        _player setVariable ["territoryState", "", true];
    };
}


            } forEach allPlayers;
            
            // Intervalle entre vérifications
            sleep 5;
        };
    };
};