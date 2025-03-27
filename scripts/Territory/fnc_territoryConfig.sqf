/*
    Fichier: fnc_territoryConfig.sqf
    Description: Configuration centralisée du système territorial
    
    Ce fichier contient toutes les constantes et paramètres configurables
    pour le système de territoire. Modifier ces valeurs pour ajuster le comportement.
*/

// Fonction pour initialiser les configurations territoriales
Gemini_fnc_initTerritoryConfig = {
    if (!isNil "OPEX_territoryConfig_initialized") exitWith {
        diag_log "[TERRITOIRE][CONFIG] Configuration déjà initialisée";
    };
    
    // Variables de débogage
    OPEX_territory_debug = OPEX_debug; // Utiliser la variable globale OPEX_debug
    OPEX_territory_verboseLogging = OPEX_debug; // Logs très détaillés en mode débug
    
    // États des territoires
    OPEX_territory_states = [
        "unknown",  // Non renseigné, état initial pour tous les nouveaux territoires
        "enemy",    // Hostile, présence ennemie confirmée
        "neutral",  // Neutre, population coopérative
        "friendly"  // Ami, sous contrôle des forces alliées
    ];
    
    // Distances et rayons
    OPEX_territory_campSafeRadius = 2500;      // Distance du camp de base pour créer des territoires neutres
    OPEX_territory_chiefSearchRadius = 150;     // Rayon de recherche pour placer les chefs de village
    OPEX_territory_minimumRadius = 400;         // Rayon minimum pour les territoires (mètres)
    
    // Seuils de sécurité pour changement d'état
    OPEX_territory_security_friendly = 75;   // Seuil de sécurité pour passer en state "friendly"
    OPEX_territory_security_enemy = 25;      // Seuil de sécurité pour passer en state "enemy"
    OPEX_territory_security_initial = 25;    // Niveau de sécurité initial pour les nouveaux territoires
    
    // Événements de chef
    OPEX_territory_chief_respawnTime = [600, 1200];  // Temps de réapparition d'un chef (min, max)
    OPEX_territory_chief_deathPenaltyFriendly = -30; // Pénalité de sécurité si un chef est tué par des amis
    OPEX_territory_chief_deathPenaltyEnemy = -20;    // Pénalité de sécurité si un chef est tué par des ennemis
    
    // Paramètres de pénalisation pour intrusion non autorisée
    OPEX_territory_penalty_delay = 60;      // Délai avant pénalité pour présence non autorisée (secondes)
    OPEX_territory_penalty_warning = 10;     // Temps d'avertissement avant pénalité (secondes)
    
    // Paramètres pour les notifications
    OPEX_territory_notif_duration = 5;      // Durée d'affichage des notifications (secondes)
    OPEX_territory_notif_warning = 8;       // Durée d'affichage des avertissements (secondes)
    
    // Délais des missions
    OPEX_territory_mission_elimination_timeout = 1800;  // Timeout mission élimination (30 minutes)
    OPEX_territory_mission_stabilization_time = 600;    // Temps requis pour mission de stabilisation (10 minutes)
    OPEX_territory_mission_checkpoint_time = 900;       // Temps requis pour mission de checkpoint (15 minutes)
    
    // Probabilités pour la détermination aléatoire d'état
    OPEX_territory_chance_enemy = 0.6;      // 60% de chance d'être hostile pour territoire inconnu
    OPEX_territory_chance_neutral = 0.3;    // 30% de chance d'être neutre pour territoire inconnu
    OPEX_territory_chance_friendly = 0.1;   // 10% de chance d'être ami pour territoire inconnu
    
    // Délais pour communications radio
    OPEX_territory_radio_initialDelay = 3;  // Délai initial de réponse radio (secondes)
    OPEX_territory_radio_analyzeTime = [5, 10]; // Temps d'analyse radio (min, max secondes)
    
    // Couleurs des marqueurs
    OPEX_territory_colors = [
        ["enemy", "ColorOPFOR"],       // Rouge
        ["neutral", "ColorCIV"],       // Vert
        ["friendly", "ColorBLUFOR"],   // Bleu
        ["unknown", "Color6_FD_F"]     // Gris
    ];
    
    // Couleurs de texte
    OPEX_territory_textColors = [
        ["enemy", "#FF0000"],          // Rouge
        ["neutral", "#00FF00"],        // Vert
        ["friendly", "#0080FF"],       // Bleu
        ["unknown", "#FFFFFF"]         // Blanc
    ];
    
    // Marqueur comme initialisé
    OPEX_territoryConfig_initialized = true;
    publicVariable "OPEX_territoryConfig_initialized";
    
    diag_log "[TERRITOIRE][CONFIG] Configuration territoriale initialisée";
};

// Fonction pour obtenir la couleur de marqueur basée sur l'état
Gemini_fnc_getTerritoryMarkerColor = {
    params ["_state"];
    
    private _color = "ColorGrey"; // Défaut
    
    {
        _x params ["_stateMatch", "_colorValue"];
        if (_state == _stateMatch) exitWith {
            _color = _colorValue;
        };
    } forEach OPEX_territory_colors;
    
    _color
};

// Fonction pour obtenir la couleur de texte basée sur l'état
Gemini_fnc_getTerritoryTextColor = {
    params ["_state"];
    
    private _color = "#FFFFFF"; // Défaut
    
    {
        _x params ["_stateMatch", "_colorValue"];
        if (_state == _stateMatch) exitWith {
            _color = _colorValue;
        };
    } forEach OPEX_territory_textColors;
    
    _color
};

// Appeler l'initialisation si ce fichier est exécuté directement
if (isServer) then {
    [] call Gemini_fnc_initTerritoryConfig;
};