// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================


// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	private ["_caller"];
	_caller = _this select 1;

// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================

	private ["_mainTitle", "_listTitle", "_listContent"];
	_mainTitle = 600;
	_listTitle = 603;
	_listContent = 604;
	_buyButton = 605;
	_closeButton = 606;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	//if ((_caller != leader _caller) && (!isNull (leader _caller))) then {[group _caller, _caller] remoteExec ["selectLeader", groupOwner group _caller]}; // if caller leader is dead, caller becomes the new leader
	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can do this !

// =========================================================================================================
// CREATING DIALOG INTERFACE
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_buyVehicles";

	// DISPLAYING TITLES
		lnbClear _listTitle;
		lnbAddRow [_listTitle,[localize "STR_dialog_buyVehiclesListTitle", "", localize "STR_cost"]];

	// DISPLAYING AVAILABLE Vehicles
		lnbClear _listContent;
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_quickTransport", format ["%1", abs OPEX_cost_fastTransport]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_transportCar", format ["%1", abs OPEX_cost_transportCar]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_armedCar", format ["%1", abs OPEX_cost_armedCar]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_transportTruck", format ["%1", abs OPEX_cost_transportTruck]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_lightArmored", format ["%1", abs OPEX_cost_lightArmored]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_heavyArmored", format ["%1", abs OPEX_cost_heavyArmored]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_transportChopper", format ["%1", abs OPEX_cost_transportChopper]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_armedChopper", format ["%1", abs OPEX_cost_armedChopper]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_static", format ["%1", abs OPEX_cost_static]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_mortar", format ["%1", abs OPEX_cost_mortar]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_drone", format ["%1", abs OPEX_cost_drone]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_uav", format ["%1", abs OPEX_cost_UAV]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_boat", format ["%1", abs OPEX_cost_boat]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_medicalTruck", format ["%1", abs OPEX_cost_supplyTruck]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_refuelTruck", format ["%1", abs OPEX_cost_supplyTruck]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_repairTruck", format ["%1", abs OPEX_cost_supplyTruck]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_rearmTruck", format ["%1", abs OPEX_cost_supplyTruck]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buyVehicles_mobileHQ", format ["%1", abs OPEX_cost_mobileHQ]]];

	// DISPLAYING SUPPLY PICTURES
		lnbSetPicture [_listContent, [0, 0], "\A3\Soft_F\Quadbike_01\Data\UI\Quadbike_01_CA.paa"];
		lnbSetPicture [_listContent, [1, 0], "\A3\Soft_F\MRAP_02\Data\UI\MRAP_02_base_CA.paa"];
		lnbSetPicture [_listContent, [2, 0], "\A3\Soft_F\MRAP_02\Data\UI\MRAP_02_HMG_ca.paa"];
		lnbSetPicture [_listContent, [3, 0], "\A3\Soft_F_EPC\Truck_03\Data\UI\truck_03_transport_CA.paa"];
		lnbSetPicture [_listContent, [4, 0], "\A3\Armor_F_Beta\APC_Wheeled_02\Data\UI\APC_Wheeled_02_RCWS_CA.paa"];
		lnbSetPicture [_listContent, [5, 0], "\A3\armor_f_gamma\MBT_02\Data\UI\MBT_02_Base_ca.paa"];
		lnbSetPicture [_listContent, [6, 0], "\A3\air_f_beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"];
		lnbSetPicture [_listContent, [7, 0], "\A3\Air_F_Beta\Heli_Attack_01\Data\UI\Heli_Attack_01_CA.paa"];
		lnbSetPicture [_listContent, [8, 0], "\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa"];
		lnbSetPicture [_listContent, [9, 0], "\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa"];
		lnbSetPicture [_listContent, [10, 0], "\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa"];
		lnbSetPicture [_listContent, [11, 0], "\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UI\UAV_02_base_F.paa"];
		lnbSetPicture [_listContent, [12, 0], "\A3\boat_F\Boat_Transport_01\data\UI\Boat_Transport_01_CA.paa"];
		lnbSetPicture [_listContent, [13, 0], "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_box_F_CA.paa"];
		lnbSetPicture [_listContent, [14, 0], "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_box_F_CA.paa"];
		lnbSetPicture [_listContent, [15, 0], "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_box_F_CA.paa"];
		lnbSetPicture [_listContent, [16, 0], "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_box_F_CA.paa"];
		lnbSetPicture [_listContent, [17, 0], "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_box_F_CA.paa"];

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
					private ["_selectedSupply"];
					if (lbCurSel _listContent == -1) then {_selectedSupply = -1};
					if (lbCurSel _listContent == 0) then {_selectedSupply = 0};
					if (lbCurSel _listContent == 1) then {_selectedSupply = 1};
					if (lbCurSel _listContent == 2) then {_selectedSupply = 2};
					if (lbCurSel _listContent == 3) then {_selectedSupply = 3};
					if (lbCurSel _listContent == 4) then {_selectedSupply = 4};
					if (lbCurSel _listContent == 5) then {_selectedSupply = 5};
					if (lbCurSel _listContent == 6) then {_selectedSupply = 6};
					if (lbCurSel _listContent == 7) then {_selectedSupply = 7};
					if (lbCurSel _listContent == 8) then {_selectedSupply = 8};
					if (lbCurSel _listContent == 9) then {_selectedSupply = 9};
					if (lbCurSel _listContent == 10) then {_selectedSupply = 10};
					if (lbCurSel _listContent == 11) then {_selectedSupply = 11};
					if (lbCurSel _listContent == 12) then {_selectedSupply = 12};
					if (lbCurSel _listContent == 13) then {_selectedSupply = 13};
					if (lbCurSel _listContent == 14) then {_selectedSupply = 14};
					if (lbCurSel _listContent == 15) then {_selectedSupply = 15};
					if (lbCurSel _listContent == 16) then {_selectedSupply = 16};
					if (lbCurSel _listContent == 17) then {_selectedSupply = 17};

				// UPDATING ORDER BUTTON
					if (OPEX_stats_faction select 14 <= 0) then {ctrlEnable [_buyButton, false]} else {ctrlEnable [_buyButton, true]};
					buttonSetAction [_buyButton, format ["[player, %1] remoteExecCall ['Gemini_fnc_buyVehicles', 2, false]", _selectedSupply]];
			};