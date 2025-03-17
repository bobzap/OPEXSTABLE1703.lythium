/*
	if called from server:
		["intel", 10] call Gemini_fnc_bonus;
		["support", "airStrike"] call Gemini_fnc_bonus;
		["reputation", 0.1] call Gemini_fnc_bonus;
		["supply", "weapon"] call Gemini_fnc_bonus;

	if called from client:
		["intel", 10] remoteExecCall ["Gemini_fnc_bonus", 2];
		["support", "airStrike"] remoteExecCall ["Gemini_fnc_bonus", 2];
		["reputation", 0.1] remoteExecCall ["Gemini_fnc_bonus", 2];
		["supply", "weapon"] remoteExecCall ["Gemini_fnc_bonus", 2];
*/

private _type = param [0, "none", [""]];
private _value = param [1, [], [0, ""]];

if (_type == "none") exitWith {};

switch (_type) do
	{
		case "intel":
			{
				OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + _value];
				publicVariable "OPEX_stats_faction";
				["hint","STR_hint_intelGathered"] remoteExec ["Gemini_fnc_globalHint"];
			};

		case "support":
			{
				[_value] remoteExec ["Gemini_fnc_addSupport", 2];
			};

		case "reputation":
			{
				OPEX_stats_faction set [18, (OPEX_stats_faction select 18) + _value];
				["hint","STR_hint_reputationBoost"] remoteExec ["Gemini_fnc_globalHint"];
			};

		case "supply":
			{
				private ["_crateType"];
				switch (_value) do
					{
						case "weapons"		:		{_crateType = "Box_NATO_Wps_F"};
						case "launchers"	:		{_crateType = "Box_NATO_WpsLaunch_F"};
						case "ammo"			:		{_crateType = "Box_NATO_Ammo_F"};
						case "grenades"		:		{_crateType = "Box_NATO_Grenades_F"};
						case "explosives"	:		{_crateType = "Box_NATO_AmmoOrd_F"};
						case "accessories"	:		{_crateType = "Box_NATO_Support_F"};
						case "clothes"		:		{_crateType = "Box_NATO_Uniforms_F"};
						case "medical"		:		{_crateType = "Box_NATO_Equip_F"};
						case "food"			:		{_crateType = "Box_NATO_WpsSpecial_F"};
						case "random"		:		{_crateType = selectRandom ["Box_NATO_Wps_F", "Box_NATO_WpsLaunch_F", "Box_NATO_Ammo_F", "Box_NATO_Grenades_F", "Box_NATO_AmmoOrd_F", "Box_NATO_Support_F", "Box_NATO_Uniforms_F", "Box_NATO_Equip_F", "Box_NATO_WpsSpecial_F"]};
						case default				{_crateType = "Box_NATO_Wps_F"};
					};
				private ["_crate"];
				_crate = _crateType createVehicle (position OPEX_deliveryZone);
				_crate remoteExec ["Gemini_fnc_fillCrate", 2];
				["hint","STR_hint_newSuppliesDelivered"] remoteExec ["Gemini_fnc_globalHint"];
			};
	};