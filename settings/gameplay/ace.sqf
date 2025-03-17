// CHECKING IF MOD IS INSTALLED
if (!(isClass (configFile >> "CfgPatches" >> "ace_main"))) exitWith {};

// FRIENDLY
if (isClass (configFile >> "CfgPatches" >> "ace_grenades")) then {OPEX_friendly_chemlights append ["ACE_HandFlare_Green", "ACE_HandFlare_White", "ACE_HandFlare_Yellow", "ACE_HandFlare_Red"]};
if (isClass (configFile >> "CfgPatches" >> "ace_grenades")) then {OPEX_friendly_stunGrenades append ["ACE_M84"]};
if (isClass (configFile >> "CfgPatches" >> "ace_explosives")) then {OPEX_friendly_explosives append ["ACE_DefusalKit", "ACE_Clacker", "APERSMineDispenser_Mag", "ACE_FlareTripMine_Mag", "DemoCharge_Remote_Mag", "ATMine_Range_Mag", "SatchelCharge_Remote_Mag", "ClaymoreDirectionalMine_Remote_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "APERSTripMine_Wire_Mag", "APERSMine_Range_Mag"]};
if (isClass (configFile >> "CfgPatches" >> "ace_hearing")) then {OPEX_friendly_earplugs append ["ACE_EarPlugs"]};
if (isClass (configFile >> "CfgPatches" >> "ace_attach")) then {OPEX_friendly_IRs append ["ACE_IR_Strobe_Item"]};
if (!(isClass (configFile >> "CfgPatches" >> "Gemini_items"))) then {if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {OPEX_cableTies append ["ACE_CableTie"]}};
if (isClass (configFile >> "CfgPatches" >> "ace_tagging")) then {OPEX_friendly_paintSprays append ["ACE_SpraypaintBlack", "ACE_SpraypaintRed", "ACE_SpraypaintGreen", "ACE_SpraypaintBlue"]};
if (isClass (configFile >> "CfgPatches" >> "ace_maptools")) then {OPEX_friendly_mapTools append ["ACE_MapTools"]};
if (isClass (configFile >> "CfgPatches" >> "ace_rangecard")) then {OPEX_friendly_rangeCards append ["ACE_RangeCard", "ACE_RangeTable_82mm"]};
if (isClass (configFile >> "CfgPatches" >> "ace_atragmx")) then {OPEX_friendly_sniperPDAs append ["ACE_ATragMX"]};
if (isClass (configFile >> "CfgPatches" >> "ace_kestrel4500")) then {OPEX_friendly_weatherPDAs append ["ACE_Kestrel4500"]};
if (isClass (configFile >> "CfgPatches" >> "ace_yardage450")) then {OPEX_friendly_laserDesignators append ["ACE_Yardage450"]};
if (isClass (configFile >> "CfgPatches" >> "ace_scopes")) then {OPEX_friendly_spotterBinoculars append ["ACE_SpottingScope"]};
if (isClass (configFile >> "CfgPatches" >> "ace_vector")) then {OPEX_friendly_spotterBinoculars append ["ACE_Vector"]};
if (isClass (configFile >> "CfgPatches" >> "ace_microdagr")) then {OPEX_friendly_advancedGPS append ["ACE_microDAGR"]};
if (isClass (configFile >> "CfgPatches" >> "ace_sandbag")) then {OPEX_friendly_sandbags append ["ACE_Sandbag_empty"]};
if (isClass (configFile >> "CfgPatches" >> "ace_tripod")) then {OPEX_friendly_tripods append ["ACE_Tripod"]};
if (isClass (configFile >> "CfgPatches" >> "ace_huntir")) then {OPEX_friendly_HuntIRs append ["ACE_HuntIR_monitor"]};
if (isClass (configFile >> "CfgPatches" >> "ace_minedetector")) then {OPEX_friendly_mineDetectors append ["ACE_VMH3", "ACE_VMM3"]};
if (isClass (configFile >> "CfgPatches" >> "ace_parachute")) then {OPEX_friendly_altimeters append ["ACE_Altimeter"]};
if (isClass (configFile >> "CfgPatches" >> "ace_tacticalladder")) then {OPEX_friendly_ladders append ["ACE_TacticalLadder_Pack","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope36"]};
if (isClass (configFile >> "CfgPatches" >> "ace_mx2a")) then {OPEX_friendly_commonBinoculars append ["ACE_MX2A"]};
if (isClass (configFile >> "CfgPatches" >> "ace_chemlights")) then {OPEX_friendly_chemlights append ["ACE_Chemlight_IR", "ACE_Chemlight_White", "ACE_Chemlight_Orange", "ACE_Chemlight_HiWhite", "ACE_Chemlight_HiYellow", "ACE_Chemlight_HiRed", "ACE_Chemlight_HiOrange"]};

// COMMON
if (isClass (configFile >> "CfgPatches" >> "ace_trenches")) then {OPEX_entrenchingTools append ["ACE_EntrenchingTool"]};
if (isClass (configFile >> "CfgPatches" >> "ace_concertina_wire")) then {OPEX_ConcertinaWireCoils append ["ACE_ConcertinaWireCoil"]};
if (isClass (configFile >> "CfgPatches" >> "logistics_wirecutter")) then {OPEX_wireCutters append ["ACE_wirecutter"]};
if (isClass (configFile >> "CfgPatches" >> "ace_flashlights")) then {OPEX_flashlights append ["ACE_Flashlight_MX991", "ACE_Flashlight_KSF1", "ACE_Flashlight_XL50"]};

// ENEMY
if (isClass (configFile >> "CfgPatches" >> "ace_explosives")) then {OPEX_enemy_explosives append ["ACE_Cellphone", "ACE_Clacker", "ACE_M26_Clacker", "ACE_DeadManSwitch"]};

// MEDICAL
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then
  {
    OPEX_medical_firstAidKit = "ACE_personalAidKit";
    OPEX_medical_commonSupplies = ["ACE_morphine", "ACE_epinephrine", "ACE_atropine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage"];
    OPEX_medical_advancedSupplies = ["ACE_tourniquet", "ACE_surgicalKit", "ACE_quikclot", "ACE_bloodIV_250", "ACE_bloodIV_500", "ACE_bloodIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_plasmaIV", "ACE_salineIV_250", "ACE_salineIV_500", "ACE_salineIV", "ACE_bodyBag", "ACE_splint"];
    //OPEX_medical_supplies = OPEX_medical_medikits + OPEX_medical_firstAidKit + OPEX_medical_defibrillator + OPEX_medical_commonSupplies + OPEX_medical_advancedSupplies;
    OPEX_medical_supplies = [OPEX_medical_firstAidKit] + OPEX_medical_commonSupplies + OPEX_medical_advancedSupplies;
  };