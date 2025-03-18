/*
    Fichier: init.sqf
    Description: Initialisation du système de contrôle territorial
*/

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

// Compilation des fonctions de mission
Gemini_fnc_clearAreaMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_findCacheMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_rescueChiefMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_offerLiberationMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_offerStabilizationMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_offerSecurityMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_offerAdvancedMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_spawnEnemiesForMission = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_spawnTerritoryAttackers = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";
Gemini_fnc_monitorPlayerInEnemyTerritory = compile preprocessFileLineNumbers "scripts\Territory\fnc_territoryMissions.sqf";

// Exécution automatique au démarrage
[] spawn {
    diag_log "[TERRITOIRE] Préparation à l'initialisation...";
    sleep 15; // Attendre que tout soit prêt
    
    // Initialiser le système
    [] call Gemini_fnc_initTerritorySystem;
    diag_log "[TERRITOIRE] Système initialisé avec succès";
    
    // Créer un territoire neutre près du camp pour tester les chefs
    sleep 5;
    private _campPos = getMarkerPos "OPEX_marker_camp";
    private _testPos = [(_campPos select 0) + 1000, (_campPos select 1) + 1000, 0];
    ["Village Test", _testPos, 300, "neutral"] call Gemini_fnc_createTerritory;
    diag_log "[TERRITOIRE] Territoire test (neutre) créé";
    
    
};

diag_log "[TERRITOIRE] Module chargé";