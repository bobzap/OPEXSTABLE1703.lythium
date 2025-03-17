/*
	This script saves several data into the RPT file, for OPEX debugging.
	In case of issue, user can send his RPT file to gemini.69@free.fr
	For more information about the RPT file, please visit: https://community.bistudio.com/wiki/arma.RPT
*/

	waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
	waitUntil {!isNil "OPEX_persistentData_server"}; waitUntil {count OPEX_persistentData_server > 1};
	waitUntil {!isNil "OPEX_param_medical"}; // temp - because this variable is currently disabled in the settings screen at startup
	waitUntil {!isNil "OPEX_friendly_radioBackpacks"};

// --------------------------------------------------------------------------------
// GETTING DATA FROM THE SERVER
// --------------------------------------------------------------------------------

	if (isServer) then
		{
			if (isDedicated) then {OPEX_serverType = "dedicated"} else {if (isMultiplayer) then {OPEX_serverType = "local"} else {OPEX_serverType = "n/a"}}; publicVariable "OPEX_serverType";
			OPEX_gameVersion_server = productVersion; publicVariable "OPEX_gameVersion_server";
			OPEX_version_server = OPEX_version; publicVariable "OPEX_version_server";
			OPEX_foundPersistentData_server = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_server", []]; publicVariable "OPEX_foundPersistentData_server";
			OPEX_foundPersistentStats_server = profileNameSpace getVariable ["OPEX_" + worldName + "_persistentStats_server", []]; publicVariable "OPEX_foundPersistentStats_server";
			OPEX_assignedTask_server = OPEX_assignedTask; publicVariable "OPEX_assignedTask_server";
			OPEX_taskID_server = OPEX_taskID; publicVariable "OPEX_taskID_server";
			OPEX_taskDescription_server = OPEX_taskDescription; publicVariable "OPEX_taskDescription_server";
			OPEX_ambientCivilianBoats_server= OPEX_ambientCivilianBoats; publicVariable "OPEX_ambientCivilianBoats_server";
			OPEX_ambientCivilianCars_server = OPEX_ambientCivilianCars; publicVariable "OPEX_ambientCivilianCars_server";
			OPEX_ambientEnemyAmbushes_server = OPEX_ambientEnemyAmbushes; publicVariable "OPEX_ambientEnemyAmbushes_server";
			OPEX_ambientEnemyBivouacs_server = OPEX_ambientEnemyBivouacs; publicVariable "OPEX_ambientEnemyBivouacs_server";
			OPEX_ambientEnemyCaches_server = OPEX_ambientEnemyCaches; publicVariable "OPEX_ambientEnemyCaches_server";
			OPEX_ambientEnemyGarrisons_server = OPEX_ambientEnemyGarrisons; publicVariable "OPEX_ambientEnemyGarrisons_server";
			OPEX_ambientEnemyIEDs_server = OPEX_ambientEnemyIEDs; publicVariable "OPEX_ambientEnemyIEDs_server";
			OPEX_ambientEnemyPatrols_server = OPEX_ambientEnemyPatrols; publicVariable "OPEX_ambientEnemyPatrols_server";
			OPEX_ambientEnemyReinforcements_server = OPEX_ambientEnemyReinforcements; publicVariable "OPEX_ambientEnemyReinforcements_server";
			OPEX_ambientEnemyRoadblock_server = OPEX_ambientEnemyRoadblock; publicVariable "OPEX_ambientEnemyRoadblock_server";
			OPEX_ambientFriendlyAir_server = OPEX_ambientFriendlyAir; publicVariable "OPEX_ambientFriendlyAir_server";
			OPEX_ambientFriendlyBoats_server = OPEX_ambientFriendlyBoats; publicVariable "OPEX_ambientFriendlyBoats_server";
			OPEX_ambientFriendlyPatrols_server = OPEX_ambientFriendlyPatrols; publicVariable "OPEX_ambientFriendlyPatrols_server";
			OPEX_ambientFriendlyRoadblock_server = OPEX_ambientFriendlyRoadblock; publicVariable "OPEX_ambientFriendlyRoadblock_server";
			OPEX_incomingSupport_server = OPEX_incomingSupport; publicVariable "OPEX_incomingSupport_server";
			OPEX_support_suppliesDrop_server = OPEX_support_suppliesDrop; publicVariable "OPEX_support_suppliesDrop_server";
			OPEX_support_vehicleDrop_server = OPEX_support_vehicleDrop; publicVariable "OPEX_support_vehicleDrop_server";
			OPEX_support_airStrike_server = OPEX_support_airStrike; publicVariable "OPEX_support_airStrike_server";
			OPEX_support_artilleryStrike_server = OPEX_support_artilleryStrike; publicVariable "OPEX_support_artilleryStrike_server";
			OPEX_support_airAssistance_server = OPEX_support_airAssistance; publicVariable "OPEX_support_airAssistance_server";
			OPEX_support_landAssistance_server = OPEX_support_landAssistance; publicVariable "OPEX_support_landAssistance_server";
			OPEX_support_transport_server = OPEX_support_transport; publicVariable "OPEX_support_transport_server";
			OPEX_persistentData_server_server = OPEX_persistentData_server; publicVariable "OPEX_persistentData_server_server";
			OPEX_friendly_commonUniforms_server = OPEX_friendly_commonUniforms; publicVariable "OPEX_friendly_commonUniforms_server";
			OPEX_friendly_specialUniforms_server = OPEX_friendly_specialUniforms; publicVariable "OPEX_friendly_specialUniforms_server";
			OPEX_friendly_commonVests_server = OPEX_friendly_commonVests; publicVariable "OPEX_friendly_commonVests_server";
			OPEX_friendly_specialVests_server = OPEX_friendly_specialVests; publicVariable "OPEX_friendly_specialVests_server";
			OPEX_friendly_commonHelmets_server = OPEX_friendly_commonHelmets; publicVariable "OPEX_friendly_commonHelmets_server";
			OPEX_friendly_commonRifles_server = OPEX_friendly_commonRifles; publicVariable "OPEX_friendly_commonRifles_server";
			OPEX_friendly_commonHandguns_server = OPEX_friendly_commonHandguns; publicVariable "OPEX_friendly_commonHandguns_server";
			OPEX_friendly_closeCombatOptics_server = OPEX_friendly_closeCombatOptics; publicVariable "OPEX_friendly_closeCombatOptics_server";
			OPEX_medical_supplies_server = OPEX_medical_supplies; publicVariable "OPEX_medical_supplies_server";
			OPEX_enemy_commonUniforms_server = OPEX_enemy_commonUniforms; publicVariable "OPEX_enemy_commonUniforms_server";
			OPEX_enemy_commonRifles_server = OPEX_enemy_commonRifles; publicVariable "OPEX_enemy_commonRifles_server";
			OPEX_enemy_specialRifles_server = OPEX_enemy_specialRifles; publicVariable "OPEX_enemy_specialRifles_server";
			OPEX_enemy_motorizedVehicles_server = OPEX_enemy_motorizedVehicles; publicVariable "OPEX_enemy_motorizedVehicles_server";
			OPEX_friendly_transportTrucksCovered_woodland_server = OPEX_friendly_transportTrucksCovered_woodland; publicVariable "OPEX_friendly_transportTrucksCovered_woodland_server";
			OPEX_friendly_transportCars_woodland_server = OPEX_friendly_transportCars_woodland; publicVariable "OPEX_friendly_transportCars_woodland_server";
			OPEX_friendly_combatCarsMG_woodland_server = OPEX_friendly_combatCarsMG_woodland; publicVariable "OPEX_friendly_combatCarsMG_woodland_server";
			OPEX_friendly_vtt_woodland_server = OPEX_friendly_vtt_woodland; publicVariable "OPEX_friendly_vtt_woodland_server";
			OPEX_friendly_tanks_woodland_server = OPEX_friendly_tanks_woodland; publicVariable "OPEX_friendly_tanks_woodland_server";
			OPEX_friendly_smallTransportHelicopters_woodland_server = OPEX_friendly_smallTransportHelicopters_woodland; publicVariable "OPEX_friendly_smallTransportHelicopters_woodland_server";
			OPEX_friendly_bigTransportHelicopters_woodland_server = OPEX_friendly_bigTransportHelicopters_woodland; publicVariable "OPEX_friendly_bigTransportHelicopters_woodland_server";
			OPEX_fps_server = diag_fps; publicVariable "OPEX_fps_server";
		};

// --------------------------------------------------------------------------------
// WAITING FOR DATA SYNCRONIZATION AND EXECUTING SCRIPT ON CLIENT ONLY
// --------------------------------------------------------------------------------

	if (isDedicated) exitWith {};
	waitUntil {!isNil "OPEX_fps_server"};

// --------------------------------------------------------------------------------
// UPDATING RPT
// --------------------------------------------------------------------------------

	diag_log "";
	diag_log "";
	diag_log "";
	diag_log "";
	diag_log "";
	diag_log "===========================================================================================================================================";
	diag_log " ********** OPEX RPT ********** to report any issue with OPEX, please send this file to gemini.69@free.fr                                  ";
	diag_log "===========================================================================================================================================";

	diag_log "";
	diag_log "[PLAYER]";
	diag_log format ["   - PROFILE : %1", name player];
	diag_log format ["   - STEAM : %1", profileNameSteam];

	diag_log "";
	diag_log "[GAME]";
	diag_log format ["   - TYPE : %1", if (isMultiplayer) then {"MP"} else {"SP"}];
	diag_log format ["   - SERVER : %1", OPEX_serverType];
	diag_log format ["   - VERSION (HOST) :   %1", OPEX_gameVersion_server];
	diag_log format ["   - VERSION (CLIENT) : %1", productVersion];

	diag_log "";
	diag_log "[MODS]";
	diag_log format ["   - HOST :   %1 %2", count OPEX_serverMods, OPEX_serverMods];
	diag_log format ["   - CLIENT : %1 %2", count OPEX_clientMods, OPEX_clientMods];
	diag_log format ["   - MISSING MODS ON CLIENT SIDE : %1", if (count (OPEX_serverMods - OPEX_clientMods) == 0) then {"none"} else {OPEX_serverMods - OPEX_clientMods}];

	diag_log "";
	diag_log "[MISSION]";
	diag_log format ["   - MAP : %1", worldName];
	diag_log format ["   - VERSION : %1 (%2)", OPEX_version, OPEX_version_server];
	diag_log format ["   - TIME : %1 (%2)", [time, "HH:MM:SS"] call BIS_fnc_secondsToString, [serverTime, "HH:MM:SS"] call BIS_fnc_secondsToString];
	diag_log format ["   - AVERAGE FPS : %1 (%2)", diag_fps, OPEX_fps_server];

	diag_log "";
	diag_log "[POPULATION COUNT]";
	diag_log format ["   - PLAYERS : %1 (total) | %2 (playing) | %3 (not playing)", count (allPlayers - entities "HeadlessClient_F"), count OPEX_playingPlayers, (count (allPlayers - entities "HeadlessClient_F")) - (count OPEX_playingPlayers)];
	diag_log format ["   - AIs : %1 (total) | %2 (west) | %3 (east) | %4 (indep) | %5 (civ)", {(alive _x) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits, {(alive _x) && (side _x == west) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits, {(alive _x) && (side _x == east) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits, {(alive _x) && (side _x == resistance) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits, {(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits];
	diag_log format ["   - VEHICLES : %1 (land) | %2 (sea) | %3 (air)", {(alive _x) && (_x isKindOf "LandVehicle") && (!(_x call Gemini_fnc_isInSafeLocation))} count vehicles, {(alive _x) && (_x isKindOf "Ship") && (!(_x call Gemini_fnc_isInSafeLocation))} count (vehicles), {(alive _x) && (_x isKindOf "Air") && (!(_x call Gemini_fnc_isInSafeLocation))} count (vehicles)];

	diag_log "";
	diag_log "[SETTINGS]";
	diag_log format ["   - PLAYFOR FACTION :    %1 (%2)", OPEX_persistentData_server select 0 select 0 select 0, OPEX_persistentData_server_server select 0 select 0 select 0];
	diag_log format ["   - OPFOR FACTION :      %1 (%2)", OPEX_persistentData_server select 0 select 0 select 1, OPEX_persistentData_server_server select 0 select 0 select 1];
	diag_log format ["   - TASK MANAGEMENT :    %1 (%2)", OPEX_persistentData_server select 0 select 0 select 2, OPEX_persistentData_server_server select 0 select 0 select 2];
	diag_log format ["   - GEAR MANAGEMENT :    %1 (%2)", OPEX_persistentData_server select 0 select 0 select 3, OPEX_persistentData_server_server select 0 select 0 select 3];
	diag_log format ["   - SUPPORT MANAGEMENT : %1 (%2)", OPEX_persistentData_server select 0 select 0 select 4, OPEX_persistentData_server_server select 0 select 0 select 4];
	diag_log format ["   - MEDICAL SYSTEM :     %1 (%2)", OPEX_persistentData_server select 0 select 0 select 5, OPEX_persistentData_server_server select 0 select 0 select 5];
	diag_log format ["   - PRIMERY NEEDS :      %1 (%2)", OPEX_persistentData_server select 0 select 0 select 6, OPEX_persistentData_server_server select 0 select 0 select 6];
	diag_log format ["   - FAST DEPLOYMENT :    %1 (%2)", OPEX_persistentData_server select 0 select 0 select 7, OPEX_persistentData_server_server select 0 select 0 select 7];
	diag_log format ["   - INTEL LEVEL :        %1 (%2)", OPEX_persistentData_server select 0 select 0 select 8, OPEX_persistentData_server_server select 0 select 0 select 8];
	diag_log format ["   - STARTING TIME :      %1 (%2)", OPEX_persistentData_server select 0 select 0 select 9, OPEX_persistentData_server_server select 0 select 0 select 9];
	diag_log format ["   - TIME ACCELERATION :  %1 (%2)", OPEX_persistentData_server select 0 select 0 select 10, OPEX_persistentData_server_server select 0 select 0 select 10];

	diag_log "";
	diag_log "[AMBIENT MODULES]";
	diag_log format ["   - CIVILIAN BOATS :       %1 (%2)", OPEX_ambientCivilianBoats, OPEX_ambientCivilianBoats_server];
	diag_log format ["   - CIVILIAN CARS :        %1 (%2)", OPEX_ambientCivilianCars, OPEX_ambientCivilianCars_server];
	diag_log format ["   - ENEMY AMBUSHES :       %1 (%2)", OPEX_ambientEnemyAmbushes, OPEX_ambientEnemyAmbushes_server];
	diag_log format ["   - ENEMY BIVOUACS :       %1 (%2)", OPEX_ambientEnemyBivouacs, OPEX_ambientEnemyBivouacs_server];
	diag_log format ["   - ENEMY CACHES :         %1 (%2)", OPEX_ambientEnemyCaches, OPEX_ambientEnemyCaches_server];
	diag_log format ["   - ENEMY GARRISONS :      %1 (%2)", OPEX_ambientEnemyGarrisons, OPEX_ambientEnemyGarrisons_server];
	diag_log format ["   - ENEMY IEDS :           %1 (%2)", OPEX_ambientEnemyIEDs, OPEX_ambientEnemyIEDs_server];
	diag_log format ["   - ENEMY PATROLS :        %1 (%2)", OPEX_ambientEnemyPatrols, OPEX_ambientEnemyPatrols_server];
	diag_log format ["   - ENEMY REINFORCEMENTS : %1 (%2)", OPEX_ambientEnemyReinforcements, OPEX_ambientEnemyReinforcements_server];
	diag_log format ["   - ENEMY ROADBLOCKS :     %1 (%2)", OPEX_ambientEnemyRoadblock, OPEX_ambientEnemyRoadblock_server];
	diag_log format ["   - FRIENDLY AIR :         %1 (%2)", OPEX_ambientFriendlyAir, OPEX_ambientFriendlyAir_server];
	diag_log format ["   - FRIENDLY BOATS :       %1 (%2)", OPEX_ambientFriendlyBoats, OPEX_ambientFriendlyBoats_server];
	diag_log format ["   - FRIENDLY PATROLS :     %1 (%2)", OPEX_ambientFriendlyPatrols, OPEX_ambientFriendlyPatrols_server];
	diag_log format ["   - FRIENDLY ROADBLOCKS :  %1 (%2)", OPEX_ambientFriendlyRoadblock, OPEX_ambientFriendlyRoadblock_server];

	diag_log "";
	diag_log "[SUPPORTS]";
	diag_log format ["   - INCOMING SUPPORT : %1 (%2)", OPEX_incomingSupport, OPEX_incomingSupport_server];
	diag_log format ["   - SUPPLIES DROP :    %1 (%2)", OPEX_support_suppliesDrop, OPEX_support_suppliesDrop_server];
	diag_log format ["   - VEHICLE DROP :     %1 (%2)", OPEX_support_vehicleDrop, OPEX_support_vehicleDrop_server];
	diag_log format ["   - AIR STRIKE :       %1 (%2)", OPEX_support_airStrike, OPEX_support_airStrike_server];
	diag_log format ["   - ARTILLERY STRIKE : %1 (%2)", OPEX_support_artilleryStrike, OPEX_support_artilleryStrike_server];
	diag_log format ["   - AIR ASSISTANCE :   %1 (%2)", OPEX_support_airAssistance, OPEX_support_airAssistance_server];
	diag_log format ["   - LAND ASSISTANCE :  %1 (%2)", OPEX_support_landAssistance, OPEX_support_landAssistance_server];
	diag_log format ["   - TRANSPORT :        %1 (%2)", OPEX_support_transport, OPEX_support_transport_server];

	diag_log "";
	diag_log "[TASKS]";
	diag_log format ["   - OPEX_ASSIGNEDTASK : %1 (%2)", OPEX_assignedTask, OPEX_assignedTask_server];
	diag_log format ["   - OPEX_TASKID : %1 (%2)", OPEX_taskID, OPEX_taskID_server];
	diag_log format ["   - OPEX_TASKDESCRIPTION : %1 (%2)", OPEX_taskDescription, OPEX_taskDescription_server];

	diag_log "";
	diag_log "[VEHICLES]";
	diag_log format ["   - ENEMY VEHICLES: %1 (%2)", count OPEX_enemy_motorizedVehicles, count OPEX_enemy_motorizedVehicles_server];
	diag_log format ["   - FRIENDLY COVERED TRUCKS : %1 (%2)", count OPEX_friendly_transportTrucksCovered_woodland, count OPEX_friendly_transportTrucksCovered_woodland_server];
	diag_log format ["   - FRIENDLY TRANSPORT CARS : %1 (%2)", count OPEX_friendly_transportCars_woodland, count OPEX_friendly_transportCars_woodland_server];
	diag_log format ["   - FRIENDLY COMBAT CARS : %1 (%2)", count OPEX_friendly_combatCarsMG_woodland, count OPEX_friendly_combatCarsMG_woodland_server];
	diag_log format ["   - FRIENDLY VTTS : %1 (%2)", count OPEX_friendly_vtt_woodland, count OPEX_friendly_vtt_woodland_server];
	diag_log format ["   - FRIENDLY TANKS : %1 (%2)", count OPEX_friendly_tanks_woodland, count OPEX_friendly_tanks_woodland_server];
	diag_log format ["   - FRIENDLY SMALL TRANSPORT HELICOPTERS : %1 (%2)", count OPEX_friendly_smallTransportHelicopters_woodland, count OPEX_friendly_smallTransportHelicopters_woodland_server];
	diag_log format ["   - FRIENDLY BIG TRANSPORT HELICOPTERS : %1 (%2)", count OPEX_friendly_bigTransportHelicopters_woodland, count OPEX_friendly_bigTransportHelicopters_woodland_server];

	diag_log "";
	diag_log "[GEAR]";
	diag_log format ["   - FRIENDLY UNIFORMS :      %1 (%2)", count (OPEX_friendly_commonUniforms + OPEX_friendly_specialUniforms), count (OPEX_friendly_commonUniforms_server + OPEX_friendly_specialUniforms_server)];
	diag_log format ["   - FRIENDLY VESTS :         %1 (%2)", count OPEX_friendly_commonVests, count OPEX_friendly_commonVests_server];
	diag_log format ["   - FRIENDLY UNIFORMS :      %1 (%2)", count OPEX_friendly_specialVests, count OPEX_friendly_specialVests_server];
	diag_log format ["   - FRIENDLY HELMETS :       %1 (%2)", count OPEX_friendly_commonHelmets, count OPEX_friendly_commonHelmets_server];
	diag_log format ["   - FRIENDLY RIFLES :        %1 (%2)", count OPEX_friendly_commonRifles, count OPEX_friendly_commonRifles_server];
	diag_log format ["   - FRIENDLY HANDGUNS :      %1 (%2)", count OPEX_friendly_commonHandguns, count OPEX_friendly_commonHandguns_server];
	diag_log format ["   - FRIENDLY OPTICS :        %1 (%2)", count OPEX_friendly_closeCombatOptics, count OPEX_friendly_closeCombatOptics_server];
	diag_log format ["   - FRIENDLY MEDICALS :      %1 (%2)", count OPEX_medical_supplies, count OPEX_medical_supplies_server];
	diag_log format ["   - ENEMY UNIFORMS :         %1 (%2)", count OPEX_enemy_commonUniforms, count OPEX_enemy_commonUniforms_server];
	diag_log format ["   - ENEMY RIFLES (COMMON) :  %1 (%2)", count OPEX_enemy_commonRifles, count OPEX_enemy_commonRifles_server];
	diag_log format ["   - ENEMY RIFLES (SPECIAL) : %1 (%2)", count OPEX_enemy_specialRifles, count OPEX_enemy_specialRifles_server];

	diag_log "";
	diag_log "[PERSISTENT SAVE]";
	diag_log format ["   - SERVER : %1", if (count OPEX_foundPersistentData_server == 0) then {false} else {true}];
	diag_log format ["   - PLAYER : %1", if (count (profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_player", []]) == 0) then {false} else {true}];
	diag_log format ["   - SERVER CURRENT DATA :    %1", OPEX_persistentData_server];
	diag_log format ["   - SERVER PERSISTENT DATA : %1", OPEX_foundPersistentData_server];
	diag_log format ["   - PLAYER CURRENT DATA :    %1", OPEX_persistentData_player];
	diag_log format ["   - PLAYER PERSISTENT DATA : %1", profileNameSpace getVariable ["OPEX_" + worldName + "_persistentData_player", []]];
	diag_log format ["   - SERVER CURRENT STATS :   %1", OPEX_stats_faction];
	diag_log format ["   - SERVER PERSISTENT STATS: %1", OPEX_foundPersistentStats_server];
	diag_log format ["   - PLAYER CURRENT STATS :   %1", OPEX_stats_player];
	diag_log format ["   - PLAYER PERSISTENT STATS: %1", profileNameSpace getVariable ["OPEX_persistentStats_player", []]];

	diag_log "";
	diag_log "===========================================================================================================================================";
	diag_log "";
	diag_log "";
	diag_log "";
	diag_log "";
	diag_log "";

// --------------------------------------------------------------------------------
// DISPLAYING CONFIRMATION
// --------------------------------------------------------------------------------

	//if (!(_this isEqualTo [])) then {hint localize "STR_hint_RPTupdated"};
	if (!(_this isEqualTo [])) then 
		{
			private _text = format ["<t align='center'>%1</t>", localize "STR_hint_RPTupdated"];
			hint parseText _text;
		};
