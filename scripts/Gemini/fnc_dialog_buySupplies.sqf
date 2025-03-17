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

	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can do this !

// =========================================================================================================
// CREATING DIALOG INTERFACE
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_buySupplies";

	// DISPLAYING TITLES
		lnbClear _listTitle;
		lnbAddRow [_listTitle,[localize "STR_dialog_buySuppliesListTitle", "", localize "STR_cost"]];

	// DISPLAYING AVAILABLE SUPPLIES
		lnbClear _listContent;
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesWeapons", format ["%1", abs OPEX_cost_weapons]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesLaunchers", format ["%1", abs OPEX_cost_launchers]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesAmmo", format ["%1", abs OPEX_cost_ammo]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesGrenades", format ["%1", abs OPEX_cost_grenades]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesExplosives", format ["%1", abs OPEX_cost_explosives]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesAccessories", format ["%1", abs OPEX_cost_accessories]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesClothes", format ["%1", abs OPEX_cost_clothes]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesMedical", format ["%1", abs OPEX_cost_medical]]];
		lnbAddRow [_listContent, ["", localize "STR_dialog_buySuppliesCanteen", format ["%1", abs OPEX_cost_canteenSupplies]]];

	// DISPLAYING SUPPLY PICTURES
		lnbSetPicture [_listContent, [0, 0], "\A3\Weapons_F_EPB\Rifles\MX_Black\Data\UI\gear_mx_rifle_black_X_CA.paa"];
		lnbSetPicture [_listContent, [1, 0], "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_ca.paa"];
		lnbSetPicture [_listContent, [2, 0], "\A3\Weapons_F_Mark\Data\UI\M_127x54_CA.paa"];
		lnbSetPicture [_listContent, [3, 0], "\A3\Weapons_F\Data\UI\gear_M67_CA.paa"];
		lnbSetPicture [_listContent, [4, 0], "\A3\Weapons_F\Data\UI\gear_c4_charge_small_CA.paa"];
		lnbSetPicture [_listContent, [5, 0], "\A3\weapons_F_beta\Data\UI\gear_acco_MRCO_CA.paa"];
		lnbSetPicture [_listContent, [6, 0], "\A3\characters_f\data\ui\icon_U_OI_CombatUniform_ocamo_ca.paa"];
		lnbSetPicture [_listContent, [7, 0], "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa"];
		if (isClass (configFile >> "CfgPatches" >> "Gemini_items"))
			then {lnbSetPicture [_listContent, [8, 0], "\Gemini_items\pictures\bottle.paa"]}
			else {lnbSetPicture [_listContent, [8, 0], "\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa"]};

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

				// UPDATING ORDER BUTTON
					if (OPEX_stats_faction select 14 <= 0) then {ctrlEnable [_buyButton, false]} else {ctrlEnable [_buyButton, true]};
					buttonSetAction [_buyButton, format ["[player, %1] spawn Gemini_fnc_buySupplies", _selectedSupply]];
			};