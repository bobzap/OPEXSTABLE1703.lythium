// =========================================================================================================
// NOT FOR DEDICATED SERVERS
// =========================================================================================================

	if (isDedicated) exitWith {};
	waitUntil {!isNil "OPEX_spawnDistanceMini"};
	waitUntil {!isNil "OPEX_spawnDistanceMaxi"};

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private _debug = param [0, false, [false], 1];

// =========================================================================================================
// DEFINING FUNCTION
// =========================================================================================================

	if (_debug) then
		{
			// PLAYER POSITION
			private ["_debugMarkerPlayer"];
			_debugMarkerPlayer = createMarker [format ["OPEX_debugMarker_player_%1", round random 100000], position player];
			_debugMarkerPlayer setMarkerType "mil_dot";
			_debugMarkerPlayer setMarkerColor "ColorBlue";
			_debugMarkerPlayer setMarkerText format ["%1", name player];
			private ["_debugMarkerSpawnMini"];
			_debugMarkerSpawnMini = createMarkerLocal [format ["OPEX_debugMarker_spawnMini", round random 100000], position player];
			_debugMarkerSpawnMini setMarkerShape "ellipse";
			_debugMarkerSpawnMini setMarkerSize [OPEX_spawnDistanceMini, OPEX_spawnDistanceMini];
			_debugMarkerSpawnMini setMarkerColor "ColorGreen";
			_debugMarkerSpawnMini setMarkerAlpha 0.25;
			private ["_debugMarkerSpawnMaxi"];
			_debugMarkerSpawnMaxi = createMarkerLocal [format ["OPEX_debugMarker_spawnMaxi", round random 100000], position player];
			_debugMarkerSpawnMaxi setMarkerShape "ellipse";
			_debugMarkerSpawnMaxi setMarkerSize [OPEX_spawnDistanceMaxi, OPEX_spawnDistanceMaxi];
			_debugMarkerSpawnMaxi setMarkerColor "ColorRed";
			_debugMarkerSpawnMaxi setMarkerAlpha 0.25;
			[player, _debugMarkerPlayer, _debugMarkerSpawnMini, _debugMarkerSpawnMaxi] spawn {while {true} do {sleep 1; {_x setMarkerPos (position (_this select 0))} forEach [(_this select 1), (_this select 2), (_this select 3)]}};

			// FAST TRAVELLING
			onMapSingleClick "{_x setPos _pos} forEach ([vehicle player] + ((units group player) - [player]))";

			// SITREP
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Sitrep" + "</t>", {call Gemini_fnc_sitrep}, nil, 0, false];

			// INVISIBILITY
			player setVariable ["OPEX_isVisible", true, false];
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Invisibility" + "</t>", {if (player getVariable "OPEX_isVisible") then {player hideObjectGlobal true; player setCaptive true; player setVariable ["OPEX_isVisible", false, false]; hint "You are now INVISIBLE !"} else {player hideObjectGlobal false; player setCaptive false; player setVariable ["OPEX_isVisible", true, false]; hint "You are now VISIBLE !"}}, nil, 0, false];

			// INVULNERABILITY
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Invulnerability" + "</t>", {if (isDamageAllowed player) then {player allowDamage false; hint "You are now INVULNERABLE !"} else {player allowDamage true; hint "You are now VULNERABLE !"}}, nil, 0, false];

			// INSTANT KILLING
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Kill OPFOR" + "</t>", {{if (side _x == east) then {_x setDamage 1}} forEach allUnits}, nil, 0, false];

			// SHOWING ALL ALIVE UNITS ON MAP
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Show all units on map" + "</t>",
			{
				{if (["debug_unitPos_", _x, false] call BIS_fnc_inString) then {deleteMarker _x}} forEach allMapMarkers;
				{
					private ["_debugMarker"];
					_debugMarker = createMarker [format ["OPEX_marker_debug_unitPos_%1", random 100000], position _x];
					_debugMarker setMarkerType "mil_triangle";
					[_x, _debugMarker] spawn
						{
							while {alive (_this select 0)} do {sleep 1; (_this select 1) setMarkerPos (position (_this select 0))};
							deleteMarker (_this select 1);
						};
					if (side _x == west) then {_debugMarker setMarkerColor "ColorBlue"};
					if (side _x == east) then {_debugMarker setMarkerColor "ColorRed"};
					if (side _x == resistance) then {_debugMarker setMarkerColor "ColorGreen"};
					if (side _x == civilian) then {_debugMarker setMarkerColor "ColorYellow"};
					if (side _x == sideLogic) then {_debugMarker setMarkerColor "ColorPink"};
				} forEach allUnits;
			}, nil, 0, false];

			// GETTING ALL MAP LOCATIONS
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Show all map locations" + "</t>",
				{
							{
								private ["_markerShape"];
								_markerShape = createMarker [format ["OPEX_marker_debug_location_%1", random 100000], position _x];
								_markerShape setMarkerPos (position _x);
								_markerShape setMarkerBrush "Solid";
								_markerShape setMarkerAlpha 1;
								_markerShape setMarkerSize [triggerArea (_x) select 0, triggerArea (_x) select 1];
								if (triggerArea _x select 3) then {_markerShape setMarkerShape "rectangle"} else {_markerShape setMarkerShape "ellipse"};
								if (_x in OPEX_locations_safe) then {_markerShape setMarkerColor "colorBlue"};
								if (_x in OPEX_locations_isolated) then {_markerShape setMarkerColor "colorYellow"};
								if (_x in OPEX_locations_villages) then {_markerShape setMarkerColor "colorGreen"};
								if (_x in OPEX_locations_cities) then {_markerShape setMarkerColor "colorGreen"};
								if (_x in OPEX_locations_industrial) then {_markerShape setMarkerColor "colorOrange"};
								if (_x in OPEX_locations_military) then {_markerShape setMarkerColor "colorRed"};
								private ["_markerName"];
								_markerName = createMarker [format ["OPEX_marker_debug_location_%1", random 100000], getMarkerPos _markerShape];
								_markerName setMarkerType "mil_dot";
								if (_x in OPEX_locations_safe) then {_markerName setMarkerColor "colorBlue"};
								if (_x in OPEX_locations_isolated) then {_markerName setMarkerColor "colorYellow"};
								if (_x in OPEX_locations_villages) then {_markerName setMarkerColor "colorGreen"};
								if (_x in OPEX_locations_cities) then {_markerName setMarkerColor "colorGreen"};
								if (_x in OPEX_locations_industrial) then {_markerName setMarkerColor "colorOrange"};
								if (_x in OPEX_locations_military) then {_markerName setMarkerColor "colorRed"};
								if (_x in OPEX_locations_safe) then {_markerName setMarkerText "safe location"};
								if (_x in OPEX_locations_isolated) then {_markerName setMarkerText "isolated location"};
								if (_x in OPEX_locations_villages) then {_markerName setMarkerText "village location"};
								if (_x in OPEX_locations_cities) then {_markerName setMarkerText "city location"};
								if (_x in OPEX_locations_industrial) then {_markerName setMarkerText "industrial location"};
								if (_x in OPEX_locations_military) then {_markerName setMarkerText "military location"};
							} forEach OPEX_allLocations;
					openMap true;
				}
				, nil, 0, false];

			// GUIDED TOUR
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Guided Tour" + "</t>", {call Gemini_fnc_guidedTour3D_switch}, nil, 0, false];

			// DISPLAYING FPS
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Display FPS" + "</t>", {while {true} do {hintSilent str diag_fps}}, nil, 0, false];

			// CLEANING
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Clean map" + "</t>", {call Gemini_fnc_cleaning}, nil, 0, false];

			// SAVING PERSISTENT DATA
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Save Server" + "</t>", {"server" remoteExecCall ["Gemini_fnc_persistence_save", 2]}, nil, 0, false];
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Save Player" + "</t>", {"client" remoteExecCall ["Gemini_fnc_persistence_save", player]}, nil, 0, false];
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Save OPEX" + "</t>", {"server" remoteExecCall ["Gemini_fnc_persistence_save", 2]; "client" remoteExecCall ["Gemini_fnc_persistence_save", player]}, nil, 0, false];

			// RESETTING PERSISTENT DATA
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Reset Server" + "</t>", {"server" remoteExecCall ["Gemini_fnc_persistence_reset", 2]}, nil, 0, false];
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Reset Player" + "</t>", {"client" remoteExecCall ["Gemini_fnc_persistence_reset", player]}, nil, 0, false];
			player addAction ["<t color=""#FF0000"">" + "[DEBUG] Reset OPEX" + "</t>", {"all" remoteExecCall ["Gemini_fnc_persistence_reset", 0]}, nil, 0, false];
		};