// =========================================================================================================
// INITIALIZING CLIENT
// =========================================================================================================

	// WAITING FOR PLAYER
	waitUntil {(!isNull player) && (player == player)};
	[player] joinSilent grpNull;
	//waitUntil {time > 0};

	// WAITING FOR MISSION START
	//waitUntil {getClientState == "BRIEFING READ"};

	// DISPLAYING BLACK SCREEN AND MUTING SOUND
	//0 fadeSound 0;
	//cutText ["", "black in", 10e10];

	// DELETING USELESS PLAYABLE UNITS (IN SP)
	if (!isMultiplayer) then {{deleteVehicle _x} forEach (playableUnits + switchableUnits)};

// =========================================================================================================
// CHECKING INSTALLED MODS
// =========================================================================================================

	{OPEX_serverMods = (configSourceModList (configFile >> "CfgPatches")); publicVariable "OPEX_serverMods"} remoteExecCall ["BIS_fnc_call", 2]; waitUntil {!isNil "OPEX_serverMods"}; OPEX_serverMods sort true;
	{OPEX_clientMods = (configSourceModList (configFile >> "CfgPatches"))} remoteExecCall ["BIS_fnc_call", player]; waitUntil {!isNil "OPEX_clientMods"}; OPEX_clientMods sort true;
	if (count (OPEX_serverMods - OPEX_clientMods) > 0) then {hintC format [localize "STR_hint_warningMissingMods", OPEX_serverMods - OPEX_clientMods]};

// =========================================================================================================
// DISPLAYING IMPORTANT INFORMATION AT STARTUP (WARNING, TIP, UPDATE INFO...)
// =========================================================================================================

	waitUntil {!isNil "OPEX_updateNotice"};
	if (OPEX_updateNotice select 0) then
		{
			private ["_current", "_old"];
			_current = OPEX_updateNotice select 1;
			if (isNil {profileNamespace getVariable "OPEX_updateNotice"})
				then
					{
						sleep 2;
						hintC (localize "STR_hint_updateNotice");
						profileNamespace setVariable ["OPEX_updateNotice", _current];
						saveProfileNamespace;
						sleep 0.01;
						hintSilent "";
						if (isMultiplayer) then {sleep 8} else {sleep 2};
					}
				else
					{
						_old = profileNamespace getVariable "OPEX_updateNotice";
						if (_current > _old) then
							{
								sleep 2;
								hintC (localize "STR_hint_updateNotice");
								profileNamespace setVariable ["OPEX_updateNotice", _current];
								saveProfileNamespace;
								sleep 0.01;
								hintSilent "";
								if (isMultiplayer) then {sleep 8} else {sleep 2};
							};
					};
		};

// =========================================================================================================
// CHECKING IF PERSISTENT DATA EXISTS FOR THE CLIENT
// =========================================================================================================

	if ("client" call Gemini_fnc_persistence_exists)
	then
		{
			"client" spawn Gemini_fnc_persistence_resume;
		}
	else
		{
			"client" spawn Gemini_fnc_persistence_new;
			waitUntil {!isNil "Gemini_fnc_initStatsPlayer"}; call Gemini_fnc_initStatsPlayer;
			if (isMultiplayer)
				then {if ((getPlayerUID player) in ["76561198076257522"]) then {[player] spawn Gemini_fnc_loadouts} else {[player] spawn Gemini_fnc_loadouts}}
				else {if ((profileNameSteam) in ["gemini.69", "Gemini", "Kamih"]) then {[player] spawn Gemini_fnc_loadouts} else {[player] spawn Gemini_fnc_loadouts}};
		};

// =========================================================================================================
// DISPLAYING SETUP MENU (IF THE MISSION HASN'T BEEN SET ALREADY)
// =========================================================================================================

	0 cutText [localize "STR_hint_waitForInit", "black in", 10e10];
	sleep 5;
	if (isNil "OPEX_params_ready")
	then
		{
			{OPEX_persistentSave = "server" call Gemini_fnc_persistence_exists; publicVariable "OPEX_persistentSave"} remoteExecCall ["BIS_fnc_call", 2];
			waitUntil {!isNil "OPEX_persistentSave"};
			if (!OPEX_persistentSave)
				then
					{
						if (isMultiplayer) then {0 cutText ["", "black in", 10e10]; sleep 1; 0 cutText [localize "STR_hint_waitForParams", "black in", 10e10]; sleep 3; waitUntil {(serverCommandAvailable "#kick") || (count (allPlayers - entities "HeadlessClient_F") == 1) || (!isNil "OPEX_params_ready")}};
						if ((isNil "OPEX_params_ready") && ((serverCommandAvailable "#kick") || (count (allPlayers - entities "HeadlessClient_F") == 1))) then {0 cutText ["", "black in", 10e10]; sleep 1; createDialog "OPEX_params"};
					}
				else
					{
						sleep 2;
						0 cutText ["", "black in", 10e10];
						sleep 2;
					};
			waitUntil {!isNil "OPEX_params_ready"};
		}
	else {0 cutText ["", "black in", 10e10]; sleep 2};

// =========================================================================================================
// INITIALIZING PLAYER
// =========================================================================================================

	// INITIALIZING DIARY
	execVM "diary.sqf";

	// ADDING WHEEL ACTIONS
	[player] spawn Gemini_fnc_customActionsPlayer;

	// INITIALIZING PLAYER'S STANCE
	player setVariable ["isSitting", false, true];
	player switchMove "";

	// INITIALIZING PLAYER HIGH COMMAND
	[] spawn {waitUntil {!isNil "OPEX_introFinished"}; waitUntil {OPEX_introFinished}; sleep 1; hcRemoveAllGroups player};

	// INITIALIZING DYNAMIC GROUPS
	["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

	// INITIALIZING TEAM SWITCH FEATURE (ONLY WORKS IN SP)
	enableTeamSwitch true;
	addMissionEventHandler
	[
		"TeamSwitch",
		{
			if (leader (_this select 0) == (_this select 0)) then {(group (_this select 0)) selectLeader (_this select 1)};
			execVM "diary.sqf";
			execVM "scripts\Gemini\fnc_JIP_getCurrentTask.sqf";
			execVM "scripts\Gemini\fnc_JIP_getCurrentSupports.sqf";
			(_this select 0) setVariable ["customActionsReady", false, true];
			[_this select 1] spawn Gemini_fnc_customActionsPlayer;
			if (OPEX_assignedTask) then {(_this select 0) setVariable ["assignedTask",true]} else {(_this select 0) setVariable ["assignedTask",false]};
		}
	];

// =========================================================================================================
// STARTING INTRO
// =========================================================================================================

	if (OPEX_intro) then {OPEX_introFinished = false} else {OPEX_introFinished = true; 0 cutText ["", "black out", 10e10]};
	execVM "scripts\Gemini\sqf_intro.sqf";
	waitUntil {!isNil "OPEX_introFinished"}; waitUntil {OPEX_introFinished};
	//waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
	//waitUntil {!isNil "OPEX_variables_ready"}; waitUntil {OPEX_variables_ready};
	disableUserInput false;

// =========================================================================================================
// GETTING CURRENT TASKS AND SUPPORTS (FOR JIP PLAYERS)
// =========================================================================================================

	execVM "scripts\Gemini\fnc_JIP_getCurrentTask.sqf";
	execVM "scripts\Gemini\fnc_JIP_getCurrentSupports.sqf";

// =========================================================================================================
// FIXING DOOR BUG ON KUNDUZ AND LYTHIUM MAP (thanks to BADBENSON and JOHNNY DRAMA: https://steamcommunity.com/sharedfiles/filedetails/?id=897711455)
// useless since https://steamcommunity.com/workshop/filedetails/?id=1623903743
// =========================================================================================================

	//if ((worldName == "Kunduz") || (worldName == "lythium")) then {execVM "scripts\badbenson\OpenDoor.sqf"};

// =========================================================================================================
// FINISHING MISSION INITALIZATION
// =========================================================================================================

	if (!OPEX_intro) then {5 fadeSound 1; enableRadio true};