// WAITING FOR SERVER INITIALIZATION
if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientFriendlyPatrols = 0; publicVariable "OPEX_ambientFriendlyPatrols";

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		// ADJUSTING LIMIT
		private _maxPatrols = 1;
		if (count OPEX_playingPlayers <= 3) then {_maxPatrols = 1};
		if ((count OPEX_playingPlayers > 3) && (count OPEX_playingPlayers <= 9)) then {_maxPatrols = 2};
		if (count OPEX_playingPlayers > 9) then {_maxPatrols = 3};

		// CHECKING IF CONDITIONS ARE VALID
		if ((count (OPEX_playingPlayers select {speed _x < 20}) == 0) || (OPEX_ambientFriendlyPatrols >= _maxPatrols) || (random 100 > 25)) exitWith {};

		// CHECKING IF SPECIFIC TASKS ARE RUNNING (TO AVOID ANY ISSUE - example: in task "05" spawning a friendly patrol could lead to the hostage execution
		if ((OPEX_assignedTask) && (OPEX_taskID == "06")) exitWith {};

		// SELECTING A RANDOM PLAYER
		private _player = selectRandom (OPEX_playingPlayers select {speed _x < 20});

		// UPDATING COUNT
		OPEX_ambientFriendlyPatrols = OPEX_ambientFriendlyPatrols + 1; publicVariable "OPEX_ambientFriendlyPatrols";

		// SPAWNING FRIENDS
		private _squad = [OPEX_friendly_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], selectRandom [6,8,10,12], _player, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], "patrol", _player, OPEX_friendly_AIskill, 100] call Gemini_fnc_spawnSquad;
		if (isNil "_squad") exitWith {OPEX_ambientFriendlyPatrols = OPEX_ambientFriendlyPatrols - 1; publicVariable "OPEX_ambientFriendlyPatrols"};

		// SENDING RADIO MESSAGE + CREATING MARKER TO INFORM PLAYERS THAT A FRIEND PATROL IS NEARBY
		{if (_x distance2D _player <= OPEX_spawnDistanceMini / 3) then {["Base", "STR_radio_friendliesNearby"] remoteExec ["Gemini_fnc_commandChat", _x]}} forEach OPEX_playingPlayers;
		private _squadMarker = [position (leader _squad), "mil_warning", "ColorBlue", "STR_marker_friendlyPatrol"] call Gemini_fnc_createMarker;
		[_squad, _squadMarker] spawn
			{
				while {count (units (_this select 0)) > 0} do {if (OPEX_debug) then {sleep 3} else {sleep 30}; (_this select 1) setMarkerPos (position leader (_this select 0))};
				deleteMarker (_this select 1);
			};

		// DEBUGGING
		if (OPEX_debug) then {systemChat "AMBIENT PATROL READY !"};

		// WAITING FOR THE END, THEN RESETTING
		waitUntil {(!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
		OPEX_ambientFriendlyPatrols = OPEX_ambientFriendlyPatrols - 1; publicVariable "OPEX_ambientFriendlyPatrols";
	};

// LOOPING
while {true} do {sleep (call Gemini_fnc_ambientSleep); [] spawn _mainFunction};