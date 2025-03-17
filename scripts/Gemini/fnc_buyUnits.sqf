// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================

// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private
		[
			"_currentUnits",
			"_availableUnits",
			"_randomUnit",
			"_selectedRole",
			"_unit"
		];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	_caller = _this select 0;

// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================

	_currentUnits = 503;
	_availableUnits = 506;
	_randomUnit = nil;
	_selectedRole = nil;

	// GETTING CURRRENT INTEL LEVEL
	private ["_intel"];
	_intel = OPEX_stats_faction select 14;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	//if (isMultiplayer && (count (units (group _caller)) >= 5)) exitWith {hint localize "STR_hint_fullTeam"};
	//if (!isMultiplayer && (count (units (group _caller)) >= 10)) exitWith {hint localize "STR_hint_fullTeam"};
	if ((_intel < abs OPEX_cost_rifleman) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_rifleman")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_scout) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_scout")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_grenadier) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_grenadier")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_mgLight) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_mgLight")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_mgHeavy) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_mgHeavy")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_at) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_at")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_ghillieSniper) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ghillieSniper")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_ghillieSpotter) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ghillieSpotter")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_medic) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_medic")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_sapper) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_sapper")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_marksman) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_marksman")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_assault) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_assault")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_diver) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_diver")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_teamLeader) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_teamLeader")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_aa) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_aa")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_chopperPilot) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_chopperPilot")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_aircraftPilot) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_aircraftPilot")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_ammoAssistant) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ammoAssistant")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_repairer) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_repairer")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_crewman) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_crewman")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_radioOperator) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_radioOperator")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_droneOperator) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_droneOperator")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_interpret) && ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_interpret")) exitWith {hint localize "STR_hint_globalStatsTooLow"};

// =========================================================================================================
// SELECTING UNIT TYPE
// =========================================================================================================

	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_rifleman") then {_randomUnit = OPEX_friendly_rifleman; _selectedRole = "rifleman"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_scout") then {_randomUnit = OPEX_friendly_scout; _selectedRole = "scout"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_grenadier") then {_randomUnit = OPEX_friendly_grenadier; _selectedRole = "grenadier"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_mgLight") then {_randomUnit = OPEX_friendly_MGLight; _selectedRole = "mgLight"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_mgHeavy") then {_randomUnit = OPEX_friendly_MGHeavy; _selectedRole = "mgHeavy"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_at") then {_randomUnit = OPEX_friendly_AT; _selectedRole = "at"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ghillieSniper") then {_randomUnit = OPEX_friendly_ghillie; _selectedRole = "ghillieSniper"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ghillieSpotter") then {_randomUnit = OPEX_friendly_spotter; _selectedRole = "ghillieSpotter"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_medic") then {_randomUnit = OPEX_friendly_medic; _selectedRole = "medic"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_sapper") then {_randomUnit = OPEX_friendly_sapper; _selectedRole = "sapper"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_marksman") then {_randomUnit = OPEX_friendly_marksman; _selectedRole = "marksman"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_assault") then {_randomUnit = OPEX_friendly_rifleman; _selectedRole = "assault"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_diver") then {_randomUnit = OPEX_friendly_diver; _selectedRole = "diver"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_teamLeader") then {_randomUnit = OPEX_friendly_teamLeader; _selectedRole = "teamLeader"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_aa") then {_randomUnit = OPEX_friendly_AA; _selectedRole = "aa"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_chopperPilot") then {_randomUnit = OPEX_friendly_chopper_pilot; _selectedRole = "chopperPilot"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_aircraftPilot") then {_randomUnit = OPEX_friendly_aircraft_pilot; _selectedRole = "aircraftPilot"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_ammoAssistant") then {_randomUnit = OPEX_friendly_ammoAssistant; _selectedRole = "ammoAssistant"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_repairer") then {_randomUnit = OPEX_friendly_repairer; _selectedRole = "repairer"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_crewman") then {_randomUnit = OPEX_friendly_crewman; _selectedRole = "crewman"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_radioOperator") then {_randomUnit = OPEX_friendly_radioOperator; _selectedRole = "radioOperator"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_droneOperator") then {_randomUnit = OPEX_friendly_droneOperator; _selectedRole = "droneOperator"};
	if ((lbText [_availableUnits, lbCurSel _availableUnits * 2]) == localize "STR_interpret") then {_randomUnit = OPEX_friendly_interpret; _selectedRole = "interpret"};
	if ((isNil "_randomUnit") || (isNil "_selectedRole")) exitWith {};

// =========================================================================================================
// SPAWNING UNIT AND UPDATING STATS (BY SERVER)
// =========================================================================================================

	[
		[_intel, _caller, _randomUnit, _selectedRole],
		{

			private ["_intel", "_unit", "_caller", "_randomUnit", "_selectedRole"];
			_intel = _this select 0;
			_caller = _this select 1;
			_randomUnit = _this select 2;
			_selectedRole = _this select 3;

			// =========================================================================================================
			// SPAWNING UNIT
			// =========================================================================================================

				if (isNil "OPEX_deliveryZone") then {OPEX_deliveryZone = position _caller};
				_unit = [side _caller, group _caller, [_randomUnit], (position OPEX_deliveryZone), OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
				_unit spawn {sleep 5; _this setBehaviour "aware"};
				_unit allowDamage false; [_unit] spawn {sleep 3; (_this select 0) allowDamage true}; // prevents bug when spawning
				addSwitchableUnit _unit; // setting team switch availability

			// =========================================================================================================
			// UPDATING STATS
			// =========================================================================================================

				private ["_cost"];
				if (_selectedRole == "rifleman") then {_cost = abs OPEX_cost_rifleman};
				if (_selectedRole == "scout") then {_cost = abs OPEX_cost_scout};
				if (_selectedRole == "grenadier") then {_cost = abs OPEX_cost_grenadier};
				if (_selectedRole == "mgLight") then {_cost = abs OPEX_cost_mgLight};
				if (_selectedRole == "mgHeavy") then {_cost = abs OPEX_cost_mgHeavy};
				if (_selectedRole == "at") then {_cost = abs OPEX_cost_at};
				if (_selectedRole == "ghillieSniper") then {_cost = abs OPEX_cost_ghillieSniper};
				if (_selectedRole == "ghillieSpotter") then {_cost = abs OPEX_cost_ghillieSpotter};
				if (_selectedRole == "medic") then {_cost = abs OPEX_cost_medic};
				if (_selectedRole == "sapper") then {_cost = abs OPEX_cost_sapper};
				if (_selectedRole == "marksman") then {_cost = abs OPEX_cost_marksman};
				if (_selectedRole == "assault") then {_cost = abs OPEX_cost_assault};
				if (_selectedRole == "diver") then {_cost = abs OPEX_cost_diver};
				if (_selectedRole == "teamLeader") then {_cost = abs OPEX_cost_teamLeader};
				if (_selectedRole == "aa") then {_cost = abs OPEX_cost_aa};
				if (_selectedRole == "chopperPilot") then {_cost = abs OPEX_cost_chopperPilot};
				if (_selectedRole == "aircraftPilot") then {_cost = abs OPEX_cost_aircraftPilot};
				if (_selectedRole == "ammoAssistant") then {_cost = abs OPEX_cost_ammoAssistant};
				if (_selectedRole == "repairer") then {_cost = abs OPEX_cost_repairer};
				if (_selectedRole == "crewman") then {_cost = abs OPEX_cost_crewman};
				if (_selectedRole == "radioOperator") then {_cost = abs OPEX_cost_radioOperator};
				if (_selectedRole == "droneOperator") then {_cost = abs OPEX_cost_droneOperator};
				if (_selectedRole == "interpret") then {_cost = abs OPEX_cost_interpret};
				_unit setVariable ["value", _cost, true];
				OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
				//[OPEX_friendly_side1, "Base", "STR_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];

			// =========================================================================================================
			// SETTING LOADOUT
			// =========================================================================================================

				sleep 0.1;
				if (_selectedRole == "rifleman") then {[_unit, {_this execVM "loadouts\full\rifleman.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "scout") then {[_unit, {_this execVM "loadouts\full\scout.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "grenadier") then {[_unit, {_this execVM "loadouts\full\grenadier.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "mgLight") then {[_unit, {_this execVM "loadouts\full\mgLight.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "mgHeavy") then {[_unit, {_this execVM "loadouts\full\mgHeavy.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "at") then {[_unit, {_this execVM "loadouts\full\at.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "ghillieSniper") then {[_unit, {_this execVM "loadouts\full\ghillieSniper.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "ghillieSpotter") then {[_unit, {_this execVM "loadouts\full\ghillieSpotter.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "medic") then {[_unit, {_this execVM "loadouts\full\medic.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "sapper") then {[_unit, {_this execVM "loadouts\full\sapper.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "marksman") then {[_unit, {_this execVM "loadouts\full\marksman.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "assault") then {[_unit, {_this execVM "loadouts\full\assault.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "diver") then {[_unit, {_this execVM "loadouts\full\diver.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "teamLeader") then {[_unit, {_this execVM "loadouts\full\teamLeader.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "chopperPilot") then {[_unit, {_this execVM "loadouts\full\chopperPilot.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "aircraftPilot") then {[_unit, {_this execVM "loadouts\full\aircraftPilot.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "ammoAssistant") then {[_unit, {_this execVM "loadouts\full\ammoAssistant.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "aa") then {[_unit, {_this execVM "loadouts\full\aa.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "repairer") then {[_unit, {_this execVM "loadouts\full\repairer.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "crewman") then {[_unit, {_this execVM "loadouts\full\crewman.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "radioOperator") then {[_unit, {_this execVM "loadouts\full\radioOperator.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "droneOperator") then {[_unit, {_this execVM "loadouts\full\droneOperator.sqf"}] remoteExec ["spawn", _unit]};
				if (_selectedRole == "interpret") then {[_unit, {_this execVM "loadouts\full\interpret.sqf"}] remoteExec ["spawn", _unit]};

				/*
				if (_selectedRole == "rifleman") then {[_unit] execVM "loadouts\full\rifleman.sqf"};
				if (_selectedRole == "scout") then {[_unit] execVM "loadouts\full\scout.sqf"};
				if (_selectedRole == "grenadier") then {[_unit] execVM "loadouts\full\grenadier.sqf"};
				if (_selectedRole == "mgLight") then {[_unit] execVM "loadouts\full\mgLight.sqf"};
				if (_selectedRole == "mgHeavy") then {[_unit] execVM "loadouts\full\mgHeavy.sqf"};
				if (_selectedRole == "at") then {[_unit] execVM "loadouts\full\at.sqf"};
				if (_selectedRole == "ghillieSniper") then {[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
				if (_selectedRole == "ghillieSpotter") then {[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
				if (_selectedRole == "medic") then {[_unit] execVM "loadouts\full\medic.sqf"; _unit setUnitTrait ["Medic", true]};
				if (_selectedRole == "sapper") then {[_unit] execVM "loadouts\full\sapper.sqf"};
				if (_selectedRole == "marksman") then {[_unit] execVM "loadouts\full\marksman.sqf"};
				if (_selectedRole == "assault") then {[_unit] execVM "loadouts\full\assault.sqf"};
				if (_selectedRole == "diver") then {[_unit] execVM "loadouts\full\diver.sqf"};
				if (_selectedRole == "teamLeader") then {[_unit] execVM "loadouts\full\teamLeader.sqf"};
				if (_selectedRole == "chopperPilot") then {[_unit] execVM "loadouts\full\chopperPilot.sqf"};
				if (_selectedRole == "aircraftPilot") then {[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
				if (_selectedRole == "ammoAssistant") then {[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
				if (_selectedRole == "aa") then {[_unit] execVM "loadouts\full\aa.sqf"};
				if (_selectedRole == "repairer") then {[_unit] execVM "loadouts\full\repairer.sqf"};
				if (_selectedRole == "crewman") then {[_unit] execVM "loadouts\full\crewman.sqf"};
				if (_selectedRole == "radioOperator") then {[_unit] execVM "loadouts\full\radioOperator.sqf"};
				if (_selectedRole == "droneOperator") then {[_unit] execVM "loadouts\full\droneOperator.sqf"};
				if (_selectedRole == "interpret") then {[_unit] execVM "loadouts\full\interpret.sqf"};
				*/

				// this code deletes backpacks that are sometimes spawning on the ground, I don't know why !
				_unit spawn {sleep 1; {deleteVehicle _x} forEach ((_this nearObjects 15) select {typeOf _x == "GroundWeaponHolder"})};
		}
	] remoteExec ["spawn", 2];
	//hint localize "STR_hint_deliveryDone";

// =========================================================================================================
// INITIALIZING UNIT'S RATING
// =========================================================================================================

	//_unit addRating ((rating _unit) * -1);




// =========================================================================================================
// RESETTING DIALOG INTERFACE
// =========================================================================================================

	sleep 0.75;
	lbClear _currentUnits;
	{lbAdd [_currentUnits, name _x]} forEach units (group _caller);