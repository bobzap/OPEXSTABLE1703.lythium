// ORIGINAL CODE BY CARLGUSTAFFA  *** INSPIRED BY TPW CORE

private ["_lat","_day","_hour"];
while {true} do
	{
		_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
		_day = 360 * (dateToNumber date);
		_hour = (daytime / 24) * 360;
		OPEX_sunHeight = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));
		sleep 33.33;
	};