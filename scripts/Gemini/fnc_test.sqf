_video = "test.ogv";
_screen = "Land_TripodScreen_01_large_F" createVehicle (player modelToWorld [0,2.5,0]);
_screen setObjectTexture [0, _video];
_screen setDir (getDir _screen + 180);
[_video, [10,10], [1,1,1,1], "", [0,0,1,1], false] call BIS_fnc_playVideo;