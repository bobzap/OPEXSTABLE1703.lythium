waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
sleep 1;
// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private ["_unit", "_requestedLoadout"];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	if ((count _this) > 0) then {_unit = _this select 0};
	if ((count _this) > 1) then {_requestedLoadout = _this select 1};

	if (side _unit == civilian) exitWith {};
	sleep 0.1;
	if (OPEX_intro) then {if (isNil "OPEX_introFinished") then {sleep 12}}; // avoids a display issue during the intro causes by TFR mod

// =========================================================================================================
// LOADING LOADOUT
// =========================================================================================================

	if (!isNil "_requestedLoadout") then
		{
			if (_requestedLoadout == "officer") then {[_unit] execVM "loadouts\full\officer.sqf"};
			if (_requestedLoadout == "rifleman") then {[_unit] execVM "loadouts\full\rifleman.sqf"};
			if (_requestedLoadout == "teamLeader") then {[_unit] execVM "loadouts\full\teamLeader.sqf"};
			if (_requestedLoadout == "grenadier") then {[_unit] execVM "loadouts\full\grenadier.sqf"};
			if (_requestedLoadout == "mgLight") then {[_unit] execVM "loadouts\full\mgLight.sqf"};
			if (_requestedLoadout == "mgHeavy") then {[_unit] execVM "loadouts\full\mgHeavy.sqf"};
			if (_requestedLoadout == "at") then {[_unit] execVM "loadouts\full\at.sqf"};
			if (_requestedLoadout == "aa") then {[_unit] execVM "loadouts\full\aa.sqf"};
			if (_requestedLoadout == "ghillieSniper") then {[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
			if (_requestedLoadout == "ghillieSpotter") then {[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
			if (_requestedLoadout == "marksman") then {[_unit] execVM "loadouts\full\marksman.sqf"};
			if (_requestedLoadout == "scout") then {[_unit] execVM "loadouts\full\scout.sqf"};
			if (_requestedLoadout == "medic") then {[_unit] execVM "loadouts\full\medic.sqf"};
			if (_requestedLoadout == "repairer") then {[_unit] execVM "loadouts\full\repairer.sqf"};
			if (_requestedLoadout == "sapper") then {[_unit] execVM "loadouts\full\sapper.sqf"};
			if (_requestedLoadout == "ammoAssistant") then {[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
			if (_requestedLoadout == "chopperPilot") then {[_unit] execVM "loadouts\full\chopperPilot.sqf"};
			if (_requestedLoadout == "aircraftPilot") then {[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
			if (_requestedLoadout == "diver") then {[_unit] execVM "loadouts\full\diver.sqf"};
			if (_requestedLoadout == "assault") then {[_unit] execVM "loadouts\full\assault.sqf"};
			if (_requestedLoadout == "crewman") then {[_unit] execVM "loadouts\full\crewman.sqf"};
			if (_requestedLoadout == "radioOperator") then {[_unit] execVM "loadouts\full\radioOperator.sqf"};
			if (_requestedLoadout == "droneOperator") then {[_unit] execVM "loadouts\full\droneOperator.sqf"};
			if (_requestedLoadout == "interpret") then {[_unit] execVM "loadouts\full\interpret.sqf"};

			// THIS IS TO LOAD CUSTOMED LOADOUT (NEEDS PLAYER PROFILE NAME)
			if (_requestedLoadout == "customed") then
				{
					if (((isMultiplayer) && (getPlayerUID _unit == "76561198076257522")) || (!isMultiplayer && ((profileNameSteam) in ["gemini.69"]))) then {[_unit] execVM "loadouts\full\Gemini.sqf"};
					if (((isMultiplayer) && (getPlayerUID _unit == "00000000000000000")) || (!isMultiplayer && ((profileNameSteam) in ["Kamih"]))) then {[_unit] execVM "loadouts\full\Kamih.sqf"};
				};
		}

	else
		{

			if ((typeOf _unit) == OPEX_friendly_officer) then {[_unit] execVM "loadouts\full\officer.sqf"};
			if ((typeOf _unit) == OPEX_friendly_rifleman) then {[_unit] execVM "loadouts\full\rifleman.sqf"};
			if ((typeOf _unit) == OPEX_friendly_teamLeader) then {[_unit] execVM "loadouts\full\teamLeader.sqf"};
			if ((typeOf _unit) == OPEX_friendly_grenadier) then {[_unit] execVM "loadouts\full\grenadier.sqf"};
			if ((typeOf _unit) == OPEX_friendly_MGLight) then {[_unit] execVM "loadouts\full\mgLight.sqf"};
			if ((typeOf _unit) == OPEX_friendly_MGHeavy) then {[_unit] execVM "loadouts\full\mgHeavy.sqf"};
			if ((typeOf _unit) == OPEX_friendly_AT) then {[_unit] execVM "loadouts\full\at.sqf"};
			if ((typeOf _unit) == OPEX_friendly_AA) then {[_unit] execVM "loadouts\full\aa.sqf"};
			if ((typeOf _unit) == OPEX_friendly_ghillie) then {[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
			if ((typeOf _unit) == OPEX_friendly_spotter) then {[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
			if ((typeOf _unit) == OPEX_friendly_marksman) then {[_unit] execVM "loadouts\full\marksman.sqf"};
			if ((typeOf _unit) == OPEX_friendly_scout) then {[_unit] execVM "loadouts\full\scout.sqf"};
			if ((typeOf _unit) == OPEX_friendly_medic) then {[_unit] execVM "loadouts\full\medic.sqf"};
			if ((typeOf _unit) == OPEX_friendly_repairer) then {[_unit] execVM "loadouts\full\repairer.sqf"};
			if ((typeOf _unit) == OPEX_friendly_sapper) then {[_unit] execVM "loadouts\full\sapper.sqf"};
			if ((typeOf _unit) == OPEX_friendly_ammoAssistant) then {[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
			if ((typeOf _unit) == OPEX_friendly_chopper_pilot) then {[_unit] execVM "loadouts\full\chopperPilot.sqf"};
			if ((typeOf _unit) == OPEX_friendly_aircraft_pilot) then {[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
			if ((typeOf _unit) == OPEX_friendly_diver) then {[_unit] execVM "loadouts\full\diver.sqf"};
			if ((typeOf _unit) == OPEX_friendly_assault) then {[_unit] execVM "loadouts\full\assault.sqf"};
			if ((typeOf _unit) == OPEX_friendly_crewman) then {[_unit] execVM "loadouts\full\crewman.sqf"};
			if ((typeOf _unit) == OPEX_friendly_radioOperator) then {[_unit] execVM "loadouts\full\radioOperator.sqf"};
			if ((typeOf _unit) == OPEX_friendly_droneOperator) then {[_unit] execVM "loadouts\full\droneOperator.sqf"};
			if ((typeOf _unit) == OPEX_friendly_interpret) then {[_unit] execVM "loadouts\full\interpret.sqf"};
			if ((typeOf _unit) == "C_man_polo_1_F") then {[_unit] execVM "loadouts\full\press.sqf"};

			if (((isMultiplayer) && (getPlayerUID _unit == "76561198076257522") && (!OPEX_debug)) || (!isMultiplayer && ((profileNameSteam) in ["gemini.69"]) && (!OPEX_debug))) then {[_unit] execVM "loadouts\full\Gemini.sqf"};
			if (((isMultiplayer) && (getPlayerUID _unit == "00000000000000000") && (!OPEX_debug)) || (!isMultiplayer && ((profileNameSteam) in ["Kamih"]) && (!OPEX_debug))) then {[_unit] execVM "loadouts\full\Kamih.sqf"};
		};