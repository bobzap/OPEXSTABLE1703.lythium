if (isServer || isDedicated) then
	{
		"playableUnitOccupier_PV" addPublicVariableEventHandler
			{
				private ["_playableUnit"];
				_playableUnit = [_this,1,objNull] call BIS_fnc_param;
				if (!isNull _playableUnit) then {missionNamespace setVariable [getPlayerUID _playableUnit,_playableUnit]};
			};

		[
			"deleteBodyOnPlayerDisccndId", "onPlayerDisconnected",
				{
				   private ["_body"];
				   _body = missionNamespace getVariable [_uid,objNull];
				   if (!isNull _body) then
					   {
							deleteVehicle _body;
							missionNamespace setVariable[_uid,nil];
					   };
				}
		] call BIS_fnc_addStackedEventHandler;
	};

if (!isDedicated) then
	{
		waitUntil {sleep 1; alive player};
		playableUnitOccupier_PV = player; publicVariableServer "playableUnitOccupier_PV";
		player addEventHandler ["Respawn", {playableUnitOccupier_PV = _this select 0; publicVariableServer "playableUnitOccupier_PV"}];
	};

if (!isServer || !isDedicated) exitWith {};
[
	"onPlayerDiscnndId", "onPlayerDisconnected",
		{
		   private ["_body","_weaponholders"];
		   _body = missionNamespace getVariable _uid;
		   if (!isNull _body) then
			   {
					_weaponholders = [];
					_weaponholders = nearestObjects [getPosATL _body, ["weaponHolderSimulated", "weaponHolder"], 20];
					{deleteVehicle _x}forEach _weaponholders;
					deleteVehicle _body;
					missionNamespace setVariable [_uid,nil];
			   };
		}
] call BIS_fnc_addStackedEventHandler;