// =========================================================================================================
// DEFINING VARIABLE(S)
// =========================================================================================================
	disableSerialization;

	private
		[
			"_needsManager", "_needsManagerMainTitle",
			"_hunger", "_hungerStatus", "_thirst", "_thirstStatus", "_tiredness", "_tirednessStatus",
			"_warning", "_close"
		];
	_needsManager = 4000;
	_needsManagerMainTitle = 4001;
	_hunger = 4010;
	_hungerStatus = 4011;
	_thirst = 4020;
	_thirstStatus = 4021;
	_tiredness = 4030;
	_tirednessStatus = 4031;
	_warning = 4040;
	_close = 4999;

// =========================================================================================================
// OPENING DIALOG INTERFACE
// =========================================================================================================

	// DISPLAYING CUSTOM DIALOG INTERFACE
		createDialog "OPEX_needsManager";
		ctrlSetText [_needsManagerMainTitle, toUpper localize "STR_dialog_needsManager_title"];

	// DISPLAYING NEEDS
		ctrlSetText [_hunger, localize "STR_dialog_needsManager_hunger"];
		ctrlSetText [_thirst, localize "STR_dialog_needsManager_thirst"];
		ctrlSetText [_tiredness, localize "STR_dialog_needsManager_tiredness"];

	// DISPLAYING WARNING
		ctrlSetText [_warning, format [localize "STR_dialog_needsManagerWarning", 16, 8, 16, "%"]];

	// DISPLAYING CLONE BUTTON
		ctrlSetText [_close, toUpper localize "STR_dialog_close"];
		buttonSetAction [_close, "closeDialog 0"];

	// UPDATING STATUS

		// DEFINING COLORS
			private ["_green1", "_green2", "_yellow", "_orange", "_red"];
			_green1 = [0.2, 0.8, 0.0, 1.0];
			_green2 = [0.6, 1.0, 0.0, 1.0];
			_yellow = [1.0, 1.0, 0.0, 1.0];
			_orange = [1.0, 0.4, 0.0, 1.0];
			_red = [0.8, 0.0, 0.0, 1.0];

		// UPDATING COLORS
			private ["_hungerMonitor", "_thirstMonitor", "_tirednessMonitor"];
			while {dialog} do
				{
					sleep 0.1;

					// HUNGER
						_hungerMonitor = ((findDisplay _needsManager) displayCtrl _hungerStatus);
						if ((player getVariable "hunger") < (hungerLimit * 0.35))
							then {_hungerMonitor ctrlSetTextColor _green1; ctrlSetText [_hungerStatus, localize "STR_dialog_needsManager_none"]};
						if (((player getVariable "hunger") >= (hungerLimit * 0.35)) && ((player getVariable "hunger") < (hungerLimit * 0.55)))
							then {_hungerMonitor ctrlSetTextColor _green2; ctrlSetText [_hungerStatus, localize "STR_dialog_needsManager_small"]};
						if (((player getVariable "hunger") >= (hungerLimit * 0.55)) && ((player getVariable "hunger") < (hungerLimit * 0.75)))
							then {_hungerMonitor ctrlSetTextColor _yellow; ctrlSetText [_hungerStatus, localize "STR_dialog_needsManager_moderate"]};
						if (((player getVariable "hunger") >= (hungerLimit * 0.75)) && ((player getVariable "hunger") < (hungerLimit * 0.90)))
							then {_hungerMonitor ctrlSetTextColor _orange; ctrlSetText [_hungerStatus, localize "STR_dialog_needsManager_intense"]};
						if ((player getVariable "hunger") >= (hungerLimit * 0.90))
							then {_hungerMonitor ctrlSetTextColor _red; ctrlSetText [_hungerStatus, localize "STR_dialog_needsManager_critical"]};

					// THIRST
						_thirstMonitor = ((findDisplay _needsManager) displayCtrl _thirstStatus);
						if ((player getVariable "thirst") < (thirstLimit * 0.35))
							then {_thirstMonitor ctrlSetTextColor _green1; ctrlSetText [_thirstStatus, localize "STR_dialog_needsManager_none"]};
						if (((player getVariable "thirst") >= (thirstLimit * 0.35)) && ((player getVariable "thirst") < (thirstLimit * 0.55)))
							then {_thirstMonitor ctrlSetTextColor _green2; ctrlSetText [_thirstStatus, localize "STR_dialog_needsManager_small"]};
						if (((player getVariable "thirst") >= (thirstLimit * 0.55)) && ((player getVariable "thirst") < (thirstLimit * 0.75)))
							then {_thirstMonitor ctrlSetTextColor _yellow; ctrlSetText [_thirstStatus, localize "STR_dialog_needsManager_moderate"]};
						if (((player getVariable "thirst") >= (thirstLimit * 0.75)) && ((player getVariable "thirst") < (thirstLimit * 0.90)))
							then {_thirstMonitor ctrlSetTextColor _orange; ctrlSetText [_thirstStatus, localize "STR_dialog_needsManager_intense"]};
						if ((player getVariable "thirst") >= (thirstLimit * 0.90))
							then {_thirstMonitor ctrlSetTextColor _red; ctrlSetText [_thirstStatus, localize "STR_dialog_needsManager_critical"]};

					// TIREDNESS
						_tirednessMonitor = ((findDisplay _needsManager) displayCtrl _tirednessStatus);
						if ((player getVariable "tiredness") < (tirednessLimit * 0.35))
							then {_tirednessMonitor ctrlSetTextColor _green1; ctrlSetText [_tirednessStatus, localize "STR_dialog_needsManager_none"]};
						if (((player getVariable "tiredness") >= (tirednessLimit * 0.35)) && ((player getVariable "tiredness") < (tirednessLimit * 0.55)))
							then {_tirednessMonitor ctrlSetTextColor _green2; ctrlSetText [_tirednessStatus, localize "STR_dialog_needsManager_small"]};
						if (((player getVariable "tiredness") >= (tirednessLimit * 0.55)) && ((player getVariable "tiredness") < (tirednessLimit * 0.75)))
							then {_tirednessMonitor ctrlSetTextColor _yellow; ctrlSetText [_tirednessStatus, localize "STR_dialog_needsManager_moderate"]};
						if (((player getVariable "tiredness") >= (tirednessLimit * 0.75)) && ((player getVariable "tiredness") < (tirednessLimit * 0.90)))
							then {_tirednessMonitor ctrlSetTextColor _orange; ctrlSetText [_tirednessStatus, localize "STR_dialog_needsManager_intense"]};
						if ((player getVariable "tiredness") >= (tirednessLimit * 0.90))
							then {_tirednessMonitor ctrlSetTextColor _red; ctrlSetText [_tirednessStatus, localize "STR_dialog_needsManager_critical"]};

					// CHECKING IF MAXIMUM VALUE HASN'T BEEN OVERPASSED
						if ((player getVariable "hunger") < 0) then {player setVariable ["hunger", 0]};
						if ((player getVariable "thirst") < 0) then {player setVariable ["thirst", 0]};
						if ((player getVariable "tiredness") < 0) then {player setVariable ["tiredness", 0]};
				};