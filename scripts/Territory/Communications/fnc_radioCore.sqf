/*
    Fichier: fnc_radioCore.sqf
    Description: Fonctions et variables de base pour le système de communication radio
    
    Ce fichier contient les variables globales et les fonctions fondamentales
    utilisées par le système de communication radio territorial.
*/

// Variables globales pour la gestion des communications radio
if (isServer) then {
    // Variables d'état global
    if (isNil "OPEX_radioComm_active") then {
        OPEX_radioComm_active = false;
        publicVariable "OPEX_radioComm_active";
    };
    
    // Liste des territoires autorisés
    if (isNil "OPEX_radioComm_authorized") then {
        OPEX_radioComm_authorized = [];
        publicVariable "OPEX_radioComm_authorized";
    };
    
    // Compteur de transmissions radio
    if (isNil "OPEX_radioComm_transmissions") then {
        OPEX_radioComm_transmissions = 0;
        publicVariable "OPEX_radioComm_transmissions";
    };
    
    diag_log "[TERRITOIRE][RADIO] Variables globales de communication initialisées";
};

// Fonction pour vérifier si un joueur peut utiliser la radio
Gemini_fnc_canUseRadio = {
    params [["_player", objNull, [objNull]]];
    
    // Validation de base
    if (isNull _player) exitWith {false};
    
    // Vérification si le joueur a un moyen de communication
    private _hasRadio = false;
    
    // Si ACE est activé, vérification des radios ACE
    if (OPEX_ace_enabled) then {
        _hasRadio = [_player] call acre_api_fnc_hasRadio;
    } else {
        // Sans ACE, vérification simplifiée
        _hasRadio = true; // Simplifié pour la démo, peut être adapté selon vos besoins
    };
    
    _hasRadio
};

// Fonction pour verrouiller/déverrouiller les transmissions radio
Gemini_fnc_setRadioLock = {
    params [["_state", true, [true]]];
    
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative de verrouillage radio côté client";
        false
    };
    
    OPEX_radioComm_active = _state;
    publicVariable "OPEX_radioComm_active";
    
    diag_log format ["[TERRITOIRE][RADIO] État du verrouillage radio: %1", _state];
    true
};

// Fonction pour ajouter un territoire à la liste des autorisés
Gemini_fnc_addToAuthorizedTerritories = {
    params [["_territoryIndex", -1, [0]]];
    
    if (!isServer) exitWith {
        diag_log "[TERRITOIRE][RADIO] Erreur: Tentative d'ajout d'autorisation côté client";
        false
    };
    
    // Vérifier si l'index est valide
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][RADIO] Erreur: Index de territoire invalide: %1", _territoryIndex];
        false
    };
    
    // Ajouter à la liste (sans duplication)
    OPEX_radioComm_authorized pushBackUnique _territoryIndex;
    publicVariable "OPEX_radioComm_authorized";
    
    private _territoryName = (OPEX_territories select _territoryIndex) select 0;
    diag_log format ["[TERRITOIRE][RADIO] Territoire autorisé ajouté: %1 (index: %2)", _territoryName, _territoryIndex];
    
    // Incrémenter le compteur de transmissions
    OPEX_radioComm_transmissions = OPEX_radioComm_transmissions + 1;
    publicVariable "OPEX_radioComm_transmissions";
    
    true
};

// Fonction pour vérifier si un territoire est autorisé
Gemini_fnc_isTerritoryAuthorized = {
    params [["_territoryIndex", -1, [0]]];
    
    _territoryIndex in OPEX_radioComm_authorized
};

// Fonction pour obtenir une réponse du QG selon l'état réel du territoire
Gemini_fnc_getHQResponse = {
    params [["_territoryIndex", -1, [0]]];
    
    // Vérifier l'index
    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        ["Données indisponibles sur ce secteur. Restez vigilants.", "unknown"]
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _actualState = _territoryData select 3;
    private _territoryName = _territoryData select 0;
    
    private _response = switch (_actualState) do {
        case "enemy": {
            [format ["Secteur %1 est HOSTILE. Présence ennemie confirmée. Procédez avec extrême prudence.", _territoryName], "enemy"]
        };
        case "neutral": {
            [format ["Secteur %1 est NEUTRE. Population coopérative, mais restez vigilants.", _territoryName], "neutral"]
        };
        case "friendly": {
            [format ["Secteur %1 est AMI. Zone sous contrôle des forces alliées.", _territoryName], "friendly"]
        };
        default {
            [format ["Données indisponibles sur secteur %1. Restez sur votre position, nous envoyons du renfort pour évaluation.", _territoryName], "unknown"]
        };
    };
    
    _response
};

// Fonction pour simuler un délai radio réaliste
Gemini_fnc_simulateRadioDelay = {
    params [
        ["_minDelay", 2, [0]],
        ["_maxDelay", 5, [0]],
        ["_qualityFactor", 1.0, [0]]
    ];
    
    // Plus la qualité est basse, plus le délai est long
    private _qualityMultiplier = 1 / (_qualityFactor max 0.1);
    private _delay = (_minDelay + random (_maxDelay - _minDelay)) * _qualityMultiplier;
    
    // Limiter à un maximum raisonnable
    _delay = _delay min 15;
    
    diag_log format ["[TERRITOIRE][RADIO] Délai de transmission simulé: %1 secondes", _delay];
    
    _delay
};

// Initialisation au démarrage du script
if (isServer) then {
    diag_log "[TERRITOIRE][RADIO] Module radioCore initialisé";
};