if (!isServer) exitWith {};


private ["_fnc","_tr","_main","_side"];
_fnc = {
    {
        _tr = createTrigger [
            "EmptyDetector",
            _side modelToWorld _x
        ];
        _tr setVariable ["parent", _side];
        _tr setTriggerArea [5, 5, 0, false];
        _tr setTriggerActivation ["ANY", "PRESENT", true];
        _tr setTriggerStatements [
            "this",
            format [
                "
                    (thisTrigger getVariable 'parent')
                        animate ['Door_%1A_move', 1];
                    (thisTrigger getVariable 'parent')
                        animate ['Door_%1B_move', 1];
                ", _forEachIndex + 7
            ],
            format [
                "
                    (thisTrigger getVariable 'parent')
                        animate ['Door_%1A_move', 0];
                    (thisTrigger getVariable 'parent')
                        animate ['Door_%1B_move', 0];
                ", _forEachIndex + 7
            ]
        ];
        _side setVariable [format [
            "bis_disabled_Door_%1",
            _forEachIndex + 7
        ], 1, true];
    } forEach _this;
};
_main = createVehicle ["Land_Airport_center_F", [0,0,0], [], 0, "NONE"];
_main  setDir (_this select 0);
_main  setPosATL (_this select 1);
_side = createVehicle ["Land_Airport_left_F", [0,0,0], [], 0, "NONE"];
_side attachTo [_main, [19.6722,-4.61768,4.04246]];
detach _side;
[
    [-0.62,-15.16,-7],
    [-0.62,15.16,-7]
] call _fnc;
_side = createVehicle ["Land_Airport_right_F", [0,0,0], [], 0, "NONE"];
_side attachTo [_main, [-19.5177,-4.61768,4.04246]];
detach _side;
[
    [0.62,-15.16,-7],
    [0.62,15.16,-7]
] call _fnc;