// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private ["_caller"];
	_caller = _this select 1;

// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================

	private ["_mainTitle", "_listTitle", "_listContent"];
	_mainTitle = 900;
	_listTitle = 903;
	_listContent = 904;
	_buyButton = 905;
	_closeButton = 906;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	//if ((_caller != leader _caller) && (!isNull (leader _caller))) then {[group _caller, _caller] remoteExec ["selectLeader", groupOwner group _caller]}; // if caller leader is dead, caller becomes the new leader
	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can do this !

// =========================================================================================================
// CREATING DIALOG INTERFACE
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_buySupports";

	// DISPLAYING TITLES
		lnbClear _listTitle;
		lnbAddRow [_listTitle,[localize "STR_dialog_buySupportsListTitle", "", localize "STR_cost"]];

	// DISPLAYING AVAILABLE SUPPORTS
		lnbClear _listContent;
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_suppliesDrop", format ["%1", abs OPEX_cost_suppliesDrop]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_vehicleDrop", format ["%1", abs OPEX_cost_vehicleDrop]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_transport", format ["%1", abs OPEX_cost_transport]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_landAssistance", format ["%1", abs OPEX_cost_landAssistance]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_airAssistance", format ["%1", abs OPEX_cost_airAssistance]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_artilleryStrike", format ["%1", abs OPEX_cost_artilleryStrike]]];
		lnbAddRow [_listContent, ["", localize "STR_OPEX_support_airStrike", format ["%1", abs OPEX_cost_airStrike]]];


	// DISPLAYING SUPPLY PICTURES
		lnbSetPicture [_listContent, [0, 0], "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa"];
		lnbSetPicture [_listContent, [1, 0], "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa"];
		lnbSetPicture [_listContent, [2, 0], "\A3\air_f_beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"];
		lnbSetPicture [_listContent, [3, 0], "\a3\soft_f_beta\Truck_01\Data\UI\Truck_01_covered_CA.paa"];
		lnbSetPicture [_listContent, [4, 0], "\A3\Air_F_Beta\Heli_Attack_01\Data\UI\Heli_Attack_01_CA.paa"];
		lnbSetPicture [_listContent, [5, 0], "\A3\Armor_F_Gamma\MBT_01\Data\UI\Slammer_Scorcher_M4_Base_ca.paa"];
		lnbSetPicture [_listContent, [6, 0], "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa"];

	// DISPLAYING BUTTONS
		ctrlSetText [_buyButton, format [localize "STR_dialog_orderButton", OPEX_stats_faction select 14]]; // order button
		ctrlSetText [_closeButton, toUpper localize "STR_dialog_close"]; buttonSetAction [_closeButton, "closeDialog 0"]; // exit button

	// MONITORING ACTIONS
		while {dialog} do
			{
				sleep 0.01;

				// UPDATING CURRENT STATS (CREDITS) DISPLAYED ON ORDER BUTTON
					ctrlSetText [_buyButton, format [localize "STR_dialog_orderButton", OPEX_stats_faction select 14]];

				// CHECKING WHAT SUPPLY IS SELECTED
					private ["_selectedSupports"];
					if (lbCurSel _listContent == -1) then {_selectedSupports = -1};
					if (lbCurSel _listContent == 0) then {_selectedSupports = 0};
					if (lbCurSel _listContent == 1) then {_selectedSupports = 1};
					if (lbCurSel _listContent == 2) then {_selectedSupports = 2};
					if (lbCurSel _listContent == 3) then {_selectedSupports = 3};
					if (lbCurSel _listContent == 4) then {_selectedSupports = 4};
					if (lbCurSel _listContent == 5) then {_selectedSupports = 5};
					if (lbCurSel _listContent == 6) then {_selectedSupports = 6};

				// UPDATING ORDER BUTTON
					if (OPEX_stats_faction select 14 <= 0) then {ctrlEnable [_buyButton, false]} else {ctrlEnable [_buyButton, true]};
					buttonSetAction [_buyButton, format ["[player, %1] spawn Gemini_fnc_buySupports", _selectedSupports]];
			};