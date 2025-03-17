/*
	This fix has been proposed by Johnny Drama (http://steamcommunity.com/sharedfiles/filedetails/?id=897711455) because there's currently a bug on Kunduz map to open doors.
	The original script is from badbenson's Enhanced Movements mod (http://steamcommunity.com/sharedfiles/filedetails/?id=333310405&searchtext=enhanced)

	I just integrate it into OPEX, so all credits goes to people above.

	- Gemini
*/


if (isDedicated) exitWith {};


waitUntil {!isNull player};
if (!hasInterface) exitWith {};

if (OPEX_intro) then {waitUntil {!isNil "OPEX_introFinished"}; sleep 1};
if (OPEX_intro) then {waitUntil {OPEX_introFinished; sleep 30}};
waitUntil {speed player > 10};
if (!OPEX_debug) then {hintC localize "STR_tempFix_Kunduz"};

while {true} do
	{
		waitUntil {inputAction "LookAround" > 0};

		//fn_use.sqf Start
		_range = 10;

		_obj = nil;

		if (isNil "_obj") then
		{
			_obj = ((lineintersectsSurfaces [atltoasl (positionCameraToWorld [0,0,0]), atltoasl (positionCameraToWorld [0,0,_range]), player, objNull, true, 1, "GEOM", "FIRE"]) select 0) select 3;

			if (isNil "_obj") then
			{
				_obj = ((lineintersectsSurfaces [atltoasl (player modeltoworld [0,0,0.5]), atltoasl (player modeltoworld [0,0,-1]), player, objNull, true, 1, "FIRE", "FIRE"]) select 0) select 3;
			};
		} else
		{
			_inbbr = [player, _obj, _range] call babe_core_fnc_inbbr_pl;

			if (!_inbbr) then
			{
				_obj = ((lineintersectsSurfaces [atltoasl (positionCameraToWorld [0,0,0]), atltoasl (positionCameraToWorld [0,0,_range]), player, objNull, true, 1, "GEOM", "FIRE"]) select 0) select 3;

				if (isNil "_obj") then
				{
					_obj = ((lineintersectsSurfaces [atltoasl (player modeltoworld [0,0,0.5]), atltoasl (player modeltoworld [0,0,-1]), player, objNull, true, 1, "GEOM", "FIRE"]) select 0) select 3;
				};
			};
		};

		if (isNil "_obj") exitwith {babe_int_curr = []};

		babe_int_curr = [_obj];
		_obj = babe_int_curr select 0;

		//fn_use.sqf End

		_anms = animationNames _obj;

		_range = 1.55;

		if (cameraView == "External") then
		{
			_range = _range + ((positioncameratoworld [0,0,0]) distance (player modeltoworld(player selectionposition "head")));
		};

		_posa = positionCameraToWorld [0,0,0];
		_posb = positionCameraToWorld [0,0,_range];

		_int = ([_obj, "GEOM"] intersect [_posa, _posb]) select 0 select 0;

		if (isNil "_int") then
		{
			_int = ([_obj, "FIRE"] intersect [_posa, _posb]) select 0 select 0;
		};



		if (!IsNil "_int") then
		{
			{
				if (toLower _x find toLower _int > -1) then
				{
					if (_obj animationPhase _x > 0.5) then
					{
						_obj animate [_x, 0];
					} else
					{
						_obj animate [_x, 1];
					};
				};
			} count _anms;
		};
		sleep 0.1;
	};