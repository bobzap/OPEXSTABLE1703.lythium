/*********************************************
init.sqf

Initializes variables server and client.
Launch functions client side and server side.

Author : ~R3F~ Mapoule
team-r3f.org
*********************************************/
private ["_version"];

#include "config.sqf"

_version = [1,0];
//diag_log format ["---AI COM TARGET [v %1.%2]---",_version select 0,_version select 1];

sleep 1;

if ( ! isDedicated ) then
{
	call compile preprocessFile "scripts\R3F\AiComTarget\client.sqf";
	player addEventHandler [ "Fired", { call R3F_AIC_FNCT_client;}];
	R3F_AIC_save_time = time;
	R3F_AIC_player_array_eni = [];
};

if ( isServer ) then
{
	call compile preprocessFile "scripts\R3F\AiComTarget\server.sqf";
	"R3F_AIC_player_array_eni" addPublicVariableEventHandler { call R3F_AIC_FNCT_sever;};
	R3F_AIC_time_flare = time;
};