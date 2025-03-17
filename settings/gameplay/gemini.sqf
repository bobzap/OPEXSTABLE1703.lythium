// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "Gemini_items"))) exitWith {};

//OPEX_medical_firstAidKit = "Gemini_fak";
OPEX_medical_defibrillator = "Gemini_defibrillator";

OPEX_cableTies = ["Gemini_cableTie"];

OPEX_bioScans = ["Gemini_bioscan"];
OPEX_spyMicros = ["Gemini_spyMicro"];

OPEX_canteenItems = ["Gemini_rationSmall", "Gemini_rationMedium", "Gemini_rationBig", "Gemini_bottleSmall", "Gemini_bottleMedium", "Gemini_bottleBig", "Gemini_apple", "Gemini_banana"];
OPEX_sleepingBags = ["Gemini_sleepingbag", "Gemini_portabletent"];

OPEX_civilian_items append ["Gemini_dattes", "Gemini_fig", "Gemini_banana", "Gemini_apple", "Gemini_bottleSmall", "Gemini_cigarettsMarlbara", "Gemini_cigarettsLocky", "Gemini_cigarettsCanel", "Gemini_matches", "Gemini_battery", "Gemini_adhesiveTape", "Gemini_pen", "Gemini_cellphone"];