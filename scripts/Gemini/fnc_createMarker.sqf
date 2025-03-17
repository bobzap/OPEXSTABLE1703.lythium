/*
	example:
	[<object or position>, <markertype>, <markercolor>, <markertext>, <markerlifetime>] call Gemini_fnc_createMarker;

*/

// =========================================================================================================
// STARTING SCRIPT EXECUTION (SERVER ONLY)
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// CHECKING PARAMETERS
// =========================================================================================================

	private _position = param [0, [0,0,0], [[], objNull]]; if (typeName _position == "OBJECT") then {_position = position _position};
	private _type = param [1, "mil_unknown", [""]];
	private _color = param [2, "ColorWhite", [""]];
	private _text = param [3, "", [""]];
	private _lifeTime = param [4, "distance", [""]];

// =========================================================================================================
// SETTING MARKER NAME
// =========================================================================================================

	private ["_markerName"];
	switch _text do
		{
			case OPEX_friendly_camp				:	{_markerName = "OPEX_marker_camp"};
			case "STR_marker_gate"				:	{_markerName = format ["OPEX_marker_gate_%1", ceil random 100000]};
			case "STR_marker_ammoDepot"			:	{_markerName = "OPEX_marker_ammo"};
			case "STR_marker_armory"			:	{_markerName = "OPEX_marker_armory"};
			case "STR_marker_canteen"			:	{_markerName = "OPEX_marker_canteen"};
			case "STR_marker_delivery"			:	{_markerName = "OPEX_marker_delivery"};
			case "STR_marker_dormitory"			:	{_markerName = "OPEX_marker_dormitory"};
			case "STR_marker_fitness"			:	{_markerName = "OPEX_marker_fitness"};
			case "STR_marker_fuel"				:	{_markerName = "OPEX_marker_fuel"};
			case "STR_marker_jail"				:	{_markerName = "OPEX_marker_jail"};
			case "STR_marker_medicalCenter"		:	{_markerName = "OPEX_marker_medical"};
			case "STR_marker_practise"			:	{_markerName = "OPEX_marker_practise"};
			case "STR_marker_shooting"			:	{_markerName = "OPEX_marker_shooting"};
			case "STR_marker_showers"			:	{_markerName = "OPEX_marker_showers"};
			case "STR_marker_toc"				:	{_markerName = "OPEX_marker_toc"};
			case "STR_marker_training"			:	{_markerName = "OPEX_marker_training"};
			case "STR_marker_workshop"			:	{_markerName = "OPEX_marker_workshop"};
			case "STR_marker_recreation"		:	{_markerName = "OPEX_marker_recreation"};
			case "STR_marker_seaport"			:	{_markerName = "OPEX_marker_seaport"};
			case default 							{_markerName = format ["OPEX_marker_unnamed_%1", ceil random 100000]};
		};

// =========================================================================================================
// CREATING MARKER
// =========================================================================================================

	_debugMarker = createMarker [_markerName, _position];
	_debugMarker setMarkerType _type;
	_debugMarker setMarkerColor _color;
	if (!(_text isEqualTo "")) then {[_debugMarker, _text] remoteExec ["Gemini_fnc_setMarkerText", 0, true]}; // localizing marker text
	[_debugMarker, _lifeTime] call Gemini_fnc_setLifeTime; // setting marker life time

// =================================================================================================
// RETURNING CREATED MARKER
// =================================================================================================

	_debugMarker