if (isDedicated) exitWith {};

waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
private ["_debug", "_unit"];

_debug = false;
_unit = player;

while {alive _unit} do

	{
		sleep 3;
		if
			(
				(
					(primaryWeapon _unit == "")
					&&
					(secondaryWeapon _unit == "")
					&&
					(currentWeapon _unit == "")
					&&
					(backpack _unit == "")
					&&
					((uniform _unit) in OPEX_civilian_uniforms)
					&&
					((headgear _unit == "") || ((headgear _unit) in OPEX_civilian_headgears))
					&&
					(hmd _unit == "")
					&&
					(speed _unit < 10)
					&&
					(stance _unit != "CROUCH")
					&&
					(stance _unit != "PRONE")
					&&
					(!((typeOf vehicle _unit) in OPEX_friendly_vehicles))
					&&
					(!((vehicle player) isKindOf "air"))
					&&
					({(side _x == OPEX_enemy_side1) && (_unit distance _x < 15)} count (allUnits - allPlayers) == 0)
					&&
					(count (attachedObjects _unit) == 0)
					//&&
					//(OPEX_enemy_side1 knowsAbout _unit < 3.9)
				)
			||
				(
					(vehicle _unit != _unit)
					&&
					(!((typeOf vehicle _unit) in OPEX_friendly_vehicles))
					&&
					({(side _x == OPEX_enemy_side1) && (_unit distance _x < 15)} count (allUnits - allPlayers) == 0)
					//&&
					//(OPEX_enemy_side1 knowsAbout _unit < 3.9)
				)
			)
		then
			{_unit setCaptive true; if (_debug) then {hint "INCOGNITO !!!"}} else {_unit setCaptive false; if (_debug) then {hint "NOT INCOGNITO !!!"}};
	};