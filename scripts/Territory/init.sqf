/*
    Fichier: init.sqf
    Description: Initialisation du système de contrôle territorial
    Version: 2.0 (Révisée)
*/

// --- INITIALISATION PRINCIPALE ---
diag_log "[TERRITOIRE] Début de l'initialisation du système territorial";

// Vérifier si déjà initialisé pour éviter les doubles appels
if (!isNil "OPEX_territory_initialized") exitWith {
    diag_log "[TERRITOIRE] Système déjà initialisé - initialisation ignorée";
};

// Marquer comme en cours d'initialisation
OPEX_territory_initialized = false;
publicVariable "OPEX_territory_initialized";

// Vérifier si ACE est actif
OPEX_ace_enabled = isClass (configFile >> "CfgPatches" >> "ace_main");
if (OPEX_ace_enabled) then {
    diag_log "[TERRITOIRE] ACE détecté, activation des fonctionnalités ACE";
} else {
    diag_log "[TERRITOIRE] ACE non détecté, utilisation des interactions standards";
};

// --- SECTION 1: CONFIGURATION ---
diag_log "[TERRITOIRE] Compilation et chargement de la configuration";

// Variables de base pour le debug
if (isNil "OPEX_territory_debug") then { OPEX_territory_debug = false; };
if (isNil "OPEX_territory_verboseLogging") then { OPEX_territory_verboseLogging = false; };

// Variables pour les notifications
if (isNil "OPEX_territory_notif_duration") then { OPEX_territory_notif_duration = 5; };
if (isNil "OPEX_territory_notif_warning") then { OPEX_territory_notif_warning = 8; };

// Configuration centralisée
Gemini_fnc_initTerritoryConfig = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";
Gemini_fnc_getTerritoryMarkerColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";
Gemini_fnc_getTerritoryTextColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";

// Initialiser la configuration immédiatement sur le serveur
if (isServer) then {[] call Gemini_fnc_initTerritoryConfig};

// --- SECTION 2: SYSTÈME DE MESSAGERIE ---
diag_log "[TERRITOIRE] Compilation des fonctions de messagerie";

// Messagerie de base
Gemini_fnc_territoryNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territorySystemChat = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryGlobalChat = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryEntryNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryExitNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryPenaltyWarning = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryPenaltyNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_radioAvailableNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";

// --- SECTION 3: SYSTÈME RADIO ---
diag_log "[TERRITOIRE] Compilation des fonctions du système radio";

// Radio Core
Gemini_fnc_canUseRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_setRadioLock = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_addToAuthorizedTerritories = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_isTerritoryAuthorized = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_getHQResponse = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_simulateRadioDelay = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";

// Radio Actions
Gemini_fnc_initRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addACERadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addStandardRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_removeAllRadioActions = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_removeRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addMissionAcceptAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";

// Radio Dialog
Gemini_fnc_startRadioDialog = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";
Gemini_fnc_playerToPlayerRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";
Gemini_fnc_hqAlert = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";

// Missions Radio
Gemini_fnc_offerMissionViaRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_acceptMissionViaRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_reportMissionCompletion = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_requestSupport = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";

// --- SECTION 4: FONCTIONS DE BASE DU TERRITOIRE ---
diag_log "[TERRITOIRE] Compilation des fonctions de base du système territorial";

Gemini_fnc_initTerritorySystem = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritoryMarkers = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateTerritoryState = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateReputationFromTerritories = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";

// --- SECTION 5: FONCTIONS DE CHEF DE VILLAGE ---
diag_log "[TERRITOIRE] Compilation des fonctions de chefs de village";

Gemini_fnc_spawnVillageChief = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_addChiefInteraction = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_openChiefDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_handleChiefDeath = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";

// --- SECTION 6: FONCTIONS DE DÉTECTION ET MONITORING ---
diag_log "[TERRITOIRE] Compilation des fonctions de détection et monitoring";

// Nouveau système modulaire de détection
Gemini_fnc_initTerritoryMonitor = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";
Gemini_fnc_runTerritoryMonitor = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";
Gemini_fnc_checkPlayerTerritory = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";

Gemini_fnc_handleTerritoryEnter = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryEnter.sqf";
Gemini_fnc_handleTerritoryExit = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryExit.sqf";
Gemini_fnc_handleChiefOnExit = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryExit.sqf";

Gemini_fnc_startPenaltyTracking = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_penaltySystem.sqf";
Gemini_fnc_applyTerritoryPenalty = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_penaltySystem.sqf";

// --- SECTION 7: FONCTIONS D'INTERACTION AVEC CHEF ---
diag_log "[TERRITOIRE] Compilation des fonctions d'interaction du chef";

Gemini_fnc_openChiefMissionDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showTerritoryStatus = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showFactionReputation = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getTerritoryColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getRecentIncidents = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getReputationEffect = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";

// --- SECTION 8: INITIALISATION DES MISSIONS ---
diag_log "[TERRITOIRE] Chargement des missions territoriales";

// Charger séparément les missions
execVM "scripts\Territory\Missions\initMissions.sqf";

// --- SECTION 9: VÉRIFICATION DE LA COMPILATION DES FONCTIONS ---
// Vérifier que toutes les fonctions critiques sont correctement compilées
_functionsToCheck = [
    "Gemini_fnc_initTerritorySystem",
    "Gemini_fnc_territoryEntryNotification",
    "Gemini_fnc_territoryExitNotification",
    "Gemini_fnc_initTerritoryMonitor",
    "Gemini_fnc_handleTerritoryEnter",
    "Gemini_fnc_handleTerritoryExit"
];

_missingFunctions = [];
{
    if (isNil _x) then {
        _missingFunctions pushBack _x;
    };
} forEach _functionsToCheck;

if (count _missingFunctions > 0) then {
    diag_log format ["[TERRITOIRE][ERREUR] Fonctions manquantes: %1", _missingFunctions];
} else {
    diag_log "[TERRITOIRE] Toutes les fonctions critiques sont correctement compilées";
};

// --- SECTION 10: DÉMARRAGE DU SYSTÈME (SERVER ONLY) ---
if (isServer) then {
    [] spawn {
        diag_log "[TERRITOIRE] Préparation à l'initialisation du système (côté serveur)...";
        sleep 10; // Attendre que tout soit prêt
        
        // Initialiser le système territorial
        [] call Gemini_fnc_initTerritorySystem;
        diag_log "[TERRITOIRE] Système territorial initialisé avec succès";
        
        // Attendre que l'initialisation soit complète
        waitUntil {!isNil "OPEX_territories_initialized"};
        waitUntil {OPEX_territories_initialized};
        
        // Laisser un délai pour que tout se stabilise
        sleep 5;
        
        // Vérifier si le moniteur est déjà actif
        if (!isNil "OPEX_territory_monitoring_active" && {OPEX_territory_monitoring_active}) then {
            diag_log "[TERRITOIRE] Système de surveillance déjà actif - pas de réinitialisation";
        } else {
            diag_log "[TERRITOIRE] Lancement du système de surveillance territorial";
            
            // Activer le debug temporairement
            OPEX_territory_debug = true;
            OPEX_territory_verboseLogging = true;
            
            // Lancer le système de surveillance
            [] call Gemini_fnc_initTerritoryMonitor;
            
            // Confirmer le lancement
            if (!isNil "OPEX_territory_monitoring_active" && {OPEX_territory_monitoring_active}) then {
                diag_log "[TERRITOIRE] Système de surveillance territorial démarré avec succès";
            } else {
                diag_log "[TERRITOIRE][ERREUR] Échec du démarrage du système de surveillance territorial";
            };
        };
        
        // Marquer comme complètement initialisé
        OPEX_territory_initialized = true;
        publicVariable "OPEX_territory_initialized";
        
        diag_log "[TERRITOIRE] Initialisation complète du système territorial";
    };
};

// Marquer les fonctions comme compilées
OPEX_territory_functions_compiled = true;
publicVariable "OPEX_territory_functions_compiled";

diag_log "[TERRITOIRE] Toutes les fonctions territoriales compilées avec succès";
diag_log "[TERRITOIRE] Module chargé";