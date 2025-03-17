// hint str (typeof (nearestbuilding player))

// SERVER ONLY
if (!isServer) exitWith {};

// DEFINING PROBABILITY
private ["_probability"];
_probability = 2;
if (_probability < (random 100)) exitWith {nil};

// CREATING DEBUG MARKER
private ["_debugMarker"];
_debugMarker =
	{
		if (OPEX_debug) then
			{
				private ["_marker", "_markerID", "_markerText"];
				_markerID = format [ "debugMarker_intel_%1", round random 5000];
				_markerText = format [ "%1", "INTEL"];
				_marker = createMarker [_markerID, position _this];
				_marker setMarkerType "mil_dot";
				_marker setMarkerColor "ColorRed";
				_marker setMarkerText _markerText;
				while {alive _this} do {sleep 2};
				deleteMarker _marker;
			};
	};

// DEFINING INTEL ITEMS
private ["_intel"];
_intels = ["Land_FilePhotos_F", "Land_File1_F", "Land_File2_F", "Land_MobilePhone_old_F", "Land_MobilePhone_smart_F", "Land_Laptop_F", "Land_Laptop_unfolded_F"];

// SPAWNING INTEL
private ["_intel"];
_intel = (selectRandom _intels) createVehicle (getPos _this);
[_this, _intel, [0, 0, abs ((((boundingBoxReal _this) select 1) select 2) - (((boundingBoxReal _this) select 0) select 2))], (random 25 - random 25)] call BIS_fnc_relPosObject;
[_intel, ["STR_action_getIntel", "white"], "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", "_target distance2D _this < 5", "_target distance2D _this < 5", {}, {}, {OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + 50]; publicVariable "OPEX_stats_faction"; hint localize "STR_hint_intelGathered"; deleteVehicle _target}, {}, [_x], 3, 10, true, false, true] remoteExec ["Gemini_fnc_holdActionAdd", 0, _intel];
//_intel enableSimulation false;
_intel setVariable ["R3F_LOG_disabled", true, true];

/*

// disabling this for now because enemies can spawn too close from players - I need to think about a way to make it compatible with OPEX_spawnDistanceMini and OPEX_spawnDistanceMaxi

// SPAWNING ENEMIES
if (random 100 > 50) then {[_this, 10, -1, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill, "distance"] call Gemini_fnc_spawnUnitsStandingInside};
	
if (random 100 > 50) then
	{
		private ["_squadPos", "_squad"];
		_squadPos = ["land", _this, 0, 100, 1] call Gemini_fnc_findPos;
		_squad = [OPEX_enemy_side1, ["infantry"], 2, _squadPos, 50, "patrol", position _this, OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
		if (!isNil "_squad") then {_squad setBehaviour "safe"};
	};
*/

// DISPALYING DEBUG MARKER
_intel spawn _debugMarker;

// RETURNING INTEL
_intel