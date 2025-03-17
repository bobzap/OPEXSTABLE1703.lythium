/*
	thanks to BEAKSBY
	https://forums.bohemia.net/forums/topic/157732-finding-a-vehicle-ammo-value-from-0-1/?do=findComment&comment=2664114
*/

private _vehicle = _this;

_magCount = 0;
_mags = [];
_totalCurAmmo = 0;
_VehAmmoArray = [];
_getVehicleAmmoDef = 0;


_maxAmmoArray = [];
_VehAmmoArray = [];
_defAmmoCount = 0;

_VehAmmoArray =  getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Turrets" >> "MainTurret" >> "magazines");
_defAmmoCount = getNumber (configFile >> "CfgMagazines" >> ((magazines _vehicle) select 0) >> "count");

_defTotalAmmo = 0;
{_defTotalAmmo = _defTotalAmmo + (getNumber (configFile >> "CfgMagazines" >> _x >> "count"))} forEach _VehAmmoArray;

if (typeOf _vehicle ==  "B_G_Offroad_01_armed_F") then {_defTotalAmmo = 400};  // cheat as it's not defined in CfgVehicles // need to update this for O_G_Offroad_01_armed_F

_magCount = count (magazines (_vehicle));
_totalCurAmmo = 0;
{_totalCurAmmo = _totalCurAmmo + (_x select 1)} forEach (magazinesAmmo _vehicle);

private _getVehicleAmmoDef = 0;
if (_defTotalAmmo != 0) then {_getVehicleAmmoDef = (_totalCurAmmo/_defTotalAmmo)} else {_getVehicleAmmoDef = 0};

_getVehicleAmmoDef