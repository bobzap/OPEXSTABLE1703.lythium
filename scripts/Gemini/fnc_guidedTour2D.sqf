waitUntil {!isNil "OPEX_params_ready"};

// AUTO DISPLAYING/HIDING MARKERS
if (!isDedicated) then
{
	private _autoDisplayMarkers =
		{
			if (isClass (configFile >> "CfgPatches" >> "BaBe_EM")) exitWith {}; // the script below makes Enhanced Movement mod crashing... need to make more test later
			//if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {}; // the script below may make Task Force Radio mod crashing ? need to make more test later
			OPEX_guides_2D = addMissionEventHandler
				[	"Map",
					{
						disableSerialization;
						onEachFrame
						{
								private _map = (findDisplay 12) displayCtrl 51; //Arma 3
								private _scale = ctrlMapScale _map; //returns number from 1 to 0.001 (default: 0.16)
								if ((_scale <= 0.25) || (visibleGPS))
								then
									{
										{_x setMarkerAlphaLocal 1} forEach ((OPEX_markers select 3) select {(["mil_box", getMarkerType _x] call BIS_fnc_inString) || (["mil_start", getMarkerType _x] call BIS_fnc_inString)});
										{_x setMarkerAlphaLocal 0} forEach ((OPEX_markers select 3) select {!((["mil_box", getMarkerType _x] call BIS_fnc_inString) || (["mil_start", getMarkerType _x] call BIS_fnc_inString))});
									}
								else
									{
										{_x setMarkerAlphaLocal 0} forEach ((OPEX_markers select 3) select {(["mil_box", getMarkerType _x] call BIS_fnc_inString) || (["mil_start", getMarkerType _x] call BIS_fnc_inString)});
										{_x setMarkerAlphaLocal 1} forEach ((OPEX_markers select 3) select {!((["mil_box", getMarkerType _x] call BIS_fnc_inString) || (["mil_start", getMarkerType _x] call BIS_fnc_inString))});
									};
						};
					}
				];
		};
	if (isNil "OPEX_guides_2D") then {call _autoDisplayMarkers};
};

// CREATING MARKER
private _markerType = "mil_box";
if (_this select 1 == "STR_marker_gate") then {_markerType = "mil_start"} else {_markerType = "mil_box"};
if (isServer) then 
	{
		[_this select 0, _markerType, _this select 1] spawn 
			{
				private _position = _this select 0;
				private _markerType = _this select 1;
				private _text = _this select 2;
				sleep 5; // waiting for ammo boxes conversion (otherwise the armory marker is not created)
				[_position, _markerType, "colorBlack", _text, "hq"] call Gemini_fnc_createMarker;
			};
	};