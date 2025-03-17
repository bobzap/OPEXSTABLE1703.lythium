/*
	AUTHOR :
		Gemini (gemini.69@free.fr)

	DESCRIPTION :
		This script allows to find a random position according to several parameters.

	SYNTAX :
		<position> = [<type>, <center>, <minDistance>, <maxDistance>, <space>] call Gemini_fnc_findPos;

	PARAMETERS :
		<type>			(STRING or ARRAY of STRING)		the required position type
		<center>		(ARRAY or OBJECT)				the position or object we are starting the research
		<minDistance>	(NUMBER)						the minimum distance from center
		<maxDistance>	(NUMBER)						the maximim distance from center
		<space>			(NUMBER)						the minimum distance from any object

	RETURNED VALUE :
		A valid [X, Y, Z] position (or [0,0,0] if no valid position has been found)

	EXAMPLES :
		_position = ["land", player, 0, 250, 5] call Gemini_fnc_findPos; // any land position around player (inside a radius of 250 meters and at least 5 meters from any object)
		_position = ["overwatch", player, 100, 500] call Gemini_fnc_findPos; // any overwatch position around player (inside a radius of 500 meters and at least far from 100 meters)
		_position = [["city", "village"], player, 0, 1000] call Gemini_fnc_findPos; // any city or village around player (inside a radius of 1000 meters)
*/

// GETTING PARAMETERS
private _type = param [0, "land", ["", []]];
private _center = param [1, OPEX_mapCenter, [objNull, []]]; if (typeName _center isEqualTo "OBJECT") then {_center = position _center};
private _minDistance = param [2, OPEX_spawnDistanceMini, [0]];
private _maxDistance = param [3, OPEX_spawnDistanceMaxi, [0]];
private _space = param [4, 0, [0]];

// INITIALIZING MAIN VARIABLES
private _position = [0,0,0];
private _validPos = [0,0,0];
private _attempts = 0;
//private _maxAttempts = 3000;
private _maxAttempts = 500;

// DEFINING ANNEXE FUNCTION
private _getLocationPosition =
	{
		private _type = _this select 0;
		private _center = _this select 1;
		private _minDistance = _this select 2;
		private _maxDistance = _this select 3;
		if (!(typeName _type isEqualTo "ARRAY")) exitWith {};
		private _locations = [];
		if ("city" in _type) then {private _cities = OPEX_locations_cities select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; _locations append _cities};
		if ("village" in _type) then {private _villages = OPEX_locations_villages select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; _locations append _villages};
		if ("industry" in _type) then {private _industries = OPEX_locations_industrial select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; _locations append _industries};
		if ("military" in _type) then {private _militaries = OPEX_locations_military select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; _locations append _militaries};
		if ("isolated" in _type) then {private _isolated = OPEX_locations_isolated select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; _locations append _isolated};
		//_locations = _locations select {count (_x nearEntities ["Man", 100]) == 0};
		if (count _locations == 0) exitWith {[0,0,0]};
		private _location = position (selectRandom _locations);
		_location
	};

// DEFINING MAIN FUNCTION
private _getPosition =
	{
		// GETTING PARAMETERS
		private _type = _this select 0 select 0;
		private _center = _this select 0 select 1;
		private _minDistance = _this select 0 select 2;
		private _maxDistance = _this select 0 select 3;
		private _space = _this select 0 select 4;
		private _position = _this select 1 select 0;
		private _validPos = _this select 1 select 1;

		// GETTING A RANDOM POSITION
		switch _type do
			{
				case "any"						:	{_position = _center getPos [_minDistance + (random _maxDistance), random 360]};
				case "land"						:	{_position = _center getPos [_minDistance + (random _maxDistance), random 360]};
				case "land_isolated"			:	{_position = _center getPos [_minDistance + (random _maxDistance), random 360]};
				case "land_noRoad"				:	{_position = _center getPos [_minDistance + (random _maxDistance), random 360]};
				case "road"						:	{private _roads = (_center nearRoads _maxDistance) select {_center distance2D _x > _minDistance}; if (count _roads > 0) then {_position = position (selectRandom _roads)}};
				case "building"					:	{private _buildings = ([_center, _maxDistance] call Gemini_fnc_findBuildings) select {_center distance2D _x > _minDistance}; if (count _buildings > 0) then {_position = position (selectRandom _buildings)}};
				case "city"						:	{private _locations = OPEX_locations_cities select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; if (count _locations > 0) then {_position = position (selectRandom _locations)}};
				case "village"					:	{private _locations = OPEX_locations_villages select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; if (count _locations > 0) then {_position = position (selectRandom _locations)}};
				case "industry"					:	{private _locations = OPEX_locations_industrial select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; if (count _locations > 0) then {_position = position (selectRandom _locations)}};
				case "military"					:	{private _locations = OPEX_locations_military select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; if (count _locations > 0) then {_position = position (selectRandom _locations)}};
				case "isolated"					:	{private _locations = OPEX_locations_isolated select {(_center distance2D _x > _minDistance) && (_center distance2D _x < _maxDistance)}; if (count _locations > 0) then {_position = position (selectRandom _locations)}};
				case "overwatch"				:	{_position = [_center, _maxDistance, _minDistance, 25] call BIS_fnc_findOverwatch; if (count _position == 2) then {_position pushBack 0}};
				case "forest"					:	{_position = (selectBestPlaces [_center, _maxDistance, "(1 + forest + trees) * (1 - sea) * (1 - houses)", _maxDistance / 10, 1]) select 0 select 0; _position pushBack 0};
				case "hill"						:	{_position = (selectBestPlaces [_center, _maxDistance, "(1 + hills) * (1 - sea)", _maxDistance / 10, 1]) select 0 select 0; _position pushBack 0};
				case "water"					:	{_position = _center getPos [_minDistance + (random _maxDistance), random 360]; _position = [_position select 0, _position select 1, 0]};
				default								{_position = [_type, _center, _minDistance, _maxDistance] call _getLocationPosition};
			};
		if (isNil "_position") then {_position = [0,0,0]};

		// DEFINING POSSIBLE CONDITIONS
		private _isNotInRestrictedArea = (!([_position, OPEX_locations_safe] call BIS_fnc_isPosBlacklisted));
		private _isDistantAsRequired = (_position distance2D _center >= _minDistance) && (_position distance2D _center <= _maxDistance);
		private _isEmptyPos = [_position, _space] call Gemini_fnc_isEmptyPos;
		private _isFlatEnough = !((_position isFlatEmpty [-1, -1, 0.2, 1 max _space * 0.1, -1]) isEqualTo []);
		private _isGround = (!surfaceIsWater _position) && (_position select 2 < 1);
		private _isWater = surfaceIsWater _position;
		private _isOnRoad = (isOnRoad ASLToAGL _position) && ((_position select 2) < 0.1);
		private _isFarRoad = ((_position nearRoads 100) isEqualTo []);
		private _isNearRoad = !((_position nearRoads 25) isEqualTo []);
		private _isFarBuilding = ((nearestTerrainObjects [_position, ["House","Building"], 100]) isEqualTo []);
		private _isNearBuilding = !((nearestTerrainObjects [_position, ["House","Building"], 50]) isEqualTo []);
		private _isInsideBuilding = _position call Gemini_fnc_isInsideBuilding;
		private	_isPlayerNearby = [_position, OPEX_spawnDistanceMini] call Gemini_fnc_isPlayerNearby;
		private _isHighEnough = ((AGLToASL _position) select 2) + 25 > (AGLToASL _center) select 2;

		// COMPILING CONDITIONS ACCORDING TO REQUESTED TYPE
		private _conditions = false;
		switch _type do
			{
				case "any"						:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "land"						:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isEmptyPos && _isFlatEnough && _isGround && !_isInsideBuilding};
				case "land_isolated"			:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isEmptyPos && _isFlatEnough && _isGround && !_isInsideBuilding && _isFarRoad && !_isNearBuilding};
				case "land_noRoad"				:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isEmptyPos && _isFlatEnough && _isGround && !_isInsideBuilding && !_isNearRoad};
				case "road"						:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isEmptyPos && !_isInsideBuilding};
				case "building"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "city"						:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "village"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "industry"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "military"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "isolated"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "city+village+isolated"	:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
				case "overwatch"				:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isFarRoad && _isHighEnough};
				case "forest"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isFarBuilding && _isFarRoad && _isFlatEnough};
				case "hill"						:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isFarRoad};
				case "water"					:	{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby && _isEmptyPos && _isWater};
				default								{_conditions = _isNotInRestrictedArea && _isDistantAsRequired && !_isPlayerNearby};
			};

		// CHECKING POSITION ACCORDING TO REQUESTED TYPE
		if (_conditions) then {_validPos = _position} else {_validPos = [0,0,0]};

		//DEBUGGING
		/*
		private _debug = OPEX_debug;
		if (_debug) then
			{
				private _marker = [[0,0,0], "mil_box", "colorWhite"] call Gemini_fnc_createMarker;
				if (_validPos isEqualTo [0,0,0]) then {_marker setMarkerColor "ColorKhaki"} else {_marker setMarkerColor "ColorGreen"; _marker setMarkerPos _validPos};
			};
		*/

		// RETURNING POSITION
		_validPos
	};

while {(_validPos isEqualTo [0,0,0]) && (_attempts < _maxAttempts)} do
	{
		// GRADUALLY INCREASING RADIUS IN CASE NO VALID POS HAS BEEN FOUND
		_attempts = _attempts + 1;
		_validPos = [[_type, _center, _minDistance, _maxDistance, _space], [_position, _validPos]] call _getPosition;
	};

// DEBUGGING
private _debug = false;
if (_debug) then
	{
		systemChat format ["%1 | %2 attempt(s)", _validPos, _attempts];
	};

// RETURNING FOUND POSITION
_validPos