private _caller = _this select 1;
private _length = _this select 3 select 0;

// RESTING
//playSound "yawn";
//sleep 2; // important (otherwise it breakes the black out screen !)
if ((OPEX_param_primaryNeeds == 1) && (isClass (configFile >> "CfgPatches" >> "Gemini_items"))) then
	{
		if (_length == 1) then {_caller setVariable ["tiredness", (_caller getVariable ["tiredness", 0]) - (tirednessLimit / 6)]};
		if (_length == 3) then {_caller setVariable ["tiredness", (_caller getVariable ["tiredness", 0]) - (tirednessLimit / 4)]};
		if (_length == 6) then {_caller setVariable ["tiredness", (_caller getVariable ["tiredness", 0]) - (tirednessLimit / 2)]};
		if (_length == 9) then {_caller setVariable ["tiredness", 0]};
		if (_length == 12) then {_caller setVariable ["tiredness", 0]};
		if ((_caller getVariable ["tiredness", 0]) < tirednessLimit) then {_caller setVariable ["tiredness", 0]};
	};
_caller setFatigue 0;

// DISPLAYING BLACK SCREEN
titleText ["", "black out", 2];
3 fadeSound 0;
sleep 3;

// DISPLAYING TEXT
private _text = "";
if (!isMultiplayer) then {_text = "STR_aFewHoursLater"} else {_text = "STR_aFewHoursLater_MP"};
titleText [format [localize _text, _length], "black", 0.00001];

// SKIPPING TIME
if (!isMultiplayer) then {skipTime _length};
sleep _length;

// HIDING BLACK SCREEN
titleText ["", "black in", 5];
5 fadeSound 1;