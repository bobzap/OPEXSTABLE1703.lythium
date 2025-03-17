/*
	File: fn_filterList.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Refreshes the filtering list.
*/
private["_control","_curSel","_filter","_row"];
_curSel = _this select 1;
if(_curSel == -1) exitWith {};

_filter = lbData[38102,_curSel];

_control = ((findDisplay 38100) displayCtrl 38101);
if((lnbSize 38101) select 0 > -1) then
{
	lnbClear _control;
};

_vehicleList = [_filter] call VVS_fnc_filterType;
if(count _vehicleList == 0) exitWith {hint "There was an error and no vehicles could be fetched !"};
_row = 0;
{
	_cfgInfo = [_x] call VVS_fnc_cfgInfo;
	if(count _cfgInfo > 0) then
	{
		_sideName = switch ((_cfgInfo select 5)) do {case 0: {localize "STR_east"}; case 1: {localize "STR_west"}; case 2: {localize "STR_vvs_indep"}; case 3: {toUpper localize "STR_civilian"}; default {"UNKNOWN"}};
		_vehicleType = switch ((_cfgInfo select 4)) do
			{
				case "Car": {localize "STR_vvs_car"};
				case "Air" : {localize "STR_vvs_air"};
				case "Ship" : {localize "STR_vvs_ship"};
				case "Armored" : {localize "STR_vvs_armored"};
				case "Autonomous" : {localize "STR_vvs_autonomous"};
				case "Support" : {localize "STR_vvs_support"};
				case "Submarine" : {localize "STR_vvs_submarine"};
				default {_cfgInfo select 4}
			};
		_control lnbAddRow["",_cfgInfo select 3,_sideName, _vehicleType];
		_control lnbSetPicture[[_row,0],_cfgInfo select 2];
		_control lnbSetData[[_row,0],_x];
		_control lnbSetData[[_row,1],(_cfgInfo select 3)];
		_row = _row + 1;
	};
} foreach _vehicleList;