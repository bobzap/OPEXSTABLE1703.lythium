	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013-2015 Nicolas BOITEUX

	----- modified by Gemini for OPEX missions -----

	Real weather for MP GAMES v 1.4

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
	*/

	private ["_lastrain", "_rain", "_fog", "_mintime", "_maxtime", "_overcast", "_realtime", "_random","_startingdate", "_startingweather", "_timeforecast", "_daytimeratio", "_nighttimeratio", "_timesync", "_wind"];

	// Real time vs fast time
	// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
	// false: fast time give more different weather conditions (ideal for non persistent game)
	_realtime = true;

	// Random time before new forecast
	// true: forecast happens bewteen mintime and maxtime
	// false: forecast happens at mintime
	_random = true;

	// Min time seconds (real time) before a new weather forecast
	_mintime = 600;

	// Max time seconds (real time) before a new weather forecast
	_maxtime = 1200;

	// If Fastime is on
	// Ratio 1 real time second for x game time seconds
	// Default: 1 real second = 6 second in game
	_daytimeratio = 6;
	_nighttimeratio = 24;

	// send sync data across the network each xxx seconds
	// 60 real seconds by default is a good value
	// shortest time do not improve weather sync
	_timesync = 60;

	// Mission starting date is 25/09/2013 at 12:00
	if (isServer) then {startingDate = date; publicVariable "startingDate"} else {startingDate = startingDate};
	_startingdate = startingDate;

	// Mission starting weather
	private ["_mainWeathers", "_averageOvercast", "_canRain", "_canSnow"];
	waitUntil {!isNil "OPEX_mapClimate"};
	if (OPEX_mapClimate == "arid") then {_mainWeathers = ["CLEAR", "CLEAR", "CLEAR", "CLEAR", "CLEAR", "CLOUDY_1", "CLOUDY_2", "CLOUDY_3"]; _averageOvercast = 0.10; _canRain = true; _canSnow = false};
	if (OPEX_mapClimate == "mediterranean") then {_mainWeathers = ["CLEAR", "CLEAR", "CLEAR", "CLEAR", "CLEAR", "CLOUDY_1", "CLOUDY_2", "CLOUDY_3", "CLOUDY_4", "CLOUDY_5", "RAIN", "RAIN", "STORM"]; _averageOvercast = 0.20; _canRain = true; _canSnow = false};
	if (OPEX_mapClimate == "continental") then {_mainWeathers = ["CLEAR", "CLEAR", "CLEAR", "CLOUDY_1", "CLOUDY_2", "CLOUDY_3", "CLOUDY_4", "CLOUDY_5", "RAIN", "RAIN", "STORM"]; _averageOvercast = 0.30; _canRain = true; _canSnow = true};
	if (OPEX_mapClimate == "tropical") then {_mainWeathers = ["CLEAR", "CLOUDY_1", "CLOUDY_2", "CLOUDY_3", "CLOUDY_4", "CLOUDY_5", "RAIN", "RAIN", "RAIN", "RAIN", "STORM", "STORM"]; _averageOvercast = 0.40; _canRain = true; _canSnow = false};
	if (OPEX_mapClimate == "polar") then {_mainWeathers = ["CLEAR", "CLOUDY_1", "CLOUDY_2", "CLOUDY_3", "CLOUDY_4", "CLOUDY_5"]; _averageOvercast = 0.5; _canRain = false; _canSnow = true};
	_startingweather = selectRandom _mainWeathers;

	/////////////////////////////////////////////////////////////////
	// Do not edit below
	/////////////////////////////////////////////////////////////////

	if(_mintime > _maxtime) exitwith {hint format["Real weather: Max time: %1 can no be higher than Min time: %2", _maxtime, _mintime];};
	_timeforecast = _mintime;

	setdate _startingdate;
	switch (toUpper (_startingweather)) do

	{
		// [rain, fog, overcast, wind, date]

		case "CLEAR":
			{
				wcweather = [0, 0, 0.0, [random 1, random 1, false], date];
			};

		case "CLOUDY_1":
			{
				wcweather = [0, 0, 0.2, [random 2, random 2, false], date];
			};

		case "CLOUDY_2":
			{
				wcweather = [0, 0, 0.4, [random 3, random 3, false], date];
			};

		case "CLOUDY_3":
			{
				wcweather = [0, 0, 0.6, [random 4, random 4, false], date];
			};

		case "CLOUDY_4":
			{
				wcweather = [0, 0, 0.8, [random 5, random 5, false], date];
			};

		case "CLOUDY_5":
			{
				wcweather = [0, 0, 1.0, [random 5, random 5, false], date];
			};

		case "RAIN":
			{
				wcweather = [1, 0, 1.0, [random 5, random 5, false], date];
			};

		case "STORM":
			{
				wcweather = [1, 0, 1.0, [5 + (random 5), 5 + (random 5), false], date];
			};

		default
			{
				// clear
				wcweather = [0, 0, 0.0, [random 3, random 3, false], date];
				diag_log "Real weather: wrong starting weather";
			};
	};

	// add handler
	if (local player) then
	{
		wcweatherstart = true;
		"wcweather" addPublicVariableEventHandler
		{
			// first JIP synchronization
			if(wcweatherstart) then
			{
				wcweatherstart = false;
				skipTime -24;
				if (_canRain) then {86400 setRain (wcweather select 0)} else {86400 setRain 0};
				86400 setfog (wcweather select 1);
				86400 setOvercast (wcweather select 2);
				skipTime 24;
				simulweatherSync;
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			}else
			{
				wcweather = _this select 1;
				if (_canRain) then {60 setRain (wcweather select 0)} else {60 setRain 0};
				60 setfog (wcweather select 1);
				60 setOvercast (wcweather select 2);
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			};
		};
	};

	// SERVER SIDE SCRIPT
	if (!isServer) exitWith{};

	// apply weather
	skipTime -24;
	if (_canRain) then {86400 setRain (wcweather select 0)} else {86400 setRain 0};
	86400 setfog (wcweather select 1);
	86400 setOvercast (wcweather select 2);
	skipTime 24;
	simulweatherSync;
	setwind (wcweather select 3);
	setdate (wcweather select 4);

	// sync server & client weather & time
	[_realtime, _timesync, _daytimeratio, _nighttimeratio] spawn {
		private["_realtime", "_timesync", "_daytimeratio", "_nighttimeratio"];

		_realtime = _this select 0;
		_timesync = _this select 1;
		_daytimeratio = _this select 2;
		_nighttimeratio =  _this select 3;

		while { true } do {
			wcweather set [4, date];
			publicvariable "wcweather";
			if(!_realtime) then {
				if((date select 3 > 16) or (date select 3 <6)) then {
					//setTimeMultiplier _nighttimeratio;
					setTimeMultiplier timeMultiplier;
				} else {
					//setTimeMultiplier _daytimeratio;
					setTimeMultiplier timeMultiplier;
				};
			};
			sleep _timesync;
		};
	};

	_lastrain = 0;
	_rain = 0;
	_overcast = 0;
	_fog = 0;

	while {true} do
		{
			// setting random weather
			_overcast = (random (1 - _averageOvercast)) + (random _averageOvercast);

			// if weather is bad then starting rain
			if ((_overcast > 0.70) && (_canRain)) then {_rain = random 1} else {_rain = 0};

			// if day time is morning or if it was raining then starting fog
			if ((date select 3 > 4.5) and (date select 3 < 8))
			then
				{
					// morning
					if (random 1 > 0.80) then {_fog = random 0.20}; // 20% risk of low fog during morning (default climates)
					if ((OPEX_mapClimate == "tropical") && (random 1 > 0.50)) then {_fog = random 0.50}; // 50% risk of dense fog during morning (tropical climate)
					if ((OPEX_mapClimate == "polar") && (random 1 > 0.70)) then {_fog = random 0.20}; // 30% risk of low fog during morning (polar climate)
					if (OPEX_mapClimate == "arid") then {_fog = 0}; // 0% risk of fog during morning (arid climate)
				}
			else
				{
					// if weather is better after it has been raining a lot
					if ((_lastrain > 0.6) && (_rain < 0.2)) then
						{
							_fog = random 0.10; // (default climates)
							if ((OPEX_mapClimate == "tropical") && (random 1 > 0.5)) then {_fog = random 0.25}; // (tropical climate)
							if ((OPEX_mapClimate == "arid") && (random 1 > 0.85)) then {_fog = random 0.10}; // (arid climate)
						};
					// OPEX_mapClimate is polar and weather is bad
					if ((OPEX_mapClimate == "polar") && (_overcast > 0.50)) then {_fog = random 0.30} else {_fog = 0};
				};

			// setting wind
			_wind = [[random (_overcast * 10), random (_overcast * 10), false]];

			if (_canRain) then {_lastrain = _rain} else {_lastRain = 0};
			wcweather = [_rain, _fog, _overcast, _wind, date];
			if (_canRain) then {60 setRain (wcweather select 0)} else {60 setRain 0};
			60 setfog (wcweather select 1);
			60 setOvercast (wcweather select 2);
			setWind (wcweather select 3);
			if (_random) then {_timeforecast = _mintime + (random (_maxtime - _mintime))};
			sleep _timeforecast;
		};