// FONCTION: Afficher la boîte de dialogue des missions du chef

// FONCTION: Afficher la boîte de dialogue des missions du chef
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

// FONCTION: Afficher le status du territoire
Gemini_fnc_showTerritoryStatus = {
    params [["_chief", objNull, [objNull]], ["_player", objNull, [objNull]]];
    
    // Vérification
    if (isNull _chief) exitWith {
        hint "Erreur: Chef non défini";
    };
    
    private _territoryIndex = _chief getVariable ["territoryIndex", -1];
    if (_territoryIndex == -1) exitWith {
        hint "Erreur: Chef non lié à un territoire";
    };
    
    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _state = _territoryData select 3;
    private _securityLevel = _territoryData select 4;
    
    // Statut traduit
    private _stateText = switch (_state) do {
        case "friendly": {"sous contrôle allié"};
        case "neutral": {"neutre"};
        case "enemy": {"hostile"};
        default {"inconnu"};
    };
    
    // Message de statut avec mise en forme
    private _message = format [
        "<t size='1.2' align='center' color='#FFD700'>Situation à %1</t><br/><br/>
        <t align='left'>Statut: <t color='%2'>%3</t></t><br/>
        <t align='left'>Niveau de sécurité: %4%</t><br/>
        <t align='left'>Population: Calme</t><br/>
        <t align='left'>Incidents récents: %5</t>",
        _name,
        [_state] call Gemini_fnc_getTerritoryColor,
        _stateText,
        _securityLevel,
        ([_territoryIndex] call Gemini_fnc_getRecentIncidents)
    ];
    
    [_message, 0.3, 0.2, 8, 0.5] remoteExec ["BIS_fnc_dynamicText", _player];
};

// Fonction pour récupérer la couleur hexadécimale selon l'état
Gemini_fnc_getTerritoryColor = {
    params ["_state"];
    
    switch (_state) do {
        case "friendly": {"#0080FF"}; // Bleu
        case "neutral": {"#00FF00"}; // Vert
        case "enemy": {"#FF0000"}; // Rouge
        case "unknown": {"#FFFFFF"}; // Blanc
        default {"#FFFFFF"};
    };
};

// Fonction pour récupérer les incidents récents (fictifs pour l'instant)
Gemini_fnc_getRecentIncidents = {
    params ["_territoryIndex"];
    
    private _incidents = [
        "Aucun incident récent signalé",
        "Quelques vols rapportés",
        "Une patrouille ennemie repérée hier",
        "Un véhicule suspect a traversé le village",
        "Des coups de feu entendus la nuit dernière"
    ];
    
    selectRandom _incidents
};

// FONCTION: Afficher la réputation de la faction
Gemini_fnc_showFactionReputation = {
    params [["_chief", objNull, [objNull]], ["_player", objNull, [objNull]]];
    
    // Vérification de sécurité
    if (isNull _chief) exitWith {
        hint "Erreur: Chef non défini";
    };
    
    // Récupérer la réputation actuelle
    private _reputation = call Gemini_fnc_reputation;
    private _reputationValue = _reputation select 0;
    private _reputationText = _reputation select 1;
    
    // Message de réputation avec mise en forme
    private _color = switch (true) do {
        case (_reputationValue < -100): {"#FF0000"}; // Rouge pour mauvaise réputation
        case (_reputationValue < 0): {"#FFA500"}; // Orange pour réputation modérée
        case (_reputationValue < 100): {"#FFFF00"}; // Jaune pour réputation neutre
        default {"#00FF00"}; // Vert pour bonne réputation
    };
    
    private _message = format [
        "<t size='1.2' align='center' color='#FFD700'>Réputation locale</t><br/><br/>
        <t align='center'>Votre réputation auprès de la population locale est :</t><br/>
        <t align='center' size='1.5' color='%1'>%2</t><br/><br/>
        <t align='left'>Valeur numérique: %3</t><br/>
        <t align='left'>Influence sur la coopération: %4</t>",
        _color,
        _reputationText,
        _reputationValue,
        ([_reputationValue] call Gemini_fnc_getReputationEffect)
    ];
    
    [_message, 0.3, 0.2, 8, 0.5] remoteExec ["BIS_fnc_dynamicText", _player];
};

// Fonction pour obtenir l'effet de la réputation
Gemini_fnc_getReputationEffect = {
    params ["_reputationValue"];
    
    switch (true) do {
        case (_reputationValue < -100): {"Très négatif - La population est hostile"};
        case (_reputationValue < 0): {"Négatif - La coopération est difficile"};
        case (_reputationValue < 50): {"Neutre - Coopération limitée possible"};
        case (_reputationValue < 100): {"Positif - Soutien modéré de la population"};
        default {"Très positif - La population est coopérative"};
    };
};