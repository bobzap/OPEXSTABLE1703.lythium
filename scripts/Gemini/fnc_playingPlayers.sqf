if (!isServer) exitWith {};

private _add = 
	{
		for "_i" from 0 to (count OPEX_locations_safe) do {{if ((!((position _x) inArea (OPEX_locations_safe select _i))) && (!(_x in OPEX_playingPlayers))) then {OPEX_playingPlayers append [_x]}} forEach _this};
	};

private _remove = 
	{
		if (count OPEX_playingPlayers == 0) exitWith {}; 
		for "_i" from 0 to (count OPEX_locations_safe) do {{if (((position _x) inArea (OPEX_locations_safe select _i)) && (_x in OPEX_playingPlayers)) then {OPEX_playingPlayers = OPEX_playingPlayers - [_x]}} forEach _this};
	};

private _update =
	{
		private _allPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
		if (count _allPlayers > 0)
		then
			{
				// ADDING PLAYERS TO PLAYING PLAYERS IF THEY ARE OUTSIDE A SAFE LOCATION AND IF THEY ARE NOT IN PLAYING LIST ALREADY
				_allPlayers call (_this select 0);
				// REMOVING PLAYERS FROM PLAYING PLAYERS IF THEY ARE INSIDE A SAFE LOCATION AND IF THEY ARE IN PLAYING LIST
				_allPlayers call (_this select 1);
			}
		else {OPEX_playingPlayers = []};
		publicVariable "OPEX_playingPlayers";
	};

while {true} do
	{
		sleep 5; // updating list every 5 seconds
		[_add, _remove] call _update;
	};