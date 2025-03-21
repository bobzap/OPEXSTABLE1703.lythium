// Fonctions simplifiées pour tests
Gemini_fnc_openChiefMissionDialog = {
    params [["_chief", objNull, [objNull]], ["_player", objNull, [objNull]]];
    
    // Vérification de sécurité
    if (isNull _chief) exitWith {
        hint "Erreur: Chef non défini";
    };
    
    private _territoryIndex = _chief getVariable ["territoryIndex", -1];
    if (_territoryIndex == -1) exitWith {
        hint "Erreur: Chef non lié à un territoire";
    };
    
    // Appel de la fonction existante
    [_chief, _player, _territoryIndex] call Gemini_fnc_openChiefDialog;
};

Gemini_fnc_showTerritoryStatus = {
    hint "Test: Statut du territoire";
};

Gemini_fnc_showFactionReputation = {
    hint "Test: Réputation de la faction";
};

// Utiliser cette ligne pour compiler ces fonctions
if (true) then {
    Gemini_fnc_openChiefMissionDialog = compileFinal Gemini_fnc_openChiefMissionDialog;
    Gemini_fnc_showTerritoryStatus = compileFinal Gemini_fnc_showTerritoryStatus;
    Gemini_fnc_showFactionReputation = compileFinal Gemini_fnc_showFactionReputation;
};