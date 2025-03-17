// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================


// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	private ["_recruiter", "_requestedSquad", "_currentUnits"];
	_recruiter = _this select 0;
	_requestedSquad = _this select 1;
	_currentUnits = 503;

	// GETTING CURRRENT INTEL LEVEL
	private ["_intel"];
	_intel = OPEX_stats_faction select 14;

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	if ((_intel < abs OPEX_cost_squad_infantryFull) && (_requestedSquad == localize "STR_squad_infantryFull")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_infantryLight) && (_requestedSquad == localize "STR_squad_infantryLight")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_reco) && (_requestedSquad == localize "STR_squad_reco")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_assaultLong) && (_requestedSquad == localize "STR_squad_assaultLong")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_assaultShort) && (_requestedSquad == localize "STR_squad_assaultShort")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_at) && (_requestedSquad == localize "STR_squad_at")) exitWith {hint localize "STR_hint_globalStatsTooLow"};
	if ((_intel < abs OPEX_cost_squad_rescue) && (_requestedSquad == localize "STR_squad_rescue")) exitWith {hint localize "STR_hint_globalStatsTooLow"};

// =========================================================================================================
// DEFINING SQUAD COMPOSITION
// =========================================================================================================

	private ["_unitTypes", "_cost"];
	if (_requestedSquad == localize "STR_squad_infantryFull") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_grenadier, OPEX_friendly_marksman, OPEX_friendly_MGLight, OPEX_friendly_MGHeavy, OPEX_friendly_medic, OPEX_friendly_ammoAssistant, OPEX_friendly_AT, OPEX_friendly_radioOperator, OPEX_friendly_repairer, OPEX_friendly_rifleman]};
	if (_requestedSquad == localize "STR_squad_infantryFull") then {_cost = round ((abs OPEX_cost_squad_infantryFull) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_infantryLight") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_grenadier, OPEX_friendly_MGLight, OPEX_friendly_marksman, OPEX_friendly_medic]};
	if (_requestedSquad == localize "STR_squad_infantryLight") then {_cost = round ((abs OPEX_cost_squad_infantryLight) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_reco") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_scout, OPEX_friendly_droneOperator, OPEX_friendly_spotter, OPEX_friendly_ghillie]};
	if (_requestedSquad == localize "STR_squad_reco") then {_cost = round ((abs OPEX_cost_squad_reco) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_assaultLong") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_MGLight, OPEX_friendly_AT, OPEX_friendly_marksman, OPEX_friendly_marksman, OPEX_friendly_MGHeavy, OPEX_friendly_MGHeavy, OPEX_friendly_ammoAssistant, OPEX_friendly_ammoAssistant]};
	if (_requestedSquad == localize "STR_squad_assaultLong") then {_cost = round ((abs OPEX_cost_squad_assaultLong) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_assaultShort") then {_unitTypes = [OPEX_friendly_MGLight, OPEX_friendly_sapper, OPEX_friendly_assault, OPEX_friendly_assault, OPEX_friendly_assault]};
	if (_requestedSquad == localize "STR_squad_assaultShort") then {_cost = round ((abs OPEX_cost_squad_assaultShort) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_at") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_AT, OPEX_friendly_AT, OPEX_friendly_ammoAssistant, OPEX_friendly_sapper]};
	if (_requestedSquad == localize "STR_squad_at") then {_cost = round ((abs OPEX_cost_squad_at) / (count _unitTypes))};
	if (_requestedSquad == localize "STR_squad_rescue") then {_unitTypes = [OPEX_friendly_teamLeader, OPEX_friendly_medic, OPEX_friendly_medic, OPEX_friendly_repairer, OPEX_friendly_ammoAssistant]};
	if (_requestedSquad == localize "STR_squad_rescue") then {_cost = round ((abs OPEX_cost_squad_rescue) / (count _unitTypes))};


// =========================================================================================================
// SPAWNING UNIT AND UPDATING STATS (BY SERVER)
// =========================================================================================================

	[
		[_intel, _recruiter, _unitTypes, _requestedSquad, _cost],
		{

			private ["_intel", "_recruiter", "_unitTypes", "_requestedSquad", "_cost"];
			_intel = _this select 0;
			_recruiter = _this select 1;
			_unitTypes = _this select 2;
			_requestedSquad = _this select 3;
			_cost = _this select 4;

			// =========================================================================================================
			// SPAWNING UNITS
			// =========================================================================================================

				private ["_count", "_squad"];
				_count = 0;
				_squad = [];
				for "_i" from 0 to (count _unitTypes - 1) do
					{
						// CREATING UNIT
						private ["_unit"];
						_unit = [side _recruiter, grpNull, (_unitTypes select _count), (position OPEX_deliveryZone), OPEX_friendly_AIskill] call Gemini_fnc_createUnit;
						_unit allowDamage false;
						[_unit] spawn {sleep 5; (_this select 0) allowDamage true}; // prevents bug when spawning

						// LOADOUTS
						if ((_unitTypes select _count) == OPEX_friendly_rifleman) then {[_unit] execVM "loadouts\full\rifleman.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_teamLeader) then {[_unit] execVM "loadouts\full\teamLeader.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_grenadier) then {[_unit] execVM "loadouts\full\grenadier.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_MGLight) then {[_unit] execVM "loadouts\full\mgLight.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_MGHeavy) then {[_unit] execVM "loadouts\full\mgHeavy.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_AT) then {[_unit] execVM "loadouts\full\at.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_AA) then {[_unit] execVM "loadouts\full\aa.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_ghillie) then {[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_spotter) then {[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_marksman) then {[_unit] execVM "loadouts\full\marksman.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_scout) then {[_unit] execVM "loadouts\full\scout.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_medic) then {[_unit] execVM "loadouts\full\medic.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_repairer) then {[_unit] execVM "loadouts\full\repairer.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_sapper) then {[_unit] execVM "loadouts\full\sapper.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_ammoAssistant) then {[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_chopper_pilot) then {[_unit] execVM "loadouts\full\chopperPilot.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_aircraft_pilot) then {[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_diver) then {[_unit] execVM "loadouts\full\diver.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_assault) then {[_unit] execVM "loadouts\full\assault.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_crewman) then {[_unit] execVM "loadouts\full\crewman.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_radioOperator) then {[_unit] execVM "loadouts\full\radioOperator.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_droneOperator) then {[_unit] execVM "loadouts\full\droneOperator.sqf"};
						if ((_unitTypes select _count) == OPEX_friendly_interpret) then {[_unit] execVM "loadouts\full\interpret.sqf"};

						// DEFINING UNIT'S VALUE
						_unit setVariable ["value", _cost, true];

						// UNIT JOINS SQUAD
						_squad = _squad + [_unit];
						if (count _squad > 1) then {[_unit] joinSilent (group (_squad select 0))};

						// DONE
						_count = _count + 1;
					};

			// =========================================================================================================
			// UPDATING STATS
			// =========================================================================================================

				// this code deletes backpacks that are sometimes spawning on the ground, I don't know why !
				[] spawn {sleep 1; {deleteVehicle _x} forEach ((OPEX_deliveryZone nearObjects 15) select {typeOf _x == "GroundWeaponHolder"})};

				private ["_cost"];
				if (_requestedSquad == localize "STR_squad_infantryFull") then {_cost = abs OPEX_cost_squad_infantryFull};
				if (_requestedSquad == localize "STR_squad_infantryLight") then {_cost = abs OPEX_cost_squad_infantryLight};
				if (_requestedSquad == localize "STR_squad_reco") then {_cost = abs OPEX_cost_squad_reco};
				if (_requestedSquad == localize "STR_squad_assaultLong") then {_cost = abs OPEX_cost_squad_assaultLong};
				if (_requestedSquad == localize "STR_squad_assaultShort") then {_cost = abs OPEX_cost_squad_assaultShort};
				if (_requestedSquad == localize "STR_squad_at") then {_cost = abs OPEX_cost_squad_at};
				if (_requestedSquad == localize "STR_squad_rescue") then {_cost = abs OPEX_cost_squad_rescue};

				OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
				//[OPEX_friendly_side1, "Base", "STR_globalStats_updateBuy", name _recruiter, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];
		}
	] remoteExec ["spawn", 2];
	//hint localize "STR_hint_deliveryDone";

// =========================================================================================================
// RESETTING DIALOG INTERFACE
// =========================================================================================================

	sleep 0.75;
	lbClear _currentUnits;
	{lbAdd [_currentUnits, name _x]} forEach units (group _recruiter);