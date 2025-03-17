// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _caller = _this select 0;

// =========================================================================================================
// GETTING CONTROL IDs
// =========================================================================================================

	private _params_dialog = 1000;
	private _params_title = 1002;
	private _params_version = 10021;
	private _params_start = 1004;

	private _params_background = 1003;
	private _params_flag = 1001;

	private _params_friendlyFaction = 1100;
	private _params_friendlyFaction_list = 1101;
	private _params_enemyFaction = 1102;
	private _params_enemyFaction_list = 1103;
	private _params_taskManagement = 1104;
	private _params_taskManagement_list = 1105;
	private _params_gearManagement = 1106;
	private _params_gearManagement_list = 1107;
	private _params_supportManagement = 1108;
	private _params_supportManagement_list = 1109;
	private _params_medical = 1110;
	private _params_medical_list = 1111;
	private _params_restManagement = 1122;
	private _params_restManagement_list = 1123;
	private _params_primaryNeeds = 1112;
	private _params_primaryNeeds_list = 1113;
	private _params_fastTravel = 1114;
	private _params_fastTravel_list = 1115;
	private _params_intel = 1116;
	private _params_intel_list = 1117;
	private _params_dayTime = 1118;
	private _params_dayTime_list = 1119;
	private _params_timeMultiplier = 1120;
	private _params_timeMultiplier_list = 1121;

// =========================================================================================================
// DISPLAYING CUSTOM DIALOG INTERFACE
// =========================================================================================================

	//cutText ["", "black in", 10e10];
	//waitUntil {dialog};

	ctrlSetText [_params_title, toUpper localize "STR_mainTitle"];
	ctrlSetText [_params_version, format ["version %1", OPEX_version]];

	if (isMultiplayer) then {ctrlSetText [_params_friendlyFaction, localize "STR_params_friendlyFactionMP"]} else {ctrlSetText [_params_friendlyFaction, localize "STR_params_friendlyFactionSP"];};
	ctrlSetText [_params_enemyFaction, localize "STR_params_enemyFaction"];
	ctrlSetText [_params_taskManagement, localize "STR_params_taskManagement"];
	ctrlSetText [_params_gearManagement, localize "STR_params_gearManagement"];
	ctrlSetText [_params_supportManagement, localize "STR_params_supportManagement"];
	//ctrlSetText [_params_medical, localize "STR_params_medical"];
	ctrlSetText [_params_restManagement, localize "STR_params_restManagement"];
	ctrlSetText [_params_primaryNeeds, localize "STR_params_primaryNeeds"];
	ctrlSetText [_params_fastTravel, localize "STR_params_fastTravel"];
	ctrlSetText [_params_intel, localize "STR_params_intel"];
	ctrlSetText [_params_dayTime, localize "STR_params_dayTime"];
	ctrlSetText [_params_timeMultiplier, localize "STR_params_timeMultiplier"];

	disableSerialization;
	private _display =  _this select 0 select 0;
	//waitUntil {!isNil "OPEX_friendly_factions"};

// =========================================================================================================
// DISPLAYING PARAMETERS
// =========================================================================================================

	// FRIENDLY FACTION
	private ["_friendlyFaction_list"];
	_friendlyFaction_list = _display displayCtrl _params_friendlyFaction_list;
	OPEX_friendly_factions sort true;
	{_friendlyFaction_list lbAdd (localize (_x select 0) + " " + "(" + (_x select 1) + ")")} forEach OPEX_friendly_factions;
	lbSetCurSel [_params_friendlyFaction_list, 0];
	if (["STR_friendly_subFaction_Italy", "Pedagne"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Italy", "Pedagne"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Italy") + " (Pedagne)"};
	if (["STR_friendly_subFaction_Canada", "TFC"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Canada", "TFC"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Canada") + " (TFC)"};
	if (["STR_friendly_subFaction_UK", "BAF"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_UK", "BAF"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_UK") + " (BAF)"};
	if (["STR_friendly_subFaction_Germany", "CUP"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Germany", "CUP"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Germany") + " (CUP)"};
	if (["STR_friendly_subFaction_Germany", "BW"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Germany", "BW"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Germany") + " (BW)"};
	if (["STR_friendly_subFaction_Germany", "CFP + RnT"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Germany", "CFP + RnT"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Germany") + " (CFP + RnT)"};
	if (["STR_friendly_subFaction_Spain", "FFAA"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_Spain", "FFAA"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_Spain") + " (FFAA)"};
	if (["STR_friendly_subFaction_USA", "RHS"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_USA", "RHS"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_USA") + " (RHS)"};
	if (["STR_friendly_subFaction_France", "AMF"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "AMF"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (AMF)"};
	if (["STR_friendly_subFaction_France", "JackFrench"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "JackFrench"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (JackFrench)"};
	if (["STR_friendly_subFaction_France", "CUP"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "CUP"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (CUP)"};
	if (["STR_friendly_subFaction_France", "R3F"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "R3F"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (R3F)"};
	if (["STR_friendly_subFaction_France", "OFrP"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "OFrP"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (OFrP)"};
	if (["STR_friendly_subFaction_France", "OFrP + R3F + AMF"] in OPEX_friendly_factions) then {lbSetCurSel [_params_friendlyFaction_list, OPEX_friendly_factions find (["STR_friendly_subFaction_France", "OFrP + R3F + AMF"])]; OPEX_param_friendlyFaction = (localize "STR_friendly_subFaction_France") + " (OFrP + R3F + AMF)"};

	// ENEMY FACTION
	private ["_enemyFaction_list"];
	_enemyFaction_list = _display displayCtrl _params_enemyFaction_list;
	OPEX_enemy_factions sort true;
	{_enemyFaction_list lbAdd (localize (_x select 0) + " " + "(" + (_x select 1) + ")")} forEach OPEX_enemy_factions;
	lbSetCurSel [_params_enemyFaction_list, 0];
	if ((OPEX_mapEnemy == "ULTRA") && (["STR_enemy_name_ULTRA_4", "vanilla"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_ULTRA_4", "vanilla"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_ULTRA_4") + " (vanilla)"};
	if ((OPEX_mapEnemy == "ULTRA") && (["STR_enemy_name_ULTRA_4", "LOP"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_ULTRA_4", "LOP"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_ULTRA_4") + " (LOP)"};
	if ((OPEX_mapEnemy == "ULTRA") && (["STR_enemy_name_ULTRA_4", "RHS"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_ULTRA_4", "RHS"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_ULTRA_4") + " (RHS)"};
	if ((OPEX_mapEnemy == "TALIB") && (["STR_enemy_name_talib_4", "LOP"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_talib_4", "LOP"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_talib_4") + " (LOP)"};
	if ((OPEX_mapEnemy == "ISIS") && (["STR_enemy_name_ISIS_4", "LOP"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_ISIS_4", "LOP"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_ISIS_4") + " (LOP)"};
	if ((OPEX_mapEnemy == "BOKO") && (["STR_enemy_name_BOKO_4", "LOP"] in OPEX_enemy_factions)) then {lbSetCurSel [_params_enemyFaction_list, OPEX_enemy_factions find (["STR_enemy_name_BOKO_4", "LOP"])]; OPEX_param_enemyFaction = (localize "STR_enemy_name_BOKO_4") + " (LOP)"};

	// TASK MANAGEMENT
	private ["_taskManagement_list"];
	_taskManagement_list = _display displayCtrl _params_taskManagement_list;
	if (isMultiplayer)
		then
			{
				_taskManagement_list lbAdd localize "STR_params_admin";
				_taskManagement_list lbAdd localize "STR_params_leader";
				_taskManagement_list lbAdd localize "STR_params_everybody";
			}
		else {_taskManagement_list lbAdd localize "STR_params_player"};
	lbSetCurSel [_params_taskManagement_list, 0];

	// GEAR MANAGEMENT
	private ["_gearManagement_list"];
	_gearManagement_list = _display displayCtrl _params_gearManagement_list;
	_gearManagement_list lbAdd localize "STR_realistic";
	_gearManagement_list lbAdd localize "STR_unlimited";
	lbSetCurSel [_params_gearManagement_list, 0];

	// SUPPORT MANAGEMENT
	private ["_supportManagement_list"];
	_supportManagement_list = _display displayCtrl _params_supportManagement_list;
	_supportManagement_list lbAdd localize "STR_realistic";
	_supportManagement_list lbAdd localize "STR_unlimited";
	lbSetCurSel [_params_supportManagement_list, 0];

	// MEDICAL SYSTEM
	if (isNil "OPEX_param_medical") then {OPEX_param_medical = 0; publicVariable "OPEX_param_medical"};
	/*
	private ["_medical_list"];
	_medical_list = _display displayCtrl _params_medical_list;
	if (isClass (configFile >> "CfgPatches" >> "ace_medical"))
		then
			{
				_medical_list lbAdd localize "STR_params_medical_ace";
				lbSetCurSel [_params_medical_list, 0];
			}
		else
			{
				_medical_list lbAdd localize "STR_params_medical_ais";
				//_medical_list lbAdd localize "STR_params_medical_vanilla";
				lbSetCurSel [_params_medical_list, 0];
			};
	*/

	// REST MANAGEMENT
	private ["_restManagement_list"];
	_restManagement_list = _display displayCtrl _params_restManagement_list;
	if (isMultiplayer)
		then
			{
				_restManagement_list lbAdd localize "STR_params_admin";
				_restManagement_list lbAdd localize "STR_params_everybody";
			}
		else {_restManagement_list lbAdd localize "STR_params_player"};
	lbSetCurSel [_params_restManagement_list, 0];

	// PRIMARY NEEDS
	private ["_primaryNeeds_list"];
	_primaryNeeds_list = _display displayCtrl _params_primaryNeeds_list;
	_primaryNeeds_list lbAdd localize "STR_no";
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then {_primaryNeeds_list lbAdd localize "STR_yes"; lbSetCurSel [_params_primaryNeeds_list, 1]} else {lbSetCurSel [_params_primaryNeeds_list, 0]};

	// FAST TRAVEL
	private ["_fastTravel_list"];
	_fastTravel_list = _display displayCtrl _params_fastTravel_list;
	_fastTravel_list lbAdd localize "STR_no";
	_fastTravel_list lbAdd localize "STR_yes";
	if (OPEX_debug) then {lbSetCurSel [_params_fastTravel_list, 1]} else {lbSetCurSel [_params_fastTravel_list, 0]};

	// INTEL
	private ["_intel_list"];
	_intel_list = _display displayCtrl _params_intel_list;
	_intel_list lbAdd "0";
	_intel_list lbAdd "50";
	_intel_list lbAdd "100";
	_intel_list lbAdd "500";
	_intel_list lbAdd "1 000";
	_intel_list lbAdd "10 000";
	lbSetCurSel [_params_intel_list, 0];
	if (isMultiplayer) then {lbSetCurSel [_params_intel_list, 0]} else {lbSetCurSel [_params_intel_list, 2]};
	if (OPEX_debug) then {lbSetCurSel [_params_intel_list, 5]};

	// DAYTIME
	private ["_dayTime_list"];
	_dayTime_list = _display displayCtrl _params_dayTime_list;
	_dayTime_list lbAdd localize "STR_random";
	_dayTime_list lbAdd localize "STR_params_dayTime_morning";
	_dayTime_list lbAdd localize "STR_params_dayTime_noon";
	_dayTime_list lbAdd localize "STR_params_dayTime_evening";
	_dayTime_list lbAdd localize "STR_params_dayTime_night";
	if (OPEX_debug) then {lbSetCurSel [_params_dayTime_list, 2]} else {lbSetCurSel [_params_dayTime_list, 0]};

	// TIME MULTIPLIER
	private ["_timeMultiplier_list"];
	_timeMultiplier_list = _display displayCtrl _params_timeMultiplier_list;
	_timeMultiplier_list lbAdd "x1";
	_timeMultiplier_list lbAdd "x3";
	_timeMultiplier_list lbAdd "x6";
	_timeMultiplier_list lbAdd "x12";
	_timeMultiplier_list lbAdd "x24";
	lbSetCurSel [_params_timeMultiplier_list, 1];

// =========================================================================================================
// SETTING START BUTTON & VALIDATING CHOSEN PARAMETERS
// =========================================================================================================

	// START BUTTON
	ctrlSetText [_params_start, localize "STR_dialog_start"]; // order button
	buttonSetAction [_params_start, "closeDialog 0"];

	while {dialog} do
		{
			{
				if (((localize (_x select 0)) + " " + "(" + (_x select 1) + ")") == OPEX_param_friendlyFaction) then
					{
						switch (localize (_x select 0)) do
							{
								case (localize "STR_friendly_subFaction_USA")			:	{ctrlSetText [_params_flag, "pictures\params_us.paa"]};
								case (localize "STR_friendly_subFaction_France")		:	{ctrlSetText [_params_flag, "pictures\params_fr.paa"]};
								case (localize "STR_friendly_subFaction_Russia")		:	{ctrlSetText [_params_flag, "pictures\params_ru.paa"]};
								case (localize "STR_friendly_subFaction_Spain")			:	{ctrlSetText [_params_flag, "pictures\params_sp.paa"]};
								case (localize "STR_friendly_subFaction_UK")			:	{ctrlSetText [_params_flag, "pictures\params_uk.paa"]};
								case (localize "STR_friendly_subFaction_Germany")		:	{ctrlSetText [_params_flag, "pictures\params_ge.paa"]};
								case (localize "STR_friendly_subFaction_Czechia")		:	{ctrlSetText [_params_flag, "pictures\params_cz.paa"]};
								case (localize "STR_friendly_subFaction_Canada")		:	{ctrlSetText [_params_flag, "pictures\params_ca.paa"]};
								case (localize "STR_friendly_subFaction_Italy")			:	{ctrlSetText [_params_flag, "pictures\params_it.paa"]};
								default														{ctrlSetText [_params_flag, "pictures\params_default.paa"]};
							};
					}
			} forEach OPEX_friendly_factions;
		};

	waitUntil {!dialog};

	// UNLOCALIZING FACTION
	private _result = "";
	for "_i" from 0 to ((count OPEX_friendly_factions) - 1) do
		{
			private _localizedFaction = localize (OPEX_friendly_factions select _i select 0) + " (" + (OPEX_friendly_factions select _i select 1) + ")";
			private _unlocalizedFaction = [(OPEX_friendly_factions select _i select 0), (OPEX_friendly_factions select _i select 1)];
			if (OPEX_param_friendlyFaction == _localizedFaction) then {_result = _unlocalizedFaction};
		};

	OPEX_param_friendlyFaction = _result; publicVariable "OPEX_param_friendlyFaction";

	OPEX_params_ready = true; publicVariable "OPEX_params_ready";
	//if (!OPEX_intro) then {cutText ["", "black out", 10e10]};