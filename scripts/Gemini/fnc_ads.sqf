// WAITING FOR SERVER INITIALIZATION
if (isDedicated) exitWith {};

private _screens = ((allMissionObjects "all") select {((typeOf _x) find "Land_TripodScreen_01_dual_v2") != -1});
if (count _screens == 0) exitWith {};

{_x setVariable ["R3F_LOG_disabled", true]} forEach _screens;

// DEFINING MAIN FUNCTION
private _mainFunction =
	{
		{
			if (player distance2D _x < 15) then
				{
					_x setObjectTexture [0, "pictures\ad_ratsuper_h.paa"];
					_x setObjectTexture [1, "pictures\ad_ratsuper_v.paa"];
					sleep 10;
					_x setObjectTexture [0, "pictures\ad_typex_h.paa"];
					_x setObjectTexture [1, "pictures\ad_typex_v.paa"];
					sleep 10;
					_x setObjectTexture [0, "pictures\ad_faiavan_h.paa"];
					_x setObjectTexture [1, "pictures\ad_faiavan_v.paa"];
					sleep 10;
				};
		} forEach _this;
	};

// LOOPING
while {true} do {_screens spawn _mainFunction; sleep 30};