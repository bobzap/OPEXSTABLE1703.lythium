// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	private ["_target", "_caller"];
	_target = [_this, 0, objNull] call BIS_fnc_param;
	_caller = [_this, 1, objNull] call BIS_fnc_param;


// =========================================================================================================
// GETTING CONTROLS
// =========================================================================================================

	private
		[
			"_dialog",
			"_civilian_movement_TITLE", "_civilian_movement_halt", "_civilian_movement_move",
			"_civilian_conversation_TITLE", "_civilian_conversation_thoughts", "_civilian_conversation_identity", "_civilian_conversation_nationality",
			"_civilian_conversation_birthdate", "_civilian_conversation_job", "_civilian_conversation_suspicious", "_civilian_conversation_goodbye",
			"_civilian_IDcheck_TITLE", "_civilian_IDcheck_card", "_civilian_IDcheck_scan",
			"_civilian_suspect_TITLE", "_civilian_suspect_down", "_civilian_suspect_search", "_civilian_suspect_handcuff",
			"_civilian_suspect_take", "_civilian_suspect_load", "_civilian_suspect_drop", "_civilian_suspect_release"
		];
	_dialog = 3000;
	_civilian_movement_TITLE = 3001;
	_civilian_movement_halt = 3002;
	_civilian_movement_move = 3003;
	_civilian_conversation_TITLE = 3004;
	_civilian_conversation_thoughts = 3005;
	_civilian_conversation_identity = 3006;
	_civilian_conversation_nationality = 3007;
	_civilian_conversation_birthdate = 3008;
	_civilian_conversation_job = 3009;
	_civilian_conversation_suspicious = 3010;
	_civilian_conversation_goodbye = 3011;
	_civilian_IDcheck_TITLE = 3012;
	_civilian_IDcheck_card = 3013;
	_civilian_IDcheck_scan = 3014;
	_civilian_suspect_TITLE = 3015;
	_civilian_suspect_down = 3016;
	_civilian_suspect_search = 3017;
	_civilian_suspect_handcuff = 3018;
	_civilian_suspect_take = 3019;
	_civilian_suspect_load = 3020;
	_civilian_suspect_drop = 3021;
	_civilian_suspect_release = 3022;


// =========================================================================================================
// SPAWNING DIALOG
// =========================================================================================================

	createDialog "OPEX_civilianInteractions";


// =========================================================================================================
// SETTING TEXTS
// =========================================================================================================

	// MOVEMENT
		ctrlSetText [_civilian_movement_TITLE, toUpper localize "STR_dialog_civilianInteractions_movement_TITLE"];
		ctrlSetText [_civilian_movement_halt, localize "STR_dialog_civilianInteractions_movement_halt"];
		ctrlSetText [_civilian_movement_move, localize "STR_dialog_civilianInteractions_movement_move"];

	// CONVERSATION
		ctrlSetText [_civilian_conversation_TITLE, toUpper localize "STR_dialog_civilianInteractions_conversation_TITLE"];
		ctrlSetText [_civilian_conversation_thoughts, localize "STR_dialog_civilianInteractions_conversation_thoughts"];
		ctrlSetText [_civilian_conversation_identity, localize "STR_dialog_civilianInteractions_conversation_identity"];
		ctrlSetText [_civilian_conversation_nationality, localize "STR_dialog_civilianInteractions_conversation_nationality"];
		ctrlSetText [_civilian_conversation_birthdate, localize "STR_dialog_civilianInteractions_conversation_birthdate"];
		ctrlSetText [_civilian_conversation_job, localize "STR_dialog_civilianInteractions_conversation_job"];
		ctrlSetText [_civilian_conversation_suspicious, localize "STR_dialog_civilianInteractions_conversation_suspicious"];
		ctrlSetText [_civilian_conversation_goodbye, localize "STR_dialog_civilianInteractions_conversation_goodbye"];

	// ID CHECK
		ctrlSetText [_civilian_IDcheck_TITLE, toUpper localize "STR_dialog_civilianInteractions_IDcheck_TITLE"];
		ctrlSetText [_civilian_IDcheck_card, localize "STR_dialog_civilianInteractions_IDcheck_card"];
		ctrlSetText [_civilian_IDcheck_scan, localize "STR_dialog_civilianInteractions_IDcheck_scan"];

	// SUSPECT INTERACTIONS
		ctrlSetText [_civilian_suspect_TITLE, toUpper localize "STR_dialog_civilianInteractions_suspect_TITLE"];
		ctrlSetText [_civilian_suspect_down, localize "STR_dialog_civilianInteractions_suspect_down"];
		ctrlSetText [_civilian_suspect_search, localize "STR_dialog_civilianInteractions_suspect_search"];
		ctrlSetText [_civilian_suspect_handcuff, localize "STR_dialog_civilianInteractions_suspect_handcuff"];
		ctrlSetText [_civilian_suspect_take, localize "STR_dialog_civilianInteractions_suspect_take"];
		ctrlSetText [_civilian_suspect_load, localize "STR_dialog_civilianInteractions_suspect_load"];
		ctrlSetText [_civilian_suspect_drop, localize "STR_dialog_civilianInteractions_suspect_drop"];
		ctrlSetText [_civilian_suspect_release, localize "STR_dialog_civilianInteractions_suspect_release"];


// =========================================================================================================
// DEFINING CONTROL ACTIONS
// =========================================================================================================

	// MOVEMENT
		//buttonSetAction [_civilian_movement_halt, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_movement_halt", _target, _caller]];
		buttonSetAction [_civilian_movement_halt, format ["[%1, %2] remoteExec ['Gemini_fnc_civilianInteractions_movement_halt', 2]", _target, _caller]];
		//buttonSetAction [_civilian_movement_move, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_movement_move", _target, _caller]];
		buttonSetAction [_civilian_movement_move, format ["[%1, %2] remoteExec ['Gemini_fnc_civilianInteractions_movement_move', 2]", _target, _caller]];

	// CONVERSATIONS
		buttonSetAction [_civilian_conversation_thoughts, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 1]];
		buttonSetAction [_civilian_conversation_identity, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 2]];
		buttonSetAction [_civilian_conversation_nationality, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 3]];
		buttonSetAction [_civilian_conversation_birthdate, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 4]];
		buttonSetAction [_civilian_conversation_job, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 5]];
		buttonSetAction [_civilian_conversation_suspicious, format ["[%1, %2, %3] spawn Gemini_fnc_civilianInteractions_conversation", _target, _caller, 6]];
		buttonSetAction [_civilian_conversation_goodbye, "closeDialog 0"];

	// ID CHECK
		buttonSetAction [_civilian_IDcheck_card, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_IDcheck_card", _target, _caller]];
		buttonSetAction [_civilian_IDcheck_scan, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_IDcheck_scan", _target, _caller]];

	// SUSPECT INTERACTIONS
		//buttonSetAction [_civilian_suspect_down, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_down", _target, _caller]];
		buttonSetAction [_civilian_suspect_down, format ["[%1, %2] remoteExec ['Gemini_fnc_civilianInteractions_suspect_down', 2]", _target, _caller]];
		buttonSetAction [_civilian_suspect_search, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_search", _target, _caller]];
		buttonSetAction [_civilian_suspect_handcuff, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_handcuff", _target, _caller]];
		buttonSetAction [_civilian_suspect_take, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_take; closeDialog 0", _target, _caller]];
		//buttonSetAction [_civilian_suspect_load, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_load; closeDialog 0", _target, _caller]];
		buttonSetAction [_civilian_suspect_load, format [" closeDialog 0; [%1, %2] remoteExec ['Gemini_fnc_civilianInteractions_suspect_load', 2]", _target, _caller]];
		buttonSetAction [_civilian_suspect_drop, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_drop", _target, _caller]];
		buttonSetAction [_civilian_suspect_release, format ["[%1, %2] spawn Gemini_fnc_civilianInteractions_suspect_release", _target, _caller]];


// =========================================================================================================
// ENABLING/DISABLING CONTROLS
// =========================================================================================================

	while {dialog} do
		{
			sleep 0.1;

			// IF SUSPECT IS NOT HANDCUFFED
				if (animationState _target != "AmovPercMstpSsurWnonDnon") then
					{
						ctrlEnable [_civilian_movement_halt, true];
						ctrlEnable [_civilian_movement_move, true];
						ctrlEnable [_civilian_IDcheck_card, true];
						if ("Gemini_bioscan" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller))) then {ctrlEnable [_civilian_IDcheck_scan, true]} else {ctrlEnable [_civilian_IDcheck_scan, false]};
						ctrlEnable [_civilian_suspect_down, true];
						ctrlEnable [_civilian_suspect_search, true];
						if (("Gemini_cableTie" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller))) || ("ACE_CableTie" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller)))) then {ctrlEnable [_civilian_suspect_handcuff, true]} else {ctrlEnable [_civilian_suspect_handcuff, false]};
						if ((!(isClass (configFile >> "CfgPatches" >> "Gemini_items"))) && (!(isClass (configFile >> "CfgPatches" >> "ace_main")))) then {ctrlEnable [_civilian_suspect_handcuff, true]};
						ctrlEnable [_civilian_suspect_take, false];
						ctrlEnable [_civilian_suspect_load, false];
						ctrlEnable [_civilian_suspect_drop, false];
						ctrlEnable [_civilian_suspect_release, false];
					};

			// IF SUSPECT IS HANDCUFFED
				if (animationState _target == "AmovPercMstpSsurWnonDnon") then
					{
						ctrlEnable [_civilian_movement_halt, false];
						ctrlEnable [_civilian_movement_move, false];
						ctrlEnable [_civilian_IDcheck_card, true];
						if ("Gemini_bioscan" in ((uniformItems _caller) + (backpackItems _caller) + (vestItems _caller))) then {ctrlEnable [_civilian_IDcheck_scan, true]} else {ctrlEnable [_civilian_IDcheck_scan, false]};
						ctrlEnable [_civilian_suspect_down, false];
						ctrlEnable [_civilian_suspect_search, true];
						ctrlEnable [_civilian_suspect_handcuff, false];
						ctrlEnable [_civilian_suspect_take, true];
						ctrlEnable [_civilian_suspect_load, false];
						ctrlEnable [_civilian_suspect_drop, false];
						ctrlEnable [_civilian_suspect_release, true];
					};

			// IF SUSPECT IS TAKEN
				if (_target in attachedObjects _caller) then
					{
						ctrlEnable [_civilian_movement_halt, false];
						ctrlEnable [_civilian_movement_move, false];
						ctrlEnable [_civilian_IDcheck_card, false];
						ctrlEnable [_civilian_IDcheck_scan, false];
						ctrlEnable [_civilian_suspect_down, false];
						ctrlEnable [_civilian_suspect_search, false];
						ctrlEnable [_civilian_suspect_handcuff, false];
						ctrlEnable [_civilian_suspect_take, false];
						if (count (((position _target) nearEntities [["Air", "Car", "Motorcycle", "Tank"], 7.5])) > 0) then {ctrlEnable [_civilian_suspect_load, true]};
						ctrlEnable [_civilian_suspect_drop, true];
						ctrlEnable [_civilian_suspect_release, false];
					};

			// IF SUSPECT IS TOO FAR FROM CALLER
				if (_target distance _caller > 5) then
					{
						ctrlEnable [_civilian_movement_halt, true];
						ctrlEnable [_civilian_movement_move, true];
						ctrlEnable [_civilian_IDcheck_card, false];
						ctrlEnable [_civilian_IDcheck_scan, false];
						ctrlEnable [_civilian_suspect_search, false];
						ctrlEnable [_civilian_suspect_handcuff, false];
						ctrlEnable [_civilian_suspect_take, false];
						ctrlEnable [_civilian_suspect_load, false];
						ctrlEnable [_civilian_suspect_drop, false];
						ctrlEnable [_civilian_suspect_release, false];
					};
				if (_target distance _caller > 10)
					then
						{
							ctrlEnable [_civilian_conversation_thoughts, false];
							ctrlEnable [_civilian_conversation_identity, false];
							ctrlEnable [_civilian_conversation_nationality, false];
							ctrlEnable [_civilian_conversation_birthdate, false];
							ctrlEnable [_civilian_conversation_job, false];
							ctrlEnable [_civilian_conversation_suspicious, false];
							ctrlEnable [_civilian_suspect_down, false];
						}
					else
						{
							ctrlEnable [_civilian_conversation_thoughts, true];
							ctrlEnable [_civilian_conversation_identity, true];
							ctrlEnable [_civilian_conversation_nationality, true];
							ctrlEnable [_civilian_conversation_birthdate, true];
							ctrlEnable [_civilian_conversation_job, true];
							ctrlEnable [_civilian_conversation_suspicious, true];
						};
				if (_target distance _caller > 7.5) then {closeDialog 0};
		};