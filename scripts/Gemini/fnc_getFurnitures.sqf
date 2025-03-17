/*
	to get all furnitures: go into a custom filled building and use:
	_this call Gemini_fnc_getFurnitures

	another usefull command: object call BIS_fnc_objectType;


*/

private ["_building", "_objects", "_list"];

_building = nearestBuilding player;
_objects = player nearObjects 15;

{
	_type = _x call BIS_fnc_objectType;
	if
		(
			(typeOf _x == typeOf _building)
			||
			(typeOf _x == "Land_LampShabby_F")
			||
			(typeOf _x == "Land_Slums02_4m")
		 	||
			(_type isEqualTo ["Soldier","Infantry"])
			||
			(_type isEqualTo ["Object","UnknownObject"])
			||
			(_type isEqualTo ["Object","Effect"])
			||
			(_type isEqualTo ["",""])
		)
	then {_objects = _objects - [_x]};
} forEach _objects;

_list = [];

{
	_list append
		[
			[
				typeOf _x,
				_building worldToModel (getPosATL _x),
				(getDir _building) - (getDir _x)
			]
		];
} forEach _objects;

copyToClipboard str _list;
hint format ["%1\n%2", typeOf _building, count _objects];