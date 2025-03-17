// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "task_force_radio"))) exitWith {};

// RADIOS
OPEX_friendly_radiosShortDistance = ["tf_anprc152"];
OPEX_friendly_radiosLongDistance = ["tf_rt1523g_green"];