// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private ["_caller", "_selectedSupport"];
	_caller = _this select 0;
	_selectedSupport = _this select 1;

// =========================================================================================================
// CHECKING IF SUPPORT IS ALREADY ASSIGNED
// =========================================================================================================

	if (_selectedSupport == 0 && OPEX_support_suppliesDrop) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 1 && OPEX_support_vehicleDrop) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 2 && OPEX_support_transport) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 3 && OPEX_support_landAssistance) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 4 && OPEX_support_airAssistance) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 5 && OPEX_support_artilleryStrike) exitWith {hint localize "STR_support_ready"};
	if (_selectedSupport == 6 && OPEX_support_airStrike) exitWith {hint localize "STR_support_ready"};

// =========================================================================================================
// SUPPORTS
// =========================================================================================================

	// GETTING CURRRENT INTEL LEVEL
	private ["_intel"];
	_intel = OPEX_stats_faction select 14;

	// ASSIGNING NEW SUPPORT
	private ["_cost"];
	switch (_selectedSupport) do
		{
			case 0	:	{_cost = (abs OPEX_cost_suppliesDrop); if (_intel >= _cost) then {["suppliesDrop"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 1	:	{_cost = (abs OPEX_cost_vehicleDrop); if (_intel >= _cost) then {["vehicleDrop"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 2	:	{_cost = (abs OPEX_cost_transport); if (_intel >= _cost) then {["transport"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 3	:	{_cost = (abs OPEX_cost_landAssistance); if (_intel >= _cost) then {["landAssistance"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 4	:	{_cost = (abs OPEX_cost_airAssistance); if (_intel >= _cost) then {["airAssistance"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 5	:	{_cost = (abs OPEX_cost_artilleryStrike); if (_intel >= _cost) then {["artilleryStrike"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
			case 6	:	{_cost = (abs OPEX_cost_airStrike); if (_intel >= _cost) then {["airStrike"] remoteExec ["Gemini_fnc_addSupport"]} else {hint localize "STR_hint_globalStatsTooLow"}};
		};

		// UPDATING INTEL LEVEL
	if (_intel >= _cost) then
		{
			OPEX_stats_faction set [14, _intel - _cost];
			publicVariable "OPEX_stats_faction";
		};