/*
	File: fn_spawnVehicle.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Spawns the selected vehicle, if a vehicle is already on the spawn point
	then it deletes the vehicle from the spawn point.
*/
disableSerialization;
private["_position","_direction","_className","_displayName","_spCheck","_cfgInfo"];
if(lnbCurSelRow 38101 == -1) exitWith {hint localize "STR_vvs_noVehicleSelected"};

_className = lnbData[38101,[(lnbCurSelRow 38101),0]];
_displayName = lnbData[38101,[(lnbCurSelRow 38101),1]];
//_position = getMarkerPos VVS_SP;
_position = getPos OPEX_deliveryZone;
//_direction = markerDir VVS_SP;
_direction = 0;

//Make sure the marker exists in a way.
if(isNil "_position") exitWith {hint "The spawn point marker doesn't exist !!!";};

//Check to make sure the spawn point doesn't have a vehicle on it, if it does then delete it.
_spCheck = nearestObjects[_position,["landVehicle","Air","Ship"],12] select 0;
if(!isNil "_spCheck") exitWith {hint localize "STR_hint_DeliveryZoneEncumbered"};

_cfgInfo = [_className] call VVS_fnc_cfgInfo;

//_vehicle = _className createVehicle _position;
//_vehicle = [_className, _position, 0, true, "distance", false] call Gemini_fnc_createVehicle;
[_className, _position, 0, true, "distance", false] remoteExec ["Gemini_fnc_createVehicle", 2];
//_vehicle allowDamage false;
//_vehicle setPos _position; //Make sure it gets set onto the position.
//_vehicle setDir _direction; //Set the vehicles direction the same as the marker.

/*
if((_cfgInfo select 4) == "Autonomous") then
{
	createVehicleCrew _vehicle;
};
*/

VVS_Checkbox = true;

/*
if(VVS_Checkbox) then
{
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
};
*/

//_vehicle allowDamage true;
closeDialog 0;
_displayName spawn {sleep 1; hint format [localize "STR_vvs_vehicleSpawned",_this]};