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


// Compilation des fonctions de base
Gemini_fnc_initTerritorySystem = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_createTerritoryMarkers = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateTerritoryState = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";
Gemini_fnc_updateReputationFromTerritories = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryCore.sqf";

// Compilation des fonctions de chefs de village
Gemini_fnc_spawnVillageChief = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_addChiefInteraction = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_openChiefDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";
Gemini_fnc_handleChiefDeath = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryChiefs.sqf";

// Compilation des fonctions de mission
// consulter le initMissions

// Utiliser uniquement la version standalone
Gemini_fnc_monitorPlayerInTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_monitorPlayerInTerritory.sqf";

// Compilation des fonctions d'interaction du chef de village
Gemini_fnc_openChiefMissionDialog = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showTerritoryStatus = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_showFactionReputation = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getTerritoryColor = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getRecentIncidents = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";
Gemini_fnc_getReputationEffect = compile preprocessFileLineNumbers "scripts\Territory\fnc_chiefInteractions.sqf";


// Charger les missions territoriales
execVM "scripts\Territory\Missions\initMissions.sqf";

// Après avoir compilé toutes les fonctions
diag_log "[TERRITOIRE] Fonctions compilées avec succès";

// Exécution automatique au démarrage - Cette partie est cruciale
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
    
    if (!isNil "Gemini_fnc_monitorPlayerInTerritory") then {
        diag_log "[TERRITOIRE] FORCE: Fonction monitorPlayerInTerritory trouvée, exécution...";
        [] spawn Gemini_fnc_monitorPlayerInTerritory;
        systemChat "DEBUG: Moniteur territorial lancé!";
        diag_log "[TERRITOIRE] FORCE: Moniteur lancé!";
    } else {
        diag_log "[TERRITOIRE] ERREUR GRAVE: Fonction monitorPlayerInTerritory non trouvée!";
        systemChat "ERREUR: Moniteur territorial non trouvé!";
    };
};

OPEX_territory_functions_compiled = true;
publicVariable "OPEX_territory_functions_compiled";
diag_log "[TERRITOIRE] Toutes les fonctions territoriales compilées avec succès";
diag_log "[TERRITOIRE] Module chargé";