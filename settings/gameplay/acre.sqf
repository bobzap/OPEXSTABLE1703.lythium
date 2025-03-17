// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) exitWith {};

// CHECKING IF TFAR IS INSTALLED (THESE MODS HAVE SAME GOAL SO HAVING BOTH IS USELESS)
if (!(isClass (configFile >> "CfgPatches" >> "task_force_radio"))) exitWith {};

// RADIOS
OPEX_friendly_radiosShortDistance = ["ACRE_PRC343"];
OPEX_friendly_radiosLongDistance = ["ACRE_PRC148"];