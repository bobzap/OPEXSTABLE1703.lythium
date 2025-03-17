
// ------------------------------------------------------------------------------------------------------------------------------------------
// MAIN FUNCTIONS (SERVER SIDE)
// ------------------------------------------------------------------------------------------------------------------------------------------


// INITIALIZING VEHICLE
Gemini_fnc_vehicleMusicReceiver_initVehicle =
	{
		//if (!isServer) exitWith {};
		private ["_vehicle", "_vehicleID"];
		_vehicle = _this select 0;
		if ((_vehicle isKindOf "car") || (_vehicle isKindOf "tank") || (_vehicle isKindOf "air") || (_vehicle isKindOf "ship")) then
			{
				// INITIALIZING VARIABLES
				if (isServer) then
					{
						_vehicle setVariable ["vehicleMusicReceiver_track", "...", true];
						_vehicle setVariable ["vehicleMusicReceiver_index", -1, true];
						_vehicle setVariable ["vehicleMusicReceiver_timer", 0, true];
						_vehicle setVariable ["vehicleMusicReceiver_volume", 0.5, true];
						_vehicle setVariable ["vehicleMusicReceiver_shuffle", false, true];
					};
			};
	};




// ------------------------------------------------------------------------------------------------------------------------------------------
// MAIN FUNCTIONS (CLIENT SIDE)
// ------------------------------------------------------------------------------------------------------------------------------------------

// MONITORING WHEN PLAYER IS GETTING IN A VEHICLE
Gemini_fnc_vehicleMusicReceiver_getInVehicle =
	{
		if (isDedicated) exitWith {};
		private ["_unit", "_vehicle"];
		_unit = _this select 0;
		_vehicle = _this select 2;
		// ADDING ACTION
		vehicleMusicReceiver_action = _unit addAction [localize "STR_action_vehicleMusicReceiver", {[_this select 1] spawn Gemini_fnc_vehicleMusicReceiver_dialog}, nil, 5, false, true];
		// IF MUSIC IS CURRENTLY PLAYING INTO VEHICLE, PLAYING IT ALSO FOR NEW CREW UNIT
		if (_vehicle getVariable "vehicleMusicReceiver_track" != "...") then {playMusic [_vehicle getVariable "vehicleMusicReceiver_track", _vehicle getVariable "vehicleMusicReceiver_timer"]};
	};


// MONITORING WHEN PLAYER IS GETTING OUT A VEHICLE
Gemini_fnc_vehicleMusicReceiver_getOutVehicle =
	{
		if (isDedicated) exitWith {};
		private ["_unit", "_vehicle"];
		_unit = _this select 0;
		_vehicle = _this select 2;
		// REMOVING ACTION
		_unit removeAction vehicleMusicReceiver_action;
		// IF MUSIC IS CURRENTLY PLAYING, DOING SO
		if (_vehicle getVariable "vehicleMusicReceiver_track" != "...") then {playMusic ""};
	};


// CLOSING INTERFACE
Gemini_fnc_vehicleMusicReceiver_close =
	{
		closeDialog 0;
	};

// UPDATING SHUFFLE MOD
Gemini_fnc_vehicleMusicReceiver_shuffle =
	{
		private ["_vehicle"];
		_vehicle = _this select 0;
		if (_vehicle getVariable "vehicleMusicReceiver_shuffle")
			then {_vehicle setVariable ["vehicleMusicReceiver_shuffle", false, true]}
			else {_vehicle setVariable ["vehicleMusicReceiver_shuffle", true, true]};
	};

// STOPPING MUSIC
Gemini_fnc_vehicleMusicReceiver_stopMusic =
	{
		private ["_vehicle"];
		_vehicle = _this select 0;
		if (!isDedicated) then {if (player in _vehicle) exitWith {playMusic ""}};
		_vehicle setVariable ["vehicleMusicReceiver_track", "...", true];
		_vehicle setVariable ["vehicleMusicReceiver_index", -1, true];
		_vehicle setVariable ["vehicleMusicReceiver_timer", 0, true];
	};


// GETTING TRACK INDEX
Gemini_fnc_vehicleMusicReceiver_getTrackIndex =
	{
		private ["_vehicle", "_track", "_index", "_idx"];
		_vehicle = _this select 0;
		_track = _this select 1;
		_index = 0;
		_idx= 0;
		for "_i" from 0 to (count vehicleMusicReceiver_trackList - 1) do
			{
				if ((vehicleMusicReceiver_trackList select _idx select 1) == _track) then {_index = _idx} else {_idx = _idx + 1};
			};
		_index
	};

// PLAYING MUSIC
Gemini_fnc_vehicleMusicReceiver_playMusic =
	{
		private ["_vehicle", "_track", "_timer", "_index", "_idx"];
		_vehicle = _this select 0;
		_track =_this select 1;
		_timer = _this select 2;
		if (!isDedicated) then {if (player in _vehicle) exitWith {playMusic [_track, _timer]}};
		if ((isServer) && (_vehicle getVariable "vehicleMusicReceiver_track" == "...")) then
			{
				_index = [_vehicle, _track] call Gemini_fnc_vehicleMusicReceiver_getTrackIndex;
				_vehicle setVariable ["vehicleMusicReceiver_track", _track, true];
				_vehicle setVariable ["vehicleMusicReceiver_index", _index, true];
				_vehicle setVariable ["vehicleMusicReceiver_timer", 0, true];
			};
	};

// INITIALIZING NEW TRACK
Gemini_fnc_vehicleMusicReceiver_initTrack =
	{
		private ["_vehicle", "_track"];
		_vehicle = _this select 0;
		_track =_this select 1;
		[_vehicle, _track] call Gemini_fnc_vehicleMusicReceiver_stopMusic; // stopping music
		if (_vehicle getVariable "vehicleMusicReceiver_track" == "...") then
			{
				[_vehicle, _track, 0] call Gemini_fnc_vehicleMusicReceiver_playMusic; // playing music
				sleep 0.1;
				[_vehicle] spawn Gemini_fnc_vehicleMusicReceiver_updateTimer; // monitoring music (server only)
			};

	};

// SELECTING PREVIOUS/NEXT TRACK
Gemini_fnc_vehicleMusicReceiver_previousNext =
	{
		private ["_vehicle", "_track", "_index"];
		_vehicle = _this select 0;
		_index = _this select 1;
		if (_index < 0) then {_index = (count vehicleMusicReceiver_trackList) - 1};
		if (_index > ((count vehicleMusicReceiver_trackList) - 1)) then {_index = 0};
		if (_vehicle getVariable "vehicleMusicReceiver_shuffle") then {_track = (vehicleMusicReceiver_trackList call BIS_fnc_selectRandom) select 1} else {_track = vehicleMusicReceiver_trackList select _index select 1};
		[_vehicle, _track] remoteExec ["Gemini_fnc_vehicleMusicReceiver_initTrack"];
	};

// TIMER
Gemini_fnc_vehicleMusicReceiver_updateTimer =
	{
		if (!isServer) exitWith {};
		private ["_vehicle", "_track", "_timer", "_trackDuration"];
		_vehicle = _this select 0;
		_track = _vehicle getVariable ["vehicleMusicReceiver_track", ""];
		_timer = _vehicle getVariable ["vehicleMusicReceiver_timer", 0];
		_trackDuration = vehicleMusicReceiver_trackList select (_vehicle getVariable ["vehicleMusicReceiver_index", 0]) select 2;
		if (isNil "_trackDuration") then {_trackDuration = 0};
		while
			{
				(alive _vehicle)
				&&
				(_vehicle getVariable ["vehicleMusicReceiver_track", ""] != "...")
				&&
				(_vehicle getVariable ["vehicleMusicReceiver_track", ""] == _track)
				&&
				(_vehicle getVariable ["vehicleMusicReceiver_timer", 0] < _trackDuration)
			}
		do
			{
				_timer = _timer + 1;
				_vehicle setVariable ["vehicleMusicReceiver_timer", _timer, true];
				sleep 1;
			};
		// IF MUSIC IS ENDED AND IF THERE ARE STILL PLAYERS IN VEHICLE, STARTING NEXT ONE
		if ((alive _vehicle) && (_vehicle getVariable ["vehicleMusicReceiver_timer", 0] >= _trackDuration) && ({_x in (allPlayers - entities "HeadlessClient_F")} count crew _vehicle > 0)) then
			{
				[_vehicle, (_vehicle getVariable ["vehicleMusicReceiver_index", 0]) + 1] remoteExecCall ["Gemini_fnc_vehicleMusicReceiver_previousNext"];
			};
	};

// UPDATING VOLUME
Gemini_fnc_vehicleMusicReceiver_volume =
	{
		private ["_vehicle", "_targetLevel", "_currentLevel", "_levelUp", "_levelDown"];
		_vehicle = _this select 0;
		_targetLevel = _this select 1;
		_currentLevel = _vehicle getVariable ["vehicleMusicReceiver_volume", 1];
		_levelUp = _currentLevel + 0.05; if (_levelUp > 2) then {_levelUp = 2};
		_levelDown = _currentLevel - 0.05; if (_levelDown <= 0.01) then {_levelDown = 0};
		// CASE LEVEL UP
		if (_targetLevel == "up") then
			{
				if (!isDedicated) then {if (player in _vehicle) exitWith {0 fadeMusic _levelUp}};
				if (isServer) then {_vehicle setVariable ["vehicleMusicReceiver_volume", _levelUp, true]};
			};
		// CASE LEVEL DOWN
		if (_targetLevel == "down") then
			{
				if (!isDedicated) then {if (player in _vehicle) exitWith {0 fadeMusic _levelDown}};
				if (isServer) then {_vehicle setVariable ["vehicleMusicReceiver_volume", _levelDown, true]};
			};
		// CASE MUTE
		if ((_targetLevel == "mute") && (_currentLevel > 0)) then
			{
				if (!isDedicated) then {if (player in _vehicle) exitWith {0 fadeMusic 0}};
				if (isServer) then {_vehicle setVariable ["vehicleMusicReceiver_volume", 0, true]};
			};
		if ((_targetLevel == "mute") && (_currentLevel == 0)) then
			{
				if (!isDedicated) then {if (player in _vehicle) exitWith {0 fadeMusic 0.5}};
				if (isServer) then {_vehicle setVariable ["vehicleMusicReceiver_volume", 0.5, true]};
			};
	};

// ------------------------------------------------------------------------------------------------------------------------------------------
// DISPLAYING MUSIC RECEIVER INTERFACE
// ------------------------------------------------------------------------------------------------------------------------------------------

	Gemini_fnc_vehicleMusicReceiver_dialog =
		{
			// PRIVATIZING VARIABLES
			private ["_vehicle", "_unit"];
			private
				[
					"_track_title", "_track_time", "_track_volume", "_track_shuffle",
					"_track_titleTITLE", "_track_timeTITLE", "_track_volumeTITLE", "_track_shuffleTITLE",
					"_powerButton", "_volDownButton", "_volMuteButton", "_volUpButton",
					"_playButton", "_stopButton", "_previousButton", "_nextButton", "_shuffleButton"
				];

			// GETTING ARGUMENTS
			_unit = _this select 0;
			_vehicle = vehicle _unit;

			// GETTING IDs
			_track_title = 901;
			_track_titleTITLE = 9011;
			_track_time = 902;
			_track_timeTITLE = 9021;
			_track_volume = 903;
			_track_volumeTITLE = 9031;
			_track_shuffle = 904;
			_track_shuffleTITLE = 9041;
			_powerButton = 910;
			_volDownButton = 911;
			_volMuteButton = 912;
			_volUpButton = 913;
			_playButton = 914;
			_stopButton = 915;
			_previousButton = 916;
			_nextButton = 917;
			_shuffleButton = 918;

			// DISPLAYING DIALOG
			createDialog "OPEX_vehicleMusicReceiver";

			// DEFINING BUTTONS ACTIONS
			buttonSetAction [_powerButton, "call Gemini_fnc_vehicleMusicReceiver_close"];
			buttonSetAction [_volDownButton, format ["[%1, ""%2""] remoteExecCall [""Gemini_fnc_vehicleMusicReceiver_volume""]", _vehicle, "down"]];
			buttonSetAction [_volMuteButton, format ["[%1, ""%2""] remoteExecCall [""Gemini_fnc_vehicleMusicReceiver_volume""]", _vehicle, "mute"]];
			buttonSetAction [_volUpButton, format ["[%1, ""%2""] remoteExecCall [""Gemini_fnc_vehicleMusicReceiver_volume""]", _vehicle, "up"]];
			while {dialog} do
				{
					buttonSetAction [_playButton, format ["[%1, %2] call Gemini_fnc_vehicleMusicReceiver_previousNext", _vehicle, 0]];
					buttonSetAction [_stopButton, format ["[%1] remoteExecCall [""Gemini_fnc_vehicleMusicReceiver_stopMusic""]", _vehicle]];
					buttonSetAction [_previousButton, format ["[%1, %2] call Gemini_fnc_vehicleMusicReceiver_previousNext", _vehicle, ((_vehicle getVariable "vehicleMusicReceiver_index") - 1)]];
					buttonSetAction [_nextButton, format ["[%1, %2] call Gemini_fnc_vehicleMusicReceiver_previousNext", _vehicle, ((_vehicle getVariable "vehicleMusicReceiver_index") + 1)]];
					buttonSetAction [_shuffleButton, format ["[%1] call Gemini_fnc_vehicleMusicReceiver_shuffle", _vehicle]];
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then
					{
						ctrlSetText
						[
							_track_title,
							toUpper format
								["%1 (%2/%3)",
									//(getText (configfile >> "CfgMusic" >> (_vehicle getVariable "vehicleMusicReceiver_track") >> "name")),
									vehicleMusicReceiver_trackList select (_vehicle getVariable "vehicleMusicReceiver_index") select 3,
									(_vehicle getVariable "vehicleMusicReceiver_index") + 1,
									count vehicleMusicReceiver_trackList
								]
						];
					} else {ctrlSetText [_track_title, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_titleTITLE, toUpper "TRACK"]} else {ctrlSetText [_track_titleTITLE, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_timeTITLE, toUpper "TIME"]} else {ctrlSetText [_track_timeTITLE, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_shuffleTITLE, toUpper "SHUFFLE"]} else {ctrlSetText [_track_shuffleTITLE, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_volumeTITLE, toUpper "VOLUME"]} else {ctrlSetText [_track_volumeTITLE, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {if (_vehicle getVariable "vehicleMusicReceiver_shuffle") then {ctrlSetText [_track_shuffle, "ON"]} else {ctrlSetText [_track_shuffle, "OFF"]}} else {ctrlSetText [_track_shuffle, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_time,  [(_vehicle getVariable "vehicleMusicReceiver_timer"), "MM:SS"] call BIS_fnc_secondsToString]} else {ctrlSetText [_track_time, ""]};
					if ((_vehicle getVariable "vehicleMusicReceiver_track") != "...") then {ctrlSetText [_track_volume, format ["%1%2", (_vehicle getVariable "vehicleMusicReceiver_volume") * 100, "%"]]} else {ctrlSetText [_track_volume, ""]};
				};
		};


player addEventHandler ["GetInMan", "_this call Gemini_fnc_vehicleMusicReceiver_getInVehicle"];
player addEventHandler ["GetOutMan", "_this call Gemini_fnc_vehicleMusicReceiver_getOutVehicle"];
{[_x] spawn Gemini_fnc_vehicleMusicReceiver_initVehicle} forEach vehicles;
