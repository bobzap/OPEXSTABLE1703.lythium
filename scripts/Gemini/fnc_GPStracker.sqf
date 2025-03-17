// =========================================================================================================
// PRIVATIZING  VARIABLES 
// =========================================================================================================

	private 
		[
			"_unit",
			"_unitMarker"
		];	

// =========================================================================================================
// GETTING ARGUMENTS 
// =========================================================================================================

	_unit = _this select 0;

// =========================================================================================================
// CHECKING AUTHORIZATION
// =========================================================================================================

	if (group _unit != group player) exitWith {}; // only for player's group units

// =========================================================================================================
// INITIALIZING MARKER
// =========================================================================================================	

	sleep 5;
	while {alive _unit} do
		{
			sleep 1;
			if (alive _unit && ((goggles player) in ["G_Tactical_Black", "G_Tactical_Clear", "G_Goggles_VR"])) then 
				{
					_unitMarker = createMarkerLocal [format ["%1", random 100000], position _unit];
					_unitMarker setMarkerTypeLocal "mil_dot";
					_unitMarker setMarkerColorLocal "ColorBlue";
					_unitMarker setMarkerTextLocal format ["%1", name _unit]			
				};

			while {alive _unit && ((goggles player) in ["G_Tactical_Black", "G_Tactical_Clear", "G_Goggles_VR"]) && (!isNil "_unitMarker")} do {_unitMarker setMarkerPosLocal (position _unit); sleep 1};
			if ((!((goggles player) in ["G_Tactical_Black", "G_Tactical_Clear","G_Goggles_VR"])) && (!isNil "_unitMarker")) then {deleteMarker _unitMarker};			
		};
	if ((!alive _unit) && (!isNil "_unitMarker")) then {deleteMarker _unitMarker};

// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================
	
	if (true) exitWith {};