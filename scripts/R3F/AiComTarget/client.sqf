/*************************************
client.sqf;
Function client side.

Author : ~R3F~ Mapoule
team-r3f.org
**************************************/

R3F_AIC_FNCT_has_silencer = {
	//Author : ~R3F~ Madbull
	private ["_unit", "_weapon", "_muzzle", "_has_silencer"];
	
	_unit = _this select 0;
	_weapon = _this select 1;
	_muzzle = _this select 2;
	
	_has_silencer = false;
	
	if (( _weapon != "" ) && ( _muzzle == _weapon )) then
	{
		switch ( _weapon ) do
		{
			case primaryWeapon _unit: {_has_silencer = ( primaryWeaponItems _unit select 0 != "" );};
			case secondaryWeapon _unit: {_has_silencer = ( secondaryWeaponItems _unit select 0 != "" );};
			case handgunWeapon _unit: {_has_silencer = ( handgunItems _unit select 0 != "" );};
			default {_has_silencer = false;};
		};
	};
	_has_silencer
};

R3F_AIC_FNCT_is_Silent_Muzzle = {
	private ["_weapon", "_muzzle","_is_Silent_Muzzle","_magazine","_muzzle_gl_array"];
	
	_weapon = _this select 0;
	_muzzle = _this select 1;
	_magazine = _this select 2;
	
	_muzzle_gl_array = ["GL_3GL_F","EGLM","Lance_Grenades"];
	_is_Silent_Muzzle = false;
	
	if (( _weapon == "Throw" ) && ( _muzzle != "HandGrenadeMuzzle" ) ) then
	{
		_is_Silent_Muzzle = true;
	};
	if (( _muzzle in _muzzle_gl_array ) && ( _magazine != "1Rnd_HE_Grenade_shell" )) then //
	{
			_is_Silent_Muzzle = true;
	};
	if ( _weapon == "Put" ) then 
	{
		_is_Silent_Muzzle = true;
	};
	_is_Silent_Muzzle
};


R3F_AIC_FNCT_client = {
	if ( time > R3F_AIC_save_time  + 30 ) then 
	{
		private ["_player_unit","_weapon","_muzzle","_magazine","_array_near_entities",
		"_enemy_side_array","_index","_has_silencer","_is_silent_muzzle","_array_eni_near"];
		R3F_AIC_save_time = time;
		
		_player_unit = _this select 0;
		_weapon = _this select 1;
		_muzzle = _this select 2;
		_magazine = _this select 5;
		
		_is_silent_muzzle = [ _weapon, _muzzle, _magazine ] call R3F_AIC_FNCT_is_Silent_Muzzle;
		
		if ( _is_silent_muzzle ) exitWith {R3F_AIC_save_time = time - 30;}; 
		
		_has_silencer = [ _player_unit, _weapon, _muzzle ] call R3F_AIC_FNCT_has_silencer;
		
		if ( _has_silencer ) then 
		{
			_array_near_entities = ( getPos player ) nearEntities [ "Land", 60 + random floor ((60 * 10) / 100)];
		} else {
			_array_near_entities = ( getPos player ) nearEntities [ "Land", 600 + random floor ((600 * 10) / 100)];
		};
		
		_enemy_side_array = player call BIS_fnc_enemySides;
		_array_eni_near = [];
		_index = 0;
		
		{
			if ( side _x in _enemy_side_array ) then
			{
				_array_eni_near set [ _index, _x ];
				_index = _index + 1;
			};
		} forEach _array_near_entities;
		
		if ( count _array_near_entities > 0 ) then
		{
			R3F_AIC_player_array_eni set [ 0,_player_unit ];
			R3F_AIC_player_array_eni set [ 1,_array_eni_near ];
			publicVariableServer "R3F_AIC_player_array_eni";
			R3F_AIC_player_array_eni = [];
			R3F_AIC_save_time = time;
		} else {
			R3F_AIC_save_time = time - 30;
		};	
	};
};