// =========================================================================================================
// SERVER ONLY
// =========================================================================================================

	//if (!isServer) exitWith {};
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};

// =========================================================================================================
// SETTING LANGUAGE FOR UNITS
// =========================================================================================================

	// GETTING ALL UNITS
	private _unit = param [0, objNull, [objNull]];

	// DEFINING AVAILABLE VOICES
	private ["_greek", "_persian", "_englishUS", "_englishGB", "_englishGR", "_englishFR", "_french", "_chinese", "_russian", "_arabic", "_german", "_czech", "_italian"];
	_greek = ["Male01GRE", "Male02GRE", "Male03GRE", "Male04GRE", "Male05GRE"];
	_persian = ["Male01PER", "Male02PER", "Male03PER"];
	_englishUS = ["Male01ENG", "Male02ENG", "Male03ENG", "Male04ENG", "Male05ENG", "Male06ENG", "Male07ENG", "Male08ENG", "Male09ENG", "Male10ENG", "Male11ENG", "Male12ENG"];
	_englishGB = ["Male01ENGB", "Male02ENGB", "Male03ENGB", "Male04ENGB", "Male05ENGB"];
	_englishGR = ["Male01GRE", "Male02GRE", "Male03GRE", "Male04GRE", "Male05GRE", "Male06GRE"];
	_englishFR = ["Male02ENGFRE"];
	_french = ["Male01FRE"];
	_chinese = ["Male01CHI", "Male02CHI", "Male03CHI"];
	_russian = [];
	_arabic = [];
	_italian = _englishGR;
	if ((getText (configFile >> "CfgVoice" >> "CUP_D_Male01_CZ_ACR" >> "icon")) != "") then {_czech = ["cup_d_male01_cz_acr","cup_d_male02_cz_acr","cup_d_male03_cz_acr","cup_d_male04_cz_acr","cup_d_male05_cz_acr","cup_d_male01_cz","cup_d_male02_cz","cup_d_male03_cz","cup_d_male04_cz","cup_d_male05_cz"]} else {_czech = _englishGR};
	if ((getText (configFile >> "CfgVoice" >> "Male01RUS" >> "icon")) != "") then {_russian append ["Male01RUS", "Male02RUS", "Male03RUS"]};
	if ((getText (configFile >> "CfgVoice" >> "RHS_Male01RUS" >> "icon")) != "") then {_russian append ["RHS_Male01RUS","RHS_Male02RUS","RHS_Male03RUS","RHS_Male04RUS","RHS_Male05RUS"]};
	if ((count _russian == 0) && ((getText (configFile >> "CfgVoice" >> "CUP_D_Male01_RU" >> "icon")) != "")) then {_russian append ["CUP_D_Male01_RU","CUP_D_Male02_RU","CUP_D_Male03_RU","CUP_D_Male04_RU","CUP_D_Male05_RU"]};
	//if (isClass (configFile >> "CfgPatches" >> "rhsusf_weapons")) then {_russian = ["RHS_Male01RUS", "RHS_Male02RUS", "RHS_Male03RUS", "RHS_Male04RUS", "RHS_Male05RUS"]};
	if ((getText (configFile >> "CfgVoice" >> "CUP_D_Male01_TK" >> "icon")) != "") then {_arabic append ["CUP_D_Male01_TK","CUP_D_Male02_TK","CUP_D_Male03_TK","CUP_D_Male04_TK","CUP_D_Male05_TK"]};
	if (count _russian == 0) then {_russian = _englishGR};
	if (count _arabic == 0) then {_arabic = _persian};
	_german = _englishGR;
	_spanish = _englishGR;
	_russian = _russian;

	// SETTING
	private ["_speaker"];
	switch (side _unit) do
		{
			// LOGIC
			case sideLogic :
				{
					_speaker = "none";
				};

			// FRIENDS
			case OPEX_friendly_side1 :
				{
					switch OPEX_friendly_subFaction do
						{
							case "STR_friendly_subFaction_USA"		:	{_speaker = selectRandom _englishUS};
							case "STR_friendly_subFaction_France"	:	{_speaker = selectRandom _french};
							case "STR_friendly_subFaction_UK"		:	{_speaker = selectRandom _englishGB};
							case "STR_friendly_subFaction_Russia"	:	{_speaker = selectRandom _russian};
							case "STR_friendly_subFaction_Spain"	:	{_speaker = selectRandom _spanish};
							case "STR_friendly_subFaction_Germany"	:	{_speaker = selectRandom _german};
							case "STR_friendly_subFaction_China"	:	{_speaker = selectRandom _chinese};
							case "STR_friendly_subFaction_Czechia"	:	{_speaker = selectRandom _czech};
							case "STR_friendly_subFaction_Canada"	:	{_speaker = selectRandom _englishUS};
							case "STR_friendly_subFaction_Italy"	:	{_speaker = selectRandom _italian};
							default	 									{_speaker = selectRandom _englishUS};
						};
				};

			// ENEMIES
			case OPEX_enemy_side1 :
				{
					switch OPEX_enemy_fighters do
						{
							case "STR_enemy_fighters_TALIB"					:	{_speaker = selectRandom _arabic};
							case "STR_enemy_fighters_ISIS"					:	{_speaker = selectRandom _arabic};
							case "STR_enemy_fighters_BOKO"					:	{_speaker = selectRandom _french};
							case "STR_enemy_fighters_ULTRA"					:	{_speaker = selectRandom _greek};
							default	 											{_speaker = selectRandom _greek};
						};
				};

			// CIVILIANS
			case civilian :
				{
					switch OPEX_mapLanguage do
						{
							case "persian"		:	{_speaker = selectRandom _persian};
							case "arabic"		:	{_speaker = selectRandom _arabic};
							case "englishUS"	:	{_speaker = selectRandom _englishUS};
							case "englishGB"	:	{_speaker = selectRandom _englishGB};
							case "greek"		:	{_speaker = selectRandom _greek};
							case "englishFR"	:	{_speaker = selectRandom _englishFR};
							case "french"		:	{_speaker = selectRandom _french};
							case "chinese"		:	{_speaker = selectRandom _chinese};
							case "russian"		:	{_speaker = selectRandom _russian};
							case "german"		:	{_speaker = selectRandom _german};
							default	 				{_speaker = selectRandom _greek};
						};

				};

			// DEFAULT
			default {_speaker = "none"};
		};

	// STOPPING SCRIPT IF NO  SPEAKER IS REQUIRED (EXAMPLE: LOGIC OBJECTS)
	if (_speaker == "none") exitWith {};

	// ASSIGNING SELECTED VOICE
	[_unit, _speaker] remoteExecCall ["setSpeaker", 0, _unit];

	// AVOIDING AI UNITS TO SPEAK AFTER THEY'RE DEAD ???
	_unit addEventHandler ["killed", {[_this select 0, "NoVoice"] remoteExec ["setSpeaker", 0, _this select 0]}];