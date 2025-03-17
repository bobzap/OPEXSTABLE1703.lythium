// =================================================
// STARTING SCRIPT (SERVER ONLY)
// note: this script also requires Gemini_fnc_dormitory and Gemini_fnc_useInventoryObjects
// =================================================

	if (isDedicated) exitWith {};
	//if (!isNil {player getVariable "thirst"}) exitWith {}; // IN CASE PLAYER LOADS A SAVED GAME ? I NEED TO CHECK IF THIS COMMAND IS REALLY REQUIRED


// =================================================
// CHECKING IF THIS MODULE IS REQUIRED BY SERVER ADMIN
// =================================================

	waitUntil {!isNil "OPEX_param_primaryNeeds"};
	waitUntil {!isNil "OPEX_params_ready"}; waitUntil {!isNil "OPEX_params_ready"};
	if (OPEX_param_primaryNeeds == 0) exitWith {};

// =================================================
// DEBUG MOD
// =================================================

	_debug = false;

// =================================================
// DEFINING PENALTY FUNCTION
// =================================================

	Gemini_fnc_needs_applyPenalty =
		{
			// PRIVATIZING VARIABLES
			private ["_debug", "_unit", "_need", "_thirstLimitHours", "_hungerLimitHours", "_tirednessLimitHours", "_debug"];

			// GETTING VARIABLES
			_unit = _this select 0;
			_need = _this select 1;
			_limit = _this select 2;
			_debug = _this select 3;

			while {true} do
				{
					// WAITING ONE HOUR (IN-GAME TIME) - OR 30 SECONDS (IN-GAME TIME) IF DEBUG MOD IS ON
					if (!_debug) then {sleep (60 * 60 / timeMultiplier)} else {sleep (60 / timeMultiplier / 2)};

					if ((alive _unit) && (isPlayer _unit)) then
						{
							// PRIVATIZING VARIABLES
							private ["_thirst", "_hunger", "_tiredness", "_globalState", "_probability", "_fatiguePenalty"];

							// GETTING DATA
							_thirst = _unit getVariable ["thirst", 0];
							_hunger = _unit getVariable ["hunger", 0];
							_tiredness = _unit getVariable ["tiredness", 0];
							_globalState = _thirst + _hunger + _tiredness;

							if ((isNil "_need") || (isNil "_thirst") || (isNil "_hunger") || (isNil "_tiredness") || isNil "_globalState") exitWith {};

							// THIRST EFFECT
							if (_need == "thirst") then
								{
									private ["_length"];
									if (_thirst < _limit * 0.35) then {_probability = 0; _fatiguePenalty = 0.00; _length = 0};
									if ((_thirst >= _limit * 0.35) && (_thirst < _limit * 0.55)) then {_probability = 5; _fatiguePenalty = 0.10; _length = random 2};
									if ((_thirst >= _limit * 0.55) && (_thirst < _limit * 0.75)) then {_probability = 10; _fatiguePenalty = 0.25; _length = random 4};
									if ((_thirst >= _limit * 0.75) && (_thirst < _limit * 0.90)) then {_probability = 20; _fatiguePenalty = 0.50; _length = random 6};
									if (_thirst >= _limit * 0.90) then {_probability = 30; _fatiguePenalty = 1.00; _length = random 8};
									if (_thirst >= _limit) then {_probability = 50; _fatiguePenalty = 1.00; _length = random 12};
									if (_probability > round (random 100)) then {_unit setFatigue (getFatigue _unit + (random _fatiguePenalty)); titleCut ["", "WHITE IN", _length]};
								};

							// HUNGER EFFECT
							if (_need == "hunger") then
								{
									private ["_length"];
									if (_hunger < _limit * 0.35) then {_probability = 0; _fatiguePenalty = 0.00; _length = 0};
									if ((_hunger >= _limit * 0.35) && (_hunger < _limit * 0.55)) then {_probability = 5; _fatiguePenalty = 0.10; _length = random 2};
									if ((_hunger >= _limit * 0.55) && (_hunger < _limit * 0.75)) then {_probability = 10; _fatiguePenalty = 0.25; _length = random 4};
									if ((_hunger >= _limit * 0.75) && (_hunger < _limit * 0.90)) then {_probability = 20; _fatiguePenalty = 0.50; _length = random 6};
									if (_hunger >= _limit * 0.90) then {_probability = 30; _fatiguePenalty = 1.00; _length = random 8};
									if (_hunger >= _limit) then {_probability = 50; _fatiguePenalty = 1.00; _length = random 12};
									if (_probability > round (random 100)) then {_unit setFatigue (getFatigue _unit + (random _fatiguePenalty)); titleCut ["", "WHITE IN", _length]; playSound "rumble"};
								};

							// TIREDNESS EFFECT
							if (_need == "tiredness") then
								{
									private ["_length"];
									if (_tiredness < _limit * 0.35) then {_probability = 0; _fatiguePenalty = 0.00; _length = 0};
									if ((_tiredness >= _limit * 0.35) && (_tiredness < _limit * 0.55)) then {_probability = 5; _fatiguePenalty = 0.10; _length = random 2};
									if ((_tiredness >= _limit * 0.55) && (_tiredness < _limit * 0.75)) then {_probability = 10; _fatiguePenalty = 0.25; _length = random 4};
									if ((_tiredness >= _limit * 0.75) && (_tiredness < _limit * 0.90)) then {_probability = 20; _fatiguePenalty = 0.50; _length = random 6};
									if (_tiredness >= _limit * 0.90) then {_probability = 30; _fatiguePenalty = 1.00; _length = random 8};
									if (_tiredness >= _limit) then {_probability = 50; _fatiguePenalty = 1.00; _length = random 12};
									if (_probability > round (random 100)) then {_unit setFatigue (getFatigue _unit + (random _fatiguePenalty)); titleCut ["", "BLACK IN", _length]; playSound "yawn"};
								};

							// GLOBAL EFFECT
							if (_need == "global") then
								{
									if (_globalState < _limit * 0.50) then {_unit setAnimSpeedCoef 1.00};
									if ((_globalState >= _limit * 0.50) && (_globalState < _limit * 0.55)) then {_unit setAnimSpeedCoef 0.90};
									if ((_globalState >= _limit * 0.70) && (_globalState < _limit * 0.75)) then {_unit setAnimSpeedCoef 0.80};
									if ((_globalState >= _limit * 0.90) && (_globalState < _limit * 0.90)) then {_unit setAnimSpeedCoef 0.70};
									if (_globalState >= _limit * 1.00) then {_unit setAnimSpeedCoef 0.6};
								};
						};
				};
		};

// =================================================
// DEFINING MAIN VARIABLES
// =================================================

	// PRIVATIZING VARIABLES
	private
		[
			"_debug",
			"_unit",
			"_thirstLimitDays", "_hungerLimitDays", "_tirednessLimitdays",
			"_thirstLimitHours", "_hungerLimitHours", "_tirednessLimitHours"
		];

	// GETTING UNIT
	_unit = player;

	// INITIALIZING NEEDS
	_unit setVariable ["thirst", 0];
	_unit setVariable ["hunger", 0];
	_unit setVariable ["tiredness", 0];

	// DEFINING LIMITS (IN DAYS)
	if (OPEX_mapRegion == "europe") then
		{
			_thirstLimitDays = 1.0;		// default = 1.0 (days)
			_hungerLimitDays = 2.0;		// default = 2.0 (days)
			_tirednessLimitdays = 2.0;	// default = 2.0 (days)
		};
	if (OPEX_mapRegion == "pacific") then
		{
			_thirstLimitDays = 0.9;		// default = 0.9 (days)
			_hungerLimitDays = 1.5;		// default = 1.5 (days)
			_tirednessLimitdays = 1.5;	// default = 1.5 (days)
		};
	if (OPEX_mapRegion == "middleEast") then
		{
			_thirstLimitDays = 0.7;		// default = 0.7 (days)
			_hungerLimitDays = 1.5;		// default = 1.5 (days)
			_tirednessLimitdays = 1.75;	// default = 1.75 (days)
		};
	if (OPEX_mapRegion == "africa") then
		{
			_thirstLimitDays = 0.5;		// default = 0.5 (days)
			_hungerLimitDays = 1.5;		// default = 1.5 (days)
			_tirednessLimitdays = 1.75;	// default = 1.75 (days)
		};

	// CONVERTING INTO HOUR FORMAT
	_thirstLimitHours = _thirstLimitDays * 24 * (1 + random 0.2); // adding a random additional resistance - to avoid everybody needs to drink exactly at the same time
	_hungerLimitHours = _hungerLimitDays * 24 * (1 + random 0.2); // adding a random additional resistance - to avoid everybody needs to eat exactly at the same time
	_tirednessLimitHours = _tirednessLimitdays * 24 * (1 + random 0.2); // adding a random additional resistance - to avoid everybody needs to rest exactly at the same time

	thirstLimit = _thirstLimitHours;
	hungerLimit = _hungerLimitHours;
	tirednessLimit = _tirednessLimitHours;


// =================================================
// UPDATING DATA
// =================================================

	[_debug, _unit, _thirstLimitHours, _hungerLimitHours, _tirednessLimitHours] spawn
		{
			// PRIVATIZING VARIABLES
			private ["_debug", "_thirst", "_hunger", "_tiredness", "_thirstUpdated", "_hungerUpdated", "_tirednessUpdated"];

			// DEFINING VARIABLES
			_debug = _this select 0;
			_unit = _this select 1;
			_thirstLimitHours = _this select 2;
			_hungerLimitHours = _this select 3;
			_tirednessLimitHours = _this select 4;

			while {true} do
				{
					// WAITING ONE HOUR (IN-GAME TIME) - OR 30 SECONDS (IN-GAME TIME) IF DEBUG MOD IS ON
					if (!_debug) then {sleep (60 * 60 / timeMultiplier)} else {sleep (60 / timeMultiplier / 2)};

					// GETTING DATA
					_thirst = _unit getVariable ["thirst", 0];
					_hunger = _unit getVariable ["hunger", 0];
					_tiredness = _unit getVariable ["tiredness", 0];

					// UPDATING DATA
					_thirstUpdated = _thirst + 1;
					_hungerUpdated = _hunger + 1;
					_tirednessUpdated = _tiredness + 1;
					_unit setVariable ["thirst", _thirstUpdated];
					_unit setVariable ["hunger", _hungerUpdated];
					_unit setVariable ["tiredness", _tirednessUpdated];
				};
		};


// =================================================
// APPLYING PENALTIES
// =================================================

	[_unit, _thirstLimitHours, _hungerLimitHours, _tirednessLimitHours, _debug] spawn
		{
			// PRIVATIZING VARIABLES
			private ["_unit", "_thirstLimitHours", "_hungerLimitHours", "_tirednessLimitHours", "_debug"];

			// DEFINING VARIABLES
			_unit = _this select 0;
			_thirstLimitHours = _this select 1;
			_hungerLimitHours = _this select 2;
			_tirednessLimitHours = _this select 3;
			_debug = _this select 4;

			// APPLYING PENALTIES
			[_unit, "thirst", _thirstLimitHours, _debug] spawn Gemini_fnc_needs_applyPenalty;
			[_unit, "hunger", _hungerLimitHours, _debug] spawn Gemini_fnc_needs_applyPenalty;
			[_unit, "tiredness", _tirednessLimitHours, _debug] spawn Gemini_fnc_needs_applyPenalty;
			[_unit, "global", _thirstLimitHours + _hungerLimitHours + _tirednessLimitHours, _debug] spawn Gemini_fnc_needs_applyPenalty;

			// CHECKING UNIT - THEN RESETTING VARIABLES IF UNIT IS KILLED
			/*
			while {true} do
				{
					sleep 1;
					if ((damage _unit >= 1) || (!alive _unit))
					then
						{
							sleep 1;
							_unit setVariable ["thirst", 0];
							_unit setVariable ["hunger", 0];
							_unit setVariable ["tiredness", 0];
						};

				// DEBUGGING
				if (_debug) then
					{
						hint format
							[
								"THIRST : %1/%2 (%3%10)\nHUNGER : %4/%5 (%6%10)\nTIREDNESS : %7/%8 (%9%10)",
								player getVariable "thirst", round _thirstLimitHours, round ((_unit getVariable "thirst") * 100 / _thirstLimitHours),
								player getVariable "hunger", round _hungerLimitHours, round ((_unit getVariable "hunger") * 100 / _hungerLimitHours),
								player getVariable "tiredness", round _tirednessLimitHours, round ((_unit getVariable "tiredness") * 100 / _tirednessLimitHours),
								"%"
							];
					};
				};
			*/
		};


// =================================================
// DEFINING ITEMS EFFECTS
// =================================================

	Gemini_fnc_needs_drink =
		{
			private ["_item"];
			_item = _this select 0;
			if (_item in ["Gemini_bottleSmall"]) then {player setVariable ["thirst", (player getVariable "thirst") - (thirstLimit / 4)]};
			if (_item in ["Gemini_bottleMedium"]) then {player setVariable ["thirst", (player getVariable "thirst") - (thirstLimit / 2)]};
			if (_item in ["Gemini_bottleBig"]) then {player setVariable ["thirst", 0]};
			player removeItem _item;
			playSound "drinking";
		};

	Gemini_fnc_needs_eat =
		{
			private ["_item"];
			_item = _this select 0;
			if (_item in ["Gemini_dattes", "Gemini_banana", "Gemini_fig", "Gemini_apple"]) then {player setVariable ["hunger", (player getVariable "hunger") - (hungerLimit / 6)]};
			if (_item in ["Gemini_rationSmall"]) then {player setVariable ["hunger", (player getVariable "hunger") - (hungerLimit / 4)]};
			if (_item in ["Gemini_rationMedium"]) then {player setVariable ["hunger", (player getVariable "hunger") - (hungerLimit / 2)]};
			if (_item in ["Gemini_rationBig"]) then {player setVariable ["hunger", 0]};
			player removeItem _item;
			playSound "eating";
		};