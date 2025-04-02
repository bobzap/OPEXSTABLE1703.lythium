/*
    Fichier: init.sqf
    Description: Initialisation du système de contrôle territorial
*/

// Vérifier si ACE est actif
OPEX_ace_enabled = isClass (configFile >> "CfgPatches" >> "ace_main");
if (OPEX_ace_enabled) then {
    diag_log "[TERRITOIRE] ACE détecté, activation des fonctionnalités ACE";
} else {
    diag_log "[TERRITOIRE] ACE non détecté, utilisation des interactions standards";
};

// SECTION 1: CHARGEMENT DE LA CONFIGURATION
// Compilation et chargement de la configuration centralisée (doit être en premier)
Gemini_fnc_initTerritoryConfig = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";
Gemini_fnc_getTerritoryMarkerColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";
Gemini_fnc_getTerritoryTextColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryConfig.sqf";
// Initialiser la configuration immédiatement
if (isServer) then {[] call Gemini_fnc_initTerritoryConfig};

// SECTION 2: SYSTÈME DE MESSAGERIE ET COMMUNICATIONS
// Compilation des fonctions de messagerie
Gemini_fnc_territoryNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territorySystemChat = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryGlobalChat = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryEntryNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryExitNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryPenaltyWarning = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_territoryPenaltyNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";
Gemini_fnc_radioAvailableNotification = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_messagingSystem.sqf";

// Compilation des fonctions du système radio
// Core
Gemini_fnc_canUseRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_setRadioLock = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_addToAuthorizedTerritories = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_isTerritoryAuthorized = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_getHQResponse = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";
Gemini_fnc_simulateRadioDelay = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioCore.sqf";

// Actions
Gemini_fnc_initRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addACERadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addStandardRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_removeAllRadioActions = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_removeRadioAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_addMissionAcceptAction = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";

// Dialogue
Gemini_fnc_startRadioDialog = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";
Gemini_fnc_playerToPlayerRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";
Gemini_fnc_hqAlert = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";

// Missions
Gemini_fnc_offerMissionViaRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_acceptMissionViaRadio = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_reportMissionCompletion = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";
Gemini_fnc_requestSupport = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";


// SECTION 3: FONCTIONS DE BASE
// Compilation des fonctions de base du système territorial
Gemini_fnc_initTerritorySystem = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritoryMarkers = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateTerritoryState = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateReputationFromTerritories = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";

// SECTION 4: FONCTIONS DE CHEF DE VILLAGE
// Compilation des fonctions de chefs de village
Gemini_fnc_spawnVillageChief = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_addChiefInteraction = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_openChiefDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_handleChiefDeath = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";

// SECTION 5: FONCTIONS DE MONITORING
// Compilation des fonctions de monitoring de territoire
Gemini_fnc_monitorPlayerInTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_monitorPlayerInTerritory.sqf";

// Nouvelles fonctions modulaires de détection
Gemini_fnc_initTerritoryMonitor = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";
Gemini_fnc_runTerritoryMonitor = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";
Gemini_fnc_checkPlayerTerritory = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_monitorInit.sqf";

Gemini_fnc_handleTerritoryEnter = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryEnter.sqf";
Gemini_fnc_handleTerritoryExit = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryExit.sqf";
Gemini_fnc_handleChiefOnExit = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_territoryExit.sqf";

Gemini_fnc_startPenaltyTracking = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_penaltySystem.sqf";
Gemini_fnc_applyTerritoryPenalty = compile preprocessFileLineNumbers "scripts\Territory\Detection\fnc_penaltySystem.sqf";
// SECTION 6: FONCTIONS D'INTERACTION AVEC CHEF
// Compilation des fonctions d'interaction du chef de village
Gemini_fnc_openChiefMissionDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showTerritoryStatus = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showFactionReputation = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getTerritoryColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getRecentIncidents = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getReputationEffect = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";

// SECTION 7: INITIALISATION DES MISSIONS
// Charger les missions territoriales
execVM "scripts\Territory\Missions\initMissions.sqf";

// Après avoir compilé toutes les fonctions
diag_log "[TERRITOIRE] Fonctions compilées avec succès";

// SECTION 8: DÉMARRAGE AUTOMATIQUE
// Cette partie est exécutée au démarrage du serveur
[] spawn {
    diag_log "[TERRITOIRE] Préparation à l'initialisation...";
    sleep 15; // Attendre que tout soit prêt
    
    // Initialiser le système
    [] call Gemini_fnc_initTerritorySystem;
    diag_log "[TERRITOIRE] Système initialisé avec succès";
    
    // Lancer le moniteur après initialisation
    waitUntil {!isNil "OPEX_territories_initialized"};
    waitUntil {OPEX_territories_initialized};
    diag_log "[TERRITOIRE] FORCE: Lancement du moniteur territorial depuis init.sqf principal";
    
    sleep 5; // Petit délai pour s'assurer que tout est prêt
    
 // Utiliser le nouveau système de surveillance si disponible, sinon utiliser l'ancien
if (!isNil "Gemini_fnc_initTerritoryMonitor") then {
    diag_log "[TERRITOIRE] Utilisation du système modulaire de surveillance";
    [] call Gemini_fnc_initTerritoryMonitor;
} else {
    if (!isNil "Gemini_fnc_monitorPlayerInTerritory") then {
        diag_log "[TERRITOIRE] Utilisation du système monolithique de surveillance";
        [] spawn Gemini_fnc_monitorPlayerInTerritory;
    } else {
        diag_log "[TERRITOIRE] ERREUR GRAVE: Aucune fonction de surveillance trouvée!";
        if (OPEX_territory_debug) then {
            systemChat "ERREUR: Moniteur territorial non trouvé!";
        };
    };
};

// Marquer comme initialisé
OPEX_territory_functions_compiled = true;
publicVariable "OPEX_territory_functions_compiled";
diag_log "[TERRITOIRE] Toutes les fonctions territoriales compilées avec succès";
diag_log "[TERRITOIRE] Module chargé";