private ["_music", "_volume", "_selectedTrack"];

if (isDedicated) exitWith {};
if ((vehicle player) != player) exitWith {};

_music = _this select 0;
if (isMultiplayer) then {_volume = 0.05} else {_volume = 0.15};

if (_music == "punchy") then {_selectedTrack = ambianceMusic_punchy call BIS_fnc_selectRandom};
if (_music == "calm") then {_selectedTrack = ambianceMusic_calm call BIS_fnc_selectRandom};
if (_music == "stealth") then {_selectedTrack = ambianceMusic_stealth call BIS_fnc_selectRandom};
if (_music == "sad") then {_selectedTrack = ambianceMusic_sad call BIS_fnc_selectRandom};

playMusic _selectedTrack;
0 fadeMusic _volume;