/**************************************
server.sqf
Functions server side

Author : ~R3F~ Mapoule
team-r3f.org
***************************************/

R3F_AIC_FNCT_ai_suppress_fire = { 
	private ["_unit","_cible","_random_result"];
	
	_unit = _this select 0;
	_cible = _this select 1;
	
	_random_result = floor ( random 100 );	
	if (( _random_result <= R3F_AIC_CFG_suppress_fire_probability ) && ( _unit distance _cible <= ( R3F_AIC_CFG_distance_min_suppress_fire + random ( R3F_AIC_CFG_distance_max_suppress_fire - R3F_AIC_CFG_distance_min_suppress_fire )))) then 
	{
		_unit suppressFor ( R3F_AIC_CFG_time_min_suppress_fire + random (R3F_AIC_CFG_time_max_suppress_fire - R3F_AIC_CFG_time_min_suppress_fire) );
	};
};

R3F_AIC_FNCT_ai_flares = {
	if (( sunOrMoon < 1 ) && ( time > R3F_AIC_time_flare + (( random 120 ) + 120 )) && ( floor ( random 100 ) <= 15 )) then
	{
		private ["_unit", "_cible", "_flare"];
		
		_unit = _this select 0;
		_cible = _this select 1;
		
		if ( _unit distance _cible < floor ( random 50 ) + 150 ) then
		{	
			R3F_AIC_time_flare = time;
			sleep ( random 15 ) + 10;
			_flare =  createvehicle ["F_20mm_Red", [ getPos _cible select 0, getPos _cible select 1, (getPos _cible select 2) + 190 ], [], 100, "NONE"]; 
			_flare setVelocity [0, 0, -10];
			waitUntil {sleep 1; ! alive _flare};
			deleteVehicle _flare;
		};
	};
};

R3F_AIC_FNCT_sever = {
	private ["_player_array_eni","_player","_array_eni_detected","_distance","_min_max_reveal"];

	_player_array_eni = _this select 1;
	_player = _player_array_eni  select 0;
	_array_eni_detected = _player_array_eni select 1;

	switch ( sunOrMoon ) do
	{
		case 1:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_day_min_max;
		};
		case 0:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_night_min_max;
		};		
		default 
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_transition_d_n_min_max;
		};
	};
	
	{
		if ( _x knowsAbout _player < R3F_AIC_CFG_knowsAbout_set_mini ) then 
		 {
			_distance = _x distance _player;
			if ( _x isKindOf "LandVehicle" ) then
			{
				_x reveal [ _player, 3.3 ];
				_x setCombatMode "RED";
				_x setBehaviour "COMBAT";
				_x allowFleeing 0;
				_x doTarget _player;
			} else {
				if ( _distance > 250 ) then
				{
					_x reveal [ _player, _min_max_reveal select 0 ];
				} else {
					_x reveal [ _player, _min_max_reveal select 1 ];
				};
			};
		 }; 
		[ _x, _player ] call R3F_AIC_FNCT_ai_suppress_fire; 
		[ _x, _player ] spawn R3F_AIC_FNCT_ai_flares; 
	} forEach _array_eni_detected;
};