/*
    Fichier: initMissions.sqf
    Description: Initialisation du système de missions territoriales
*/

// Compilation des fonctions de base du gestionnaire de missions
Gemini_fnc_territoryMissionManager = compile preprocessFileLineNumbers "scripts\Territory\Missions\fnc_missionManager.sqf";
Gemini_fnc_offerEnemyMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\fnc_missionManager.sqf";
Gemini_fnc_offerNeutralMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\fnc_missionManager.sqf";
Gemini_fnc_offerFriendlyMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\fnc_missionManager.sqf";

// Compilation des fonctions de communication radio
Gemini_fnc_initiateRadioCommunication = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioActions.sqf";
Gemini_fnc_startRadioSequence = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioDialog.sqf";
Gemini_fnc_simpleEliminationMission = compile preprocessFileLineNumbers "scripts\Territory\Communications\fnc_radioMissions.sqf";

// Déplacer les fonctions existantes aux nouveaux emplacements
Gemini_fnc_clearAreaMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Enemy\fnc_clearAreaMission.sqf";
Gemini_fnc_cacheMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Enemy\fnc_cacheMission.sqf";
Gemini_fnc_rescueMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Enemy\fnc_rescueMission.sqf";
Gemini_fnc_stabilizationMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Neutral\fnc_stabilizationMission.sqf";
Gemini_fnc_securityMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Friendly\fnc_securityMission.sqf";
Gemini_fnc_intelligenceMission = compile preprocessFileLineNumbers "scripts\Territory\Missions\Friendly\fnc_intelligenceMission.sqf";

// Compilation de la fonction d'attaque territoriale
Gemini_fnc_territoryAttack = compile preprocessFileLineNumbers "scripts\Territory\Missions\Dynamic\fnc_territoryAttack.sqf";


publicVariable "Gemini_fnc_initiateRadioCommunication"; 
publicVariable "Gemini_fnc_startRadioSequence";
publicVariable "Gemini_fnc_simpleEliminationMission";

diag_log "[TERRITOIRE][MISSIONS] Toutes les fonctions de missions territoriales compilées";