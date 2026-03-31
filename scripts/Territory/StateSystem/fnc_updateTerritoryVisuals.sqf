/*
    Fichier: fnc_updateTerritoryVisuals.sqf
    Description: Mise à jour des marqueurs visuels (carte) pour un territoire

    Utilise les couleurs définies dans fnc_territoryConfig.sqf :
    - OPEX_territory_colors
    - OPEX_territory_textColors
*/

Gemini_fnc_updateTerritoryVisuals = {
    params [["_territoryIndex", -1, [0]]];

    if (_territoryIndex < 0 || _territoryIndex >= count OPEX_territories) exitWith {
        diag_log format ["[TERRITOIRE][VISUALS] Index invalide: %1", _territoryIndex];
        false
    };

    private _territoryData = OPEX_territories select _territoryIndex;
    private _name = _territoryData select 0;
    private _state = _territoryData select 3;
    private _securityLevel = _territoryData select 4;
    private _chief = _territoryData select 5;
    private _markers = _territoryData select 8;

    // Déterminer la couleur selon l'état
    private _color = switch (_state) do {
        case "friendly": { "ColorBLUFOR" };
        case "neutral": { "ColorCIV" };
        case "unknown": { "Color6_FD_F" };
        default { "ColorOPFOR" };
    };

    // Mettre à jour les marqueurs s'ils existent
    if (count _markers > 1) then {
        private _markerArea = _markers select 0;
        private _markerIcon = _markers select 1;

        // Couleur de la zone et de l'icône
        _markerArea setMarkerColor _color;
        _markerIcon setMarkerColor _color;

        // Opacité selon l'état (inconnu plus transparent)
        if (_state == "unknown") then {
            _markerArea setMarkerAlpha 0.15;
        } else {
            _markerArea setMarkerAlpha 0.3;
        };

        // Texte du marqueur selon l'état
        private _markerText = switch (_state) do {
            case "unknown": { format ["%1 (Non renseigné)", _name] };
            case "enemy": { format ["%1 (Hostile)", _name] };
            case "neutral": { format ["%1", _name] };
            case "friendly": { format ["%1", _name] };
            default { _name };
        };

        _markerIcon setMarkerText _markerText;

        // Icône selon la présence d'un chef et l'état
        private _iconType = switch (_state) do {
            case "friendly": { "loc_Ruin" };
            case "neutral": { "loc_Ruin" };
            case "enemy": { "loc_Ruin" };
            default { "loc_Ruin" };
        };

        _markerIcon setMarkerType _iconType;
    };

    // Pas de marqueur précis pour le chef — plus immersif
    // Le joueur reçoit une description approximative via les notifications d'entrée

    if (OPEX_territory_debug) then {
        diag_log format ["[TERRITOIRE][VISUALS] Marqueurs mis à jour pour %1: état=%2, couleur=%3", _name, _state, _color];
    };

    true
};
