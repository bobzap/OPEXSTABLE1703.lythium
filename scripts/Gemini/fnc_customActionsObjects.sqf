sleep 10; // necessary to let all objects initialization/conversion

// ==============================================
// DEFINING COLORS
// ==============================================

private _white	= 	"<t color='#FFFFFF'>";
private _red	= 	"<t color='#FF0000'>";
private _green 	= 	"<t color='#00A903'>";
private _orange =	"<t color='#EC9A00'>";

// ==============================================
// DEFINING COMMON ACTIONS
// ==============================================

private _read 	= {(_this select 0) addAction [(_this select 1) + localize "STR_action_read" + "</t>", {hintSilent localize (_this select 3 select 0)}, [_this select 2], 6, true, true, "", "_target distance _this < 3"]};
private _eat 	= {[(_this select 0), (_this select 1) + format [localize "STR_action_eat"] + "</t>", "pictures\icon_eat.paa", "pictures\icon_eat.paa", "(_target distance2D _this < 3)", "true", {}, {}, {call Gemini_fnc_eat}, {}, [], 3, 10, false, false] call BIS_fnc_holdActionAdd};
private _drink 	= {[(_this select 0), (_this select 1) + format [localize "STR_action_drink"] + "</t>", "pictures\icon_drink.paa", "pictures\icon_drink.paa", "(_target distance2D _this < 3)", "true", {}, {}, {call Gemini_fnc_drink}, {}, [], 3, 10, false, false] call BIS_fnc_holdActionAdd};
private _sit	= {[(_this select 0), (_this select 1) + localize "STR_action_sit" + "</t>", "pictures\icon_sit.paa", "pictures\icon_sit.paa", "(_target distance _this < 2) && (_target getVariable ['isAvailable', true]) && (!(_this getVariable ['isSitting', false]))", "true", {}, {}, {[_target,_caller] spawn Gemini_fnc_sitOnChair}, {}, [], 1, 6, false, false] call BIS_fnc_holdActionAdd};

// ==============================================
// SETTING COMMON OBJECTS
// ==============================================

private _players = []; {_players append [vehicleVarName _x]} forEach (allPlayers - entities "HeadlessClient_F");
private _monitors = [];

{switch (typeOf _x) do
	{
		// ------------------------------------------------
		// GATES
		// ------------------------------------------------
		case "Land_BarGate_F" :
			{
				_x setVariable ["R3F_LOG_disabled", true];
				[_x, "STR_marker_gate"] call Gemini_fnc_guidedTour2D;
			};

		// ------------------------------------------------
		// READABLE SIGNS
		// ------------------------------------------------
		case "SignAd_SponsorS_ARMEX_F" :
			{
				_x setVariable ["R3F_LOG_disabled", true];
				_x enableSimulation false;
				if (isServer) then {_x setPos (_x modelToWorld [0,0,-1.8])};
				if (["sign_toc", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_toc"] call _read};
				if (["sign_showers", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_showers"] call _read};
				if (["sign_medical", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_medicalCenter"] call _read};
				if (["sign_armory", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_armory"] call _read};
				if (["sign_ammo", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_ammoDepot"] call _read};
				if (["sign_canteen", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_canteen"] call _read};
				if (["sign_delivery", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_delivery"] call _read};
				if (["sign_dormitory", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_dormitory"] call _read};
				if (["sign_fitness", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_fitness"] call _read};
				if (["sign_fuel", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_fuel"] call _read};
				if (["sign_jail", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_jail"] call _read};
				if (["sign_practise", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_practise"] call _read};
				if (["sign_shooting", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_shooting"] call _read};
				if (["sign_training", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_training"] call _read};
				if (["sign_workshop", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_workshop"] call _read};
				if (["sign_recreation", (getObjectTextures _x) select 0] call BIS_fnc_inString) then {[_x, _white, "STR_marker_recreation"] call _read};
				_x setVectorUp (surfaceNormal (position _x));
				_x setVectorUp [0,0,1];
			};

		// ------------------------------------------------
		// MISSION SETTINGS
		// ------------------------------------------------
		case "Land_Laptop_03_black_F" :
			{
				if ((((getObjectTextures _x) select 1) find "settings") != -1) then
					{
						private _distance = "_target distance2D _this < 3";
						private _adminConditions = "(!isMultiplayer) || (serverCommandAvailable '#kick')";

						_x setVariable ["R3F_LOG_disabled", true];
						_x enableSimulation false;
						[_x, "STR_guide_object_settings"] call Gemini_fnc_guidedTour3D;

						// GUIDED TOUR
						[_x, _white + localize "STR_action_guidedTour" + "</t>", "pictures\icon_map.paa", "pictures\icon_map.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {call Gemini_fnc_guidedTour3D_switch}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;

						// CHECK MODS
						[_x, _orange + localize "STR_action_checkMods" + "</t>", "pictures\icon_check.paa", "pictures\icon_check.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {call Gemini_fnc_checkMods}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;

						// UPDATE RPT FILE (FOR DEBUG)
						[_x, _orange + localize "STR_action_updateRPT" + "</t>", "pictures\icon_log.paa", "pictures\icon_log.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {["update"] remoteExec ["Gemini_fnc_rpt", [_caller, 2]]}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;

						// SAVE
						[_x, _green + localize "STR_action_enableVanillaSave" + "</t>", "pictures\icon_save.paa", "pictures\icon_save.paa", _distance + "&& (OPEX_serverType != 'dedicated') && !savingEnabled && (count (profileNameSpace getVariable ['OPEX_' + worldName + '_persistentData_player', []]) == 0)", _adminConditions, {hint localize "STR_hint_saveWarning2"}, {}, {enableSaving [true, true]; hint localize "STR_hint_vanillaSaveEnabled"}, {}, [], 5, 10, false, false] call BIS_fnc_holdActionAdd;						
						[_x, _green + localize "STR_action_savePersistentData" + "</t>", "pictures\icon_save.paa", "pictures\icon_save.paa", _distance + "&& !savingEnabled", _adminConditions, {if !((!isMultiplayer) || (serverCommandAvailable '#kick')) then {hint localize "STR_hint_adminOnly"} else {if (OPEX_serverType != "dedicated") then {hint localize "STR_hint_saveWarning"}}}, {}, {"server" remoteExecCall ["Gemini_fnc_persistence_save", 2]}, {}, [], 5, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _green + localize "STR_action_savePersistentPlayer" + "</t>", "pictures\icon_save.paa", "pictures\icon_save.paa", _distance + "&& !savingEnabled", _distance, {if (OPEX_serverType != "dedicated") then {hint localize "STR_hint_saveWarning"}}, {}, {"client" remoteExecCall ["Gemini_fnc_persistence_save", player]}, {}, [], 5, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _green + localize "STR_action_savePersistentAll" + "</t>", "pictures\icon_save.paa", "pictures\icon_save.paa", _distance + "&& !savingEnabled", _adminConditions, {if !((!isMultiplayer) || (serverCommandAvailable '#kick')) then {hint localize "STR_hint_adminOnly"} else {if (OPEX_serverType != "dedicated") then {hint localize "STR_hint_saveWarning"}}}, {}, {"server" remoteExecCall ["Gemini_fnc_persistence_save", 2]; "client" remoteExecCall ["Gemini_fnc_persistence_save", player]}, {}, [], 5, 10, false, false] call BIS_fnc_holdActionAdd;
						//[_x, _green + localize "STR_action_savePersistentAll2" + "</t>", "pictures\icon_save.paa", "pictures\icon_save.paa", _distance, _adminConditions, {if !((!isMultiplayer) || (serverCommandAvailable '#kick')) then {hint localize "STR_hint_adminOnly"}}, {}, {"server" remoteExecCall ["Gemini_fnc_persistence_save", 2]; "client" remoteExecCall ["Gemini_fnc_persistence_save", -2]}, {}, [], 5, 10, false, false] call BIS_fnc_holdActionAdd;

						// RESET
						[_x, _red + localize "STR_action_resetPersistentData" + "</t>", "pictures\icon_reset.paa", "pictures\icon_reset.paa", _distance + "&& !savingEnabled", _adminConditions, {if !((!isMultiplayer) || (serverCommandAvailable '#kick')) then {hint localize "STR_hint_adminOnly"} else {hint localize "STR_hint_resetDataWarning"}}, {}, {"server" remoteExecCall ["Gemini_fnc_persistence_reset", 2]}, {}, [], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _red + localize "STR_action_resetPersistentPlayer" + "</t>", "pictures\icon_reset.paa", "pictures\icon_reset.paa", _distance + "&& !savingEnabled", _distance, {hint localize "STR_hint_resetPlayerWarning"}, {}, {"client" remoteExecCall ["Gemini_fnc_persistence_reset", player]}, {}, [], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _red + localize "STR_action_resetPersistentAll" + "</t>", "pictures\icon_reset.paa", "pictures\icon_reset.paa", _distance + "&& !savingEnabled", _adminConditions, {if !((!isMultiplayer) || (serverCommandAvailable '#kick')) then {hint localize "STR_hint_adminOnly"} else {hint localize "STR_hint_resetAllWarning"}}, {}, {"all" remoteExecCall ["Gemini_fnc_persistence_reset", [2, player]]}, {}, [], 10, 10, false, false] call BIS_fnc_holdActionAdd;
					};
			};

		// ------------------------------------------------
		// MISSION MANAGER
		// ------------------------------------------------
		case "Land_MapBoard_F" :
			{
				if ((((getObjectTextures _x) select 0) find "briefingboard") != -1) then
					{
						_x setVariable ["R3F_LOG_disabled", true];
						_x enableSimulation false;
						[_x, "STR_guide_object_main"] call Gemini_fnc_guidedTour3D;
						[_x, _white + localize "STR_action_taskManager" + "</t>", "pictures\icon_checklist.paa", "pictures\icon_checklist.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {_this execVM "scripts\Gemini\fnc_taskManagerDialog.sqf"}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + localize "STR_action_sitrep" + "</t>", "pictures\icon_stats.paa", "pictures\icon_stats.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {_this execVM "scripts\Gemini\fnc_sitrep.sqf"}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
					};
			};

		// ------------------------------------------------
		// BRIEFING SCREEN
		// ------------------------------------------------
		case "Land_BriefingRoomScreen_01_F" :
			{
				_x setVariable ["R3F_LOG_disabled", true];
				_x enableSimulation false;
				[_x, "STR_guide_object_slides"] call Gemini_fnc_guidedTour3D;
				[_x, _white + localize "STR_action_slide_sitrep" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_sitrep]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_objectives" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_objectives]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_intel" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_intel]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_roe" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_roe]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_strategy" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_strategy]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_questions" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_questions]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_debriefing" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, OPEX_briefingScreen_debriefing]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_off" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, ""]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_slide_drones" + "</t>", "pictures\icon_slideshow.paa", "pictures\icon_slideshow.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {(_this select 0) setObjectTextureGlobal [0, "pictures\monitorBig_drone2.paa"]}, {}, [], 0.1, 10, false, false] call BIS_fnc_holdActionAdd;
			};

		// ------------------------------------------------
		// FAST TRAVEL
		// ------------------------------------------------
		case "Land_MapBoard_01_Wall_Altis_F" :
			{
				if ((((getObjectTextures _x) select 0) find "mapboard_") != -1) then
					{
						_x setVariable ["R3F_LOG_disabled", true];
						_x enableSimulation false;
						if (OPEX_param_fastTravel == 1) then {[_x, "STR_guide_object_fastTravel"] call Gemini_fnc_guidedTour3D};
						[_x, _white + localize "STR_action_fastTravel_unit" + "</t>", "pictures\icon_travel.paa", "pictures\icon_travel.paa", "(_target distance2D _this < 3) && (OPEX_param_fastTravel == 1)", "_target distance2D _this < 3", {}, {}, {_this spawn Gemini_fnc_fastTravel}, {}, ["unit"], 1, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + localize "STR_action_fastTravel_group" + "</t>", "pictures\icon_travel.paa", "pictures\icon_travel.paa", "(_target distance2D _this < 3) && (OPEX_param_fastTravel == 1)", "_target distance2D _this < 3", {}, {}, {_this spawn Gemini_fnc_fastTravel}, {}, ["group"], 1, 10, false, false] call BIS_fnc_holdActionAdd;
					};
			};

		// ------------------------------------------------
		// SPECIALIZATION
		// ------------------------------------------------
		case "Land_MapBoard_01_Wall_F" :
			{
				if ((((getObjectTextures _x) select 0) find "specialization") != -1) then
					{
						[_x, "STR_guide_object_training"] call Gemini_fnc_guidedTour3D;
						_x setVariable ["R3F_LOG_disabled", true];
						_x enableSimulation false;
						[_x, _white + (localize "STR_action_trainingCheck") + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "_target distance2D _this < 3", "_target distance2D _this < 3", {}, {}, {if (_caller getUnitTrait "medic") then {hint localize "STR_hint_training_isMedic"}; if (_caller getUnitTrait "engineer") then {hint localize "STR_hint_training_isEngineer"}; if (_caller getUnitTrait "explosiveSpecialist") then {hint localize "STR_hint_training_isExplosiveSpecialist"}; if (_caller getUnitTrait "UAVHacker") then {hint localize "STR_hint_training_isUAVHacker"}; if (_caller getUnitTrait "interpret") then {hint localize "STR_hint_training_isInterpret"}; if ((!(_caller getUnitTrait "medic")) && (!(_caller getUnitTrait "engineer")) && (!(_caller getUnitTrait "explosiveSpecialist")) && (!(_caller getUnitTrait "UAVHacker")) && (!(_caller getUnitTrait "interpret"))) then {hint localize "STR_hint_training_none"}}, {}, ["medic"], 0.5, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + format [localize "STR_action_trainingMedic", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'medic')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'medic')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["medic"], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + format [localize "STR_action_trainingEngineer", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'engineer')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'engineer')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["engineer"], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + format [localize "STR_action_trainingExplosive", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'explosiveSpecialist')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'explosiveSpecialist')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["explosiveSpecialist"], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + format [localize "STR_action_trainingDrone", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'UAVHacker')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'UAVHacker')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["UAVHacker"], 10, 10, false, false] call BIS_fnc_holdActionAdd;
						[_x, _white + format [localize "STR_action_trainingInterpret", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa", "(_target distance2D _this < 3) && !(_this getUnitTrait 'interpret')", "(_target distance2D _this < 3) && !(_this getUnitTrait 'interpret')", {hint localize "STR_hint_training"}, {}, {_this execVM "scripts\Gemini\fnc_training.sqf"}, {}, ["interpret"], 10, 10, false, false] call BIS_fnc_holdActionAdd;
					};
			};

		// ------------------------------------------------
		// RECREATION HALL
		// ------------------------------------------------
		case "Land_SM_01_shed_F":
									{
										[_x, "STR_marker_recreation"] call Gemini_fnc_guidedTour2D;
										[_x, "STR_marker_recreation"] call Gemini_fnc_guidedTour3D;
									};
		case "Land_TripodScreen_01_dual_v2_black_F" :
			{
				if ((((getObjectTextures _x) select 0) find "ad_") != -1) then
					{
						[_x, "STR_guide_object_ads"] call Gemini_fnc_guidedTour3D;
						[_x, _white, "STR_hint_ads"] call _read;
					};
			};
		case "Land_Laptop_unfolded_F" :
			{
				if ((((getObjectTextures _x) select 0) find "laptop_opex") != -1) then
					{
						[_x, "STR_guide_object_ad_opex"] call Gemini_fnc_guidedTour3D;
						[_x, _white, "STR_hint_ad_opex"] call _read;
					};
			};

		// ------------------------------------------------
		// FIELD HOSPITAL
		// ------------------------------------------------

		case "Box_NATO_Equip_F" :
			{
				[_x, "STR_guide_object_heal"] call Gemini_fnc_guidedTour3D;
				[_x, _white + format [localize "STR_action_selfHeal", 5] + "</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa", "(_target distance2D _this < 3)", "(_target distance2D _this < 3)", {hint localize "STR_hint_healing"}, {}, {_caller setDamage 0}, {}, [], 10, 10, false, false] call BIS_fnc_holdActionAdd;

			};
		case "Land_Medevac_HQ_V1_F"	:
			{
				[_x, "STR_marker_medicalCenter"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_medicalCenter"] call Gemini_fnc_guidedTour3D;
				if (!isDedicated) exitWith {};
				_x spawn
					{
						while {true} do {playSound3D [OPEX_missionPath + "sounds\sfx\medicalCenter.ogg", _this, true, [getPos _this select 0, getPos _this select 1, (getPos _this select 2) - 2], 10, 1, 15]; sleep 17}
					};
			};

		// ------------------------------------------------
		// ARMORY
		// ------------------------------------------------
		case "B_CargoNet_01_ammo_F" :
			{
				[_x, "STR_marker_armory"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_armory"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------
		// AMMO DEPOT - (not usefull anymore because it's now very close to the armory)
		// ------------------------------------------------

		case "B_Slingload_01_Ammo_F" :
			{
				[_x, "STR_marker_ammoDepot"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_ammoDepot"] call Gemini_fnc_guidedTour3D;
				//[_x, "STR_guide_object_rearm"] call Gemini_fnc_guidedTour3D;
			};
		case "Box_NATO_AmmoVeh_F" :
			{
				//[_x, "STR_guide_object_rearm"] call Gemini_fnc_guidedTour3D;
			};


		// ------------------------------------------------------
		// DELIVERY AREA
		// ------------------------------------------------------
		case "Land_JumpTarget_F" :
			{
				[_x, "STR_guide_object_delivery"] call Gemini_fnc_guidedTour3D;
				_x setVariable ["R3F_LOG_disabled", true];
				_x enableSimulation false;
				OPEX_deliveryZone = _x;
				[_x, "STR_marker_delivery"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_delivery"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// CUSTODY SUITE (JAIL)
		// ------------------------------------------------------
		case "Land_ToiletBox_F" :
			{
				[_x, "STR_marker_jail"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_jail"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// WORKSHOP
		// ------------------------------------------------------
		case "Land_RepairDepot_01_green_F" :
			{
				//[_x, "STR_guide_object_repair"] call Gemini_fnc_guidedTour3D;
				_x setVariable ["R3F_LOG_disabled", true];
				[_x, "STR_marker_workshop"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_workshop"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// FUEL DEPOT
		// ------------------------------------------------------
		case "B_Slingload_01_Fuel_F" :
			{
				//[_x, "STR_guide_object_refuel"] call Gemini_fnc_guidedTour3D;
				_x setVariable ["R3F_LOG_disabled", true];
				[_x, "STR_marker_fuel"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_fuel"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// DORMITORY
		// ------------------------------------------------------
		case "Land_FMradio_F" :
			{
				[_x, "STR_marker_dormitory"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_dormitory"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// SHOWERS
		// ------------------------------------------------------
		case "WaterSpill_01_Medium_New_F" :
			{
				[_x, "STR_marker_showers"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_showers"] call Gemini_fnc_guidedTour3D;
				if (isDedicated) exitWith {};
				_x spawn
					{
						while {true} do
								{
									_this say3D ["shower", 15, 1, false];
									sleep (45 + random 30);
								};
					};
			};

		// ------------------------------------------------------
		// PRACTISE
		// ------------------------------------------------------
		case "PRACTISE_CLASS_TO_DEFINE" :
			{
				[_x, "STR_marker_practise"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_practise"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// SHOOTING RANGE
		// ------------------------------------------------------
		case "Land_MysteriousBell_01_F" :
			{
				[_x, "STR_marker_shooting"] call Gemini_fnc_guidedTour2D;
				[_x, "STR_marker_shooting"] call Gemini_fnc_guidedTour3D;
			};
		case "Target_PopUp4_Moving_F" :
			{
				if (isServer) then {_x setPosATL (_x modelToWorld [0,0,-1.30])};
				_x animate ["terc", 1];
				nopop = true;
				_x allowDamage false;
			};
		case "Hostage_PopUp_Moving_F" :
			{
				if (isServer) then {_x setPosATL (_x modelToWorld [0,0,-1.30])};
				_x animate ["terc", 1];
				nopop = true;
				_x allowDamage false;
			};
		case "Hostage_PopUp2_Moving_F" :
			{
				if (isServer) then {_x setPosATL (_x modelToWorld [0,0,-1.30])};
				_x animate ["terc", 1];
				nopop = true;
				_x allowDamage false;
			};
		case "Land_Laptop_03_sand_F" :
			{
				[_x, "STR_guide_object_shootingRange"] call Gemini_fnc_guidedTour3D;
				[_x, _white + localize "STR_action_shootingRange_start_easy" + "</t>", "pictures\icon_shooting.paa", "pictures\icon_shooting.paa", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", {}, {}, {["start", 7.5] spawn Gemini_fnc_shootingRange}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_shootingRange_start_medium" + "</t>", "pictures\icon_shooting.paa", "pictures\icon_shooting.paa", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", {}, {}, {["start", 5] spawn Gemini_fnc_shootingRange}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_shootingRange_start_hard" + "</t>", "pictures\icon_shooting.paa", "pictures\icon_shooting.paa", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", {}, {}, {["start", 2.5] spawn Gemini_fnc_shootingRange}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_shootingRange_down" + "</t>", "pictures\icon_shooting.paa", "pictures\icon_shooting.paa", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", {}, {}, {["down"] spawn Gemini_fnc_shootingRange}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + localize "STR_action_shootingRange_up" + "</t>", "pictures\icon_shooting.paa", "pictures\icon_shooting.paa", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", "(_target distance2D _this < 3) && (missionNamespace getVariable ['OPEX_shootingRange', true])", {}, {}, {["up"] spawn Gemini_fnc_shootingRange}, {}, [], 1, 10, false, false] call BIS_fnc_holdActionAdd;
			};

		// ------------------------------------------------------
		// CHAIRS
		// ------------------------------------------------------
		case "Land_CampingChair_V2_F" :
			{
				_x enableDynamicSimulation true;
				_x enableSimulation false;
				_x allowDamage false;
				_x setVariable ["R3F_LOG_disabled", false];
				[_x, _white] call _sit;
			};

		// ------------------------------------------------------
		// DONATERS TRIBUTE
		// ------------------------------------------------------
		case "SignAd_Sponsor_Blueking_F" :
			{
				if ((((getObjectTextures _x) select 0) find "thanks") != -1) then
					{
						_x setVariable ["R3F_LOG_disabled", true];
						_x enableSimulation false;
						if (isServer) then {_x setPos (_x modelToWorld [0,0,-1.25])};
						[_x, _white, "STR_hint_thanksDonations"] call _read;
					};
			};

		// ------------------------------------------------------
		// ARMORY CRATES
		// ------------------------------------------------------
		case "Box_NATO_Wps_F"	 	 : 	{[_x, "STR_crate_weapons"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_WpsLaunch_F"  : 	{[_x, "STR_crate_launchers"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_Ammo_F"		 : 	{[_x, "STR_crate_ammo"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_Support_F" 	 : 	{[_x, "STR_crate_accessories"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_Grenades_F" 	 : 	{[_x, "STR_crate_grenades"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_AmmoOrd_F" 	 : 	{[_x, "STR_crate_explosives"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_Uniforms_F" 	 : 	{[_x, "STR_crate_uniforms"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_NATO_WpsSpecial_F" : 	{[_x, "STR_crate_civilianClothes"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		case "Box_IDAP_Equip_F" 	 : 	{[_x, "STR_crate_food"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};
		//case "Box_NATO_Equip_F"		 : 	{[_x, "STR_crate_medicalEquipment"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", false]};

		// ------------------------------------------------------
		// FOOD
		// ------------------------------------------------------
		// EATABLE
		case "Fridge_01_open_F"				:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_Sacks_goods_F"			:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_Microwave_01_F"			:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_Wicker_basket_EP1"		:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_bags_EP1"				:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_transport_kiosk_EP1"		:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_stand_meat_EP1"			:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "Land_stand_small_EP1"			:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		case "jbad_stand_meat"				:	{[_x, "STR_action_eat"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _eat};
		// DRINKABLE
		case "Land_WaterCooler_01_new_F"	:	{[_x, "STR_action_drink"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _drink};
		case "Land_WaterCooler_01_old_F"	:	{[_x, "STR_action_drink"] call Gemini_fnc_guidedTour3D; _x setVariable ["R3F_LOG_disabled", true]; [_x, _white] call _drink};

		// TOC AMBIENT SOUND (OFFICE)
		case "Land_Printer_01_F"				:
													{
														if (isDedicated) exitWith {};
														_x spawn
															{
																while {true} do
																		{
																			_this say3D ["office", 20, 1, false];
																			sleep 97;
																		};
															};
													};

		// CANTEEN
		case "Land_i_Shed_Ind_F"	:
										{
											[_x, "STR_marker_canteen"] call Gemini_fnc_guidedTour2D;
											[_x, "STR_marker_canteen"] call Gemini_fnc_guidedTour3D;
										};
		case "Land_WaterBottle_01_empty_F"	:
												{
													if (isDedicated) exitWith {};
													_x spawn
														{
															while {true} do
																	{
																		_this say3D ["canteen", 20, 1, false];
																		sleep 39;
																	};
														};
												};

		// TOC AMBIENT SOUND (RADIO)
		case "Land_Router_01_black_F"		:
												{
													_x spawn
														{
															sleep (random 30);
															while {true} do
																	{
																		private _radioMessage = selectRandom ["radioChatter", "a3\sounds_f\sfx\radio\ambient_radio2.wss", "a3\sounds_f\sfx\radio\ambient_radio3.wss", "a3\sounds_f\sfx\radio\ambient_radio4.wss", "a3\sounds_f\sfx\radio\ambient_radio5.wss", "a3\sounds_f\sfx\radio\ambient_radio6.wss", "a3\sounds_f\sfx\radio\ambient_radio6.wss", "a3\sounds_f\sfx\radio\ambient_radio7.wss", "a3\sounds_f\sfx\radio\ambient_radio8.wss", "a3\sounds_f\sfx\radio\ambient_radio9.wss", "a3\sounds_f\sfx\radio\ambient_radio10.wss", "a3\sounds_f\sfx\radio\ambient_radio11.wss", "a3\sounds_f\sfx\radio\ambient_radio12.wss", "a3\sounds_f\sfx\radio\ambient_radio13.wss", "a3\sounds_f\sfx\radio\ambient_radio14.wss", "a3\sounds_f\sfx\radio\ambient_radio15.wss", "a3\sounds_f\sfx\radio\ambient_radio16.wss", "a3\sounds_f\sfx\radio\ambient_radio17.wss", "a3\sounds_f\sfx\radio\ambient_radio18.wss", "a3\sounds_f\sfx\radio\ambient_radio19.wss", "a3\sounds_f\sfx\radio\ambient_radio20.wss", "a3\sounds_f\sfx\radio\ambient_radio21.wss", "a3\sounds_f\sfx\radio\ambient_radio22.wss", "a3\sounds_f\sfx\radio\ambient_radio23.wss", "a3\sounds_f\sfx\radio\ambient_radio24.wss", "a3\sounds_f\sfx\radio\ambient_radio25.wss", "a3\sounds_f\sfx\radio\ambient_radio26.wss", "a3\sounds_f\sfx\radio\ambient_radio27.wss", "a3\sounds_f\sfx\radio\ambient_radio28.wss", "a3\sounds_f\sfx\radio\ambient_radio29.wss", "a3\sounds_f\sfx\radio\ambient_radio30.wss"];
																		//playSound3D [_radioMessage, _this, true, getPos _this, 5, 1, 10];

																		if (_radioMessage == "radioChatter") then {if (!isDedicated) then {_this say3D [_radioMessage, 10, 1, false]}; sleep 90} else {if (isDedicated) then {playSound3D [_radioMessage, _this, false, getPos _this, 5, 1, 15]}; sleep 10};
																		sleep (random 10);
																	};
														};
													};

		// WORKSHOP AMBIENT SOUND
		case "Land_CanisterOil_F"			:
												{
													if (isDedicated) exitWith {};
													_x spawn
														{
															while {true} do
																	{
																		_this say3D ["workshop", 20, 1, false];
																		sleep (91 + random 30);
																	};
														};
												};

		// LARGE MONITORS
		case "Land_TripodScreen_01_large_black_F"	:		{_monitors append [_x]; [_x, "STR_guide_object_lfc"] call Gemini_fnc_guidedTour3D};

		// JUKEBOX
		case "Land_PortableSpeakers_01_F" :
			{
				if (!isDedicated) exitWith {};
				_x spawn
					{
						private _musics =
								[
									["Unknown music 1", "A3\music_f_EPC\Music\C_EA_RadioMusic1.ogg", 52],
									["Unknown music 2", "A3\music_f_EPC\Music\C_EA_RadioMusic2.ogg", 72],
									["Unknown music 3", "A3\Missions_F_EPA\data\music\radio_music.ogg", 151]
								];
						while {true} do
							{
								for "_i" from 0 to (count _musics - 1) do
									{
										playSound3D [_musics select _i select 1, _this, true, getPos _this, 5, 1, 15];
										sleep (1 + (_musics select _i select 2));
									};
							};
					};
			};

		// REST
		case "Land_Sleeping_bag_F"	:
			{
				private _duration = 3;
				// SP
				[_x, _white + format [localize "STR_action_haveRest_1"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "(!isMultiplayer) && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [1], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_haveRest_3"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "(!isMultiplayer) && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_haveRest_6"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "(!isMultiplayer) && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [6], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_haveRest_9"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "(!isMultiplayer) && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [9], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_haveRest_12"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "(!isMultiplayer) && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [12], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				// MP
				[_x, _white + format [localize "STR_action_haveRest"] + "</t>", "pictures\icon_rest.paa", "pictures\icon_rest.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_skipTime_1"] + "</t>", "pictures\icon_time.paa", "pictures\icon_time.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [1], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_skipTime_3"] + "</t>", "pictures\icon_time.paa", "pictures\icon_time.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [3], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_skipTime_6"] + "</t>", "pictures\icon_time.paa", "pictures\icon_time.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [6], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_skipTime_9"] + "</t>", "pictures\icon_time.paa", "pictures\icon_time.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [9], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
				[_x, _white + format [localize "STR_action_skipTime_12"] + "</t>", "pictures\icon_time.paa", "pictures\icon_time.paa", "isMultiplayer && (_target distance2D _this < 3)", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [12], _duration, 6, false, false] call BIS_fnc_holdActionAdd;
			};

		// ------------------------------------------------------
		// PRACTISE
		// ------------------------------------------------------
		case "Land_FishingGear_01_F" :
			{
				[_x, "STR_marker_seaport"] call Gemini_fnc_guidedTour2D;
				//[_x, "STR_marker_seaport"] call Gemini_fnc_guidedTour3D;
			};

		// ------------------------------------------------------
		// DEFAULT
		// ------------------------------------------------------
		default {};
	};
} forEach (allMissionObjects "all");

// LIVE VIDEO FEED
if ((count _monitors > 0) && (count _players > 0)) then {null = [_monitors, _players] execVM "scripts\BangaBob\LFC\Feedinit.sqf"};

// ==============================================
// DEFINING AMMO BOXES ACTIONS
// ==============================================
private _crates = vehicles select {(typeOf _x) in ["Box_NATO_Wps_F", "Box_NATO_WpsLaunch_F", "Box_NATO_Ammo_F", "Box_NATO_Support_F", "Box_NATO_Grenades_F", "Box_NATO_Uniforms_F", "Box_NATO_AmmoOrd_F", "Box_NATO_WpsSpecial_F"]};
{
	// (TEMPORARY) ADDING ACTION TO AUTO ASSIGN CIVILIAN CLOTHES TO THE PLAYER (because ArmA doesn't allow military units to get other faction clothes manually through the inventory)
	if (typeOf _x == "Box_NATO_WpsSpecial_F") then 
		{
			[
				_x, ["STR_action_incognito", "white"],
				"pictures\icon_incognito.paa", "pictures\icon_incognito.paa",
				"_this distance _target < 3", "_caller distance _target < 3",
				{
					private _crate = _this select 0;
					private _unit = _this select 1;
					private _items = (vestItems _unit) + (uniformItems _unit);
					private _uniform = uniform _unit;
					private _vest = vest _unit;
					private _headgear = headgear _unit;
					{_crate addItemCargoGlobal [_x, 1]} forEach _items;
					if (!(_uniform in OPEX_civilian_uniforms)) then {_crate addItemCargoGlobal [_uniform, 1]};
					_crate addItemCargoGlobal [_vest, 1];
					if (!(_uniform in OPEX_civilian_headgears)) then {_crate addItemCargoGlobal [_headgear, 1]};
					removeUniform _unit;
					removeVest _unit;
					removeHeadgear _unit;
				},
				{},
				{
					private _crate = _this select 0;
					private _unit = _this select 1;
					_unit forceAddUniform (selectRandom OPEX_civilian_uniforms);
					_unit addHeadgear (selectRandom OPEX_civilian_headgears);
					hint localize "STR_hint_incognito";
				},
				{},
				[],
				5,
				5,
				false,
				false
			] call Gemini_fnc_holdActionAdd;
	};

	// ADDING CUSTOM ACTIONS IF GEAR MANAGEMENT IS SET TO UNLIMITED
	private ["_validCrates"];
	_validCrates = ["Box_NATO_Wps_F", "Box_NATO_WpsLaunch_F", "Box_NATO_Ammo_F", "Box_NATO_Support_F", "Box_NATO_Grenades_F", "Box_NATO_Uniforms_F", "Box_NATO_AmmoOrd_F", "Box_NATO_WpsSpecial_F"];
	if ((OPEX_param_gearManagement == 1) && ((typeOf _x) in _validCrates)) then
		{
			// VIRTUAL ARSENAL
			if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {[_x, true] call ace_arsenal_fnc_initBox};
			[
				_x,
				["STR_action_arsenal", "white"],
				"pictures\icon_weapon.paa", "pictures\icon_weapon.paa",
				"_target distance2D _this < 3", "_target distance2D _this < 3",
				{}, {},
				{if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {[_this select 3 select 0, player] call ace_arsenal_fnc_openBox} else {0 = ["Open", true] spawn BIS_fnc_arsenal}},
				{},
				[_x],
				1,
				10,
				false, false, false
			] call Gemini_fnc_holdActionAdd;

			// PRESET LOADOUTS
			private _duration = 5;
			private _priority = 1;
			if ((profileNameSteam) in ["Gemini", "gemini.69", "Kamih"]) then {[_x, ["STR_action_takePackage_custom", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "customed"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd};
			[_x, ["STR_action_takePackage_rifleman", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "rifleman"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_teamLeader", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "teamLeader"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_grenadier", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "grenadier"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_mgLight", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "mgLight"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_mgHeavy", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "mgHeavy"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_ammoAssistant", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "ammoAssistant"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_at", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "at"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_aa", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "aa"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_marksman", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "marksman"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_ghillieSniper", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "ghillieSniper"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_ghillieSpotter", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "ghillieSpotter"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_scout", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "scout"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_medic", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "medic"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_repairer", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "repairer"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_sapper", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "sapper"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_radioOperator", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "radioOperator"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_droneOperator", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "droneOperator"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_diver", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "diver"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_chopperPilot", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "chopperPilot"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_aircraftPilot", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "aircraftPilot"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
			[_x, ["STR_action_takePackage_crewman", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {["hint", "STR_hint_warning_equipmentReplacement"] remoteExec ["Gemini_fnc_globalHint", (_this select 1)]}, {}, {[_this select 1, "crewman"] execVM "scripts\Gemini\fnc_loadouts.sqf"}, {}, [_x], _duration, _priority, false, false, false] call Gemini_fnc_holdActionAdd;
		};

} forEach _crates,