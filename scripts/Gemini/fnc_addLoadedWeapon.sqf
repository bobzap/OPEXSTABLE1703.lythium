private _unit = param [0, objNull, [objNull]];
private _weapon = param [1, "", [""]];
private ["_muzzles", "_compatibleBullets", "_compatibleGrenades"];

if ((isNull _unit) || (_weapon == "")) exitWith {};

_muzzles = getArray (configFile >> "cfgWeapons" >> _weapon >> "muzzles");

if (count _muzzles > 0) then {_compatibleBullets = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines"); _unit addMagazine (_compatibleBullets select 0)};
if ((count _muzzles > 1) && (_muzzles select 1 != "securite")) then {_compatibleGrenades = getArray (configFile >> "cfgWeapons" >> _weapon >> _muzzles select 1 >> "magazines"); _unit addMagazine (_compatibleGrenades select 0)};

_unit addWeapon _weapon;