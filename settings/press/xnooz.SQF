// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "Xnooz_Press"))) exitWith {};

// SPECIAL STUFF
OPEX_press_cameras = ["XZ_CamRecorder_1"];
OPEX_press_photos = ["Xnooz_AppareilPhoto"];
OPEX_press_micros = ["Xnooz_micro2"];