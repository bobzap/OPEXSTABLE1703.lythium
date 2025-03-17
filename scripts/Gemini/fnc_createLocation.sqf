params [["_logic", objNull], ["_locationType", ""], ["_radiusX", 10], ["_radiusY", 10]];

private ["_newLocation"];
_newLocation = createLocation [_locationType, position _logic, _radiusX, _radiusY];

_newLocation setText " ";