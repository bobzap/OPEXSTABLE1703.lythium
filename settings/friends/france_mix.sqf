/*
	NOT ENABLED YET !
*/
if (true) exitWith {};


// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "r3f_armes"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_Retex"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_Uniformes"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "R3F_PVP"))) exitWith {};
if (!(isClass (configFile >> "CfgPatches" >> "AMF"))) exitWith {};

// DEFINING FACTION NAMES
_OPEX_friendly_modName = "mix"; // e.g.: "RHS"
_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // e.g.: "NATO"
_OPEX_friendly_subFaction = "STR_friendly_subFaction_France"; // e.g.; "USA"

// ===============================================================================
// do not edit or delete section below
// ===============================================================================

// ENABLING FACTION
waitUntil {!isNil "OPEX_friendly_factions"};
if (isServer) then {OPEX_friendly_factions append [[_OPEX_friendly_subFaction, _OPEX_friendly_modName]]}; publicVariable "OPEX_friendly_factions"; // do not edit or delete this line

// WAITING FOR FACTION SELECTION
waitUntil {!isNil "OPEX_params_ready"}; // do not edit or delete this line
waitUntil {OPEX_params_ready}; // do not edit or delete this line
if (!(OPEX_param_friendlyFaction isEqualTo [_OPEX_friendly_subFaction, _OPEX_friendly_modName])) exitWith {};

// CONFIRMING FACTION NAMES
OPEX_friendly_modName = _OPEX_friendly_modName; // do not edit or delete this line
OPEX_friendly_factionName = _OPEX_friendly_factionName; // do not edit or delete this line
OPEX_friendly_subFaction = _OPEX_friendly_subFaction; // do not edit or delete this line

// ===============================================================================
// ===============================================================================

// CAMP NAME
OPEX_friendly_camp = "Camp Lugdunum";
OPEX_friendly_army = localize "STR_friendly_army_france";

// SIGNS
OPEX_sign_camp = "pictures\sign_camp_fr.paa";
OPEX_sign_toc = "pictures\sign_toc_fr.paa";

if (isClass (configFile >> "CfgPatches" >> "rhsusf_weapons")) then {OPEX_friendly_sunglasses append ["rhs_googles_black", "rhs_googles_clear", "rhs_googles_orange", "rhs_googles_yellow"]};