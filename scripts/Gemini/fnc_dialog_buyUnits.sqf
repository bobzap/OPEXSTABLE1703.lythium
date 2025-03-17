// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================


// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private
		[
			"_caller",
			"_currentUnits",
			"_availableUnits",
			"_enlist",
			"_demobilize",
			"_close",
			"_globalStats",
			"_roleList"
		];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	_caller = _this select 1;

// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================

	_currentUnitsTitle = 502;
	_currentUnits = 503;
	_availableUnitsTitle = 505;
	_availableUnits = 506;
	_enlist = 507;
	_demobilize = 508;
	_close = 509;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	//if ((_caller != leader _caller) && (!isNull (leader _caller))) then {[group _caller, _caller] remoteExec ["selectLeader", groupOwner group _caller]}; // if caller leader is dead, caller becomes the new leader
	if ((_caller != leader _caller) && (!isNull (leader _caller))) exitWith {hint localize "STR_hint_leaderOnly"}; // only team leaders can do this !

// =========================================================================================================
// CREATING DIALOG INTERFACE
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_buyUnits";

	// DISPLAYING TITLES
		ctrlSetText [_currentUnitsTitle, toUpper localize "STR_dialog_buyUnitsCurrentTeam"];
		{lbAdd [_currentUnits, name _x]} forEach units (group _caller);
		lnbClear _availableUnitsTitle;
		lnbAddRow [_availableUnitsTitle, [toUpper localize "STR_dialog_buyUnitsAvailableUnits", toUpper localize "STR_cost"]];

	// DISPLAYING AVAILABLE SUPPLIES
		lnbClear _availableUnits;
		lnbAddRow [_availableUnits, [localize "STR_rifleman", format ["%1", abs OPEX_cost_rifleman]]];
		lnbAddRow [_availableUnits, [localize "STR_grenadier", format ["%1", abs OPEX_cost_grenadier]]];
		lnbAddRow [_availableUnits, [localize "STR_mgLight", format ["%1", abs OPEX_cost_mgLight]]];
		lnbAddRow [_availableUnits, [localize "STR_mgHeavy", format ["%1", abs OPEX_cost_mgHeavy]]];
		lnbAddRow [_availableUnits, [localize "STR_marksman", format ["%1", abs OPEX_cost_marksman]]];
		lnbAddRow [_availableUnits, [localize "STR_ghillieSniper", format ["%1", abs OPEX_cost_ghillieSniper]]];
		lnbAddRow [_availableUnits, [localize "STR_ghillieSpotter", format ["%1", abs OPEX_cost_ghillieSpotter]]];
		lnbAddRow [_availableUnits, [localize "STR_at", format ["%1", abs OPEX_cost_at]]];
		lnbAddRow [_availableUnits, [localize "STR_aa", format ["%1", abs OPEX_cost_aa]]];
		lnbAddRow [_availableUnits, [localize "STR_sapper", format ["%1", abs OPEX_cost_sapper]]];
		lnbAddRow [_availableUnits, [localize "STR_scout", format ["%1", abs OPEX_cost_scout]]];
		lnbAddRow [_availableUnits, [localize "STR_repairer", format ["%1", abs OPEX_cost_repairer]]];
		lnbAddRow [_availableUnits, [localize "STR_ammoAssistant", format ["%1", abs OPEX_cost_ammoAssistant]]];
		lnbAddRow [_availableUnits, [localize "STR_assault", format ["%1", abs OPEX_cost_assault]]];
		lnbAddRow [_availableUnits, [localize "STR_medic", format ["%1", abs OPEX_cost_medic]]];
		lnbAddRow [_availableUnits, [localize "STR_teamLeader", format ["%1", abs OPEX_cost_teamLeader]]];
		lnbAddRow [_availableUnits, [localize "STR_chopperPilot", format ["%1", abs OPEX_cost_chopperPilot]]];
		lnbAddRow [_availableUnits, [localize "STR_aircraftPilot", format ["%1", abs OPEX_cost_aircraftPilot]]];
		lnbAddRow [_availableUnits, [localize "STR_crewman", format ["%1", abs OPEX_cost_crewman]]];
		lnbAddRow [_availableUnits, [localize "STR_diver", format ["%1", abs OPEX_cost_diver]]];
		lnbAddRow [_availableUnits, [localize "STR_radioOperator", format ["%1", abs OPEX_cost_radioOperator]]];
		lnbAddRow [_availableUnits, [localize "STR_droneOperator", format ["%1", abs OPEX_cost_droneOperator]]];
		lnbAddRow [_availableUnits, [localize "STR_interpret", format ["%1", abs OPEX_cost_interpret]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_infantryFull", format ["%1", abs OPEX_cost_squad_infantryFull]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_infantryLight", format ["%1", abs OPEX_cost_squad_infantryLight]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_reco", format ["%1", abs OPEX_cost_squad_reco]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_assaultLong", format ["%1", abs OPEX_cost_squad_assaultLong]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_assaultShort", format ["%1", abs OPEX_cost_squad_assaultShort]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_at", format ["%1", abs OPEX_cost_squad_at]]];
		lnbAddRow [_availableUnits, [localize "STR_squad_rescue", format ["%1", abs OPEX_cost_squad_rescue]]];
		lnbSort [_availableUnits, 0];

	// INITIALIZING BUTTONS
		ctrlSetText [_close, toUpper localize "STR_dialog_close"];
		buttonSetAction [_demobilize, "if (lbCurSel 503 != -1) then {if (player != ((units group player) select (lbCurSel 503))) then {OPEX_stats_faction set [14, (OPEX_stats_faction select 14) + abs (((units group player) select (lbCurSel 503)) getVariable ['value', 0])]; publicVariable 'OPEX_stats_faction';; deleteVehicle ((units group player) select (lbCurSel 503)); lbDelete [503, lbCurSel 503]}}"];

		buttonSetAction [_close, "closeDialog 0"];

	// UPDATING CREDITS (GLOBAL STATS)
		while {dialog} do
			{
				sleep 0.01;

				if (["[", lbText [_availableUnits, lbCurSel _availableUnits * 2]] call BIS_fnc_inString)
				then {buttonSetAction [_enlist, format ["[player, ""%1""] spawn Gemini_fnc_buySquads", lbText [_availableUnits, lbCurSel _availableUnits * 2]]]}
				else {buttonSetAction [_enlist, "[player] spawn Gemini_fnc_buyUnits"]};

				//if (lbCurSel _currentUnits > -1) then {ctrlEnable [_availableUnits, false]} else {ctrlEnable [_availableUnits, true]};
				//if (lbCurSel _availableUnits > -1) then {ctrlEnable [_currentUnits, false]} else {ctrlEnable [_currentUnits, true]};

				// UPDATING TEXT DISPLAYED ON ORDER BUTTON
					ctrlSetText [_enlist, format [localize "STR_dialog_mobilizeUnit", OPEX_stats_faction select 14]];
					ctrlSetText [_demobilize, format [localize "STR_dialog_demobilizeUnit", toUpper (lbText [_currentUnits, lbCurSel _currentUnits])]];

					if (OPEX_stats_faction select 14 <= 0) then {ctrlEnable [_enlist, false]} else {ctrlEnable [_enlist, true]};
			};